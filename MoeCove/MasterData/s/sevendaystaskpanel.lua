---@class SevenDaysTaskPanel : SevenDaysTaskPanel_Generate
---##################### 【SevenDaysTaskPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SevenDaysTaskPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SevenDaysTaskPanel = require "SevenDaysTaskPanel_Generate"
local Random = require "Random"

-- 测试版本临时隐藏 RoleInfoBg，避免刷新/动画再次显示
local HIDE_ROLE_INFO_BG = true

function SevenDaysTaskPanel:forceHideRoleInfoBg()
    if not UICommonUtils.Checkobj(self.roleInfoBg) then
        return
    end
    self.roleInfoBg.rectTransform:DOKill()
    self.roleInfoBg.canvasGroup:DOKill()
    self.roleInfoBg.canvasGroup.alpha = 0
    self.roleInfoBg:SetActive(false)
end

function SevenDaysTaskPanel:InitLogic(data)
    self.nowSelectDay = 1
    self.dayboxList = {}
    self.nowRoleBox = nil --当前角色格子
    self.nowShowSpineObj = nil
    self.nextRoleBox = nil --下一个角色格子
    self.nextShowSpineObj = nil
    self.nowShowCharacterId = nil
    self.roleInfoBgOriginPos = nil
    self.isCharSwitching = false
    self._spineLoadVersion = {}
end

---检查七日任务功能是否开放
---@param showToast boolean? 是否弹出提示，默认true
---@return boolean
function SevenDaysTaskPanel:checkSevenDayTaskOpen(showToast)
    local state, tips = UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.SevenDayTask)
    if state == GE.FunctionOpenState.Lock then
        if showToast ~= false then
            UICommonUtils.PopToast(tips)
        end
        return false
    end
    return true
end

---领取七日任务奖励
---@param idList integer[]
---@param callback function
function SevenDaysTaskPanel:requestMissionReward(idList, callback)
    if not self:checkSevenDayTaskOpen() then
        return
    end
    Me:GetMissionRewardReq(idList, callback)
end

--function SevenDaysTaskPanel:StartCreating(time)
--
--end

--function SevenDaysTaskPanel:StartEnter(time)
--
--end

--function SevenDaysTaskPanel:StartRemoving(time)
--
--end

--function SevenDaysTaskPanel:StartExit(time)
--
--end

function SevenDaysTaskPanel:OnOpen(data, initiative)
    if not self:checkSevenDayTaskOpen() then
        UIMgr:closeUI(self)
        return
    end
    self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.SevenDaysTaskPanel)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
        UIMgr:closeUI(self)
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)
    self:forceHideRoleInfoBg()
    self:RefreshView()
    self:initShowRoleBox()
end

---刷新界面
function SevenDaysTaskPanel:RefreshView()
    self:refreshDayButtons()
    self:refreshTaskList()
    self:pointTaskView()
end

---计算分段进度（用于非线性刻度的进度条）
---@param point number 当前积分
---@return number 进度条的值（0-1之间）
function SevenDaysTaskPanel:calculateSegmentedProgress(point)
    if point <= 0 then
       return 0 
    end
    local c = {
       {0, 0}, {80, 0.195},{160,0.385},{300, 0.58},{500, 0.77},{800, 0.96}
    }
    local max = c[#c][1]
    if point >= max then
       return 1 
    end
    local index = 0
    for i = 1, #c do
        local cfg = c[i]
        if point <= cfg[1] then
           index = i - 1
           break
        end
    end
    if index == 0 then
        return 0    
    end
    local minCfg = c[index]
    local maxCfg = c[index + 1]
    local valLen = maxCfg[1] - minCfg[1] 
    local vp = (point - minCfg[1]) / valLen
    local p = minCfg[2] + (maxCfg[2] - minCfg[2]) * vp
    return p 
end

---刷新天数按钮列表
function SevenDaysTaskPanel:refreshDayButtons()
    self.dayboxList = {}
    local nowDays = Me:getRegisteredDayCount()
    self:FillTemplateContent(self.dayBox, self.dayList, 7, function(index, dayBox)
        dayBox:SetActive(true)
        local isLock = index > nowDays
        dayBox.bgTxt.text.text = string.format("第%d天", index)
        dayBox.txt.text.text = string.format("第%d天", index)
        dayBox.isOn:SetActive(index == self.nowSelectDay)
        dayBox.isLock:SetActive(isLock)
        dayBox.btn.scaleButton.onClick:RemoveAllListeners()
        dayBox.btn.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, "click"))
            if isLock then
                return
            end

            if index == self.nowSelectDay then
                return
            end

            self.nowSelectDay = index
            self:refreshDayButtons()
            self:refreshTaskList()
        end)
  
        self.dayboxList[index] = dayBox
        if index == 7 then
            self:refreshRedPoint()
        end
    end)
