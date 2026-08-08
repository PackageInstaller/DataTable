---@class BattleStoryPanel : BattleStoryPanel_Generate
---##################### 【BattleStoryPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【BattleStoryPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local BattleStoryPanel = require "BattleStoryPanel_Generate"
local BattleCore = require "BattleCore"

function BattleStoryPanel:InitLogic(data)
    --角色id列表
    self.roleIdList = {}
    --角色对话气泡Obj列表
    self.bubblesObjList = {}
    --角色表情气泡Obj列表
    self.emoteObjList = {}
    --是否可以下一句
    self.isNext = false
    --是否可切换自动播放
    self.canAutoClick = true
    --角色spine对话Timer列表
    self.stopTalkActionTimerList = {}
    --角色spine对话结束回调列表
    self.stopTalkCallbackList = {}
    --是否可以点击跳过按钮
    self.canSkip = false
end

function BattleStoryPanel:InitPanel()
    self._battleMgr = BattleCore:getBattleMgr()
    self._battleStoryMgr = BattleCore:getBattleStoryManager()
	self._showMgr = self._battleStoryMgr._showMgr

    self.speakBubble:SetActive(false)
    self.speakEmote:SetActive(false)
    self.endCurtain:SetActive(false)
    self.endCurtain.image:DOFade(0,0)

    --根据角色进行预处理
    self:creatSpeakObj(self.roleIdList)
    --初始化自动播放UI动画
    self.round.animator.speed = 0
    --根据是否编辑器模式设置显示状态
    if self._battleStoryMgr:getEditorMode() then
        self.autoBtn:SetActive(false)
        self.doNextBtn:SetActive(false)
        self.skipBtn:SetActive(false)
    else
        self.autoBtn:SetActive(true)
        self.doNextBtn:SetActive(true)
        --设置跳过按钮
        self.skipBtn:SetActive(self._battleStoryMgr.canSkip)
    end
end

function BattleStoryPanel:Update()

    self:speakFollow()

end

--function BattleStoryPanel:StartCreating(time)
--
--end

--function BattleStoryPanel:StartEnter(time)
--
--end

--function BattleStoryPanel:StartRemoving(time)
--
--end

--function BattleStoryPanel:StartExit(time)
--
--end

function BattleStoryPanel:OnOpen(data, initiative)
    if initiative then
        self.roleIdList = data and data.roleIdList
        self.openFunc = data and data.openFunc
        self:InitPanel()
    end
    
end

--对话气泡跟随角色
function BattleStoryPanel:speakFollow()
    for roleId, bubblesData in pairs(self.emoteObjList) do
        local role = self._showMgr:getRole(roleId)
        if not role then
            return
        end
        local UICamera = UIMgr.uiCamera
        local sreenPoint = self._showMgr.cameraObj:GetComponent(typeof(UnityEngine.Camera)):WorldToScreenPoint(role.speakPoint.transform.position)
        local _,screenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(
            UIMgr.uiCanvas:GetComponent(TypeInfo.RectTransform), Vector2.New(sreenPoint.x, sreenPoint.y), UICamera, nil)

        local emoteObj = self.emoteObjList[roleId]
        emoteObj.transform.localPosition = screenPos
    end
end

