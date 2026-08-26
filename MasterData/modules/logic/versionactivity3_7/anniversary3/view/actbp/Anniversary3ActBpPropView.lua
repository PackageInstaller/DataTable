-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/actbp/Anniversary3ActBpPropView.lua

module("modules.logic.versionactivity3_7.anniversary3.view.actbp.Anniversary3ActBpPropView", package.seeall)

local Anniversary3ActBpPropView = class("Anniversary3ActBpPropView", BaseView)

function Anniversary3ActBpPropView:onInitView()
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._txtlv = gohelper.findChildText(self.viewGO, "#go_title/level/#txt_lv")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_buy")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gogrid1 = gohelper.findChild(self.viewGO, "#go_grid1")
	self._scrollrewarditem1 = gohelper.findChildScrollRect(self.viewGO, "#go_grid1/#go_grid1/#scroll_rewarditem")
	self._goitemcontent1 = gohelper.findChild(self.viewGO, "#go_grid1/#scroll_rewarditem/viewport/#go_itemcontent")
	self._gorewarditem1 = gohelper.findChild(self.viewGO, "#go_grid1/#scroll_rewarditem/viewport/#go_itemcontent/#go_rewarditem")
	self._gogrid2 = gohelper.findChild(self.viewGO, "#go_grid2")
	self._scrollrewarditem2 = gohelper.findChildScrollRect(self.viewGO, "#go_grid2/#scroll_rewarditem")
	self._goitemcontent2 = gohelper.findChild(self.viewGO, "#go_grid2/#scroll_rewarditem/viewport/#go_itemcontent")
	self._gorewarditem2 = gohelper.findChild(self.viewGO, "#go_grid2/#scroll_rewarditem/viewport/#go_itemcontent/#go_rewarditem")
	self._scrollreminditem = gohelper.findChildScrollRect(self.viewGO, "#go_grid2/#scroll_reminditem")
	self._goremindcontent = gohelper.findChild(self.viewGO, "#go_grid2/#scroll_reminditem/Viewport/#go_remindcontent")
	self._goreminditem = gohelper.findChild(self.viewGO, "#go_grid2/#scroll_reminditem/Viewport/#go_remindcontent/#go_reminditem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Anniversary3ActBpPropView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Anniversary3ActBpPropView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function Anniversary3ActBpPropView:_btncloseOnClick()
	self:closeThis()
end

function Anniversary3ActBpPropView:_btnbuyOnClick()
	local bpCo = Activity233Config.instance:getBpCo(self._bpId)
	local itemCos = string.splitToNumber(bpCo.unlockPremiumCost, "#")

	if CurrencyController.instance:checkFreeDiamondEnough(itemCos[3], CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._buyGood, self, self.closeThis, self) then
		self:_buyGood()
	end
end

function Anniversary3ActBpPropView:_buyGood()
	Activity233Rpc.instance:sendAct233BpPayRequest(self._actId)
	self:closeThis()
end

function Anniversary3ActBpPropView:onClickModalMask()
	self:closeThis()
end

function Anniversary3ActBpPropView:_editableInitView()
	NavigateMgr.instance:addEscape(ViewName.Anniversary3ActBpPropView, self._btncloseOnClick, self)
end

function Anniversary3ActBpPropView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_zhenqi_win3_7)

	self._bpId = self.viewParam.bpId
	self._actId = self.viewParam.activityId
	self._topItems = self:getUserDataTb_()
	self._bottomItems = self:getUserDataTb_()

	self:_refreshUI()
	self:_refreshTopItems()
	self:_refreshBottomItems()
end

function Anniversary3ActBpPropView:_refreshUI()
	local hasPay = Anniversary3ActBpModel.instance:isPremiumPayed(self._bpId, self._actId)

	gohelper.setActive(self._btnbuy.gameObject, not hasPay)

	self._txtlv.text = Anniversary3ActBpModel.instance:getActBpLevel(self._bpId, self._actId)
end

