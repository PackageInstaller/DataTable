---@class MaterialLevelPanel : MaterialLevelPanel_Generate
---##################### 【MaterialLevelPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【MaterialLevelPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local MaterialLevelPanel = require "MaterialLevelPanel_Generate"

function MaterialLevelPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.RefreshMaterilalLevelPanel, function()
            self:setMaterialLevelData(self.chapterIdList[self.selectDeepType])
            self:setTypeBoxList()
        end}, 
	}
    self.selectDeepType = 0
    self.nowSelectLevelBox = nil
    self.levelBoxList = {}
    self.nowSelectTypeBox = nil
    self._materialType = nil    --章节类型
    self.needStrenigthNum = 0  --进入关卡需要的体力
    self.newClearLevelBox = nil --最新通关的关卡格子
    self.isOpen = false

    --点击穿透监听
    self.closeDetailBtn.pointerListener.onPointerClickEvent = function()
        self:selectLevelBox()
        DLuaTimer:DoAfter(0.05, function()
            if not self.nowSelectLevelBox then
                self.animator:SetTrigger("HideDetails")
            end
		end)
    end
end

function MaterialLevelPanel:InitPanel(data)
    --根据未来需求跳转到默认页签，目前默认打开第一页签
    if data and data.selectDeepType then
        self.selectDeepType = data.selectDeepType
    else
        self.selectDeepType = SeaMapMgr:getNowMaterialDeepType() or 1
        SeaMapMgr:setNowMaterialDeepType(nil)
    end
    if data and data.selLevelIndex then
        self.selLevelIndex = data.selLevelIndex
    else
        self.selLevelIndex = nil
    end
    self:setMaterialLevelData(self.chapterIdList[self.selectDeepType], self.selLevelIndex)

    self:setTypeBoxList()
    --导航栏
    --材料章节类型对应导航类型
    local chapterTypeToNavigation = {
        [GE.ChapterDeepType.Exp] = GE.NavigationType.MaterialLevelPanel_Exp,
        [GE.ChapterDeepType.Skill] = GE.NavigationType.MaterialLevelPanel_Skill,
        [GE.ChapterDeepType.Technology] = GE.NavigationType.MaterialLevelPanel_Tech,
        [GE.ChapterDeepType.Equip] = GE.NavigationType.MaterialLevelPanel_Equip,
    }
    local NavigationId = chapterTypeToNavigation[self._materialType]
    if NavigationId then
        self.customBackPanel.customBackPanel:Bind(NavigationId, self)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self.initMask.canvasGroup.blocksRaycasts = true
            self.initMask.canvasGroup:DOFade(1, 0.33)
            self.animator:SetTrigger("Out")
            self.animOverCallBack:SetCallBackOfName(function(name)
                if name == "ClosePanel" then
                    self.animOverCallBack:SetCallBackOfName(nil)
                    UIMgr:closeSpecificUI(self)
                end
            end)
        end)
    end
end

--function MaterialLevelPanel:StartCreating(time)
--
--end

--function MaterialLevelPanel:StartEnter(time)
--
--end

--function MaterialLevelPanel:StartRemoving(time)
--
--end

--function MaterialLevelPanel:StartExit(time)
--
--end

function MaterialLevelPanel:OnOpen(data, initiative)
    --LuaLogger.ds(">>>>>>>>data<<<<<<<<", tablex.dump(data))
    self.isOpen = true
    self.chapterIdList = data and data.chapterIdList
    self._materialType = data and data.materialType
    self.openFinishFunc = data and data.openFinishFunc
    self:InitPanel(data)
    LoadingMgr:SetLoadingOver(function()
        if CoveManager.instance() then
            CoveManager.instance():SetHomelandShowOrHide(false)
        end
    end, nil, "MaterialLevelPanel")
end

