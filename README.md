Sencha Cmd image
================

A basic docker image with preinstalled Sencha Cmd, nodejs and OpenJDK 8.

The images are tagged with the Sencha Cmd version.

Everything except the Sencha Cmd is installed via apt (and thus
available in the standard `$PATH`). Sencha Cmd is installed in
`/usr/local/Sencha/Cmd/$SENCHA_CMD_VERSION` and the executable is linked to `/usr/local/bin/sencha`.


Jenkins Pipeline example
------------------------

```
pipeline  {
    agent {
        docker {
            image 'danielbraga/sencha-cmd:6.7.0.63'
        }
    }
    stages {
        stage('Build') {
            stages {
                stage('Build: Testing') {
                    when {
                        not {
                            branch 'master'
                        }
                    }

                    steps {
                        sh "sencha app build desktop testing"
                    }
                }

                stage('Build: Production') {
                    when {
                        branch 'master'
                    }
                    steps {
                        sh "sencha app build desktop production"
                    }
                }
            }
        }

        stage('Deploy') {
            stages {
                stage('Deploy: Testing') {
                    when {
                        branch 'develop'
                    }
                    steps {
                        sshPublisher(
                            publishers: [
                                sshPublisherDesc(
                                    configName: 'Testing Server',
                                    transfers: [
                                        sshTransfer(
                                            cleanRemote: false,
                                            excludes: '',
                                            execCommand: '',
                                            execTimeout: 120000,
                                            flatten: false,
                                            makeEmptyDirs: false,
                                            noDefaultExcludes: false,
                                            patternSeparator: '[, ]+',
                                            remoteDirectory: '',
                                            remoteDirectorySDF: false,
                                            removePrefix: 'build/testing/MyApp',
                                            sourceFiles: 'build/testing/MyApp/**'
                                        )
                                    ],
                                    usePromotionTimestamp: false,
                                    useWorkspaceInPromotion: false,
                                    verbose: false
                                )
                            ]
                        )
                    }
                }
                stage('Deploy: Production') {
                    when {
                        branch 'master'
                    }
                    steps {
                        sshPublisher(
                            publishers: [
                                sshPublisherDesc(
                                    configName: 'Production Server',
                                    transfers: [
                                        sshTransfer(
                                            cleanRemote: false,
                                            excludes: '',
                                            execCommand: '',
                                            execTimeout: 120000,
                                            flatten: false,
                                            makeEmptyDirs: false,
                                            noDefaultExcludes: false,
                                            patternSeparator: '[, ]+',
                                            remoteDirectory: '',
                                            remoteDirectorySDF: false,
                                            removePrefix: 'build/production/MyApp',
                                            sourceFiles: 'build/production/MyApp/**'
                                        )
                                    ],
                                    usePromotionTimestamp: false,
                                    useWorkspaceInPromotion: false,
                                    verbose: false
                                )
                            ]
                        )
                    }
                }
            }
        }
    }
}
```