-- chunkname: @modules/logic/fight/view/FightViewRedAndBlueArea.lua

module("modules.logic.fight.view.FightViewRedAndBlueArea", package.seeall)

local FightViewRedAndBlueArea = class("FightViewRedAndBlueArea", BaseView)

FightViewRedAndBlueArea.LoadStatus = {
	Loaded = 3,
	Loading = 2,
	None = 1
}
FightViewRedAndBlueArea.PointIndexList = {
	{},
	{
		3
	},
	{
		2,
		3
	},
	{
		2,
		3,
		4
	},
	{
		1,
		2,
		3,
		4
	},
	{
		1,
		2,
		3,
		4,
		5
	},
	{
		1,
		2,
		3,
		4,
		5,
		6
	}
}

function FightViewRedAndBlueArea:onInitView()
	self._scrollViewObj = gohelper.findChild(self.viewGO, "root/playcards/#scroll_cards")
	self._rectTrScrollView = self._scrollViewObj:GetComponent(gohelper.Type_RectTransform)
	self._playCardItemRoot = gohelper.findChild(self.viewGO, "root/playcards/#scroll_cards/Viewport/Content")
	self._playCardItemTransform = self._playCardItemRoot:GetComponent(gohelper.Type_RectTransform)
	self.LY_cardLoadStatus = FightViewRedAndBlueArea.LoadStatus.None
	self._goLyCardContainer = gohelper.findChild(self.viewGO, "root/playcards/#go_LYcard")
	self._rectTrLyCardContainer = self._goLyCardContainer:GetComponent(gohelper.Type_RectTransform)
	self.LY_cardLoadStatus = FightViewRedAndBlueArea.LoadStatus.None

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightViewRedAndBlueArea:addEvents()
	return
end

function FightViewRedAndBlueArea:removeEvents()
	return
end

function FightViewRedAndBlueArea:_editableInitView()
	self.addEventCb(self, FightController.instance, FightEvent.LY_HadRedAndBluePointChange, self.onLY_HadRedAndBluePointChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.LY_PointAreaSizeChange, self.refreshLYCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.SetBlockCardOperate, self.refreshLYCard, self, LuaEventSystem.Low)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayCardFlowDone, self.refreshLYCard, self, LuaEventSystem.Low)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayAssistBossCardFlowDone, self.refreshLYCard, self, LuaEventSystem.Low)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self, LuaEventSystem.Low)
	self.addEventCb(self, FightController.instance, FightEvent.OnRoundSequenceFinish, self.refreshLYCard, self, LuaEventSystem.Low)
end

function FightViewRedAndBlueArea:onStageChange()
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage == FightStageMgr.StageType.Operate then
		FightDataHelper.LYDataMgr:refreshPointList(true)

		return self:refreshLYCard()
	end
end

function FightViewRedAndBlueArea:onLY_HadRedAndBluePointChange()
	if self.LY_cardLoadStatus == FightViewRedAndBlueArea.LoadStatus.Loading then
		return
	end

	if self.LY_cardLoadStatus == FightViewRedAndBlueArea.LoadStatus.Loaded then
		return self:refreshLYCard()
	end

	self.LY_cardLoadStatus = FightViewRedAndBlueArea.LoadStatus.Loading
	self.LYLoader = PrefabInstantiate.Create(self._goLyCardContainer)

	self.LYLoader:startLoad(FightLYWaitAreaCard.getResPath(), self.onLoadLYCardDone, self)
end

function FightViewRedAndBlueArea:onLoadLYCardDone(loader)
	self.LY_cardLoadStatus = FightViewRedAndBlueArea.LoadStatus.Loaded

	local instanceGo = self.LYLoader:getInstGO()

	self.LY_instanceGo = instanceGo
	self.LY_goCardBack = gohelper.findChild(instanceGo, "current/back")

	gohelper.setActive(self.LY_goCardBack, false)

	self.LY_pointItemList = {}

	for i = 1, FightLYWaitAreaCard.LY_MAXPoint do
		local pointItem = self:getUserDataTb_()

		pointItem.go = gohelper.findChild(instanceGo, "current/font/energy/" .. i)
		pointItem.goRed = gohelper.findChild(pointItem.go, "red")
		pointItem.goBlue = gohelper.findChild(pointItem.go, "green")
		pointItem.goBoth = gohelper.findChild(pointItem.go, "both")
		pointItem.animator = pointItem.go:GetComponent(gohelper.Type_Animator)

		table.insert(self.LY_pointItemList, pointItem)
	end

	self:refreshLYCard()
end

