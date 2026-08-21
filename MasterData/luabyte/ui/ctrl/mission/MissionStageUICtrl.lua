local M = BaseClass("MissionStageUICtrl", BaseUICtrl)

local m_insert = table.insert
local MessageId = Proto.MessageId
local EPanelType = { EMPTY = 1, INFO = 2 }
local EChapterType = ChapterConst.EChapterType
local MissionMgr = MissionDataMgr:GetInstance()
local pointCtrl = require("UI.Ctrl.Mission.MissionPointItemCtrl")

function M:_InitData()
    self.m_tween = nil -- 切换上/下一章的动画
    self.m_chapter = nil
    self.m_mission = nil
    self.m_mapTween = nil
    self.m_posTimer = nil    -- 计算位置定时器
    self.m_roleChapter = nil
    self.m_selectPoint = nil -- 只是判断点击
    self.m_pointLst = {}
    self.m_chapterLst = {}
    self.m_missionLst = {}
    self.m_moveMap = true -- 关卡的数量是否可以滑动
    self.m_stageMove = false
    self.m_firstEnter = true
    self.m_limitX = 0
    self.m_jumpPos = 0   -- 跳转关卡的位置
    self.m_getStars = 0
    self.m_mapWidth = 0  -- 地图宽度
    self.m_shopActId = 0 -- activity 表 id
    self.m_curCptIdx = 0
    self.m_responseId = 0
    self.m_oriMapPosX = 0    -- 打开stagePanel前背景的位置
    self.m_screenWidth = 0   -- 屏幕宽度
    self.m_maxMissionPos = 0 -- 当前最后通关关卡X坐标
    self.m_jumpMissionId = 0
    self.m_panel = EPanelType.EMPTY
    self.m_mapTrans = self._view.mapBg.transform
    self.m_doubleData = MissionMgr:GetDoubleData()
    self.m_rightRectPos = self._view.stagePanel.rect.width
    self.m_clips = self._view.stageAnim.runtimeAnimatorController.animationClips
    self.m_canvasTrans = UIManager:GetInstance():canvasTransformNormal().transform
end

function M:_InitEvent()
    local itemCtrl = require("UI.Ctrl.Mission.ChapterNameItemCtrl")
    local itemView = require("UI.View.Mission.ChapterNameItemView")
    self._view.chapterScroll:Init(itemCtrl, itemView)
    self._view.mapBg:onClick(Bind(self, self.OnCloseStagePanel))
    self._view.cptReward:onClick(Bind(self, self.OnClickRewardBtn))
    self._view.btn_shop:onClick(Bind(self, self.OnClickActivityShop)) -- 活动商店
    self._view.lastChapterBtn:onClick(Bind(self, self.OnClickLastChapter))
    self._view.nextChapterBtn:onClick(Bind(self, self.OnClickNextChapter))

    self.m_stageHandle = Bind(self, self._OpenStagePanel)
    self.m_cptAwardHandler = Bind(self, self.OnShowChapterAward)
    self.m_mopupEnd = EventMgr:AddListener(UIMessageNames.BATTLE_MOPUOP_END, Bind(self, self.OnBattleMopupEnd))
    self.m_onCloseDetails = EventMgr:AddListener(UIMessageNames.CLOSE_MISSION_DETAILS, Bind(self, self.OnCloseStage))
end

function M:Init()
    self:_InitData()
    self:_InitEvent()
end

