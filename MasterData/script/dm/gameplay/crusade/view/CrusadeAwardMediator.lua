-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/view/CrusadeAwardMediator.lua

CrusadeAwardMediator = class("CrusadeAwardMediator", DmPopupViewMediator, _M)

CrusadeAwardMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")

function CrusadeAwardMediator:initialize()
	super.initialize(self)
end

function CrusadeAwardMediator:dispose()
	super.dispose(self)
end

function CrusadeAwardMediator:onRegister()
	super.onRegister(self)

	self._bgWidget = bindWidget(self, "bg.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Crusade_UI11"),
		title1 = Strings:get("UITitle_EN_Jiangli"),
		bgSize = {
			width = 837,
			height = 576
		}
	})
end

function CrusadeAwardMediator:enterWithData(data)
	self._rewards = data.rewards

	local curFloorModel = self._crusadeSystem:getCurCrusadeFloorModel()
	local crusadePointModel = self._crusadeSystem:getCurCrusadePointModel()

	self._floorIndex = crusadePointModel and curFloorModel:getIndex() or 100

	self:initWidgetInfo()
	self:initContent()
end

function CrusadeAwardMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByFullName("bg")
	self._viewPanel = self._mainPanel:getChildByName("viewPanel")
	self._cellPanel = self._mainPanel:getChildByName("cellPanel")

	self._cellPanel:setVisible(false)
end

function CrusadeAwardMediator:initContent()
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
		local data = self._rewards[index]

		self:addRankAwardPanel(cell, data)

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

function CrusadeAwardMediator:addRankAwardPanel(cell, awardInfo)
	cell:removeAllChildren()

	local panel = self._cellPanel:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)

	local rankNum = panel:getChildByName("rankNum")
	local firstPassImg = panel:getChildByName("firstPassImg")

	rankNum:setString(awardInfo.name)
	GameStyle:setQualityText(rankNum, awardInfo.quality, true)

	local rewards = awardInfo.rewards
	local iconPanel = panel:getChildByName("icon")
	local length = #rewards

	firstPassImg:setVisible(false)

	local color = cc.c3b(255, 255, 255)

	for i = 1, length do
		local icon = IconFactory:createRewardIcon(rewards[i], {
			isWidget = true
		})

		icon:addTo(iconPanel)
		icon:setScale(0.7)
		icon:setPosition(cc.p(iconPanel:getContentSize().width / 2 + (i - 1) * 90, iconPanel:getContentSize().height / 2))
		icon:setColor(color)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewards[i], {
			needDelay = true
		})
	end

	local iconFirst = panel:getChildByName("icon_first")
	local rewardsFirst = self._crusadeSystem:getfloorFirstReward(awardInfo.index)
	local length = #rewardsFirst

	for i = 1, length do
		local icon = IconFactory:createRewardIcon(rewardsFirst[i], {
			isWidget = true
		})

		icon:addTo(iconFirst)
		icon:setScale(0.7)
		icon:setPosition(cc.p(iconFirst:getContentSize().width / 2 + (i - 1) * 90, iconFirst:getContentSize().height / 2))
		icon:setColor(color)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardsFirst[i], {
			needDelay = true
		})
	end
end

function CrusadeAwardMediator:onClickClose()
	self:close()
end