--角色对话
function BattleStoryPanel:doSpeakBubblesData(actionData)
    local roleId = actionData.target--角色cid
    local bubbleType = actionData.parameter1 and tonumber(actionData.parameter1) or GE.SpeakBubbleType.Big--气泡框格式
    local locationData = actionData.parameter2 and loadstring("return " .. actionData.parameter2)() or {1, 0}--对话气泡位置
    local offset = actionData.parameter3 and loadstring("return " .. actionData.parameter3)() or {0, 0}--对话框偏移量
    local words = actionData.parameter4--对话内容
    local emoteHead = actionData.parameter5 or "idle_talk"--spine表情
    local speakName = actionData.parameter6--说话人
    local bubblesObj = self.bubblesObjList[roleId].bubblesObj
    local spineObj = self.bubblesObjList[roleId].spineObj

    --根据格子类型显示不同大小的气泡框
    bubblesObj.bubbleBg.image.enabled = bubbleType == GE.SpeakBubbleType.Big
    bubblesObj.bubbleMiddle:SetActive(bubbleType == GE.SpeakBubbleType.Middle)
    if bubbleType == GE.SpeakBubbleType.Big then
        bubblesObj.wordsTxt.rectTransform.sizeDelta = Vector2.New(663, 121.7)
    elseif bubbleType == GE.SpeakBubbleType.Middle then
        bubblesObj.wordsTxt.rectTransform.sizeDelta = Vector2.New(515, 121.7)
    end

    --根据位置配置设计父节点
    local location = locationData[1]
    if UICommonUtils.Checkobj(bubblesObj["rootPos"..location]) then
        bubblesObj.bubbleBg.transform:SetParent(bubblesObj["rootPos"..location].transform)
        bubblesObj.bubbleBg.transform.localPosition = Vector3.zero
        --对话框Y轴偏移量
        local baseBubble = self.speakBubble
        local baseX = baseBubble["rootPos"..location].rectTransform.anchoredPosition.x
        local baseY = baseBubble["rootPos"..location].rectTransform.anchoredPosition.y
        bubblesObj["rootPos"..location].rectTransform.anchoredPosition = Vector2.New(baseX + offset[1], baseY + offset[2])
    end

    --spine翻转
    local isFlip = locationData[2] == 1
    local spinePos = spineObj.transform.localPosition
    local headPointPos = spineObj.transform:Find("HeadPoint").transform.localPosition
    if isFlip then
        spineObj.transform.localRotation = Quaternion.Euler(0, 180, 0)
        spineObj.transform.localPosition = Vector3.New(headPointPos.x, spinePos.y, spinePos.z)
    else
        spineObj.transform.localRotation = Quaternion.Euler(0, 0, 0)
        spineObj.transform.localPosition = Vector3.New(-headPointPos.x, spinePos.y, spinePos.z)
    end

    --根据位置配置修改气泡内容框位置
    local newVect2
    if location % 2 == 0 then
        local needPos = bubblesObj.headIconFrame.rectTransform.anchoredPosition
        bubblesObj.headIconFrame.rectTransform.anchoredPosition = Vector2.New(math.abs(needPos.x), needPos.y)
        needPos = bubblesObj.wordsRoot.rectTransform.anchoredPosition
        bubblesObj.wordsRoot.rectTransform.anchoredPosition = Vector2.New(-math.abs(needPos.x), needPos.y)
        needPos = bubblesObj.nameBg.rectTransform.anchoredPosition
        bubblesObj.nameBg.rectTransform.anchoredPosition = Vector2.New(-math.abs(needPos.x), needPos.y)
        newVect2 = Vector2.New(1, 0.5)
    else
        local needPos = bubblesObj.headIconFrame.rectTransform.anchoredPosition
        bubblesObj.headIconFrame.rectTransform.anchoredPosition = Vector2.New(-math.abs(needPos.x), needPos.y)
        needPos = bubblesObj.wordsRoot.rectTransform.anchoredPosition
        bubblesObj.wordsRoot.rectTransform.anchoredPosition = Vector2.New(math.abs(needPos.x), needPos.y)
        needPos = bubblesObj.nameBg.rectTransform.anchoredPosition
        bubblesObj.nameBg.rectTransform.anchoredPosition = Vector2.New(math.abs(needPos.x), needPos.y)
        newVect2 = Vector2.New(0, 0.5)
    end

    bubblesObj.bubbleMiddle.transform.pivot = newVect2
    bubblesObj.bubbleMiddle.transform.anchorMax = newVect2
    bubblesObj.bubbleMiddle.transform.anchorMin = newVect2
    bubblesObj.wordsTxt.transform.pivot = newVect2
    bubblesObj.wordsTxt.transform.anchorMax = newVect2
    bubblesObj.wordsTxt.transform.anchorMin = newVect2

    --显示姓名及对话
    bubblesObj.nextArrow:SetActive(false)
    if bubblesObj.canvasGroup.alpha == 0 then
        bubblesObj.canvasGroup:DOFade(1, 0.2)
    end
    bubblesObj.wordsTxt.text.text = ""
    bubblesObj.nameText.text.text = speakName or ""

    local wordsDelayTime = #words/3 *0.05
    self.text_tweener = bubblesObj.wordsTxt.text:DoTextMesh(words, wordsDelayTime, function()
        bubblesObj.nextArrow:SetActive(true)
        self.text_tweener = nil
        self.isNext = true
        self._battleStoryMgr:setRoleSpeakAutoList(roleId, nil)
    end)

    --角色表情口型
    self:_RemoveStopTalkTimer()
    local objSpine = spineObj:GetComponent("SkeletonGraphic")
    local spineAnimation = objSpine:GetComponent("SetSpineAnimation")
    local objSpineAnim = objSpine:GetComponent("SkeletonAnimation")

    local actionName = emoteHead and string.find(emoteHead, "action") and emoteHead
    local nowActionName = ""
    local currentAnimation = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Action)
    if currentAnimation then
        nowActionName = currentAnimation.Animation.Name
        if actionName and nowActionName ~= actionName then
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Action, actionName, true)
        end
    else
        nowActionName = actionName or "idle_action"
        objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Action, nowActionName, true)
    end

    local emoteName = emoteHead
    local nowEmoteName = "idle_talk"
    currentAnimation = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote)
    if currentAnimation then
        local currentAnimationName = currentAnimation.Animation.Name
        nowEmoteName = string.find(currentAnimationName, "_talk") and currentAnimationName or currentAnimationName.."_talk"
    end
    nowEmoteName = emoteName or nowEmoteName
    objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, nowEmoteName, true)

    self.stopTalkActionTimerList[spineObj.name] = DLuaTimer:DoAfter(wordsDelayTime * 4, function()
        if not objSpine then
            return
        end
        local nowEmoteName = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote).Animation.Name
        local nameBreakList = {}
        local newEomteName = ""
        string.gsub(nowEmoteName,'[^'.."_"..']+',function ( w )
            table.insert(nameBreakList, w)
        end)
        if #nameBreakList > 1 then
            newEomteName = nameBreakList[1]
        end
        if newEomteName ~= "" and nowEmoteName ~= newEomteName and spineAnimation:CheckAnimationExist(newEomteName) then
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, newEomteName, true)
        end
    end)
    self.stopTalkCallbackList[spineObj.name] = function()
        local nowEmoteName = objSpineAnim.AnimationState:GetTrack(GE.RoleSpineActionType.Emote).Animation.Name
        local nameBreakList = {}
        local newEomteName = ""
        string.gsub(nowEmoteName,'[^'.."_"..']+',function ( w )
            table.insert(nameBreakList, w)
        end)
        if #nameBreakList > 1 then
            newEomteName = nameBreakList[1]
        end
        if newEomteName ~= "" and nowEmoteName ~= newEomteName and spineAnimation:CheckAnimationExist(newEomteName) then
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, newEomteName, true)
        end
    end

    --战中模式则调用镜头跟随方法
    if self._battleMgr:getBattleState() ~= GE.BattleState.PlayStory then
        local role = self._showMgr:getRole(roleId)
        self._showMgr:setFollowTarget(role.root.transform, GE.FollowTargetType.Move)
    end
