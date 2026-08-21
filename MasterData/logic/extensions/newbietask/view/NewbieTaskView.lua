-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbietask/view/NewbieTaskView.lua

module("logic.extensions.newbietask.view.NewbieTaskView", package.seeall)

local M = class("NewbieTaskView", ViewComponent)
local HeroPos = Vector3.New(49.841, -1.51, 3.693)
local HeroAngle = Vector3.New(0, 167.2154, 0)
local FOV = 20
local LightRot = Vector3.New(68.8, -46.5, 0)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)

	self._colorFade = Color.New(1, 1, 1, 0)
	self._canvasGroupHero = self:getUIComponent("newhand_task_view_-827968351", ComponentType.CanvasGroup)
	self._rawImageHero = self:getUIComponent("newhand_task_view_-986017559", UIComponentType.RawImage)

	goutil.setActive(self._canvasGroupHero.gameObject, true)

	self._photoUnit = Astral.PhotoBase.Add(self._rawImageHero.gameObject)
	self._txtRoleName = goutil.findChildTextComponent(self.mainGO, "info/txtName")
	self._btnCheck = self:getBtnByPath("info/btnCheck")
	self._imgRoleQuality = self:getGo("newhand_task_view_-1349371135")
	self._imgRoleQualityLetter = self:getGo("newhand_task_view_1306328750")

	local tabRoot = self:getRectTransform("newhand_task_view_-1360718061")

	self._tagDayText = {
		goutil.findChildTextComponent(tabRoot, "tog1/text"),
		goutil.findChildTextComponent(tabRoot, "tog2/text"),
		goutil.findChildTextComponent(tabRoot, "tog3/text"),
		goutil.findChildTextComponent(tabRoot, "tog4/text"),
		goutil.findChildTextComponent(tabRoot, "tog5/text"),
		goutil.findChildTextComponent(tabRoot, "tog6/text"),
		goutil.findChildTextComponent(tabRoot, "tog7/text")
	}
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(function(index)
		local group = self._weekTab and self._weekTab:getSelectWeek()

		return self._tabCheckFunc((group - 1) * 7 + index)
	end)

	self._tabEntryLocks = {}
	self._tabRedDot = {}
	self._tabEntryTextCanvasGroup = {}
	self._tabFinish = {}

	for i = 0, tabRoot.childCount - 1 do
		local index = i + 1
		local tmpGo = tabRoot:GetChild(i).gameObject
		local tab = goutil.addComponentOnce(tmpGo, UIComponentType.SpaceXToggle)

		self._toggleTabControl:addToggleTab(tab)
		table.insert(self._tabEntryLocks, goutil.findChild(tmpGo, "text/lock").gameObject)
		table.insert(self._tabRedDot, goutil.findChild(tmpGo, "red_point").gameObject)
		table.insert(self._tabEntryTextCanvasGroup, goutil.findChildTextComponent(tmpGo, "text"))
		table.insert(self._tabFinish, goutil.findChild(tmpGo, "text/done").gameObject)
	end

	self._txtStepPointProcess = self:getText("newhand_task_view_1836087821")
	self._stepPointComps = {}
	self._stepPointMax = {
		[1] = 1,
		[2] = 1
	}

	local stepRewardLst = NewbieTaskConfig.instance:getStepRewardLst()
	local maxStepPoint = #stepRewardLst
	local goStepPointRoot = self:getGo("newhand_task_view_75979062")

	self._rewardCell = {}

	for i = 1, 5 do
		table.insert(self._rewardCell, goutil.findChild(goStepPointRoot, string.format("cell%s/backpack_item", i)).gameObject)
	end

	self._rewardData = {}

	for i = 1, maxStepPoint do
		local data = {}
		local cfg = stepRewardLst[i]
		local stepPoint = cfg.stepPoint

		if stepPoint >= self._stepPointMax[cfg.group] then
			self._stepPointMax[cfg.group] = stepPoint
		end

		data.cfg = cfg
		data.preStepPoint = stepRewardLst[i - 1] and stepRewardLst[i - 1].stepPoint or 0

		if i == 6 then
			data.preStepPoint = 0
		end

		local idx = i

		if idx > 5 then
			idx = idx - 5
		end

		data.goMarkReach = goutil.findChild(goStepPointRoot, string.format("cell%s/img1", idx)).gameObject
		data.goMarkUnReach = goutil.findChild(goStepPointRoot, string.format("cell%s/img2", idx)).gameObject
		data.txtPoint = goutil.findChildTextComponent(goStepPointRoot, string.format("cell%s/txtProgress", idx))
		data.txtPoint.text = stepPoint

		local itemId, itemCount = NewbieTaskConfig.instance:str2ItemIdCount(cfg.reward)
		local numVisible = not ItemUtil.isCharacterById(itemId)
		local itemData = ItemUtil.createItemData({
			itemId = itemId
		})

		itemData:setCount(itemCount)
		table.insert(self._rewardData, itemData)

		local goItemCell = self._rewardCell[idx]

		goutil.setActive(goItemCell, true)

		data.rewardCell = Astral.LuaComponentContainer.Add(goItemCell, NewbieStepRewardItemCell)

		data.rewardCell:setStepPoint(stepPoint)
		data.rewardCell:updateData(itemData)
		data.rewardCell:getComponent("num"):setVisible(numVisible)
		table.insert(self._stepPointComps, data)
	end

	self._stepFillGroup = {
		self:getImage("newhand_task_view_1333265568"),
		self:getImage("newhand_task_view_-1170138981"),
		self:getImage("newhand_task_view_432568168"),
		self:getImage("newhand_task_view_-1094573433"),
		self:getImage("newhand_task_view_911069976"),
		self:getImage("newhand_task_view_194549632")
	}
	self._loopList = LoopListHelper.New(self:getGo("newhand_task_view_-1031351649"))

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._loopListView = self._loopList:GetLoopListView()
	self._content = goutil.findChild(self:getGo("newhand_task_view_-1031351649"), "view/content")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._middleAni = goutil.addComponentOnce(goutil.findChild(self.mainGO, "middle"), typeof(Astral.GUITimelineAniLua))
	self._imgHero = goutil.findChildImageComponent(self.mainGO, "CharacterImg/imgHero")
	self._goCareer = goutil.findChild(self.mainGO, "info/career")
	self._dotweenSeq = {}
	self.tabComp = Astral.LuaComponentContainer.Add(goutil.findChild(self.mainGO, "left_tab_content"), LeftTabComp)

	self.tabComp:setActiveTabIndexLst({
		1,
		2
	})
	self.tabComp:setRedPointTypeStrong()

	self._weekTabControl = ToggleTabControl.New()
	self._weekTab = NewbieTaskWeekTab.New()

	self._weekTab:init(self)
	self._weekTabControl:setViewPager(self._weekTab)
	self._weekTabControl:setTabCheckFunc(self._weekTabCheck)
	self._weekTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_1", UIComponentType.SpaceXToggle))
	self._weekTabControl:addToggleTab(goutil.findChildComponent(self.mainGO, "left_tab_content/rightTabList/tab_2", UIComponentType.SpaceXToggle))

	if NewbieTaskConfig.instance:getMaxDay() <= 7 then
		goutil.setActive(goutil.findChild(self.mainGO, "left_tab_content"), false)
	end

	self._weekLock = {
		goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_1/normal/done"),
		goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_1/select/done"),
		goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_2/normal/done"),
		goutil.findChild(self.mainGO, "left_tab_content/rightTabList/tab_2/select/done")
	}
