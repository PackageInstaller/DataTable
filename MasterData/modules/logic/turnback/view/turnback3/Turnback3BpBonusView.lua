-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3BpBonusView.lua

module("modules.logic.turnback.view.turnback3.Turnback3BpBonusView", package.seeall)

local Turnback3BpBonusView = class("Turnback3BpBonusView", BaseView)

function Turnback3BpBonusView:onInitView()
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "left/#simage_leftbg")
	self._simagefreeicon = gohelper.findChildSingleImage(self.viewGO, "left/free/#simage_freeicon")
	self._simagepayicon = gohelper.findChildSingleImage(self.viewGO, "left/pay/#simage_payicon")
	self._btnpay = gohelper.findChildButtonWithAudio(self.viewGO, "left/pay/#btn_pay")
	self._gobtnpaylock = gohelper.findChild(self.viewGO, "left/pay/#gomask/lock")
	self._simagescrollbg = gohelper.findChildSingleImage(self.viewGO, "#simage_scrollbg")
	self._scroll = gohelper.findChildScrollRect(self.viewGO, "#scroll")
	self._goscrollitem = gohelper.findChild(self.viewGO, "#scroll/item")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#keyBonus/#simage_rightbg")
	self._gokeyBonusItem = gohelper.findChild(self.viewGO, "#keyBonus")
	self._imgFill = gohelper.findChildImage(self.viewGO, "#scroll/progress/bg/#progress_fg")
	self._golevelLayout = gohelper.findChild(self.viewGO, "#scroll/progress/levellayout")
	self._golevelItem = gohelper.findChild(self.viewGO, "#scroll/progress/levellayout/#go_levelitem")
	self._bonusItemList = {}
	self._levelItemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3BpBonusView:addEvents()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrencyChange, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, self.succbuydoublereward, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function Turnback3BpBonusView:removeEvents()
	return
end

function Turnback3BpBonusView:onUpdateParam()
	return
end

function Turnback3BpBonusView:succbuydoublereward()
	self:_refreshUI()
end

function Turnback3BpBonusView:onOpen()
	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()

	self:_initBonusItemList()
	self:_initLevelItemList()
	self:_refreshFill()
	self:_refreshUI()
end

function Turnback3BpBonusView:_refreshUI()
	local hasDouble = TurnbackModel.instance:getBuyDoubleBonus()

	gohelper.setActive(self._gobtnpaylock, not hasDouble)
end

function Turnback3BpBonusView:_initBonusItemList()
	self._index = 1

	TaskDispatcher.runRepeat(self._cloneBonusItem, self, 0)
end

function Turnback3BpBonusView:_cloneBonusItem()
	local item = self._bonusItemList[self._index]

	item = item or self:_initBonusItem(self._index)
	self._index = self._index + 1

	if self._index > 7 then
		self:_initBonusItem(8, true)
		self:_cancelClone()
	end
end

function Turnback3BpBonusView:_cancelClone()
	TaskDispatcher.cancelTask(self._cloneBonusItem, self)
end

function Turnback3BpBonusView:_initBonusItem(index, isLast)
	local item = self:getUserDataTb_()
	local parent = gohelper.findChild(self.viewGO, "#scroll/content/pos" .. index)

	item.go = isLast and gohelper.findChild(self.viewGO, "pos8/item") or gohelper.clone(self._goscrollitem, parent, "index" .. index)

	gohelper.setActive(item.go, true)

	item.comp = MonoHelper.addNoUpdateLuaComOnceToGo(item.go, Turnback3BpBonusItem)

	table.insert(self._bonusItemList, item)

	local config = TurnbackConfig.instance:getTurnbackTaskBonusCo(self._turnbackId, index)

	item.config = config
	item.comp.parentView = self

	item.comp:_initItem(config, isLast)
	item.comp:checkPlayAnim()

	return item
end

function Turnback3BpBonusView:_initLevelItemList()
	for i = 1, 7 do
		local item = self._levelItemList[i]

		if not item then
			item = self:getUserDataTb_()

			local parent = gohelper.findChild(self.viewGO, "#scroll/progress/levellayout/pos" .. i)

			item.go = gohelper.clone(self._golevelItem, parent, "index" .. i)
			item.gonormalbg = gohelper.findChild(item.go, "#go_normalbg")
			item.gocurrentbg = gohelper.findChild(item.go, "#go_currentbg")
			item.txtlv = gohelper.findChildText(item.go, "#txt_lvtxt")

			gohelper.setActive(item.go, true)
			table.insert(self._levelItemList, item)
		end

		item.index = i

		local config = TurnbackConfig.instance:getTurnbackTaskBonusCo(self._turnbackId, i)

		item.config = config
		item.txtlv.text = config.needPoint

		self:_updateLevelItem(item)
	end
end

function Turnback3BpBonusView:_updateLevelItem(levelItem)
	local config = levelItem.config
	local curActiveCount = TurnbackModel.instance:getCurrentPointId(self._turnbackId)
	local canGet = curActiveCount >= config.needPoint

	gohelper.setActive(levelItem.gonormalbg, not canGet)
	gohelper.setActive(levelItem.gocurrentbg, canGet)
end

function Turnback3BpBonusView:onCurrencyChange()
	for index, item in ipairs(self._levelItemList) do
		self:_updateLevelItem(item)
	end

	self:_refreshFill()
end

function Turnback3BpBonusView:_refreshFill()
	self._imgFill.fillAmount = self:getSchedule()
end

function Turnback3BpBonusView:getSchedule()
	local firstFillAmount = 0.145
	local maxFillAmount = 1
	local rewardColist = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self._turnbackId)
	local rewardCount = #rewardColist
	local firstNum = rewardColist[1].needPoint
	local havenum = TurnbackModel.instance:getCurrentPointId(self._turnbackId)
	local currentIndex = 0
	local currentIndexNum = 0
	local nextIndexNum = 0

	for index, rewardco in ipairs(rewardColist) do
		local indexNum = rewardco.needPoint

		if indexNum <= havenum then
			currentIndex = index
			currentIndexNum = rewardco.needPoint
		else
			nextIndexNum = rewardco.needPoint

			break
		end
	end

	if havenum < firstNum then
		return havenum / firstNum * firstFillAmount
	end

	local per = (maxFillAmount - firstFillAmount) / (rewardCount - 1)
	local progress = (havenum - currentIndexNum) / (nextIndexNum - currentIndexNum)

	return currentIndex == rewardCount and 1 or currentIndex - 1 + progress <= 0 and havenum / firstNum * firstFillAmount or firstFillAmount + per * (currentIndex - 1 + progress)
end

function Turnback3BpBonusView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView and TurnbackModel.instance:getOpenPopTipView() then
		ViewMgr.instance:openView(ViewName.Turnback3BuyBpTipView)
		TurnbackModel.instance:setOpenPopTipView(false)
	end
end

function Turnback3BpBonusView:onClose()
	TaskDispatcher.cancelTask(self._cloneBonusItem, self)
end

function Turnback3BpBonusView:onDestroyView()
	TaskDispatcher.cancelTask(self._cloneBonusItem, self)
end

return Turnback3BpBonusView
