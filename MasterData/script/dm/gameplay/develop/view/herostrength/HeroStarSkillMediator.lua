-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStarSkillMediator.lua

HeroStarSkillMediator = class("HeroStarSkillMediator", DmPopupViewMediator, _M)

HeroStarSkillMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function HeroStarSkillMediator:initialize()
	super.initialize(self)
end

function HeroStarSkillMediator:dispose()
	super.dispose(self)
end

function HeroStarSkillMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.refreshView)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._bgWidget = bindWidget(self, "main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Hero_Star_UI_Preview_SC"),
		title1 = Strings:get("Hero_Star_UI_Preview_EN"),
		bgSize = {
			width = 837,
			height = 574
		}
	})
end

function HeroStarSkillMediator:enterWithData(data)
	self:initData(data)
	self:initView()
	self:createCellHeight()
	self:initTableView()
end

function HeroStarSkillMediator:initData(data)
	self._heroId = data.heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._starAttrs = self._heroData:getStarAttrs()
	self._starAttrsTemp = {}

	for i = 1, #self._starAttrs do
		local params = self._starAttrs[i]

		if params.star then
			local param = params.star

			if params.star == 7 then
				param = Strings:get("AWAKE_TITLE")
			elseif params.star > 7 then
				param = Strings:get("Hero_IA_UI_Effect_Desc", {
					star = params.star - 7
				})
			end

			table.insert(self._starAttrsTemp, {
				attrType = "star",
				star = params.star,
				desc = Strings:get("Hero_Star_UI_Effect_Desc", {
					star = param
				})
			})
		end

		if params.info then
			for index = 1, #params.info do
				local value = params.info[index]

				if value.isHide == 0 then
					table.insert(self._starAttrsTemp, value)
				end
			end
		end
	end

	self._nodes = {}
	self._selectTab = 1
end

function HeroStarSkillMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._cloneSkill = self._main:getChildByFullName("cloneSkill")

	self._cloneSkill:setVisible(false)

	self._cloneTitle = self._main:getChildByFullName("cloneTitle")

	self._cloneTitle:setVisible(false)

	self._viewPanel = self._main:getChildByFullName("panel")
end

function HeroStarSkillMediator:initTableView()
	self._cellWidth = self._cloneSkill:getContentSize().width

	local function scrollViewDidScroll(view)
		if self._ignoreSlide then
			return
		end

		local maxOffset = view:minContainerOffset().y
		local y = view:getContentOffset().y

		for i = 1, #self._cellHeights do
			local index = #self._cellHeights - i + 1

			if index == 1 then
				if y == maxOffset and self._selectTab ~= index then
					self._selectTab = index
				end
			else
				local offsetY = self._cellHeights[index] + maxOffset - self._cloneTitle:getContentSize().height

				if offsetY <= y and self._selectTab ~= index then
					self._selectTab = index
				end
			end
		end
	end

	local function cellSizeForTable(table, idx)
		local width, height = self._cellWidth, self._cellsHeight[idx + 1]

		return width, height
	end

	local function numberOfCellsInTableView(table)
		return #self._starAttrsTemp
	end

	local function tableCellAtIndex(table, idx)
		local index = idx + 1
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		cell:setTag(index)
		self:createTeamCell(cell, index)

		return cell
	end

	local tableView = cc.TableView:create(self._viewPanel:getContentSize())

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	tableView:setBounceable(false)
	self._viewPanel:addChild(tableView)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:reloadData()
end

function HeroStarSkillMediator:createTeamCell(cell, index)
	local children = cell:getChildren()

	for i = 1, #children do
		children[i]:setVisible(false)
	end

	local child = cell:getChildByTag(index)

	if not child then
		local node = self._nodes[index]

		if node then
			node:changeParent(cell):posite(0, 0)
			node:setVisible(true)
		end
	else
		child:setVisible(true)
	end
end

function HeroStarSkillMediator:createCellHeight()
	self._cellHeights = {}
	self._cellsHeight = {}

	local addHeight = 0

	for index = 1, #self._starAttrsTemp do
		local data = self._starAttrsTemp[index]
		local height = 0

		if data.attrType == "star" then
			local node = self._cloneTitle:clone()

			node:addTo(self:getView())
			node:getChildByFullName("title"):setString(data.desc)

			height = node:getContentSize().height

			if index ~= 1 then
				height = height + 8
			end

			self._nodes[index] = node
			self._cellsHeight[index] = height
		else
			local node = self._cloneSkill:clone()

			node:addTo(self:getView())

			local bg = node:getChildByFullName("bg")
			local icon = node:getChildByFullName("icon")

			if data.attrType == "attr" then
				local image = ccui.ImageView:create(data.path, 1)

				image:addTo(icon):center(icon:getContentSize())
			elseif data.attrType == "skill" then
				local image = IconFactory:createHeroSkillIcon({
					levelHide = true,
					id = data.skillId
				})

				image:addTo(icon):center(icon:getContentSize())
				image:setScale(0.6)

				if data.isEXSkill then
					local str = cc.Label:createWithTTF(Strings:get("Hero_Star_UI_Ex"), TTF_FONT_FZYH_R, 16)

					str:addTo(icon):center(icon:getContentSize()):offset(-2, -16)
					str:enableOutline(cc.c4b(0, 0, 0, 255), 2)
				end
			end

			local name = node:getChildByFullName("name")

			name:setString(data.name)

			local desc = node:getChildByFullName("desc")
			local descWidth = desc:getContentSize().width

			desc:setString("")

			local label = ccui.RichText:createWithXML(data.desc, {})

			label:addTo(desc)
			label:renderContent(descWidth, 0)
			label:setAnchorPoint(cc.p(0, 0.5))
			label:setPosition(cc.p(0, desc:getContentSize().height / 2))

			local sizeH = math.max(97, label:getContentSize().height + 20)

			bg:setContentSize(cc.size(bg:getContentSize().width, sizeH))

			height = sizeH - 20

			node:setContentSize(cc.size(node:getContentSize().width, sizeH - 20))
			icon:setPositionY(height / 2 + 2)
			name:setPositionY(height / 2 + 3)
			desc:setPositionY(height / 2 + 5)

			self._nodes[index] = node
			self._cellsHeight[index] = height
		end

		addHeight = addHeight + height

		if data.attrType == "star" then
			table.insert(self._cellHeights, addHeight)
		end
	end
end

function HeroStarSkillMediator:refreshData()
	self._reward = self._starRewards[self._selectTab]
end

function HeroStarSkillMediator:refreshView()
	if self._tableView then
		local maxOffset = self._tableView:minContainerOffset().y

		self._tableView:setContentOffset(cc.p(0, self._selectTab == 1 and maxOffset or self._cellHeights[self._selectTab] + maxOffset - self._cloneTitle:getContentSize().height))
	end
end

function HeroStarSkillMediator:onClickBack()
	self:close()
end
