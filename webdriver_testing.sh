#!/bin/bash
ssh c.jfritz@test-handler-05.ucs.baengr.gogoair.com "cd /home/c.jfritz/scs-workspace/gate-src/docker-images && git fetch upstream && git checkout upstream/WebdriverFullpageScreenshot_testing && make setup-gate-test"
ssh c.jfritz@test-handler-05.ucs.baengr.gogoair.com "docker exec -t gate-test-c.jfritz py.test -vs ../src/tests/unit/TestWebdriverLocalJfritz.py"
cd ~/tmp
rm -f *.png 
scp c.jfritz@test-handler-05.ucs.baengr.gogoair.com:scs-workspace/gate-src/docker-images/logs/*webdriver_testing.png ./ 
# view the latest png file
gpicview $(ls -t *webdriver_testing.png | head -1)
cd -
