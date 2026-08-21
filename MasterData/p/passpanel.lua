---@class PassPanel : PassPanel_Generate
---##################### 【PassPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【PassPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local PassPanel = require "PassPanel_Generate"
local Toast = require("Main.Assets.Content.Lua.UI.Toast.Toast")

function PassPanel:InitLogic(data)
    self.ToggleMode = {
        "menuListToggle1","menuListToggle2","menuListToggle3"
    }
     self.msgEventHandler = {
        {GameMsgType.PassMainUpdate, self.RefreshPassUpdateData},
        --刷新任务按钮状态
        {GameMsgType.MissionRefresh, self.RefreshTaskRefreshUI},
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
    }

    self.animOverCallBack:SetCallBackOfName(function(animatonName)
        if animatonName == "PassPanelSecondShowRole" or animatonName == "PassPanelFirstShowRole" then
            self.animator.enabled = false
        end
    end)
    -- 2025/12/15 关闭拖拽方法
    self.roleView.scrollRect.enabled = false
    self._originMaskPadding = self.showCharacterRt.rectMask2D.padding
end

--function PassPanel:StartCreating(time)
--
--end

--function PassPanel:StartEnter(time)
--
--end

--function PassPanel:StartRemoving(time)
--
--end

--function PassPanel:StartExit(time)
--
--end

function PassPanel:RefreshTaskRefreshUI()
    self:refreshTaskComplete()
end

---获取奖励列表数量
function PassPanel:GetMaxRwdListCount()
    return tablex.size(self:GetpassRwdList())
end

---获取奖励列表
function PassPanel:GetpassRwdList()
    local result = Config.GetPassportByPassportId(self.m_activityData.id)
    table.sort(result, function(a, b)
        return a.id < b.id
    end)
    return result
end

function PassPanel:OnOpen(data, initiative)
    self:SetUIVolume()

    self:SetUpdateInterval(0)
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.PassPanel)

    self.m_openPassData = data

    self.m_selectTopRewardListIndex = 0
    self.m_activityData = Config.GetActivityInfo(self.m_openPassData.activityId)
    self.m_passportMainData = Config.GetPassportMainInfo(self.m_activityData.activityPara[1])
    if initiative then

        self:bindRwdList()
        self:bindTaskList()
        
        self:bindSuperRewardList()
        self:bindAdvRewardList2()
        self:bindAdvRewardList()

       
        self.unlockBack.unlockDest.text.text = LocalStrEnum.passport_001--"解锁<color=#36a3fc>高级通行证</color>，等级达到<color=#36a3fc>20级</color>获得"
        --1 表示主ui  2 表示进入高级通行证购买界面
        self.m_ShowState = 1
        self.mainRoot:SetActive(true)
        self.secondRoot:SetActive(false)
        self:RefreshCharacterAndNameLocal(true)

        self:__RefreshNavigation()

        self.m_advanceRewardList = {}
        self.m_advanceRewardList2 = {}
        self.m_superRewardList = {}
        --初始化关闭所有toggle
        for k, v in pairs(self.ToggleMode) do
            self.menuListPanel[v].toggle.isOn = false
        end
        self:refreshUnlockAllBtnDis()

    end

    self:RefreshSpine()
    --页签相关初始化
    if not self.nowMode then
        self:SetModeSelect(1)
    else
        self:SetModeSelect(self.nowMode)
    end
    self:refreshGetBtnShow()

    if self.recoverDownTimer then
        DLuaTimer:RemoveTimer(self.recoverDownTimer)
    end
    self:UpdateTime()
    self.recoverDownTimer = DLuaTimer:DoRepeatForever(60, function()
        self:UpdateTime()
    end)
    self.curLevelTxt.text.text = ""
    self:RefreshLevelAndExp()
    self:refreshAllRedPoint()
    
    if self.m_isShowInitAnimation  ~= true then
        
        self.animator.enabled = true
        self.animator:Play("PassPanelInit")
        self.m_isShowInitAnimation = true
    end
end

-- 设置相机后处理 Volume（与其他 UI 面板一致）
function PassPanel:SetUIVolume()
    --local uiVolumeTr = self.gameObject.transform:Find("UiVolume")
    --if not uiVolumeTr then
    --    return
    --end
    --
    --local UICamera = UIMgr.uiCamera
    --local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    --if cameraData then
    --    cameraData.renderPostProcessing = true
    --    cameraData.volumeTrigger = uiVolumeTr
    --    cameraData.volumeLayerMask = LayerMask.GetMask("UI")
    --end
end

function PassPanel:RefreshPassUpdateData()
    if self.nowMode == 1 then
        self:RefreshWithBuyLevel()
    else
        self:refreshTaskComplete()
    end
    
end

function PassPanel:__RefreshNavigation()
    if self.m_ShowState == 1 then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.PassPanel)
        --接管返回方法
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            UIMgr:closeCurrentUI()
            self.m_isShowInitAnimation = false
        end)
    elseif self.m_ShowState == 2 then
        
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.PassPanel)
        --接管返回方法
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self.m_ShowState = 1
            self.animator.enabled = true
            self.animator:Play("PassPanelSecondToFirst")
            -- self.mainRoot:SetActive(true)
            -- self.secondRoot:SetActive(false)
            self:RefreshCharacterAndNameLocal()
            self:__RefreshNavigation()
        end)

    elseif self.m_ShowState == 3 then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.PassPanel)
        --接管返回方法
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self.m_ShowState = 1
            -- self.roleView.scrollRect.enabled = false
            self.animator.enabled = true
            self.animator:Play("PassPanelFirstHideRole")
            self.posPoint.rectTransform:DOAnchorPos(Vector2.New(0, 0), 0.3)
            self.mainRoot:SetActive(true)
            self.secondRoot:SetActive(false)

            self:RefreshCharacterAndNameLocal()
            self:__RefreshNavigation()
        end)

    elseif self.m_ShowState == 4 then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.PassPanel)
        --接管返回方法
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self.m_ShowState = 2
            -- self.roleView.scrollRect.enabled = false
            self.animator.enabled = true
            self.animator:Play("PassPanelSecondHideRole")
            self.posPoint.rectTransform:DOAnchorPos(Vector2.New(0, 0), 0.3)
            self.mainRoot:SetActive(false)
            self.secondRoot:SetActive(true)

            self:RefreshCharacterAndNameLocal()
            self:__RefreshNavigation()
        end)
    end
    
end

function PassPanel:OnClose(initiative)
    -- if self.levelEffectSeq ~= nil then
    --    self.levelEffectSeq:Kill()
    --    self.levelEffectSeq = nil 
    -- end
    -- self.effect:SetActive(false)
end

function PassPanel:OnVisibleChange(isVisable)

    -- if not isVisable then
    --     if self.levelEffectSeq ~= nil then
    --         self.levelEffectSeq:Kill()
    --         self.levelEffectSeq = nil 
    --     end
    --     self.effect:SetActive(false)
    -- end

end

function PassPanel:OnDestroy()
    if self.levelEffectSeq ~= nil then
       self.levelEffectSeq:Kill()
       self.levelEffectSeq = nil 
    end

    self.super:OnDestroy(self)
end

--function PassPanel:OnRefresh(data)
--
--end