end

--刷新任务列表(根据当前选择的天数)
function SevenDaysTaskPanel:refreshTaskList()
    local taskList = Config.GetTaskInfoByTaskTypeGroupType(GE.MissionType.SevenDayTask, GE.SevenDayTaskType.SevenDayCommon, self.nowSelectDay)
    if taskList then
        table.sort(taskList, function(a, b)
            local aData = Me:getMissionListById(a.id)
            local bData = Me:getMissionListById(b.id)
            if aData.state ~= bData.state then
                return aData.state < bData.state
            end
            return a.id < b.id
        end)
    end

    -- 收集可领取的任务ID列表（只收集当前天数的任务）
    self.canGetTaskIds = {}
    if taskList then
        for _, taskCfg in pairs(taskList) do
            -- 再次确认任务属于当前天数
            if taskCfg.type == self.nowSelectDay then
                local taskData = Me:getMissionListById(taskCfg.id)
                if taskData and taskData.state == GE.MissionState.Unclaimed then
                    table.insert(self.canGetTaskIds, taskData.id)
                end
            end
        end
    end
    
    -- 根据是否有可领取任务显示/隐藏一键领取按钮
    self.canGetAll:SetActive(#self.canGetTaskIds > 0)

    if #self.canGetTaskIds > 0 then
        self.achieveRect.rectTransform.sizeDelta = Vector2.New(self.achieveRect.rectTransform.sizeDelta.x, 570)
    else
        self.achieveRect.rectTransform.sizeDelta = Vector2.New(self.achieveRect.rectTransform.sizeDelta.x, 675)
    end

    self:FillTemplateContent(self.taskBox, self.achieveList, tablex.size(taskList), function(index, taskBox)
        taskBox:SetActive(true)
        --显示动画
        taskBox.canvasGroup.alpha = 0
        DLuaTimer:DoAfter(0.05 * index, function()
            taskBox.canvasGroup:DOFade(1, 0.2)
        end)

        local taskCfg = taskList[index]
        local taskData = Me:getMissionListById(taskList[index].id)
        local taskProgressTarget = Me:getTaskProgressTarget(taskData.id, GE.MissionSystemType.task)
        taskBox.taskNameTxt.text.text = taskCfg.taskName.."(<color=#DF5045>"..taskData.progress.."</color>/"..taskProgressTarget..")"
        
        taskBox.bgReceive:SetActive(taskData.state == GE.MissionState.Unclaimed)
        taskBox.bgTo:SetActive(taskCfg.TurnTo ~= 0 and taskData.state == GE.MissionState.Progress)

        taskBox.isFinishText:SetActive(taskData.state == GE.MissionState.Received)
        taskBox.inProgressText:SetActive(taskData.state == GE.MissionState.Progress)
        
        local rewardList = tablex.clone(taskCfg.Award)
        table.insert(rewardList, {GE.RewardType.ItemProp, Config.GetConfigInfo("TaskItem")[4], taskCfg.extraScore})
        self:FillTemplateContent(self.customBox, taskBox.rewardList, tablex.size(rewardList), function(k, itemObj)
            local customBox = itemObj.customBox
            customBox:setMono(self)
            customBox:SetUIData(rewardList[k], {navType = GE.NavigationType.TaskPanel})
        end)
        
        taskBox.getRewardBtn.button.onClick:RemoveAllListeners()
        taskBox.getRewardBtn.button.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, "click"))
            if taskData and taskData.state == GE.MissionState.Unclaimed then
                self:requestMissionReward({taskData.id}, function(data)
                    self:refreshTaskList()
                    self:pointTaskView()
                    self:refreshRedPoint(self.nowSelectDay)
                end)
            end
        end)

        taskBox.goToBtn.button.onClick:RemoveAllListeners()
        taskBox.goToBtn.button.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, "click"))
            local canTurnTo = UICommonUtils.CanUseSkipJudge(taskCfg.TurnTo, true)
            if canTurnTo then
                UICommonUtils.CommonTurnTo(taskCfg.TurnTo)
            end
        end)
    end)
