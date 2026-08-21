local M = BaseClass("StoryUICtrl", BaseUICtrl)
local CheckTbl = table.isNullOrEmpty
local CheckStr = string.isNullOrEmpty
local StoryType = StoryConst.StoryType
local ResponseType = StoryConst.ResponseType

function M:Init()
    self.m_musicId = nil
    self.m_animPath = nil
    self.m_pauseTimer = nil

    local scmHandler = Bind(self, self.OnStoryCallMain)
    local refHandler = Bind(self, self.OnStoryRefresh)
    local visHandler = Bind(self, self.OnStoryVisible)
    self.m_nextHandler = Bind(self, self.OnNextStory)
    self.m_voiceEndHandler = Bind(self, self.OnVoiceComplete)
    self._view.ctrlCmd:SetBgRaycastCallback(Bind(self, self.OnSetBgRaycast))
    self.m_refreshEvent = EventMgr:AddListener(UIMessageNames.STORY_REFRESH, refHandler)
    self.m_visibleEvent = EventMgr:AddListener(UIMessageNames.STORY_VISIBLE, visHandler)
    self.m_callMainEvent = EventMgr:AddListener(UIMessageNames.STORY_CALL_MAIN, scmHandler)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.STORY_REFRESH, self.m_refreshEvent)
    EventMgr:RemoveListener(UIMessageNames.STORY_VISIBLE, self.m_visibleEvent)
    EventMgr:RemoveListener(UIMessageNames.STORY_CALL_MAIN, self.m_callMainEvent)

    self:_StopPause()
    self.m_musicId = nil
    self.m_animPath = nil
    self.m_nextHandler = nil
    self.m_refreshEvent = nil
    self.m_visibleEvent = nil
    self.m_callMainEvent = nil
    self.m_voiceEndHandler = nil
    UIContextMgr:GetInstance():Close("StorySkip")

    M.super.OnDispose(self)
end

function M:OnEnter(storyCfg)
    self:OnStoryRefresh(storyCfg)
end

function M:OnStoryRefresh(storyCfg)
    if storyCfg.pointId > 0 then IBuriedPointDataMgr:SubmitStoryData(storyCfg.groupId, 0, storyCfg.pointId) end

    self:OnStoryVisible(storyCfg)
    self:_StoryRefresh(storyCfg)
end

function M:OnSetBgRaycast(value)
    self._view.ctrlBase:SetBgRaycastEnable(value)
end

function M:OnVoiceComplete()
    StoryDataMgr:GetInstance():SetVoiceComplete(true)

    local storyCfg = StoryDataMgr:GetInstance():GetStory()
    if not storyCfg or storyCfg.commanderType ~= ResponseType.None then return end
    local mType = storyCfg.storyType
    if mType == StoryType.Interact or mType == StoryType.RoleIntro then return end
    if StoryDataMgr:GetInstance():IsAuto() and CheckTbl(storyCfg.guide) then
        if not StoryDataMgr:GetInstance():IsAsideOrNoVoice() then -- 非旁白或者有声音，其它在StoryNextCtrl
            StoryDataMgr:GetInstance():NextStoryDelay(0.5)
        end
    end
end

function M:OnNextStory()
    self:_StopPause()
    StoryDataMgr:GetInstance():NextStory()
end

function M:OnStoryVisible(storyCfg)
    self._view.ctrlBase:RefreshBgVisible(storyCfg)
    self._view.ctrlCmd:SetRaycasterVisible(storyCfg)
    self._view.ctrlNext:RefreshNextVisible(storyCfg)
    self._view.ctrlTop:RefreshTopBarVisible(storyCfg)
end

function M:_DestoryEffect(trans)
    local storyCfg = StoryDataMgr:GetInstance():GetStory()
    if CheckStr(storyCfg.animPath) then
        self.m_animPath = ""
        for i = 0, trans.childCount - 1 do
            GameUtil.DestroyGo(trans:GetChild(i).gameObject)
        end
    end
end