end

function M:destroyUI()
	self._photoUnit = nil

	self._toggleTabControl:destroy()
	self._weekTabControl:destroy()

	self._toggleTabControl = nil
	self._weekTabControl = nil

	self._loopList:Dispose()

	self._loopList = nil

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
	NewbieTaskModel.instance:clearRecord()
end

function M:bindEvents()
	self._btnCheck:AddClickListener(self._onClickCheck, self)
end

function M:unbindEvents()
	self._btnCheck:RemoveClickListener()
end

function M:onEnter()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
	self.tabComp:setCanvasGroupShow(true)
	self.tabComp:onEnter()

	local recordWeek, recordDay = NewbieTaskModel.instance:getRecordJump()

	if recordWeek and recordDay then
		self._weekTabControl:selectTab(recordWeek)
	else
		local defualtTabIndex = 1

		if NewbieTaskModel.instance:getDefaultShowOpenDay() > 7 then
			defualtTabIndex = 2
		end

		self._weekTabControl:selectTab(defualtTabIndex)
	end

	self.tabComp:playGuiAniTab(true, not self._viewPresentor:getIsBackOpen(), self._weekTab:getSelectWeek())
	MainScenePerformUtil.setBgHeroShow(false, true, true)
	self:setEvent(true)
	NewbieTaskAgent.instance:sendGetTaskListRequest()

	local heroId = NewbieTaskConfig.instance:getConstByKey("DisplayHero")
	local skinId = false

	if self._weekTab:getSelectWeek() == 2 then
		skinId = NewbieTaskConfig.instance:getConstByKey("DisplayHeroSkin")
	end

	self:refreshHeroShow(heroId, skinId)
	self:_setHeroLight()
