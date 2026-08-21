local M = BaseClass("ChapterSelectionCtrl", BaseUICtrl)

local JChapter = CS.GameBase.JChapter
local allMain = JChapter.AllNormal()
local allElite = JChapter.AllElite()
local EBattleStyle = EnumConst.EBattleStyle
local RedPointConst = CS.GameX.RedPointConst
local EChapterType = ChapterConst.EChapterType
local MissionDataMgr = MissionDataMgr:GetInstance()

function M:Init()
    self.m_finalMainId = 0  -- 最后解锁的主线关卡
    self.m_doubleDatas = {} -- 正在进行的限时奖励配置
    self.m_csChapters = nil
    self.m_selectData = nil
    self.m_selectChapter = nil
    self.m_hardUnlock = JumpMgr:GetInstance():CheckUnlockByFunctionOpenId(2) -- 是否可以打困难

    local msgId = Proto.MessageId.ResponseChapterAward
    local mainCtrl = require("UI.Ctrl.Mission.ChapterItemCtrl")
    local mainView = require("UI.View.Mission.ChapterItemView")
    self._view.node_loopList:Init(mainCtrl, mainView)
    self._view.tgl_hard:onClick(Bind(self, self.OnHardModel))
    self._view.tgl_main:onClick(Bind(self, self.OnNormalModel))
    self._view.btn_cptRwd:onClick(Bind(self, self.OnOpenCptRwd))
    self._view.img_banner:onClick(Bind(self, self.OnEnterStage))
    self._view.tgl_bossWar:onClick(Bind(self, self.OnEnterBossWar))
    self._view.tgl_resType:onClick(Bind(self, self.OnResourceChapter))
    self._view.tgl_encounter:onClick(Bind(self, self.OnEnterEncounter))
    --self._view.tgl_limitChallge:onClick(Bind(self,self.OnEnterLimitChallge))
    self.m_context = UIContextMgr:GetInstance():GetContext("ChapterSelection")
    self._view.node_loopList:SetCreateItemCallback(Bind(self, self.OnCreateMainItem))
    self.rsChapterAward = NetPack:RegistResponse(msgId, Bind(self, self.OnRsChapterAward))
end

function M:OnEnter(chapterType, battleStyle, isWin)
    self._isWin = isWin
    if self._isWin == nil then
        self._isWin = isWin
    end
    self._view.tgl_resType:SetIsOn(false)
    self._view.typeGroup:SetActive(false)
    self._view.tgl_resType:SetInteractable(false)
    self._view.lockMask:SetActive(not self.m_hardUnlock)

    self:_CheckMainFinalId()
    self:_CheckDoubleActive()

    self._view.typeGroup:SetActive(true)
    self:OnBattleChapter()

    if chapterType == EChapterType.ECT_Elite then
        self:OnHardModel()
    else
        self:OnNormalModel()
    end

    if chapterType == EChapterType.ECT_Resource then
        self:OnResourceChapter()
    elseif battleStyle == EBattleStyle.Encount then
        MissionDataMgr:OpenEncountPanel(true, self._isWin)
    elseif battleStyle == EBattleStyle.Boss then
        self:OnEnterBossWar()
    end
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnBack()
    if self._view.tgl_resType:GetIsOn() then
        -- DuStr说 主线 精英 副本都显示资源入口
        self._view.typeGroup:SetActive(true)
        self:OnBattleChapter()
        self:_UpdateItems()
        return false
    end
    self:Close()
    return true
end

function M:OnClose()
    local msgId = Proto.MessageId.ResponseChapterAward
    NetPack:UnRegistResponse(msgId, self.rsChapterAward)

    if self.m_mainTimer then
        self.m_mainTimer:Stop()
        self.m_mainTimer = nil
    end
    if self.m_resTimer then
        self.m_resTimer:Stop()
        self.m_resTimer = nil
    end

    self.m_context = nil
    self.m_csChapters = nil
    self.m_selectData = nil
    self.m_finalMainId = nil
    self.m_doubleDatas = nil
    self.m_selectChapter = nil
end

function M:OnCreateMainItem(itemCtrl)
    itemCtrl:SetItemState(Bind(self, self.OnSelectItem))
