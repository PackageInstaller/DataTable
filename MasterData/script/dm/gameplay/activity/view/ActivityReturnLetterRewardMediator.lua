-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivityReturnLetterRewardMediator.lua

ActivityReturnLetterRewardMediator = class("ActivityReturnLetterRewardMediator", PopupViewMediator, _M)

ActivityReturnLetterRewardMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.drawBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickReward"
	},
	["main.back"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBack"
	}
}

function ActivityReturnLetterRewardMediator:initialize()
	super.initialize(self)
end

function ActivityReturnLetterRewardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:initUI()
end

function ActivityReturnLetterRewardMediator:enterWithData(data)
	self._rewardId = data.rewardId
	self._reward = ConfigReader:getDataByNameIdAndKey("Reward", self._rewardId, "Content")
	self._callback = data.callback

	self:setupLetterContent()
end

function ActivityReturnLetterRewardMediator:initUI()
	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("listPanel")
	self._itemCell = self:getView():getChildByName("cell")
end

function ActivityReturnLetterRewardMediator:setupLetterContent()
	self._listView:removeAllChildren()

	local size = self._itemCell:getContentSize()
	local listSize = self._listView:getContentSize()
	local tableView = cc.TableView:create(listSize)

	local function numberOfCells(view)
		return math.ceil(#self._reward / 5)
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return listSize.width, size.height
	end

	local function cellAtIndex(table, idx)
		local bar = table:dequeueCell()

		if bar == nil then
			bar = cc.TableViewCell:new()

			for i = 1, 5 do
				local itemIdx = idx * 5 + i

				if itemIdx <= #self._reward then
					local itemCell = self._itemCell:clone()

					itemCell:setSwallowTouches(false)
					itemCell:setPosition(cc.p(39 + (size.width + 55) * (i - 1), -20 * idx - 20))
					bar:addChild(itemCell, 0, i)
					self:updataCell(itemCell, itemIdx)
				end
			end
		end

		return bar
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:addTo(self._listView)
	tableView:reloadData()
	tableView:setBounceable(false)

	self._tableView = tableView
end

function ActivityReturnLetterRewardMediator:updataCell(cell, index)
	local rewardData = self._reward[index]
	local iconPanel = cell:getChildByFullName("icon")
	local name = cell:getChildByFullName("name")

	iconPanel:removeAllChildren()

	local icon = IconFactory:createRewardIcon(rewardData, {
		isWidget = true,
		showAmount = true
	})

	icon:setScaleNotCascade(0.8)
	icon:addTo(iconPanel):center(icon:getContentSize()):offset(-9, -9)
	IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
		needDelay = true
	})
	name:setString(RewardSystem:getName(rewardData))
end

function ActivityReturnLetterRewardMediator:onClickReward()
	if self._callback then
		self._callback()
	end

	self:close()
end

function ActivityReturnLetterRewardMediator:onClickBack()
	self:close()
end
