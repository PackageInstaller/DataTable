-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/task/AirWorkShopTaskView.lua

module("logic.extensions.airworkshop.view.task.AirWorkShopTaskView", package.seeall)

local M = class("AirWorkShopTaskView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._scroll = self:getUIComponent("air_workshop_task_view_86130750", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self._scroll.gameObject)

	self._loopList:InitListView(0, self._onCellUpdate, self)

	self._loopListViewComp = self._loopList:GetLoopListView()

	local rectTrTabRoot = self:getUIComponent("5&left_tab_content_-205429629", UIComponentType.RectTransform)

	self._selectedGo = self:getGo("5&left_tab_content_-1382376651")
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(self._tabCheckFunc)

	self._tabGos = {}
	self._tabRedGo = {}

	for i = 1, rectTrTabRoot.childCount - 1 do
		local childGo = rectTrTabRoot:GetChild(i).gameObject

		self._toggleTabControl:addToggleTab(childGo:GetComponent(UIComponentType.SpaceXToggle))
		table.insert(self._tabGos, childGo)
		table.insert(self._tabRedGo, goutil.findChild(childGo, "red_point"))
	end

	self._txtTime = self:getText("air_workshop_task_view_1617641509")
end

function M:destroyUI()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	self._loopList:Dispose()

	self._loopList = nil

	for _, value in pairs(self._itemData or {}) do
		value.destroyUI()
	end

	self._itemData = nil
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	return
end

function M:onEnter()
	self:setEvent(true)
	AirWorkShopDefAgent.instance:sendGetAirInfoRequest()
	self:_refreshRedDot()

	local info = self:getFirstParam() or {}
	local defualtTabIndex = info.tabIndex or AirWorkShopEnum.TaskPageType.Create

	if not M._tabCheckFunc(defualtTabIndex) then
		defualtTabIndex = AirWorkShopEnum.TaskPageType.Create
	end

	self._toggleTabControl:selectTab(defualtTabIndex)
	self:_refreshEntertainmentTime()
end

function M:onExit()
	self:setEvent(false)
	self:_playItemOpenAni(false)

	self._activeIndex = nil

	self._loopList:ClearCells()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.AIRWORKSHOP_TASK_UPDATE, self._refresh, self)
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_AIR_INFO_CHANGE, self._handleOnAirInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.AIRWORKSHOP_TASK_UPDATE, self._refresh, self)
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_AIR_INFO_CHANGE, self._handleOnAirInfoChange, self)
	end
end

function M:_refresh(e, params)
	self:refreshView(true)
	self:_refreshRedDot()
end

function M:_refreshRedDot()
	for index, go in ipairs(self._tabRedGo) do
		local canRewardFromServerIds = AirWorkMapModel.instance:getCanGainFromServerTaskIds(index)
		local canGain = #canRewardFromServerIds > 0

		goutil.setActive(go, canGain)
	end
end

function M:_handleOnAirInfoChange()
	if Astral.OSDef.isEditor then
		printWarn("工坊信息刷新")
		TableUtil.dump(AirWorkShopModel.instance:getAirInfo())
	end

	if self._activeIndex == AirWorkShopEnum.TaskPageType.Entertainment then
		if M._tabCheckFunc(AirWorkShopEnum.TaskPageType.Entertainment) then
			self:_refreshEntertainmentTime()
		else
			FloatWordMgr.instance:show("娱乐模式已结束")
			self._toggleTabControl:selectTab(AirWorkShopEnum.TaskPageType.Create)
		end
	end
end

function M:onTaskClickGet(cell)
	local status
end

function M._tabCheckFunc(tabIndex)
	local canTab = true

	if tabIndex == AirWorkShopEnum.TaskPageType.Entertainment then
		canTab = false

		local airInfo = AirWorkShopModel.instance:getAirInfo()
	end

	return canTab
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = orgIndex ~= tabIndex

	self._activeIndex = tabIndex

	self:refreshView(needReflash)
