-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/heroshow/HeroCardDescMediator.lua

HeroCardDescMediator = class("HeroCardDescMediator", DmPopupViewMediator)

local kCardDesc = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_DetailedExplain", "content")
local kSkillDesc = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SkillExplain", "content")
local kBtnHandlers = {}
local kDescData = {
	card = {
		desc = kCardDesc,
		title = Strings:get("Title_ABILITYEXPLAIN"),
		title1 = Strings:get("Title_ABILITYEXPLAIN_EN")
	},
	skill = {
		desc = kSkillDesc,
		title = Strings:get("Title_SKILLEXPLAIN"),
		title1 = Strings:get("Title_SKILLEXPLAIN_EN")
	}
}

function HeroCardDescMediator:initialize()
	super.initialize(self)
end

function HeroCardDescMediator:dispose()
	super.dispose(self)
end

function HeroCardDescMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local bgNode = self:getView():getChildByFullName("main.bgNode")

	self._bgWidget = bindWidget(self, bgNode, PopupNormalTabWidget, {
		title = "",
		title1 = "",
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		}
	})
end

function HeroCardDescMediator:enterWithData(data)
	self._type = data.type or "card"
	self._showData = kDescData[self._type]

	self:setupView()
	self:initData()
	self:initTableView()
	self:initTabView()
end

function HeroCardDescMediator:setupView()
	self._mainPanel = self:getView():getChildByName("main")
	self._tabpanel = self._mainPanel:getChildByName("tabpanel")
	self._panel = self._mainPanel:getChildByName("panel")
	self._cellPanel = self._mainPanel:getChildByName("cellPanel")

	self._cellPanel:setVisible(false)
	self._cellPanel:getChildByFullName("title"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998))
	self._cellPanel:getChildByFullName("text"):enableOutline(cc.c4b(0, 0, 0, 219.29999999999998))
	self._bgWidget:updateTitle({
		title = self._showData.title,
		title1 = self._showData.title1
	})
end

function HeroCardDescMediator:initData()
	self._curTabType = 1
	self._tabName = {}
	self._tabDesc = {}

	local length = #self._showData.desc

	for i = 1, length do
		local data = self._showData.desc[i]
		local title = Strings:get(data.Title[1])
		local titleEn = Strings:get(data.Title[2])

		self._tabName[i] = {
			title,
			titleEn
		}

		local descs = data.Desc

		self._tabDesc[i] = {}

		for j = 1, #descs do
			local title1 = next(descs[j])
			local desc = descs[j][title1]

			self._tabDesc[i][j] = type(desc) == "string" and {
				title = Strings:get(title1),
				desc = Strings:get(desc)
			} or {
				title = Strings:get(title1),
				imageFile = desc[1],
				desc = Strings:get(desc[2])
			}
		end
	end

	self._curDesc = self._tabDesc[self._curTabType]
	self._nodes = {}
end

function HeroCardDescMediator:initTabView()
	local config = {
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #self._tabName do
		data[#data + 1] = {
			tabText = self._tabName[i][1],
			tabTextTranslate = self._tabName[i][2]
		}
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 500)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		noCenterBtn = true,
		ignoreRedSelectState = true
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabpanel):posite(0, 0)
	view:setLocalZOrder(1100)
end

function HeroCardDescMediator:initTableView()
	self._cellWidth = self._cellPanel:getContentSize().width

	local function cellSizeForTable(table, idx)
		local height = self:getCellHeight(idx + 1)

		return self._cellWidth, height
	end

	local function numberOfCellsInTableView(table)
		return #self._curDesc
	end

	local function tableCellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		cell:setTag(index)
		self:createCell(cell, index)

		return cell
	end

	local tableView = cc.TableView:create(self._panel:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._panel:addChild(tableView)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
end

function HeroCardDescMediator:createCell(cell, index)
	cell:removeAllChildren()

	local node = self._nodes[index]

	if node then
		node:changeParent(cell):posite(0, 0)
		node:setVisible(true)
	end
end

function HeroCardDescMediator:getCellHeight(index)
	local data = self._curDesc[index]
	local cellPanel = self._cellPanel:clone()
	local title = cellPanel:getChildByFullName("title")

	title:setString(data.title)

	local desc = cellPanel:getChildByFullName("text")

	desc:getVirtualRenderer():setDimensions(681, 0)
	desc:setString(data.desc)

	local height = desc:getContentSize().height
	local image = cellPanel:getChildByFullName("image")

	image:setContentSize(cc.size(796, height + 14))

	local panelHeight = height + 27

	cellPanel:setContentSize(cc.size(800, panelHeight))
	title:setPositionY(panelHeight / 2)
	desc:setPositionY(panelHeight / 2)
	image:setPositionY(panelHeight / 2)

	if data.imageFile then
		local file = string.format("asset/heroRect/heroOccupation/%s.png", data.imageFile)
		local image = ccui.ImageView:create(file)

		image:addTo(cellPanel):setPosition(30, title:getPositionY())
		image:setScale(0.5)
		title:offset(40, 0)
		desc:offset(40, 0)
	end

	cellPanel:addTo(self:getView())
	cellPanel:setVisible(false)

	self._nodes[index] = cellPanel

	return panelHeight
end

function HeroCardDescMediator:onClickTab(name, tag)
	if self._curTabType == tag then
		return
	end

	self._curTabType = tag
	self._curDesc = self._tabDesc[self._curTabType]

	self._tableView:stopScroll()
	self._tableView:reloadData()
end

function HeroCardDescMediator:onClickBack()
	self:close()
end
