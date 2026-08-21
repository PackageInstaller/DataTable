local M = BaseClass("BaseStageInfoCtrl")

function M:__init(view)
    self._view = view
    self.m_sweepState = 3 -- 扫荡状态 2:扫荡, 3:锁定
    self.m_energyChanged = EventMgr:AddListener(UIMessageNames.ENERGY_CHANGED_NOTIFY, Bind(self, self.OnEnergyChanged))
    self:Init()
end

function M:Init()
    -- body
end

function M:OnDispose()
    GameHelper.ClearItemJump()
    EventMgr:RemoveListener(UIMessageNames.ENERGY_CHANGED_NOTIFY, self.m_energyChanged)
    self.m_energyChanged = nil
    self.m_missionData = nil
    self.m_doubleData = nil
    self.m_exceptions = nil
    self.m_isFullStar = nil
    self.m_mission = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

-- 体力变化回调
function M:OnEnergyChanged()
    -- body
end

-- 刷新状态
function M:OnRefreshState()
    -- body
end

-- 保存关卡配置回调
function M:OnSaveCallback()
    local state = self.m_missionData:MopUpState() -- 可选 和 选中 状态
    local isUnlock = self.m_missionData:IsUnlockSweep()
    self.m_sweepState = isUnlock and state or 3
    self:OnRefreshState() -- 刷新UI
end

function M:_SetBaseInfo(mission, doubleData)
    self.m_mission = mission
    self.m_doubleData = doubleData
    self.m_missionData = MissionDataMgr:GetInstance():GetMissionDataById(self.m_mission.id)
    self.m_isFullStar = self.m_missionData:GetStar() >= (MissionHelper.Is4StarMission(mission) and 4 or 3)
end