function PassPanel:RefreshLevelAndExp()
    self:PlayLevelUpEfect()
    local curUseLevel = self:GetPassServeData().level + 1
    local currLevelExp = (self:GetPassServeData().levelExp or 0)

    if curUseLevel >=  self:GetMaxRwdListCount() then
        curUseLevel = self:GetMaxRwdListCount()
        currLevelExp = self:GetpassRwdList()[curUseLevel].Exp
    end

    

    self.expTxt.text.text = currLevelExp.."/"..self:GetpassRwdList()[curUseLevel].Exp
    self.expSliderValue.image.fillAmount = currLevelExp/self:GetpassRwdList()[curUseLevel].Exp
end

--- 获取奖励状态
---@param level number 等级
---@return boolean, boolean, boolean, boolean isLock1, isLock2, isGet1, isGet2
function PassPanel:GetRewardState(level)
    local passData = self:GetPassServeData()
    local isLock1 = level > passData.level
    local isLock2 = isLock1 or (passData.openAdvance ~= 1)
    local isGet1 = tablex.find(passData.basePassRwdStates, level)
    local isGet2 = tablex.find(passData.advancePassRwdStates, level)
    return isLock1, isLock2, isGet1, isGet2
end

--- 设置奖励框数据
---@param rewardBox table 奖励框对象
---@param award table 奖励配置
---@param isGet boolean 是否已领取
---@param isLock boolean 是否锁定
---@param level number 等级
---@param rewardState number 奖励状态类型(1:基础,2:高级)
function PassPanel:SetRewardBoxData(rewardBox, award, isGet, isLock, level, rewardState)
    local customData = {
        isGet = isGet,
        isLock2 = isLock,
        listener = function()
            if not isGet and not isLock then
                Me:getPassRewardReq({
                    id = self.m_openPassData.activityId,
                    level = level,
                    rewardState = rewardState
                }, function(data)
                    self:RefreshWithBuyLevel()
                end)
                return
            end
            return false
        end
    }
    rewardBox.customBox:setMono(self)
    rewardBox.customBox:SetUIData(award, customData)
    
    local canGet = not isGet and not isLock
    rewardBox.customBox.redPoint:SetActive(canGet)
end

function PassPanel:bindRwdList()
    self.passRewardLoopList.loopListView2:InitListView(1000, function(listView, index)
        local level = index + 1
        local isLock1, isLock2, isGet1, isGet2 = self:GetRewardState(level)

        local loopListViewItem2 = listView:GetShownItemByItemIndex(index)
        if loopListViewItem2 == nil then
            loopListViewItem2 = listView:NewListViewItem("CommonPassBox")
        end
        local itemObj = loopListViewItem2.gameObject
        EngineUtil.FillPeer(self.commonPassBox, itemObj)
        
        local usePassportTable = self:GetpassRwdList()[level]
        itemObj.basePassLevelTxt.text.text = string.format(LocalStrEnum.passport_002, usePassportTable.Level)

        -- 设置基础奖励状态图标
        itemObj.basePassImage:SetActive(isGet1)
        itemObj.basePassImage2:SetActive(not isGet1)

        -- 设置基础奖励
        self:SetRewardBoxData(itemObj.basePassRwd.rewardBox, usePassportTable.Award[1], isGet1, isLock1, usePassportTable.Level, 1)
        itemObj.basePassRwd.effectCai:SetActive(false)
        itemObj.basePassRwd.effectJin:SetActive(false)
        local canGet1 = not isGet1 and not isLock1
        if canGet1 then
            if itemObj.basePassRwd.rewardBox.customBox:getQuality() >= 5 then
                itemObj.basePassRwd.effectCai:SetActive(true)
            elseif itemObj.basePassRwd.rewardBox.customBox:getQuality() == 4 then
                itemObj.basePassRwd.effectJin:SetActive(true)
            end
        end
        -- 设置高级奖励1
        if #usePassportTable.AdvancedAward >= 1 then
            self:SetRewardBoxData(itemObj.advancedRwd1.rewardBox, usePassportTable.AdvancedAward[1], isGet2, isLock2, usePassportTable.Level, 2)
            itemObj.advancedRwd1:SetActive(true)
            itemObj.advancedRwd1.effectCai:SetActive(false)
            itemObj.advancedRwd1.effectJin:SetActive(false)
            local canGet2 = not isGet2 and not isLock2
            if canGet2 then
                if itemObj.advancedRwd1.rewardBox.customBox:getQuality() >= 5 then
                    itemObj.advancedRwd1.effectCai:SetActive(true)
                elseif itemObj.basePassRwd.rewardBox.customBox:getQuality() == 4 then
                    itemObj.advancedRwd1.effectJin:SetActive(true)
                end
            end

        else
            itemObj.advancedRwd1:SetActive(false)
        end

        -- 设置高级奖励2
        if #usePassportTable.AdvancedAward >= 2 then
            self:SetRewardBoxData(itemObj.advancedRwd2.rewardBox, usePassportTable.AdvancedAward[2], isGet2, isLock2, usePassportTable.Level, 2)
            itemObj.advancedRwd2:SetActive(true)
            itemObj.advancedRwd2.effectCai:SetActive(false)
            itemObj.advancedRwd2.effectJin:SetActive(false)
            local canGet2 = not isGet2 and not isLock2
            if canGet2 then
                if itemObj.advancedRwd2.rewardBox.customBox:getQuality() >= 5 then
                    itemObj.advancedRwd2.effectCai:SetActive(true)
                elseif itemObj.basePassRwd.rewardBox.customBox:getQuality() == 4 then
                    itemObj.advancedRwd2.effectJin:SetActive(true)
                end
            end
        else
            itemObj.advancedRwd2:SetActive(false)
        end

        return loopListViewItem2
    end)

end

--刷新奖励列表
function PassPanel:refreshRwdList(needJump)
    --LuaLogger.ds("刷新奖励列表", debug.traceback())

    self.passRewardLoopList.loopListView2:SetListItemCount(tablex.size(self:GetpassRwdList()))
    self.passRewardLoopList.loopListView2:RefreshAllShownItem2()
    --跳转
    if needJump then
        local targetLevel = self:GetFastMoveIndex()
        --LuaLogger.ds("跳转等级", targetLevel)
        -- 因为index从0开始的要-1 因为跳转的各自要显示在第二格所以还要-1
        local index = targetLevel - 2 >= 0 and targetLevel - 2 or 0
        self.passRewardLoopList.loopListView2:MovePanelToItemIndex(index, 0)
    end
    self.topAdvancedImage:SetActive(true)
    self.advancedPassDestTxt.text.text = LocalStrEnum.passport_003--"-前往激活-"
    if self:GetPassServeData().openAdvance == 1 then
        self.topAdvancedImage:SetActive(false)
        self.advancedPassDestTxt.text.text = LocalStrEnum.passport_004--"-已激活-"
    end
end

--- 获取快速跳转index 跳转到待领取的最小等级 没有待领取就跳转到当前等级
function PassPanel:GetFastMoveIndex()
    for i = 1, self:GetPassServeData().level do
        if not tablex.find(self:GetPassServeData().basePassRwdStates, i) then
            return i
        end
        if self:GetPassServeData().openAdvance == 1 then
            if not tablex.find(self:GetPassServeData().advancePassRwdStates,i) then
                return i
            end
        end
    end
    return self:GetPassServeData().level < 1 and 1 or self:GetPassServeData().level
end

function PassPanel:RefreshWithBuyLevel()
    self:__RefreshNavigation()
    self:RefreshLevelAndExp()
    self:refreshRwdList()
    self:refreshAllRedPoint()
    self:refreshUnlockAllBtnDis()
    self:RefreshTopPassRwd()
    self:refreshGetBtnShow()
end

