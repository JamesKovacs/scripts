mkdir psake_tmp
cd psake_tmp
git svn init http://psake.googlecode.com/svn/ --stdlayout --no-metadata
git config svn.authorsfile C:\Users\James\Desktop\authors.txt
git svn fetch
cd ..
git clone psake_tmp psake