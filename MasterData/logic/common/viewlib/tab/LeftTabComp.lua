-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/tab/LeftTabComp.lua

module("logic.common.viewlib.tab.LeftTabComp", package.seeall)

local M = class("LeftTabComp")

M.AnimType = {
	B = 2,
	A = 1
}

function M:ctor(gameObject)
	self.mainGO = gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
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
	self._canvasGroup = goutil.addComponentOnce(self.mainGO.gameObject, ComponentType.CanvasGroup)
	self._guiAnimTab = goutil.addComponentOnce(self.mainGO.gameObject, typeof(Astral.GUITimelineAniLua))
	self._rootRect = self._registry:getRectTransform("left_tab_content_-205429629")
	self._tabLstRoot = self._rootRect.gameObject
	self._tabLst = {}

	for i = 0, self._rootRect.childCount - 1 do
		local go = self._rootRect:GetChild(i).gameObject

		if string.match(go.name, "_%d+") then
			table.insert(self._tabLst, self:_buildTab(go))
		end
	end

	self._cachePos = Vector3.New(0, 0, 0)
	self._rectTrSelect = self._registry:getRectTransform("left_tab_content_-1382376651")
	self._canvasGroupSelect = goutil.addComponentOnce(self._rectTrSelect.gameObject, ComponentType.CanvasGroup)
	self._animSelect = self._registry:getUIComponent("0&com_select_tab_642439857", ComponentType.Animation)
	self._animSelectListener = Astral.AnimationEventListener.Get(self._animSelect.gameObject)

	self._animSelectListener:AddListener(self._onAnimEventSelect, self)
end

function M:destroyUI()
	self:setEvent(false)

	self._tabLstRoot = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end

	self.mainGO = nil

	self._animSelectListener:RemoveListener()

	self._animSelectListener = nil

	self:releaseTween()
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:setEvent(true)
end

function M:onExit()
	self:setEvent(false)
	self:releaseTween()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
	end
end

function M:getMainGO()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:getTabsCount()
	return #self._tabLst
end

function M:getTabComps(index)
	local comps = self._tabLst[index]

	if not comps then
		printError(string.format("不存在index = [%s]的tab", index))
	end

	return comps
end

function M:getToggleTab(index)
	local comps = self:getTabComps(index)

	if comps then
		return comps.toggleTab
	end

	return nil
end

function M:clearActiveTabIndex()
	self._activeTabIds = {}
end

function M:createTab()
	local tab = self:getToggleTab(1)

	if tab then
		local tabCount = self:getTabsCount()
		local go = goutil.cloneAndSetParent(tab.gameObject, self._rootRect)

		go.gameObject.name = string.format("tmp_%s", tabCount + 1)

		table.insert(self._tabLst, self:_buildTab(go))
	end
end

function M:setActiveTabIndexLst(indexIds)
	if not self._activeTabIds then
		self._activeTabIds = {}
	end

	for _, value in ipairs(indexIds or {}) do
		table.insert(self._activeTabIds, value)
	end
end

function M:setActiveTabIndex(index)
	if not self._activeTabIds then
		self._activeTabIds = {}
	end

	table.insert(self._activeTabIds, index)
end

function M:isTabActive(index)
	if self._activeTabIds and #self._activeTabIds > 0 then
		return table.indexof(self._activeTabIds, index)
	end

	return true
end

function M:setTabShow(index, show)
	local comps = self:getTabComps(index)

	if comps then
		goutil.setActive(comps.toggleTab.gameObject, show)
	end
end

function M:setTabName(index, str)
	local comps = self:getTabComps(index)

	if comps then
		comps.txt1.text = str
		comps.txt2.text = str
	end
end

function M:getIcons(index)
	local comps = self:getTabComps(index)

	if comps then
		return comps.icon1, comps.icon2
	end

	return nil
end

function M:setIconSprite(index, iconTyp, path)
	if string.nilorempty(path) then
		printWarn(string.format("尝试设置tab[%s]图片为空路径", index))

		return
	end

	local icon1, icon2 = self:getIcons(index)

	if icon1 then
		IconLoader.setSprite(icon1, iconTyp, path)
	end

	if icon2 then
		IconLoader.setSprite(icon2, iconTyp, path)
	end