end

function M:_RefreshChpterInfo(id)
    local mission = ConfigHelper.GetCfgByLua("mission", id)
    if mission then
        if mission.Chapter then
            self.m_selectChapter = mission.Chapter
            if not self.m_selectChapter then
                Logger.LogError("Chapter is nil, @四叶看看, mission id = " .. id)
            end
        else
            Logger.LogError("Chapter is nil, @四叶看看, mission id = " .. id)
        end
    else
        Logger.LogError("mission is nil, @四叶看看, id = " .. id)
    end
    self:_RefreshBannerInfo()
    self:_RefreshChapterRewards()
end

function M:_RefreshBannerInfo()
    if not self.m_selectChapter then return end

    self._view.img_banner:SetPic(self.m_selectChapter.banner)
    self._view.txt_cnName:SetText(self.m_selectChapter.name)
    self._view.txt_enName:SetText(self.m_selectChapter.nameEN)
    self._view.txt_desc:SetText(self.m_selectChapter.chapterDesc)
    local progs = MissionDataMgr:GetChapterProgress(self.m_selectChapter)
    local progsStr = string.format("%0.2f<size=48>%%</size>", progs * 100)
    self._view.percentage:SetText(progsStr)
    self._view.progsSlider:SetValue(progs)

    self._view.bannerPoint:SetParam(0, self.m_selectChapter.id)
    self._view.bannerPoint:Check()
end

function M:_RefreshChapterRewards()
    if not self.m_selectChapter then return end

    local cptId = self.m_selectChapter.id
    local groupId = self.m_selectChapter.chapterReward
    local roleChapter = MissionDataMgr:GetRoleChapter(cptId)
    local status = not roleChapter or (roleChapter.Status == 0) -- 0:没领 1：领过
    self._view.btn_cptRwd:SetActive(status and (groupId ~= 0))
    if not self._view.btn_cptRwd:IsActive() then return end     -- 没有章节奖励

    self._view.redPoint:SetParam(0, cptId)
    self._view.redPoint:Check()

    -- DuStr说 cpt.rewardDes 有且只有俩 第0个是标题 第1个是描述
    local rewardDes = self.m_selectChapter.rewardDes
    if rewardDes and rewardDes.Length > 0 then
        self._view.cptRwdTitle:SetActive(true)
        self._view.cptRwdDesc:SetActive(true)
        self._view.cptRwdTitle:SetText(rewardDes[0])
        self._view.cptRwdDesc:SetText(rewardDes[1])
    else
        self._view.cptRwdTitle:SetActive(false)
        self._view.cptRwdDesc:SetActive(false)
    end

    local chapterAward = ConfigHelper.GetCfg("itemGroup", groupId)
    if chapterAward then
        if #chapterAward.items > 0 then
            local itemId = chapterAward.items[1]
            self._view.cptItemPfb:SetInfo(itemId, ItemNumberType.NONE)
        else
            Logger.LogError("itemGroup.items is nil, @熊伟看看. id = " .. groupId)
        end
    else
        Logger.LogError("itemGroup is nil, @熊伟看看. id = " .. groupId)
    end
end

function M:OnNormalModel(go)
    if self._view.tgl_main:GetIsOn() then return end
    self:_RefreshModelState(true)

    -- 埋点-打开普通章节页面
    GameHelper.DoPlayerAction(PlayerAction.OpenDefauleChapter)

    self:_RefreshChpterInfo(self.m_finalMainId)
    self.m_csChapters = allMain
    self:_UpdateItems()
end

