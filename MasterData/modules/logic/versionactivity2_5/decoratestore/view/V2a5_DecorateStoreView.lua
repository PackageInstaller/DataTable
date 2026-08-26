-- chunkname: @modules/logic/versionactivity2_5/decoratestore/view/V2a5_DecorateStoreView.lua

module("modules.logic.versionactivity2_5.decoratestore.view.V2a5_DecorateStoreView", package.seeall)

local V2a5_DecorateStoreView = class("V2a5_DecorateStoreView", BaseView)

function V2a5_DecorateStoreView:onInitView()
	self.btnShop = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Right/#btn_goto")
	self.txtLimitTime = gohelper.findChildTextMesh(self.viewGO, "Root/Right/#txt_LimitTime")
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.items = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a5_DecorateStoreView:addEvents()
	self.addClickCb(self, self.btnShop, self._btngotoOnClick, self)

	if self.btnClose then
		self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
	end

	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshView, self)
end

function V2a5_DecorateStoreView:removeEvents()
	return
end

function V2a5_DecorateStoreView:_editableInitView()
	return
end

function V2a5_DecorateStoreView:onClickBtnClose()
	self:closeThis()
end

function V2a5_DecorateStoreView:_btngotoOnClick()
	local jumpId = 10176

	if jumpId and jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end
end

function V2a5_DecorateStoreView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V2a5_DecorateStoreView:onOpen()
	if self.viewParam then
		if self.viewParam then
			gohelper.addChild(self.viewParam, self.viewGO)
		end

		self:refreshParam()
		self:refreshView()
	end
end

function V2a5_DecorateStoreView:refreshParam()
	self.actId = ActivityEnum.Activity.V2a5_DecorateStore
end

function V2a5_DecorateStoreView:refreshView()
	self:_showDeadline()
	self:refreshItems()
end

function V2a5_DecorateStoreView:refreshItems()
	local actCos = ActivityConfig.instance:getNorSignActivityCos(self.actId)

	for i, v in ipairs(actCos) do
		local item = self:getOrCreateItem(i)

		if item then
			self:updateItem(item, v)
		end
	end
end

function V2a5_DecorateStoreView:getOrCreateItem(index)
	local item = self.items[index]

	if not item then
		item = self:getUserDataTb_()

		local itemGO = gohelper.findChild(self.viewGO, string.format("Root/Right/Day/go_day%s", index))

		item.go = itemGO
		item.rewards = {}

		for i = 1, 3 do
			item.rewards[i] = self:createReward(itemGO, i)
		end

		item.goTomorrow = gohelper.findChild(itemGO, "#go_TomorrowTag")
		self.items[index] = item
	end

	return item
end

function V2a5_DecorateStoreView:updateItem(item, config)
	local index = config.id
	local rewardGet = ActivityType101Model.instance:isType101RewardGet(self.actId, index)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self.actId, index)
	local totalday = ActivityType101Model.instance:getType101LoginCount(self.actId)
	local rewards = GameUtil.splitString2(config.bonus, true)

	for i = 1, math.max(#item.rewards, #rewards) do
		local rewardItem = item.rewards[i]
		local rewardData = rewards[i]

		self:updateReward(rewardItem, rewardData, {
			actId = self.actId,
			index = index,
			rewardGet = rewardGet,
			couldGet = couldGet
		})
	end

	gohelper.setActive(item.goTomorrow, index == totalday + 1)
end

function V2a5_DecorateStoreView:createReward(itemGO, index)
	local reward = self:getUserDataTb_()

	reward.go = gohelper.findChild(itemGO, string.format("reward/#go_rewarditem%s", index))
	reward.iconGO = gohelper.findChild(reward.go, "go_icon")
	reward.goCanget = gohelper.findChild(reward.go, "go_canget")
	reward.goReceive = gohelper.findChild(reward.go, "go_receive")

	return reward
end

function V2a5_DecorateStoreView:updateReward(item, itemCo, param)
	if not item then
		return
	end

	gohelper.setActive(item.go, itemCo ~= nil)

	if not itemCo then
		return
	end

	gohelper.setActive(item.goCanget, param.couldGet)
	gohelper.setActive(item.goReceive, param.rewardGet)

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.iconGO)

	item.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3])
	item.itemIcon:setScale(0.7)
	item.itemIcon:setCountFontSize(46)
	item.itemIcon:setHideLvAndBreakFlag(true)
	item.itemIcon:hideEquipLvAndBreak(true)

	param.itemCo = itemCo

	item.itemIcon:customOnClickCallback(V2a5_DecorateStoreView.onClickItemIcon, param)
end

function V2a5_DecorateStoreView.onClickItemIcon(param)
	local actId = param.actId
	local index = param.index

	if not ActivityModel.instance:isActOnLine(actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

	if couldGet then
		Activity101Rpc.instance:sendGet101BonusRequest(actId, index)

		return
	end

	local itemCo = param.itemCo

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function V2a5_DecorateStoreView:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 60)
end

function V2a5_DecorateStoreView:_onRefreshDeadline()
	self.txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function V2a5_DecorateStoreView:onClose()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

function V2a5_DecorateStoreView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

return V2a5_DecorateStoreView