end

function M:_handleOnSystemOpen(e)
	if not self.mainGO or goutil.isNil(self.mainGO) then
		return
	end

	for i = 1, self:getTabsCount() do
		local lock = not self:getIsSystemOpen(i)
		local online = self:getIsSystemOnline(i)
		local showOnLock = self:getIsSystemShowOnLock(i)
		local forceSetData = self:getForceSetLockData(i)

		if forceSetData then
			lock = forceSetData.lock
			online = forceSetData.online
			showOnLock = forceSetData.showOnLock
		end

		self:setLock(i, lock, online, showOnLock)
	end
end

function M:setSystemOpenLst(systemOpenKeyList)
	if systemOpenKeyList then
		self._systemOpenKeyList = systemOpenKeyList
	end

	self:_handleOnSystemOpen(nil)
end

function M:getIsSystemOpen(tabIndex)
	local key = self._systemOpenKeyList and self._systemOpenKeyList[tabIndex] or -1

	if key > 0 then
		return SystemOpenFacade.instance:isOpen(key, false)
	end

	return true
end

function M:getIsSystemOnline(tabIndex)
	local key = self._systemOpenKeyList and self._systemOpenKeyList[tabIndex] or -1

	if key > 0 then
		return SystemOpenModel.instance:getSystemIsOnline(key, true)
	end

	return true
end

function M:getIsSystemShowOnLock(tabIndex)
	local key = self._systemOpenKeyList and self._systemOpenKeyList[tabIndex] or -1

	if key > 0 then
		return SystemOpenFacade.instance:isShowOnLock(key)
	end

	return true
end

function M:setLock(index, lock, online, showOnLock)
	local comps = self:getTabComps(index)

	if comps then
		local showUI = not lock or lock and showOnLock or not online and showOnLock

		if not self:isTabActive(index) then
			showUI = false
		end

		goutil.setActive(comps.toggleTab.gameObject, showUI)

		if showUI then
			goutil.setActive(comps.imgLock.gameObject, lock)
		end
	end
end

function M:forceSetLock(index, lock, online, showOnLock)
	if not self._forceSetLockData then
		self._forceSetLockData = {}
	end

	self._forceSetLockData[index] = {
		lock = lock,
		online = online,
		showOnLock = showOnLock
	}

	self:setLock(index, lock, online, showOnLock)
end

function M:getForceSetLockData(index)
	if self._forceSetLockData then
		return self._forceSetLockData[index]
	end

	return nil
end

function M:setRedDotLst(redDotLst)
	self._redDotLst = redDotLst

	if self._redDotLst then
		for i = 1, self:getTabsCount() do
			local keyList = self._redDotLst[i] and self._redDotLst[i].keyList or nil

			if keyList then
				local comps = self:getTabComps(i)

				if comps and comps.redPointRoot then
					RedDotModel.instance:createDotView({
						dotNode = comps.redPointRoot,
						keyList = keyList
					})
				end
			end
		end
	end
end

function M:setRedPointNum(index, num)
	num = tonumber(num)

	if num > 0 then
		local comps = self:getTabComps(index)

		if comps then
			comps.redPointTxt.text = num

			goutil.setActive(comps.redPointRoot, num > 0)
		end
	else
		self:hideRedPoint(index)
	end
end

function M:hideRedPoint(index)
	local comps = self:getTabComps(index)

	if comps then
		goutil.setActive(comps.redPointRoot, false)
	end
end

function M:setRedPoint(index, isRed)
	local comps = self:getTabComps(index)

	if comps then
		goutil.setActive(comps.redPointRoot, isRed)
	end
end

function M:setRedPointTypeNum()
	for _, comps in pairs(self._tabLst or {}) do
		goutil.setActive(comps.redPointSubRootNum, true)
		goutil.setActive(comps.redPointSubRootStrong, false)
	end
end

function M:setRedPointTypeStrong()
	for _, comps in pairs(self._tabLst or {}) do
		goutil.setActive(comps.redPointSubRootNum, false)
		goutil.setActive(comps.redPointSubRootStrong, true)
	end