-- 闪屏时间:[1] = 淡入时间,[2] = 持续时间,[3] = 淡出时间
function M:_SetBlink(storyCfg)
    -- 淡入时间，持续时间，淡出时间
    local blinkDuration = storyCfg.blinkDuration
    if not CheckTbl(blinkDuration) then
        local fadeTime, durTime, outTime = blinkDuration[1], blinkDuration[2], blinkDuration[3]
        if fadeTime ~= -1 then self._view.imgBlink:SetColorTo16(storyCfg.blinkColor) end
        local fadeInDuration = (fadeTime > 0) and (fadeTime / 1000) or fadeTime
        local fadeOutDuration = outTime > 0 and outTime / 1000 or outTime
        local interval = durTime > 0 and durTime / 1000 or durTime
        local value = 1
        if #blinkDuration >= 4 then value = blinkDuration[4] / 100 end
        self._view.imgBlink:SetBlink(fadeInDuration, fadeOutDuration, interval, value)
    end
end

--播放声音和背景音乐
function M:_PlayVoiceAndMusic(storyCfg)
    if not StoryDataMgr:GetInstance():IsFast() then
        local voiceId = storyCfg.voice
        if voiceId > 0 then
            if voiceId == 30208 then
                GameHelper.PlayAudioById(voiceId)
            else
                GameHelper.PlaySoundReturnObjById(voiceId, self.m_voiceEndHandler)
            end
        end
        StoryDataMgr:GetInstance():SetVoiceComplete(false, 0.1)
    end

    if storyCfg.sfx > 0 then -- 音效
        GameHelper.PlayAudioById(storyCfg.sfx)
    end

    local musicId = storyCfg.music
    if musicId > 0 then -- 背景音乐
        if self.m_musicId ~= musicId then
            self.m_musicId = musicId
            GameHelper.PlayAudioById(musicId)
        end
    end
end

--判定自动跳过逻辑
--同时满足以下条件则会在一定时间后自动跳过
-- 1、comanderType 和 roleTalk 等于 0
-- 2、storyType = Dailogue 或  Sam 或  Effect
function M:_SetAutoNext(storyCfg)
    if (storyCfg.commanderType == ResponseType.None) and (storyCfg.roleTalk == 0) then
        local mType = storyCfg.storyType
        if (mType == StoryType.Dialogue) or (mType == StoryType.Sam) or (mType == StoryType.Effect) then
            self:_SetPause(storyCfg)
        end
    end
end

function M:_SetPause(storyCfg)
    local duration = StoryHelper.GetPauseDuration(storyCfg)
    self.m_pauseTimer = TimerManager:GetInstance():GetTimer(duration, self.m_nextHandler, self, true, nil, true)
    self.m_pauseTimer:Start()
end

function M:_StopPause()
    if self.m_pauseTimer then
        self.m_pauseTimer:Stop()
        self.m_pauseTimer = nil
    end
end

function M:_ShowEffectStory(storyCfg)
    local path = storyCfg.animPath
    if path ~= self.m_animPath then
        local go = self:_InstanceGo(path, storyCfg.effectPosition)
        go:SetEffectsLayer()
        go:SetEffectsUnscaledDelta()
        self.m_animPath = path
    end
end

--设置剧情表现形式类型
function M:_SetStoryType(storyCfg)
    local mType = storyCfg.storyType
    if mType == StoryType.Background then
        self._view.ctrlNext:ShowBlackStory(storyCfg.roleTalk)
    elseif mType == StoryType.Sam then
        self._view.ctrlNext:ShowSamStory(storyCfg.roleTalk)
    elseif mType == StoryType.Interact then
        UIContextMgr:GetInstance():Show("StoryInteract")
    elseif mType == StoryType.Video then
        self._view.ctrlBase:ShowInteractVideoStory(storyCfg)
    elseif mType == StoryType.Effect then
        self:_ShowEffectStory(storyCfg)
    elseif mType == StoryType.RoleIntro then
        UIContextMgr:GetInstance():Show("StoryRoleIntro", storyCfg)
    end
end