function MaterialLevelPanel:setMaterialLevelData(chapterId, selLvIndex)
    local chapterConfig = Config.GetChapterInfo(chapterId)
    local levelList = chapterConfig.PveLevel
    local deepType = chapterConfig.DeepType
    self.m_chapterConfig = chapterConfig
    
    local loadCount = 0
    self.levelBoxList = {}
    self.newClearLevelBox = nil
    --LuaLogger.ds(">>>>>>>^^^<<<<<<<", tablex.dump(levelList))
    self:FillTemplateContent(self.levelBox, self.levelBoxGroup, #levelList, function (index,levelBox)
        local levelConfig = Config.GetPveLevelInfo(levelList[index][1])

        --设置关卡位置
        local boxPos = levelList[index][2]
        levelBox.rectTransform.anchoredPosition = Vector2.New(boxPos[1], boxPos[2])

        --判断关卡是否解锁
        local isLocked = false
        if next(levelConfig.unlock) then
            for _, v in pairs(levelConfig.unlock) do
                local unlockType = v[1]
                if unlockType == GE.CommonLockJudgeType.Level then--关卡解锁
                    local levelData = Me:getLevelDataByid(v[2])
                    if not levelData or levelData.state == GE.LevelStateType.Going then
                        isLocked = true
                        break
                    end
                end
            end
        end
        levelBox.isLocked:SetActive(isLocked)
        levelBox.line.image.color = isLocked and Color.NewFromStr("4D4D4D") or Color.NewFromStr("FFFFFF")
        levelBox.levelName.text.text = levelConfig.nameKey
        local levelData = Me:getLevelDataByid(levelConfig.id)
        if levelData and levelData.state == GE.LevelStateType.Finish then
            self.newClearLevelBox = levelBox
        end
        levelBox.isClear:SetActive(levelData and levelData.state == GE.LevelStateType.Finish)
        levelBox.goBtn.scaleButton.onClick:RemoveAllListeners()
        levelBox.goBtn.scaleButton.onClick:AddListener(function ()
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            if isLocked then
                UICommonUtils.PopToast(LocalStrEnum.PassPreLevelUnlock)
            else
                self:selectLevelBox(levelBox)
                self:setLevelInfo(levelConfig)
            end
        end)
        if selLvIndex and selLvIndex == index then
            DLuaTimer:DoAfter(0.5, function()
                self:selectLevelBox(levelBox)
                self:setLevelInfo(levelConfig)
            end)
        end

        --设置细分类型图标
        local levelType = string.format(Config.SpritePath.MaterialLevelType, levelConfig.MaterialLevelType)
        self:LoadSpriteAsync(levelType, levelBox.typeIcon.image)

        --设置格子连线
        table.insert(self.levelBoxList, levelBox)
        loadCount = loadCount + 1
        if loadCount == #levelList then
            self:setBoxLine()
            if self.openFinishFunc then
                self.openFinishFunc()
            end

            --设置拖动框长度
            local beginPosX = levelList[1][2][1]
            local endPosX = levelList[#levelList][2][1]
            local rootTransform =  UIMgr:GetUICanvasRoot():GetComponent("RectTransform")
            local screen_width = rootTransform.rect.width
            local length = endPosX + beginPosX + (screen_width / 2)
            self.levelBoxGroup.rectTransform.sizeDelta = Vector2.New(length, self.levelBoxGroup.rectTransform.sizeDelta.y)

            --根据最新通关id设置初始位置
            if selLvIndex and selLvIndex > 2 then
                --如果是从其他页面跳转过来，且选择的关卡在第三个之后，则自动将关卡格子移动到屏幕中心
                self:autoMoveBoxToCenter(self.levelBoxList[selLvIndex])
            elseif self.newClearLevelBox then
                self:autoMoveBoxToCenter(self.newClearLevelBox)
            else
                self:autoMoveBoxToCenter(self.levelBoxList[1])
            end
        end
    end)

    --加载背景图
    local mapName = chapterConfig.MapBG
    self:LoadSpriteAsync(string.format(Config.SpritePath.LevelMapPicturePath, mapName), function (s)
        self.imgBg.image.sprite = s
        self:playShowAnimation()
    end)

    --设置细分类型图标
    local deepTypeIconPath = string.format(Config.SpritePath.LevelDeepTypeIconPath, deepType)
    self:LoadSpriteAsync(deepTypeIconPath, self.levelTypeIcon.image)

    --self.levelTypeTxt.text.text = LocalStrEnum["chaperMainName"..deepType]

    --额外奖励显示
    local extraRewards = Me:getExtraRewardsData()
    for _, weekday in pairs(chapterConfig.ExtraRewardTime) do
        if weekday == DLuaUtil.getWeekDayWithOffset(Me.servertime) and extraRewards[deepType].count > 0 then
            self.topLine:SetActive(true)
            self.doubleCountTxt.text.text = string.format(LocalStrEnum.PveExtraRewardDec, extraRewards[deepType].count + (extraRewards[deepType].extraCount or 0))
            break
        else
            self.topLine:SetActive(false)
        end
    end

    self:RefreshLevelCount()
end

function MaterialLevelPanel:selectLevelBox(levelBox)
    if self.nowSelectLevelBox then
        self.nowSelectLevelBox.isSelect:SetActive(false)
    end
    if levelBox then
        self.nowSelectLevelBox = levelBox
        self.nowSelectLevelBox.isSelect.image.color = Color.New(1, 1, 1, 0)
        self.nowSelectLevelBox.selectFrame.transform.localScale = Vector3.New(1.1, 1.1, 1)
        self.nowSelectLevelBox.isSelect:SetActive(true)
        self.nowSelectLevelBox.isSelect.image:DOFade(1, 0.2)
        self.nowSelectLevelBox.selectFrame.transform:DOScale(Vector3.New(1, 1, 1), 0.2)
        if self.levelDetails.canvasGroup.alpha == 0 then
            self.animator:SetTrigger("ShowDetails")
        end
    else
        self.nowSelectLevelBox = nil
    end
end

---@param levelConfig PveLevelTable
function MaterialLevelPanel:setLevelInfo(levelConfig)
    self.selectLevelId = levelConfig.id
    self.levelNameText.text.text = levelConfig.nameKey
    self.levelNameShadowText.text.text = levelConfig.nameKey
    self.levelCountTxt.text.text = levelConfig.title
    self.recLevelText.text.text = levelConfig.recommendLevel

    self.winCondition.conditionTxt.text.text = levelConfig.victoryDesKey
    self.defCondition.conditionTxt.text.text = levelConfig.failDesKey

    local rewardList = {}

    --材料关卡没有首通奖励
    for _, reward in pairs(levelConfig.nomalDropShow) do
        table.insert(rewardList, reward)
    end

    self:FillTemplateContent(self.customBox, self.rewardList, #rewardList, function (index, itemObj)
        local customBox = itemObj.customBox
        local rewardData = rewardList[index]
        --[[local data = {
            id = rewardData[2],
            isFrist = rewardData.isFrist,
        }
        if rewardData[1] == GE.RewardType.ItemProp then
            data.itemType = GE.ItemTypeIndex.item
        elseif rewardData[1] == GE.RewardType.Equipment then
            data.itemType = GE.ItemTypeIndex.equip
        elseif rewardData[1] == GE.RewardType.Weapon then
            data.itemType = GE.ItemTypeIndex.weapon
        end
        if rewardData[3] ~= 0 then
            data.itemNum = rewardData[3]
        end]]
        customBox:setMono(self)
        customBox:SetUIData(rewardData)
    end)

    self:LoadSpriteAsync(string.format(Config.SpritePath.MaterialLevelBanner, levelConfig.MaterialLevelBanner), self.levelNameBg.image)

    self.needStrenigthNum = levelConfig.enterCost[2] + levelConfig.victoryCost[2]
    self.goStrengthText.text.text = "x"..self.needStrenigthNum

    --边缘格子位置归正
    self:autoMoveBoxToCenter(self.nowSelectLevelBox, true)

    local showCount = levelConfig.cleanNum ~= -1
    self.lastCountInfo:SetActive(showCount)
    if showCount then
        local levelInfo = Me:getLevelDataByid(levelConfig.id)
        local curCount = (levelInfo and levelInfo.dailyBattleNum) or 0
        local addCount = Me:GetCycleCardPrivilegeAddCount(PrivilegeType["LevelMapCleanAddCount_" .. levelConfig.typemain])
        local lastCount = levelConfig.cleanNum + addCount - (curCount)

        local str = lastCount
        if lastCount == 0 then
            str = "<color=red>" .. lastCount .. "</color>" 
        end
        self.lastCountText.text.text = string.format(LocalStrEnum.leveltips_001, str)
    end

    self:RefreshLevelCount()
end

--边缘格子位置归正
function MaterialLevelPanel:autoMoveBoxToCenter(needLevelBox, needDoTween)
    local UICamera = UIMgr.uiCamera
    local rootTransform =  UIMgr:GetUICanvasRoot():GetComponent("RectTransform")
    local nowBoxScreenPos = UICamera:WorldToScreenPoint(needLevelBox.transform.position)
    local nowBaseScreenPos = UICamera:WorldToScreenPoint(rootTransform.position)
    local checkScreenPosX = nowBaseScreenPos.x - nowBoxScreenPos.x
    local moveX = 0
    local nowBoxGroupPos = nil
    if checkScreenPosX > 620 then --向右移动
        moveX = checkScreenPosX - 620
        nowBoxGroupPos = self.levelBoxGroup.rectTransform.anchoredPosition
    elseif checkScreenPosX < -170 then --向左移动
        moveX = checkScreenPosX - 170
        nowBoxGroupPos = self.levelBoxGroup.rectTransform.anchoredPosition
    end
    if not nowBoxGroupPos then
        return
    end
    local newPosX = math.min(nowBoxGroupPos.x + moveX, 0)
    newPosX = math.max(newPosX, self.scrollView.transform.sizeDelta.x - self.levelBoxGroup.transform.sizeDelta.x)
    if needDoTween then
        self.levelBoxGroup.rectTransform:DOAnchorPos(Vector2.New(newPosX, 0), 0.3)
    else
        self.levelBoxGroup.rectTransform.anchoredPosition = Vector2.New(newPosX, 0)
    end
end

--设置格子连线
function MaterialLevelPanel:setBoxLine()
    for i = 1, #self.levelBoxList do
        local nowBox = self.levelBoxList[i]
        local nextBox = self.levelBoxList[i + 1]
        if nextBox then
            local nowBoxPos = nowBox.startPoint.transform.position
            local nextBoxPos = nextBox.endPoint.transform.position
            local dir = nextBoxPos - nowBoxPos  -- 计算方向向量
            local angle = math.deg(math.atan2(dir.y, dir.x))  -- 计算角度，转成度数
            nowBox.line.transform.rotation = Quaternion.Euler(0, 0, angle)  -- 设置旋转角度

            local UICamera = UIMgr.uiCamera
            local nowScreenPoint = UICamera:WorldToScreenPoint(nowBoxPos)
            local _,nowScreenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(
            self.levelBoxGroup.rectTransform, Vector2.New(nowScreenPoint.x, nowScreenPoint.y), UICamera, nil)
            local nextScreenPos = UICamera:WorldToScreenPoint(nextBoxPos)
            local _,nextScreenPos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(
            self.levelBoxGroup.rectTransform, Vector2.New(nextScreenPos.x, nextScreenPos.y), UICamera, nil)
            local distance = Vector2.Distance(nowScreenPos, nextScreenPos)  -- 计算屏幕坐标下的距离
            nowBox.line.rectTransform.sizeDelta = Vector2.New(distance, 4)  -- 设置长度
        end
        nowBox.line:SetActive(nextBox ~= nil)
    end
end

function MaterialLevelPanel:setTypeBoxList()
    local deepTypeNum = #self.chapterIdList
    local topLinePos = self.topLine.rectTransform.anchoredPosition
    if deepTypeNum <= 1 then
        self.typeBoxListBg:SetActive(false)
        self.levelTypeTxt.text.text = LocalStrEnum["chaperMainName"..self.m_chapterConfig.DeepType]
        self.topLine.rectTransform.anchoredPosition = Vector2.New(topLinePos.x, 36.5)
        return
    else
        self.typeBoxListBg:SetActive(true)
        self.topLine.rectTransform.anchoredPosition = Vector2.New(topLinePos.x, 163.5)
    end

    local useTypeBox  = self.typeBox

    if self.m_chapterConfig.OpenTime then
        useTypeBox = self.typeBox2

        --找出所有开启的关卡
        local unlockList = {}
        for index = 1, deepTypeNum, 1 do
            local chapterId = self.chapterIdList[index]
            local chapterConfig = Config.GetChapterInfo(chapterId)
            if self:IscanOpenWithOpenTime(chapterConfig.OpenTime) then
                table.insert(unlockList,index)
            end
        end
        --如果当前关卡不在内部 ，开启管钱
        if not tablex.contains(unlockList,self.selectDeepType) then
            self.selectDeepType = unlockList[1]
        end
    end

    self:FillTemplateContent(useTypeBox, self.typeBoxList, deepTypeNum, function (index,typeBox)
        local chapterId = self.chapterIdList[index]
        local chapterConfig = Config.GetChapterInfo(chapterId)
        typeBox.typeText.text.text = chapterConfig.name
        if typeBox.typeText2 then
            typeBox.typeText2.text.text = chapterConfig.name
        end
        
        if index == self.selectDeepType then
            self:selectTypeBox(typeBox)
            self:setMaterialLevelData(chapterId)
        end
        
        local chapterType = string.format(Config.SpritePath.MaterialChapterType, chapterConfig.MaterialChapterType)
        self:LoadSpriteAsync(chapterType, function(sprite)
            typeBox.typeIcon.image.sprite = sprite
            if typeBox.typeIcon2 then
                typeBox.typeIcon2.image.sprite = sprite
            end
        end)
        typeBox.scaleButton.onClick:RemoveAllListeners()
        typeBox.scaleButton.onClick:AddListener(function ()
            if self.selectDeepType == index then
                return
            end
            if chapterConfig.OpenTime then
                if not self:IscanOpenWithOpenTime(chapterConfig.OpenTime) then
                    UICommonUtils.PopToast(LocalStrEnum["NotOpenToday"])
                    return
                end
            end
            UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
            self.animator:SetTrigger("ChangeType")
            self:selectTypeBox(typeBox)
            self:setMaterialLevelData(chapterId)
            self.selectDeepType = index
        end)

        if chapterConfig.OpenTime then
            local weekStr = self:GetWeekCapitalNum(chapterConfig.OpenTime)
            if typeBox.timeDest2 then
                typeBox.timeDest2.text.text = "周"..weekStr.."开启"
            end
            typeBox.timeDest.text.text = "周"..weekStr.."开启"

            if self:IscanOpenWithOpenTime(chapterConfig.OpenTime) then
                typeBox.lockBack:SetActive(false)
                typeBox.openBack:SetActive(true)
            else
                typeBox.lockBack:SetActive(true)
                typeBox.openBack:SetActive(false)
            end

        else

        end

    end)
end

local CapitalNumArray = {"一", "二", "三", "四", "五", "六", "日"}
function MaterialLevelPanel:GetWeekCapitalNum(tOpenTime)
    local capitalNumStr = ""
    if tOpenTime == nil then
        tOpenTime = {}
    end

    for index = 1, #tOpenTime, 1 do
        capitalNumStr = capitalNumStr..CapitalNumArray[tOpenTime[index]]
    end
    return capitalNumStr
end

function MaterialLevelPanel:IscanOpenWithOpenTime(tOpenTime)
    if tOpenTime == nil then
        tOpenTime = {}
    end
    for index = 1, #tOpenTime, 1 do
        local weekday = tOpenTime[index]
        if weekday == DLuaUtil.getWeekDayWithOffset(Me.servertime) then
            return true
        end

    end
    return false
end
function MaterialLevelPanel:selectTypeBox(typeBox)
    if self.nowSelectTypeBox then
        self.nowSelectTypeBox.isSelect:SetActive(false)
    end
    self.nowSelectTypeBox = typeBox
    self.nowSelectTypeBox.isSelect:SetActive(true)

    self.levelTypeTxt.text.text = self.nowSelectTypeBox.typeText.text.text

    if self.nowSelectLevelBox then
        self.animator:SetTrigger("HideDetails")
        self.nowSelectLevelBox.isSelect:SetActive(false)
        self.nowSelectLevelBox = nil
    end
end

--进入动画
function MaterialLevelPanel:playShowAnimation()
    if self.isOpen then
        self.initMask.canvasGroup:DOFade(0, 0.33):OnComplete(function()
            self.initMask.canvasGroup.blocksRaycasts = false
        end)
        self.animator:SetTrigger("InitShow")
        GuideMgr:StartGuideTrigger("MaterialLevelPanel")
        self.isOpen = false
    end
end

--function MaterialLevelPanel:OnClose(initiative)
--
--end 

--function MaterialLevelPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function MaterialLevelPanel:OnRefresh(data)
--
--end

--[[
/MapPanel_M/Mask/LevelDetails/AutoBattle onClick 
--]]
function MaterialLevelPanel:autoBattle_ScaleButton_onClick(autoBattle)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local levelData = Me:getLevelDataByid(self.selectLevelId)

    local lastCount = self:GetPveLevelLastCount()
    if lastCount == 0 then
        UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_CleanNumNotEnough)
        return
    end

    if levelData and levelData.state == GE.LevelStateType.Finish then
        UIMgr:popUICover("BattleRepeatPanel",{levelId = self.selectLevelId})
    else
        UICommonUtils.PopToast("扫荡战斗未解锁，请三星通关关卡！")
    end