end

--角色气泡表情
function BattleStoryPanel:doSpeakEmoteData(actionData)
    local emoteObj = self.emoteObjList[actionData.roleId]
    emoteObj:SetActive(true)
    local objSpine = emoteObj.emoteSpine.skeletonGraphic
    local objSpineAnim = emoteObj.emoteSpine.skeletonAnimation
    objSpineAnim.AnimationState:SetAnimation(0, "pop up", false)
    local startTime = objSpine.Skeleton.Data:FindAnimation("pop up").Duration
    objSpineAnim.AnimationState:AddAnimation(0, actionData.emoteName, false, startTime)
    local showTime = objSpine.Skeleton.Data:FindAnimation(actionData.emoteName).Duration

    DLuaTimer:DoAfter(startTime + showTime, function()
        if UICommonUtils.Checkobj(emoteObj) then
            emoteObj:SetActive(false)
        end
    end)
    return startTime + showTime
end

--结束演出
function BattleStoryPanel:doEndStory(endData)
    --编辑器模式不退出
    if self._battleStoryMgr:getEditorMode() then
        return
    end

    local endType = endData.parameter1--黑屏模式
    if self.endCurtain.activeSelf then
        return
    end
    self.endCurtain:SetActive(true)
    self._showMgr:setFollowTarget(nil)
    self:_RemoveStopTalkTimer()

    --将故事角色位置传递给battleshowMgr，供共用模型逻辑使用
    if not StoryMgr:getIsHomeLandStory() then
        self._showMgr:setStoryRoleBlockIdList(self._battleStoryMgr.roleBlockIdList)
    end

    local doEndFunc = function()
        --判断是否有多段剧情，有的话播放下一段
        local haveNextArray = self._battleStoryMgr:checkAndDoNextArray()
        if haveNextArray then
            return
        end
        --正常情况
        --self._battleMgr:clear()
        if StoryMgr:getIsHomeLandStory() then
			self._showMgr:_removeAllRole()
	    	self._showMgr.rolesMap = {}
            local homeLvUpSkipCallback = StoryMgr:getHomeLvUpSkipCallback()
            if homeLvUpSkipCallback then
                homeLvUpSkipCallback()
            end
		end
        local endCallback = self._battleStoryMgr:getEndCallbackFunc()
        if endCallback then
            endCallback()
        else
            StateMgr:ChangeToState(GameFlowState.GameState)
            self._battleStoryMgr:clear()
        end
        --self._showMgr:initScreen()
        -- self._battleStoryMgr:clear()
    end
    if endType == "fade" then
        self.endCurtain.image:DOFade(1,2)
        self:DoAfter(2, function()
            doEndFunc()
        end)
    elseif endType == "black" then
        self.endCurtain.image:DOFade(1, 0)
        self:DoAfter(0.5, function()
            doEndFunc()
        end)
    elseif endType == "end" then--直接结束(战中使用)
        --dotween移动镜头
        self._showMgr:initScreen({time = 1}, function()
            local endCallback = self._battleStoryMgr:getEndCallbackFunc()
            if endCallback then
                endCallback()
            end
            self._battleStoryMgr:clear()
        end)
    end
