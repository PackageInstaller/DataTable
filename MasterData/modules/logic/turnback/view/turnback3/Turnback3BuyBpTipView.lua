-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BuyBpTipView.lua

module("modules.logic.turnback.view.turnback3.Turnback3BuyBpTipView", package.seeall)

local Turnback3BuyBpTipView = class("Turnback3BuyBpTipView", BaseView)

function Turnback3BuyBpTipView:onInitView()
	self._btnclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/bg/#btn_closebtn")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_reward")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "root/#scroll_reward/viewport/content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/#scroll_reward/viewport/content/#go_rewarditem")
	self._gounlockbtn = gohelper.findChild(self.viewGO, "root/#go_unlockbtn")
	self._btnunlockbtn = gohelper.findChildButton(self.viewGO, "root/#go_unlockbtn")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/#go_unlockbtn/#simage_icon")
	self._txtprice = gohelper.findChildText(self.viewGO, "root/#go_unlockbtn/#txt_price")

	gohelper.setActive(self._gorewarditem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3BuyBpTipView:addEvents()
	self._btnclosebtn:AddClickListener(self.closeThis, self)
	self._btnunlockbtn:AddClickListener(self._btnunlockbtnOnClick, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, self.closeThis, self)
end

function Turnback3BuyBpTipView:removeEvents()
	self._btnclosebtn:RemoveClickListener()
	self._btnunlockbtn:RemoveClickListener()
end

function Turnback3BuyBpTipView:_btnunlockbtnOnClick()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRpc.instance:sendBuyDoubleBonusRequest(turnbackId)
end

function Turnback3BuyBpTipView:_editableInitView()
	return
end

function Turnback3BuyBpTipView:onUpdateParam()
	return
end

function Turnback3BuyBpTipView:onOpen()
	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self._config = TurnbackConfig.instance:getTurnbackCo(self._turnbackId)

	local rewardList = TurnbackModel.instance:getCurrenUnLockPayReward()
	local goRewardItem = gohelper.findChild(self._gorewardcontent, "#go_rewarditem")

	for index, co in ipairs(rewardList) do
		local item = self:getUserDataTb_()

		item.go = gohelper.clone(goRewardItem, self._gorewardcontent, "index" .. index)
		item.goIcon = gohelper.findChild(item.go, "itemicon")

		gohelper.setActive(item.go, true)

		local iconComp = IconMgr.instance:getCommonPropItemIcon(item.goIcon)

		iconComp:setMOValue(tonumber(co.type), tonumber(co.id), tonumber(co.num))
	end

	local temp = not string.nilorempty(self._config.buyDoubleBonusPrice) and string.splitToNumber(self._config.buyDoubleBonusPrice, "#")

	self._txtprice.text = temp and temp[3]
end

function Turnback3BuyBpTipView:onClose()
	return
end

function Turnback3BuyBpTipView:onDestroyView()
	return
end

return Turnback3BuyBpTipView
