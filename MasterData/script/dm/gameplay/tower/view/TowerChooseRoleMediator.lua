-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerChooseRoleMediator.lua

TowerChooseRoleMediator = class("TowerChooseRoleMediator", DmAreaViewMediator, _M)

TowerChooseRoleMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")
TowerChooseRoleMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.Button_rule"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRule"
	}
}
local kCellWidth = 350

function TowerChooseRoleMediator:initialize()
	super.initialize(self)
end

function TowerChooseRoleMediator:dispose()
	super.dispose(self)
end

function TowerChooseRoleMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()
end

function TowerChooseRoleMediator:enterWithData()
	self:initData()
	self:initView()
end

function TowerChooseRoleMediator:resumeWithData()
	self:refreshData()
	self:refreshView()
end

function TowerChooseRoleMediator:initData()
	self._curSelectMasterId = nil
	self._preSelectIdx = nil
	self._cells = {}

	self:getData()
end

function TowerChooseRoleMediator:initView(data)
	if not self._masterList then
		return
	end

	self:bindWidgets()
	self:setupTopInfoWidget(data)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:initWidgetInfo(data)
	self:createTableView()
end

function TowerChooseRoleMediator:refreshData()
	self:getData()
end

function TowerChooseRoleMediator:refreshView()
	self._tableView:stopScroll()
	self._tableView:reloadData()
end

function TowerChooseRoleMediator:getData(...)
	self._data = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())

	if not self._data then
		return
	end

	self._masterList = self._data:getInitMasters()
end

function TowerChooseRoleMediator:bindWidgets()
	self:bindWidget("main.sure_btn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickSure, self)
		}
	})
end

function TowerChooseRoleMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_LEAVETIME_CHANGE, self, self.resumeWithData)
end

function TowerChooseRoleMediator:setupTopInfoWidget(data)
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local var_13_0 = {
		style = 1,
		currencyInfo = {
			CurrencyIdKind.kDiamond,
			CurrencyIdKind.kPower,
			CurrencyIdKind.kCrystal,
			CurrencyIdKind.kGold
		},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}

	var_13_0.title = Strings:get(self._data:getTowerBase():getConfig().Name)

	local config = var_13_0
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	local button_rule = self:getView():getChildByFullName("main.Button_rule")

	button_rule:setPositionX(self._topInfoWidget:getTitleWidth() + 20)
end

function TowerChooseRoleMediator:initWidgetInfo(data)
	self._main = self:getView():getChildByName("main")
	self._backgroundBG = self._main:getChildByName("backgroundBG")
	self._sure_btn = self._main:getChildByName("sure_btn")
	self._scrollView = self._main:getChildByName("scrollView")
	self._roleClone = self._main:getChildByName("roleClone")

	self._roleClone:setVisible(false)
	self._sure_btn:setGray(true)
	GameStyle:setCommonOutlineEffect(self._main:getChildByFullName("Text_ChooseRole"))
end

function TowerChooseRoleMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function TowerChooseRoleMediator:didFinishResumeTransition()
	local winSize = cc.Director:getInstance():getWinSize()
	local transitionView = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), winSize.width, winSize.height)

	transitionView:addTo(self:getView())
	transitionView:center(cc.size(1136, 640))
	transitionView:runAction(cc.Sequence:create(cc.FadeTo:create(0.1, 0), cc.CallFunc:create(function()
		transitionView:removeFromParent(true)
	end)))
end

function TowerChooseRoleMediator:createTableView()
	local tableViewLayer = self._main:getChildByName("tableView")
	local viewSize = tableViewLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function tableViewDidScroll(table)
		if table:isTouchMoved() then
			self:touchMovedTableView()
		end
	end

	local function numberOfCells(view)
		return #self._masterList
	end

	local function cellTouched(table, cell)
		self:onClickCell(cell)
	end

	local function cellSize(table, idx)
		return kCellWidth, viewSize.height
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setContentSize(cc.size(kCellWidth, viewSize.height))
		end

		self:addCell(cell, idx)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(tableViewLayer)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:setMaxBounceOffset(0)
	tableView:reloadData()

	self._tableView = tableView
