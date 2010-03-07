# wixvars.ps1
# Copyright © 2009 by James Kovacs (JamesKovacs.com)
# All rights reserved.
# THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
# ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE IMPLIED WARRANTIES OF MERCHANTIBILITY AND/OR FITNESS FOR A
# PARTICULAR PURPOSE.

$base = 'c:\Program Files'

if (test-path HKLM:SOFTWARE\Wow6432Node) {
  $base += ' (x86)'
}

$env:PATH = "$env:PATH;$base\Windows Installer XML v3\bin\;"