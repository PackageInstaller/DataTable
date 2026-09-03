-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubBossShowRewardMediator.lua

ClubBossShowRewardMediator = class("ClubBossShowRewardMediator", DmPopupViewMediator)

ClubBossShowRewardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubBossShowRewardMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onCloseClicked"
	}
}

function ClubBossShowRewardMediator:initialize()
	super.initialize(self)
end

function ClubBossShowRewardMediator:dispose()
	super.dispose(self)
end

function ClubBossShowRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ClubBossShowRewardMediator:enterWithData(data)
	self:initDate(data)
	self:initNodes()
	self:createTableView()
end

function ClubBossShowRewardMediator:initDate(data)
	if data and data.awards then
		local list = {}

		for k, value in pairs(data.awards) do
			list[#list + 1] = value
		end

		table.sort(list, function(a, b)
			return a.id and a.id == self._developSystem:getPlayer():getRid()
		end)

		self._allData = list
	end
end

function ClubBossShowRewardMediator:initNodes()
	self._main = self:getView():getChildByName("main")
	self._viewPanel = self._main:getChildByFullName("viewPanel")
	self._cellPanel = self._main:getChildByFullName("cellPanel")

	self._cellPanel:setVisible(false)

	self._titleNode = self._main:getChildByFullName("title_node")

	local config = {
		title = Strings:get("clubBoss_22"),
		title1 = Strings:get("clubBoss_23")
	}

	self._titleNode:setVisible(true)
	self._titleNode:setLocalZOrder(3)

	local injector = self:getInjector()
	local titleWidget = injector:injectInto(TitleWidget:new(self._titleNode))

	titleWidget:updateView(config)
end

function ClubBossShowRewardMediator:createTableView()
	local function cellSizeForTable(table, idx)
		return 752, 100
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local layout = ccui.Layout:create()

			layout:addTo(cell):posite(0, 0)
			layout:setAnchorPoint(cc.p(0, 0))
			layout:setTag(123)
		end

		local cell_Old = cell:getChildByTag(123)

		self:createCell(cell_Old, self._allData[idx + 1])
		cell:setTag(idx)

		return cell
	end

	local function numberOfCellsInTableView(table)
		return #self._allData
	end

	local tableView = cc.TableView:create(self._viewPanel:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setPosition(0, 0)
	tableView:setAnchorPoint(0, 0)
	tableView:setMaxBounceOffset(36)
	self._viewPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
	tableView:setBounceable(false)
end

function ClubBossShowRewardMediator:createCell(cell, data)
	cell:removeAllChildren()

	local panel = self._cellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local greatImage = panel:getChildByName("greatImage")
	local nomalImage = panel:getChildByName("nomalImage")

	if data.perfect == true then
		greatImage:setVisible(true)
		nomalImage:setVisible(false)
	else
		greatImage:setVisible(false)
		nomalImage:setVisible(true)
	end

	local headPanel = panel:getChildByName("headPanel")

	if data.head and data.headFrame then
		local headIcon = IconFactory:createPlayerIcon({
			frameStyle = 3,
			clipType = 1,
			headFrameScale = 0.4,
			id = data.head,
			size = cc.size(82, 82),
			headFrameId = data.headFrame
		})

		headIcon:setScale(0.8)
		headIcon:addTo(headPanel):center(headPanel:getContentSize())
		headPanel:setTouchEnabled(true)
		headPanel:addClickEventListener(function()
			self:onClickPlayerHead(data)
		end)
	end

	local nameText = panel:getChildByName("nameText")

	nameText:setString(data.name)

	local rewardNode = panel:getChildByName("RewardNode")
	local list = {}

	for k, v in pairs(data.itemCount) do
		local oneReward = {}

		if self:getRewardType(k) > 0 then
			oneReward.type = self:getRewardType(k)
		end

		oneReward.code = k
		oneReward.amount = v
		list[#list + 1] = oneReward
	end

	local rewardSystem = self:getInjector():getInstance(RewardSystem)

	table.sort(list, function(a, b)
		if a.type == RewardType.kHero then
			return true
		elseif a.type == RewardType.kSurface then
			return true
		elseif a.type == RewardType.kEquip then
			return true
		end

		return false
	end)

	for i = 1, #list do
		local rewardIcon = IconFactory:createRewardIcon(list[i], {
			isWidget = true
		})

		IconFactory:bindTouchHander(rewardIcon, IconTouchHandler:new(self), list[i], {
			needDelay = true
		})
		panel:addChild(rewardIcon)
		rewardIcon:setPosition(cc.p(530 + (i - 1) * 80, 50))
		rewardIcon:setScaleNotCascade(0.6)
	end
end

function ClubBossShowRewardMediator:getRewardType(code)
	local type = 0
	local config = ConfigReader:getRecordById("ItemConfig", code)

	if config then
		type = RewardType.kItem
	end

	if not config then
		config = ConfigReader:getRecordById("Surface", code)

		if config then
			type = RewardType.kSurface
		end
	end

	if not config then
		config = ConfigReader:getRecordById("HeroEquipBase", code)

		if config then
			type = RewardType.kEquip
		end
	end

	if not config then
		config = ConfigReader:getRecordById("HeroBase", code)

		if config then
			type = RewardType.kHero
		end
	end

	return type
end

function ClubBossShowRewardMediator:onClickPlayerHead(data)
	if not data or data.id == nil then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._clubSystem:showMemberPlayerInfoView(data.id)
end

function ClubBossShowRewardMediator:onCloseClicked(sender, eventType)
	self:close()
end
