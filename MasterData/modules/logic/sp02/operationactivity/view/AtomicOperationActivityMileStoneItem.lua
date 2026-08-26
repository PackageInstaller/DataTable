-- chunkname: @modules/logic/sp02/operationactivity/view/AtomicOperationActivityMileStoneItem.lua

module("modules.logic.sp02.operationactivity.view.AtomicOperationActivityMileStoneItem", package.seeall)

local AtomicOperationActivityMileStoneItem = class("AtomicOperationActivityMileStoneItem", ListScrollCellExtend)

function AtomicOperationActivityMileStoneItem:onInitView()
	self.transform = self.viewGO.transform
	self._gorewards = gohelper.findChild(self.viewGO, "#go_rewards")
	self._imagestatushasget = gohelper.findChildImage(self.viewGO, "#image_status_hasget")
	self._imagestatusgrey = gohelper.findChildImage(self.viewGO, "#image_status_grey")
	self._imagestatuscanget = gohelper.findChildImage(self.viewGO, "#image_status_canget")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicOperationActivityMileStoneItem:addEvents()
	return
end

function AtomicOperationActivityMileStoneItem:removeEvents()
	return
end

function AtomicOperationActivityMileStoneItem:_editableInitView()
	self.isOpen = false
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.canvasGroup = self.viewGO:GetComponent(gohelper.Type_CanvasGroup)
	self.txtValue = gohelper.findChildTextMesh(self.viewGO, "txt_pointvalue")
	self.rewardList = {}

	for i = 1, 2 do
		self:getOrCreateRewardItem(i)
	end
end

function AtomicOperationActivityMileStoneItem:_editableAddEvents()
	return
end

function AtomicOperationActivityMileStoneItem:_editableRemoveEvents()
	return
end

function AtomicOperationActivityMileStoneItem:getAnimator()
	return self.anim
end

function AtomicOperationActivityMileStoneItem:onUpdateMO(mo)
	self.isOpen = true
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

function AtomicOperationActivityMileStoneItem:refreshValue()
	local isLoop = self._mo.isLoopBonus
	local status = self.actMo:getMilestoneRewardStatus(self._mo.rewardId)
	local cangetOrHasget = status == Activity186Enum.RewardStatus.Canget or status == Activity186Enum.RewardStatus.Hasget

	if isLoop then
		self.txtValue.text = "∞"
	else
		local value = self.actMo:getMilestoneValue(self._mo.rewardId)

		self.txtValue.text = cangetOrHasget and string.format("<color=#FFEDAD>%s</color>", value) or value
	end

	gohelper.setActive(self._imagestatuscanget, status == Activity186Enum.RewardStatus.Canget)
	gohelper.setActive(self._imagestatushasget, status == Activity186Enum.RewardStatus.Hasget)
	gohelper.setActive(self._imagestatusgrey, status == Activity186Enum.RewardStatus.None)
end

function AtomicOperationActivityMileStoneItem:refreshReward()
	local rewards = GameUtil.splitString2(self._mo.bonus, true)
	local rewardCount = #rewards
	local status = self.actMo:getMilestoneRewardStatus(self._mo.rewardId)

	for i = 1, math.max(#rewards, #self.rewardList) do
		self:updateRewardItem(self:getOrCreateRewardItem(i), rewards[i], status)
	end

	self.itemWidth = rewardCount * 210 + (rewardCount - 1) * 10

	recthelper.setWidth(self.transform, self.itemWidth)

	if self.canvasGroup.alpha == 0 then
		self.canvasGroup.alpha = 1
	end
end

function AtomicOperationActivityMileStoneItem:getOrCreateRewardItem(index)
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
		item.goNum = gohelper.findChild(go, "#go_num")
		item.txtNum = gohelper.findChildTextMesh(go, "#go_num/#txt_num")
		item.golock = gohelper.findChild(go, "go_lock")
		self.rewardList[index] = item
	end

	return item
end

function AtomicOperationActivityMileStoneItem:updateRewardItem(item, data, status)
	if not item then
		return
	end

	if not data then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local itemCfg = ItemModel.instance:getItemConfigAndIcon(data[1], data[2])

	item.itemIcon = item.itemIcon or IconMgr.instance:getCommonPropItemIcon(item.goIcon)

	item.itemIcon:setMOValue(data[1], data[2], data[3])
	item.itemIcon:setScale(0.7)
	item.itemIcon:isShowQuality(true)
	item.itemIcon:isShowEquipAndItemCount(false)
	gohelper.setActive(item.goCanget, status == Activity186Enum.RewardStatus.Canget)
	gohelper.setActive(item.golock, status == Activity186Enum.RewardStatus.None)
	gohelper.setActive(item.goReceive, status == Activity186Enum.RewardStatus.Hasget)

	local param = {
		actId = self._mo.activityId,
		status = status,
		itemCo = data
	}

	item.itemIcon:customOnClickCallback(AtomicOperationActivityMileStoneItem.onClickItemIcon, param)

	local showCount = not AtomicOperationActivityEnum.HideNumItemDic[data[2]]

	gohelper.setActive(item.goNum, showCount)

	if showCount then
		item.txtNum.text = data[3]
	end
end

function AtomicOperationActivityMileStoneItem.onClickItemIcon(param)
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

function AtomicOperationActivityMileStoneItem:getItemWidth()
	return self.itemWidth
end

function AtomicOperationActivityMileStoneItem:onDestroyView()
	return
end

return AtomicOperationActivityMileStoneItem
