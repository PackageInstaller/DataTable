-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rank/view/RankRewardTipsMediator.lua

RankRewardTipsMediator = class("RankRewardTipsMediator", DmPopupViewMediator, _M)

RankRewardTipsMediator:has("_towerSystem", {
	is = "rw"
}):injectWith("TowerSystem")

local kBtnHandlers = {}

function RankRewardTipsMediator:initialize()
	super.initialize(self)
end

function RankRewardTipsMediator:dispose()
	super.dispose(self)
end

function RankRewardTipsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function RankRewardTipsMediator:enterWithData(data)
	self._data = data.data
	self._rankType = data.rankType

	if data.maxLimitNum then
		self._maxLimitNum = data.maxLimitNum or 50
	end

	self:initView()
	self:createTableView()
end

function RankRewardTipsMediator:initView()
	self:getView():getChildByFullName("main.title"):setString(Strings:get("RankRuleUI_5"))

	self._listView = self:getView():getChildByFullName("main.listview")

	self._listView:setVisible(false)

	self._emptyTip = self:getView():getChildByFullName("main.emptyTip")
	self._contentPanel = self:getView():getChildByFullName("main.content_panel")

	self._contentPanel:setVisible(false)
end

function RankRewardTipsMediator:initContent()
	self._listView:setScrollBarEnabled(false)
	self._listView:removeAllChildren(true)

	for i = 1, #self._data do
		local panel = self._contentPanel:clone()

		panel:setVisible(true)
		self._listView:pushBackCustomItem(panel)

		local data = self._data[i]
		local iconPanel = panel:getChildByFullName("image_icon")

		if self._rankType == RankType.kClub then
			local icon = IconFactory:createClubIcon({
				id = data.headImg
			})

			icon:addTo(iconPanel):center(iconPanel:getContentSize()):offset(0, 0)
			icon:setScale(0.6)
		else
			local headIcon, oldIcon = IconFactory:createPlayerIcon({
				clipType = 4,
				id = data.headImg,
				headFrameId = data.headFrame
			})

			headIcon:addTo(iconPanel):center(iconPanel:getContentSize())
			oldIcon:setScale(0.4)
			headIcon:setScale(0.6)
		end

		panel:getChildByFullName("rank"):setString(tostring(i))

		if RankTopImage[i] then
			panel:getChildByFullName("Image_14"):loadTexture(RankTopImage[i], 1)
		end

		panel:getChildByFullName("Image_14"):setVisible(RankTopImage[i] and true or false)
		panel:getChildByFullName("rank"):setString(tostring(i))
		panel:getChildByFullName("title"):setString(data.nickname)

		local tb = TimeUtil:localDate("*t", data.time * 0.001)

		panel:getChildByFullName("content"):setString(string.format("%d/%02d/%02d     %2d:%02d:%02d", tb.year, tb.month, tb.day, tb.hour, tb.min, tb.sec))
	end
end

function RankRewardTipsMediator:onClickBack()
	self:close()
end

function RankRewardTipsMediator:createTableView()
	local listLocator = self._listView
	local clonePanel = self._contentPanel
	local viewSize = listLocator:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	if #self._data > self._maxLimitNum then
		if not self._maxLimitNum then
			local numberCells = #self._data

			local function numberOfCells(view)
				return numberCells > 50 and 50 or numberCells
			end

			local function cellTouched(table, cell)
				return
			end

			local function cellSize(table, index)
				local viewSize = clonePanel:getContentSize()

				return viewSize.width, viewSize.height
			end

			local function cellAtIndex(tableView, index)
				index = index + 1

				local cell = tableView:dequeueCell()

				if cell == nil then
					cell = cc.TableViewCell:new()

					local realCell = clonePanel:clone()

					realCell:setPosition(2, 0)
					realCell:setVisible(true)
					realCell:setSwallowTouches(false)
					realCell:setName("realCell")
					cell:addChild(realCell)
				end

				local data = self._data[index]

				self:updataCell(cell, data, index)

				return cell
			end

			local function onScroll()
				return
			end

			tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
			tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
			tableView:setPosition(listLocator:getPosition())
			tableView:setDelegate()
			listLocator:getParent():addChild(tableView)
			tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
			tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
			tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
			tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
			tableView:registerScriptHandler(onScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
			tableView:reloadData()

			self.bestTableView = tableView
		end
	end
end

function RankRewardTipsMediator:updataCell(cell, data, index)
	local panel = cell:getChildByFullName("realCell")
	local iconPanel = panel:getChildByFullName("image_icon")

	if self._rankType == RankType.kClub then
		local icon = IconFactory:createClubIcon({
			id = data.headImg
		})

		icon:addTo(iconPanel):center(iconPanel:getContentSize()):offset(0, 0)
		icon:setScale(0.6)
	else
		local headIcon, oldIcon = IconFactory:createPlayerIcon({
			clipType = 4,
			id = data.headImg,
			headFrameId = data.headFrame
		})

		headIcon:addTo(iconPanel):center(iconPanel:getContentSize())
		oldIcon:setScale(0.4)
		headIcon:setScale(0.6)
	end

	panel:getChildByFullName("rank"):setString(tostring(index))

	if RankTopImage[index] then
		panel:getChildByFullName("Image_14"):loadTexture(RankTopImage[index], 1)
	end

	panel:getChildByFullName("Image_14"):setVisible(RankTopImage[index] and true or false)
	panel:getChildByFullName("rank"):setString(tostring(index))
	panel:getChildByFullName("title"):setString(data.nickname)

	local tb = TimeUtil:localDate("*t", data.time * 0.001)

	panel:getChildByFullName("content"):setString(string.format("%d/%02d/%02d     %2d:%02d:%02d", tb.year, tb.month, tb.day, tb.hour, tb.min, tb.sec))
end