end

function SevenDaysTaskPanel:pointTaskView()
    local PointList = Config.GetTaskInfoByTaskTypeAndGroup(GE.MissionType.SevenDayTask, GE.SevenDayTaskType.SevenDayPoint)
    if not PointList or tablex.size(PointList) == 0 then
        return
    end
    
    table.sort(PointList, function(a, b)
        return a.id < b.id
    end)
    
    --当前积分显示（优先获取未完成任务的进度，如果全部完成则使用最后一个任务的进度）
    local lastId = PointList[#PointList].id
    local lastTaskData = Me:getMissionListById(lastId)
    local nowPoint = lastTaskData.progress
    self.nowPointTxt.text.text = tostring(nowPoint)
    
    local sliderValue = self:calculateSegmentedProgress(nowPoint)
    self.pointSlider.slider.value = sliderValue

    self:FillTemplateContent(self.pointBox, self.levelList, tablex.size(PointList), function(index, pointBox)
        pointBox:SetActive(true)
        local pointCfg = PointList[index]
        local pointData = Me:getMissionListById(pointCfg.id)
        pointBox.pointLevelTxt.text.text = pointCfg.complete[2]
        --根据状态判断领取图标样式
        pointBox.isOn:SetActive(pointData.state == GE.MissionState.Received or pointData.state == GE.MissionState.Unclaimed)
        pointBox.canGet:SetActive(pointData.state == GE.MissionState.Unclaimed)
        pointBox.isOpen:SetActive(pointData.state == GE.MissionState.Received)
        pointBox.boxBg:SetActive(pointData.state ~= GE.MissionState.Received)

        pointBox.btn.button.onClick:RemoveAllListeners()
        pointBox.btn.button.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, "click"))

            if pointData.state == GE.MissionState.Unclaimed then
                self:requestMissionReward({pointCfg.id}, function(data)
                    self:refreshTaskList()
                    self:pointTaskView()
                    self:refreshRedPoint(self.nowSelectDay)
                end)

            else
                UIMgr:popUICover("SevenRewardPanel", {rewardList = pointCfg.Award, pointTxt = pointCfg.complete[2]})

            end

        end)
    end)
end

--刷新红点
function SevenDaysTaskPanel:refreshRedPoint(nowSelectDay)
    local setDayboxRedFunc = function(day,dayBox)
        local taskList = Config.GetTaskInfoByTaskTypeGroupType(GE.MissionType.SevenDayTask, GE.SevenDayTaskType.SevenDayCommon, day)
        local canGet = false
        for _, taskCfg in pairs(taskList) do
            local nowDays = Me:getRegisteredDayCount()
            if day > nowDays then
                break
            end
            if taskCfg.type == day then
                local taskData = Me:getMissionListById(taskCfg.id)
                if taskData and taskData.state == GE.MissionState.Unclaimed then
                    canGet = true
                    break
                end
            end
        end
        dayBox.redPoint:SetActive(canGet)
    end
    if nowSelectDay then
        local dayBox = self.dayboxList[nowSelectDay]
        if dayBox then
            setDayboxRedFunc(nowSelectDay, dayBox)
        end
        return
    else
        for day, dayBox in pairs(self.dayboxList) do
            setDayboxRedFunc(day, dayBox)
        end
    end
end

--暂停角色展示（界面关闭时保留spine，返回后可继续显示）
function SevenDaysTaskPanel:stopRoleShow()
    if self.changeCharTimer then
        DLuaTimer:RemoveTimer(self.changeCharTimer)
        self.changeCharTimer = nil
    end
    self.isCharSwitching = false
    self.needAnim = false
    self._spineLoadVersion = {}

    if UICommonUtils.Checkobj(self.showRoleBox1) then
        self.showRoleBox1.rectTransform:DOKill()
        self.showRoleBox1.canvasGroup:DOKill()
    end
    if UICommonUtils.Checkobj(self.showRoleBox2) then
        self.showRoleBox2.rectTransform:DOKill()
        self.showRoleBox2.canvasGroup:DOKill()
    end
    if UICommonUtils.Checkobj(self.roleInfoBg) then
        self.roleInfoBg.rectTransform:DOKill()
        self.roleInfoBg.canvasGroup:DOKill()
    end

    self:setSpineRenderTextureEnabled(self.nowShowSpineObj, false)
    self:setSpineRenderTextureEnabled(self.nextShowSpineObj, false)
