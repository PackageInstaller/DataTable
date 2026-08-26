-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballCurrencyItem.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyItem", package.seeall)

local PinballCurrencyItem = class("PinballCurrencyItem", LuaCompBase)

function PinballCurrencyItem:init(go)
	self._txtNum = gohelper.findChildTextMesh(go, "content/#txt")
	self._imageicon = gohelper.findChildImage(go, "#image")
	self._btn = gohelper.findButtonWithAudio(go)
	self._anim = gohelper.findChildAnim(go, "")
end

function PinballCurrencyItem:addEventListeners()
	self._btn:AddClickListener(self._openTips, self)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, self._refreshUI, self)
	PinballController.instance:registerCallback(PinballEvent.EndRound, self._refreshUI, self)
end

function PinballCurrencyItem:removeEventListeners()
	self._btn:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, self._refreshUI, self)
	PinballController.instance:unregisterCallback(PinballEvent.EndRound, self._refreshUI, self)
end

function PinballCurrencyItem:setCurrencyType(currencyType)
	self._currencyType = currencyType

	self:_refreshUI()
end

function PinballCurrencyItem:_refreshUI()
	local num = PinballModel.instance:getResNum(self._currencyType)

	if self._cacheNum and num > self._cacheNum then
		self._anim:Play("refresh", 0, 0)
	end

	self._cacheNum = num
	self._txtNum.text = GameUtil.numberDisplay(num)

	local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][self._currencyType]

	if not resCo then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(self._imageicon, resCo.icon)
end

function PinballCurrencyItem:_openTips()
	local trans = self._imageicon.transform
	local scale = trans.lossyScale
	local pos = trans.position
	local width = recthelper.getWidth(trans)
	local height = recthelper.getHeight(trans)

	pos.x = pos.x + width / 2 * scale.x
	pos.y = pos.y - height / 2 * scale.y

	ViewMgr.instance:openView(ViewName.PinballCurrencyTipView, {
		arrow = "BL",
		type = self._currencyType,
		pos = pos
	})
end

return PinballCurrencyItem
