-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveCutlineView.lua

module("logic.extensions.retrieve.view.RetrieveCutlineView", package.seeall)

local M = class("RetrieveCutlineView", ViewComponent)
local txtLayoutUpHeight = 37
local txtLayoutCommonHeight = 62
local txtLayoutLineHeight = 22
local eachCountPerLine = 5
local upCellHeight = 163
local commonCellHeight = 163
local cellSpace = 0
local heroRewardHeight = 420
local echoRewardHeight = 254

function M:buildUI()
	self._btnClose = self:getBtn("1&middle_tips_common_bg_-1205189576")
	self._btnBg = self:getBtn("1&middle_tips_common_bg_-1572128605")
	self._desc = self:getUIComponent("retrieve_preview_tips_622873837", UIComponentType.TextMeshProUGUI)
	self._scrollGo = self:getGo("retrieve_preview_tips_-1348249960")
	self._irregularLoopScroll = Astral.IrregularLoop.Get(self._scrollGo)

	self._irregularLoopScroll:Init(Astral.ScrollDir.Vertical, {}, self._onCellUpdate, self)
end

function M:destroyUI()
	self._btnClose = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBg:AddClickListener(self._onClickClose, self)
	GlobalDispatcher:addEventListener(EventType.GET_GUIDE_TEXT, self.refreshView, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBg:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.GET_GUIDE_TEXT, self.refreshView, self)
end

function M:_bindEvents()
	return
end

function M:_unbindEvents()
	return
end

function M:onEnter()
	local isBackOpen = self._viewPresentor:getIsBackOpen()

	self._viewPresentor:getBlurView():setNoBlurOnEnter(isBackOpen)

	self._lotteryData = self:getOpenParam()[1]

	self:_bindEvents()
	TextDetectAgent.instance:sendCheckDescriptionRequest(GameEnum.DescriptionEnum.LotteryPool, tostring(self._lotteryData:getPoolId()))
	self:refreshView()
	self:_refreshScrollView()
end

function M:onExit()
	self:_unbindEvents()

	if self._commonListView then
		for i, commonView in ipairs(self._commonListView) do
			commonView:onExit()
		end
	end
end

function M:_onClickClose()
	self:close()
end

function M:refreshView(evt, text, id)
	if id == GameEnum.DescriptionEnum.LotteryPool then
		self._desc.text = text
	end
end

function M:_refreshScrollView()
	local upList, commonList = self._lotteryData:getPreviewItemList()

	self._irregularLoopScroll:ClearCells()
	self:setIrregularLoop(upList, commonList)
end

function M:setIrregularLoop(upList, commonList)
	local irregularInfo = {}

	self._commonListView = {}
	self._scrollList = {}

	local isUp = false

	for quality = GameEnum.QualityEnum.S, GameEnum.QualityEnum.D, -1 do
		if upList[quality] then
			isUp = true

			local txtLayoutIrregularInfo = Astral.IrregularInfo.New(0, txtLayoutUpHeight, nil)

			table.insert(irregularInfo, txtLayoutIrregularInfo)
			table.insert(self._scrollList, {
				isUp = true,
				quality = quality,
				rate = self._lotteryData:getUpRateByQuality(quality)
			})

			local totalUpCardLineCount = math.ceil(#upList[quality] / eachCountPerLine)

			for i = 1, totalUpCardLineCount do
				local irregularCommonInfo = Astral.IrregularInfo.New(1, upCellHeight, nil)

				table.insert(irregularInfo, irregularCommonInfo)

				local tempList = {}

				for j = 1, eachCountPerLine do
					local index = j + (i - 1) * eachCountPerLine

					table.insert(tempList, upList[quality][index])
				end

				table.insert(self._scrollList, {
					isUp = true,
					quality = quality,
					list = tempList
				})
			end
		end
	end

	if isUp then
		local lineLayoutIrregularInfo = Astral.IrregularInfo.New(0, txtLayoutLineHeight, nil)

		table.insert(irregularInfo, lineLayoutIrregularInfo)
		table.insert(self._scrollList, {
			isLine = true
		})
	end

	for quality = GameEnum.QualityEnum.S, GameEnum.QualityEnum.D, -1 do
		if commonList[quality] then
			local txtLayoutIrregularInfo = Astral.IrregularInfo.New(0, txtLayoutCommonHeight, nil)
			local complexRate = self._lotteryData:getComplexRateByQuality(quality)
			local baiseRate = self._lotteryData:getCommonRateByQuality(quality)

			table.insert(irregularInfo, txtLayoutIrregularInfo)
			table.insert(self._scrollList, {
				isUp = false,
				quality = quality,
				rate = baiseRate,
				complexRate = complexRate
			})

			local spaceTimes = 0
			local totalCommonLineCount = math.ceil(#commonList[quality] / eachCountPerLine)

			for i = 1, totalCommonLineCount do
				if i == totalCommonLineCount then
					spaceTimes = 1
				end

				local irregularCommonInfo = Astral.IrregularInfo.New(1, commonCellHeight + spaceTimes * cellSpace, nil)

				table.insert(irregularInfo, irregularCommonInfo)

				local tempList = {}

				for j = 1, eachCountPerLine do
					local index = j + (i - 1) * eachCountPerLine

					table.insert(tempList, commonList[quality][index])
				end

				table.insert(self._scrollList, {
					isUp = false,
					quality = quality,
					list = tempList
				})
			end
		end
	end

	local lotterySimpleType = self._lotteryData:getLotterySimpleType()

	if lotterySimpleType == RetrieveEnum.LotterySimpleType.Card then
		local lineLayoutIrregularInfo = Astral.IrregularInfo.New(0, heroRewardHeight, nil)

		table.insert(irregularInfo, lineLayoutIrregularInfo)
		table.insert(self._scrollList, {
			isLine = false,
			isReward = true
		})
	elseif lotterySimpleType == RetrieveEnum.LotterySimpleType.Echo then
		local lineLayoutIrregularInfo = Astral.IrregularInfo.New(0, echoRewardHeight, nil)

		table.insert(irregularInfo, lineLayoutIrregularInfo)
		table.insert(self._scrollList, {
			isLine = false,
			isReward = true
		})
	end

	self._irregularLoopScroll:UpdateIrregularInfo(irregularInfo, true, false)
end

function M:_onCellUpdate(cellRect, curIndex, type, param)
	curIndex = curIndex + 1

	local childCount = cellRect.childCount
	local commonGo = false
	local commonView = false

	if childCount ~= 0 then
		commonGo = cellRect.transform:GetChild(0).gameObject
		commonView = Astral.LuaComponentContainer.Get(commonGo, RetrieveCardCutlineItemView)

		commonView:onExit()
	else
		commonGo = self._viewPresentor:getResInstance(ResName.RetrievePreviewScrollItem)
		commonView = Astral.LuaComponentContainer.Add(commonGo, RetrieveCardCutlineItemView)

		goutil.addChildToParent(commonGo, cellRect)
		table.insert(self._commonListView, commonView)
	end

	commonView:setViewPresentor(self._viewPresentor)
	commonView:onEnter()
	commonView:setLotteryData(self._lotteryData)
	commonView:setLotteryType(self._lotteryData:getLotterySimpleType())
	commonView:updateData(self._scrollList[curIndex])
end

return M