end

--清理角色展示相关资源
function SevenDaysTaskPanel:clearRoleShow()
    self:stopRoleShow()
    self:destroySpineObj("nowShowSpineObj")
    self:destroySpineObj("nextShowSpineObj")
end

function SevenDaysTaskPanel:isPanelAlive()
    return UICommonUtils.Checkobj(self.gameObject)
end

function SevenDaysTaskPanel:setSpineRenderTextureEnabled(spineObj, enabled)
    if not UICommonUtils.Checkobj(spineObj) then
        return
    end
    local myRT = spineObj:GetComponent("SkeletonGraphicRenderTexture_Custom")
    if myRT then
        myRT.enabled = enabled
    end
end

function SevenDaysTaskPanel:destroySpineObj(spineObjKey)
    local spineObj = self[spineObjKey]
    if not UICommonUtils.Checkobj(spineObj) then
        self[spineObjKey] = nil
        return
    end
    self:setSpineRenderTextureEnabled(spineObj, false)
    GameObject.Destroy(spineObj)
    self[spineObjKey] = nil
end

--初始化角色显示格子
function SevenDaysTaskPanel:initShowRoleBox()
    self:clearRoleShow()
    self:forceHideRoleInfoBg()

    self.showCharList = Config.GetConfigInfo("SevenDayTaskCharacter") or {}
    if #self.showCharList == 0 then
        self.showRoleBox1:SetActive(false)
        self.showRoleBox2:SetActive(false)
        self.roleInfoBg:SetActive(false)
        return
    end

    self.showRoleBox1.rectTransform.anchoredPosition = Vector2.New(0, 0)
    self.showRoleBox1.canvasGroup.alpha = 1
    self.showRoleBox1:SetActive(true)
    self.nowRoleBox = self.showRoleBox1

    --单个角色：固定显示，不播放切换动画
    if #self.showCharList == 1 then
        self.showRoleBox2:SetActive(false)
        self.nowCharIndex = 1
        local skinConfig = Config.GetCharacterSkinInfo(self.showCharList[1])
        self:initShowSpine(self.nowRoleBox, skinConfig, "nowShowSpineObj")
        self:showCurrentRoleInfo()
        return
    end

    --多个角色：原地淡入淡出切换
    self.showRoleBox2:SetActive(true)
    self.showRoleBox2.rectTransform.anchoredPosition = Vector2.New(0, 0)
    self.showRoleBox2.canvasGroup.alpha = 0
    self.nextRoleBox = self.showRoleBox2

    local seed = DLuaUtil.GetGreenwichTime()
    local random = Random:new(seed)
    self.nowCharIndex = random:range(1, #self.showCharList)

    local skinConfig = Config.GetCharacterSkinInfo(self.showCharList[self.nowCharIndex])
    self:initShowSpine(self.nowRoleBox, skinConfig, "nowShowSpineObj")
    self:showCurrentRoleInfo()

    self.changeCharTimer = DLuaTimer:DoRepeatForever(5, function()
        if not self:isPanelAlive() or self.isCharSwitching then
            return
        end
        self.isCharSwitching = true
        self.needAnim = true
        self.nowCharIndex = self.nowCharIndex + 1
        if self.nowCharIndex > #self.showCharList then
            self.nowCharIndex = 1
        end
        local switchTime = 0.5
        local nextSkinId = self.showCharList[self.nowCharIndex]
        local nextSkinConfig = Config.GetCharacterSkinInfo(nextSkinId)
        if not nextSkinConfig then
            self.isCharSwitching = false
            self.needAnim = false
            return
        end
        self:initShowSpine(self.nextRoleBox, nextSkinConfig, "nextShowSpineObj")
        self.nextRoleBox.canvasGroup.alpha = 0
        self:playRoleInfoSwitchAnimation(nextSkinId, switchTime)
        self:setSpineRenderTextureEnabled(self.nowShowSpineObj, true)
        self.nowRoleBox.canvasGroup:DOFade(0, switchTime):SetEase(DG.Tweening.Ease.OutQuart)
        self.nextRoleBox.canvasGroup:DOFade(1, switchTime):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
            if not self:isPanelAlive() then
                return
            end
            local tempRoleBox = self.nowRoleBox
            self.nowRoleBox = self.nextRoleBox
            self.nextRoleBox = tempRoleBox

            local tempSpineObj = self.nowShowSpineObj
            self.nowShowSpineObj = self.nextShowSpineObj
            self.nextShowSpineObj = tempSpineObj

            self.nextRoleBox.canvasGroup.alpha = 0
            self.needAnim = false
            self.isCharSwitching = false

            self:setSpineRenderTextureEnabled(self.nowShowSpineObj, false)
            self:setSpineRenderTextureEnabled(self.nextShowSpineObj, false)
        end)
    end)