function M:_ShowCommanderResponse(storyCfg)
    local cmdType = storyCfg.commanderType
    if cmdType == ResponseType.None then
        self:_AddStoryReviewList(storyCfg)
    elseif (cmdType == ResponseType.Selection) then
        self._view.ctrlCmd:ShowSelections(storyCfg)
    elseif cmdType == ResponseType.RoleEffect then
        self._view.ctrlCmd:ShowRoleEffect(storyCfg)
    elseif cmdType == ResponseType.BgEffect then
        self._view.ctrlCmd:ShowBgEffects(storyCfg)
    elseif cmdType == ResponseType.RoleMagnifier then
        self._view.ctrlCmd:ShowRoleMagnifiers(storyCfg)
    elseif cmdType == ResponseType.AnimSeries then
        self._view.ctrlCmd:ShowAnimSeries(storyCfg.animPath)
    elseif cmdType == ResponseType.AnimParallel then
        self._view.ctrlCmd:ShowAnimParallel(storyCfg.animPath)
    elseif cmdType == ResponseType.AnimSwipe then
        self._view.ctrlCmd:ShowAnimSwipe(storyCfg.animPath)
    elseif cmdType == ResponseType.Gift then
        self._view.ctrlCmd:ShowGiftStory(storyCfg)
    elseif cmdType == ResponseType.AnimAuto then --大鹏：9是道具可获得，10是道具无法获得，都需要配置reward字段道具和rewardDec字段
        self._view.ctrlCmd:ShowAnimAuto(storyCfg)
    elseif cmdType == ResponseType.Video then
        self._view.ctrlBase:ShowVideoStory(storyCfg.animPath)
    elseif cmdType == ResponseType.Fire then
        self:_ShowFire(storyCfg)
    end
end

function M:_StoryRefresh(storyCfg)
    self:_DestoryEffect(self._view.effPanel.transform)
    self:_PlayVoiceAndMusic(storyCfg) --因为黑屏也要播放声音
    self:_SetStoryType(storyCfg)

    if storyCfg.storyType == StoryType.Background then return end

    self:_ShowCommanderResponse(storyCfg)
    self._view.ctrlBase:RefreshBgInfo(storyCfg)
    self._view.ctrlNext:SetGuide(storyCfg.guide)
    self:_SetBlink(storyCfg)
    self:_SetAutoNext(storyCfg)
end

function M:_AddStoryReviewList(storyCfg)
    if storyCfg.roleTalk > 0 then
        local mType = storyCfg.storyType
        StoryDataMgr:GetInstance():AddReviewStory(storyCfg)
        if (mType ~= StoryType.Sam) and (mType ~= StoryType.Background) then
            self._view.ctrlNext:ShowDialogue(storyCfg)
        end
    end
end

function M:_ShowFire(storyCfg)
    local go = self:_InstanceGo(storyCfg.animPath, storyCfg.effectPosition)
    go:onClick(function()
        GameUtil.DestroyGo(go) -- 只有一个开枪特效
        StoryDataMgr:GetInstance():CmdResponseDialogue(storyCfg, 1)
    end)
end

function M:_InstanceGo(path, effectPos)
    local go = ResourceManager:GetInstance():InstanceGameObject(path)
    go.transform:SetParent(self._view.effPanel.transform, false)
    if CheckTbl(effectPos) then
        go.transform.localPosition = Vector3.zero
    else
        local x, y = effectPos[1] / 1000, effectPos[2] / 1000
        go.transform:SetRectLocalPoint(self._view.effPanel, x, y)
    end
    return go
end

function M:OnStoryCallMain(funcName, ...)
    self[funcName](self, ...)
end

function M:OnClickBackground()
    local storyCfg = StoryDataMgr:GetInstance():GetStory()
    local mType = storyCfg.storyType
    if not self._view.ctrlBase:GetSkipActive() and (mType == StoryType.Video) then
        if storyCfg.isVideoLoop == StoryConst.IsVideoLoop.Off then
            self._view.ctrlBase:SetSkipActive(true)
            self._view.ctrlBase:SetBgRaycastEnable(false)
            return
        end
    end

    if (mType == StoryType.Dialogue) or (mType == StoryType.Sam) then
        if not self._view.ctrlTop:GetHideBtnState() and CheckStr(storyCfg.spinePath) then
            EventMgr:Broadcast(UIMessageNames.STORY_VISIBLE, storyCfg)
            return
        end
    end

    if self._view.ctrlTop:StopAutoState() then return end
    if self._view.ctrlTop:StopFastState() then return end
    if self._view.ctrlNext:CloseKeyword() then return end

    self._view.ctrlNext:NextStoryDialogue(storyCfg)
end

function M:SetNextDialogueActive(active)
    self._view.ctrlNext:SetDialogueActive(active)
end

function M:SetNextSamActive(active)
    self._view.ctrlNext:SetSamActive(active)
end

return M
