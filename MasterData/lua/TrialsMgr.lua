TrialsMgr = MgrRegister("TrialsMgr")
local this = TrialsMgr;

function this:Init()
    self:Clear()
    FightProto:GetChainFrontInfo()
end

function this:Clear()
    self.info = nil
    self.fightInfo = nil
    self.trialsSectionData = nil
    self.trialsFightOverInfo = {}
end

---------------------------------------------连锁战线---------------------------------------------
function this:UpdateData(proto)
    if proto and proto.id then
        local cfg = Cfgs.CfgChain:GetByID(proto.id)
        if cfg then
            local dupScores = {}
            if proto.dupScore then
                for i, v in ipairs(proto.dupScore) do
                    dupScores[v.first] = v.second
                end
            end
            self.info = {
                score = proto.maxScore or 0,
                sid = cfg.sectionID,
                sTime = TimeUtil:GetTimeStampBySplit(cfg.begTime),
                eTime = TimeUtil:GetTimeStampBySplit(cfg.endTime),
                dupScores = dupScores,
                taskEndTime = cfg.taskEndTime
            }
        end
        self:UpdateFightingInfo(proto.progressInfo)
    end
    EventMgr.Dispatch(EventType.Trials2_Panel_Refresh)
end

function this:GetCurSectionId()
    return self.info and self.info.sid or 0
end

function this:GetStartTime()
    return self.info and self.info.sTime or 0
end

function this:GetEndTime()
    return self.info and self.info.eTime or 0
end

function this:GetMaxScore()
    return self.info and self.info.score or 0
end

function this:GetMissionEndTime()
    local time = 0
    if self.info and self.info.taskEndTime then
        time = TimeUtil:GetTimeStampBySplit(self.info.taskEndTime)
    end
    return time
end

function this:GetLen(groupId)
    local cfg = Cfgs.DungeonGroup:GetByID(groupId)
    if cfg and cfg.dungeonGroups then
        return #cfg.dungeonGroups
    end
    return 0
end

-- 获取关卡对应的分数
function this:GetDupScore(dungeonId)
    if dungeonId and self.info and self.info.dupScores then
        return self.info.dupScores[dungeonId] or 0
    end
end

function this:CheckRed()
    local isChainRed, isRed = TipsMgr:IsShowDailyTips("Chain"), TipsMgr:IsShowDailyTips("Trials")
    local openInfo = nil
    if isRed then
        local datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.Trials, true)
        local time = 0
        if datas and #datas > 0 then
            for i, v in ipairs(datas) do
                if v:GetCfg() and not v:GetCfg().isChain then
                    if not openInfo then
                        openInfo = DungeonMgr:GetActiveOpenInfo2(v:GetID())
                    end
                    if openInfo and openInfo:GetUpTime(v:GetID()) > time then
                        time = openInfo:GetUpTime(v:GetID())
                        break
                    end
                end
            end
        end
        isRed = time > 0
    end
    if isChainRed then
        openInfo = DungeonMgr:GetActiveOpenInfo2(self:GetCurSectionId())
        if openInfo and openInfo:GetCfg() and openInfo:GetCfg().taskEndTime then
            local time = TimeUtil:GetTimeStampBySplit(openInfo:GetCfg().taskEndTime)
            isChainRed = time - TimeUtil:GetTime() > 0
        else
            isChainRed = false
        end
    end

    return (isRed or isChainRed), isChainRed, isRed
end

function this:SaveClickInfo(isChain)
    local isSave = false
    if isChain and TipsMgr:IsShowDailyTips("Chain") then
        TipsMgr:SaveDailyTips("Chain", true)
        isSave = true
    elseif not isChain and TipsMgr:IsShowDailyTips("Trials") then
        TipsMgr:SaveDailyTips("Trials", true)
        isSave = true
    end
    if isSave then
        DungeonMgr:CheckRedPointData()
    end
end

function this:UpdateFightingInfo(progressInfo)
    if progressInfo then
        self.fightInfo = {
            id = progressInfo.group,
            isFighting = progressInfo.isFighting and progressInfo.isFighting == 1,
            round = progressInfo.round,
            lockRounds = progressInfo.lockRounds,
            lockAssistRoles = progressInfo.lockAssistRoles
        }
        EventMgr.Dispatch(EventType.Trials2_Panel_Refresh)
    end
end

--正在战斗中
function this:IsFighting()
    return self.fightInfo and self.fightInfo.isFighting
end

function this:GetFightId()
    return self.fightInfo and self.fightInfo.id
end

function this:GetFightRound()
    return self.fightInfo and self.fightInfo.round
end

