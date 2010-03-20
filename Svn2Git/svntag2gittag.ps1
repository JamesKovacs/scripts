# Converts SVN remote tags to Git tags
# Modified version of Frank S. Thomas' Bash script
# http://frank.thomas-alfeld.de/wp/2008/08/30/converting-git-svn-tag-branches-to-real-tags/

foreach($branch in (git branch -r)) {
  $branch = $branch.Trim()
  if($branch.StartsWith('tags/')) {
    $name=$branch.Split('/')[1]
    $subject=(git log -1 --pretty=format:"%s" $branch)
    $commitDate=(git log -1 --pretty=format:"%ci" $branch)

    "Creating tag $name..."
    git tag -s -f -m "$subject" "$name" "$branch^"
    git branch -d -r $branch
  }
}