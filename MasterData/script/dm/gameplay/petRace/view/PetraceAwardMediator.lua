-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/PetraceAwardMediator.lua

PetraceAwardMediator = class("PetraceAwardMediator", DmPopupViewMediator, _M)

function PetraceAwardMediator:initialize()
	super.initialize(self)
end

function PetraceAwardMediator:dispose()
	super.dispose(self)
end

function PetraceAwardMediator:onRegister()
	super.onRegister(self)

	self._bgWidget = bindWidget(self, "bg.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Petrace_Text_107"),
		title1 = Strings:get("Petrace_Text_108"),
		bgSize = {
			width = 837,
			height = 576
		}
	})
end

function PetraceAwardMediator:enterWithData(data)
	self._rewards = ConfigReader:getDataByNameIdAndKey("ConfigValue", "KOF_RankReward", "content") or {}

	self:initWidgetInfo()
	self:initContent()
end

function PetraceAwardMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByFullName("bg")
	self._viewPanel = self._mainPanel:getChildByName("viewPanel")
	self._cellPanel = self._mainPanel:getChildByName("cellPanel")

	self._cellPanel:setVisible(false)
end

function PetraceAwardMediator:initContent()
	local viewSize = self._viewPanel:getContentSize()
	local tableView = cc.TableView:create(viewSize)
	local kCellHeight = self._cellPanel:getContentSize().height

	local function numberOfCells(view)
		return #self._rewards
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
		local rewardId = self._rewards[index]

		self:addRankAwardPanel(cell, rewardId)

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

function PetraceAwardMediator:addRankAwardPanel(cell, rewardId)
	cell:removeAllChildren()

	local reward = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "Reward") or ""
	local rank = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "Rank") or {}
	local dartnum = ConfigReader:getDataByNameIdAndKey("RankReward", rewardId, "DartNum") or 0
	local panel = self._cellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local rankNum = panel:getChildByName("rankNum")

	rankNum:setString(rank[1] == rank[2] and Strings:get("Petrace_Text_111", {
		num = rank[1]
	}) or Strings:get("Petrace_Text_111", {
		num = rank[1] .. "-" .. rank[2]
	}))

	local text_dartnum = panel:getChildByName("text_score")

	text_dartnum:setString(dartnum)

	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", reward, "Content") or {}
	local iconPanel = panel:getChildByName("icon")
	local length = #rewards

	for i = 1, length do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			showAmount = true,
			isWidget = true
		})

		icon:addTo(iconPanel)
		icon:setScale(0.7)
		icon:setPosition(cc.p(iconPanel:getContentSize().width / 2 + (i - 1) * 94, iconPanel:getContentSize().height / 2))
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
	end
end

function PetraceAwardMediator:onClickClose()
	self:close()
end
