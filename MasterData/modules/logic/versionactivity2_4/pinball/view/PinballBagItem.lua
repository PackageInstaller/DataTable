-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballBagItem.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballBagItem", package.seeall)

local PinballBagItem = class("PinballBagItem", LuaCompBase)

function PinballBagItem:init(go)
	self.go = go
	self._click = gohelper.findChildClickWithDefaultAudio(go, "")
	self._txtNum = gohelper.findChildTextMesh(go, "#txt_num")
	self._imageicon = gohelper.findChildImage(go, "#image_icon")
	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(go)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})
end

function PinballBagItem:addEventListeners()
	self._click:AddClickListener(self._onClick, self)
	self._btnLongPress:AddLongPressListener(self._onLongClickItem, self)
end

function PinballBagItem:removeEventListeners()
	self._click:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()
end

function PinballBagItem:_onClick()
	if self._curNum <= 0 then
		return
	end

	if self._canPlaceNum <= 0 then
		return
	end

	PinballController.instance:dispatchEvent(PinballEvent.ClickBagItem, self._resType)
end

function PinballBagItem:_onLongClickItem()
	local trans = self._imageicon.transform
	local scale = trans.lossyScale
	local pos = trans.position
	local width = recthelper.getWidth(trans)

	pos.x = pos.x + width / 2 * scale.x

	ViewMgr.instance:openView(ViewName.PinballCurrencyTipView, {
		isMarbals = true,
		arrow = "TR",
		type = self._resType,
		pos = pos
	})
end

function PinballBagItem:setInfo(resType, curNum, canPlaceNum)
	self._resType = resType or self._resType
	self._curNum = curNum or self._curNum
	self._canPlaceNum = canPlaceNum

	if self._resType > 0 then
		local co = lua_activity178_marbles.configDict[VersionActivity2_4Enum.ActivityId.Pinball][self._resType]
		local alpha = curNum > 0 and canPlaceNum > 0 and 1 or 0.5

		UISpriteSetMgr.instance:setAct178Sprite(self._imageicon, co.icon, true, alpha)
		ZProj.UGUIHelper.SetColorAlpha(self._imageicon, alpha)
	end

	self._txtNum.text = self._curNum
end

return PinballBagItem