end

function M:_refreshEntertainmentTime()
	local isEntertainmentPage = self._activeIndex == AirWorkShopEnum.TaskPageType.Entertainment

	if isEntertainmentPage then
		self._txtTime.text = nil
	end

	goutil.setActive(self._txtTime.gameObject, isEntertainmentPage)

	local tab = self._toggleTabControl:getTab(AirWorkShopEnum.TaskPageType.Entertainment)

	goutil.setActive(tab.gameObject, false)
end

function M:refreshView(needReflash)
	if needReflash then
		local moLst = AirWorkMapModel.instance:getTaskMoList(self._activeIndex)

		self:refreshTaskLst(moLst, true, true)
		goutil.setActive(self._selectedGo, false)
	end

	self:_refreshEntertainmentTime()
	settimer(0, function()
		goutil.setActive(self._selectedGo, true)
		Astral.TransformUtil.SetLocalPosY(self._selectedGo.transform, self._tabGos[self._activeIndex].transform.localPosition.y)
	end, self, false)
end

function M:refreshTaskLst(moLst, resetPos, playOpenAni)
	self._scroll.enabled = false
	self._taskMoLst = moLst

	local len = self._taskMoLst and #self._taskMoLst or 0

	self._needPlayItemCellOpenAni = playOpenAni and len > 0

	if len > 0 then
		if resetPos then
			self._loopList:ClearCells()
		end

		self._loopList:SetListItemCount(len, resetPos)
		self:_playItemOpenAni(playOpenAni)
	else
		self._loopList:ClearCells()
	end

	self:_playItemOpenAni(self._needPlayItemCellOpenAni)
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._taskMoLst[curIndex]
	local prefabName = "task_item"
	local item = self._loopList:NewListViewItem(prefabName)

	self:_updateTaskCell(item.gameObject, data)

	return item
end

function M:_updateTaskCell(go, data)
	if not self._itemData then
		self._itemData = {}
	end

	local key = go:GetInstanceID()
	local theItem = self._itemData[key]

	if not theItem then
		theItem = {
			go = go,
			canvasGroup = goutil.addComponentOnce(go, ComponentType.CanvasGroup),
			txtDesc = goutil.findChildComponent(go, "txtDesc", UIComponentType.Text),
			txtProgress = goutil.findChildComponent(go, "txtProgress", UIComponentType.Text),
			imgProgress = goutil.findChildImageComponent(go, "fillDi/imgProgress"),
			btnJump = UIComponentType.ButtonAdapter(goutil.findChild(go, "layout/btnGo")),
			btnGet = UIComponentType.ButtonAdapter(goutil.findChild(go, "layout/btnGet")),
			goDone = goutil.findChild(go, "layout/txtDone"),
			goDoing = goutil.findChild(go, "layout/txtOngoing")
		}

		local rewardRoot = goutil.findChildComponent(go, "reward", UIComponentType.RectTransform)

		theItem.rewardCellLst = {}

		for i = 0, rewardRoot.childCount - 1 do
			local itemCell = Astral.SimpleLuaComponentContainer.Add(rewardRoot:GetChild(i).gameObject, ItemCell)

			itemCell:setShowSelectedEffect(false)
			table.insert(theItem.rewardCellLst, itemCell)
		end

		function theItem.isActive()
			return theItem.go.gameObject.activeSelf
		end

		function theItem.setAlpha(alpha)
			theItem.canvasGroup:DOKill(false)

			theItem.canvasGroup.alpha = alpha
		end

		function theItem.playOpenAni(play, duration, delay)
			theItem.canvasGroup:DOKill(false)

			if play then
				duration = duration or 0.26
				delay = delay or 0
				theItem.canvasGroup.alpha = 0

				return theItem.canvasGroup:DOFade(1, duration):SetEase(DG.Tweening.Ease.Linear):SetDelay(delay):SetAutoKill(true):OnComplete(function()
					return
				end, self)
			else
				theItem.canvasGroup.alpha = 1

				return nil
			end
		end

		self._itemData[key] = theItem
	end

	function theItem.getTaskId()
		return data:getTaskId()
	end

	function theItem.getJumpId()
		return data:getJumpId()
	end

	theItem.btnJump:AddClickListener(function()
		self:_onCellClickJump(theItem.getJumpId())
	end, self)
	theItem.btnGet:AddClickListener(function()
		self:_onCellClickGet(theItem.getTaskId())
	end, self)

	function theItem.destroyUI()
		theItem.btnJump:RemoveClickListener()
		theItem.btnGet:RemoveClickListener()
	end

	printWarn("======taskId=====", theItem.getTaskId())

	theItem.txtDesc.text = data:getShowDesc()
	theItem.txtProgress.text = string.format("(%s/%s)", data:getCurCount(), data:getMaxCount())
	theItem.imgProgress.fillAmount = data:getCurCount() / data:getMaxCount()
	theItem.canvasGroup.alpha = self._needPlayItemCellOpenAni and 0 or 1

	local showJump = data:canJump() and not data:canGetReward()
	local showGet = data:canGetReward() and not data:getIsFinish()

	goutil.setActive(theItem.btnJump.gameObject, showJump)
	goutil.setActive(theItem.btnGet.gameObject, showGet)
	goutil.setActive(theItem.goDone, data:getIsFinish())
	goutil.setActive(theItem.goDoing, not data:getIsFinish() and not showJump and not showGet)

	local rewardList = data:getRewardList()
	local len = #rewardList

	for i = 1, #theItem.rewardCellLst do
		goutil.setActive(theItem.rewardCellLst[i]:getGo(), i <= len)

		if i <= len then
			theItem.rewardCellLst[i]:updateData(ItemUtil.createItemData({
				itemId = rewardList[i].itemId,
				count = rewardList[i].num
			}))
		end
	end