end

--[[
/LevelDetails/GoBattle onClick 
--]]
function MaterialLevelPanel:goBattle_ScaleButton_onClick(goBattle)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local isEnough = Me:checkNormalTicket(self.needStrenigthNum)
    if not isEnough then
        UIMgr:popUICover("BuyTicketPanel", {})
        return
    end

    local levelId =  self.selectLevelId
    local levelConfig = Config.GetPveLevelInfo(levelId)
    if levelConfig.cleanNum ~= -1 then
        local levelInfo = Me:getLevelDataByid(levelId)
        local curCount = (levelInfo and levelInfo.dailyBattleNum) or 0
        
        local addCount = Me:GetCycleCardPrivilegeAddCount(PrivilegeType["LevelMapCleanAddCount_" .. levelConfig.typemain])
        local lastCount = levelConfig.cleanNum + addCount - (curCount)
        if lastCount <= 0 then
            UICommonUtils.PopToast(LocalStrEnum.ActionFailReason_CleanNumNotEnough)
            return
        end
    end

    SeaMapMgr:setNowMaterialDeepType(self.selectDeepType)
    Me:setNowSelectLevel(self.selectLevelId)
    LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "MaterialLevelPanel2")
end

--[[
/TipsBtn onClick 
--]]
function MaterialLevelPanel:tipsBtn_ScaleButton_onClick(tipsBtn)