end

--加载角色对话气泡相关Obj
function BattleStoryPanel:creatSpeakObj(idList)
    if not next(idList) then
        if self.openFunc then
            self.openFunc()
        end
        self.canSkip = true
        return
    end
    self:FillTemplateContent(self.speakBubble, self.speakBubblesList, #idList, function (index,speakBubble)
        local roleId = idList[index]
        speakBubble.canvasGroup.alpha = 0
        speakBubble.name = "speakBubbles"..roleId
        self.bubblesObjList[roleId] = {}
        self.bubblesObjList[roleId].bubblesObj = speakBubble

        local roleCid = 0
        if self._battleStoryMgr:getDialogMode() then
            local roleMgr = self._battleMgr:getRoleManager()
            roleCid = roleMgr:getRole(roleId) and roleMgr:getRole(roleId).cid or 0
        else
            roleCid = roleId
        end
        local storyResConfig = Config.GetStoryResourceInfo(roleCid)
        if not storyResConfig then
            return--没有配置说明用不到这个spine
        end
        local resPath = ""
        if storyResConfig.camp == GE.StoryResourceCamp.Role then
            resPath = Config.PrefabPath.RoleSpine
        elseif storyResConfig.camp == GE.StoryResourceCamp.Enemy then
            resPath = Config.PrefabPath.RoleSpine
        elseif storyResConfig.camp == GE.StoryResourceCamp.NPC then
            resPath = Config.PrefabPath.RoleSpine
        end
        local prefabPath = string.format(resPath, storyResConfig.name, storyResConfig.name)
        self:LoadInstantiatePrefab(prefabPath, function (obj)
            local spineObject = obj
            spineObject:SetParent(speakBubble.roleRoot.transform)
            self.bubblesObjList[roleId].spineObj = spineObject

            local headPointPos = spineObject.transform:Find("HeadPoint").transform.localPosition
            spineObject.transform.localPosition = Vector3.New(-headPointPos.x, -headPointPos.y, 0)

            --剧情关闭spine物理效果
            local objSpine = spineObject:GetComponent("SkeletonGraphic")
            objSpine.PhysicsPositionInheritanceFactor = Vector2.zero
        end)
    end)

    self:FillTemplateContent(self.speakEmote, self.speakEmoteList, #idList, function (index,speakEmote)
        local roleId = idList[index]
        speakEmote:SetActive(false)
        speakEmote.name = "speakEmote"..roleId
        self.emoteObjList[roleId] = {}
        self.emoteObjList[roleId] = speakEmote
        if index == #idList then
            if self.openFunc then
                self.openFunc()
            end
            self.canSkip = true
        end
    end)