function FightViewRedAndBlueArea:refreshLYCard()
	if self.LY_cardLoadStatus ~= FightViewRedAndBlueArea.LoadStatus.Loaded then
		gohelper.setActive(self._goLyCardContainer, false)

		return
	end

	local serverPointList = FightDataHelper.LYDataMgr:getPointList()

	if not serverPointList then
		gohelper.setActive(self._goLyCardContainer, false)

		return
	end

	gohelper.setActive(self._goLyCardContainer, true)

	local serverPointLen = #serverPointList
	local areaSize = FightDataHelper.LYDataMgr.LYPointAreaSize

	self:getOpRedOrBlueList(FightDataHelper.operationDataMgr:getOpList())
	self:resetAllPoint()

	areaSize = math.min(math.max(0, areaSize), FightLYWaitAreaCard.LY_MAXPoint)

	if not FightViewRedAndBlueArea.PointIndexList[areaSize + 1] then
		local pointIndexList = {}

		for i = 1, areaSize do
			local index = pointIndexList[i]
			local pointItem = index and self.LY_pointItemList[index]

			if pointItem then
				gohelper.setActive(pointItem.go, true)

				local color

				if i <= serverPointLen then
					color = serverPointList[i]

					pointItem.animator:Play("empty", 0, 0)
				else
					color = self.tempPointList[i - serverPointLen]

					if self.tempPointList[i - serverPointLen] and color ~= FightEnum.CardColor.None then
						pointItem.animator:Play("loop", 0, 0)
					else
						pointItem.animator:Play("empty", 0, 0)
					end
				end

				gohelper.setActive(pointItem.goRed, color == FightEnum.CardColor.Red)
				gohelper.setActive(pointItem.goBlue, color == FightEnum.CardColor.Blue)
				gohelper.setActive(pointItem.goBoth, color == FightEnum.CardColor.Both)
			end
		end

		self:refreshLYContainerAnchorX()
	end
end

function FightViewRedAndBlueArea:resetAllPoint()
	for i = 1, FightLYWaitAreaCard.LY_MAXPoint do
		local pointItem = self.LY_pointItemList[i]

		gohelper.setActive(pointItem.go, false)
	end
end

FightViewRedAndBlueArea.AddRedOrBlueBehaviorId = 60154

function FightViewRedAndBlueArea:getOpRedOrBlueList(opList)
	self.tempPointList = self.tempPointList or {}

	tabletool.clear(self.tempPointList)

	for _, cardOp in ipairs(opList) do
		local cardInfo = cardOp and cardOp.cardInfoMO
		local skillId = cardInfo and cardInfo.skillId
		local skillCo = skillId and lua_skill.configDict[skillId]

		if skillCo then
			for i = 1, FightEnum.MaxBehavior do
				local behavior = skillCo["behavior" .. i]

				if not string.nilorempty(behavior) then
					local list = FightStrUtil.instance:getSplitToNumberCache(behavior, "#")

					if list and list[1] == FightViewRedAndBlueArea.AddRedOrBlueBehaviorId then
						local point = list[2]
						local count = list[3]

						for _ = 1, count do
							table.insert(self.tempPointList, point)
						end
					end
				end
			end
		end

		if cardOp and cardOp.cardColor ~= FightEnum.CardColor.None and not FightHelper.checkIsDevicePowerCard(skillId) then
			table.insert(self.tempPointList, cardOp.cardColor)
		end
	end

	return self.tempPointList
end

function FightViewRedAndBlueArea:refreshLYContainerAnchorX()
	if self.LY_cardLoadStatus ~= FightViewRedAndBlueArea.LoadStatus.Loaded then
		return
	end

	local contentWidth = recthelper.getWidth(self._playCardItemTransform)
	local maxContentWidth = recthelper.getWidth(self._rectTrScrollView)

	contentWidth = math.min(contentWidth, maxContentWidth)

	local halfWidth = contentWidth / 2
	local cardSkin = FightCardDataHelper.getCardSkin()
	local offset = FightEnum.SkiId2LYPlayCardAreaOffsetDict[cardSkin]

	offset = offset or FightEnum.SkiId2LYPlayCardAreaOffsetDict[0]

	recthelper.setAnchorX(self._rectTrLyCardContainer, halfWidth + offset)
end

function FightViewRedAndBlueArea:onUpdateParam()
	return
end

function FightViewRedAndBlueArea:onDestroyView()
	if self.LYLoader then
		self.LYLoader:dispose()

		self.LYLoader = nil

		gohelper.destroy(self.LY_instanceGo)
	end

	self.LY_cardLoadStatus = FightViewRedAndBlueArea.LoadStatus.None
end

return FightViewRedAndBlueArea
