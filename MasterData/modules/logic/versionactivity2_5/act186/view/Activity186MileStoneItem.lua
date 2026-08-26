-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186MileStoneItem.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186MileStoneItem", package.seeall)

local Activity186MileStoneItem = class("Activity186MileStoneItem", ListScrollCellExtend)

function Activity186MileStoneItem:onInitView()
	self.transform = self.viewGO.transform
	self.txtValue = gohelper.findChildTextMesh(self.viewGO, "txt_pointvalue")
	self.goStatus = gohelper.findChild(self.viewGO, "#image_status")
	self.goStatusGrey = gohelper.findChild(self.viewGO, "#image_statusgrey")
	self.rewardList = {}

	for i = 1, 2 do
		self:getOrCreateRewardItem(i)
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186MileStoneItem:addEvents()
	return
end

function Activity186MileStoneItem:removeEvents()
	return
end

function Activity186MileStoneItem:_editableInitView()
	return
end

function Activity186MileStoneItem:onUpdateMO(mo)
	self._mo = mo

	if not mo then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self.actMo = Activity186Model.instance:getById(self._mo.activityId)

	self:refreshValue()
	self:refreshReward()
end

function Activity186MileStoneItem:refreshValue()
	local isLoop = self._mo.isLoopBonus
	local status = self.actMo:getMilestoneRewardStatus(self._mo.rewardId)
	local cangetOrHasget = status == Activity186Enum.RewardStatus.Canget or status == Activity186Enum.RewardStatus.Hasget

	if isLoop then
		self.txtValue.text = "∞"
	else
		local value = self.actMo:getMilestoneValue(self._mo.rewardId)

		self.txtValue.text = cangetOrHasget and string.format("<color=#BF5E26>%s</color>", value) or value
	end

	gohelper.setActive(self.goStatus, cangetOrHasget)
	gohelper.setActive(self.goStatusGrey, not cangetOrHasget)
end

function Activity186MileStoneItem:refreshReward()
	local rewards = GameUtil.splitString2(self._mo.bonus, true)
	local rewardCount = #rewards
	local status = self.actMo:getMilestoneRewardStatus(self._mo.rewardId)

	for i = 1, math.max(#rewards, #self.rewardList) do
		self:updateRewardItem(self:getOrCreateRewardItem(i), rewards[i], status)
	end

	self.itemWidth = rewardCount * 210 + (rewardCount - 1) * 10

	recthelper.setWidth(self.transform, self.itemWidth)
end

function Activity186MileStoneItem:getOrCreateRewardItem(index)
	local item = self.rewardList[index]

	if not item then
		local go = gohelper.findChild(self.viewGO, "#go_rewards/#go_reward" .. index)

		if not go then
			return
		end

		item = self:getUserDataTb_()
		item.go = go
		item.imgCircle = gohelper.findChildImage(go, "#image_circle")
		item.imgQuality = gohelper.findChildImage(go, "#image_quality")
		item.goIcon = gohelper.findChild(go, "go_icon")
		item.goCanget = gohelper.findChild(go, "go_canget")
		item.goReceive = gohelper.findChild(go, "go_receive")
		item.txtNum = gohelper.findChildTextMesh(go, "#txt_num")
		self.rewardList[index] = item
	end

	return item
end

function Activity186MileStoneItem:updateRewardItem(item, data, status)
	if not item then
		return
	end

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local itemCfg = ItemModel.instance:getItemConfigAndIcon(data[1], data[2])

	UISpriteSetMgr.instance:setUiFBSprite(item.imgQuality, "bg_pinjidi_" .. itemCfg.rare)
	UISpriteSetMgr.instance:setUiFBSprite(item.imgCircle, "bg_pinjidi_lanse_" .. itemCfg.rare)

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.goIcon)

	item.itemIcon:setMOValue(data[1], data[2], data[3])
	item.itemIcon:setScale(0.7)
	item.itemIcon:isShowQuality(false)
	item.itemIcon:isShowEquipAndItemCount(false)
	gohelper.setActive(item.goCanget, status == Activity186Enum.RewardStatus.Canget)
	gohelper.setActive(item.goReceive, status == Activity186Enum.RewardStatus.Hasget)

	local param = {
		actId = self._mo.activityId,
		status = status,
		itemCo = data
	}

	item.itemIcon:customOnClickCallback(Activity186MileStoneItem.onClickItemIcon, param)

	item.txtNum.text = data[2] == 171504 and "" or string.format("×%s", data[3])
end

function Activity186MileStoneItem.onClickItemIcon(param)
	local actId = param.actId

	if not ActivityModel.instance:isActOnLine(actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local status = param.status

	if status == Activity186Enum.RewardStatus.Canget then
		Activity186Rpc.instance:sendGetAct186MilestoneRewardRequest(actId)

		return
	end

	local itemCo = param.itemCo

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function Activity186MileStoneItem:getItemWidth()
	return self.itemWidth
end

function Activity186MileStoneItem:onDestroyView()
	return
end

return Activity186MileStoneItem
