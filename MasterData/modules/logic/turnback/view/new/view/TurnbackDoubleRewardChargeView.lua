-- chunkname: @modules/logic/turnback/view/new/view/TurnbackDoubleRewardChargeView.lua

module("modules.logic.turnback.view.new.view.TurnbackDoubleRewardChargeView", package.seeall)

local TurnbackDoubleRewardChargeView = class("TurnbackDoubleRewardChargeView", BaseView)

function TurnbackDoubleRewardChargeView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnbgclose = gohelper.findChildButtonWithAudio(self.viewGO, "close")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "content/#btn_buy")
	self._txtcost = gohelper.findChildText(self.viewGO, "content/#btn_buy/#txt_cost")
	self._golockreward = gohelper.findChild(self.viewGO, "content/lockreward/reward")
	self._gounlockreward1 = gohelper.findChild(self.viewGO, "content/unlockreward/reward1")
	self._gounlockreward2 = gohelper.findChild(self.viewGO, "content/unlockreward/reward2")
	self._contentanim = gohelper.findChild(self.viewGO, "content"):GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackDoubleRewardChargeView:addEvents()
	self._btnclose:AddClickListener(self._btnclsoeOnClick, self)
	self._btnbgclose:AddClickListener(self._btnclsoeOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, self.succbuydoublereward, self)
end

function TurnbackDoubleRewardChargeView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnbgclose:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, self.succbuydoublereward, self)
end

function TurnbackDoubleRewardChargeView:_btnbuyOnClick()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRpc.instance:sendBuyDoubleBonusRequest(turnbackId)
end

function TurnbackDoubleRewardChargeView:succbuydoublereward()
	self._contentanim:Play("unlock")
	TaskDispatcher.runDelay(self.afterAnim, self, 0.8)
end

function TurnbackDoubleRewardChargeView:afterAnim()
	self:closeThis()
end

function TurnbackDoubleRewardChargeView:_btnclsoeOnClick()
	self:closeThis()
end

function TurnbackDoubleRewardChargeView:_editableInitView()
	self.rewardList = {}

	self:getRewardIcon(self._golockreward)
	self:getRewardIcon(self._gounlockreward1)
	self:getRewardIcon(self._gounlockreward2)
end

function TurnbackDoubleRewardChargeView:getRewardIcon(contentgo)
	local list = {}

	for i = 1, 4 do
		local icon = gohelper.findChild(contentgo, "icon" .. i)

		table.insert(list, icon)
	end

	table.insert(self.rewardList, list)
end

function TurnbackDoubleRewardChargeView:onUpdateParam()
	return
end

function TurnbackDoubleRewardChargeView:onOpen()
	local rewardList = TurnbackModel.instance:getAllBonus()

	for _, iconList in ipairs(self.rewardList) do
		for index, rewardco in ipairs(rewardList) do
			local rewardItem = self:getUserDataTb_()

			rewardItem.itemIcon = rewardItem.itemIcon or IconMgr.instance:getCommonPropItemIcon(iconList[index])

			rewardItem.itemIcon:setMOValue(rewardco[1], rewardco[2], rewardco[3], nil, true)
			rewardItem.itemIcon:setCountFontSize(30)
		end
	end
end

function TurnbackDoubleRewardChargeView:onClose()
	return
end

function TurnbackDoubleRewardChargeView:onDestroyView()
	return
end

return TurnbackDoubleRewardChargeView