function M:OnHardModel(go)
    if self._view.tgl_hard:GetIsOn() then return end

    if not self.m_hardUnlock then
        local funcOpen = ConfigHelper.GetCfg("functionOpen", 2) or {}
        local lockReason = GameHelper.GetFirstLockReason(funcOpen.openCondition)
        local openCondition = ConfigHelper.GetCfgByLua("openCondition", lockReason)
        if openCondition ~= nil then GameHelper.TipsById(openCondition.tips) end
        return
    end

    -- 埋点-打开困难章节页面
    GameHelper.DoPlayerAction(PlayerAction.OpenEliteChapter)

    self:_RefreshModelState(false)
    local curMissionId = MissionDataMgr:GetLastHardMissionId()
    local mission = ConfigHelper.GetCfgByLua("mission", curMissionId) or {}
    local nextMission = mission.NextMission
    if nextMission then
        local curChapterId = mission.Chapter.id
        local nextChapter = nextMission.Chapter
        if curChapterId ~= nextChapter.id then
            local isLock = GameHelper.CSCheckLockByOpenConditionIds(nextChapter.openCondition)
            if isLock then curMissionId = nextMission.id end
        end
    end
    self:_RefreshChpterInfo(curMissionId)
    self.m_csChapters = allElite
    self:_UpdateItems()
end

function M:OnEnterStage(go)
    if not self.m_selectChapter then return end

    GameHelper.Jump(100, EBattleStyle.Normal, self.m_selectChapter)
    -- self:OpenModule(ModuleConfig.StageModule.id, EBattleStyle.Normal, self.m_selectChapter)
end

function M:OnOpenCptRwd(go)
    if not self.m_selectChapter then return end

    UIContextMgr:GetInstance():Show("ChapterReviewRewardUI", self.m_selectChapter)
end

function M:OnRsChapterAward(_, result, msg)
    if result ~= 0 then return end
    self._view.btn_cptRwd:SetActive(false)
    IRedPointMgr:ForceCheck(RedPointConst.ChapterRewardRedPointChecker)
    IRedPointMgr:ForceCheck(RedPointConst.MissionRedPointChecker)
end

function M:_RefreshModelState(value)
    self._view.tgl_main:SetIsOn(value)
    self._view.tgl_hard:SetIsOn(not value)
end

function M:OnSelectItem(data)
    if self.m_selectData then
        self.m_selectData.IsSelect = false
    end
    self.m_selectData = data
    self.m_selectData.IsSelect = true
    self.m_selectChapter = data.Chapter
    self:_RefreshBannerInfo()
    self:_RefreshChapterRewards()
    self._view.node_loopList:UpdateList()
end

-- 战役副本
function M:OnBattleChapter(go)
    self._view.battlePanel:SetActive(true)
    self._view.tgl_resType:SetIsOn(false)
    self._view.resPanelCtrl:HidePanel()
end

-- 资源副本
function M:OnResourceChapter(go)
    if self._view.tgl_resType:GetIsOn() then return end
    local funcOpen = ConfigHelper.GetCfgByLua("functionOpen", 25) or {}
    local lockId = GameHelper.GetFirstLockReason(funcOpen.openCondition)
    if lockId > 0 then
        local openCfg = ConfigHelper.GetCfgByLua("openCondition", lockId)
        if openCfg then
            GameHelper.TipsById(openCfg.tips)
        else
            Logger.LogError("openCondition is nil, @熊伟看看, id = " .. lockId)
        end
        return
    end
    self._view.tgl_resType:SetIsOn(true)
    self._view.typeGroup:SetActive(false)
    self._view.battlePanel:SetActive(false)
    self:_ShowResPanel()
end

function M:OnEnterEncounter(go)
    MissionDataMgr:OpenEncountPanel(false)
end

--极限挑战
-- function M:OnEnterLimitChallge(go)
--     UIContextMgr:GetInstance():Show("LimiteChallgeStage")
-- end

-- Boss战
function M:OnEnterBossWar(go)
    BossWarDataMgr:GetInstance():ReqBossBattleInfo(function()
        UIContextMgr:GetInstance():Show("BossWarMainUI")
    end)
end

