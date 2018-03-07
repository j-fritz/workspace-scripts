#!/bin/bash
TEMPDIR=~/tmp
REMOTE=c.jfritz@test-handler-01.ucs.baengr.gogoair.com
ssh $REMOTE "rm -f /home/c.jfritz/scs-workspace/gate-src/docker-images/logs/*.png"
ssh $REMOTE "cd /home/c.jfritz/scs-workspace/gate-src/docker-images && git fetch upstream && git checkout upstream/WebdriverFullpageScreenshot_testing && make setup-gate-test"
ssh $REMOTE "docker exec -t gate-test-c.jfritz py.test -vs ../src/tests/unit/TestWebdriverLocalJfritz.py"
ssh $REMOTE "docker exec -t gate-test-c.jfritz py.test -vs ../src/tests/unit/TestVerifyScreenshots.py"
cd $TEMPDIR
rm -f *.png 
scp $REMOTE:scs-workspace/gate-src/docker-images/logs/*webdriver_testing*.png ./ 
scp $REMOTE:scs-workspace/gate-src/docker-images/logs/*browser*.png ./ 
ssh $REMOTE "cd /home/c.jfritz/scs-workspace/gate-src/docker-images && make clean-gate-test"
# This views the latest png file
# $(ls -t *.png | head -1)
cd -
gpicview $TEMPDIR/*webdriver_testing*.png $TEMPDIR/*browser*.png