end

function M:onExit(reasonTyp)
	self.tabComp:onExit()
	self.tabComp:setCanvasInteractable(false)

	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	self.tabComp:playGuiAniTab(false, isNormalClose)

	for _, tweener in ipairs(self._dotweenSeq or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._dotweenSeq = {}

	local cam = PhotoBaseExtension.GetCamera(self._photoUnit)

	if cam then
		cam.enabled = false
	end

	self._canvasGroupHero:DOKill(false)
	self:setEvent(false)

	self._activeIndex = nil

	MainScenePerformUtil.showTmpHero(false)
	self:_resetHeroLight()
end

function M:onExitFinished()
	if not self._photoUnit.IsOn then
		return
	end

	local cam = PhotoBaseExtension.GetCamera(self._photoUnit)

	self._photoUnit:SetCameraPosition(0, 0, 0)
	self._photoUnit:SetCameraRotation(0, 0, 0)
	self._photoUnit:TurnOff()

	if cam then
		cam.enabled = true
	end
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.NEWBIE_STEP_REWARD_CLICK, self._handleNewbieStepRewardClick, self)
		GlobalDispatcher:addEventListener(EventType.NEWBIE_TASK_INFO_CHANGE, self._handleNewbieTaskInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.NEWBIE_STEP_POINT_CHANGE, self._handleNewbieStepPointChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.NEWBIE_STEP_REWARD_CLICK, self._handleNewbieStepRewardClick, self)
		GlobalDispatcher:removeEventListener(EventType.NEWBIE_TASK_INFO_CHANGE, self._handleNewbieTaskInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.NEWBIE_STEP_POINT_CHANGE, self._handleNewbieStepPointChange, self)
	end
end

function M:_handleNewbieStepRewardClick(e, cell)
	local data = cell:getData()
	local stepPoint = cell:getStepPoint()
	local group = self._weekTab:getSelectWeek()
	local rewardStatus = NewbieTaskModel.instance:getStepPointRewardStatus(stepPoint, group)

	self:recordJump()

	if rewardStatus == CommEnum.RewardEnum.CanNotGot then
		GlobalDispatcher:dispatchEvent(data:getItemMarkType(), data, cell:getGo(), 0, true)
	elseif rewardStatus == CommEnum.RewardEnum.HasGot then
		GlobalDispatcher:dispatchEvent(data:getItemMarkType(), data, cell:getGo(), 0, true)
	elseif rewardStatus == CommEnum.RewardEnum.CanGot then
		self:_receiveAllReward(group)
	end
end

function M:_receiveAllReward(group)
	local stepPoints = {}
	local stepRewardLst = NewbieTaskConfig.instance:getStepRewardLst()
	local maxStepPoint = #stepRewardLst

	for i = 1, maxStepPoint do
		if stepRewardLst[i].group == group then
			local stepPoint = stepRewardLst[i].stepPoint
			local rewardStatus = NewbieTaskModel.instance:getStepPointRewardStatus(stepPoint, group)

			if rewardStatus == CommEnum.RewardEnum.CanGot then
				table.insert(stepPoints, stepPoint)
			end
		end
	end

	NewbieTaskAgent.instance:sendTakeStepRewardRequest({
		group = group,
		stepPoints = stepPoints
	})
end

