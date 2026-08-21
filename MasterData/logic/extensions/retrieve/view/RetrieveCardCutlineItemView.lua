-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveCardCutlineItemView.lua

module("logic.extensions.retrieve.view.RetrieveCardCutlineItemView", package.seeall)

local M = class("RetrieveCardCutlineItemView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self._smallTitleGo = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_-572400324")
	self._imgQuality = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_-1847230700", UIComponentType.Image)
	self._txtHint = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_-1558199640", UIComponentType.Text)
	self._goHint = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_695024219")
	self._goLine = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_-684092707")
	self._txtDesc = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_1628104111", UIComponentType.Text)
	self._echoLayout = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_775198285")
	self._heroLayout = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_-426131385")
	self._txtSmallTitle = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_70778176", UIComponentType.Text)
	self._heroRewardGo = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_371048589")
	self._echoRewardGo = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_373631772")
	self._heroRewardInfo = {
		[5] = {
			self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_41229583", UIComponentType.TMPText),
			self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_890199098", UIComponentType.TMPText)
		},
		[4] = {
			self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_354623084", UIComponentType.TMPText),
			self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_1254615004", UIComponentType.TMPText)
		},
		[3] = {
			self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_1919238081", UIComponentType.TMPText),
			self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_338964446", UIComponentType.TMPText)
		}
	}
	self._echoRewardInfo = {
		[5] = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_642907153", UIComponentType.TMPText),
		[4] = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_2127811645", UIComponentType.TMPText),
		[3] = self._viewElementsRegistry:findUIElement("retrieve_preview_scroll_item_607320384", UIComponentType.TMPText)
	}
end

function M:onEnter()
	return
end

function M:setViewPresentor(viewPresentor)
	self._viewPresentor = viewPresentor
end

function M:onExit()
	return
end

function M:setLotteryType(type)
	self._type = type
end

function M:setLotteryData(lotteryData)
	self._lotteryData = lotteryData
end

function M:updateData(data)
	if data.isReward then
		goutil.setActive(self._echoRewardGo, self._type ~= RetrieveEnum.LotterySimpleType.Card)
		goutil.setActive(self._heroRewardGo, self._type == RetrieveEnum.LotterySimpleType.Card)
		goutil.setActive(self._heroLayout, false)
		goutil.setActive(self._echoLayout, false)
		goutil.setActive(self._smallTitleGo, false)
		goutil.setActive(self._goHint, false)
		goutil.setActive(self._goLine, false)
		self:_refreshReward()
	elseif data.isLine then
		goutil.setActive(self._echoRewardGo, false)
		goutil.setActive(self._heroRewardGo, false)
		goutil.setActive(self._heroLayout, false)
		goutil.setActive(self._echoLayout, false)
		goutil.setActive(self._smallTitleGo, false)
		goutil.setActive(self._goHint, false)
		goutil.setActive(self._goLine, true)
	elseif data.list then
		goutil.setActive(self._echoRewardGo, false)
		goutil.setActive(self._heroRewardGo, false)
		goutil.setActive(self._echoLayout, self._type ~= RetrieveEnum.LotterySimpleType.Card)
		goutil.setActive(self._heroLayout, self._type == RetrieveEnum.LotterySimpleType.Card)
		goutil.setActive(self._smallTitleGo, false)
		goutil.setActive(self._goHint, false)
		goutil.setActive(self._goLine, false)
		self:_refreshHeroLayout(data)
	elseif data.isUp then
		goutil.setActive(self._echoRewardGo, false)
		goutil.setActive(self._heroRewardGo, false)
		goutil.setActive(self._echoLayout, false)
		goutil.setActive(self._heroLayout, false)
		goutil.setActive(self._smallTitleGo, false)
		goutil.setActive(self._goHint, true)
		goutil.setActive(self._goLine, false)
		self:_refreshUpText(data)
	else
		goutil.setActive(self._echoRewardGo, false)
		goutil.setActive(self._heroRewardGo, false)
		goutil.setActive(self._echoLayout, false)
		goutil.setActive(self._heroLayout, false)
		goutil.setActive(self._smallTitleGo, true)
		goutil.setActive(self._goHint, false)
		goutil.setActive(self._goLine, false)
		self:_refreshCommonText(data)
	end