end

--[[
/LevelDetails/CloseDetailBtn onClick 
--]]
function MaterialLevelPanel:closeDetailBtn_Button_onClick(closeDetailBtn)
    --不在此处使用
end

--[[
/CustomBackPanel/HelpBtn onClick 
--]]
function MaterialLevelPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/LevelDetails/HideRewardBtn onClick 
--]]
function MaterialLevelPanel:hideRewardBtn_ScaleButton_onClick(hideRewardBtn)

end

--[[
/MapPanel_M/Mask/LevelDetails/EnemyBtn onClick 
--]]
function MaterialLevelPanel:enemyBtn_ScaleButton_onClick(enemyBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUICover("LevelMapMsgPanel", {id = self.chapterIdList[self.selectDeepType], levelId = self.selectLevelId, mode = 1})
end

function MaterialLevelPanel:GetPveLevelLastCount()
    if self.selectLevelId == nil then
        return -1
    end
    local levelConfig = Config.GetPveLevelInfo(self.selectLevelId)
    if levelConfig == nil then
        return -1
    end
    local showCount = levelConfig.cleanNum ~= -1
    self.lastCountInfo:SetActive(showCount)
    if showCount then
        local levelInfo = Me:getLevelDataByid(levelConfig.id)
        local curCount = (levelInfo and levelInfo.dailyBattleNum) or 0

        local addCount = Me:GetCycleCardPrivilegeAddCount(PrivilegeType["LevelMapCleanAddCount_" .. levelConfig.typemain])
        local lastCount = levelConfig.cleanNum + addCount - (curCount)
        lastCount = math.max(0, lastCount)
        return lastCount
    end
    return -1
end

function MaterialLevelPanel:RefreshLevelCount()
    local lastCount = self:GetPveLevelLastCount()
    self.lastCountInfo:SetActive(lastCount ~= -1)
    if lastCount == -1 then
        return
    end
    local str = lastCount
    if lastCount == 0 then
        str = "<color=red>" .. lastCount .. "</color>" 
    end
    self.lastCountText.text.text = string.format(LocalStrEnum.leveltips_001, str)
end

return MaterialLevelPanel