end

function M:setRedPointTypeWeakly()
	for _, comps in pairs(self._tabLst or {}) do
		goutil.setActive(comps.redPointSubRootNum, false)
		goutil.setActive(comps.redPointSubRootStrong, false)
		goutil.setActive(comps.redPointWeakly, true)
	end
end

function M:setRedPointWeaklyByIndex(index)
	if not index or not self._tabLst[index] then
		return
	end

	local comp = self._tabLst[index]

	goutil.setActive(comp.redPointSubRootNum, false)
	goutil.setActive(comp.redPointSubRootStrong, false)
	goutil.setActive(comp.redPointWeakly, true)
end

function M:_buildTab(tabGo)
	local tabInfo = {}

	tabInfo.toggleTab = tabGo:GetComponent(UIComponentType.SpaceXToggle)
	tabInfo.txt1 = goutil.findChildTextComponent(tabGo, "normal/Text1")
	tabInfo.txt2 = goutil.findChildTextComponent(tabGo, "select/Text1")
	tabInfo.icon1 = goutil.findChildImageComponent(tabGo, "normal/icon")
	tabInfo.icon2 = goutil.findChildImageComponent(tabGo, "select/icon")
	tabInfo.imgLock = goutil.findChildImageComponent(tabGo, "normal/lock")
	tabInfo.redPointRoot = goutil.findChild(tabGo, "red_point").gameObject
	tabInfo.redPointSubRootNum = goutil.findChild(tabGo, "red_point/type2").gameObject
	tabInfo.redPointTxt = goutil.findChildTextComponent(tabGo, "red_point/type2/txtNum")
	tabInfo.redPointSubRootStrong = goutil.findChild(tabGo, "red_point/type3").gameObject
	tabInfo.redPointWeakly = goutil.findChild(tabGo, "red_point/type1")

	goutil.setActive(tabInfo.redPointWeakly.gameObject, false)
	goutil.setActive(tabInfo.redPointSubRootNum, true)
	goutil.setActive(tabInfo.redPointTxt.gameObject, true)
	goutil.setActive(tabInfo.redPointRoot, false)

	return tabInfo
end

function M:playSelectAnim(name)
	if string.nilorempty(name) then
		return
	end

	self._animSelect:Stop()
	self._animSelect:Play(name)

	self._patternMark = M.AnimType.B

	if string.match(name, "_a") then
		self._patternMark = M.AnimType.A
	end
end

function M:_onAnimEventSelect(animationEvent)
	if not self._animSelect.gameObject.activeSelf then
		return
	end

	local param = animationEvent.stringParameter

	if param == "open" then
		self:playSelectAnim("right_tablist_idle_a")
	elseif param == "idle_a" then
		self:playSelectAnim("right_tablist_idle_a")
	elseif param == "idle_b" then
		self:playSelectAnim("right_tablist_idle_b")
	elseif param == "qie_a" then
		self:playSelectAnim("right_tablist_idle_a")
	elseif param == "qie_b" then
		self:playSelectAnim("right_tablist_idle_b")
	end
end

function M:releaseTween()
	self._rectTrSelect:DOKill(false)
	self._canvasGroupSelect:DOKill(false)

	if self._delayTween then
		self._delayTween:Kill(false)
	end

	self._delayTween = nil
end

function M:MoveSelectMark(tabIndex, duraion, speedBase)
	local comps = self:getTabComps(tabIndex)

	if not comps then
		return
	end

	duraion = duraion or 0

	RectTransformUtils.ForceRebuildLayoutImmediate(self._rootRect)

	local anchoredX, anchoredY = Astral.TransformUtil.GetAnchoredPos(comps.toggleTab.transform, 0, 0)

	self._cachePos:Set(anchoredX, anchoredY, 0)
	self._rectTrSelect:DOKill(false)

	if duraion > 0 then
		self._rectTrSelect:DOAnchorPos(self._cachePos, duraion):SetSpeedBased(speedBase):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)

		if self._patternMark == M.AnimType.A then
			self:playSelectAnim("right_tablist_qie_b")

			self._patternMark = M.AnimType.B
		else
			self:playSelectAnim("right_tablist_qie_a")

			self._patternMark = M.AnimType.A
		end
	else
		RectTransformUtils.SetAnchoredPosition(self._rectTrSelect, anchoredX, anchoredY)
	end