function M:OnEnter(chapter, missionId)
    self.m_stageMove = false
    self.m_chapter = chapter
    self.m_jumpMissionId = missionId or 0
    local cptId = self.m_chapter.id
    self.m_roleChapter = MissionMgr:GetRoleChapter(cptId)
    if not self.m_roleChapter then self.m_roleChapter = CS.Protocol.CRoleChapter() end -- 可能数据未收到，则需要额外处理
    if not self.m_notichWidth then self.m_notichWidth = CS.GameX.GameGlobal.notichWeight end

    self.m_mapWidth = self.m_mapTrans.rect.width
    self.m_screenWidth = self._view.transform.rect.width
    self.m_getStars = MissionMgr:GetChapterTotalStars(cptId)
    self.m_mission = ConfigHelper.GetCfgByLua("mission", self.m_chapter.stages[0])
    self.m_limitX = (self.m_mapWidth - self.m_screenWidth) / 2 - self.m_notichWidth

    local mType = self.m_chapter.type
    local isShowReward = (mType ~= EChapterType.ECT_Resource) and (mType ~= EChapterType.ECT_Activity)
    self._view.normalTag:SetActive(mType == EChapterType.ECT_Main)
    self._view.hardTag:SetActive(mType == EChapterType.ECT_Elite)
    self._view.mapBg:SetPic(self.m_chapter.backGround)
    self._view.cptReward:SetActive(isShowReward)
    self._view.mapScroll:StopMovement()
    self._view.stageClose:DOComplete()
    self._view.stageOpen:DOComplete()
    self._view.backGround:ReDraw()

    self:_CloseTween()
    self:_PlayerAction()
    self:_DoubleActive()
    self:_GetMissionLst()
    self:_SetStagePoints()
    self:_RefreshStarReward()
    self:_RefreshChapterScroll()
    self:_SetMissionSelectState(false)

    local cfg = MissionHelper.MissionActivityShopCfg(cptId)
    if cfg then
        self.m_shopActId = cfg.id -- activity 表 id
        self._view.img_shopIcon:SetPic(cfg.icon)
        self._view.txt_shopName:SetText(cfg.name)
    else
        self.m_shopActId = 0
    end
    self._view.btn_shop:SetActive(self.m_shopActId > 0)

    if self.m_firstEnter then
        self.m_firstEnter = false
        self.m_posTimer = TimerManager:GetInstance():GetTimer(0.4, Bind(self, self._AccountMapPos, 0.35), self, true)
        self.m_posTimer:Start() -- 定时器解决手机分辨率动态变化问题
    else
        self:_AccountMapPos()
    end

    self._view.cptReward:SetParam(0, cptId)
    self._view.cptReward:Check()
    self:_CheckActivityTimes()
end

function M:OnVisible()
    self:_PlayerAction()
    M.super.OnVisible(self)
end

function M:OnDispose()
    if self.m_timer then self.m_timer:Stop() end
    if self.m_posTimer then self.m_posTimer:Stop() end
    for _, v in ipairs(self.m_pointLst) do v:OnDispose() end
    for i = 1, 4 do self._view["starLine" .. i]:SetClickCallback() end
    NetPack:UnRegistResponse(self.m_responseId, self.m_rsBattleResult)
    EventMgr:RemoveListener(UIMessageNames.BATTLE_MOPUOP_END, self.m_mopupEnd)
    EventMgr:RemoveListener(UIMessageNames.ACTIVITY_UPDATE, self.m_onActivityUpdate)
    EventMgr:RemoveListener(UIMessageNames.CLOSE_MISSION_DETAILS, self.m_onCloseDetails)
    self.m_timer = nil
    self.m_tween = nil
    self.m_chapter = nil
    self.m_mission = nil
    self.m_posTimer = nil
    self.m_mopupEnd = nil
    self.m_pointLst = nil
    self.m_mapTween = nil
    self.m_mapTrans = nil
    self.m_shopActId = nil
    self.m_chapterLst = nil
    self.m_missionLst = nil
    self.m_doubleData = nil
    self.m_responseId = nil
    self.m_canvasTrans = nil
    self.m_roleChapter = nil
    self.m_selectPoint = nil
    self.m_onCloseDetails = nil
    self.m_rsBattleResult = nil
    self.m_cptAwardHandler = nil
    self.m_onActivityUpdate = nil
    UIContextMgr:GetInstance():Close(UIDefine.UITeamConfig)
    M.super.OnDispose(self)