function PassPanel:refreshUnlockAllBtnDis()
    if self:GetPassServeData().openAdvance ~= 1 then
        -- self.unlockAllBtn.desc.text.text = "解锁高级通行证"
        self.unlockAllBtn.desc.text.text = LocalStrEnum.passport_015
        self.figureFinish:SetActive(false)
        self.figure:SetActive(true)
    elseif self:GetPassServeData().openAdvance == 1 and self:GetPassServeData().openSuperAdvance ~= 1 then
        -- self.unlockAllBtn.desc.text.text = "升级高级通行证"
        self.unlockAllBtn.desc.text.text = LocalStrEnum.passport_016
        self.figureFinish:SetActive(false)
        self.figure:SetActive(true)
    elseif self:GetPassServeData().openAdvance == 1 and self:GetPassServeData().openSuperAdvance == 1 then
        self.figureFinish:SetActive(true)
        self.figure:SetActive(false)
    end
end

--- 刷新
---@param isInit 是否初始化
function PassPanel:RefreshCharacterAndNameLocal(isInit)
    local needMask = false
    --主界面
    if self.m_ShowState == 1 then
        needMask = true
        self.showCharacterRt.rectTransform.anchoredPosition = Vector2.New(780,0)
        self.nameDestRoot.rectTransform.anchoredPosition = Vector2.New(688,-290)
        self.searchRoot:SetActive(true)
        self.characterMask1:SetActive(true)
        self.characterMask2:SetActive(false)
    --高级通行证购买界面
    elseif self.m_ShowState == 2 then
        needMask = true
        self.showCharacterRt.rectTransform.anchoredPosition = Vector2.New(130,0)
        self.nameDestRoot.rectTransform.anchoredPosition = Vector2.New(-7,-381)
        self.searchRoot:SetActive(true)
        self.characterMask1:SetActive(false)
        self.characterMask2:SetActive(true)
    --主界面点击的查看立绘
    elseif self.m_ShowState == 3 then
        needMask = false
        self.showCharacterRt.rectTransform.anchoredPosition = Vector2.New(130,0)
        self.nameDestRoot.rectTransform.anchoredPosition = Vector2.New(-7,-381)
        self.searchRoot:SetActive(true)
        self.characterMask1:SetActive(false)
        self.characterMask2:SetActive(true)
    --高级通行证界面点击的查看立绘
    elseif self.m_ShowState == 4 then
        needMask = false
        self.showCharacterRt.rectTransform.anchoredPosition = Vector2.New(130,0)
        self.nameDestRoot.rectTransform.anchoredPosition = Vector2.New(-7,-381)
        self.searchRoot:SetActive(true)
        self.characterMask1:SetActive(false)
        self.characterMask2:SetActive(true)
    end
    if isInit then
        self._lastNeedMask = needMask
    end
    --需要切换表现
    if self._lastNeedMask ~= needMask then
        self._lastNeedMask = needMask
        if self._maskDotween then
            self._maskDotween:Kill()
            self._maskDotween = nil
        end
        local passTime = 0.6
        if needMask then
            self._maskDotween = DG.Tweening.DOVirtual.Float(1, 0, passTime, function(v)
                local paddingValueX = math.floor(self._originMaskPadding.x + -500 * v)
                local paddingValueZ = math.floor(self._originMaskPadding.z + -500 * v)

                local paddingValueW = math.floor(self._originMaskPadding.w + -200 * v)
                local paddingValueY = math.floor(self._originMaskPadding.y + -200 * v)  
                self.showCharacterRt.rectMask2D.padding = Vector4.New(paddingValueX, paddingValueY, paddingValueZ, paddingValueW)
            end)
        else
            self._maskDotween = DG.Tweening.DOVirtual.Float(0, 1, passTime, function(v)
                local paddingValueX = math.floor(self._originMaskPadding.x + -500 * v)
                local paddingValueZ = math.floor(self._originMaskPadding.z + -500 * v)

                local paddingValueW = math.floor(self._originMaskPadding.w + -200 * v)
                local paddingValueY = math.floor(self._originMaskPadding.y + -200 * v)
                self.showCharacterRt.rectMask2D.padding = Vector4.New(paddingValueX, paddingValueY, paddingValueZ, paddingValueW)
            end)
        end
    end
end
--数据初始化
function PassPanel:DataInfo()

    self.passweekTaskTable = {} 
    self.seasonTaskTable = {}
    local missionList = Me:getMissionList()
    for k, v in pairs(missionList) do
        local taskConfig = Config.GetTaskTableInfo(v.id)
        if taskConfig then
            local temp = {
                server = v, config = taskConfig
            }
            if taskConfig.taskType == GE.MissionType.PassTask and tablex.contains(self.m_activityData.TaskGroup,taskConfig.taskGroup) then
                if taskConfig.refreshType == 2 then
                    table.insert(self.passweekTaskTable, temp)
                elseif taskConfig.refreshType == 0  and tablex.contains(self.m_activityData.TaskGroup,taskConfig.taskGroup) then
                    table.insert(self.seasonTaskTable, temp)
                end

            end
        end
    end

    table.sort(self.passweekTaskTable, function(a, b)
        if a.server.state == b.server.state then
            return a.server.id < b.server.id
        else
            return a.server.state < b.server.state
        end

    end)

    table.sort(self.seasonTaskTable, function(a, b)
        if a.server.state == b.server.state then
            return a.server.id < b.server.id
        else
            return a.server.state < b.server.state
        end
    end)

end