-- [通用] 所有类型关卡的奖励预览中不再显示randomReward的奖励预览
function M:_GetRewardItems()
    local awardList, cfg = {}, self.m_mission
    local addItem = MissionHelper.ActivityAddMissionItem(cfg.chapterID)
    if (addItem > 0) and (cfg.energyCost > 0) then -- 主线预热额外活动道具
        awardList[#awardList + 1] = { id = addItem, num = cfg.energyCost }
    end

    if self.m_missionData:GetPassCount() <= 0 then -- [通用] 如果没首通 则添加首通奖励
        local itemGroup = ConfigHelper.GetCfg("itemGroup", cfg.firstChests) or {}
        self:_AddRandomRewards(awardList, itemGroup.items, itemGroup.cnts)
    end

    self:_AddAllStarAward(awardList) -- [通用] 如果配置了星级奖励，则显示星级奖励
    if MissionDataMgr:GetInstance():IsResTeachMission(cfg.id) then
        self:_AddChestRewards(awardList, cfg.chest, false)
    elseif MissionHelper.Is4StarMission(cfg) then
        self:_AddChestRewards(awardList, cfg.chest, true)
    elseif self.m_missionData:IsResource() then
        self:_AddChestRewards(awardList, cfg.chest, false, true)
    else
        self:_AddChestRewards(awardList, cfg.chest, true)
    end
    return awardList
end

-- 所有星级奖励
function M:_AddAllStarAward(awardList)
    local awardDic, cfg, starNum, id = {}, self.m_mission, self.m_missionData:GetStar(), nil
    for i, items in ipairs({ cfg.headFullstar, cfg.secndFullstar, cfg.thirdFullstar, cfg.fourthFullstar }) do
        if i > starNum then
            for k = 0, (items and items.Length or 0) - 1, 2 do
                id = items[k]
                awardDic[id] = (awardDic[id] or 0) + items[k + 1] -- 合并数量
            end
        end
    end
    for k, v in pairs(awardDic) do awardList[#awardList + 1] = { id = k, num = v } end
end

-- 统一添加固定奖励奖励
function M:_AddChestRewards(data, chestIds, isShowNum, isRandom)
    if not chestIds then return end

    for i = 0, chestIds.Length - 1 do
        local itemGroup = ConfigHelper.GetCfg("itemGroup", chestIds[i])
        if itemGroup then
            local nums = itemGroup.cnts
            for j, v in ipairs(itemGroup.items) do
                data[#data + 1] = { id = v, num = isShowNum and nums[j] or 0 }
                if isRandom then break end
            end
        else
            Logger.LogError("itemGroup is nil, id = " .. tostring(chestIds[i]))
        end
    end
end

-- 统一添加随机奖励
function M:_AddRandomRewards(data, items, cnts)
    if not items or not cnts then return end

    for i, v in ipairs(items) do data[#data + 1] = { id = v, num = cnts[i] } end
end

-- 是否体力不足
function M:_IsLackEnergy(id)
    if EnergyMgr:GetInstance():EnergyValue() < self.m_mission.energyCost then
        UIContextMgr:GetInstance():Show("ComPopupEnergy")
        GameHelper.TipsById(id)
        return true
    end
    return false
end

-- 开始战斗按钮点击事件
function M:OnBattleClick()
    -- state == 2 开启扫荡模式
    if self.m_sweepState == 2 then
        if self:_CheckJumpItemBack() then return end
        self:_RequestMopping()
    else
        self:_OpenBattleToTeam()
    end
end

-- 扫荡按钮点击事件
function M:OnMoppingClick()
    if self.m_sweepState == 3 then return end

    local config = self.m_missionData:ClientConfig() or {}
    config.mopUpState = self.m_sweepState == 1 and 2 or 1

    local handler = Bind(self, self.OnSaveCallback)
    if self.m_missionData:IsActivity() then
        local cptId = self.m_missionData:GetChapterId()
        MissionDataMgr:GetInstance():NetSaveCopyMissionConfig(self.m_mission.id, cptId, config, handler)
    else
        MissionDataMgr:GetInstance():NetSaveMissionConfig(self.m_mission.id, config, handler)
    end
end

-- 跳到编队界面
function M:_OpenBattleToTeam()
    if self:_IsLackEnergy(5182) then return end

    IPlayerData.cur_chapterId = self.m_mission.chapterID
    local isTeach = self.m_missionData:IsSystemTeam()
    local battleStyle = EnumConst.EBattleStyle.Normal -- 当前界面只会是 Normal
    JumpMgr:GetInstance():Execute(7, isTeach, self.m_mission.id, EnumConst.TeamConfigStyle.Battle, battleStyle)
end

-- 判断是否打开二次弹窗(道具跳转返回)
function M:_CheckJumpItemBack()
    local eType = EnumConst.NotesWorkType.ItemJump
    local noteData = NotesWorkMgr:GetInstance():GetDataByType(eType)
    if noteData and noteData:IsShowJumpNote() then -- 判断是否打开二次弹窗
        if noteData:IsItemNumDone() then
            local name = noteData:NoteItemName()
            local content = string.format(ConfigHelper.GetLocalString(1286), name)
            EventMgr:Broadcast(UIMessageNames.JUMP_ITEM_DONE)
            GameHelper.ConfirmPopupUI(content, function(ok)
                if ok then
                    EventMgr:Broadcast(UIMessageNames.CLOSE_MISSION_DETAILS)
                else
                    self:_RequestMopping()
                end
            end, nil, nil, 1288, 1287)
            noteData:ClearData()
            return true
        end
    end
    return false
end

-- 获取选中词条
function M:_GetSelectWordDic()
    local selectDic, missionId = {}, self.m_mission.id
    local words = GameHelper.GetChallengeTarget(missionId)
    if IsNull(words) then
        local keyName = "ChallengeStage" .. tostring(missionId)
        if PlayerPrefTools.GetPlayerPrefsInt(keyName, 0) == 0 then
            if not self.m_exceptions then
                self.m_exceptions = ConfigHelper.GetSystemParams(341) -- 需要排除自动选中的关卡
            end
            if not table.arrayContains(self.m_exceptions, missionId) then
                local wordId, saveTarget, cTarget = 0, {}, self.m_mission.Stage.challengeTarget
                for i = 1, (cTarget and cTarget.Length or 0) do
                    wordId = cTarget[i - 1]
                    selectDic[wordId] = true
                    saveTarget[#saveTarget + 1] = wordId
                end
                GameHelper.SetChallengeTarget(saveTarget, missionId)
            end
            PlayerPrefTools.SetPlayerPrefs(keyName, 1)
        end
    else
        for i = 0, words.Count - 1 do selectDic[words[i]] = true end
    end
    return selectDic
end

-- 请求扫荡
function M:_RequestMopping()
    if self:_IsLackEnergy(5181) then return end

    UIContextMgr:GetInstance():Show("ConfirmSweepUI", self.m_missionData)
end

-- 是否双倍奖励关卡
function M:_IsDoubleMission()
    if self.m_doubleData:IsTotalDouble() or self.m_doubleData:DoubleValue(self.m_mission.id) then
        return self.m_doubleData:RemainTimes() > 0 -- 当日次数用完，当日活动就相当于结束了
    end
    return false
end

-- 当前关卡是否有双倍活动的随机奖励
function M:_HasRandomReward()
    local doubleRewardId = self.m_doubleData:RandomValue(self.m_mission.id)
    return doubleRewardId and (doubleRewardId > 0) or false
end

-- 打开奖励详情面板
function M:OnOpenRewardClick(go)
    local isDouble = self:_IsDoubleMission()
    local doubleRewardId = self.m_doubleData:RandomValue(self.m_mission.id)
    if self.m_missionData:IsMaskedBall() then -- 假面舞会
        UIContextMgr:GetInstance():Show("MissionActivityAwardDetails", self.m_mission, isDouble, doubleRewardId)
    else
        UIContextMgr:GetInstance():Show("MissionAwardDetails", self.m_mission, isDouble, doubleRewardId)
    end
end

-- 打开地图详情面板
function M:OnMapInfoClick(go)
    UIContextMgr:GetInstance():Show("MissionMapUI", self.m_mission.map)
end

-- 打开怪物详情面板
function M:OnMonInfoClick(go)
    UIContextMgr:GetInstance():Show("MonsterInfoUI", self.m_mission.Stage)
end

function M:OnEnergyClick(go)
    UIContextMgr:GetInstance():Show("ComPopupEnergy")
end

-- 显示已使用助战提示
function M:IsShowHelpTip()
    -- 未解锁助战 & 满星通关 & 显示助战按钮
    return (self.m_sweepState == 3) and self.m_isFullStar and self.m_missionData:IsShowFast()
end

-- 开始战斗按钮状态 1：手动 2：扫荡
function M:BattleBtnState()
    -- 2:选中扫荡按钮
    return (self.m_sweepState ~= 2) and 1 or 2
end

return M