end

function M:OnBack()
    if self.m_timer or self.m_mapTween then return false end

    if self.m_panel == EPanelType.EMPTY then
        local mType = self.m_chapter.type
        local topCmd = JumpMgr:GetInstance():GetTopBackCommand()
        local isNullCmd = string.isNullOrEmpty(topCmd)
        if isNullCmd or topCmd == "OpenChapterSelection" then
            UIContextMgr:GetInstance():GetContext("ChapterSelection"):SetBackType(mType)
        end
        if isNullCmd then
            if mType ~= EChapterType.ECT_Activity then
                UIContextMgr:GetInstance():Show("ChapterSelection", mType, EnumConst.EBattleStyle.Normal)
            else
                ActivityCopyDataMgr:GetInstance():OpenDefaultActivity()
            end
        end

        return true
    else
        self:OnCloseStagePanel(nil)
        return false
    end
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:CurChapter()
    return self.m_chapter
end

function M:_InitOpenSystem()
    local missionId = OpenSystemMgr:GetInstance():GetMissionId()
    if not missionId then return end
    local functionOpenId = OpenSystemMgr:GetInstance():IsOpenNewTips(missionId)
    if not functionOpenId then return end

    UIManager:GetInstance():Show(UIDefine.UIOpenSystem, functionOpenId)
end

function M:OnClickRewardBtn(go)
    local starStr = tostring(self.m_getStars)
    local starLimit = self.m_chapter.starLimit
    local awardFlag = self.m_roleChapter.AwardFlag
    local awardDatas, chapterId = {}, self.m_chapter.id
    for i = 0, starLimit.Length - 1 do
        local idx = i
        local limitNum = starLimit[idx]
        local data = {
            IdArr = nil,
            NumArr = nil,
            ClickFun = nil,
            IsAward = false,
            IsAccept = false,
            LeftStr = starStr,
            RightStr = "/" .. limitNum,
        }

        if self.m_getStars >= limitNum then
            if (awardFlag >> idx & 1) == 1 then -- 0:没领 1：领过
                data.IsAccept = true            -- 已领取
            else
                data.IsAward = true             -- 可领取
            end
        end

        data.ClickFun = function()
            local request = { ChapterId = chapterId, Idx = idx }
            MissionMgr:GetChapterAward(request, self.m_cptAwardHandler)
        end

        local groupId = self.m_chapter.starReward[idx]
        local itemGroup = ConfigHelper.GetCfgByLua("itemGroup", groupId)
        if itemGroup then
            data.IdArr = itemGroup.items
            data.NumArr = itemGroup.cnts
        else
            Logger.LogError("itemGroup is nil, @熊伟看看, id = " .. groupId)
        end

        m_insert(awardDatas, data)
    end

    UIContextMgr:GetInstance():Show("TargetRewardUI", awardDatas)
end

-- 打开活动商店
function M:OnClickActivityShop(go)
    MissionHelper.OpenMissionActivityShop(self.m_shopActId)
end

-- 检查是否有无剧情关卡
function M:_CheckStoryMission(mission)
    if self.m_rsBattleResult then return true end

    -- 文字关卡
    if mission.wordsMission == 1 then
        local missionId = mission.id
        local triggerType = StoryConst.TriggerType.Story
        if StoryDataMgr:GetInstance():TriggerStoryByGroupIds(mission.storyID, missionId, triggerType, function()
                local requestId, nRequest
                local resultHander = Bind(self, self.OnResponseBattleResult)
                if mission.Chapter.type == EChapterType.ECT_Activity then
                    requestId = MessageId.RequestActivityEndBattle
                    self.m_responseId = MessageId.ResponseActivityEndBattle
                    local actId = ActivityCopyDataMgr:GetInstance():GetActivity()
                    nRequest = { ActivityId = actId, MissionId = missionId, IsWin = protocol.BattleRes.WIN }
                else
                    requestId = MessageId.RequestBattleResult
                    self.m_responseId = MessageId.ResponseBattleResult
                    nRequest = { MissionId = missionId, IsWin = protocol.BattleRes.WIN }
                end
                self.m_rsBattleResult = NetPack:RegistResponse(self.m_responseId, resultHander)
                NetPack:SendMessage(requestId, nRequest)
            end) then
            return true
        end
    end

    return false
