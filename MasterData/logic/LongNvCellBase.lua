-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/view/LongNvCellBase.lua

module("logic.extensions.directpurchase.view.LongNvCellBase", package.seeall)

local LongNvCellBase = class("LongNvCellBase")

function LongNvCellBase:ctor()
	return
end

function LongNvCellBase:buildUI(go)
	self._mainGo = go
	self._txtPower = goutil.findChildTextComponent(go, "power/txtPower")
	self._btnBuy = Framework.ButtonAdapter.GetFrom(go, "btnBuy")
	self._txtPrice = goutil.findChildTextComponent(go, "btnBuy/txtPrice")
	self._txtTitle = goutil.findChildTextComponent(go, "txtTitle")
	self._txtPrice.text = ""
	self._powerGo = goutil.findChild(go, "power")
	self._txtLimit = goutil.findChildTextComponent(go, "txtLimit")
end

function LongNvCellBase:bindEvents()
	self._btnBuy:AddClickListener(self._onClickBuy, self)
end

function LongNvCellBase:unbindEvents()
	self._btnBuy:RemoveClickListener()
end

function LongNvCellBase:init(id, activityId)
	self._id = id
	self._activityId = activityId

	self:_setTxtTitle()
end

function LongNvCellBase:getId()
	return self._id
end

function LongNvCellBase:onExit()
	return
end

function LongNvCellBase:_onClickBuy()
	return
end

function LongNvCellBase:update()
	return
end

function LongNvCellBase:_setTxtLimit(curNum, maxNum)
	self._txtLimit.text = string.format("优惠次数 %d/%d", curNum, maxNum)
end

function LongNvCellBase:_isHasBuyCount()
	return true
end

function LongNvCellBase:_showTip()
	FloatWordMgr.instance:show("已售罄")
end

function LongNvCellBase:_setBtnGray(isGray)
	GameUtil.SetGray(self._btnBuy, isGray)
end

function LongNvCellBase:_setTxtTitle()
	self._txtTitle.text = ""
end

function LongNvCellBase:_getShopItemId(activityId, id, petId)
	local petMo = BagModel.instance:getPet(petId)

	if petMo then
		local cfg = DirectPurchaseConfig.instance:getDirectUpPetCfg(activityId, checknumber(petMo.curFaceId), id)

		if cfg then
			return cfg.shopItemId, cfg.desc
		end
	end

	local cfg = DirectPurchaseConfig.instance:getDirectUpCfgById(activityId, id)

	return cfg.shopItemId, cfg.desc
end

return LongNvCellBase
