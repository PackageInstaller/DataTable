-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/view/EchoCardUnpackShowView.lua

module("logic.extensions.echocardpack.view.EchoCardUnpackShowView", package.seeall)

local M = class("EchoCardUnpackShowView", ViewComponent)
local unpackState = EchoCardPackController.UnpackState
local audioNames = {
	[GameEnum.QualityEnum.D] = CriwareAudioEnum.ui_canxiang_zhanshi_b,
	[GameEnum.QualityEnum.C] = CriwareAudioEnum.ui_canxiang_zhanshi_b,
	[GameEnum.QualityEnum.B] = CriwareAudioEnum.ui_canxiang_zhanshi_b,
	[GameEnum.QualityEnum.A] = CriwareAudioEnum.ui_canxiang_zhanshi_a,
	[GameEnum.QualityEnum.S] = CriwareAudioEnum.ui_canxiang_zhanshi_s
}

function M:buildUI()
	self._goShow = self:getGo("echocard_unpacking_view_1084340135")
	self._btnSkip = self:getBtn("echocard_unpacking_view_983990286")
	self._btnClick = self:getBtn("echocard_unpacking_view_718163330")
	self._txtTimes = self:getText("echocard_unpacking_view_1722387162")
	self._toggle = self:getUIComponent("echocard_unpacking_view_-197512022", UIComponentType.SpaceXToggle)
	self._guiAnimation = self._goShow:GetComponent(typeof(Astral.GUITimelineAniLua))
	self._showItems = {}
	self._goMask = goutil.findChild(self._goShow, "mask")

	for i = 1, 5 do
		local cardGo = goutil.findChild(self._goShow, "cardPos" .. i .. "/echocard_unpacking_item")
		local item = Astral.LuaComponentContainer.Add(cardGo, EchoCardUnpackShowViewItem)

		item:setClickFunction(self._onHandleItemClick, self)

		self._showItems[i] = item
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._showNext, self)
	self._btnSkip:AddClickListener(self._onClickSkip, self)
	self._toggle:AddListener(self._onToggleChange, self)
end

function M:unbindEvents()
	self._toggle:RemoveListener()
	self._btnClick:RemoveClickListener()
	self._btnSkip:RemoveClickListener()
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ECHO_UNPACK_STATE_CHANGE, self._handleUnpackStateChange, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_UNPACK_SHOW_NEXT, self._handleUnpackShowNext, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ECHO_UNPACK_STATE_CHANGE, self._handleUnpackStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_UNPACK_SHOW_NEXT, self._handleUnpackShowNext, self)
	end
end

function M:onEnter()
	ViewMgr.instance:close(ViewName.EchoCardUnpackResultView)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
	self:_setEvents(true)

	self._showTimes = 0
	self._results = EchoCardPackController.instance:getCacheResult()
	self._isAutoOpen = PlayerModel.instance:getLocalStorageInt(EchoCardPackController.AutoOpenCardKey, 0) == 1
	self._toggle.IsOn = self._isAutoOpen
	self._needShowTimes = EchoCardPackController.instance:getUnpackNum()

	goutil.setActive(self._goMask, false)
	self:_handleUnpackStateChange()
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
	self:_setEvents(false)
	removetimer(self._resetShowSEchoAnimState, self)
	removetimer(self._playAnimationEnd, self)
end

function M:_onClickSkip()
	if not EchoCardPackController.instance:getModelInitState() then
		return
	end

	if EchoCardPackController.instance:getShowCutInState() then
		return
	end

	if EchoCardPackController.instance:getShowSEchoAnim() then
		return
	end

	if not self._hasShowDissolveAnim then
		self:showDissolveAnim()

		return
	end

	EchoCardPackController.instance:setSkipState(true)
	GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_SHOW_NEXT)
end

function M:_showNext()
	if not EchoCardPackController.instance:getModelInitState() then
		return
	end

	if EchoCardPackController.instance:getShowCutInState() then
		return
	end

	local state = EchoCardPackController.instance:getUnpackState()

	if state == unpackState.UnpackEnd then
		if EchoCardPackController.instance:getShowSEchoAnim() then
			return
		end

		if not self._hasShowDissolveAnim then
			self:showDissolveAnim()

			return
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_SHOW_NEXT)
end

