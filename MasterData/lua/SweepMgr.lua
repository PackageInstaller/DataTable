local SweepData = require("SweepData")
SweepMgr = MgrRegister("SweepMgr")
local this = SweepMgr;

function this:Init()
    self:Clear()

    PlayerProto:DuplicateModUpData()
end

function this:Clear()
    self.datas = {}
end

function this:SetDatas(proto)
    if (proto == nil or proto.modUpData == nil) then
        return;
    end

    self.datas = self.datas or {}
    for i, v in ipairs(proto.modUpData) do
        self:SetData(v)
    end

    EventMgr.Dispatch(EventType.Sweep_Show_Panel)
end

function this:SetData(v)
    if self.datas[v.id] then
        self.datas[v.id]:Init(v)
    else
        local sweepData = SweepData.New()
        sweepData:Init(v)
        self.datas[v.id] = sweepData
    end
end

function this:GetDatas()
    return self.datas
end

function this:GetData(dungeonId)
    return self.datas[dungeonId]
end

return this