function PassPanel:bindTaskList()

    self.passTaskLoopList.loopListView2:InitListView(0, function(listView, index)
        local loopListViewItem2 = listView:GetShownItemByItemIndex(index)
        if loopListViewItem2 == nil then
            loopListViewItem2 = listView:NewListViewItem("CommonPassTaskBox")
        end
        local itemObj = loopListViewItem2.gameObject
        EngineUtil.FillPeer(self.commonPassTaskBox, itemObj)

        local taskData = self.curShowTaskData[index + 1]
        local taskProgressTarget = Me:getTaskProgressTarget(taskData.server.id, GE.MissionSystemType.task)
        itemObj.taskMsgTxt.text.text = taskData.config.TaskSynopsis

        if self.nowMode == 2 then
            itemObj.taskWeekIcon:SetActive(true)
            itemObj.taskPassIcon:SetActive(false)
        elseif self.nowMode == 3 then
            itemObj.taskWeekIcon:SetActive(false)
            itemObj.taskPassIcon:SetActive(true)
        end

        local showTaskProgress = taskData.server.progress < taskProgressTarget and taskData.server.progress or taskProgressTarget
        if showTaskProgress == taskProgressTarget then
            itemObj.taskNameTxt.text.text = string.format("%s  (<color=#1b83d9>%s</color><color=#838383>/%s</color>)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        else
            itemObj.taskNameTxt.text.text = string.format("%s  (<color=#e8703b>%s</color><color=#838383>/%s</color>)", taskData.config.taskName, showTaskProgress, taskProgressTarget)
        end
        itemObj.pointFull:SetActive(showTaskProgress == taskProgressTarget)
        itemObj.taskPoint.image.fillAmount = showTaskProgress / taskProgressTarget
        itemObj.inProgressText:SetActive(taskData.server.state == GE.MissionState.Progress)
        itemObj.finishText:SetActive(taskData.server.state == GE.MissionState.Received)
        --itemObj.mask:SetActive(taskData.server.state == GE.MissionState.Received)
        itemObj.btn.button.onClick:RemoveAllListeners()
        if taskData.server.state == GE.MissionState.Unclaimed then
            itemObj.bgReceive:SetActive(true)
            itemObj.btn.button.onClick:AddListener(function()
                local missionId = {
                    taskData.server.id
                }
                local prevLevel = self:GetPassServeData().level
                Me:GetMissionRewardReq(missionId, function(data)

                    self:refreshTaskComplete(true)
                    local  currLevel = self:GetPassServeData().level
                    if currLevel ~=  prevLevel then
                        UIMgr:popUICover("PassBuyLevelResutPanel", {prevLevel = prevLevel,nextLevel = currLevel })
                    end
                end)
            end)
        else
            itemObj.bgReceive:SetActive(false)
        end

        if taskData.server.state == GE.MissionState.Progress and taskData.config.TurnTo ~= 0 then
            itemObj.bgTo:SetActive(true)
            itemObj.btn.button.onClick:AddListener(function()
                local canTurnTo = UICommonUtils.CanUseSkipJudge(taskData.config.TurnTo, true)
                if canTurnTo then
                    UICommonUtils.CommonTurnTo(taskData.config.TurnTo)
                end
            end)
        else
            itemObj.bgTo:SetActive(false)
        end

        local taskExpData = taskData.config.Award[1]
        itemObj.itemNum.text.text = taskExpData[3]

        self:LoadSpriteAsync(string.format(Config.SpritePath.PassExpIconPath, taskExpData[2]), itemObj.itemIcon.image)
        
        return loopListViewItem2
    end)

end

function PassPanel:GetPassServeData()
    local passdataMap = Me:getPassDataMap()
    return passdataMap[self.m_openPassData.activityId]
end

function PassPanel:refreshTaskComplete(showLevelEffect)
    self:refreshTaskList()
    self:RefreshLevelAndExp()
    self:refreshAllRedPoint()
end

function PassPanel:refreshTaskList()
    self:DataInfo()
    if self.nowMode == 2 then
        self.curShowTaskData = self.passweekTaskTable
    elseif self.nowMode == 3 then
        self.curShowTaskData = self.seasonTaskTable
    end
    self.passTaskLoopList.loopListView2:SetListItemCount(0)
    self.passTaskLoopList.loopListView2:SetListItemCount(tablex.size(self.curShowTaskData))
    self.passTaskLoopList.loopListView2:RefreshAllShownItem2()
end

function PassPanel:SetModeSelect(mode)
    self.nowMode = mode
    self.menuListPanel[self.ToggleMode[self.nowMode]].toggle.isOn = true
    for key, value in pairs(self.ToggleMode) do
        LuaLogger. ds("self.nowMode = ",self.nowMode,key, value)
        if self.nowMode == key then
            self.menuListPanel[value].iconImg.image.color = Color.NewFromStr("333333FF")
            self.menuListPanel[value].tagText.text.color = Color.NewFromStr("333333FF")
        else
            self.menuListPanel[value].iconImg.image.color = Color.NewFromStr("FFFFFF7F")
            self.menuListPanel[value].tagText.text.color = Color.NewFromStr("FFFFFF7F")
        end
    end
end

function PassPanel:refreshGetBtnShow()
    local canReceive = false
    if self.nowMode == 1 then
        local passData = Me:getPassData(self.m_openPassData.activityId)
        local cfgList = Config.GetPassportByPassportId(self.m_openPassData.activityId)
        if passData and cfgList then
            local rewardList = {}
            for _, cfg in pairs(cfgList) do
                if cfg.Level <= passData.level then
                    if not tablex.find(passData.basePassRwdStates, cfg.Level) then
                        canReceive = true
                    end
                    if passData.openAdvance == 1 then
                        if not tablex.find(passData.advancePassRwdStates, cfg.Level) then
                            canReceive = true
                        end
                    end
                end
            end
        end
    else
        if self.nowMode == 2 then
            for _, value in pairs(self.passweekTaskTable) do
                if value.server.state == GE.MissionState.Unclaimed then
                    canReceive = true
                end
            end
        elseif self.nowMode == 3 then
            for _, value in pairs(self.seasonTaskTable) do
                if value.server.state == GE.MissionState.Unclaimed then
                    canReceive = true
                end
            end
        end
    end
    self.getBtn.normal:SetActive(canReceive)
    self.getBtn.gray:SetActive(not canReceive)
end

function PassPanel:RefreshSpine()
    self.nowSelectSkinId = self.m_passportMainData.CharacterSkin[1]
    self.nowSelectSkinBg = self.m_passportMainData.CharacterSkin[2]
    self:ShowRolePicOrSpine(self.showCharacter, self.nowSelectSkinId, function(spineObject)
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
                GameObject.Destroy(self.nowShowSpineObj)
        end
        self.nowShowSpineObj = spineObject
    end)
    --皮肤对应背景图片
    self:LoadSpriteAsync(string.format(Config.SpritePath.PassPanelBg, self.nowSelectSkinBg), self.backImage.image)
    local skinConfig = Config.GetCharacterSkinInfo(self.nowSelectSkinId)
    local roleConfig = Config.GetCharacterInfo(skinConfig.CharacterID)
    self.roleNameRoot.gameObject:SetActive(false)
    self.roleNameRoot.roleNameTxt.text.text = roleConfig.name
    self.roleNameRoot.gameObject:SetActive(true)

    DLuaTimer:DoAfter(0.02, function()
        self.roleNameRoot.gameObject:SetActive(false)
		self.roleNameRoot.gameObject:SetActive(true)
	end)
end

function PassPanel:GetPassSkinDisplayOffset(baseOffset)
    local offsetX = 0
    local offsetY = 0
    if baseOffset then
        offsetX = tonumber(baseOffset[1]) or 0
        offsetY = tonumber(baseOffset[2]) or 0
    end
    local passOffset = self.m_passportMainData and self.m_passportMainData.imgOffset
    if passOffset then
        offsetX = offsetX + (tonumber(passOffset[1]) or 0)
        offsetY = offsetY + (tonumber(passOffset[2]) or 0)
    end
    return offsetX, offsetY
end

function PassPanel:ShowRolePicOrSpine(showRoot, skinId, callback)
	local picRoot = showRoot.skinImg
	local spineRoot = showRoot.spineRoot
	local skinConfig = Config.GetCharacterSkinInfo(skinId)
	if not skinConfig then
		picRoot:SetActive(false)
		spineRoot:SetActive(false)
		return
	end

    --根据配置信息显示spine或图片
    picRoot:SetActive(false)
    spineRoot:SetActive(false)
	showRoot.canvasGroup.alpha = 0
	local needOffset, needRate
    if skinConfig.spineKey and skinConfig.spineKey ~= "" then
        local prefabPath = string.format(Config.PrefabPath.RoleSpine, skinConfig.spineKey, skinConfig.spineKey)
        self:LoadInstantiatePrefab(prefabPath, function (obj)
            local spineObject = obj
            spineObject:SetParent(spineRoot.transform)
            local objSpineAnim = spineObject:GetComponent("SkeletonAnimation")
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Action, "idle_action", true)
            objSpineAnim.AnimationState:SetAnimation(GE.RoleSpineActionType.Emote, "idle", true)
			spineRoot:SetActive(true)
			showRoot.canvasGroup:DOFade(1, 0.18)
			if callback then
				callback(spineObject)
			end
        end)
		needOffset = skinConfig.spineOffset
		needRate = skinConfig.spineRate
    else
        local function is_numeric(str)
            return tonumber(str) ~= nil
        end
        local resourceFolder = nil
        if is_numeric(skinConfig.resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(skinConfig.resourceFolder)))
        else
            resourceFolder = skinConfig.resourceFolder
        end
        self:LoadSpriteAsync(string.format(Config.SpritePath.PortraitRolePath, resourceFolder, skinConfig.imgKey), function (s)
			picRoot.image.sprite = s
            picRoot.image:SetNativeSize()
            picRoot:SetActive(true)
			showRoot.canvasGroup:DOFade(1, 0.18)
        end)
		needOffset = skinConfig.imgOffset
		needRate = skinConfig.imgRate
    end
	-- 皮肤表基础偏移 + 通行证表额外偏移
	local offsetX, offsetY = self:GetPassSkinDisplayOffset(needOffset)
	showRoot.rectTransform.anchoredPosition = Vector2(offsetX, offsetY)
    showRoot.rectTransform.localScale = Vector2.New(needRate, needRate)