function M:_handleNewbieTaskInfoChange(e)
	local maxDay = NewbieTaskConfig.instance:getMaxDay()
	local moLst
	local resetPos = true

	self.tabComp:setLock(2, NewbieTaskModel.instance:getCurUnlockMaxDay() <= 7, nil, true)

	for i = 1, maxDay do
		local canTab = self._tabCheckFunc(i)
		local isFinish = NewbieTaskModel.instance:getIsFinishDay(i)
		local pos = i > 7 and i - 7 or i

		if self._weekTab:getSelectWeek() == 1 and i <= 7 or self._weekTab:getSelectWeek() == 2 and i > 7 then
			goutil.setActive(self._tabEntryLocks[pos], not canTab)
			goutil.setActive(self._tabFinish[pos], canTab and isFinish)
		end
	end

	if not self._activeIndex then
		local recordWeek, recordDay = NewbieTaskModel.instance:getRecordJump()

		if recordWeek and recordDay then
			self._toggleTabControl:selectTab(recordDay)
		else
			local defualtTabIndex = NewbieTaskModel.instance:getDefaultShowOpenDay()

			if defualtTabIndex > 7 then
				defualtTabIndex = defualtTabIndex - 7
			end

			self._toggleTabControl:selectTab(defualtTabIndex)
		end
	else
		local pos = (self._weekTab:getSelectWeek() - 1) * 7 + self._activeIndex
		local moLst = NewbieTaskModel.instance:getTaskMoLst(pos)

		self:refreshTaskLst(moLst, false)
	end

	self:refreshStepPoint()
	self:refreshTabRedDot()
	self:refreshTabStatus()
end

function M:_handleNewbieStepPointChange(e)
	self:refreshStepPoint()
end

function M._tabCheckFunc(tabIndex)
	local canTab = false
	local cfgTaskLst = NewbieTaskConfig.instance:getTaskLst(tabIndex)

	for _, cfg in ipairs(cfgTaskLst) do
		if NewbieTaskModel.instance:getTaskMo(cfg.id) then
			canTab = true

			break
		end
	end

	return canTab
end

function M._weekTabCheck(tabIndex)
	local curMaxDay = NewbieTaskModel.instance:getCurUnlockMaxDay()

	return tabIndex == 1 or curMaxDay > 7
end

function M:onTaskClickGet(cell)
	for _, tweener in ipairs(self._dotweenSeq or {}) do
		if tweener and tweener:IsPlaying() then
			return
		end
	end

	local taskId = cell:getId()
	local status = NewbieTaskModel.instance:getTaskRewardStatus(taskId)

	if status == NewbieTaskConfig.TaskState.CanReceive then
		self:_receiveAllTask(self._activeIndex)
	end
end

function M:_playReceiveAnim()
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:AppendCallback(function()
		cell:playAni("lingqu")

		local idx = cell:getCurIndex()
		local minIndex, maxIndex = self._loopList:GetCurShowItemIndexRange()

		for i = idx, maxIndex do
			local item = self._loopListView:GetShownItemByItemIndex(i)
			local shower = Astral.LuaComponentContainer.Get(item.gameObject, NewbieTaskItemCell)

			if shower then
				shower:playAni("moving up")
			end
		end

		local nextItem = self:getNextItem(maxIndex)

		if nextItem then
			local nextShower = Astral.LuaComponentContainer.Get(nextItem, NewbieTaskItemCell)

			goutil.setActive(nextItem, true)
			nextShower:playAni("moving up")
		end
	end)
	sequence:AppendInterval(0.67)
	sequence:AppendCallback(function()
		NewbieTaskAgent.instance:sendFinishTaskRequest({
			taskId
		})
		ViewBlockMgr.instance:blockClick(false, ViewBlockKey.Anim)
	end)
	table.insert(self._dotweenSeq, sequence)
end

function M:_receiveAllTask(day)
	local receivableTasks = {}
	local pos = (self._weekTab:getSelectWeek() - 1) * 7 + day
	local dayTaskList = NewbieTaskModel.instance:getTaskMoLst(pos)

	for _, taskMO in ipairs(dayTaskList) do
		local status = NewbieTaskModel.instance:getTaskRewardStatus(taskMO:getId())

		if status == NewbieTaskConfig.TaskState.CanReceive then
			table.insert(receivableTasks, taskMO:getId())
		end
	end

	NewbieTaskAgent.instance:sendFinishTaskRequest(receivableTasks)