function Anniversary3ActBpPropView:_refreshTopItems()
	local lv = Anniversary3ActBpModel.instance:getActBpLevel(self._bpId, self._actId)
	local maxLv = #Activity233Config.instance:getBonusCos(self._bpId)

	if maxLv <= lv then
		if not self._gorewarditem1 then
			local gorewarditem = self._gorewarditem2

			gohelper.setActive(self._gogrid2, lv < maxLv)
			gohelper.setActive(self._gogrid1, maxLv <= lv)

			local rewardTabs = {}

			for i = 1, lv do
				local bonusCo = Activity233Config.instance:getBonusCo(i, self._bpId)
				local itemCos = GameUtil.splitString2(bonusCo.payBonus, true)

				for j = 1, #itemCos do
					local tab = {}

					tab.materilType = itemCos[j][1]
					tab.materilId = itemCos[j][2]
					tab.quantity = itemCos[j][3]

					table.insert(rewardTabs, tab)
				end
			end

			table.sort(rewardTabs, Anniversary3ActBpModel.sortRewardsByRare)

			for i, reward in ipairs(rewardTabs) do
				if not self._topItems[i] then
					self._topItems[i] = {}
					self._topItems[i].go = gohelper.cloneInPlace(gorewarditem)
					self._topItems[i].goitem = gohelper.findChild(self._topItems[i].go, "go_item")
					self._topItems[i].item = IconMgr.instance:getCommonPropItemIcon(self._topItems[i].goitem)
				end

				gohelper.setActive(self._topItems[i].go, true)
				self._topItems[i].item:setMOValue(reward.materilType, reward.materilId, reward.quantity, nil, true)
				self._topItems[i].item:setCountFontSize(46)
				self._topItems[i].item:SetCountLocalY(43.6)
				self._topItems[i].item:SetCountBgHeight(40)
				self._topItems[i].item:SetCountBgScale(1, 1.3, 1)
				self._topItems[i].item:showStackableNum()
				self._topItems[i].item:setHideLvAndBreakFlag(true)
				self._topItems[i].item:hideEquipLvAndBreak(true)
				self._topItems[i].item:isShowCount(true)
			end
		end
	end
end

function Anniversary3ActBpPropView:_refreshBottomItems()
	local lv = Anniversary3ActBpModel.instance:getActBpLevel(self._bpId, self._actId)
	local maxLv = #Activity233Config.instance:getBonusCos(self._bpId)

	if maxLv <= lv then
		return
	end

	local rewardTabs = {}

	for i = lv + 1, maxLv do
		local bonusCo = Activity233Config.instance:getBonusCo(i, self._bpId)
		local itemCos = GameUtil.splitString2(bonusCo.payBonus, true)

		for j = 1, #itemCos do
			local tab = {}

			tab.materilType = itemCos[j][1]
			tab.materilId = itemCos[j][2]
			tab.quantity = itemCos[j][3]

			table.insert(rewardTabs, tab)
		end
	end

	table.sort(rewardTabs, Anniversary3ActBpModel.sortRewardsByRare)

	for i, reward in ipairs(rewardTabs) do
		if not self._bottomItems[i] then
			self._bottomItems[i] = {}
			self._bottomItems[i].go = gohelper.cloneInPlace(self._goreminditem)
			self._bottomItems[i].goitem = gohelper.findChild(self._bottomItems[i].go, "go_item")
			self._bottomItems[i].item = IconMgr.instance:getCommonPropItemIcon(self._bottomItems[i].goitem)
		end

		gohelper.setActive(self._bottomItems[i].go, true)
		self._bottomItems[i].item:setMOValue(reward.materilType, reward.materilId, reward.quantity, nil, true)
		self._bottomItems[i].item:setCountFontSize(46)
		self._bottomItems[i].item:SetCountLocalY(43.6)
		self._bottomItems[i].item:SetCountBgHeight(40)
		self._bottomItems[i].item:SetCountBgScale(1, 1.3, 1)
		self._bottomItems[i].item:showStackableNum()
		self._bottomItems[i].item:setHideLvAndBreakFlag(true)
		self._bottomItems[i].item:hideEquipLvAndBreak(true)
		self._bottomItems[i].item:isShowCount(true)
	end
end

function Anniversary3ActBpPropView:onClose()
	return
end

function Anniversary3ActBpPropView:onDestroyView()
	return
end

return Anniversary3ActBpPropView
