Describe 'module os'
    Include lib/os.sh

    Describe 'function ostype'
        It 'should return "linux" on Linux systems.'
            OSTYPE='linux-gnu'
            When call os::type
            The stdout should eq 'linux'
        End
        It 'should return "darwin" on macOS systems.'
            OSTYPE='darwin22.0'
            When call os::type
            The stdout should eq 'darwin'
        End
        It 'should return "cygwin" on Cygwin systems.'
            OSTYPE='cygwin'
            When call os::type
            The stdout should eq 'cygwin'
        End
        It 'should return "msys" on MSYS2 systems.'
            OSTYPE='msys'
            When call os::type
            The stdout should eq 'msys'
        End
    End
End
