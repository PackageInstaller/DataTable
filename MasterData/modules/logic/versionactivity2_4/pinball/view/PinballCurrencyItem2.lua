-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballCurrencyItem2.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballCurrencyItem2", package.seeall)

local PinballCurrencyItem2 = class("PinballCurrencyItem2", PinballCurrencyItem)

function PinballCurrencyItem2:init(go)
	self._txtNum = gohelper.findChildTextMesh(go, "#txt_num")
	self._imageicon = gohelper.findChildImage(go, "#image_icon")
	self._btn = gohelper.findButtonWithAudio(go)
	self._anim = gohelper.findChildAnim(go, "")
end

function PinballCurrencyItem2:addEventListeners()
	PinballCurrencyItem2.super.addEventListeners(self)
	PinballController.instance:registerCallback(PinballEvent.OperBuilding, self._refreshUI, self)
	PinballController.instance:registerCallback(PinballEvent.LearnTalent, self._refreshUI, self)
end

function PinballCurrencyItem2:removeEventListeners()
	PinballCurrencyItem2.super.removeEventListeners(self)
	PinballController.instance:unregisterCallback(PinballEvent.OperBuilding, self._refreshUI, self)
	PinballController.instance:unregisterCallback(PinballEvent.LearnTalent, self._refreshUI, self)
end

function PinballCurrencyItem2:_refreshUI()
	local num = PinballModel.instance:getResNum(self._currencyType)
	local max = self._currencyType == PinballEnum.ResType.Food and PinballModel.instance:getTotalFoodCost() or self._currencyType == PinballEnum.ResType.Play and PinballModel.instance:getTotalPlayDemand() or 0

	max = math.max(max, 0)

	if self._cacheNum and (self._cacheNum ~= num or self._cacheMaxNum ~= max) then
		self._anim:Play("refresh", 0, 0)
	end

	self._cacheNum = num
	self._cacheMaxNum = max
	self._txtNum.text = max <= num and GameUtil.numberDisplay(num) .. "/" .. GameUtil.numberDisplay(max) or "<color=#9F342C>" .. GameUtil.numberDisplay(num) .. "</color>/" .. GameUtil.numberDisplay(max)

	local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][self._currencyType]

	if not resCo then
		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(self._imageicon, resCo.icon)
end

function PinballCurrencyItem2:_openTips()
	local trans = self._imageicon.transform
	local scale = trans.lossyScale
	local pos = trans.position
	local width = recthelper.getWidth(trans)
	local height = recthelper.getHeight(trans)

	pos.x = pos.x - width / 2 * scale.x
	pos.y = pos.y + height / 2 * scale.y

	ViewMgr.instance:openView(ViewName.PinballCurrencyTipView, {
		arrow = "TR",
		type = self._currencyType,
		pos = pos
	})
end

return PinballCurrencyItem2