end

--刷新角色信息文本与图标
---@param skinId number
function SevenDaysTaskPanel:refreshRoleInfo(skinId)
    if not self:isPanelAlive() then
        return
    end
    local skinConfig = Config.GetCharacterSkinInfo(skinId)
    if not skinConfig then
        self.roleInfoBg:SetActive(false)
        return
    end
    local roleConfig = Config.GetCharacterInfo(skinConfig.CharacterID)
    if not roleConfig then
        self.roleInfoBg:SetActive(false)
        return
    end
    self.nowShowCharacterId = roleConfig.id
    self.roleInfoBg:SetActive(false)        --TODO: 临时
    self.nameTypeTxt.text.text = roleConfig.class
    self.nameTxt.text.text = roleConfig.name
    local roleTypeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, roleConfig.attribute)
    self:LoadSpriteAsync(roleTypeIconPath, function(s)
        if not self:isPanelAlive() then
            return
        end
        self.roleTypeIcon.image.sprite = s
    end)
    local qualityIcon = string.format(Config.SpritePath.roleQualityIcon, roleConfig.rank)
    self.rareIcon:SetActive(true)
    self:LoadSpriteAsync(qualityIcon, function(s)
        if not self:isPanelAlive() then
            return
        end
        self.rareIcon.image.sprite = s
    end)
end

--角色信息入场动画
function SevenDaysTaskPanel:playRoleInfoEnterAnimation()
    local roleInfoRoot = self.roleInfoBg
    if not roleInfoRoot.gameObject.activeSelf then
        return
    end
    local defaultTime = 0.5
    local moveY = 50
    if not self.roleInfoBgOriginPos then
        self.roleInfoBgOriginPos = roleInfoRoot.rectTransform.anchoredPosition
    end
    local originPos = self.roleInfoBgOriginPos
    roleInfoRoot.rectTransform:DOKill()
    roleInfoRoot.canvasGroup:DOKill()
    roleInfoRoot.canvasGroup.alpha = 0
    roleInfoRoot.rectTransform.anchoredPosition = Vector2(originPos.x, originPos.y - moveY)
    roleInfoRoot.rectTransform:DOAnchorPosY(originPos.y, defaultTime):SetEase(DG.Tweening.Ease.OutCubic)
    roleInfoRoot.canvasGroup:DOFade(1, defaultTime):SetEase(DG.Tweening.Ease.InCubic)
end

--角色信息切换动画（与spine切换同步）
---@param skinId number
---@param duration number
function SevenDaysTaskPanel:playRoleInfoSwitchAnimation(skinId, duration)
    if not self:isPanelAlive() then
        return
    end
    local roleInfoRoot = self.roleInfoBg
    if not roleInfoRoot.gameObject.activeSelf then
        self:refreshRoleInfo(skinId)
        return
    end
    if not self.roleInfoBgOriginPos then
        self.roleInfoBgOriginPos = roleInfoRoot.rectTransform.anchoredPosition
    end
    local originPos = self.roleInfoBgOriginPos
    local halfDuration = duration * 0.5
    roleInfoRoot.rectTransform:DOKill()
    roleInfoRoot.canvasGroup:DOKill()
    roleInfoRoot.rectTransform.anchoredPosition = originPos
    roleInfoRoot.canvasGroup:DOFade(0, halfDuration):SetEase(DG.Tweening.Ease.OutQuart):OnComplete(function()
        if not self:isPanelAlive() then
            return
        end
        self:refreshRoleInfo(skinId)
        roleInfoRoot.canvasGroup:DOFade(1, halfDuration):SetEase(DG.Tweening.Ease.InQuart)
    end)
end

--显示当前角色信息（首次展示）
function SevenDaysTaskPanel:showCurrentRoleInfo()
    if not self.showCharList or #self.showCharList == 0 or not self.nowCharIndex then
        self.roleInfoBg:SetActive(false)
        return
    end
    local skinId = self.showCharList[self.nowCharIndex]
    self:refreshRoleInfo(skinId)
    self:playRoleInfoEnterAnimation()