end

function M:OnResponseBattleResult(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsBattleResult)
    self.m_rsBattleResult = nil
    self.m_responseId = 0
    if (result ~= 0) then return end

    local ids, nums, stateDic = {}, {}, {}
    for _, item in ipairs(msg.Awards or {}) do
        m_insert(ids, item.Id)
        m_insert(nums, item.Cnt)
    end
    for _, awardExt in ipairs(msg.AwardExt or {}) do
        local _type = awardExt.Tp or 0 -- 0：票选奖励 1：双倍活动奖励 2：资源本奖励
        for _, item in ipairs(awardExt.Awards or {}) do
            m_insert(ids, item.Id)
            m_insert(nums, item.Cnt)
            stateDic[#ids - 1] = 4 + _type -- 4/5/6
        end
    end

    GameHelper.ShowAwards(ids, nums, stateDic, Bind(self, self.OnCloseAwardWind))
end

function M:OnCloseAwardWind()
    self:OnEnter(self.m_chapter)
    MissionMgr:ShowLoadingChapter()
end

function M:_CheckPointInStagePanel()
    local pos = self.m_selectPoint:GetUpRightLocalPos(self.m_canvasTrans)
    return pos.x >= (self.m_screenWidth / 2 - self.m_rightRectPos)
end

function M:_CloseTween()
    if self.m_panel ~= EPanelType.EMPTY then
        self.m_panel = EPanelType.EMPTY
        self._view.stagePanel:SetActive(false)
        if self.m_timer then
            self.m_timer:Stop()
            self.m_timer = nil
        end
        if self.m_mapTween then
            self.m_mapTween:TweenPause()
            self.m_mapTween:TweenKill()
            self.m_mapTween = nil
        end
    end
end

function M:_OpenStagePanel(point)
    if self.m_selectPoint == point then return end
    if self.m_tween or self.m_timer or self.m_mapTween then return end

    local mission = point:GetMission()
    -- 检查是否有无剧情关卡
    if self:_CheckStoryMission(mission) then return end

    self.m_mission = mission
    if self.m_selectPoint then
        self.m_selectPoint:SetParent(self.m_mapTrans)
        self.m_selectPoint:SetSelectState(false)
    end
    self.m_selectPoint = point

    if not self._view.stagePanel:IsActive() then
        self._view.stageClose:DOComplete()
        self._view.stagePanel:SetActive(true)
        self:_StagePanelTimer(self.m_clips[0])
        self._view.stageAnim:Play("MissionStagePanel", 0, 0)

        self.m_stageMove = self:_CheckPointInStagePanel()
        if self.m_stageMove then
            self.m_oriMapPosX = self.m_mapTrans.localPosition.x
            local endPosX = self.m_oriMapPosX - self.m_rightRectPos
            self.m_mapTween = self._view.mapBg:SetDoLocalMoveX(endPosX, 0.5, 10)
            self.m_mapTween:OnTweenComplete(function() self.m_mapTween = nil end)
        end
    end

    self:_SetMissionSelectState(true)
    self._view.pointMask:SetAsLastSibling()
    self._view.mapScroll:SetHorizontal(false)
    self._view.stageCtrl:Refresh(self.m_mission, self.m_doubleData)
end

function M:OnCloseStagePanel(go)
    if self.m_panel == EPanelType.EMPTY then return end
    if self.m_timer or self.m_mapTween then return end

    self._view.stageOpen:DOComplete()
    self:_StagePanelTimer(self.m_clips[1], function()
        self._view.mapScroll:SetHorizontal(self.m_moveMap)
        self._view.stagePanel:SetActive(false)
    end)
    self._view.stageAnim:Play("MissionStagePanel 0", 0, 0)

    if self.m_stageMove then
        self.m_stageMove = false
        self.m_oriMapPosX = Mathf.Clamp(self.m_oriMapPosX, -self.m_limitX, self.m_limitX)
        self.m_mapTween = self._view.mapBg:SetDoLocalMoveX(self.m_oriMapPosX, 0.5)
        self.m_mapTween:OnTweenComplete(function() self.m_mapTween = nil end)
    end

    self:_SetMissionSelectState(false)

    -- 刷新层级
    local index = 1
    for i = #self.m_pointLst, 1, -1 do
        local item = self.m_pointLst[i]
        item:SetSiblingIndex(index)
        index = index + 1
    end
end

function M:_SetMissionSelectState(isOn)
    self._view.stageClose:SetActive(not isOn)
    self._view.pointMask:SetActive(isOn)
    self._view.stageOpen:SetActive(isOn)

    if not self.m_selectPoint then return end

    self.m_selectPoint:SetSelectState(isOn)

    if isOn then
        self.m_selectPoint:SetParent(self._view.pointMask)
        self.m_panel = EPanelType.INFO
    else
        self.m_selectPoint:SetParent(self.m_mapTrans)
        self.m_panel = EPanelType.EMPTY
        self.m_selectPoint = nil
    end
end

-- 点上一章
function M:OnClickLastChapter(go)
    if self.m_timer or self.m_tween or self.m_mapTween then return end
    self:_ChangeChapter(-1, 600)
end

-- 点下一章
function M:OnClickNextChapter(go)
    if self.m_timer or self.m_tween or self.m_mapTween then return end
    self:_ChangeChapter(1, -600)
end

-- 切换上/下一章节
function M:_ChangeChapter(value, offsetX)
    local maxIdx = #self.m_chapterLst
    local endLeft = (self.m_curCptIdx == 1) and (value < 0)
    local endRigtht = (self.m_curCptIdx >= maxIdx) and (value > 0)

    if endLeft or endRigtht then return end

    self._view.lastChapterNum:SetText(string.format("%02d", self.m_curCptIdx - 1))
    self.m_curCptIdx = Mathf.Clamp(self.m_curCptIdx + value, 1, maxIdx)
    local nextNum = Mathf.Clamp(self.m_curCptIdx + value, 1, maxIdx)
    self._view.nextChapterNum:SetText(string.format("%02d", nextNum - 1))
    local trans = self._view.chapterContent.transform
    local oldPos = trans.localPosition
    local newPos = Vector3.New(oldPos.x + offsetX, oldPos.y, oldPos.z)
    self.m_tween = trans:DOTweenTo(oldPos, newPos, 1)
    self.m_tween:OnTweenComplete(function() self.m_tween = nil end)
    self:OnEnter(self.m_chapterLst[self.m_curCptIdx])
end

function M:_CalculatePointX(localX)
    local x = (self.m_mapWidth / 2) + (localX + 300) -- 在地图长度上的位置
    if x < self.m_screenWidth then x = self.m_screenWidth end
    return x
end

function M:_AccountMapPos(value)
    local x = self:_CalculatePointX(self.m_maxMissionPos)
    self.m_moveMap = x > self.m_screenWidth
    if self.m_jumpPos ~= 0 then x = self:_CalculatePointX(self.m_jumpPos) end
    if self.m_moveMap then x = x - 300 + self.m_limitX end

    local endX = self.m_limitX - (x - self.m_screenWidth) -- 最终位置
    endX = Mathf.Clamp(endX, -self.m_limitX, self.m_limitX)
    self.m_mapTween = self._view.mapBg:SetDoLocalMoveX(endX, value or 0, 12)
    self.m_mapTween:OnTweenComplete(function()
        self.m_mapTween = nil
        if self.m_jumpAction then
            self.m_jumpAction()
            self.m_jumpAction = nil
        end
        self:_CheckItemNote() -- 道具收集目标
    end)

    if value then -- 改一次
        self._view.mapScroll:OffsetMinAndMaxWithNotch()
        self._view.stageAnim:OffsetMinAndMaxWithNotch()
        self:_InitOpenSystem() -- 马上打开会显示异常
    end
    self._view.mapScroll:SetHorizontal(self.m_moveMap)
    if self.m_posTimer then self.m_posTimer = nil end
end

-- 埋点事件
function M:_PlayerAction()
    local mType, backMusic = self.m_chapter.type, self.m_chapter.backMusic
    if mType == EChapterType.ECT_Resource then -- 资源关卡
        self._view.chapterScroll:SetActive(false)
    elseif mType == EChapterType.ECT_Activity then
        self._view.chapterScroll:SetActive(false)
    end

    if backMusic and (backMusic ~= 0) then GameHelper.PlayAudioById(backMusic) end --BGM
end

-- 查找最后一章
function M:_GetEndChapter()
    if self.m_chapter.type == EChapterType.ECT_Main then
        local md = MissionMgr:GetNextMissionData()
        if not md then md = MissionMgr:GetMissionDataById(IPlayerData.missionId) end
        if md then return md:GetChapter() end
        Logger.LogError("关卡进度找不到配置, @四叶看看, id = " .. IPlayerData.missionId)
        return nil -- 关卡配置有可能被删除
    else
        local id = MissionMgr:GetLastHardMissionId()
        local mission = ConfigHelper.GetCfgByLua("mission", id) or {}
        local next = mission.NextMission
        local chapter = next and next.Chapter or nil
        if chapter and GameHelper.CSCheckLockByOpenConditionIds(chapter.openCondition) then return chapter end
        return mission.Chapter
    end
end

function M:_SetPosition(mission)
    local position = mission.position
    if not position or (position.Length < 3) then
        Logger.LogError("position数据缺失, 请询问策划")
        return
    end
    if self.m_jumpMissionId == mission.id then self.m_jumpPos = position[0] end
    self.m_maxMissionPos = Mathf.Max(self.m_maxMissionPos, position[0])
    m_insert(self.m_missionLst, mission)
end

-- 当前章节所有已开放关卡
function M:_GetMissionLst()
    self.m_jumpPos = 0
    self.m_missionLst = {}
    self.m_maxMissionPos = -99999
    local stages = self.m_chapter.stages
    for i = 0, stages.Length - 1 do
        local missionId = stages[i]
        local md = MissionMgr:GetMissionDataById(missionId)
        local mission = md and md:GetMissionCfg() or nil
        if mission then
            if MissionMgr:IsResTeachMission(missionId) then
                m_insert(self.m_missionLst, mission)
            else
                if not md:IsBranch() then -- 非分支,主关卡
                    self:_SetPosition(mission)
                    if not md:IsPass() then break end
                    self:_GetNextMissions(missionId)
                end
            end
        else
            Logger.LogError("mission is nil, @四叶看看, id = " .. missionId)
        end
    end
end

-- 用主关卡查找所有分支关卡
function M:_GetNextMissions(id)
    local cptId = self.m_chapter.id
    for _, md in ipairs(MissionMgr:GetNextMissionsArry(id) or {}) do
        local mission = md:GetMissionCfg()
        if cptId == mission.chapterID then
            self:_SetPosition(mission)
            if MissionMgr:IsMissionPassById(mission.id) then
                self:_GetNextMissions(mission.id)
            end
        end
    end
end

function M:_IsDoubleMission(missionId)
    local double = self.m_doubleData
    -- IsTotalDouble:是否全关卡双倍
    if double:IsTotalDouble() or double:DoubleValue(missionId) then
        return double:RemainTimes() > 0
    end
    return false
end

function M:_GetMissionItem(template, idx)
    local item = self.m_pointLst[idx]
    if not item then
        item = pointCtrl.New(template:Instantiate())
        item:SetClickCllback(self.m_stageHandle)
        m_insert(self.m_pointLst, item)
    end
    item:SetName("PointItem_" .. idx)
    item:SetActive(true)
    return item
end

-- 当前章节所有已开放关卡UI
function M:_SetStagePoints()
    local tempItem, selectItem, missionId, item = self._view.pointItem, nil, nil, nil
    for i, mission in ipairs(self.m_missionLst) do
        missionId, item = mission.id, self:_GetMissionItem(tempItem, i)
        item:SetInfo(mission, self:_IsDoubleMission(missionId))
        if self.m_jumpMissionId == missionId then selectItem = item end
        -- if not isNew then item:SetAnimatorState() end
    end

    for i = #self.m_pointLst, #self.m_missionLst + 1, -1 do
        self.m_pointLst[i]:SetActive(false)
    end

    if selectItem then
        self.m_jumpAction = function()
            coroutine.start(function()
                coroutine.waitforseconds(0.25)
                selectItem:OnClickItem()
            end)
        end
    end

    self.m_jumpMissionId = 0
end

function M:_RefreshStarReward()
    local cfg = self.m_chapter
    local rewards = cfg.starReward
    local awardFlag = self.m_roleChapter.AwardFlag
    local length = cfg.starLimit and cfg.starLimit.Length or 0
    for i = 0, 3 do
        local isActive = i < length
        local name = "starLine" .. (i + 1)
        local starItem = self._view[name]
        starItem:SetActive(isActive)
        if isActive then
            local idx, status = i, awardFlag >> i & 1 -- 0:没领 1：领过
            local itemGroup = ConfigHelper.GetCfg("itemGroup", rewards[i]) or {}
            starItem:SetInfo(status == 1, self.m_getStars, cfg, i)
            starItem:SetItemIcon(itemGroup.items[1])
            starItem:SetClickCallback(function()
                local request = { ChapterId = cfg.id, Idx = idx }
                MissionMgr:GetChapterAward(request, self.m_cptAwardHandler)
            end)
        end
    end
    self._view.chapterStars:SetText(tostring(self.m_getStars))
end

function M:OnShowChapterAward(msg)
    self.m_roleChapter.AwardFlag = self.m_roleChapter.AwardFlag | (1 << msg.Idx)
    self:_RefreshStarReward()
    -- msg is table ,not userdata
    GameHelper.ShowGetItemsByItems(msg.Awards)
    IRedPointMgr:ForceCheck(RedPointConst.ChapterStarRedPointChecker)
end

function M:_DoubleActive()
    self.m_doubleData:Reset()
    -- TODO 获得限时类型 所有进行中的活动配置
    ActivityDataMgr:GetInstance():GetActivitysByTypeAsyn(ActivityType.TIME_LIMIT_PVE, function(datas)
        if datas and #datas > 0 then
            local mType = self.m_chapter.type
            for _, data in ipairs(datas) do
                for _, cfg in ipairs(ConfigHelper.GetCfgsByLua("activityDouble", { activityId = data:ActivityId() }) or {}) do
                    if mType == cfg.chapterType then
                        self.m_doubleData:SetDoubleActivity(data, cfg)
                        -- TODO 定时关闭tag
                        return
                    end
                end
            end
        end
    end)
end

function M:_RefreshChapterScroll()
    self:_RefreshChapterList()
    self._view.chapterScroll:SetDataList(self.m_chapterLst)
    self._view.chapterScroll:SetHorizontalNormalizedByIndex(self.m_curCptIdx)
    self._view.lastChapterBtn:SetActive(self.m_curCptIdx > 1)
    self._view.nextChapterBtn:SetActive(self.m_curCptIdx < #self.m_chapterLst)
    self._view.lastChapterNum:SetText(string.format("%02d", self.m_curCptIdx - 1))
    self._view.nextChapterNum:SetText(string.format("%02d", self.m_curCptIdx + 1))
end

function M:_RefreshChapterList()
    self.m_chapterLst = {}
    local endChapter = self:_GetEndChapter()
    m_insert(self.m_chapterLst, endChapter)
    self:_PushChapterLst(endChapter)

    self.m_curCptIdx = 1
    local cptId = self.m_chapter.id
    for _, k in ipairs(self.m_chapterLst) do
        if k.id == cptId then break end
        self.m_curCptIdx = self.m_curCptIdx + 1
    end
end

-- 从后往前添加找章节列表
function M:_PushChapterLst(cpt)
    local preChapter = cpt and cpt.PrevChapter or nil
    if not preChapter then return end -- cpt配置有可能被删除

    m_insert(self.m_chapterLst, 1, preChapter)
    self:_PushChapterLst(preChapter)
end

function M:_StagePanelTimer(clip, callback)
    self.m_timer = TimerManager:GetInstance():GetTimer(clip.length, function()
        self.m_timer = nil
        if callback then callback() end
    end, self, true)
    self.m_timer:Start()
end

-- 刷新关卡UI的双倍标签
function M:_RefreshItemsDouble()
    if self.m_doubleData:IsDouble() then
        self.m_doubleData:CheckDouble()
        if not self.m_doubleData:IsDouble() then
            for _, ctrl in ipairs(self.m_pointLst) do ctrl:CloseDouble() end
        end
    end
end

function M:OnBattleMopupEnd()
    self:_RefreshItemsDouble()
    self._view.stageCtrl:RefreshDouble()
end

function M:OnCloseStage()
    self:_CloseTween()
    UIContextMgr:GetInstance():Back()
end

function M:_CheckItemNote()
    local eType = EnumConst.NotesWorkType.ItemJump
    local noteData = NotesWorkMgr:GetInstance():GetDataByType(eType)
    if noteData and noteData:IsShowJumpNote() then
        self._view.amountCtrl:SetActive(true)
        self._view.amountCtrl:SetItemInfo(noteData:GetItemId(), noteData:GetTargetNum())
    else
        self._view.amountCtrl:SetActive(false)
    end
end

-- 资源副本活动
function M:_CheckActivityTimes()
    self._view.remainTimes:SetActive(false)
    if self.m_chapter.type == EChapterType.ECT_Resource then
        ActivityDataMgr:GetInstance():GetActivitysByTypeAsyn(ActivityType.RES_ACTIVITY_COPY, function(datas)
            for _, data in ipairs(datas or {}) do
                if data and data:IsOpen() then
                    local id = data:ActivityId()
                    self._view.remainTimes:SetActive(true)
                    self._view.txt_valueR:SetText(tostring(self:_GetMaxActivityTimes(id)))
                    self._view.txt_valueL:SetText(tostring(self:_GetCurActivityTimes(data)))
                    self.m_onActivityUpdate = EventMgr:AddListener(UIMessageNames.ACTIVITY_UPDATE, function(activityId)
                        if not self.m_chapter or (activityId ~= id) then return end
                        local actData = ActivityDataMgr:GetInstance():GetActivityData(id)
                        self._view.txt_valueL:SetText(tostring(self:_GetCurActivityTimes(actData)))
                    end)
                    break
                end
            end
        end)
    end
end

function M:_GetMaxActivityTimes(id)
    for _, cfg in ipairs(ConfigHelper.GetCfgsByLua("activityRes", { activityId = id }) or {}) do return cfg.times end
    Logger.LogError("activityRes is nil, activityId = " .. id)
    return 0
end

-- 已挑战次数
function M:_GetCurActivityTimes(actData)
    for _, v in ipairs(actData:RoleActivity() or {}) do
        if v.SubActivityId == self.m_chapter.id then
            return TimeUtil.IsToday(v.Value1, TimeUtil.DailyRefreshTime) and v.Value0 or 0
        end
    end
    return 0
end

return M