end

function M:getNextItem(maxIndex)
	local lastItem = self._loopListView:GetShownItemByItemIndex(maxIndex)
	local nextY = lastItem.transform.localPosition.y - 124
	local children = Astral.GameObjectUtil.GetChildren(self._content)
	local delta = 1

	for index = 0, children.Length - 1 do
		local childY = children[index].transform.localPosition.y

		if delta >= math.abs(nextY - childY) then
			return children[index]
		end
	end

	return false
end

function M:refreshTabRedDot()
	local maxDay = NewbieTaskConfig.instance:getMaxDay()
	local startDay = 1
	local endDay = maxDay > 7 and 7 or maxDay
	local group = self._weekTab:getSelectWeek()

	if group == 2 then
		startDay = 8
		endDay = maxDay
	end

	self:refershWeekRedDot()

	for i = startDay, maxDay do
		local pos = i > 7 and i - 7 or i

		if group == 1 and i > 7 then
			return
		end

		local showRedDot = self._tabCheckFunc(i) and NewbieTaskModel.instance:getHasTaskCanRewardInTargetDay(i)

		goutil.setActive(self._tabRedDot[pos], showRedDot)
	end
end

function M:refershWeekRedDot()
	local maxDay = NewbieTaskConfig.instance:getMaxDay()

	if maxDay <= 7 then
		return
	end

	local num = 0

	for i = 1, 7 do
		local showRedDot = self._tabCheckFunc(i) and NewbieTaskModel.instance:getHasTaskCanRewardInTargetDay(i)

		if showRedDot then
			num = num + 1
		end
	end

	self.tabComp:setRedPointNum(1, num)

	num = 0

	for i = 8, maxDay do
		local showRedDot = self._tabCheckFunc(i) and NewbieTaskModel.instance:getHasTaskCanRewardInTargetDay(i)

		if showRedDot then
			num = num + 1
		end
	end

	self.tabComp:setRedPointNum(2, num)
end

function M:updateImageSize()
	local uiRoot = ViewMgr.instance:getUIRoot()
	local rectTransform = uiRoot.transform
	local width = math.ceil(rectTransform.rect.width)
	local height = math.ceil(rectTransform.rect.height)

	RectTransformUtils.SetSize(self._rawImageHero.transform, width, height)

	return width, height
end

function M:_setHeroLight()
	local scene = SceneMgr.instance:getScene(SceneType.Room)

	if scene then
		scene.light:setCharacterLightRotation(LightRot)
	end
end

function M:_resetHeroLight()
	local scene = SceneMgr.instance:getScene(SceneType.Room)

	if scene then
		scene.light:setOriginalRotation()
	end
end

function M:refreshHeroShow(heroId, skinId)
	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(heroId)
	local skinCfg = BackpackConfig.instance:getConfigByKey(ConfigName.ItemHeroSkin, skinId)

	goutil.setActive(self._goCareer, not skinId)
	goutil.setActive(self._imgHero.gameObject, false)
	goutil.setActive(self._rawImageHero.gameObject, true)
	goutil.setActive(self._imgRoleQuality, not skinId)
	goutil.setActive(self._imgRoleQualityLetter, not skinId)

	if skinId then
		self._txtRoleName.text = skinCfg.name
	else
		local careerCell = Astral.SimpleLuaComponentContainer.Add(self._goCareer, CareerCell)

		careerCell:setData(heroId)

		self._txtRoleName.text = heroInfoCO.name
	end

	self._canvasGroupHero:DOKill(false)

	self._canvasGroupHero.alpha = 0

	self._canvasGroupHero:DOFade(1, 0.5):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true):SetDelay(0.3)

	local defaultAnim = skinId and MainPerformEnum.AnimFullName.ChoukaIdle or MainPerformEnum.AnimFullName.XiangQingIdle

	MainScenePerformUtil.showTmpHero(true, heroId, skinId, defaultAnim, HeroPos, HeroAngle, nil)
	self._photoUnit:TurnOn(PhotoCacheMgr.SIZE_M2_BLOCK, PhotoCacheMgr.SIZE_M2_BLOCK, UnityEngine.RenderTextureFormat.ARGB32, 4)
	PhotoBaseExtension.SetCameraPerspective(self._photoUnit, FOV)
	PhotoBaseExtension.SetCameraTag(self._photoUnit, "RTCamera")
	PhotoBaseExtension.SetCameraPostProcessing(self._photoUnit, true, SceneLayer.Default_Value)
	PhotoBaseExtension.SetCameraCullingLayer(self._photoUnit, SceneLayer.Unit_Value)
	self._photoUnit:SetCameraPosition(0, 0, 0)
	self._photoUnit:SetCameraRotation(0, 0, 0)

	self._photoUnit.producer.producerContainer.transform.localPosition = Vector3.New(50, 0, 0)
