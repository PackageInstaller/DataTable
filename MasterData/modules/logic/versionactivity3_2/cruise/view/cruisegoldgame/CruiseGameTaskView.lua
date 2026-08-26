-- chunkname: @modules/logic/versionactivity3_2/cruise/view/cruisegoldgame/CruiseGameTaskView.lua

module("modules.logic.versionactivity3_2.cruise.view.cruisegoldgame.CruiseGameTaskView", package.seeall)

local CruiseGameTaskView = class("CruiseGameTaskView", BaseView)

function CruiseGameTaskView:onInitView()
	self.txt_num = gohelper.findChildTextMesh(self.viewGO, "root/topleft/numbg/#txt_num")
	self.txtprogress = gohelper.findChildTextMesh(self.viewGO, "root/bonusNode/milestone/progress/txtprogress")
	self.scrollItem = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward")
	self.rewardItem = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem")
	self.bubble = gohelper.findChild(self.viewGO, "root/bonusNode/bubble")
	self.bubbleReward = gohelper.findChild(self.viewGO, "root/bonusNode/bubble/goreward")
	self.go_normalline = gohelper.findChild(self.viewGO, "root/bonusNode/#scroll_reward/Viewport/#go_content/#go_normalline")

	local scrollRect = self.scrollItem:GetComponent(gohelper.Type_ScrollRect)
	local content = scrollRect.content
	local layoutGroup = content:GetComponent(gohelper.Type_HorizontalLayoutGroup)

	self.cellWidth = 220
	self.leftPadding = layoutGroup.padding.left
	self.listSpacing = layoutGroup.spacing
	self.scrollWidth = recthelper.getWidth(self.scrollItem.transform)

	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = CruiseGameTaskItem
	scrollParam.lineCount = 1
	scrollParam.cellSpaceH = self.listSpacing
	scrollParam.endSpace = 50

	local res = self.rewardItem

	self.simpleListComp = GameFacade.createSimpleListComp(self.scrollItem, scrollParam, res, self.viewContainer)

	self.simpleListComp:setOnValueChanged(self.onValueChangedCallBack, self)
	gohelper.setActive(self.bubble, false)
end

function CruiseGameTaskView:addEvents()
	self.addEventCb(self, Activity218Controller.instance, Activity218Event.OnReceiveAcceptRewardReply, self.onReceiveAcceptRewardReply, self)
end

function CruiseGameTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_2.play_ui_tujianskin_group_switch_1)

	self.maxCoin = Activity218Config.instance:getMaxCoin()
	self.totalCoinNum = Activity218Model.instance:getTotalCoinNum()
	self.txt_num.text = string.format("%s/%s", self.totalCoinNum, self.maxCoin)
	self.txtprogress.text = string.format("%s/%s", self.totalCoinNum, self.maxCoin)

	self:refreshList()
	self:refreshBubble()
	self.simpleListComp:moveTo(self.unLockMaxIndex)
end

function CruiseGameTaskView:onClose()
	return
end

function CruiseGameTaskView:onDestroyView()
	return
end

function CruiseGameTaskView:onReceiveAcceptRewardReply()
	self:refreshList()
end

function CruiseGameTaskView:onValueChangedCallBack(scrollX, scrollY)
	self:refreshBubble()
end

function CruiseGameTaskView:refreshBubble()
	local scrollPixel = self.simpleListComp:getScrollPixel()
	local bubbleShowIndex

	for i, cfg in ipairs(self.datas) do
		if cfg.isSpBonus then
			local cellOffset = self.leftPadding + (self.cellWidth + self.listSpacing) * i - self.listSpacing

			cellOffset = cellOffset - 0.75 * self.cellWidth

			if scrollPixel < cellOffset - self.scrollWidth then
				bubbleShowIndex = i

				break
			end
		end
	end

	if bubbleShowIndex == self.bubbleShowIndex then
		return
	end

	self.bubbleShowIndex = bubbleShowIndex

	gohelper.setActive(self.bubble, self.bubbleShowIndex ~= nil)

	self.bubbleItem = self.bubbleItem or IconMgr.instance:getCommonPropItemIcon(self.bubbleReward)

	if self.bubbleShowIndex then
		local cfg = self.datas[self.bubbleShowIndex]
		local bonus = Activity218Config.instance:getBonus(cfg.activityId, cfg.rewardId)[1]

		self.bubbleItem:onUpdateMO({
			materilType = bonus[1],
			materilId = bonus[2],
			quantity = bonus[3]
		})
		self.bubbleItem:setScale(0.6)
		self.bubbleItem:isShowEffect(true)
	end
end

function CruiseGameTaskView:refreshList()
	local cfgs = Activity218Config.instance:getBonusCfgs()

	self.datas = {}
	self.unLockMaxIndex = 0

	for i, cfg in ipairs(cfgs) do
		local isLock, isReceive, canGet = Activity218Model.instance:getRewardState(cfg.rewardId)

		table.insert(self.datas, {
			cfg = cfg,
			isLock = isLock,
			isReceive = isReceive,
			canGet = canGet
		})

		if not isLock then
			self.unLockMaxIndex = i
		end
	end

	self.simpleListComp:setData(self.datas)
	self.simpleListComp:setRefreshAnimation(true, 0.06, nil, 0.24)

	local nextLevel = self.unLockMaxIndex + 1

	if nextLevel > #self.datas then
		nextLevel = #self.datas
	end

	local cur = 0

	if self.unLockMaxIndex > 0 then
		cur = self.datas[self.unLockMaxIndex].cfg.coinNum
	end

	local next = self.datas[nextLevel].cfg.coinNum
	local offset1 = self.leftPadding + (self.cellWidth + self.listSpacing) * self.unLockMaxIndex - self.listSpacing - self.cellWidth / 2
	local offset2 = self.leftPadding + (self.cellWidth + self.listSpacing) * nextLevel - self.listSpacing - self.cellWidth / 2
	local offset = offset1 + (self.totalCoinNum - cur) / (next - cur) * (offset2 - offset1)

	recthelper.setWidth(self.go_normalline.transform, offset)
end

return CruiseGameTaskView