function M:_handleUnpackStateChange()
	local state = EchoCardPackController.instance:getUnpackState()
	local isShowBtnClick = state == unpackState.UnpackEnd or state == unpackState.UnInOrder

	goutil.setActive(self._btnClick.gameObject, isShowBtnClick)
	goutil.setActive(self._goShow, state == unpackState.UnpackEnd)
	self:_handleUnpackShowNext()
end

function M:_jumpToResultView()
	ViewMgr.instance:open(ViewName.EchoCardUnpackResultView)
	self:close()
end

function M:_handleUnpackShowNext()
	local state = EchoCardPackController.instance:getUnpackState()

	if state ~= unpackState.UnpackEnd then
		return
	end

	if self._showTimes >= self._needShowTimes then
		self:_jumpToResultView()

		return
	end

	if not self:_checkIsSkip() then
		self:_updateItems()
	else
		self:_jumpToResultView()
	end
end

function M:_checkIsSkip()
	local isSkip = EchoCardPackController.instance:getSkipState()

	if not isSkip then
		return false
	end

	EchoCardPackController.instance:setSkipState(false)

	local startTimes = self._showTimes

	while startTimes < self._needShowTimes do
		for i = startTimes * 5 + 1, startTimes * 5 + 5 do
			if self._results[i].itemData:getQuality() == GameEnum.QualityEnum.S then
				self._showTimes = startTimes

				return false
			end
		end

		startTimes = startTimes + 1
	end

	return true
end

function M:_onToggleChange(index, isOn)
	if self._isAutoOpen == isOn then
		return
	end

	self._isAutoOpen = isOn

	if self._isAutoOpen and not self._hasShowDissolveAnim then
		self:showDissolveAnim()
	end

	PlayerModel.instance:setLocalStorageInt(EchoCardPackController.AutoOpenCardKey, self._isAutoOpen and 1 or 0)
end

function M:_updateItems()
	local startIndex = self._showTimes * 5 + 1
	local endIndex = startIndex + 4

	self._showDatas = {}

	for i = startIndex, endIndex do
		table.insert(self._showDatas, self._results[i])
	end

	self._showTimes = self._showTimes + 1
	self._txtTimes.text = self._showTimes .. "/" .. self._needShowTimes
	self._maxQuality = GameEnum.QualityEnum.D
	self._hasShowDissolveAnim = true

	EchoCardPackController.instance:setShowSEchoAnim(false)

	for i = 1, #self._showItems do
		local itemView = self._showItems[i]

		itemView:refreshView(self._showDatas[i].itemData)

		local quality = self._showDatas[i].itemData:getQuality()

		if quality > self._maxQuality then
			self._maxQuality = quality
		end

		local isS = quality == GameEnum.QualityEnum.S

		if isS then
			itemView:setBackActiveState(true)

			self._hasShowDissolveAnim = false
		else
			itemView:setBackActiveState(false)
		end
	end

	CriwareAudioFacade.instance:playOnceSEbyId(audioNames[self._maxQuality], nil, nil, nil)
	GlobalDispatcher:dispatchEvent(EventType.ECHO_UNPACK_SHOW_QUALITY_EFFECT, self._maxQuality)
	self:_onPlayAnimation()
end

function M:_onHandleItemClick(itemView)
	self:showDissolveAnim()
end

function M:showDissolveAnim()
	if EchoCardPackController.instance:getShowSEchoAnim() then
		return
	end

	if self._hasShowDissolveAnim then
		return
	end

	EchoCardPackController.instance:setShowSEchoAnim(true)
	removetimer(self._resetShowSEchoAnimState, self)
	settimer(1.2, self._resetShowSEchoAnimState, self, false)

	self._hasShowDissolveAnim = true

	for i = 1, #self._showItems do
		local itemView = self._showItems[i]

		itemView:showDissolveAnim()
	end
end

function M:_resetShowSEchoAnimState()
	EchoCardPackController.instance:setShowSEchoAnim(false)
end

function M:_onPlayAnimation()
	goutil.setActive(self._goMask, true)
	self._guiAnimation:StopTimelineAni()

	local aniName = "open"
	local time = self._guiAnimation:GetTrackEndTime(aniName)

	self._guiAnimation:PlayAniByName(aniName)
	removetimer(self._playAnimationEnd, self)
	settimer(time, self._playAnimationEnd, self, false)
end

function M:_playAnimationEnd()
	goutil.setActive(self._goMask, false)

	if self._isAutoOpen then
		self:showDissolveAnim()
	end
end

return M
