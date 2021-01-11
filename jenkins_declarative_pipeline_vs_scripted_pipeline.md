# JENKINS DECLARATIVE PIPELINE VS SCRIPTED PIPELINE

Declarative Pipeline Sample

    pipeline {
        agent any

        stages {
            stage("Build") {
                steps {
                    echo "Some code compilation here..."
                }
            }

            stage("Test") {
                steps {
                    echo "Some tests execution here..."
                    echo 1
                }
            }
        }
    }

Scripted Pipeline Example

    node {
        stage("Build") {
            echo "Some code compilation here..."
        }

        stage("Test") {
            echo "Some tests execution here..."
            echo 1
        }
    }

Comparison: 
### 1: Declarative Pipeline will fail if there is an error in any stage in the whole script whereas Scripted Pipeline will fail only for the particular stage that is erroneous. 
### 2: Declarative Pipeline allows to "Restart from stage" whereas Scripted Pipeline does not. 
### 3: Declarative pipeline options block: This feature is supported by both pipeline types, however the declarative pipeline handles it a bit better. In the declarative pipeline, options are separated from the pipeline script logic. The scripted pipeline also supports timestamps, ansiColor and timeout options, but it requires a different code.
### 4: The "when block" that the declarative pipeline supports. Can be used as a conditional filter to a stage. To acheive same thing in a scripted pipeline we have to use if-else statements.  

DECLARATIVE PIPELINE WHEN BLOCK EXAMPLE

Below Pipeline will execute Test stage only if env.FOO equals bar.

    pipeline {
        agent any

        options {
            timestamps()
            ansiColor("xterm")
        }

        stages {
            stage("Build") {
                options {
                    timeout(time: 1, unit: "MINUTES")
                }
                steps {
                    sh 'printf "\\e[31mSome code compilation here...\\e[0m\\n"'
                }
            }

            stage("Test") {
                when {
                    environment name: "FOO", value: "bar"
                }
                options {
                    timeout(time: 2, unit: "MINUTES")
                }
                steps {
                    sh 'printf "\\e[31mSome tests execution here...\\e[0m\\n"'
                }
            }
        }
    }



SCRIPTED PIPELINE IF-ELSE FILTER EXAMPLE

    node {
        timestamps {
            ansiColor("xterm") {
                stage("Build") {
                    timeout(time: 1, unit: "MINUTES") {
                        sh 'printf "\\e[31mSome code compilation here...\\e[0m\\n"'
                    }
                }
                if (env.FOO == "bar") {
                    stage("Test") {
                        timeout(time: 2, unit: "MINUTES") {
                            sh 'printf "\\e[31mSome tests execution here...\\e[0m\\n"'
                        }
                    }
                }
            }
        }
    }
