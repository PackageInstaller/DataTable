---挑战进度数据

local ChallengeComponent = BaseClass("ChallengeComponent",Component);
local base = Component

local function Awake(self)
    base.Awake(self)
    self.data={}
end

-------请求挑战数据
local function CoLoadData(self)
    local info = coroutine.yieldstart(Game.Scene.Session.CoCall,nil,Game.Scene.Session,
            OuterOpcode.Name2Code.ETModel_C2M_ChallengeInfo, {})
    if info.Error == ErrorCode.ERR_Success then
        self.data["ChallengeInfo101"] =info.ChallengeInfo101
        self.data["ChallengeInfo102"] =info.ChallengeInfo102
        self.data["ChallengeInfo201"] =info.ChallengeInfo201
        self.data["ChallengeInfo202"] =info.ChallengeInfo202
        self.data["ChallengeInfo301"] =info.ChallengeInfo301
        self.data["ChallengeInfo302"] =info.ChallengeInfo302
        self.data["ChallengeInfo303"] =info.ChallengeInfo303
        self.data["ChallengeInfo304"] =info.ChallengeInfo304
    else
       Logger.LogError("ETModel_C2M_ChallengeInfo:"..info.Error)
    end
    return coroutine.yieldbreak(info)
end

local function ZeroUpdate(self)
    for k,v in pairs(self.data) do
        if type(v) == "table" then
            v.Num1 = 0
            v.Num2 = 0
            v.Num3 = 0
            v.Num4 = 0
        end
    end
end

local function GetChallengeInfo(self,id)
    return self.data["ChallengeInfo"..id]
end

local function Dispose(self)
    base.Dispose(self)
end
ChallengeComponent.Awake = Awake
ChallengeComponent.Dispose = Dispose
ChallengeComponent.CoLoadData = CoLoadData
ChallengeComponent.GetChallengeInfo = GetChallengeInfo
ChallengeComponent.ZeroUpdate = ZeroUpdate

return ChallengeComponent