function M:_CheckDoubleActive()
    self.m_doubleDatas = {}
    local datas = self.m_context:GetTimeLimitData()
    if datas and #datas > 0 then
        for _, data in ipairs(datas) do
            local list = ConfigHelper.GetCfgsByLua("activityDouble", { activityId = data:ActivityId() })
            if list and #list > 0 then
                local cfg = list[1]
                local isAll = #cfg.includeMissionId == 0
                local double = {
                    IsAllDouble = isAll,
                    DoubleDic = {},          -- 限时奖励关卡
                    RemainTimes = data:RemainTimes(),
                    EndTime = data:EndTime() -- 活动结束时间
                }

                for _, missionId in ipairs(cfg.includeMissionId) do
                    double.DoubleDic[missionId] = true
                end

                self.m_doubleDatas[cfg.chapterType] = double
            end
        end

        local mainDouble = self.m_doubleDatas[EChapterType.ECT_Main]
        local resDouble = self.m_doubleDatas[EChapterType.ECT_Resource]
        self._view.mainDbTag:SetActive(mainDouble and mainDouble.RemainTimes > 0)
        self._view.resDbTag:SetActive(resDouble and resDouble.RemainTimes > 0)

        if mainDouble then
            local curTime = TimeUtil.GetNowTimeStamp()
            local endTime = mainDouble.EndTime
            local remain = math.max(0, endTime - curTime)
            local day = TimeUtil.SecToDays(remain)
            self._view.mainRemain:SetText(tostring(day))
            if self.m_mainTimer then
                self.m_mainTimer:Stop()
            end
            self.m_mainTimer = TimerManager:GetInstance():GetTimer(remain, function()
                self.m_doubleDatas[EChapterType.ECT_Main] = nil
                self._view.mainDbTag:SetActive(false)
                self.m_mainTimer:Stop()
                self.m_mainTimer = nil
            end, self, true)
        end

        if resDouble then
            local curTime = TimeUtil.GetNowTimeStamp()
            local endTime = resDouble.EndTime
            local remain = math.max(0, endTime - curTime)
            local day = TimeUtil.SecToDays(remain)
            self._view.resRemain:SetText(tostring(day))
            if self.m_resTimer then
                self.m_resTimer:Stop()
            end
            self.m_resTimer = TimerManager:GetInstance():GetTimer(remain, function()
                self.m_doubleDatas[EChapterType.ECT_Resource] = nil
                self._view.resDbTag:SetActive(false)
                self.m_resTimer:Stop()
                self.m_resTimer = nil

                if self._view.tgl_resType:GetIsOn() then
                    self:_ShowResPanel()
                end
            end, self, true)
        end
    else
        self._view.mainDbTag:SetActive(false)
        self._view.resDbTag:SetActive(false)
    end
end

function M:_CheckMainFinalId()
    local missionId = MissionDataMgr:GetNextMissionId()
    if missionId == 0 then missionId = IPlayerData.missionId end
    if missionId == 0 then missionId = GameHelper.GetParamter(101) end
    self.m_finalMainId = missionId
end

-- 显示资源面板
function M:_ShowResPanel()
    local double = self.m_doubleDatas[EChapterType.ECT_Resource]
    self._view.resPanelCtrl:OpenPanel(double)
end

function M:_UpdateItems()
    self.m_selectData = nil
    local datas, cptId = {}, self.m_selectChapter and self.m_selectChapter.id or 0
    local checkFunc = GameHelper.CSCheckLockByOpenConditionIds
    local unlockNum, selectIdx, isPrePass = 1, 0, true
    for i = 0, self.m_csChapters.Length - 1, 1 do
        local chapter = self.m_csChapters[i]
        if chapter.test == 0 then --正式章节
            local select = chapter.id == cptId
            local isPass = MissionDataMgr:IsPassedChapter(chapter.id)
            local data = {
                Chapter = chapter,
                IsSelect = select,
                IsPass = isPass,
                PostIndex = 0, -- 后置章节位置，0：非后置
            }

            if chapter.type == EChapterType.ECT_Main then
                data.IsUnlock = isPrePass or select
            else
                data.IsUnlock = checkFunc(chapter.openCondition)
            end
            if select then
                selectIdx = i + 1
                self.m_selectData = data
            end
            if data.IsUnlock then
                unlockNum = i + 1
            else
                data.PostIndex = (i + 1) - unlockNum
            end

            isPrePass = isPass
            table.insert(datas, data)
            if data.PostIndex >= 3 then break end -- 显示3个未解锁章节
        end
    end

    self._view.node_loopList:SetDataList(datas)
    self._view.node_loopList:AlignmentContentPosition(selectIdx, 1)
end

return M
