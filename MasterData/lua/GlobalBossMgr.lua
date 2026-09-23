GlobalBossMgr = MgrRegister("GlobalBossMgr")
local this = GlobalBossMgr;
GlobalBossData = require "GlobalBossData"

function this:Init()
    -- self:Clear()
end

function this:Clear()
    self.info = {}
    self.cfg = nil
    self.hp = 0
    self.lastHp = nil
    self.maxHp = 0
    self.rank = 0
    self.useCount = 0
    self.data = nil
    self.closeDesc = ""
    self.closeTime = 0
    self.maxDamage = 0
    self.buffIds = nil

    --rank
    self.clearTime = 0
    self.cur_rank = 0
    self.rankInfos = {} 
    self.myRank = 0
    self.myScore = 0
    self.max_rank = 0
    self.joinNum = 1
end

function this:SetInfo(proto)
    local isOffset = false
    if proto then
        self.info = {}
        self.info.sTime = proto.beginTime
        self.info.eTime = proto.endTime
        self.hp = proto.hp and math.floor(proto.hp) or 0
        if proto.bossId then
            if self.data == nil then
                local data = GlobalBossData.New()
                data:InitCfg(proto.bossId)
                self.data = data
            elseif self.data:GetID() ~= proto.bossId then
                self.data:InitCfg(proto.bossId)
                isOffset = true
            end
        end
    end
    self:CheckCloseTime()
    EventMgr.Dispatch(EventType.GlobalBoss_Data_Update,isOffset)
end

--世界boss活动信息
function this:GetInfo()
    return self.info
end

function this:GetData()
    return self.data
end

--活动开启
function this:IsOpen()
    if self.info.sTime and self.info.eTime then
        return TimeUtil:GetTime() >self.info.sTime and TimeUtil:GetTime() <= self.info.eTime
    end
    return false
end

--剩余时间
function this:GetActiveTime()
    if self.info.eTime and TimeUtil:GetTime() <= self.info.eTime then
        return self.info.eTime - TimeUtil:GetTime()
    end
    return 0
end

function this:SetData(proto)
    if proto then
        self.hp = proto.hp and math.floor(proto.hp) or 0
        self.maxHp = proto.maxHp and math.floor(proto.maxHp) or 0
        self.rank = proto.rank or 0
        self.useCount = proto.challengeTimes or 0
        self.maxDamage = proto.maxDamage or 0
        self.joinNum = proto.joinNum
        self.buffIds = proto.buffIds
        if self.lastHp then
            if self.hp <= 0 and self.lastHp > 0 then -- boss被杀死刷新红点
                DungeonMgr:CheckRedPointData()
            end
        end
        self.lastHp = self.hp
    end
    EventMgr.Dispatch(EventType.GlobalBoss_Data_Update)

end

--血量
function this:GetHp()
    return self.hp < 0 and 0 or self.hp
end

--血量上限
function this:GetMaxHp()
    if self.maxHp then
        return self.maxHp < 0 and 0 or self.maxHp
    end
    return 0
end

--界面排位
function this:GetRankIdx()
    return self.rank
end

--挑战次数
function this:GetCount()
    local cur,max = 0,0
    if self.data and self.data:GetMaxCount() > 0 then
        max = self.data:GetMaxCount()
        cur = max - (self.useCount or 0)
    end
    return cur,max
end

--获取当期特效
function this:GetSkills()
    return self.data and self.data:GetSkills()
end

--获取当期buffid
function this:GetBuffIds()
    return self.buffIds
end

--击败boss
function this:IsKill()
    return self.hp <= 0
end

-- 退出战斗
function this:Quit()
    SceneLoader:Load("MajorCity", function()
        CSAPI.OpenView("Section",{type = 4})
        CSAPI.OpenView("GlobalBossView")
    end)
end

------------------------------------rank------------------------------------
function this:GetRankStr(rank)
    local maxRank = self.joinNum
    local rankStr = rank >= 4 and rank .. "" or ""
    if rankStr ~= "" then
        if maxRank == nil or maxRank == 0 then
            rankStr = tonumber(rankStr) > 50 and LanguageMgr:GetByID(70026) or rankStr
        else
            local num1, num2 = 0, 0
            local globalData = GlobalBossMgr:GetData()
            if globalData then
                local info = globalData:GetRanking()
                if info and #info > 0 then
                    for i, v in ipairs(info) do
                        if v.sub and #v.sub > 1 then
                            num1 = v.sub[1] == 1 and v.sub[2] or num1
                            num2 = v.sub[1] == 2 and v.sub[2] or num2
                        end
                    end
                end
            end
            if num1 ~= 0 and num2 ~= 0 then
                if tonumber(rankStr) >= num1 then
                    rankStr = math.ceil(tonumber(rankStr) / maxRank * 1000) / 10
                    rankStr = rankStr > (num2 / 100) and math.floor(num2 / 100) .. "%+" or rankStr .. "%"
                end
            end
        end
    end
    return rankStr
end

------------------------------------red------------------------------------
function this:IsRed()
    if self:IsDayRed() then
        return true
    end
    if self:IsMissionRed() then
        return true
    end
    return false
end

function this:IsDayRed()
    if self.data then
        if not self:IsClose() and self:IsOpen() and not self:IsKill() then
            return RedPointMgr:GetDayRedState(RedPointDayOnceType.GloBalBoss)
        end
    end
    return false
end

function this:IsMissionRed()
    return MissionMgr:CheckRed({eTaskType.GlobalBossDay,eTaskType.GlobalBossMonth})
end
------------------------------------openTime------------------------------------
function this:CheckCloseTime()
    self.closeDesc = ""
    self.closeTime = 0
    if self.data then
        local openInfo = DungeonMgr:GetActiveOpenInfo2(self.data:GetDungeonCfg().group)
        if openInfo then
            local _cfg = openInfo:GetCfg()
            if _cfg and _cfg.closeStartTime and _cfg.closeEndTime then
                self.closeDesc = _cfg.desc
                local curTab = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
                local ss1 = StringUtil:split(_cfg.closeStartTime," ")
                local ss2 = StringUtil:split(_cfg.closeEndTime," ")
                if curTab.day == tonumber(ss1[1]) and curTab.day <= tonumber(ss2[1]) then
                    local tab1 = TimeUtil:SplitTime(ss1[2])
                    if curTab.hour >= tonumber(tab1[1]) then
                        local tab2 = TimeUtil:SplitTime(ss2[2])
                        self.closeTime = TimeUtil:GetTime2(curTab.year,curTab.month,curTab.day,tab2[1],tab2[2],tab2[3])
                    end
                end
            end    
        end
    end
end

function this:GetCloseTime()
    if self.closeTime > TimeUtil:GetTime() then
        return self.closeTime - TimeUtil:GetTime()
    end
    return 0
end

function this:GetCloseDesc()
    return self.closeDesc
end

function this:IsClose()
    return self.closeTime > TimeUtil:GetTime()
end

------------------------------------sweep------------------------------------
--扫荡
function this:CanSweep()
    return self.maxDamage and self.maxDamage > 0
end

function this:GetMaxDamage()
    return self.maxDamage
end

return this