end

function TowerChooseRoleMediator:addCell(cell, idx)
	cell:removeAllChildren()

	local panel = self._roleClone:clone()

	panel:setName("panel")
	panel:setVisible(true)
	panel:addTo(cell):posite(0, 0)
	GameStyle:setCommonOutlineEffect(panel:getChildByFullName("Text_147_0_0"))
	GameStyle:setCommonOutlineEffect(panel:getChildByFullName("Text_147_1"))

	local data = self._masterList[idx + 1]
	local detail = panel:getChildByFullName("Button_Details")

	detail.data = data

	detail:addClickEventListener(function(sender)
		self:onClickDetails(sender)
	end)

	local info = {
		frameId = "bustframe4_1",
		id = data:getModel()
	}
	local masterIcon = IconFactory:createRoleIconSpriteNew(info)

	masterIcon:setAnchorPoint(cc.p(0, 0))
	masterIcon:setPosition(cc.p(0, 0))
	panel:getChildByFullName("Panel_role_image"):addChild(masterIcon)
	masterIcon:setScale(1)
	panel:getChildByFullName("Text_name"):setString(data:getName())
	panel:getChildByFullName("Text_desc"):setString(data:getFeature())
	self:addSkill(panel, data)
	panel:getChildByFullName("Image_select"):setVisible(self._curSelectMasterId == data:getId())

	self._cells[idx] = cell
end

function TowerChooseRoleMediator:addSkill(panel, data)
	local panelSkill = panel:getChildByFullName("Panel_skill")

	panelSkill:setTouchEnabled(true)
	panelSkill:setSwallowTouches(true)
	panelSkill:addClickEventListener(function()
		self:onClickMasterSkill(data)
	end)
	panelSkill:removeAllChildren()

	local skills = data:getSkillList()

	for i = 1, #skills do
		local skill = skills[i]

		if skill then
			local skillId = skill:getId()
			local info = {
				levelHide = true,
				id = skillId,
				skillType = skill:getSkillType()
			}
			local newSkillNode = IconFactory:createMasterSkillIcon(info)

			newSkillNode:setScale(0.33)
			newSkillNode:addTo(panelSkill)
			newSkillNode:setPosition(cc.p(12 + 46 * (i - 1), 15))
		end
	end
end

function TowerChooseRoleMediator:onClickMasterSkill(data)
	local params = {
		towerMaster = true,
		master = data
	}
	local view = self:getInjector():getInstance("MasterLeaderSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, params))
end

function TowerChooseRoleMediator:onClickDetails(sender)
	local master = sender.data
	local params = {
		master = master,
		towerData = self._data
	}

	self._towerSystem:showMasterDetailsView(params)
end

function TowerChooseRoleMediator:onClickCell(cell)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local idx = cell:getIdx()
	local data = self._masterList[idx + 1]

	if self._curSelectMasterId == data:getId() then
		return
	end

	if self._preSelectIdx then
		self._cells[self._preSelectIdx]:getChildByFullName("panel.Image_select"):setVisible(false)
	end

	self._preSelectIdx = idx
	self._curSelectMasterId = data:getId()

	self._cells[idx]:getChildByFullName("panel.Image_select"):setVisible(true)
	self._sure_btn:setGray(false)
	self._towerSystem:setCurMasterId(self._curSelectMasterId)
end

function TowerChooseRoleMediator:touchMovedTableView()
	return
end

function TowerChooseRoleMediator:onClickSure(sender, eventType)
	if not self._curSelectMasterId then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Tower_LeaderChoice_Text")
		}))

		return
	end

	self._towerSystem:requestEnterTowerRolesCombat()
end

function TowerChooseRoleMediator:onClickRule()
	local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Tower_1_RuleText", "content")
	local view = self:getInjector():getInstance("ExplorePointRule")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Rule,
		ruleReplaceInfo = {
			time = TimeUtil:getSystemResetDate()
		}
	}))
end
