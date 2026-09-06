-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vip/view/VipView.lua

module("logic.extensions.vip.view.VipView", package.seeall)

local VipView = class("VipView", ViewComponent)

function VipView:ctor()
	VipView.super.ctor(self)
end

local leftTabs = {
	{
		showTip = "VIP奖励",
		id = 1,
		view = ViewName.VipgiftView
	},
	{
		showTip = "VIP特权",
		id = 2,
		view = ViewName.VipprivilegeView
	}
}

function VipView:buildUI()
	VipView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRecharge = self:getBtn("btnRecharge")
	self._btnRecord = self:getBtn("btnRecord")
	self._txtLevel = self:getGo("level/txt"):GetComponent(ComponentType.UIImgNumeralText)
	self._sldProgress = self:getSlider("progress")
	self._txtProgress = self:getTxt("progress/txtProgress")
	self._txtChargeTip = self:getTxt("txtChargeTip")
	self._tabCell = self:getGo("tabCell")
	self._leftTabs = self:getGo("leftTabView")
	self._leftTabView = ScrollerList.create(self._leftTabs, self._tabCell, GameUtil.handler(self._updateLeftTabs, self), GameUtil.handler(self._clearLeftTabs, self))
	self._conView = self:getGo("conView")
	self._showTip = self:getGo("btnShowTip/showTip")
	self._btnShowTip = self:getBtn("btnShowTip")
	self._bg = self:getGo("bg")
	self._level = self:getGo("level")
end

function VipView:bindEvents()
	VipView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnRecharge:AddClickListener(self._onClickBtnReCharge, self)
	self._btnRecord:AddClickListener(self._onClickBtnRecord, self)
	self._btnShowTip:AddClickListener(self._onClickBtnShowTip, self)
end

function VipView:unbindEvents()
	VipView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRecharge:RemoveClickListener()
	self._btnRecord:RemoveClickListener()
	self._btnShowTip:RemoveClickListener()
end

function VipView:destroyUI()
	VipView.super.destroyUI(self)
end

function VipView:onEnter()
	VipView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.BroadcastCurVipLevel, self.updateUI, self)
	VipController.instance:sendGetVipInfoReq()
	self._leftTabView:reloadData(leftTabs)

	self._curSelectId = self:getFirstParam() or 1

	self:_onClickLeftTab(leftTabs[self._curSelectId])
	self:_onClickBtnShowTip()

	self._bgEff = self:_playEff("fx_ui_vip/fx_ui_vip_bg.prefab", self._bg)
	self._levelEff = self:_playEff("fx_ui_vip/fx_ui_vip_vip.prefab", self._level)
end

function VipView:onEnterFinished()
	VipView.super.onEnterFinished(self)
end

function VipView:onExit()
	VipView.super.onExit(self)
	removetimer(self._finishPlayBubble, self)
	self._leftTabView:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.BroadcastCurVipLevel, self.updateUI, self)
	UIEffectManager.instance:stopEffect(self._bgEff)
	UIEffectManager.instance:stopEffect(self._levelEff)
end

function VipView:onExitFinished()
	VipView.super.onExitFinished(self)
end

function VipView:_onClickBtnReCharge()
	GlobalDispatcher:dispatch(GlobalNotify.ForceClosePayShopMainView)
	PayShopController.instance:openView(GameEnum.PayShopEasyJump.GodDiamond)
end

function VipView:_onClickBtnRecord()
	ViewMgr.instance:open(ViewName.RulesView, "vipRule")
end

function VipView:updateUI()
	local curExp = VipModel.instance:getCurVipExp()
	local curLv = VipModel.instance:getCurVipLv()
	local curExpMax = VipModel.instance:getCurVipLvExpMax()
	local isVipMax = VipModel.instance:getIsVipExpMax()

	self._txtLevel:SetText(tostring(curLv))
	self._sldProgress:SetValue(checknumber(curExp) / checknumber(curExpMax))

	self._txtProgress.text = curExp .. "/" .. curExpMax

	if isVipMax then
		self._txtChargeTip.text = lang("当前已达到最高VIP等级")
	else
		local str = string.format("再消费%s元可升级至<color=#D56D09FF>VIP%s</color>", curExpMax - curExp, curLv + 1)

		self._txtChargeTip.text = lang(str)
	end
end

function VipView:_updateLeftTabs(view, cell, data)
	if data then
		GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickLeftTab, self, data))

		local txt = goutil.findChildTextComponent(cell, "txt")
		local imgPoint = goutil.findChild(cell, "imgPoint")
		local changes = cell:GetComponent("UIChangeGroup")

		changes:SetState(data.id == self._curSelectId and 1 or 0)

		txt.text = lang(data.showTip)

		if data.id == 1 then
			RedPointController.instance:regRedPoint(imgPoint, RedPointModel.ID_VIP)
		else
			goutil.setActive(imgPoint, false)
		end
	end
end

function VipView:_clearLeftTabs(cell)
	GameUtil.rmClickHandler(cell)

	local imgPoint = goutil.findChild(cell, "imgPoint")

	RedPointController.instance:unregRedPoint(imgPoint, RedPointModel.ID_VIP)
end

function VipView:_onClickLeftTab(data)
	self._curSelectId = data.id

	self._leftTabView:reloadData(leftTabs)
	self:showTabAt(self._conView, data.view)
end

function VipView:_onClickBtnShowTip()
	if self._isPlayBubble then
		return
	end

	self._isPlayBubble = true

	removetimer(self._finishPlayBubble, self)
	goutil.setActive(self._showTip, true)
	settimer(2.5, self._finishPlayBubble, self, false)
end

function VipView:_finishPlayBubble()
	removetimer(self._finishPlayBubble, self)
	goutil.setActive(self._showTip, false)

	self._isPlayBubble = false
end

function VipView:_playEff(effPath, parent)
	if not parent then
		printInfo("Vip Parent Is Nil Gameobject")

		return
	end

	return (UIEffectManager.instance:playEffect(self, effPath, parent, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(parent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)

		eff.hideEffWhileNotOnTop = true
	end))
end

return VipView
