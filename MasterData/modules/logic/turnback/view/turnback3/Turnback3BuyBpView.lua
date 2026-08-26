-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BuyBpView.lua

module("modules.logic.turnback.view.turnback3.Turnback3BuyBpView", package.seeall)

local Turnback3BuyBpView = class("Turnback3BuyBpView", BaseView)

function Turnback3BuyBpView:onInitView()
	self._btnclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/bg/#btn_closebtn")
	self._scrollreward1 = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_reward1")
	self._gocontent1 = gohelper.findChild(self.viewGO, "root/#scroll_reward1/viewport/content")
	self._scrollreward2 = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_reward2")
	self._gocontent2 = gohelper.findChild(self.viewGO, "root/#scroll_reward2/viewport/content")
	self._gounlockbtn = gohelper.findChild(self.viewGO, "root/#go_unlockbtn")
	self._btnunlockbtn = gohelper.findChildButton(self.viewGO, "root/#go_unlockbtn")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/#go_unlockbtn/#simage_icon")
	self._txtprice = gohelper.findChildText(self.viewGO, "root/#go_unlockbtn/#txt_price")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3BuyBpView:addEvents()
	self._btnclosebtn:AddClickListener(self._btnclosebtnOnClick, self)
	self._btnunlockbtn:AddClickListener(self._btnunlockbtnOnClick, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, self.succbuydoublereward, self)
end

function Turnback3BuyBpView:removeEvents()
	self._btnclosebtn:RemoveClickListener()
	self._btnunlockbtn:RemoveClickListener()
end

function Turnback3BuyBpView:_btnclosebtnOnClick()
	self:closeThis()
end

function Turnback3BuyBpView:_btnunlockbtnOnClick()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRpc.instance:sendBuyDoubleBonusRequest(turnbackId)
end

function Turnback3BuyBpView:_editableInitView()
	return
end

function Turnback3BuyBpView:onUpdateParam()
	return
end

function Turnback3BuyBpView:succbuydoublereward()
	self:closeThis()
end

function Turnback3BuyBpView:onOpen()
	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self._config = TurnbackConfig.instance:getTurnbackCo(self._turnbackId)

	local buyDoubleBonusPrice = not string.nilorempty(self._config.buyDoubleBonusPrice) and string.splitToNumber(self._config.buyDoubleBonusPrice, "#")
	local unlockRewardList = TurnbackModel.instance:getCurrenUnLockPayReward()
	local lockRewardList = TurnbackModel.instance:getCurrenLockAllReward()

	self:_initScroll(true, unlockRewardList)
	self:_initScroll(false, lockRewardList)

	self._txtprice.text = buyDoubleBonusPrice[3]
end

function Turnback3BuyBpView:_initScroll(isfree, rewardList)
	if isfree then
		if not self._gocontent1 then
			local parent = self._gocontent2
			local goRewardItem = gohelper.findChild(parent, "#go_rewarditem")

			for index, co in ipairs(rewardList) do
				local item = self:getUserDataTb_()

				item.go = gohelper.clone(goRewardItem, parent, "index" .. index)
				item.goIcon = gohelper.findChild(item.go, "itemicon")

				gohelper.setActive(item.go, true)

				local iconComp = IconMgr.instance:getCommonPropItemIcon(item.goIcon)

				iconComp:setMOValue(tonumber(co.type), tonumber(co.id), tonumber(co.num))
			end
		end
	end
end

function Turnback3BuyBpView:onClose()
	return
end

function Turnback3BuyBpView:onDestroyView()
	return
end

return Turnback3BuyBpView
