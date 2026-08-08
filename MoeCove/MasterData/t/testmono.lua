
local TestMono = class("TestMono", LuaMonoBehavior)

TestMono.dd = 5

local NetManager = require "NetManager"
local LoginNetHandler
local GameNetHandler

--TestMono = {}
Util = LuaFramework.Util
function TestMono:Start()

--    if true then
--        return 
--    end

    NetManager.OpenPb("base.pb")
    NetManager.OpenPb("login.pb")

    LoginNetHandler = NetManager:new("LoginNetHandler")
    GameNetHandler = NetManager:new("GameNetHandler")


    local ddd = getmetatable(GameNetHandler)
    
--    print("ddd", ddd, ddd.__index(GameNetHandler, "ProtoHandle"))
--    for key, var in pairs(ddd) do
--        print("ddd", key ,var)
--    end
    
    
    LoginNetHandler:Start()

    --local NetHandler = self.gameObject:GetComponent("DragonFist.NetHandler")
	local dd = LoginNetHandler:Connect("192.168.1.91", 14000, function (success)
        Debugger.Log("connect {0}", success)
    end)
    
    --local bb = LuaFileUtils.Instance:ReadFile("login.pb")

    local quickLogin = { mobile_sn_code = "1111", password = "" }
--    local buf = protobuf.encode("SProtoSpace.login_req", quickLogin)
--    LoginNetHandler:QueueSend(7001, buf)

    LoginNetHandler:SendWaitMessage("login_req", quickLogin, "game_server_list", function (data)
        print("-------------------")
        print(DLuaUtil.SerialiseProto(data))
    end)
    --print(bb.buffer);
end


function TestMono:Update()
    LoginNetHandler:Update()
    GameNetHandler:Update()
	--print(self.dd .. "GG")
end

function TestMono:OnDestroy()
    LoginNetHandler:OnDestroy()
    GameNetHandler:OnDestroy()
end

return TestMono