end

function PassPanel:UpdateTime()

    local nowTime = math.modf(Me:getLocalStamp())

    local timeDiff = self.m_activityData.EndTime - nowTime
   
    local days = math.floor(timeDiff / 86400)
    local hours = math.floor((timeDiff % 86400) / 3600)
    local minutes = math.floor((timeDiff % 3600) / 60)
    if timeDiff < 86400 then
        self.timeRoot.timeTxt.text.text = string.format(LocalStrEnum.passport_005,hours,minutes)--"剩余时间：%s时%s分"
    else
        self.timeRoot.timeTxt.text.text = string.format(LocalStrEnum.passport_006,days,hours)--"剩余时间：%s天%s时"
    end
end

--[[
/passListContentRoot/topLevelRt/buyBtn onClick 等级购买
--]]
function PassPanel:buyBtn_ScaleButton_onClick(buyBtn)

    if  self:GetPassServeData().level >= self:GetMaxRwdListCount() then
        UICommonUtils.PopToast(LocalStrEnum.passport_007)--"已达最高等级，不能购买了"
        return 
    end
    local privilegeData = self.m_passportMainData.PrivilegeGet[4]
    local advanceShopMerchandiseInfo = Config.GetShopMerchandiseInfo(privilegeData[2])

    local data = {}
    data.goodId = advanceShopMerchandiseInfo.id
    data.activityId = self.m_openPassData.activityId
    UIMgr:popUICover("PassLevelBuyPanel", data)
end

--[[
/bottomInfoView/getBtn onClick 
--]]
function PassPanel:getBtn_ScaleButton_onClick(getBtn)

    if self.nowMode == 1 then
        Me:getPassRewardReq({id = self.m_openPassData.activityId,level = 0,rewardState = 3}, function(data)
            self:RefreshWithBuyLevel()
        end)
    else
        --判断当前常规模式下的哪个模式，对应模式整理一套一键领取的列表

        local missionId = {}
        if self.nowMode == 2 then
            for _, value in pairs(self.passweekTaskTable) do
                if value.server.state == GE.MissionState.Unclaimed then
                    table.insert(missionId, value.server.id)
                end
            end
        elseif self.nowMode == 3 then
            for _, value in pairs(self.seasonTaskTable) do
                if value.server.state == GE.MissionState.Unclaimed then
                    table.insert(missionId, value.server.id)
                end
            end
        end
        if missionId and next(missionId) then

            local prevLevel = self:GetPassServeData().level
            Me:GetMissionRewardReq(missionId, function(data)
                self:refreshTaskComplete(true)
                local currLevel = self:GetPassServeData().level
                if currLevel ~=  prevLevel then
                    UIMgr:popUICover("PassBuyLevelResutPanel", {prevLevel = prevLevel,nextLevel = currLevel })
                end
            end)
        end
    end
    

    

end

--[[
/bottomInfoView/unlockAllBtn onClick 
--]]
function PassPanel:unlockAllBtn_ScaleButton_onClick(unlockAllBtn)
    self.animator.enabled = true
    self.animator:Play("PassPanelFirstToSecond")
    self.m_ShowState = 2
    --self.mainRoot:SetActive(false)
    self.secondRoot:SetActive(true)

    self:RefreshCharacterAndNameLocal()
    self:RefreshAdvanceView()
    self:__RefreshNavigation()
end

--[[
/menuListRoot/menuListPanel/menuListToggle1 onValueChanged 奖励页签
--]]
function PassPanel:menuListToggle1_Toggle_onValueChanged(menuListToggle1,isOn)
    if self.nowMode == 1 then
        return
    end
    if isOn then
        self:SetModeSelect(1)
        self.rewardListRoot:SetActive(true)
        self.taskListRoot:SetActive(false)
        self:refreshRwdList(true)
        self:refreshGetBtnShow()
    end
   
end

--[[
/menuListRoot/menuListPanel/menuListToggle2 onValueChanged 每日任务页签
--]]
function PassPanel:menuListToggle2_Toggle_onValueChanged(menuListToggle2,isOn)
    if self.nowMode == 2 then
        return
    end
    if isOn then
        self:SetModeSelect(2)
        self:refreshTaskList()
        self.rewardListRoot:SetActive(false)
        self.taskListRoot:SetActive(true)
        self:refreshGetBtnShow()
    end
end

--[[
/menuListRoot/menuListPanel/menuListToggle3 onValueChanged 每期任务页签
--]]
function PassPanel:menuListToggle3_Toggle_onValueChanged(menuListToggle3,isOn)
    if self.nowMode == 3 then
        return
    end
   if isOn then
        self:SetModeSelect(3)
        self:refreshTaskList()
        self.rewardListRoot:SetActive(false)
        self.taskListRoot:SetActive(true)
        self:refreshGetBtnShow()
    end
end

--[[
/roleNameRoot/searchRoot/searchBtn onClick 
--]]
function PassPanel:searchBtn_Button_onClick(searchBtn)
    if self.m_ShowState == 1 then
        self.m_ShowState = 3
        self.animator.enabled = true
        self.animator:Play("PassPanelFirstShowRole")

        -- self.mainRoot:SetActive(false)
        -- self.secondRoot:SetActive(false)
        -- self.roleView.scrollRect.enabled = true
        self:RefreshCharacterAndNameLocal()

        self:__RefreshNavigation()

    elseif self.m_ShowState == 2 then
        self.m_ShowState = 4
        -- self.roleView.scrollRect.enabled = true
        self.animator.enabled = true
        self.animator:Play("PassPanelSecondShowRole")

        -- self.mainRoot:SetActive(false)
        -- self.secondRoot:SetActive(false)

        self:RefreshCharacterAndNameLocal()

        self:__RefreshNavigation()
    end
end

--[[
/passListContentRoot/taskListRoot/TaskLoopList/Viewport/Content/CommonTaskBox/Btn onClick 
--]]
function PassPanel:btn_Button_onClick(btn)

end

--[[
/secondRoot/advanceRoot/buyAdvanceBtn onClick 高级通行证
--]]
function PassPanel:buyAdvanceBtn_ScaleButton_onClick(buyAdvanceBtn)

    local openAdvance = false
    if self:GetPassServeData().openAdvance == 1 then
        openAdvance = true
    end
    if openAdvance == false then
        local privilegeData = self.m_passportMainData.PrivilegeGet[1]
        -- local advanceShopMerchandiseInfo = Config.GetShopMerchandiseInfo(privilegeData[2])
        -- local picId, picNum, picRate  = Me:GetShopItemPic(privilegeData[2])

        -- local itemCfg = Config.GetItemInfo(picId)
        -- local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)
        -- local title = LocalStrEnum.Gacha_Prompt
        -- local content = LocalStrEnum.passport_008--"确定消耗%sX%s解锁高级通行证"
        -- local name, desc, icon, quality = Me:GetGoodsItemDisplayInifo(privilegeData[2])
        -- UICommonUtils.PopMsgBox(title, string.format(content, costStr,picNum), MsgBoxType.Msg_Emoji, function()
        --     Me:ShopBuyReq(advanceShopMerchandiseInfo.id, 1, function(data)
        --         self:RefreshWithBuyLevel()
        --         self:RefreshAdvanceView()
        --     end)
        -- end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)     
        UICommonUtils:Pay(privilegeData[2], function()
            UICommonUtils.PopToast(LocalStrEnum.passport_018)
            self:RefreshWithBuyLevel()
            self:RefreshAdvanceView()
        end)
    end
    