end

function M:_onHeroModelLoaded(inst, res)
	if not inst then
		return
	end

	self._photoUnit:playAni("idle2", true, true)
end

function M:refreshStepPoint()
	local group = self._weekTab:getSelectWeek()
	local curStepPoint = NewbieTaskModel.instance:getCurStepPoint(group)

	self._txtStepPointProcess.text = curStepPoint

	local processP = curStepPoint / self._stepPointMax[group]
	local reachColor = parsecolor("#000000")
	local unReachColor = parsecolor("#B6B7B7")
	local minPoint = 1
	local maxPoint = 5

	if group == 2 and #self._stepPointComps > 5 then
		minPoint = 6
		maxPoint = 10
	end

	local stepRewardLst = NewbieTaskConfig.instance:getStepRewardLst()

	for i = minPoint, maxPoint do
		local stepPoint = self._stepPointComps[i].cfg.stepPoint

		self._stepPointComps[i].txtPoint.text = stepPoint

		local pointProcessFull = stepPoint <= curStepPoint
		local itemId, itemCount = NewbieTaskConfig.instance:str2ItemIdCount(stepRewardLst[i].reward)
		local numVisible = not ItemUtil.isCharacterById(itemId) and not ItemUtil.isCharacterSkinById(itemId)

		self._stepPointComps[i].rewardCell:setStepPoint(stepRewardLst[i].stepPoint)
		self._stepPointComps[i].rewardCell:updateData(self._rewardData[i])
		self._stepPointComps[i].rewardCell:getComponent("num"):setVisible(numVisible)

		local rewardStatus = NewbieTaskModel.instance:getStepPointRewardStatus(stepPoint, group)

		self._stepPointComps[i].rewardCell:getComponent("reward"):setRewardStatus(rewardStatus)

		local processCell = 0

		if pointProcessFull then
			processCell = 1
		elseif curStepPoint - self._stepPointComps[i].preStepPoint > 0 then
			processCell = (curStepPoint - self._stepPointComps[i].preStepPoint) / (stepPoint - self._stepPointComps[i].preStepPoint)
		end

		goutil.setActive(self._stepPointComps[i].goMarkReach, pointProcessFull)
		goutil.setActive(self._stepPointComps[i].goMarkUnReach, not pointProcessFull)

		self._stepPointComps[i].txtPoint.color = pointProcessFull and reachColor or unReachColor

		local idx = i > 5 and i - 5 or i

		if self._stepFillGroup[idx] then
			self._stepFillGroup[idx].fillAmount = processCell
		end
	end

	self._stepFillGroup[#self._stepFillGroup].fillAmount = curStepPoint >= self._stepPointMax[group] and 1 or 0
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = self._activeIndex ~= tabIndex

	self._activeIndex = tabIndex

	for i = 1, 7 do
		local pos = (self._weekTab:getSelectWeek() - 1) * 7 + i
		local canTab = self._tabCheckFunc(pos)
		local isFinish = NewbieTaskModel.instance:getIsFinishDay(pos)
		local colorStr = "#f7f6f1"

		if not canTab then
			colorStr = "#f7f6f133"
		elseif isFinish then
			colorStr = "#858585"
		end

		self._tabEntryTextCanvasGroup[i].color = i == self._activeIndex and parsecolor("#f7f6f1") or parsecolor(colorStr)
	end

	if needReflash then
		local pos = (self._weekTab:getSelectWeek() - 1) * 7 + tabIndex
		local moLst = NewbieTaskModel.instance:getTaskMoLst(pos)

		self:refreshTaskLst(moLst, true)
	end
end

function M:refreshTaskLst(moLst, resetPos)
	self._taskMoLst = moLst

	local count = self._taskMoLst and #self._taskMoLst or 0

	self._loopList:SetListItemCount(count, resetPos)
	self._loopList:RefreshAllShownItem()

	if resetPos then
		self._loopList:MoveToItemIndex(0)
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local class = NewbieTaskItemCell
	local item = self._loopList:NewListViewItem("newhand_task_item")
	local newbieTaskMo = self._taskMoLst[curIndex]
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, class)

	shower = shower or Astral.LuaComponentContainer.Add(item.gameObject, class)

	shower:setHandler(self)
	shower:updateData(newbieTaskMo, curIndex)

	return item
