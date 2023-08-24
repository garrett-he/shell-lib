Include lib/os.sh

Describe 'module file'
    Include lib/file.sh
    BeforeEach 'cp spec/resources/test-file /tmp/test-file'
    AfterEach 'rm /tmp/test-file'

    Describe 'function sed'
        It 'should run sed on file.'
            When call file::sed 's/voluptate/voluptate_test/g' /tmp/test-file
            The contents of file '/tmp/test-file' should include 'voluptate_test'
        End
    End

    Describe 'function replace_text'
        It 'should replace text in file.'
            When call file::replace_text /tmp/test-file voluptate voluptate_test
            The contents of file '/tmp/test-file' should include 'voluptate_test'
        End
    End

    Describe 'function delete_line'
        It 'should delete line with text in file.'
            When call file::delete_line /tmp/test-file voluptate
            The contents of file '/tmp/test-file' should not include 'voluptate'
        End
    End

    Describe 'function backup'
        It 'should backup the given file.'
            When call file::backup /tmp/test-file
            The path /tmp/test-file~ should be exist
        End
    End
End