end

--[[
/secondRoot/superRoot/buySuperBtn onClick 超级通行证
--]]
function PassPanel:buySuperBtn_ScaleButton_onClick(buySuperBtn)
    local openAdvance = false
    if self:GetPassServeData().openAdvance == 1 then
        openAdvance = true
    end
    local openSuperAdvance = false
    if self:GetPassServeData().openSuperAdvance == 1 then
        openSuperAdvance = true
    end

    if openSuperAdvance == false then
        local privilegeData = nil
        local advanceShopMerchandiseInfo = nil
        --已解锁高级通行证 只需要补差价购买另一商品
        if openAdvance then
            privilegeData = self.m_passportMainData.PrivilegeGet[3]
            -- advanceShopMerchandiseInfo = Config.GetShopMerchandiseInfo(privilegeData[2])
        else
            privilegeData =  self.m_passportMainData.PrivilegeGet[2]
            -- advanceShopMerchandiseInfo = Config.GetShopMerchandiseInfo(privilegeData[2])
        end

        -- local picId, picNum, picRate  = Me:GetShopItemPic(privilegeData[2])

        -- local itemCfg = Config.GetItemInfo(picId)
        -- local costStr = string.format("<size=200%%><sprite name=%s></size>", itemCfg.icon)
        -- local title = LocalStrEnum.Gacha_Prompt
        -- local content = LocalStrEnum.passport_009--"确定消耗%sX%s解锁超级通行证"
        -- local name, desc, icon, quality = Me:GetGoodsItemDisplayInifo(privilegeData[2])
        -- UICommonUtils.PopMsgBox(title, string.format(content, costStr,picNum), MsgBoxType.Msg_Emoji, function()
        --     local prevLevel = self:GetPassServeData().level
        --     Me:ShopBuyReq(advanceShopMerchandiseInfo.id, 1, nil,function(data)
        --         self:RefreshWithBuyLevel()
        --         self:RefreshAdvanceView()
        --         local currLevel = self:GetPassServeData().level
        --         UIMgr:popUICover("PassBuyLevelResutPanel", {prevLevel = prevLevel,nextLevel = currLevel })
        --     end)
        -- end, nil, LocalStrEnum.Shop_Refresh_okBtn, LocalStrEnum.Shop_Refresh_cancleBtn)
        local prevLevel = self:GetPassServeData().level
        UICommonUtils:Pay(privilegeData[2], function()
            self:RefreshWithBuyLevel()
            self:RefreshAdvanceView()
            local currLevel = self:GetPassServeData().level
            UIMgr:popUICover("PassBuyLevelResutPanel", {prevLevel = prevLevel,nextLevel = currLevel })
        end)
    end
end

function PassPanel:bindAdvRewardList()

    -- self.m_advanceRewardList = {}
    -- self.m_advanceRewardList2 = {}
    -- self.m_superRewardList = {}
    self.advanceRoot.advRewardList.loopGridView:InitGridView(0, function(gridView, index, row, col)
        --LuaLogger.ds("index", index)
        local loopGridViewItem = gridView:GetShownItemByItemIndex(index)
        if loopGridViewItem == nil then
            loopGridViewItem = gridView:NewListViewItem("CustomBox")
        end
        local  indexUse = index + 1
        local itemObj = loopGridViewItem.gameObject
        EngineUtil.FillPeer(self.customBox, itemObj)
        local customBox = itemObj.customBox
        customBox.transform.localScale = Vector3.New(0.6, 0.6, 1)
        
        --[[local customData = {
            id = self.m_advanceRewardList[indexUse][2],
            itemType = GE.ItemTypeIndex.item,
            itemNum = self.m_advanceRewardList[indexUse][3],
            listener = function()
                return false
            end
        }]]
        customBox:setMono(self)
        customBox:SetUIData(self.m_advanceRewardList[indexUse])
        return loopGridViewItem
    end)

end

function PassPanel:bindAdvRewardList2()
    -- self.m_advanceRewardList = {}
    -- self.m_advanceRewardList2 = {}
    -- self.m_superRewardList = {}
    self.advanceRoot.advRewardList2.loopGridView:InitGridView(0, function(gridView, index, row, col)
        --LuaLogger.ds("index", index)
        local loopGridViewItem = gridView:GetShownItemByItemIndex(index)
        if loopGridViewItem == nil then
            loopGridViewItem = gridView:NewListViewItem("CustomBox")
        end
        local  indexUse = index + 1
        local itemObj = loopGridViewItem.gameObject
        EngineUtil.FillPeer(self.customBox, itemObj)
        local customBox = itemObj.customBox
        customBox.transform.localScale = Vector3.New(0.6, 0.6, 1)
        
        --[[local data = {
            id = self.m_advanceRewardList2[indexUse][2],
            itemType = GE.ItemTypeIndex.item,
            itemNum = self.m_advanceRewardList2[indexUse][3],
            listener = function()
                return false
            end
        }]]
        customBox:setMono(self)
        customBox:SetUIData(self.m_advanceRewardList2[indexUse])
        return loopGridViewItem
    end)

end

function PassPanel:bindSuperRewardList()
    -- self.m_advanceRewardList = {}
    -- self.m_advanceRewardList2 = {}
    -- self.m_superRewardList = {}
    self.superRoot.advRewardList.loopGridView:InitGridView(0, function(gridView, index, row, col)
        --LuaLogger.ds("index", index)
        local loopGridViewItem = gridView:GetShownItemByItemIndex(index)
        if loopGridViewItem == nil then
            loopGridViewItem = gridView:NewListViewItem("CustomBox")
        end
        local  indexUse = index + 1
        local itemObj = loopGridViewItem.gameObject
        EngineUtil.FillPeer(self.customBox, itemObj)
        local customBox = itemObj.customBox
        customBox.transform.localScale = Vector3.New(0.6, 0.6, 1)
        
        --[[local data = {
            id = self.m_superRewardList[indexUse][2],
            itemType = GE.ItemTypeIndex.item,
            itemNum = self.m_superRewardList[indexUse][3],
            navType = GE.NavigationType.PassPanel,
            listener = function()
                return false
            end
        }]]
        customBox:setMono(self)
        customBox:SetUIData(self.m_superRewardList[indexUse])
        return loopGridViewItem
    end)

end

