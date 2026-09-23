DungeonActivityMgr = MgrRegister("DungeonActivityMgr")
local this = DungeonActivityMgr;

function this:Init()
    self:Clear()
    self:InitNewDatas()
end

function this:Clear()
    -- new
    self.sectionNewDatas = nil
end

function this:InitNewDatas()
    self.sectionNewDatas = {}
    for _, datas in pairs(self:GetSectionDatasByType(true)) do
        for i, v in ipairs(datas) do
            self.sectionNewDatas[v:GetID()] = v
        end
    end
end

-- 包含积分战斗
function this:HasBuffBattle(sid)
    local dungeonGroups = DungeonMgr:GetDungeonGroupDatas(sid)
    local isHas = false
    if dungeonGroups and #dungeonGroups > 0 then
        for i, v in ipairs(dungeonGroups) do
            if v:IsEx() then
                isHas = true
                break
            end
        end
    end
    return isHas
end

-- 获取对应类型的章节组数据
function this:GetSectionDatasByType(isCheckOnly)
    local activityTypeDatas = {}
    local activityCfgs = Cfgs.Section:GetGroup(SectionType.Activity)
    if activityCfgs then
        for _, cfg in pairs(activityCfgs) do
            local sectionData = DungeonMgr:GetSectionData(cfg.id)
            local openState1, openState2 = 0, 0
            if sectionData and sectionData:GetType() then
                activityTypeDatas[sectionData:GetType()] = activityTypeDatas[sectionData:GetType()] or {}
                if sectionData:IsShowOnly() and isCheckOnly then
                    if #activityTypeDatas[sectionData:GetType()] > 0 then
                        local id = activityTypeDatas[sectionData:GetType()][1]:GetID()
                        openState1 = activityTypeDatas[sectionData:GetType()][1]:GetOpenState()
                        openState2 = sectionData:GetOpenState()
                        if openState1 ~= openState2 then
                            if openState2 > openState1 then
                                activityTypeDatas[sectionData:GetType()][1] = sectionData
                            end
                        elseif id > sectionData:GetID() then
                            activityTypeDatas[sectionData:GetType()][1] = sectionData
                        end
                    else
                        table.insert(activityTypeDatas[sectionData:GetType()], sectionData)
                    end
                else
                    table.insert(activityTypeDatas[sectionData:GetType()], sectionData)
                end
            end
        end
    end
    return activityTypeDatas
end
---------------------------------------------red----------------------------------------------
function this:CheckRed(sid)
    local sectionData = DungeonMgr:GetSectionData(sid)
    if sectionData and sectionData:GetOpen() then
        if sectionData:GetType() == SectionActivityType.Tower then
            return TowerMgr:IsTowerRed()
        elseif sectionData:GetType() == SectionActivityType.Plot then
            local isRed = MissionMgr:CheckRed2(eTaskType.Story, sectionData:GetID())
            if not isRed then
                if sectionData:GetExploreId() then
                    local exData = ExplorationMgr:GetExData(sectionData:GetExploreId())
                    isRed = exData and exData:HasRevice()
                end
            end
            return isRed
        elseif sectionData:GetType() == SectionActivityType.TaoFa then
            local isRed = MissionMgr:CheckRed2(eTaskType.DupTaoFa, sectionData:GetID())
            if not isRed and self:HasBuffBattle(sid) then
                isRed = MissionMgr:CheckRed2(eTaskType.PointsBattle, sectionData:GetID())
            end
            return isRed
        elseif sectionData:GetType() == SectionActivityType.TotalBattle then
            return MissionMgr:CheckRed({eTaskType.StarPalace})
        elseif sectionData:GetType() == SectionActivityType.Rogue then
            if (RogueMgr:IsRed() or RogueSMgr:IsRed() or RogueTMgr:IsRed()) then
                return true
            end
        elseif sectionData:GetType() == SectionActivityType.GlobalBoss then
            return GlobalBossMgr:IsRed()
        elseif sectionData:GetType() == SectionActivityType.MultTeamBattle then
            return MultTeamBattleMgr:IsRed();
        elseif sectionData:GetType() == SectionActivityType.Trials then
            local isRed = MissionMgr:CheckRed({eTaskType.DupLiZhan,eTaskType.ChainFront})
            if not isRed then
                isRed = TrialsMgr:CheckRed()
            end
            return isRed
        elseif sectionData:GetType() == SectionActivityType.EternityWarzone then
            local isRed = MissionMgr:CheckRed({eTaskType.EternalBattle})
            if not isRed then
                local info = FileUtil.LoadByPath("section_activity_recover") or {}
                if info[sectionData:GetID()] and info[sectionData:GetID()].time > 0 then
                    --下次刷新时间
                    local nextRefreshTime = TimeUtil:NextWeekIndexTimeStamp(1,g_ActivityDiffDayTime,info[sectionData:GetID()].time) 
                    isRed = TimeUtil:GetTime() >= nextRefreshTime
                end
            end
            return isRed   
        elseif sectionData:GetType() == SectionActivityType.RogueMap then         
            return RogueMapMgr:CheckRed()
        elseif sectionData:GetType() == SectionActivityType.PeriodicBoss then         
            return PeriodicBossMgr:CheckRed()
        elseif sectionData:GetType() == SectionActivityType.VirtualCataclysm then         
            return VirCatMgr:CheckRed()
        end
    end
    return false
end
---------------------------------------------new----------------------------------------------
function this:IsNew()
    local isNew = false
    local newInfos = FileUtil.LoadByPath("section_activity_new") or {}
    if self.sectionNewDatas then
        for k, v in pairs(self.sectionNewDatas) do
            if v:GetOpen() and not newInfos[k] then
                isNew = true
                break
            end
        end
    end
    return isNew
end

function this:GetIsNew(sid)
    local newInfos = FileUtil.LoadByPath("section_activity_new") or {}
    if self.sectionNewDatas and self.sectionNewDatas[sid] and self.sectionNewDatas[sid]:GetOpen() and not newInfos[sid] then
        return true
    end
    return false
end

function this:SetNew(sid)
    local newInfos = FileUtil.LoadByPath("section_activity_new") or {}
    newInfos[sid] = 1
    FileUtil.SaveToFile("section_activity_new", newInfos)
end

return this
