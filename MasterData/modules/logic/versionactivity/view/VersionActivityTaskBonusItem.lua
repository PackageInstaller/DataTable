-- chunkname: @modules/logic/versionactivity/view/VersionActivityTaskBonusItem.lua

module("modules.logic.versionactivity.view.VersionActivityTaskBonusItem", package.seeall)

local VersionActivityTaskBonusItem = class("VersionActivityTaskBonusItem", ListScrollCell)

function VersionActivityTaskBonusItem:init(go)
	self.viewGO = go
	self.txtIndex = gohelper.findChildText(self.viewGO, "index")
	self.imagePoint = gohelper.findChildImage(self.viewGO, "progress/point")
	self.scrollRewards = gohelper.findChildScrollRect(self.viewGO, "#scroll_rewards")
	self.goRewardRoot = gohelper.findChild(self.viewGO, "#scroll_rewards/Viewport/rewardsroot")
	self.goFinish = gohelper.findChild(self.viewGO, "go_finish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityTaskBonusItem:_editableInitView()
	self.pointItemList = {}
	self.rewardItems = {}
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self.imagePoint.gameObject, false)
	gohelper.setActive(self.goFinish, false)
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.AddTaskActivityBonus, self.addActivityPoints, self)
end

function VersionActivityTaskBonusItem:onUpdateMO(taskBonusCo)
	self.co = taskBonusCo

	self:show()

	self.txtIndex.text = string.format("%2d", self.co.id)
	self.taskActivityMo = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.ActivityDungeon)

	self:refreshPoints()
	self:refreshRewardItems()
end

function VersionActivityTaskBonusItem:refreshPoints()
	local pointItem
	local taskActivityMo = self.taskActivityMo
	local lightPointCount = 0

	gohelper.setActive(self.goFinish, false)

	if self.co.id <= taskActivityMo.defineId then
		lightPointCount = self.co.needActivity

		gohelper.setActive(self.goFinish, true)
	elseif self.co.id == taskActivityMo.defineId + 1 then
		lightPointCount = taskActivityMo.value - taskActivityMo.gainValue
	end

	for i = 1, self.co.needActivity do
		pointItem = self.pointItemList[i]

		if not self.pointItemList[i] then
			pointItem = self:getUserDataTb_()
			pointItem.go = gohelper.cloneInPlace(self.imagePoint.gameObject)
			pointItem.image = pointItem.go:GetComponent(gohelper.Type_Image)
			pointItem.playGo = gohelper.findChild(pointItem.go, "play")

			table.insert(self.pointItemList, pointItem)
		end

		gohelper.setActive(pointItem.go, true)
		gohelper.setActive(pointItem.playGo, false)
		UISpriteSetMgr.instance:setVersionActivitySprite(pointItem.image, i <= lightPointCount and "img_li1" or "img_li2")
	end

	for i = self.co.needActivity + 1, #self.pointItemList do
		gohelper.setActive(self.pointItemList[i].go, false)
	end
end

function VersionActivityTaskBonusItem:refreshRewardItems()
	local rewardItem, infos
	local rewards = string.split(self.co.bonus, "|")

	for i = 1, #rewards do
		rewardItem = self.rewardItems[i]
		infos = string.splitToNumber(rewards[i], "#")

		if not self.rewardItems[i] then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self.goRewardRoot)

			table.insert(self.rewardItems, rewardItem)
			transformhelper.setLocalScale(rewardItem.go.transform, 0.62, 0.62, 1)
			rewardItem:setMOValue(infos[1], infos[2], infos[3], nil, true)
			rewardItem:setCountFontSize(50)
			rewardItem:showStackableNum2()
			rewardItem:isShowEffect(true)
			rewardItem:setHideLvAndBreakFlag(true)
			rewardItem:hideEquipLvAndBreak(true)
		else
			rewardItem:setMOValue(infos[1], infos[2], infos[3], nil, true)
		end

		gohelper.setActive(rewardItem.go, true)
	end

	for i = #rewards + 1, #self.rewardItems do
		gohelper.setActive(self.rewardItems[i].go, false)
	end

	self.scrollRewards.horizontalNormalizedPosition = 0
end

function VersionActivityTaskBonusItem:addActivityPoints()
	if not VersionActivityTaskBonusListModel.instance:checkActivityPointCountHasChange() then
		return
	end

	for i = 1, #self.pointItemList do
		if VersionActivityTaskBonusListModel.instance:checkNeedPlayEffect(self.co.id, i) then
			local pointItem = self.pointItemList[i]

			gohelper.setActive(pointItem.playGo, true)
		end
	end
end

function VersionActivityTaskBonusItem:playAnimation(animationName, delayTime)
	self._animator:Play(animationName, 0, -delayTime)
end

function VersionActivityTaskBonusItem:getAnimator()
	return self._animator
end

function VersionActivityTaskBonusItem:show()
	gohelper.setActive(self.viewGO, true)
end

function VersionActivityTaskBonusItem:hide()
	gohelper.setActive(self.viewGO, false)
end

function VersionActivityTaskBonusItem:onDestroyView()
	return
end

return VersionActivityTaskBonusItem
