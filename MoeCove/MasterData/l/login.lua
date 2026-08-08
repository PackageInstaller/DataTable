--对应于login.proto协议文件的客户端模拟处理类
--在common中有一个user.lua，同样是用来对应user.proto的客户端模拟代码实现

local SimLogin = {}

local loginProtoDealers = {
	["ChallengeReq"] = { name = "login.ChallengeResp", data = { challenge = crypt.randomkey() } },
	["KeyReq"] = { name = "login.KeyResp", data = { ret = 0, key = crypt.dhexchange(crypt.randomkey())} },
	["VerifySecretReq"] = { name = "login.VerifySecretResp", data = { ret = 0 } },
	["LoginAuthReq"] = { name = "login.LoginAuthResp", data = { ret = 0 } },
	["ZoneListReq"] = { name = "login.ZoneListResp", data = { zones = { {id = 1, name = "SimServer"} } } },
	["LoginZoneReq"] = { name = "login.LoginZoneResp", data = { ret = 0, aid = 9999999, subid = 0, ip = "127.0.0.11", port = 0 } },
}

for k,v in pairs(loginProtoDealers) do
	SimLogin[k] = function ()
		if k == "LoginZoneReq" then
			SrvSim:auth(v.data.aid)
		end
		
		return pb_encode(v.name, v.data)
	end
end

return SimLogin