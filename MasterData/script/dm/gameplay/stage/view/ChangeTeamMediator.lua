-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/ChangeTeamMediator.lua

ChangeTeamMediator = class("ChangeTeamMediator", DmPopupViewMediator, _M)

ChangeTeamMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
ChangeTeamMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function ChangeTeamMediator:initialize()
	super.initialize(self)
end

function ChangeTeamMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function ChangeTeamMediator:onRemove()
	super.onRemove(self)
end

function ChangeTeamMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._main = self:getView():getChildByName("main")
	self._listPanel = self._main:getChildByName("masterList")
	self._masterClone = self._main:getChildByName("heroPanel")

	self._masterClone:setVisible(false)
	self._masterClone:setTouchEnabled(false)

	self._Image_stencil = self._main:getChildByName("Image_stencil")

	local bgNode = self._main:getChildByFullName("tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Stage_Team_UI16"),
		title1 = Strings:get("UITitle_EN_Chuangjianxinbiandui"),
		bgSize = {
			width = 828,
			height = 605
		}
	})
	self:bindWidget("main.sureBtn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickSure, self)
		}
	})
end

function ChangeTeamMediator:enterWithData(data)
	self._curTeamId = data.teamId
	self._callBack = data.callBack
	self._masterList = self._masterSystem:getShowMasterList()
	self._curMasterId = self._masterList[1]:getId()
	self._maxTeamPetNum = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Init_DeckNum", "content") + self._developSystem:getBuildingCardEffValue()
	self._costMaxNum = self._stageSystem:getCostInit() + self._developSystem:getBuildingCostEffValue()

	self:initView()
end

function ChangeTeamMediator:initView()
	local cellWidth = self._masterClone:getContentSize().width
	local cellHeight = self._masterClone:getContentSize().height

	local function cellSizeForTable(table, idx)
		if idx == 0 then
			return cellWidth - 10, cellHeight
		elseif idx + 1 == #self._masterList then
			return cellWidth + 10, cellHeight
		end

		return cellWidth - 20, cellHeight
	end

	local function numberOfCellsInTableView(table)
		return #self._masterList
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()
		end

		self:createMaster(cell, idx + 1)

		return cell
	end

	local tableView = cc.TableView:create(self._listPanel:getContentSize())

	tableView:setTag(1234)

	self._masterView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._listPanel:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
end

function ChangeTeamMediator:createMaster(cell, index)
	cell:removeAllChildren()

	local data = self._masterList[index]
	local layer = self._masterClone:clone()

	layer:setVisible(true)
	layer:addTo(cell)
	layer:setPosition(cc.p(0, 0))

	if index == 1 then
		layer:setPosition(cc.p(10, 0))
	end

	layer:getChildByName("selected"):setVisible(self._curMasterId == data:getId())

	local info = {
		frameId = "bustframe1",
		id = data:getModel()
	}
	local rolePic = IconFactory:createRoleIconSpriteNew(info)

	if rolePic then
		rolePic:addTo(layer)
		rolePic:setPosition(layer:getChildByName("bg"):getPosition())
		layer:getChildByName("touchLayer"):setTouchEnabled(not data:getIsLock())
		layer:getChildByName("touchLayer"):setSwallowTouches(false)
		layer:getChildByName("touchLayer"):addClickEventListener(function()
			self:onTouchChooseView(data:getId())
		end)

		local color = data:getIsLock() and cc.c3b(195, 195, 195) or cc.c3b(255, 255, 255)

		layer:setColor(color)
	end

	local node = cc.Node:create()

	node:addTo(layer):posite(90, 80)
	node:removeAllChildren()

	local id, lv = self._masterSystem:getMasterLeadStatgeLevel(data:getId())
	local icon = IconFactory:createLeadStageIconVer(id, lv, {
		needBg = 1
	})

	if icon then
		icon:addTo(node)
	end
end

function ChangeTeamMediator:onTouchChooseView(masterId)
	AudioEngine:getInstance():playEffect("Se_Click_Tab_1", false)

	self._curMasterId = masterId

	local offsetX = self._masterView:getContentOffset().x

	self._masterView:reloadData()
	self._masterView:setContentOffset(cc.p(offsetX, 0))
end

function ChangeTeamMediator:onClickClose()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:close()
end

function ChangeTeamMediator:getSendData()
	local heroList = self._stageSystem:getNotOnTeamPet({})
	local orderPets = self._heroSystem:getTeamPrepared({}, heroList)
	local showOrderPets = {}
	local cost = 0

	for i = 1, #orderPets do
		local heroCost = self._heroSystem:getHeroById(orderPets[i]):getCost()

		if #showOrderPets < self._maxTeamPetNum and cost + heroCost <= self._costMaxNum then
			cost = cost + heroCost
			showOrderPets[#showOrderPets + 1] = orderPets[i]
		end
	end

	local sendData = {}
	local hasHero = false

	for k, v in pairs(showOrderPets) do
		sendData[k] = {}
		sendData[k].id = v
		hasHero = true
	end

	return {
		type = 0,
		teamId = self._curTeamId,
		masterId = self._curMasterId,
		heros = sendData
	}
end

function ChangeTeamMediator:onClickSure()
	local params = self:getSendData()

	self._stageSystem:requestChangeTeam(params, function()
		if self._callBack then
			self._callBack()
		end

		self:close()
	end)
end
