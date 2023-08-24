Describe 'module logging'
    Include lib/logging.sh

    Describe 'function logging::echo'
        It 'should print messages to stdout without color by default.'
            When call logging::echo 'Test message'
            The stdout should eq 'Test message'
            The stderr should be blank
        End

        It 'should print messages without colors if not in tty.'
            When call logging::echo 'Test message' '1;32m'
            The stdout should eq 'Test message'
            The stderr should be blank
        End

        It 'should print messages to stderr if FD specified.'
            When call logging::echo 'Test message' '' 2
            The stderr should eq 'Test message'
            The stdout should be blank
        End
    End

    Describe 'function logging::error'
        It 'should print messages to stderr with identifier.'
            When call logging::error 'Test message'
            The stderr should eq '[error] Test message'
            The stdout should be blank
        End
    End

    Describe 'function logging::warning'
        It 'should print messages to stdout with identifier.'
            When call logging::warning 'Test message'
            The stdout should eq '[warning] Test message'
            The stderr should be blank
        End
    End

    Describe 'function logging::info'
        It 'should print messages to stdout with identifier.'
            When call logging::info 'Test message'
            The stdout should eq '[info] Test message'
            The stderr should be blank
        End
    End

    Describe 'function logging::debug'
        It 'should print messages to stdout if debug flag is assigned.'
            # shellcheck disable=SC2034
            DEBUG=1
            When call logging::debug 'Test message'
            The stdout should eq '[debug] Test message'
            The stderr should be blank
        End

        It 'should not print messages to stdout if debug flag is not assigned.'
            When call logging::debug 'Test message'
            The stderr should be blank
            The stdout should be blank
        End
    End
End
