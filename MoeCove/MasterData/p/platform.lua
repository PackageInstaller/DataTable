
local platform = {}

platform.passport = "OfficialPassport"

--if Application.platform == UnityEngine.RuntimePlatform.WindowsEditor then
--elseif Application.platform == UnityEngine.RuntimePlatform.IPhonePlayer then
--elseif Application.platform == UnityEngine.RuntimePlatform.Android then
--end

-- local ip = "42.192.41.199"--外网测试服
-- local ip = "192.168.1.212"
local ip = "1.117.220.45"
local pList = {32010, 32020}
local pindex = math.random(1, 2)
local lList = {33010, 33020}
local lindex = math.random(1, 2)

platform.passporturl = string.format("http://%s:%d", ip, pList[pindex])
platform.loginip = ip
platform.loginport = lList[lindex]
platform.datalogip = string.format("http://%s:%d", ip, 20055)


return platform