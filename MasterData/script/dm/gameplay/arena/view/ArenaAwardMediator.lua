-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/arena/view/ArenaAwardMediator.lua

ArenaAwardMediator = class("ArenaAwardMediator", DmPopupViewMediator, _M)

ArenaAwardMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")

local kEffectRank = {
	cc.c4b(130, 70, 50, 229.5),
	cc.c4b(90, 80, 130, 229.5),
	cc.c4b(154, 76, 34, 229.5)
}
local clickEventMap = {
	["bg.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}

function ArenaAwardMediator:initialize()
	super.initialize(self)
end

function ArenaAwardMediator:dispose()
	super.dispose(self)
end

function ArenaAwardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(clickEventMap)
end

function ArenaAwardMediator:enterWithData(data)
	self:initWidgetInfo(data)
	self:initContent()
end

function ArenaAwardMediator:initWidgetInfo(data)
	self._mainPanel = self:getView():getChildByFullName("bg")

	self._mainPanel:getChildByFullName("title_node.Text_1"):setString(Strings:get("Arena_Reward_Title"))
	self._mainPanel:getChildByFullName("title_node.Text_2"):setString(Strings:get("UITitle_EN_Duanweijiangli"))

	self._viewPanel = self._mainPanel:getChildByName("viewPanel")
	self._cellPanel = self._mainPanel:getChildByName("cellPanel")

	self._cellPanel:setVisible(false)
	self:getView():getChildByFullName("button_rule"):setVisible(false)
end

function ArenaAwardMediator:initContent()
	local data = self._arenaSystem:getRankList()
	local viewSize = self._viewPanel:getContentSize()
	local tableView = cc.TableView:create(viewSize)
	local kCellHeight = self._cellPanel:getContentSize().height

	local function numberOfCells(view)
		return #data
	end

	local function cellSize(table, idx)
		return viewSize.width, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setContentSize(cc.size(viewSize.width, kCellHeight))
		end

		local index = idx + 1

		self:addRankAwardPanel(cell, index, data[index])

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._viewPanel)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
end

function ArenaAwardMediator:addRankAwardPanel(cell, index, data)
	cell:removeAllChildren()

	local panel = self._cellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local tmp1, tmp2 = math.modf(index / 2)
	local v = tmp2 == 0

	panel:getChildByName("Image_bg1"):setVisible(v)
	panel:getChildByName("Image_bg2"):setVisible(not v)

	local level = panel:getChildByName("level")
	local num = panel:getChildByName("num")
	local rankrequire = panel:getChildByName("rankrequire")
	local iconPanel = panel:getChildByName("icon")
	local firstAwardPanel = panel:getChildByName("icon_1")

	level:setString(Strings:get(data.Name))
	num:setString(data.ArenaAmount)

	local str = data.RankAmount == -1 and Strings:get("Arena_NullNum") or data.RankAmount

	rankrequire:setString(str)

	local rewards = RewardSystem:getRewardsById(data.NormalReward)

	for i = 1, #rewards do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			showAmount = true,
			isWidget = true
		})

		icon:addTo(iconPanel)
		icon:setScaleNotCascade(0.4)

		if #rewards == 1 then
			icon:setPosition(cc.p(iconPanel:getContentSize().width + 8, iconPanel:getContentSize().height / 2))
		else
			icon:setPosition(cc.p(iconPanel:getContentSize().width / 2 + (i - 1) * 61, iconPanel:getContentSize().height / 2))
		end

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
	end

	local rewards = RewardSystem:getRewardsById(data.FirstReward)

	for i = 1, #rewards do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			showAmount = true,
			isWidget = true
		})

		icon:addTo(firstAwardPanel)
		icon:setScaleNotCascade(0.4)
		icon:setPosition(cc.p(firstAwardPanel:getContentSize().width / 2 + (i - 1) * 60 + 5, firstAwardPanel:getContentSize().height / 2))
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
	end
end

function ArenaAwardMediator:onClickClose()
	self:close()
end

function ArenaAwardMediator:onClickRule()
	local data = {
		title = Strings:get("Arena_Reward_Detail_Title"),
		title1 = Strings:get("UITitle_EN_Jianglishuoming"),
		content = Strings:get("Arena_Reward_Detail_Text"),
		sureBtn = {}
	}
	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		return
	end

	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end