end

--自动播放动画
function BattleStoryPanel:autoPlayAnimation(isAuto)
    local autoValue = isAuto and 1 or 0
    local autoScale = isAuto and -1 or 1
    self.round.animator.speed = autoValue
    self.autoChange.transform:DOScale(Vector3.New(0,1,1), 0.15):OnComplete(function()
        self.unAuto.canvasGroup.alpha = 1 - autoValue
        self.doAuto.canvasGroup.alpha = autoValue
        self.autoChange.transform:DOScale(Vector3.New(autoScale,1,1), 0.15):OnComplete(function()
            self.canAutoClick = true
        end)
    end)
end

--外部控制是否可以进行下一句方法
function BattleStoryPanel:setCanNextClick(bool)
    self.isNext = bool
end

--移除停止对话Timer
function BattleStoryPanel:_RemoveStopTalkTimer()
    if next(self.stopTalkActionTimerList) then
        for name, timer in pairs(self.stopTalkActionTimerList) do
            DLuaTimer:RemoveTimer(timer)
        end
    end
end

--停止说话表情
function BattleStoryPanel:_StopRoleTalk()
    self:_RemoveStopTalkTimer()
    for _, endFunc in pairs(self.stopTalkCallbackList) do
        endFunc()
    end
    self.stopTalkCallbackList = {}
end

--function BattleStoryPanel:OnClose(initiative)
--
--end

--function BattleStoryPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function BattleStoryPanel:OnRefresh(data)
--
--end

--[[
/SkipBtn onClick 
--]]
function BattleStoryPanel:skipBtn_ScaleButton_onClick(skipBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.endCurtain.activeSelf then
        return
    end
    if not self.canSkip then
        return
    end
    self.canSkip = false
    --清空当前播放的剧情片段
    self._battleStoryMgr:clearNowPlayCut()
    --跳过剧情时清空场中人物数据，重新加载
    if self._battleStoryMgr:getDialogMode() then
        for roleId, blockId in pairs(self._battleStoryMgr.roleBlockIdList) do
            if self._battleStoryMgr.dialogRoleList[roleId] then
                self._showMgr:roleRemove({id = roleId})
            end
        end
    else
        --需要重置层级为role
        if not StoryMgr:getIsHomeLandStory() then
            self._showMgr:showAllRole()
        end
        self._showMgr:_removeAllRole()
	    self._showMgr.rolesMap = {}
    end
    self._battleStoryMgr.roleBlockIdList = {}
    self:_StopRoleTalk()

    local data = {
        parameter1 = "fade",
    }
    self:doEndStory(data)
end

--[[
/DoNextBtn onClick 
--]]
function BattleStoryPanel:doNextBtn_Button_onClick(doNextBtn)
    if self.isNext then
        self.isNext = false
        self._battleStoryMgr:DoPlayOneCut()
    else
        if self.text_tweener ~= nil then
			self.text_tweener:Complete(true)
		end
    end
end

--[[
/AutoBtn onClick 
--]]
function BattleStoryPanel:autoBtn_ScaleButton_onClick(autoBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.canAutoClick = false
    if self.doNextBtn.button.enabled then
        self.doNextBtn.button.enabled = false
    else
        self.doNextBtn.button.enabled = true
    end
    self._battleStoryMgr:ChangeAutoPlay()
    self:autoPlayAnimation(not self.doNextBtn.button.enabled)
end

return BattleStoryPanel