end

function M:_onCellClickJump(jumpId)
	printWarn("======jumpId=====", jumpId)
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, tonumber(jumpId))
end

function M:_onCellClickGet(taskId)
	printWarn("======taskId=====", taskId)

	local canRewardFromServerIds

	if self._activeIndex then
		canRewardFromServerIds = AirWorkMapModel.instance:getCanGainFromServerTaskIds(self._activeIndex)
	else
		canRewardFromServerIds = {
			taskId
		}
	end

	if canRewardFromServerIds and #canRewardFromServerIds > 0 then
		AirWorkShopDefAgent.instance:sendFinishAirTaskRequest(canRewardFromServerIds)
	end
end

function M:_playItemOpenAni(play)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}

	local minIndex, maxIndex = self._loopList:GetCurShowItemIndexRange()

	if play then
		self._scroll.enabled = false

		local duration = 0.26
		local maxDelay = 0.1
		local index = 1

		for i = minIndex, maxIndex do
			local isLast = i == maxIndex
			local loopItem = self._loopListViewComp:GetShownItemByItemIndex(i)

			if loopItem then
				local shower = self._itemData[loopItem.gameObject:GetInstanceID()]

				shower.setAlpha(0)

				local delay = index * 0.07

				delay = delay > 1 and 1 or delay
				maxDelay = maxDelay < delay and delay or maxDelay

				local tweenDelay = shower.playOpenAni(true, duration, delay)

				table.insert(self._cacheTweenLst, tweenDelay)

				index = index + 1
			end
		end

		table.insert(self._cacheTweenLst, DoTweenUtil.DelayedCall(maxDelay, function()
			self._scroll.enabled = true
			self._needPlayItemCellOpenAni = false
		end))
	else
		for _, cell in pairs(self._itemData or {}) do
			cell.playOpenAni(false)
		end

		self._cacheTweenLst = nil
		self._needPlayItemCellOpenAni = false
		self._scroll.enabled = true
	end
end

return M