end

function M:playHideAllTabAni()
	self._guiAnimTab:ClearAllBinding()
	self._guiAnimTab:RemoveListener()
	self._guiAnimTab:StopTimelineAni()
	self._guiAnimTab:SetAniTime(0)

	if self._patternMark == M.AnimType.A then
		self:playSelectAnim("right_tablist_close_a")
	else
		self:playSelectAnim("right_tablist_close_b")
	end
end

function M:playShowTabAni(idx)
	self._guiAnimTab:ClearAllBinding()
	self._guiAnimTab:RemoveListener()
	self._guiAnimTab:StopTimelineAni()
	self._guiAnimTab:SetAniTime(0)

	self._activeIndex = idx

	self:setSelectMarkShow(true)
	self:MoveSelectMark(idx, 0)
	self:playSelectAnim("right_tablist_open")
end

function M:playGuiAniTab(open, isNormal, activeIndex)
	self._guiAnimTab:ClearAllBinding()
	self._guiAnimTab:RemoveListener()
	self._guiAnimTab:StopTimelineAni()
	self._guiAnimTab:SetAniTime(0)

	local timeLineMode = isNormal and Astral.GUITimeLineMode.TimeToStart or Astral.GUITimeLineMode.TimeToEnd

	if open then
		self._activeIndex = activeIndex

		if activeIndex == 1 then
			self:playSelectAnim("right_tablist_open")
		else
			self:setSelectMarkShow(not isNormal)
		end

		self:setSelectMarkShow(true)
		self:MoveSelectMark(activeIndex, 0)
		self._guiAnimTab:AddListener(self._dealTagTimelineListener, self)
		self._guiAnimTab:PlayAniByName("open", timeLineMode)

		for i = 1, self:getTabsCount() do
			if i ~= activeIndex then
				self._guiAnimTab:ClearBindingByName(string.format("%s", i))
			end
		end
	else
		self._guiAnimTab:PlayAniByName("close", timeLineMode)

		if self._patternMark == M.AnimType.A then
			self:playSelectAnim("right_tablist_close_a")
		else
			self:playSelectAnim("right_tablist_close_b")
		end

		self:setSelectMarkShow(false, 0.3)
	end
end

function M:_dealTagTimelineListener(tagName, reason)
	local _index = tonumber(tagName)

	if _index and _index == self._activeIndex then
		self:setSelectMarkShow(true, 0.3)
		self:MoveSelectMark(_index, 0)
		self:playSelectAnim("right_tablist_open")
	end
end

function M:setCanvasGroupShow(show, pointTargetAlpha, autoActiveDelay)
	if self._delayTween then
		self._delayTween:Kill(false)
	end

	self._delayTween = nil

	local alpha = show and 1 or 0

	if pointTargetAlpha then
		alpha = pointTargetAlpha
	end

	self._canvasGroup.alpha = alpha

	self:setCanvasInteractable(show)

	if not show and autoActiveDelay then
		self._delayTween = DoTweenUtil.DelayedCall(autoActiveDelay, function()
			self:setCanvasGroupShow(true)
		end)
	end
end

function M:setCanvasInteractable(active)
	self._canvasGroup.interactable = active
	self._canvasGroup.blocksRaycasts = active
end

function M:setSelectMarkShow(show, duration)
	self:showCanvas(self._canvasGroupSelect, show, duration)
end

function M:showCanvas(canvas, show, duration)
	if not canvas then
		return
	end

	duration = duration or 0

	local finalAlpha = show and 1 or 0

	canvas:DOKill(false)

	if duration > 0 then
		canvas:DOFade(finalAlpha, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	else
		canvas.alpha = finalAlpha
	end

	canvas.interactable = show
	canvas.blocksRaycasts = show
end

return M