--上锁状态
function this:IsTeamLock(index)
    if self.fightInfo and self.fightInfo.lockRounds then
        for i, v in ipairs(self.fightInfo and self.fightInfo.lockRounds) do
            if v == index then
                return true
            end
        end
    end
    return false
end

--获取已锁助战队伍信息
function this:GetLockAssistData(round,teamIndex)
    if not round then
        return
    end
    if self.fightInfo and self.fightInfo.lockAssistRoles then
        for i, v in ipairs(self.fightInfo.lockAssistRoles) do
            if v.round == round then
                local card = nil
                local data = {
                    cid = v.role.cid,
                    row = v.role.row,
                    col = v.role.col,
                    fuid = v.role.fuid,
                    index = v.role.index,
                    isLeader=v.role.isLeader,
                    nStrategyIndex=v.role.nStrategyIndex,
                }
                if v.role.fuid then
                    card = RoleMgr:GetMaxFakeData(v.role.cid)
                    card.data.level = v.role.level or 1
				    data.cid = FormationUtil.FormatAssitID(v.role.fuid, v.role.cid);
                    card.data.cid = data.cid
                elseif v.role.npcid then
                    data.bIsNpc = true;
                    data.cid=FormationUtil.FormatNPCID(v.role.cid);
                end
                if v.role.aiSetting then --只有NPC或者助战卡才会返回AI预设
                    AIStrategyMgr:SetAssistAIPrefs(data.cid,teamIndex,v.role.aiSetting);
                end
                local teamItemData = TeamItemData.New()
                teamItemData:SetData(data)
                if card ~= nil then
                    teamItemData.card = card
                end
                return teamItemData
            end
        end
    end
end

function this:IsShowCard(roleTag)
    if self:IsFighting() then
        for i = 1, 3 do
            if self:IsTeamLock(i) then
                local teamData = TeamMgr:GetTeamData(eTeamType.ChainFront + i - 1)
                if teamData and teamData:HasRoleTag(roleTag) then
                    return false
                end
                local assistData = self:GetLockAssistData(i,eTeamType.ChainFront + i - 1)
                if assistData and assistData:GetRoleTag() == roleTag then
                    return false
                end
            end
        end
    end
    return true
end

function this:IsEquipLock(cid)
    if self:GetEndTime() <= TimeUtil:GetTime() then
        return false
    end
    if self:IsFighting() then
        local roleTag = nil
        for i = 1, 3 do
            if self:IsTeamLock(i) then
                local assistData = self:GetLockAssistData(i,eTeamType.ChainFront + i - 1)
                if assistData and assistData:GetID() == cid then
                    roleTag = assistData:GetRoleTag()
                    break
                end
            end
        end
        if roleTag == nil then
            local card = RoleMgr:GetData(cid)
            roleTag = card and card:GetRoleTag()
        end
        return not self:IsShowCard(roleTag)
    end
    return false
end
---------------------------------------------历战试炼---------------------------------------------
-- 获取当前开启的章节数据
function this:GetTrialsSectionData()
    if self.trialsSectionData then
        local openInfo = DungeonMgr:GetActiveOpenInfo2(self.trialsSectionData:GetID())
        if not openInfo or openInfo:GetUpTime(self.trialsSectionData:GetID()) <= 0 then
            self.trialsSectionData = nil
        end
    end
    if not self.trialsSectionData then
        local datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.Trials, true)
        if datas and #datas > 0 then
            local openInfo = nil
            for i, v in ipairs(datas) do
                if v:GetCfg() and not v:GetCfg().isChain then
                    if not openInfo then -- 共用一个
                        openInfo = DungeonMgr:GetActiveOpenInfo2(v:GetID())
                    end
                    if openInfo and openInfo:GetUpTime(v:GetID()) > 0 then
                        self.trialsSectionData = v
                        break
                    end
                end
            end
        end
    end
    return self.trialsSectionData
end

--获取当前历战时间信息
function this:GetTrialsTime()
    local time, sTime, eTime = 0, 0, 0
    local data = self:GetTrialsSectionData()
    if data then
        local openInfo = DungeonMgr:GetActiveOpenInfo2(data:GetID())
        if openInfo then
            time, sTime, eTime = openInfo:GetUpTime(data:GetID())
        end
    end
    return sTime, eTime, time
end

--设置历战副本结算信息
function this:SetTrialsFightOverInfo(proto)
    if proto and proto.dupId then
        self.trialsFightOverInfo[proto.dupId] = proto.score or 0
    end
end

--获取历战副本结算分数
function this:GetTrialsFightOverSocre(dungeonId)
    return self.trialsFightOverInfo and self.trialsFightOverInfo[dungeonId] or 0
end

return this
