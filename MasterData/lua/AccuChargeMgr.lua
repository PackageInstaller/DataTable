local AccuChargeData = require("AccuChargeData")
local AccuChargeDataS = require("AccuChargeDataS")
local AccuChargeDataT = require("AccuChargeDataT")
local this = MgrRegister("AccuChargeMgr")

function this:Init()
    self:Clear()
    self:InitData()
    PlayerProto:GetColletData()
    PlayerProto:GetColletDataByType()
end

function this:Clear()
    self.proto = {}
    self.datas = {}
    self.proto2 = nil
    self.datas2 = {}
end

function this:InitData()
    self.datas = {}
    local cfgs = Cfgs.CfgRechargeCount:GetAll()
    for i, v in ipairs(cfgs) do
        local data = AccuChargeData.New()
        data:InitData(v)
        table.insert(self.datas, data)
    end
    --
    self.datas2 = {}
    local cfgs = Cfgs.CfgRechargeCount2:GetAll()
    for i, v in ipairs(cfgs) do
        local data = AccuChargeDataS.New()
        data:InitData(v)
        table.insert(self.datas2, data)
    end
    --
    self.datas3 = {}
    local cfgs = Cfgs.CfgRechargeCount:GetAll()
    for i, v in ipairs(cfgs) do
        local data = AccuChargeDataT.New()
        data:InitData(v)
        table.insert(self.datas3, data)
    end
end

---------------------------------1--------------------------------------------------------
function this:GetColletDataRet(proto)
    self.proto = proto
    -- EventMgr.Dispatch(EventType.AccuCharge_Get)
    self:CheckRed()
end

function this:GetDatas()
    return self.datas
end

function this:CheckRed()
    local num = 0
    for k, v in pairs(self.datas) do
        if (v:IsRed()) then
            num = 1
            break
        end
    end
    local rData = RedPointMgr:GetData(RedPointType.AccuCharge)
    if (rData == nil or rData ~= num) then
        RedPointMgr:UpdateData(RedPointType.AccuCharge, num)
        ActivityMgr:CheckRedPointData(ActivityListType.AccuCharge)
    end
end

function this:GetScore()
    local socre = self.proto.score
    if (socre) then
        return math.floor(socre / 100)
    end
    return 0
end

function this:CheckIsGet(id)
    if (self.proto.data) then
        for k, v in pairs(self.proto.data) do
            if (v == id) then
                return true
            end
        end
    end
    return false
end

----------------------------------2---------------------------------------------------------
function this:GetColletDataByTypeRet(proto)
    self.proto2 = proto
    self:CheckRed2()
end

function this:GetCfg2()
    return Cfgs.CfgActiveList:GetByID(ActivityListType.AccuCharge2)
end

function this:GetDatas2()
    return self.datas2
end

function this:CheckRed2()
    local num = 0
    for k, v in pairs(self.datas2) do
        if (v:IsRed()) then
            num = 1
            break
        end
    end
    local rData = RedPointMgr:GetData(RedPointType.AccuCharge2)
    if (rData == nil or rData ~= num) then
        RedPointMgr:UpdateData(RedPointType.AccuCharge2, num)
        ActivityMgr:CheckRedPointData(ActivityListType.AccuCharge2)
    end
end

function this:GetScore2()
    local socre = self.proto2.score
    if (socre) then
        return math.floor(socre / 100)
    end
    return 0
end

function this:CheckIsGet2(id)
    if (self.proto2 and self.proto2.data) then
        for k, v in pairs(self.proto2.data) do
            if (v == id) then
                return true
            end
        end
    end
    return false
end

-- 关闭活动时间，关闭入口时间
function this:GetEndTime2()
    if (not self.proto2 or not self.proto2.closeTime or self.proto2.closeTime == -1) then
        return nil
    end
    local cTime = self:GetCfg2().cTime or 0
    local endTime = self.proto2.closeTime + cTime * 3600
    return self.proto2.closeTime, endTime
end

-- 是否需要显示(活动有效时间+等待关闭时间)
function this:IsOpen2()
    if (not self.proto2 or self.proto2.openTime == 0) then
        return false
    end
    local curTime = TimeUtil:GetTime()
    if (curTime >= self.proto2.openTime) then
        if (not self.proto2.closeTime or self.proto2.closeTime == -1) then
            return true
        end
        local cTime = self:GetCfg2().cTime or 0
        local endTime = self.proto2.closeTime + cTime * 3600
        if (endTime > curTime) then
            return true
        end
    end
    return false
end

-- 是否可充值或领取
function this:IsActive2()
    if (self:IsOpen2()) then
        local endTime = self.proto2.closeTime or -1
        if (endTime == -1 or endTime > TimeUtil:GetTime()) then
            return true
        end
    end
    return false
end

--累充2 开始，关闭时间（不是结束时间）
function this:GetOpenTime2()
    if (not self.proto2 or self.proto2.openTime == 0) then
        return 
    end
    local sTime = self.proto2.openTime or -1
    local cTime = self:GetCfg2().cTime or 0
    local _eTime = self.proto2.closeTime or sTime
    local eTime = _eTime + cTime * 3600
    return sTime,eTime
end


----------------------------------3---------------------------------------------------------
function this:GetColletDataByTypeRet3(proto)
    self.proto3 = proto
    self:CheckRed3()
end

function this:GetCfg3()
    return Cfgs.CfgActiveList:GetByID(ActivityListType.AccuCharge3)
end

function this:GetDatas3()
    return self.datas3
end

function this:CheckRed3()
    local num = 0
    for k, v in pairs(self.datas3) do
        if (v:IsRed()) then
            num = 1
            break
        end
    end
    local rData = RedPointMgr:GetData(RedPointType.AccuCharge3)
    if (rData == nil or rData ~= num) then
        RedPointMgr:UpdateData(RedPointType.AccuCharge3, num)
        ActivityMgr:CheckRedPointData(ActivityListType.AccuCharge3)
        AnniversaryMgr:CheckRedPointData()
    end
end

function this:GetScore3()
    local socre = self.proto3.score
    if (socre) then
        return math.floor(socre / 100)
    end
    return 0
end

function this:CheckIsGet3(id)
    if (self.proto3 and self.proto3.data) then
        for k, v in pairs(self.proto3.data) do
            if (v == id) then
                return true
            end
        end
    end
    return false
end

return this