function PassPanel:RefreshAdvanceView()
    self.m_advanceRewardList = {}

    for index = 1, #self:GetpassRwdList() do
        self.m_advanceRewardList = tablex.combine(self.m_advanceRewardList,self:GetpassRwdList()[index].AdvancedAward)

    end

    self.m_advanceRewardList = self:mergePassRewardList(self.m_advanceRewardList)
    self:sortPassPreviewRewardList(self.m_advanceRewardList)
    self.advanceRoot.advRewardList.loopGridView:SetListItemCount(#self.m_advanceRewardList)
    
    local openAdvance = false
    if self:GetPassServeData().openAdvance == 1 then
        openAdvance = true
    end
    local privilegeData = self.m_passportMainData.PrivilegeGet[1]
    -- local advanceShopMerchandiseInfo = Config.GetShopMerchandiseInfo(privilegeData[2])
    local advanceShopMerchandiseInfo = Config.GetGiftInfo(privilegeData[2])
    if openAdvance then
        self.advanceRoot.buyAdvanceBtn.picRoot:SetActive(false)
        self.advanceRoot.buyAdvanceBtn.graypicText:SetActive(true)
        self.advanceRoot.buyAdvanceBtn.backImage:SetActive(false)
        self.advanceRoot.buyAdvanceBtn.backImage2:SetActive(true)
    else
        self.advanceRoot.buyAdvanceBtn.picRoot:SetActive(true)
        self.advanceRoot.buyAdvanceBtn.graypicText:SetActive(false)
        self.advanceRoot.buyAdvanceBtn.backImage:SetActive(true)
        self.advanceRoot.buyAdvanceBtn.backImage2:SetActive(false)
       
        if advanceShopMerchandiseInfo then
            -- local picId, picNum, picRate  = Me:GetShopItemPic(privilegeData[2])
            -- local itemCfg = Config.GetItemInfo(picId)
            -- self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemCfg.icon), function (s)
            --     self.advanceRoot.buyAdvanceBtn.picIcon.image.sprite = s

            -- end)
            self.advanceRoot.buyAdvanceBtn.picIcon:SetActive(false)
            local cost = UICommonUtils.GetGiftPriceById(advanceShopMerchandiseInfo.id)
            self.advanceRoot.buyAdvanceBtn.picText.text.text = "￥" ..tostring(cost)
        end
    end

    self.m_advanceRewardList2 = {}
    if advanceShopMerchandiseInfo then
        --{{1,110014,20},{6,2001,1},{8,2001,10}}
        for key, value in pairs(advanceShopMerchandiseInfo.Items_get) do
            if value[1] ~= GE.RewardType.PassExp and value[1] ~= GE.RewardType.PassUnlock and value[1] ~= GE.RewardType.PassLevel  and value[1] ~= GE.RewardType.PassSuper then
                table.insert(self.m_advanceRewardList2,value)
            end
        end
    end
    self.advanceRoot.advRewardList2.loopGridView:SetListItemCount(0)

    self.m_advanceRewardList2 = self:mergePassRewardList(self.m_advanceRewardList2)

    self:sortPassPreviewRewardList(self.m_advanceRewardList2)
    if #self.m_advanceRewardList2 > 0 then
        self.advanceRoot.advRewardList2.loopGridView:SetListItemCount(#self.m_advanceRewardList2)
        self.advanceRoot.advRewardList2.scrollRect.enabled = false

        local rt1 = self.advanceRoot.advRewardRt.rectTransform
        rt1.sizeDelta = Vector2.New(rt1.sizeDelta.x, 240)

        self.advanceRwdExtendRt.gameObject:SetActive(true)
    else
        self.advanceRoot.advRewardList2.loopGridView:SetListItemCount(0)

        local rt1 = self.advanceRoot.advRewardRt.rectTransform
        rt1.sizeDelta = Vector2.New(rt1.sizeDelta.x, 365)

        self.advanceRwdExtendRt.gameObject:SetActive(false)
    end
    
    local privilegeData = nil
    local advanceShopMerchandiseInfo = nil
    if openAdvance then
        privilegeData = self.m_passportMainData.PrivilegeGet[3]
        -- advanceShopMerchandiseInfo = Config.GetShopMerchandiseInfo(privilegeData[2])
        advanceShopMerchandiseInfo = Config.GetGiftInfo(privilegeData[2])
    else
        privilegeData =  self.m_passportMainData.PrivilegeGet[2]
        -- advanceShopMerchandiseInfo = Config.GetShopMerchandiseInfo(privilegeData[2])
        advanceShopMerchandiseInfo = Config.GetGiftInfo(privilegeData[2])
    end

    self.m_superRewardList = {}
    if advanceShopMerchandiseInfo then
        for key, value in pairs(advanceShopMerchandiseInfo.Items_get) do
            if value[1] ~= GE.RewardType.PassExp and value[1] ~= GE.RewardType.PassUnlock and value[1] ~= GE.RewardType.PassLevel and value[1] ~= GE.RewardType.PassSuper then
                table.insert(self.m_superRewardList,value)
            end
        end
    end
    self.superRoot.advRewardList.loopGridView:SetListItemCount(0)

    self.m_superRewardList = self:mergePassRewardList(self.m_superRewardList)
    self:sortPassPreviewRewardList(self.m_superRewardList)
    self.superRoot.advRewardList.loopGridView:SetListItemCount(#self.m_superRewardList)
    self.superRoot.advRewardList.scrollRect.enabled = false
    local openSuperAdvance = false
    if self:GetPassServeData().openSuperAdvance == 1 then
        openSuperAdvance = true
    end

    if openSuperAdvance then
        self.superRoot.buySuperBtn.picRoot:SetActive(false)
        self.superRoot.buySuperBtn.graypicText:SetActive(true)
        self.superRoot.buySuperBtn.backImage:SetActive(false)
        self.superRoot.buySuperBtn.backImage2:SetActive(true)
    else
        self.superRoot.buySuperBtn.picRoot:SetActive(true)
        self.superRoot.buySuperBtn.graypicText:SetActive(false)
        self.superRoot.buySuperBtn.backImage:SetActive(true)
        self.superRoot.buySuperBtn.backImage2:SetActive(false)
       
        if advanceShopMerchandiseInfo then
            -- local picId, picNum, picRate  = Me:GetShopItemPic(privilegeData[2])
            -- local itemCfg = Config.GetItemInfo(picId)
            -- self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPath, itemCfg.icon), function (s)
            --     self.superRoot.buySuperBtn.picIcon.image.sprite = s

            -- end)
            self.superRoot.buySuperBtn.picIcon:SetActive(false)
            local cost = UICommonUtils.GetGiftPriceById(advanceShopMerchandiseInfo.id)
            -- if openAdvance then
                self.superRoot.buySuperBtn.picText.text.text = "￥" ..tostring(cost)
            -- else
            --     self.superRoot.buySuperBtn.picText.text.text = "升级高级通行证"
            -- end            
        end
    end

end

function PassPanel:RefreshFromPassLevelBuyPanel()
    self:RefreshWithBuyLevel()
    self:RefreshAdvanceView()
end

function PassPanel:Update()

    local indexStart = self.passRewardLoopList.loopListView2.CurSnapNearestItemIndex + 1 + 6
    if indexStart >= self:GetMaxRwdListCount() then
        self.topPassRwd:SetActive(false)
        return
    end
    local useTop = math.ceil(indexStart/10) * 10
    if useTop > self:GetMaxRwdListCount() then
       useTop =  self:GetMaxRwdListCount()
    end
    if self.m_selectTopRewardListIndex ~= useTop then
        self.m_selectTopRewardListIndex = useTop
        self:RefreshTopPassRwd()
    end

    self.topPassRwd:SetActive(true)
end

