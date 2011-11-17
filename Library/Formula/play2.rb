require 'formula'

class Play2 < Formula
  url 'http://download.playframework.org/releases/play-2.0-beta.zip'
  homepage 'http://www.playframework.org/'
  md5 'faf4bcf4ba5c889ab8a2da44d2da350f'

  def patches
    # Fix play script to allow symlinks
    DATA
  end

  def install
    rm_rf 'python' # we don't need the bundled Python for windows
    rm Dir['*.bat']
    libexec.install Dir['*']
    bin.mkpath
    ln_s libexec+'play', bin+'play2'
  end
end

__END__
diff --git a/play b/play
index d4825e3..458f837 100755
--- a/play
+++ b/play
@@ -1,14 +1,16 @@
 #! /usr/bin/env sh
 
+PLAY_HOME=/usr/local/Cellar/play2/2.0-beta/libexec
+
 if [ -f conf/application.conf ]; then
   if test "$1" = "clean"; then
-    `dirname $0`/framework/cleanIvyCache
+    $PLAY_HOME/framework/cleanIvyCache
   fi
   if [ -n "$1" ]; then
-    `dirname $0`/framework/build "$@"
+    $PLAY_HOME/framework/build "$@"
   else
-    `dirname $0`/framework/build play
+    $PLAY_HOME/framework/build play
   fi
 else
-  java -Dsbt.ivy.home=`dirname $0`/repository -Dplay.home=`dirname $0`/framework -Dsbt.boot.properties=`dirname $0`/framework/sbt/play.boot.properties -jar `dirname $0`/framework/sbt/sbt-launch-0.11.0.jar "$@"
-fi
\ No newline at end of file
+  java -Dsbt.ivy.home=$PLAY_HOME/repository -Dplay.home=$PLAY_HOME/framework -Dsbt.boot.properties=$PLAY_HOME/framework/sbt/play.boot.properties -jar $PLAY_HOME/framework/sbt/sbt-launch-0.11.0.jar "$@"
+fi

