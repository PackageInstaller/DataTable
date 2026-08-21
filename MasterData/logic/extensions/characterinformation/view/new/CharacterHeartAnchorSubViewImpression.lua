-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterHeartAnchorSubViewImpression.lua

module("logic.extensions.characterinformation.view.new.CharacterHeartAnchorSubViewImpression", package.seeall)

local M = class("CharacterHeartAnchorSubViewImpression")

function M:ctor(mainGo)
	self.mainGO = mainGo.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local mainGO = self:getMainGo()
	local registry = self:getRegistry()

	self._uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	self._canvasGroupMain = goutil.addComponentOnce(mainGO, ComponentType.CanvasGroup)
	self._guiAnimation = goutil.addComponentOnce(mainGO, typeof(Astral.GUITimelineAniLua))

	self._guiAnimation:AddListener(self._animationDoneListener, self)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(function(index)
		return self:_subTabCheckFunc(index)
	end)
	self._toggleTabControl:addToggleTab(registry:findUIElement("heart_anchor_impression_view_-327353840", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(registry:findUIElement("heart_anchor_impression_view_-232851364", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(registry:findUIElement("heart_anchor_impression_view_-336690940", UIComponentType.SpaceXToggle))

	self._toggleLockLst = {}
	self._toggleUnLockLst = {}
	self._toggleRedPointLst = {}

	for i = 1, 3 do
		local tab = self._toggleTabControl:getTab(i)

		table.insert(self._toggleLockLst, goutil.findChild(tab.gameObject, "normal/lock").gameObject)
		table.insert(self._toggleUnLockLst, goutil.findChild(tab.gameObject, "normal/Text1").gameObject)
		table.insert(self._toggleRedPointLst, goutil.findChild(tab.gameObject, "redPoint").gameObject)

		local tabNameStr = lang(string.format("tip_tacit_task_tab_%s", i))
		local txtTabName = goutil.findChildComponent(tab.gameObject, "normal/Text1", UIComponentType.Text)

		txtTabName.text = tabNameStr
		txtTabName = goutil.findChildComponent(tab.gameObject, "select/Text1", UIComponentType.Text)
		txtTabName.text = tabNameStr
		txtTabName = goutil.findChildComponent(tab.gameObject, "normal/lock/Text1", UIComponentType.Text)
		txtTabName.text = tabNameStr
	end

	self._vec3Temp = Vector3.New()
	self._scroll = registry:findUIElement("heart_anchor_impression_view_-404388403", UIComponentType.ScrollRect)
	self._rectScrollContent = registry:findUIElement("heart_anchor_impression_view_-1519579058", UIComponentType.RectTransform)
	self._checkZoneDuration = 0.2
	self._rectTaskShowZone = registry:findUIElement("heart_anchor_impression_view_314477880", UIComponentType.RectTransform)
	self._zoneWidth = self._rectTaskShowZone.rect.width
	self._zoneHeight = self._rectTaskShowZone.rect.height
	self._goItemTask = registry:findUIElement("0&heart_anchor_task_item_-266487549")
	self._taskCell = {}

	for i = 1, self._rectScrollContent.childCount - 1 do
		local tr = self._rectScrollContent:GetChild(i)

		if tr.transform.childCount == 0 then
			local itemGo = goutil.cloneAndSetParent(self._goItemTask, tr.transform)

			RectTransformUtils.SetAnchoredPosition(itemGo.transform, 0, 0)
			goutil.setActive(itemGo, true)
		end

		local cell = Astral.SimpleLuaComponentContainer.Add(tr.gameObject, CharacterImpressionTaskCell)

		cell:setHandler(self)
		table.insert(self._taskCell, cell)
	end
end

function M:destroyUI()
	self:setEvent(false)
	self:setHandler(nil)
	self._guiAnimation:RemoveListener()

	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()
	end

	self._registry = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:onEnter(isNormal, changePage)
	self:setEvent(true)
	self:_refreshEntryTab()

	self._activeIndex = nil

	self._toggleTabControl:selectTab(self:getCurActiveIndex(), true)
	self:playGuiAni("open", isNormal)
	self:blockClick(true)
	self:setVisible(true)
	settimer(self._checkZoneDuration, self.checkTaskCell, self, true)
end

function M:getCurActiveIndex()
	local heroData = self:getCurHeroData()
	local tacitLv = heroData:getTacit()
	local maxUnlockIndex = 1

	for index = 1, 3 do
		local stageCO = TacitConfig.instance:getTacitStageCO(index)
		local unLock = tacitLv >= stageCO.level

		if unLock then
			maxUnlockIndex = index
		end
	end

	local activeIndex = 1

	for index = 1, maxUnlockIndex do
		local taskLst = TacitModel.instance:getStageTaskLst(index) or {}
		local isFinishAll = true

		for k, v in pairs(taskLst) do
			if not v:getHasFinish() then
				isFinishAll = false
			end
		end

		if isFinishAll then
			activeIndex = math.min(index + 1, 3)
		end
	end

	return activeIndex
end

function M:onEnterFinished()
	return
end

function M:onExit(isNormal, changePage)
	self:setEvent(false)

	self._activeIndex = nil

	self:playGuiAni("close", isNormal)
	self:setVisible(false)
	self:blockClick(true)
	removetimer(self.checkTaskCell, self)
end

function M:onExitFinished()
	return
end

function M:setVisible(visible, includeClick)
	self._viewVisible = visible
	self._canvasGroupMain.alpha = visible and 1 or 0

	if includeClick then
		self:blockClick(not visible)
	end
end

function M:blockClick(block)
	self._canvasGroupMain.interactable = not block
	self._canvasGroupMain.blocksRaycasts = not block
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_REFRESH_TASK_VIEW, self._handleTacitRefreshTaskView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_REFRESH_TASK_VIEW, self._handleTacitRefreshTaskView, self)
	end
end

function M:_handleRefreshHeroDepotData()
	self:_refreshEntryTab()
end

function M:_handleTacitRefreshTaskView(e, rewardingTaskId, markPrimaryTask, isUpgrade)
	self:_refreshEntryTab()

	if rewardingTaskId then
		for i, cell in ipairs(self._taskCell) do
			if cell:getIsVisible() then
				if cell:getTaskId() == rewardingTaskId then
					local handler = self:getHandler()

					if handler then
						handler:flyTaskCellVFXToExp(cell:getRewardingVFX())
					end
				end

				cell:updateTaskCellData()
			end
		end
	elseif markPrimaryTask or isUpgrade then
		for i, cell in ipairs(self._taskCell) do
			if cell:getIsVisible() then
				cell:updateTaskCellData()
			end
		end
	else
		self:updateTaskLst(self._activeIndex, false, false)
	end
end

function M:playGuiAni(name, isNormal)
	self._guiAnimation:RemoveListener()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:SetAniTime(0)
	self._guiAnimation:AddListener(self._animationDoneListener, self)

	if string.nilorempty(name) then
		return
	end

	local __isNormal = true

	if isNormal ~= nil then
		__isNormal = isNormal
	end

	local mainGO = self:getMainGo()

	if mainGO.activeSelf and not string.nilorempty(name) then
		local timeLineMode = __isNormal and Astral.GUITimeLineMode.TimeToStart or Astral.GUITimeLineMode.TimeToEnd

		self._guiAnimation:PlayAniByName(name, timeLineMode)
	end
end

function M:_animationDoneListener(tagName, reason)
	self._guiAnimation:ClearAllBinding()
	self._guiAnimation:StopTimelineAni()

	if tagName == "open" then
		self:blockClick(false)
	end
end

function M:getCurHeroData()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if not heroData then
		return nil
	end

	local data = HeroDepotModel.instance:getHeroInfoByID(heroData:getId())

	return data
end

function M:getActiveIndex()
	return self._activeIndex
end

function M:_subTabCheckFunc(index)
	local activeIndex = self:getActiveIndex()

	if activeIndex and activeIndex == index then
		return true
	end

	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local tacitLv = heroData:getTacit()
	local stageCO = TacitConfig.instance:getTacitStageCO(index)

	if stageCO then
		local isEnoughLevel = tacitLv >= stageCO.level

		if not isEnoughLevel then
			ToolTipsMgr.showCharacterTopToast(langF("tip_tacit_unlock_tacitlv", stageCO.level), CommEnum.CharacterTopToastIcon.Info, 1)
		end

		return isEnoughLevel
	else
		return false
	end
end

function M:_refreshEntryTab()
	local heroData = self:getCurHeroData()
	local tacitLv = heroData:getTacit()

	for index, goLock in ipairs(self._toggleLockLst) do
		local stageCO = TacitConfig.instance:getTacitStageCO(index)
		local unLock = tacitLv >= stageCO.level

		goutil.setActive(goLock, not unLock)
		goutil.setActive(self._toggleUnLockLst[index], unLock)

		local goRedPoint = self._toggleRedPointLst[index]
		local showRedPoint = false

		if unLock then
			showRedPoint = TacitModel.instance:checkHasRedDot(index)
		end

		goutil.setActive(goRedPoint, showRedPoint)
	end
end

function M:setPage(index, ...)
	local activeIndex = self:getActiveIndex()

	if activeIndex and activeIndex == index then
		return
	end

	local lastViewIndex = self._activeIndex

	self._activeIndex = index

	local resetPos = true
	local playEnterAnim = true

	self:updateTaskLst(index, resetPos, playEnterAnim)
	CharacterInformationModel.instance:setImpressionTaskPageIndex(index)
end

function M:updateTaskLst(stage, resetPos, playEnterAni)
	self._taskLst = TacitModel.instance:getStageTaskLst(stage) or {}

	table.sort(self._taskLst, function(a, b)
		local aHasFinish = a:getHasFinish() and 1 or 0
		local bHasFinish = b:getHasFinish() and 1 or 0
		local aCanGetReward = a:getCanReward() and not a:getHasFinish() and 1 or 0
		local bCanGetReward = b:getCanReward() and not b:getHasFinish() and 1 or 0

		if aCanGetReward ~= bCanGetReward then
			return bCanGetReward < aCanGetReward
		elseif aHasFinish ~= bHasFinish then
			return aHasFinish < bHasFinish
		end

		return a:getId() < b:getId()
	end)

	for i, cell in ipairs(self._taskCell) do
		local show = i <= #self._taskLst

		cell:setVisible(show)

		if show then
			cell:setShowDetail(true)
			cell:setCellData(self._taskLst[i])
			cell:playEnterAni(playEnterAni)
		end
	end

	self:autoFixScrollContent(resetPos)
end

function M:autoFixScrollContent(resetPos)
	local maxHeight = 0
	local maxWidth = 0
	local width = 364
	local height = 364

	for i, cell in ipairs(self._taskCell) do
		if cell:getIsVisible() then
			local rectT = cell:getMainRectTr()
			local anchoredX, anchoredY = Astral.TransformUtil.GetAnchoredPos(rectT, 0, 0)
			local curWidth = anchoredX + width / 2
			local curHeigh = math.abs(anchoredY) + height / 2

			maxHeight = maxHeight < curHeigh and curHeigh or maxHeight
			maxWidth = maxWidth < curWidth and curWidth or maxWidth
		end
	end

	maxWidth = RectTransformUtils.GetWidth(self._rectScrollContent)
	maxHeight = maxHeight + 100

	RectTransformUtils.SetSize(self._rectScrollContent, maxWidth, maxHeight)

	if resetPos then
		RectTransformUtils.SetAnchoredPosition(self._rectScrollContent, 0, maxHeight * -0.5)
	end
end

function M:checkTaskCell()
	self._zoneWidth = self._rectTaskShowZone.rect.width
	self._zoneHeight = self._rectTaskShowZone.rect.height

	for i, cell in ipairs(self._taskCell) do
		if cell:getIsVisible() then
			local rectT = cell:getMainRectTr()

			self._vec3Temp:Set(TransformUtils.GetPosition(rectT, 0, 0, 0))

			local screenPos = self._uiCamera:WorldToScreenPoint(self._vec3Temp)
			local targetX, targetY = RectTransformUtils.ScreenPointToLocalPointInRectangle(self._rectTaskShowZone, screenPos.x, screenPos.y, self._uiCamera, 0, 0)
			local outZone = targetY <= self._zoneHeight * -0.5 or targetY >= self._zoneHeight * 0.5 or targetX >= self._zoneWidth * 0.5 or targetX <= self._zoneWidth * -0.5

			cell:dealInZone(not outZone, self._checkZoneDuration)
		end
	end
end

return M
