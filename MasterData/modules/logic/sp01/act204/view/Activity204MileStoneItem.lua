-- chunkname: @modules/logic/sp01/act204/view/Activity204MileStoneItem.lua

module("modules.logic.sp01.act204.view.Activity204MileStoneItem", package.seeall)

local Activity204MileStoneItem = class("Activity204MileStoneItem", ListScrollCellExtend)

function Activity204MileStoneItem:onInitView()
	self.transform = self.viewGO.transform
	self.txtValue = gohelper.findChildTextMesh(self.viewGO, "#image_status_hasget/txt_pointvalue")
	self.txtValue2 = gohelper.findChildTextMesh(self.viewGO, "#image_status_grey/txt_pointvalue")
	self.txtValue3 = gohelper.findChildTextMesh(self.viewGO, "#image_status_canget/txt_pointvalue")
	self.gohasget = gohelper.findChild(self.viewGO, "#image_status_hasget")
	self.gogrey = gohelper.findChild(self.viewGO, "#image_status_grey")
	self.gocanget = gohelper.findChild(self.viewGO, "#image_status_canget")
	self.rewardList = {}

	for i = 1, 2 do
		self:getOrCreateRewardItem(i)
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity204MileStoneItem:addEvents()
	return
end

function Activity204MileStoneItem:removeEvents()
	return
end

function Activity204MileStoneItem:_editableInitView()
	return
end

function Activity204MileStoneItem:onUpdateMO(mo)
	self._mo = mo

	if not mo then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	self.actMo = Activity204Model.instance:getById(self._mo.activityId)

	self:refreshValue()
	self:refreshReward()
end

function Activity204MileStoneItem:refreshValue()
	local isLoop = self._mo.isLoopBonus
	local status = self.actMo:getMilestoneRewardStatus(self._mo.rewardId)
	local cangetOrHasget = status == Activity204Enum.RewardStatus.Canget or status == Activity204Enum.RewardStatus.Hasget
	local pointValueStr = ""

	pointValueStr = isLoop and "∞" or self.actMo:getMilestoneValue(self._mo.rewardId)
	self.txtValue.text = pointValueStr
	self.txtValue2.text = pointValueStr
	self.txtValue3.text = pointValueStr

	gohelper.setActive(self.gogrey, not cangetOrHasget)
	gohelper.setActive(self.gocanget, status == Activity204Enum.RewardStatus.Canget)
	gohelper.setActive(self.gohasget, status == Activity204Enum.RewardStatus.Hasget)
end

function Activity204MileStoneItem:refreshReward()
	local rewards = GameUtil.splitString2(self._mo.bonus, true)
	local rewardCount = #rewards
	local status = self.actMo:getMilestoneRewardStatus(self._mo.rewardId)

	for i = 1, math.max(#rewards, #self.rewardList) do
		self:updateRewardItem(self:getOrCreateRewardItem(i), rewards[i], status)
	end

	self.itemWidth = rewardCount * 210 + (rewardCount - 1) * 10

	recthelper.setWidth(self.transform, self.itemWidth)
end

function Activity204MileStoneItem:getOrCreateRewardItem(index)
	local item = self.rewardList[index]

	if not item then
		local go = gohelper.findChild(self.viewGO, "#go_rewards/#go_reward" .. index)

		if not go then
			return
		end

		item = self:getUserDataTb_()
		item.go = go
		item.goIcon = gohelper.findChild(go, "go_icon")
		item.goCanget = gohelper.findChild(go, "go_canget")
		item.goReceive = gohelper.findChild(go, "go_receive")
		self.rewardList[index] = item
	end

	return item
end

function Activity204MileStoneItem:updateRewardItem(item, data, status)
	if not item then
		return
	end

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.goIcon)

	item.itemIcon:setMOValue(data[1], data[2], data[3], nil, true)
	item.itemIcon:setScale(0.63)
	item.itemIcon:setCountTxtSize(46)
	gohelper.setActive(item.goCanget, status == Activity204Enum.RewardStatus.Canget)
	gohelper.setActive(item.goReceive, status == Activity204Enum.RewardStatus.Hasget)

	local param = {
		actId = self._mo.activityId,
		status = status,
		itemCo = data
	}

	item.itemIcon:customOnClickCallback(Activity204MileStoneItem.onClickItemIcon, param)
end

function Activity204MileStoneItem.onClickItemIcon(param)
	local actId = param.actId

	if not ActivityModel.instance:isActOnLine(actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local status = param.status

	if status == Activity204Enum.RewardStatus.Canget then
		Activity204Rpc.instance:sendGetAct204MilestoneRewardRequest(actId)

		return
	end

	local itemCo = param.itemCo

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function Activity204MileStoneItem:getItemWidth()
	return self.itemWidth
end

function Activity204MileStoneItem:onDestroyView()
	return
end

return Activity204MileStoneItem