end

--加载角色spine
---@param nowRoleBox UnityEngine.GameObject
---@param skinConfig CharacterSkinTable
---@param nowSpineObj string  
function SevenDaysTaskPanel:initShowSpine(nowRoleBox, skinConfig, nowSpineObj)
    if not skinConfig then
        self:destroySpineObj(nowSpineObj)
        return
    end
    if UICommonUtils.Checkobj(self[nowSpineObj]) then
        if skinConfig.spineKey ~= "" and self[nowSpineObj].name == skinConfig.spineKey then
            return
        end
    end
    self._spineLoadVersion[nowSpineObj] = (self._spineLoadVersion[nowSpineObj] or 0) + 1
    local loadVersion = self._spineLoadVersion[nowSpineObj]
    if skinConfig.spineKey == "" then
        self:destroySpineObj(nowSpineObj)
        return
    end
    UICommonUtils:ShowRolePicOrSpine(self, nowRoleBox.showCharacter, skinConfig.id, function(spineObject)
        if not self:isPanelAlive() then
            if UICommonUtils.Checkobj(spineObject) then
                self:setSpineRenderTextureEnabled(spineObject, false)
                GameObject.Destroy(spineObject)
            end
            return
        end
        if self._spineLoadVersion[nowSpineObj] ~= loadVersion then
            if UICommonUtils.Checkobj(spineObject) then
                self:setSpineRenderTextureEnabled(spineObject, false)
                GameObject.Destroy(spineObject)
            end
            return
        end
        self:destroySpineObj(nowSpineObj)
        local objSpine = spineObject:GetComponent("SkeletonGraphic")
        if not objSpine then
            GameObject.Destroy(spineObject)
            return
        end
        objSpine.PhysicsPositionInheritanceFactor = Vector2.New(0.1, 0.1)
        local headPoint = objSpine.transform:Find("HeadPoint")
        if headPoint then
            local headPointPos = headPoint.localPosition
            local nowScale = nowRoleBox.showCharacter.transform.localScale
            nowRoleBox.showCharacter.transform.localPosition = Vector3.New(-headPointPos.x * nowScale.x, -headPointPos.y * nowScale.y, 0)
        end
        if self.needAnim then
            self:setSpineRenderTextureEnabled(spineObject, true)
        end
        self[nowSpineObj] = spineObject
    end)
end

function SevenDaysTaskPanel:OnClose(initiative)
    self:stopRoleShow()
end

-- function SevenDaysTaskPanel:OnClose(initiative)

-- end

function SevenDaysTaskPanel:OnDestroy()
	--self.super:OnDestroy(self)
    self:clearRoleShow()
    self.super:OnDestroy(self)
end

--function SevenDaysTaskPanel:OnRefresh(data)
--
--end

--[[
/AdjustRoot/bgDown/PointSlider onValueChanged 
--]]
function SevenDaysTaskPanel:pointSlider_Slider_onValueChanged(pointSlider,value)

end

--[[
/AdjustRoot/ListBg/Mask/AllList/CanGetAll/GetAllBtn onClick 
--]]
function SevenDaysTaskPanel:getAllBtn_ScaleButton_onClick(getAllBtn)
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    
    if self.canGetTaskIds and #self.canGetTaskIds > 0 then
        self:requestMissionReward(self.canGetTaskIds, function(data)
            self:refreshTaskList()
            self:pointTaskView()
            self:refreshRedPoint(self.nowSelectDay)
        end)
    end
end

--[[
/AdjustRoot/MsgImg/JumpToBtn onClick 
--]]
function SevenDaysTaskPanel:jumpToBtn_ScaleButton_onClick(jumpToBtn)
    UIMgr:popUI("ActivityPanel", {activityId = 60001}, function()
        LoadingMgr:SetUISwitchOver()
    end)
end

--[[
/AdjustRoot/MsgImg/RoleInfoBg/RoleInfoBtn onClick 
--]]
function SevenDaysTaskPanel:roleInfoBtn_ScaleButton_onClick(roleInfoBtn)
    if not self.nowShowCharacterId then
        return
    end
    self:play2DSound(string.format(Config.AudioPath.SE, "click"))
    LoadingMgr:SetUISwitchStart(function()
        UIMgr:popUI("DockRolePanel", {uiMode = 3, characterId = self.nowShowCharacterId})
    end)
end

return SevenDaysTaskPanel
