-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubBossActivityScoreMediator.lua

ClubBossActivityScoreMediator = class("ClubBossActivityScoreMediator", DmPopupViewMediator)

ClubBossActivityScoreMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubBossActivityScoreMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {
	["main.btn_close"] = {
		ignoreClickAudio = true,
		func = "onCloseClicked"
	}
}

function ClubBossActivityScoreMediator:initialize()
	super.initialize(self)
end

function ClubBossActivityScoreMediator:dispose()
	super.dispose(self)
end

function ClubBossActivityScoreMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local view = self:getView()
end

function ClubBossActivityScoreMediator:mapEventListeners()
	return
end

function ClubBossActivityScoreMediator:enterWithData(data)
	self:initDate(data)
	self:initNodes()
	self:createTableView()
end

function ClubBossActivityScoreMediator:initDate(data)
	self._clubBossInfo = self._developSystem:getPlayer():getClub():getClubBossInfo(ClubHallType.kActivityBoss)

	local score = self._clubBossInfo:getScore()

	if score then
		local list = {}

		for k, value in pairs(score) do
			local rankData = {}

			rankData.memberData = self._clubSystem:getMemberRecordByRid(k)
			rankData.score = value
			list[#list + 1] = rankData
		end

		table.sort(list, function(a, b)
			return a.score > b.score
		end)

		self._allData = list
	end
end

function ClubBossActivityScoreMediator:initNodes()
	self._main = self:getView():getChildByName("main")
	self._viewPanel = self._main:getChildByFullName("viewPanel")
	self._cellPanel = self:getView():getChildByFullName("clonePanel")

	self._cellPanel:setVisible(false)

	self._titleNode = self._main:getChildByFullName("title_node")

	local config = {
		title = Strings:get("Club_ActivityBoss_12"),
		title1 = Strings:get("Club_ActivityBoss_13")
	}

	self._titleNode:setVisible(true)
	self._titleNode:setLocalZOrder(3)

	local injector = self:getInjector()
	local titleWidget = injector:injectInto(TitleWidget:new(self._titleNode))

	titleWidget:updateView(config)

	local des1, des2, nextScore = self._clubSystem:getAttrEffectValueForScore(self._clubBossInfo:getAllScore())
	local allText = self._main:getChildByFullName("allText")

	allText:setString(tostring(self._clubBossInfo:getAllScore()))

	local allText2 = self._main:getChildByFullName("allText2")

	allText2:setString(des1)

	local nextBaseNode = self._main:getChildByFullName("nextBaseNode")
	local noNextText = self._main:getChildByFullName("noNextText")

	if nextScore > 0 then
		local nextText = nextBaseNode:getChildByFullName("nextText")

		nextText:setString(tostring(nextScore))

		local nextText2 = nextBaseNode:getChildByFullName("nextText2")

		nextText2:setString(des2)
		noNextText:setVisible(false)
	else
		nextBaseNode:setVisible(false)
		noNextText:setVisible(true)
	end
end

function ClubBossActivityScoreMediator:createTableView()
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

		self:createCell(cell_Old, self._allData[idx + 1], idx + 1)
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

function ClubBossActivityScoreMediator:createCell(cell, data, rankID)
	cell:removeAllChildren()

	local panel = self._cellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local rank = panel:getChildByName("rank")

	rank:setVisible(false)

	local rankBg1 = panel:getChildByName("rankBg1")

	rankBg1:setVisible(false)

	local rankBg2 = panel:getChildByName("rankBg2")

	rankBg2:setVisible(false)

	local rankBg3 = panel:getChildByName("rankBg3")

	rankBg3:setVisible(false)

	if rankID == 1 then
		rankBg1:setVisible(true)
	elseif rankID == 2 then
		rankBg2:setVisible(true)
	elseif rankID == 3 then
		rankBg3:setVisible(true)
	else
		rank:setVisible(true)
		rank:setString(tostring(rankID))
	end

	local headPanel = panel:getChildByName("headPanel")

	if data.memberData and data.memberData:getHeadId() then
		local headIcon = IconFactory:createPlayerIcon({
			frameStyle = 2,
			clipType = 1,
			headFrameScale = 0.4,
			id = data.memberData:getHeadId(),
			size = cc.size(82, 82),
			headFrameId = data.memberData:getHeadFrame()
		})

		headIcon:setPosition(cc.p(17, 17))
		headIcon:setScale(0.4)
		headIcon:addTo(headPanel)
		headPanel:setScale(1.5)
		headPanel:setTouchEnabled(true)
		headPanel:addClickEventListener(function()
			self:onClickPlayerHead(data.memberData)
		end)

		local nameText = panel:getChildByName("nameText")

		nameText:setString(data.memberData:getName())
	end

	local scoreText = panel:getChildByName("scoreText")

	scoreText:setString(data.score)
end

function ClubBossActivityScoreMediator:onClickPlayerHead(data)
	if not data then
		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._clubSystem:showMemberPlayerInfoView(data:getRid())
end

function ClubBossActivityScoreMediator:onCloseClicked(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self:close()
end
