Describe 'module utils'
    Include lib/utils.sh

    Describe 'function shell_name'
        It 'should return name of current shell.'
            When call utils::shell_name
            The stdout should eq $(basename $(readlink /proc/$$/exe))
        End
    End

    Describe 'function fn_defined'
        It 'should be failure if function not defined.'
            When call utils::fn_defined __test__
            The status should be failure
        End

        It 'should be success if function defined.'
            __test__() {
                :
            }
            When call utils::fn_defined __test__
            The status should be success
        End
    End

    Describe 'function is_true'
        It 'should be failure if variable is n.'
            __test__='n'
            When call utils::is_true $__test__
            The status should be failure
        End

        It 'should be success if variable equals 1.'
            __test__='1'
            When call utils::is_true $__test__
            The status should be success
        End

        It 'should be success if variable equals y.'
            __test__='y'
            When call utils::is_true $__test__
            The status should be success
        End

        It 'should be success if variable equals Y.'
            __test__='Y'
            When call utils::is_true $__test__
            The status should be success
        End
    End

    Describe 'function utils::read'
        It 'should set specified variables from input.'
            Data
                #|test input
                #|
            End
            When call utils::read 'Input test' test_var
            The variable test_var should eq 'test input'
        End


        It 'should set default value to variables if input none.'
            Data
                #|
            End

            When call utils::read 'Input test' test_var default_value
            The variable test_var should eq 'default_value'
        End
    End

    Describe 'function utils::confirm'
        It 'should be success if input "y".'
            Data
                #|y
            End

            When call utils::confirm 'Confirm test'
            The status should be success
        End

        It 'should be failure if input "n".'
            Data
                #|n
            End

            When call utils::confirm 'Confirm test'
            The status should be failure
        End
    End
End
