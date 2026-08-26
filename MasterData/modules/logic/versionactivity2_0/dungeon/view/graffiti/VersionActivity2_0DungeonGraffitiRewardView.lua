-- chunkname: @modules/logic/versionactivity2_0/dungeon/view/graffiti/VersionActivity2_0DungeonGraffitiRewardView.lua

module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiRewardView", package.seeall)

local VersionActivity2_0DungeonGraffitiRewardView = class("VersionActivity2_0DungeonGraffitiRewardView", BaseView)

function VersionActivity2_0DungeonGraffitiRewardView:onInitView()
	self._gorewardwindow = gohelper.findChild(self.viewGO, "#go_rewardwindow")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rewardwindow/#btn_close")
	self._imageprogressBar = gohelper.findChildImage(self.viewGO, "#go_rewardwindow/Content/bg/#image_progressBar")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "#go_rewardwindow/Content/bg/#image_progressBar/#image_progress")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#go_rewardwindow/Content/#go_rewardContent")
	self._gorewardItem = gohelper.findChild(self.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_rewarditem")
	self._gofinalrewardItem = gohelper.findChild(self.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_finalrewarditem")
	self._gofinalreward = gohelper.findChild(self.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_finalrewarditem/#go_finalreward")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gorewardwindow)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_0DungeonGraffitiRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.GetGraffitiReward, self.refreshUI, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self.refreshUI, self)
	self.addEventCb(self, Activity161Controller.instance, Activity161Event.PlayGraffitiRewardGetAnim, self.playHasGetEffect, self)
end

function VersionActivity2_0DungeonGraffitiRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.GetGraffitiReward, self.refreshUI, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateMapElementState, self.refreshUI, self)
	self.removeEventCb(self, Activity161Controller.instance, Activity161Event.PlayGraffitiRewardGetAnim, self.playHasGetEffect, self)
end

function VersionActivity2_0DungeonGraffitiRewardView:_btncloseOnClick()
	self._animatorPlayer:Play(UIAnimationName.Close, self.onCloseAnimDone, self)
	gohelper.setActive(self._btnclose.gameObject, false)
end

function VersionActivity2_0DungeonGraffitiRewardView:onCloseAnimDone()
	gohelper.setActive(self._gorewardwindow, false)
end

function VersionActivity2_0DungeonGraffitiRewardView:_editableInitView()
	gohelper.setActive(self._gorewardwindow, false)
	gohelper.setActive(self._gorewardItem, false)

	self.rewardItemTab = self:getUserDataTb_()
	self.stageRewardItems = self:getUserDataTb_()
	self.finalItemTab = self:getUserDataTb_()
end

function VersionActivity2_0DungeonGraffitiRewardView:onOpen()
	self.actId = self.viewParam.actId
	self.allRewardConfig = Activity161Config.instance:getAllRewardCos(self.actId)
	self.finalRewardList, self.finalRewardInfo = Activity161Config.instance:getFinalReward(self.actId)
	self.lastHasGetRewardMap = tabletool.copy(Activity161Model.instance.curHasGetRewardMap)

	self:createRewardItem()
	self:createFinalRewardItem()
	self:refreshUI()
end

function VersionActivity2_0DungeonGraffitiRewardView:refreshUI()
	self:refreshItemState()
	self:refreshProgress()
end

function VersionActivity2_0DungeonGraffitiRewardView:createRewardItem()
	self.rewardsConfig = tabletool.copy(self.allRewardConfig)
	self.rewardCount = GameUtil.getTabLen(self.rewardsConfig)
	self.lastStageRewardConfig = table.remove(self.rewardsConfig, #self.rewardsConfig)

	for index, config in pairs(self.rewardsConfig) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				go = gohelper.clone(self._gorewardItem, self._gorewardContent, "rewardItem" .. index),
				config = config
			}
			rewardItem = self:initWholeRewardItemComp(rewardItem, rewardItem.go)
			self.rewardItemTab[index] = rewardItem
		end

		self:initRewardItemData(rewardItem, config, index)
	end

	local finalItem = self.rewardItemTab[self.rewardCount]

	if not finalItem then
		finalItem = {
			go = self._gofinalrewardItem,
			config = self.lastStageRewardConfig
		}
		finalItem = self:initWholeRewardItemComp(finalItem, finalItem.go)
		self.rewardItemTab[self.rewardCount] = finalItem
	end

	gohelper.setAsLastSibling(finalItem.go)
	self:initRewardItemData(finalItem, self.lastStageRewardConfig, self.rewardCount)
end

function VersionActivity2_0DungeonGraffitiRewardView:initWholeRewardItemComp(rewardItem, itemGO)
	rewardItem.txtpaintedNum = gohelper.findChildTextMesh(itemGO, "txt_paintedNum")
	rewardItem.godarkPoint = gohelper.findChild(itemGO, "darkpoint")
	rewardItem.golightPoint = gohelper.findChild(itemGO, "lightpoint")
	rewardItem.goreward = gohelper.findChild(itemGO, "layout/go_reward")

	gohelper.setActive(rewardItem.goreward, false)

	return rewardItem
end

function VersionActivity2_0DungeonGraffitiRewardView:initRewardItemData(rewardItem, config, index)
	gohelper.setActive(rewardItem.go, true)

	rewardItem.txtpaintedNum.text = config.paintedNum

	local stageRewardList = {}

	stageRewardList = index == self.rewardCount and self.finalRewardList or GameUtil.splitString2(config.bonus, true)

	local rewardItems = self.stageRewardItems[index]

	if not rewardItems then
		rewardItems = {}

		for itemIndex, rewardInfo in ipairs(stageRewardList) do
			local itemTab = {}

			itemTab.itemGO = gohelper.cloneInPlace(rewardItem.goreward, "item" .. tostring(itemIndex))
			itemTab = self:initRewardItemComp(itemTab, itemTab.itemGO, rewardInfo)

			gohelper.setActive(itemTab.itemGO, true)
			self:initItemIconInfo(itemTab, rewardInfo)

			rewardItems[itemIndex] = itemTab
		end

		self.stageRewardItems[index] = rewardItems
	end
end

function VersionActivity2_0DungeonGraffitiRewardView:createFinalRewardItem()
	if GameUtil.getTabLen(self.finalItemTab) == 0 then
		self:initRewardItemComp(self.finalItemTab, self._gofinalreward, self.finalRewardInfo, true)
	end

	self:initItemIconInfo(self.finalItemTab, self.finalRewardInfo)
end

function VersionActivity2_0DungeonGraffitiRewardView:initRewardItemComp(itemTab, itemGO, rewardInfo, isFinalReward)
	itemTab.itemGO = itemGO
	itemTab.itemRare = gohelper.findChildImage(itemTab.itemGO, "item/image_rare")
	itemTab.itemIcon = gohelper.findChildSingleImage(itemTab.itemGO, "item/simage_icon")
	itemTab.itemNum = gohelper.findChildText(itemTab.itemGO, "item/txt_num")
	itemTab.goHasGet = gohelper.findChild(itemTab.itemGO, "go_hasget")
	itemTab.goCanGet = gohelper.findChild(itemTab.itemGO, "go_canget")
	itemTab.goLock = gohelper.findChild(itemTab.itemGO, "go_lock")
	itemTab.hasGetAnim = itemTab.goHasGet:GetComponent(gohelper.Type_Animator)
	itemTab.btnClick = gohelper.findChildButtonWithAudio(itemTab.itemGO, "item/btn_click")

	itemTab.btnClick:AddClickListener(self.rewardItemClick, self, rewardInfo)

	itemTab.isFinalReward = isFinalReward

	return itemTab
end

function VersionActivity2_0DungeonGraffitiRewardView:initItemIconInfo(itemTab, rewardInfo)
	local itemConfig, icon = ItemModel.instance:getItemConfigAndIcon(rewardInfo[1], rewardInfo[2], true)

	itemTab.itemIcon:LoadImage(icon)

	if itemConfig.rare == 0 then
		gohelper.setActive(itemTab.itemRare.gameObject, false)
	elseif itemConfig.rare < 5 and not itemTab.isFinalReward then
		UISpriteSetMgr.instance:setV2a0PaintSprite(itemTab.itemRare, "v2a0_paint_rewardbg_" .. itemConfig.rare)
	end

	itemTab.itemNum.text = luaLang("multiple") .. rewardInfo[3]
end

function VersionActivity2_0DungeonGraffitiRewardView:rewardItemClick(rewardInfo)
	MaterialTipController.instance:showMaterialInfo(rewardInfo[1], rewardInfo[2])
end

function VersionActivity2_0DungeonGraffitiRewardView:refreshItemState()
	self.curHasGetRewardMap = Activity161Model.instance.curHasGetRewardMap

	local curPaintedNum = Activity161Model.instance:getCurPaintedNum()

	for index, wholeRewardItem in pairs(self.rewardItemTab) do
		local paintedNum = wholeRewardItem.config.paintedNum

		gohelper.setActive(wholeRewardItem.godarkPoint, curPaintedNum < paintedNum)
		gohelper.setActive(wholeRewardItem.golightPoint, paintedNum <= curPaintedNum)
		SLFramework.UGUI.GuiHelper.SetColor(wholeRewardItem.txtpaintedNum, paintedNum <= curPaintedNum and "#E9842A" or "#666767")
	end

	for index, rewardItems in pairs(self.stageRewardItems) do
		local paintedNum = self.rewardItemTab[index].config.paintedNum

		for _, itemTab in pairs(rewardItems) do
			gohelper.setActive(itemTab.goHasGet, self.curHasGetRewardMap[index])
			gohelper.setActive(itemTab.goCanGet, not self.curHasGetRewardMap[index] and paintedNum <= curPaintedNum)
			gohelper.setActive(itemTab.goLock, not self.curHasGetRewardMap[index] and curPaintedNum < paintedNum)
		end
	end

	gohelper.setActive(self.finalItemTab.goHasGet, self.curHasGetRewardMap[self.rewardCount])
	gohelper.setActive(self.finalItemTab.goCanGet, not self.curHasGetRewardMap[self.rewardCount] and curPaintedNum >= self.lastStageRewardConfig.paintedNum)
	gohelper.setActive(self.finalItemTab.goLock, not self.curHasGetRewardMap[self.rewardCount] and curPaintedNum < self.lastStageRewardConfig.paintedNum)
end

function VersionActivity2_0DungeonGraffitiRewardView:playHasGetEffect(canGetRewardList)
	for _, canGetRewardCo in pairs(canGetRewardList) do
		local rewardItems = self.stageRewardItems[canGetRewardCo.rewardId]

		for _, itemTab in pairs(rewardItems) do
			gohelper.setActive(itemTab.goHasGet, true)
			gohelper.setActive(itemTab.goCanGet, false)
			itemTab.hasGetAnim:Play("go_hasget_in", 0, 0)
		end

		if canGetRewardCo.rewardId == self.rewardCount then
			gohelper.setActive(self.finalItemTab.goHasGet, true)
			gohelper.setActive(self.finalItemTab.goCanGet, false)
			self.finalItemTab.hasGetAnim:Play("go_hasget_in", 0, 0)
		end
	end

	TaskDispatcher.runDelay(self.rewardCanGetClick, self, 1)
end

function VersionActivity2_0DungeonGraffitiRewardView:rewardCanGetClick()
	Activity161Rpc.instance:sendAct161GainMilestoneRewardRequest(self.actId)
	UIBlockMgr.instance:endBlock("GraffitiRewardViewPlayHasGetEffect")
end

function VersionActivity2_0DungeonGraffitiRewardView:refreshProgress()
	local firstWidth = 66
	local normalWidth = 177
	local lastWidth = 278
	local tagWidth = 24
	local totalWidth = firstWidth + normalWidth * Mathf.Max(0, self.rewardCount - 2) + tagWidth * self.rewardCount + lastWidth

	recthelper.setWidth(self._imageprogressBar.transform, totalWidth)

	local progressWith = 0
	local curPaintedNum = Activity161Model.instance:getCurPaintedNum()
	local curIndex = 0
	local curIndexValue = 0
	local nextIndexValue = 0
	local offsetValue = 0

	for index, config in pairs(self.allRewardConfig) do
		if curPaintedNum >= config.paintedNum then
			curIndex = index
			curIndexValue = config.paintedNum
			nextIndexValue = config.paintedNum
		elseif curIndexValue <= nextIndexValue then
			nextIndexValue = config.paintedNum

			break
		end
	end

	if nextIndexValue ~= curIndexValue then
		offsetValue = (curPaintedNum - curIndexValue) / (nextIndexValue - curIndexValue)
	end

	if curIndex == 0 then
		progressWith = firstWidth * curPaintedNum / nextIndexValue
	elseif curIndex >= 1 and curIndex < self.rewardCount - 1 then
		progressWith = firstWidth + normalWidth * (curIndex - 1) + curIndex * tagWidth + offsetValue * normalWidth
	elseif curIndex == self.rewardCount - 1 then
		progressWith = firstWidth + normalWidth * (curIndex - 1) + curIndex * tagWidth + offsetValue * lastWidth
	elseif curIndex == self.rewardCount then
		progressWith = totalWidth
	end

	recthelper.setWidth(self._imageprogress.transform, progressWith)
end

function VersionActivity2_0DungeonGraffitiRewardView:onClose()
	TaskDispatcher.cancelTask(self.rewardCanGetClick, self)
	UIBlockMgr.instance:endBlock("GraffitiRewardViewPlayHasGetEffect")
end

function VersionActivity2_0DungeonGraffitiRewardView:onDestroyView()
	for index, rewardItems in pairs(self.stageRewardItems) do
		for itemIndex, itemTab in pairs(rewardItems) do
			itemTab.btnClick:RemoveClickListener()
			itemTab.itemIcon:UnLoadImage()
		end
	end

	self.finalItemTab.btnClick:RemoveClickListener()
	self.finalItemTab.itemIcon:UnLoadImage()
end

return VersionActivity2_0DungeonGraffitiRewardView