function PassPanel:RefreshTopPassRwd()
    local level = self.m_selectTopRewardListIndex
    local isLock1, isLock2, isGet1, isGet2 = self:GetRewardState(level)

    local usePassportTable = self:GetpassRwdList()[level]
    self.topPassRwd.basePassLevelTxt.text.text = string.format(LocalStrEnum.passport_002, usePassportTable.Level)

    -- 设置基础奖励
    local customData1 = {
        isGet = isGet1,
        isLock2 = isLock1,
        navType = GE.NavigationType.TaskPanel,
    }
    self.topPassRwd.basePassRwd.customBox:setMono(self)
    self.topPassRwd.basePassRwd.customBox:SetUIData(usePassportTable.Award[1], customData1)
    self.topPassRwd.basePassRwd.customBox.redPoint:SetActive(not isLock1 and not isGet1)

    -- 设置高级奖励1
    if #usePassportTable.AdvancedAward >= 1 then
        local customData2 = {
            isGet = isGet2,
            isLock2 = isLock2,
            navType = GE.NavigationType.TaskPanel,
        }
        self.topPassRwd.advancedRwd1.customBox:setMono(self)
        self.topPassRwd.advancedRwd1.customBox:SetUIData(usePassportTable.AdvancedAward[1], customData2)
        self.topPassRwd.advancedRwd1.customBox.redPoint:SetActive(not isLock2 and not isGet2)
        self.topPassRwd.advancedRwd1:SetActive(true)
    else
        self.topPassRwd.advancedRwd1:SetActive(false)
    end

    -- 设置高级奖励2
    if #usePassportTable.AdvancedAward >= 2 then
        local customData3 = {
            isGet = isGet2,
            isLock2 = isLock2,
            navType = GE.NavigationType.TaskPanel,
        }
        self.topPassRwd.advancedRwd2.customBox:setMono(self)
        self.topPassRwd.advancedRwd2.customBox:SetUIData(usePassportTable.AdvancedAward[2], customData3)
        self.topPassRwd.advancedRwd2.customBox.redPoint:SetActive(not isLock2 and not isGet2)
        self.topPassRwd.advancedRwd2:SetActive(true)
    else
        self.topPassRwd.advancedRwd2:SetActive(false)
    end
end

--[[
/mainRoot/passListContentRoot/rewardListRoot/PassRewardLoopList/Scrollbar Horizontal onValueChanged 
--]]
function PassPanel:scrollbarHorizontal_Scrollbar_onValueChanged(scrollbarHorizontal,value)
   
end

--[[
/mainRoot/passListContentRoot/rewardListRoot/topAdvancedImage/lockButton onClick 
--]]
function PassPanel:lockButton_Button_onClick(lockButton)

    self.animator.enabled = true
    self.animator:Play("PassPanelFirstToSecond")
    self.m_ShowState = 2
    self.mainRoot:SetActive(false)
    self.secondRoot:SetActive(true)

    self:RefreshCharacterAndNameLocal()

    self:RefreshAdvanceView()
    self:__RefreshNavigation()
end

function PassPanel:refreshAllRedPoint()
    self.menuListPanel.menuListToggle1.red:SetActive(RedPointMgr:PassPanelPassPortRedJudge(self.m_openPassData.activityId))
    self.menuListPanel.menuListToggle2.red:SetActive(RedPointMgr:PassPanelWeekTaskRedJudge(self.m_openPassData.activityId))
    self.menuListPanel.menuListToggle3.red:SetActive(RedPointMgr:PassPanelSeasonTaskRedJudge(self.m_openPassData.activityId))
end

function PassPanel:mergePassRewardList(rewardList)
    local rewardMap = {}
    for _, reward in pairs(rewardList) do

        local type, id, num = reward[1], reward[2], reward[3]
        -- 只按 id+类型 合并；key 含 num 时同种货币不同档数量无法并成一条
        local key = id .. "_" .. type
        if rewardMap[key] then
            rewardMap[key][3] = rewardMap[key][3] + num
        else
            rewardMap[key] = clone(reward)
        end
    end

    local rewards = {}
    for _, reward in pairs(rewardMap) do
        tablex.insertproxy(rewards, reward)
    end

    return rewards
end

function PassPanel:PlayLevelUpEfect()
    local lv = self:GetPassServeData().level
    self.curLevelTxt.text.transform.anchoredPosition = Vector2.zero
    self.curLevelTxt.canvasGroup.alpha = 1
    local oldLv = self.curLevelTxt.text.text
    if string.isNullOrEmpty(oldLv) then
       self.curLevelTxt.text.text = tostring(lv)
       return 
    end
    oldLv = tonumber(oldLv)
    oldLv = math.floor(oldLv)
    if oldLv >= lv then
        self.curLevelTxt.text.text = tostring(lv)
       return 
    end
    if self.levelEffectSeq ~= nil then
       self.levelEffectSeq:Kill()
       self.levelEffectSeq = nil 
    end
    local seq = DOTween.Sequence()
    for i = oldLv + 1, lv do
        local lllvvv = i
        ---@type UnityEngine.RectTransform
        local rTrs = self.curLevelTxt.gameObject.transform
        local cg = self.curLevelTxt.canvasGroup
        seq:AppendCallback(function()
            self.curLevelTxt.text.text = tostring(lllvvv)
            self.curLevelTxt.gameObject:SetActive(false)
            self.effect.gameObject:SetActive(false)
            rTrs.anchoredPosition = Vector3.New(0, -30)
            cg.alpha = 0
        end)
        seq:AppendInterval(0.02)
        local tween = rTrs:DOAnchorPosY(0, 0.5)
        tween:SetEase(DG.Tweening.Ease.OutQuad)
        tween:OnStart(function()
            rTrs.gameObject:SetActive(true)
            self.effect:SetActive(true)
        end)
        seq:Append(tween)
        local tween = cg:DOFade(1, 0.5)
        seq:Join(tween)
    end
    self.levelEffectSeq = seq

end

---通行证购买预览列表排序：1.皮肤按表 rank 从高到低 2.其余按配置品质从高到低 3.id 从小到大
---@param rewardList table[]
function PassPanel:sortPassPreviewRewardList(rewardList)
    if rewardList == nil or #rewardList < 2 then
        return
    end
    table.sort(rewardList, function(a, b)
        local ar, aq, aid = self:_passPreviewRewardSortKeys(a)
        local br, bq, bid = self:_passPreviewRewardSortKeys(b)
        if ar ~= br then
            return ar > br
        end
        if aq ~= bq then
            return aq > bq
        end
        if aid ~= bid then
            return aid < bid
        end
        local at, bt = a[1], b[1]
        if at ~= bt then
            return at < bt
        end
        return (a[3] or 0) < (b[3] or 0)
    end)
end

---@return integer skinRankOr0ForNonSkin, integer quality, integer id
function PassPanel:_passPreviewRewardSortKeys(reward)
    local rType = reward[1]
    local id = reward[2] or 0
    local skinRank = 0
    local quality = 0
    if rType == GE.RewardType.Skin then
        local skinCfg = Config.GetCharacterSkinInfo(id)
        if skinCfg then
            skinRank = skinCfg.rank or 0
        end
    elseif rType == GE.RewardType.ItemProp then
        local itemCfg = Config.GetItemInfo(id)
        if itemCfg then
            quality = itemCfg.quality or 0
        end
    elseif rType == GE.RewardType.Weapon then
        local wCfg = Config.GetWeaponInfo(id)
        if wCfg then
            quality = wCfg.rare or 0
        end
    elseif rType == GE.RewardType.Equipment then
        local eCfg = Config.GetEquipmentInfo(id)
        if eCfg then
            quality = eCfg.quality or 0
        end
    elseif rType == GE.RewardType.Character then
        local cCfg = Config.GetCharacterInfo(id)
        if cCfg then
            quality = cCfg.baseStar or 0
        end
    end
    return skinRank, quality, id
end

return PassPanel
