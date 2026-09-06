-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/ViplvView.lua

module("logic.extensions.vip.view.ViplvView", package.seeall)

local ViplvView = class("ViplvView", ViewComponent)

function ViplvView:ctor()
	ViplvView.super.ctor(self)
end

function ViplvView:buildUI()
	ViplvView.super.buildUI(self)

	self._btnOpenView = self:getBtn("bg/btnOpenView")
	self._btnShowTip = self:getBtn("bg/vipExpSld/txtChargeTip/btnShowTip")
	self._goCloseTip = self:getGo("btnCloseTip")
	self._btnCloseTip = GameUtil.asBtn(self._goCloseTip)
	self._txtChargeTip = self:getTxt("bg/vipExpSld/txtChargeTip")
	self._txtCurExp = self:getTxt("bg/vipExpSld/txtCurExp")
	self._sldVipExp = self:getSlider("bg/vipExpSld")
	self._txtCurLV = self:getGo("bg/vipLv/imgTxtNum"):GetComponent(ComponentType.UIImgNumeralText)
end

function ViplvView:bindEvents()
	ViplvView.super.bindEvents(self)
	self._btnOpenView:AddClickListener(self._onClickBtnOpenView, self)
	self._btnShowTip:AddClickListener(self._onClickBtnShowTip, self)
	self._btnCloseTip:AddClickListener(self._onClickBtnCloseTip, self)
end

function ViplvView:unbindEvents()
	ViplvView.super.unbindEvents(self)
	self._btnOpenView:RemoveClickListener()
	self._btnShowTip:RemoveClickListener()
	self._btnCloseTip:RemoveClickListener()
end

function ViplvView:destroyUI()
	ViplvView.super.destroyUI(self)
end

function ViplvView:onEnter()
	ViplvView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.BroadcastCurVipLevel, self._updateView, self)
	self:_updateView()
end

function ViplvView:onEnterFinished()
	ViplvView.super.onEnterFinished(self)
end

function ViplvView:onExit()
	ViplvView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BroadcastCurVipLevel, self._updateView, self)
end

function ViplvView:onExitFinished()
	ViplvView.super.onExitFinished(self)
end

function ViplvView:_onClickBtnOpenView()
	UIStateManager.instance:push(ViewName.VipView)
end

function ViplvView:_onClickBtnShowTip()
	GameUtil.SetActive(self._goCloseTip, true)
end

function ViplvView:_onClickBtnCloseTip()
	GameUtil.SetActive(self._goCloseTip, false)
end

function ViplvView:_updateView()
	local curExp = VipModel.instance:getCurVipExp()
	local curLv = VipModel.instance:getCurVipLv()
	local curExpMax = VipModel.instance:getCurVipLvExpMax()
	local isVipMax = VipModel.instance:getIsVipExpMax()

	self._txtCurLV:SetText(tostring(curLv))

	self._txtCurExp.text = curExp .. "/" .. curExpMax

	self._sldVipExp:SetValue(checknumber(curExp) / checknumber(curExpMax))

	if isVipMax then
		self._txtChargeTip.text = lang("当前已达到最高VIP等级")
	else
		local str = string.format("再消费%s元可升级至<color=#D56D09FF>VIP%s</color>", curExpMax - curExp, curLv + 1)

		self._txtChargeTip.text = lang(str)
	end
end

return ViplvView