end

function M:getSelectDay()
	return self._activeIndex or 1
end

function M:refreshWeekDay(selectWeek)
	local defualtTabIndex = NewbieTaskModel.instance:getDefaultOpenDayWithStart((selectWeek - 1) * 7 + 1)

	if defualtTabIndex > 7 then
		defualtTabIndex = defualtTabIndex - 7
	end

	self._toggleTabControl:selectTab(defualtTabIndex)

	local selectDay = (selectWeek - 1) * 7 + defualtTabIndex
	local moLst = NewbieTaskModel.instance:getTaskMoLst(selectDay)
	local maxDay = NewbieTaskConfig.instance:getMaxDay()
	local resetPos = true

	for i = 1, maxDay do
		local canTab = self._tabCheckFunc(i)
		local isFinish = NewbieTaskModel.instance:getIsFinishDay(i)
		local pos = i > 7 and i - 7 or i

		if selectWeek == 1 and i <= 7 or selectWeek == 2 and i > 7 then
			goutil.setActive(self._tabEntryLocks[pos], not canTab)
			goutil.setActive(self._tabFinish[pos], canTab and isFinish)
		end
	end

	self:refreshStepPoint()
	self:_refreshDayText()
	self:refreshTabRedDot()
	self:refreshTaskLst(moLst, true)
end

function M:_refreshDayText()
	local idx = 0

	if self._weekTab:getSelectWeek() == 2 then
		idx = 7

		local heroId = NewbieTaskConfig.instance:getConstByKey("DisplayHero")
		local skinId = NewbieTaskConfig.instance:getConstByKey("DisplayHeroSkin")

		MainScenePerformUtil.showTmpHero(false)
		self:refreshHeroShow(heroId, skinId)
	elseif self._weekTab:getSelectWeek() == 1 then
		local heroId = NewbieTaskConfig.instance:getConstByKey("DisplayHero")

		MainScenePerformUtil.showTmpHero(false)
		self:refreshHeroShow(heroId)
	end

	for i = 1, 7 do
		self._tagDayText[i].text = "第" .. i + idx .. "天"
	end
end

function M:recordJump()
	NewbieTaskModel.instance:recordJumpWeekDay(self._weekTab:getSelectWeek(), self:getSelectDay())
end

function M:refreshTabStatus()
	local firstWeek, secondWeek = NewbieTaskModel.instance:getFinishDays()

	for _, item in ipairs(self._weekLock) do
		goutil.setActive(item, false)
	end

	if #firstWeek == 7 then
		goutil.setActive(self._weekLock[1], true)
		goutil.setActive(self._weekLock[2], true)
	end

	if #secondWeek == 7 then
		goutil.setActive(self._weekLock[3], true)
		goutil.setActive(self._weekLock[4], true)
	end
end

function M:_onClickCheck()
	self:recordJump()

	local heroId = NewbieTaskConfig.instance:getConstByKey("DisplayHero")
	local skinId = NewbieTaskConfig.instance:getConstByKey("DisplayHeroSkin")
	local group = self._weekTab:getSelectWeek()

	if group == 1 then
		CharacterUtil.openCharacterPreviewView(heroId)
	elseif group == 2 then
		local skinCO = HeroSkinConfig.instance:getInfo(skinId)

		if skinCO then
			ViewMgr.instance:open(ViewName.CharacterSkinView, {
				heroId = skinCO.heroId,
				skinId = skinId
			})
		end
	end
end

return M