end

function M:_refreshReward()
	if self._type == RetrieveEnum.LotterySimpleType.Card then
		local tempTb = RetrieveConfig.instance:getConfig(ConfigName.LotteryHeroExtraReward)

		for key, value in pairs(self._heroRewardInfo) do
			local quality2Info = tempTb[key]

			for k, v in pairs(quality2Info) do
				local itemCo = BackpackConfig.instance:getItemInfoByItemId(v.itemCode)

				if itemCo then
					if v.lotteryNum == 6 and value then
						value[1].text = langF("tip_chouka_hero_desc", itemCo.name, v.itemCode, v.itemNum)
					else
						value[2].text = langF("tip_chouka_hero_desc", itemCo.name, v.itemCode, v.itemNum)
					end
				end
			end
		end
	elseif self._type == RetrieveEnum.LotterySimpleType.Echo then
		local tempTb = RetrieveConfig.instance:getConfig(ConfigName.LotteryEchoExtraReward)

		for key, value in pairs(self._echoRewardInfo) do
			local quality2Info = tempTb[key]

			for k, v in pairs(quality2Info) do
				local itemCo = BackpackConfig.instance:getItemInfoByItemId(v.itemCode)

				if itemCo and v.lotteryNum == 6 and value then
					value.text = langF("tip_chouka_echo_desc", itemCo.name, v.itemCode, v.itemNum)
				end
			end
		end
	end
end

function M:_refreshHeroLayout(data)
	local parentGO = false

	if self._type == RetrieveEnum.LotterySimpleType.Card then
		goutil.clearChildren(self._heroLayout)

		parentGO = self._heroLayout
	elseif self._type == RetrieveEnum.LotterySimpleType.Echo then
		goutil.clearChildren(self._echoLayout)

		parentGO = self._echoLayout
	end

	for i, groupCo in ipairs(data.list) do
		local itemGo = false
		local cellBehavior = false

		if self._type == RetrieveEnum.LotterySimpleType.Card then
			itemGo = self._viewPresentor:getResInstance(ResName.RetrieveHeroPreviewItem)
			cellBehavior = Astral.SimpleLuaComponentContainer.Add(itemGo, RetrieveCardCutlinePreviewItemView)
		elseif self._type == RetrieveEnum.LotterySimpleType.Echo then
			itemGo = self._viewPresentor:getResInstance(ResName.RetrieveEchoPreviewItem)
			cellBehavior = Astral.SimpleLuaComponentContainer.Add(itemGo, RetrieveEchoCutlinePreviewItemView)
		end

		goutil.addChildToParent(itemGo, parentGO)
		cellBehavior:_updateView(groupCo, self._type, self._lotteryData)
	end
end

function M:_refreshUpText(data)
	local content = ""

	if self._type == RetrieveEnum.LotterySimpleType.Card then
		content = langF("tip_summon_card_tips", CommEnum.Quality2Name[data.quality], data.rate)
	elseif self._type == RetrieveEnum.LotterySimpleType.Echo then
		content = langF("tip_summon_echo_tips", CommEnum.Quality2Name[data.quality], data.rate)
	end

	self._txtSmallTitle.text = content
end

function M:_refreshCommonText(data)
	local quality2Name = string.format("js_quality_%s", CommEnum.QuaLotteryBg[data.quality])

	IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_RetrieveMainView, quality2Name)

	local content = ""
	local complexRateStr = ""

	if data.complexRate then
		complexRateStr = langF("tip_summon_complex_rate", data.complexRate)
	end

	if self._type == RetrieveEnum.LotterySimpleType.Card then
		content = langF("tip_summon_card_probabilidad_tips", data.rate) .. complexRateStr
	elseif self._type == RetrieveEnum.LotterySimpleType.Echo then
		content = langF("tip_summon_echo_probabilidad_tips", data.rate) .. complexRateStr
	end

	self._txtHint.text = content
	self._txtDesc.text = lang("tip_retrieve_reward_desc")
end

function M:OnDestroy()
	self._viewElementsRegistry:cleanRegistry()

	self._viewElementsRegistry = nil
end

return M
