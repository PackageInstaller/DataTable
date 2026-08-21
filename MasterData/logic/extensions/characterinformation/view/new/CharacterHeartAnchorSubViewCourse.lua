-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterinformation/view/new/CharacterHeartAnchorSubViewCourse.lua

module("logic.extensions.characterinformation.view.new.CharacterHeartAnchorSubViewCourse", package.seeall)

local M = class("CharacterHeartAnchorSubViewCourse")

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

	self._canvasGroupMain = goutil.addComponentOnce(mainGO, ComponentType.CanvasGroup)
	self._guiAnimation = goutil.addComponentOnce(mainGO, typeof(Astral.GUITimelineAniLua))

	self._guiAnimation:AddListener(self._animationDoneListener, self)

	self._goRightMask = registry:findUIElement("heart_anchor_course_view_45356138")

	goutil.setActive(self._goRightMask, false)

	self._canvasGroupCarryItem = registry:findUIElement("heart_anchor_course_view_1444864395", ComponentType.CanvasGroup)

	goutil.setActive(self._canvasGroupCarryItem.gameObject, true)

	self._cellCarryItems = {}

	local carryItemRoot = registry:findUIElement("heart_anchor_course_view_1444864395", UIComponentType.RectTransform)
	local carryIndex = 1

	for i = 0, carryItemRoot.childCount - 1 do
		table.insert(self._cellCarryItems, self:_buildCellCarryItem(carryItemRoot:GetChild(i).gameObject, carryIndex))

		carryIndex = carryIndex + 1
	end

	self._compSublimed = Astral.SimpleLuaComponentContainer.Add(mainGO, CharacterHeartAnchorViewCompSublimed)
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

	for _, cell in pairs(self._cellCarryItems) do
		cell.destroyUI()
	end

	self._cellCarryItems = nil
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
	self:_updateCarryItem()
	self._compSublimed:onEnter()
	self:showCarryItem(true)
	self:checkTaskRedDot()

	local animName = changePage and "heart_anchor_course_view_out" or "open"

	self:playGuiAni(animName, isNormal)
	self:blockClick(true)
	self:setVisible(true)
end

function M:onEnterFinished()
	return
end

function M:onExit(isNormal, changePage)
	self:setEvent(false)
	self._compSublimed:onExit(isNormal, changePage)
	self._canvasGroupCarryItem:DOKill(false)
	self:blockClick(true)

	if isNormal then
		local animName = changePage and "heart_anchor_course_view_entry" or "close"

		self:playGuiAni(animName, isNormal)
	end
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
		GlobalDispatcher:addEventListener(EventType.HERO_INFO_RED_DOT_CHANGE, self._handleHeroInfoRedDotChange, self)
		GlobalDispatcher:addEventListener(EventType.RED_DOT_UPDATE_EVENT, self._handleHeroInfoRedDotChange, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_ANCHOR_SUBLIMED_VIEW_ENTER, self._handleTacitAnchorSublimedViewEnter, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_REFRESH_TASK_VIEW, self._handleTacitRefreshTaskView, self)
		GlobalDispatcher:addEventListener(EventType.TACIT_ANCHOR_WAKE_UP_PROCESSING, self._handleTacitAnchorWakeUpProcessing, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HERO_INFO_RED_DOT_CHANGE, self._handleHeroInfoRedDotChange, self)
		GlobalDispatcher:removeEventListener(EventType.RED_DOT_UPDATE_EVENT, self._handleHeroInfoRedDotChange, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_ANCHOR_SUBLIMED_VIEW_ENTER, self._handleTacitAnchorSublimedViewEnter, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_REFRESH_TASK_VIEW, self._handleTacitRefreshTaskView, self)
		GlobalDispatcher:removeEventListener(EventType.TACIT_ANCHOR_WAKE_UP_PROCESSING, self._handleTacitAnchorWakeUpProcessing, self)
	end
end

function M:_handleHeroInfoRedDotChange(e, heroId)
	self:_updateCarryItem()
end

function M:_handleTacitAnchorSublimedViewEnter(e, enter, isExistBySublimedFinish)
	self:showCarryItem(not enter, 0.1, 0.1)

	local isVaild = self:_isVaildToImpressionTask()

	goutil.setActive(self._goRightMask, enter)

	if enter then
		self:playGuiAni("heart_anchor_course_view_promote", true)
	elseif not isExistBySublimedFinish then
		self:playGuiAni("heart_anchor_course_view_promote_back", true)
	end
end

function M:_handleTacitRefreshTaskView(e, rewardingTaskId, markPrimaryTask, isUpgrade)
	self:checkTaskRedDot()
end

function M:_handleTacitAnchorWakeUpProcessing(e, isProcessing)
	if isProcessing then
		self:playGuiAni("heart_anchor_course_view_sublimation", true)
	else
		self:playGuiAni("heart_anchor_course_view_sublimation_back", true)
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
	elseif tagName == "course1" then
		self:setVisible(false)
	elseif tagName == "course2" then
		self:blockClick(false)
	elseif tagName == "course3" then
		self:blockClick(false)
	elseif tagName == "course4" then
		-- block empty
	elseif tagName == "sublimation" then
		self._compSublimed:onWakeUpAnimDone()
	end
end

