-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthSignin/model/MonthSignItemCell.lua

module("logic.extensions.monthSignin.model.MonthSignItemCell", package.seeall)

local M = class("MonthSignItemCell")

function M:ctor(compContainer)
	self._go = compContainer.gameObject
	self._isShowTips = true
	self._isShowSelectedEffect = false
	self._showTipsPassEvent = true
	self._isHideGetWay = false
	self._isHideLock = false
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
	self:_setEvent(true)
end

function M:OnDestroy()
	self:unbindEvents()
	self:_setEvent(false)
end

function M:buildUI()
	local mainGO = self._go
	local contentGo = goutil.findChild(mainGO, "content").gameObject

	self._contentCanvasGroup = contentGo:GetComponent(ComponentType.CanvasGroup)
	self._normalImageGo = goutil.findChild(mainGO, "content/imgDi_normal").gameObject
	self._specialImageGo = goutil.findChild(mainGO, "content/imgDi_sp").gameObject
	self._dateNumberTxt = goutil.findChildTextComponent(mainGO, "content/txtDate")
	self._iconImage = goutil.findChildImageComponent(mainGO, "content/icon")
	self._txtNumberTxt = goutil.findChildComponent(mainGO, "content/txtNum", typeof(TMPro.TMP_Text))
	self._receiveGo = goutil.findChild(mainGO, "imgReceived").gameObject
	self._selectGo = goutil.findChild(mainGO, "select").gameObject
	self._btnGo = UIComponentType.ButtonAdapter(mainGO)
	self._animation = mainGO:GetComponent(ComponentType.Animation)
	self._image = goutil.findChild(mainGO, "image").gameObject
end

function M:bindEvents()
	self._btnGo:AddClickListener(self._dealSelect, self)
end

function M:unbindEvents()
	self._btnGo:RemoveClickListener()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.MONTHSING_CURRENT_SELECT, self._setSelectGo, self)
		GlobalDispatcher:addEventListener(EventType.ITEMTIPS_CLOSE, self._selcetClose, self)
	else
		GlobalDispatcher:removeEventListener(EventType.MONTHSING_CURRENT_SELECT, self._setSelectGo, self)
		GlobalDispatcher:removeEventListener(EventType.ITEMTIPS_CLOSE, self._selcetClose, self)
	end
end

function M:updateData(signmo)
	self._animation:Stop()

	self._data = signmo:getData()
	self._id = signmo:getID()
	self._icon = signmo:getRewardIcon()
	self._status = signmo:getStatus()
	self._count = signmo:getRewardCount()
	self._isSp = signmo:getIsSp()
	self._itemType = signmo:getItemType()

	if self._isSp == 1 then
		goutil.setActive(self._specialImageGo, true)
		goutil.setActive(self._normalImageGo, false)
	else
		goutil.setActive(self._normalImageGo, true)
		goutil.setActive(self._specialImageGo, false)
	end

	self:setStatus()

	self._txtNumberTxt.text = self._count
	self._dateNumberTxt.text = self._id

	IconLoader.setSpriteByItemType(self._iconImage, self._itemType, self._icon)
end

function M:getStatus()
	return self._status
end

function M:setStatus()
	self._contentCanvasGroup.alpha = 1

	goutil.setActive(self._selectGo, false)
	goutil.setActive(self._receiveGo, false)

	if self._status == 1 then
		self._contentCanvasGroup.alpha = 0.1

		goutil.setActive(self._receiveGo, true)
	elseif self._status == 2 then
		goutil.setActive(self._selectGo, true)
	end
end

function M:_setSelectGo(e, id)
	goutil.setActive(self._selectGo, self._id == id or self._status == 2)
end

function M:_selcetClose()
	if self._status ~= 2 then
		goutil.setActive(self._selectGo, false)
	end
end

function M:_dealSelect()
	GlobalDispatcher:dispatchEvent(self._data:getItemMarkType(), self._data, self._go, 0, self._isShowTips, self._showTipsPassEvent, self._isHideGetWay, self._isHideLock)
	GlobalDispatcher:dispatchEvent(EventType.MONTHSING_CURRENT_SELECT, self._id)
end

function M:animationPlay()
	self._animation:Stop()
	self._animation:Play()
end

function M:imageActive()
	goutil.setActive(self._image, false)
end

return M
