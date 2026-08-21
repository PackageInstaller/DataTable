-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/hero/HouseHeroMoodRecordView.lua

module("logic.extensions.house.view.hero.HouseHeroMoodRecordView", package.seeall)

local M = class("HouseHeroMoodRecordView", ViewComponent)
local kWidthInterval = 135
local kShowCount = 24

function M:ctor()
	self._heroId = 0
	self._arrayMoodIcon = {}
	self._dictDescItem = {}
end

function M:buildUI()
	local heroItemRoot = self:getGo("room_small_role_detail_tips_1136515082")
	local heroItemGO = goutil.findChild(heroItemRoot, "hero_item")

	self._heroItem = Astral.LuaComponentContainer.Add(heroItemGO, HeroHeadItem)
	self._txtName = self:getText("room_small_role_detail_tips_-314476616")
	self._goDescContent = self:getGo("room_small_role_detail_tips_1077278233")
	self._dictDescItem = {}

	local moodGO = self:getGo("room_small_role_detail_tips_1851282071")

	self._moodCell = Astral.LuaComponentContainer.Add(moodGO, HouseHeroMoodCell)
	self._txtMoodProgress = self:getText("room_small_role_detail_tips_614246974")
	self._btnClose = self:getBtn("1&middle_tips_common_bg_-1205189576")
	self._goLineChart = self:getGo("room_small_role_detail_tips_1338088087")
	self._lineChartWrap = LineChartWraper.Get(self._goLineChart)

	local moodIcon = goutil.findChild(self._goLineChart, "moodIcon")

	self._arrayMoodIcon = {}

	table.insert(self._arrayMoodIcon, moodIcon)

	for i = 1, kShowCount - 1 do
		local cloneMoodIcon = goutil.cloneAndSetParent(moodIcon, self._goLineChart.transform)

		table.insert(self._arrayMoodIcon, cloneMoodIcon)
	end
end

function M:destroyUI()
	table.clear(self._arrayMoodIcon)
	table.clear(self._dictDescItem)
	self._heroItem:destroy()

	self._heroItem = nil
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._lineChartWrap:AddDrawListener(self._onLineDraw, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._lineChartWrap:RemoveDrawListener()
end

function M:_setEvents(isOn)
	if isOn then
		HouseDispatcher:addEventListener(HouseEventType.REPLY_GET_SINGLE_HERO_FEATURE, self._onReplyGetSingleHeroFeature, self)
	else
		HouseDispatcher:removeEventListener(HouseEventType.REPLY_GET_SINGLE_HERO_FEATURE, self._onReplyGetSingleHeroFeature, self)
	end
end

function M:onEnter()
	self._heroId = self:getFirstParam()

	self:initView()
	self:refreshView()
	self:_showScrollEnd()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)

	self._heroId = 0
end

function M:initView()
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._heroId)

	if heroMO then
		self._heroItem:setHeroMO(heroMO)

		self._txtName.text = heroMO:getName()
	end
end

function M:refreshView()
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._heroId)
	local featureMO = HeroHouseFeatureModel.instance:getFeatureMO(self._heroId)

	if heroMO and featureMO then
		local records = featureMO:getMoodRecords()
		local mood = math.floor(featureMO:getMood())
		local maxMood = HouseConfig.instance:getHouseConst("MoodMax").numValue

		self._moodCell:updateMood(mood)
		self._moodCell:updateMoodDesc(mood)

		self._txtMoodProgress.text = string.format("%s/%s", mood, maxMood)

		self:_refreshDesc(TableUtil.reverseTable(records))
		self:_refreshMoodIcon(records)

		local chartWidth = #records * kWidthInterval

		RectTransformUtils.SetWidth(self._goLineChart.transform, chartWidth)
		RectTransformUtils.ForceRebuildLayoutImmediate(self._goLineChart.transform)

		local arrayCoordX = {}
		local arrayCoordY = {}

		for idx, recordMO in ipairs(records) do
			table.insert(arrayCoordX, recordMO:getCoordXStr())
			table.insert(arrayCoordY, recordMO:getMood())
		end

		self._lineChartWrap:AddData(arrayCoordX, arrayCoordY)
	end
end

function M:_refreshMoodIcon(records)
	for idx, recordMO in ipairs(records) do
		local mood = recordMO:getMood()
		local icon = self._arrayMoodIcon[idx]
		local imgIcon = icon:GetComponent(UIComponentType.Image)
		local type = HouseWorkerModel.instance:getMoodInterval(mood)

		if type == 1 then
			IconLoader.setSprite(imgIcon, IconType.DynSpriteAtlas_Room, "room_mood_1")
		elseif type == 2 then
			IconLoader.setSprite(imgIcon, IconType.DynSpriteAtlas_Room, "room_mood_2")
		else
			IconLoader.setSprite(imgIcon, IconType.DynSpriteAtlas_Room, "room_mood_3")
		end
	end
end

function M:_refreshDesc(records)
	for _, item in pairs(self._dictDescItem) do
		item:setVisible(false)
	end

	for idx, recordMO in ipairs(records) do
		local item = self:_tryGetDescItem(idx)

		item:setVisible(true)
		item:updateData(recordMO)
	end
end

function M:_tryGetDescItem(idx)
	local item = self._dictDescItem[idx]

	if not item then
		local itemGO = self:getResInstance(ResName.Room_room_small_role_detail_item)

		item = Astral.LuaComponentContainer.Add(itemGO, HouseHeroMoodRecordItem)

		goutil.addChildToParent(itemGO, self._goDescContent)

		self._dictDescItem[idx] = item
	end

	return item
end

function M:_showScrollEnd()
	local chartWidth = RectTransformUtils.GetWidth(self._goLineChart.transform)

	Astral.TransformUtil.SetPosX(self._goLineChart.transform.parent, 524 - chartWidth)
end

function M:_onClickBtnClose()
	self:close()
end

function M:_onReplyGetSingleHeroFeature(e, heroId)
	if self._heroId == heroId then
		self:refreshView()
	end
end

function M:_onLineDraw(startIndex, showPoints)
	local endIndex = startIndex + showPoints.Length

	startIndex = startIndex + 1

	for idx, moodIcon in ipairs(self._arrayMoodIcon) do
		if startIndex <= idx and idx <= endIndex then
			goutil.setActive(moodIcon, true)

			local pos = showPoints[idx - startIndex]

			Astral.TransformUtil.SetLocalPosX(moodIcon.transform, pos.x)
			Astral.TransformUtil.SetLocalPosY(moodIcon.transform, pos.y)
		else
			goutil.setActive(moodIcon, false)
		end
	end
end

return M