function M:_isVaildToImpressionTask()
	local heroData = self:getCurHeroData()
	local isVaild = true
	local cfg = TacitConfig.instance:getTacitCO(heroData:getId())

	if not cfg then
		isVaild = false
	elseif cfg.isOnLine <= 0 then
		isVaild = false
	end

	return isVaild
end

function M:checkTaskRedDot()
	local hasRedDot = self:getHasTaskCanFinish()
	local isVaild = self:_isVaildToImpressionTask()
end

function M:getHasTaskCanFinish()
	local has = false

	for i = 1, 3 do
		if has == false and TacitModel.instance:checkHasRedDot(i) then
			has = true
		end
	end

	return has
end

function M:showCarryItem(show, duration, delay)
	duration = duration or 0
	delay = delay or 0

	local finalAlpha = show and 1 or 0

	self._canvasGroupCarryItem:DOKill(false)

	if duration > 0 then
		self._canvasGroupCarryItem:DOFade(finalAlpha, duration):SetDelay(delay):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
	else
		self._canvasGroupCarryItem.alpha = finalAlpha
	end

	self._canvasGroupCarryItem.interactable = show
	self._canvasGroupCarryItem.blocksRaycasts = show
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

function M:setBg(path)
	return
end

function M:_updateCarryItem()
	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local carryItemLst = CharacterUnlockContentConfig.instance:getCarryItemLst(heroId)

	for index, cell in ipairs(self._cellCarryItems) do
		local cfg = carryItemLst[index]

		if cfg then
			cell.updateData(cfg, heroData)
		end

		cell.setVisible(cfg)
	end
end

function M:_buildCellCarryItem(go, index)
	local cell = {}

	cell.go = go
	cell.index = index
	cell.txtName = goutil.findChildComponent(go, "txtName", UIComponentType.TextMeshProUGUI)
	cell.goMarkLock = goutil.findChild(go, "lock").gameObject
	cell.goMarkNew = goutil.findChild(go, "new").gameObject
	cell.canvasGroup = goutil.findChildComponent(go, "content", ComponentType.CanvasGroup)
	cell.imgIcon = goutil.findChildImageComponent(go, "content/icon")
	cell.btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)

	function cell.setLock(lock)
		goutil.setActive(cell.goMarkLock, lock)

		cell.canvasGroup.alpha = lock and 0.5 or 1
	end

	function cell.setNew(new)
		goutil.setActive(cell.goMarkNew, new)
	end

	function cell.updateData(cfg, heroData)
		cell.itemId = cfg and cfg.carryId or nil

		local imgPath = cfg and cfg.icon or nil
		local name = cfg and cfg.name or ""

		if not string.nilorempty(imgPath) then
			IconLoader.setSprite(cell.imgIcon, IconType.CharacterHeartAnchorCarryItem, imgPath)
		end

		if cell.itemId then
			local isUnlock = CharacterInformationModel.instance:getUnlockPastInfo(heroData:getId(), cell.itemId)

			cell.setLock(not isUnlock)

			if not isUnlock then
				local needTacitLv = CharacterInformationController.instance:getPastInfoItemUnLockTacitLv(heroData:getId(), cell.itemId)

				name = needTacitLv > 0 and langF("tip_tacit_item_lock_name", needTacitLv) or name
			end
		end

		local isNew = CharacterInformationModel.instance:getIsNewPastInfo(heroData:getId(), cell.itemId)

		if cell.itemId == CharacterInfoEnum.UnlockTyp.CarryItem1 then
			local heroData = self:getCurHeroData()
			local heroId = heroData:getId()

			isNew = CharacterInformationController.instance:isCarryItem1New(heroId)
		end

		cell.setNew(isNew)

		name = StringUtil.replaceTMPBlackBlock(name, "#B6B7B7")
		cell.txtName.text = name
	end

	function cell.setVisible(visible)
		goutil.setActive(cell.go, visible)
	end

	cell.btnClick:AddClickListener(function()
		local itemId = cell.itemId

		self:_onCellCarryItemClick(itemId)
	end, self)

	function cell.destroyUI()
		cell.btnClick:RemoveClickListener()
	end

	return cell
end

function M:_onCellCarryItemClick(itemId)
	local heroData = self:getCurHeroData()
	local heroId = heroData:getId()
	local online = CharacterUnlockContentConfig.instance:getCarryItemOnline(heroId, itemId)

	if not online then
		ToolTipsMgr.showCharacterTopToast(lang("tip_system_open_not_online"), CommEnum.CharacterTopToastIcon.Info, 1)

		return
	end

	local isUnlock = CharacterInformationModel.instance:getUnlockPastInfo(heroId, itemId)

	if isUnlock then
		ToolTipsMgr.showCharacterHeartAnchorCarryItemInfoTips(heroId, itemId)

		local isNEWCarryItem1 = CharacterInformationController.instance:isCarryItem1New(heroId)

		if isNEWCarryItem1 then
			RedDotAgent.instance:sendRemoveRedPointRequest(GameEnum.RedPointEnum.HeroCarryItem, {
				heroId
			})
		end
	else
		local conditionLst = CharacterUnlockContentConfig.instance:getConditionLstPastId(heroId, itemId)
		local str = CharacterInformationController.instance:getConditionUnlockDesc(conditionLst)

		ToolTipsMgr.showCharacterTopToast(str, CommEnum.CharacterTopToastIcon.Info, 1)
	end
end

return M
