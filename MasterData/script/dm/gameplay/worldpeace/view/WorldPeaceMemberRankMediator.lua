-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceMemberRankMediator.lua

WorldPeaceMemberRankMediator = class("WorldPeaceMemberRankMediator", DmPopupViewMediator, _M)

WorldPeaceMemberRankMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceMemberRankMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.btn_reward"] = {
		ignoreClickAudio = true,
		func = "showRankRewardView"
	}
}

function WorldPeaceMemberRankMediator:initialize()
	super.initialize(self)
end

function WorldPeaceMemberRankMediator:dispose()
	super.dispose(self)
end

function WorldPeaceMemberRankMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._myCell = self._main:getChildByName("myself_info_bg")
end

function WorldPeaceMemberRankMediator:setupView(data)
	if not self._init then
		self._init = true
		self._worldPeace = self._worldPeaceSystem:getWorldPeace()
		self._memberRankList = self._worldPeace:getMemberRankList()

		table.sort(self._memberRankList, function(a, b)
			return a.rank < b.rank
		end)
		self:setTopThreeView()
		self:createTableView()
		self:setMySelfView()
		self:refreshRedPoint()
	end
end

function WorldPeaceMemberRankMediator:refreshRedPoint()
	local rewardBtn = self._main:getChildByFullName("btn_reward")
	local node = RedPoint:createDefaultNode()
	local redPoint = RedPoint:new(node, rewardBtn, function()
		return self._worldPeaceSystem:hasRewardGetByType(WPRewardType.kMemberHurt)
	end)

	redPoint:posite(55, 55)
end

local headIconScale = {
	1.3,
	1.15,
	1.05
}

function WorldPeaceMemberRankMediator:setTopThreeView()
	for i = 1, 3 do
		local cell = self._main:getChildByName("cell" .. i)
		local name = cell:getChildByFullName("name")
		local name_null = cell:getChildByFullName("name_null")
		local rankTxt1 = cell:getChildByFullName("rankTxt1")
		local rankNum = cell:getChildByFullName("rankNum")
		local iconNode = cell:getChildByName("headIcon")

		iconNode:removeAllChildren()

		local data = self._memberRankList[i]

		if not data then
			name:setString("")
			rankTxt1:setString("")
			rankNum:setString("")
			name_null:setVisible(true)
		else
			name_null:setVisible(false)
			name:setString(data.nickName)
			rankTxt1:setString(Strings:get("ClubMapBoss_Page2_Score"))
			rankNum:setString(self._worldPeaceSystem:formatShowNum(data.damage))

			local headIcon, oldIcon = IconFactory:createPlayerIcon({
				clipType = 4,
				id = data.headImage,
				headFrameId = data.headFrame
			})

			oldIcon:setScale(0.45)
			headIcon:addTo(iconNode):center(iconNode:getContentSize())
			headIcon:setScale(headIconScale[i])
		end
	end
end

function WorldPeaceMemberRankMediator:createTableView()
	local size = self._myCell:getContentSize()
	local tableView = cc.TableView:create(cc.size(880, 170))

	local function scrollViewDidScroll(table)
		return
	end

	local function numberOfCells(view)
		return #self._memberRankList <= 6 and 6 or #self._memberRankList - 3
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return size.width, size.height
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local cloneCell = self._myCell:clone()

			cloneCell:setVisible(true)
			cloneCell:addTo(cell):setTag(111):posite(0, 0)
		end

		self:updateCell(cell:getChildByTag(111), idx + 1)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._main):posite(207, 85)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:setMaxBounceOffset(36)

	self._tableView = tableView

	self._tableView:reloadData()
end

function WorldPeaceMemberRankMediator:updateCell(cell, index)
	local bg = index % 2 == 0 and "bd_bg_xxt_2.png" or "bd_bg_xxt_1.png"

	cell:getChildByFullName("Image_10"):loadTexture(bg, 1)

	local rankText = cell:getChildByName("text_1")
	local nameText = cell:getChildByName("text_2")
	local hurtText = cell:getChildByName("text_3")
	local emptyImg = cell:getChildByName("empty_img")
	local myselfImg = cell:getChildByName("img_myself")

	myselfImg:setVisible(false)

	local realIndex = index + 3

	rankText:setString(realIndex)
	setTextWithFontStyle(rankText, "FontSZHText")
	setTextWithFontStyle(nameText, "FontSZHText")
	setTextWithFontStyle(hurtText, "FontSZHText")

	local data = self._memberRankList[realIndex]

	if data then
		emptyImg:setVisible(false)
		nameText:setString(data.nickName)
		hurtText:setString(self._worldPeaceSystem:formatShowNum(data.damage))
	else
		nameText:setString("")
		hurtText:setString("")
		emptyImg:setVisible(true)
	end
end

function WorldPeaceMemberRankMediator:setMySelfView()
	local player = self._developSystem:getPlayer()
	local rankText = self._myCell:getChildByName("text_1")
	local nameText = self._myCell:getChildByName("text_2")
	local hurtText = self._myCell:getChildByName("text_3")
	local emptyImg = self._myCell:getChildByName("empty_img")
	local data = self._worldPeace:getMemberDataByRid(player:getRid())

	if data then
		emptyImg:setVisible(false)
		nameText:setString(data.nickName)
		hurtText:setString(self._worldPeaceSystem:formatShowNum(data.damage))
		rankText:setString(data.rank)
	else
		nameText:setString("")
		hurtText:setString("")
		emptyImg:setVisible(false)
		rankText:setString(Strings:get("StagePractice_Text19"))
	end
end

function WorldPeaceMemberRankMediator:showRankRewardView()
	local view = self:getInjector():getInstance("WorldPeaceRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {}))
end
