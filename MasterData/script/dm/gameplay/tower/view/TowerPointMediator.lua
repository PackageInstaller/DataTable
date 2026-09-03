-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerPointMediator.lua

require("dm.gameplay.arena.view.component.ArenaRoleInfoCell")

TowerPointMediator = class("TowerPointMediator", DmAreaViewMediator, _M)

TowerPointMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TowerPointMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
TowerPointMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
TowerPointMediator:has("_arenaSystem", {
	is = "r"
}):injectWith("ArenaSystem")
TowerPointMediator:has("_taskSystem", {
	is = "r"
}):injectWith("TaskSystem")
TowerPointMediator:has("_stageSystem", {
	is = "r"
}):injectWith("StageSystem")
TowerPointMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")

local kTowerPointNum = 8
local kBtnHandlers = {
	button_rule = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRule"
	}
}

function TowerPointMediator:initialize()
	super.initialize(self)
end

function TowerPointMediator:dispose()
	super.dispose(self)
end

function TowerPointMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
	self._customDataSystem = self:getInjector():getInstance(CustomDataSystem)
	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function TowerPointMediator:mapEventListeners()
	return
end

function TowerPointMediator:updateView(event)
	self:createPointView()
	self:refreshProgress()
end

function TowerPointMediator:resumeWithData()
	self:updateData()
	self:updateView()
end

function TowerPointMediator:enterWithData(data)
	self._towerId = data.towerId

	self:updateData()
	self:setupView()
end

function TowerPointMediator:updateData()
	self._towerData = self._towerSystem:getTowerDataById(self._towerId)
	self._data = self._towerData:getMonsters()
end

function TowerPointMediator:setupView()
	self:setupTopInfoWidget()
	self:initWidgetInfo()
	self:createPointView()
	self:refreshProgress()
end

function TowerPointMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfo = {}
	local var_10_0 = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}

	var_10_0.title = Strings:get(self._towerData:getTowerBase():getConfig().Name)

	local config = var_10_0
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function TowerPointMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByName("main")
	self._bossCell = self._mainPanel:getChildByFullName("bossCell")
	self._cellClone = self._mainPanel:getChildByFullName("cellClone")

	self._cellClone:setVisible(false)
end

function TowerPointMediator:createPointView()
	self._cellList = {}

	local scrollLayer = self._mainPanel:getChildByFullName("rolePanel")

	scrollLayer:removeAllChildren()

	for i = 1, kTowerPointNum do
		local cell = self._cellClone:clone()

		cell:setVisible(true)
		cell:addTo(scrollLayer)

		if i <= 4 then
			if not (200 * (i - 1)) then
				local posX = 200 * (i - 5)
				local posY = i <= 4 and 280 or 30

				posX = (i == 3 or i == 4 or i == 7 or i == 8) and posX + 300 or posX

				cell:setPosition(cc.p(posX, posY))

				local touchPanel = cell:getChildByFullName("node.roleNode")

				touchPanel:addClickEventListener(function()
					self:onClickFight(i)
				end)
				cell:getChildByFullName("node.button_battle"):addClickEventListener(function()
					self:onClickFight(i)
				end)
				self:refreshPointCell(cell, i)
			end
		end
	end

	scrollLayer:setLocalZOrder(100)

	local bossIndex = kTowerPointNum + 1

	self:refreshPointCell(self._bossCell, bossIndex)

	local touchPanel = self._bossCell:getChildByFullName("roleNode")

	touchPanel:addClickEventListener(function()
		self:onClickFight(bossIndex)
	end)
	self._bossCell:getChildByFullName("button_battle"):addClickEventListener(function()
		self:onClickFight(9)
	end)
end

function TowerPointMediator:refreshPointCell(panel, index)
	local cell = panel:getChildByFullName("node")

	cell = cell or panel

	local data = self._data[index]
	local win = data:getWin()
	local towerEnemyConfig = data:getTowerEnemy():getConfig()
	local battleIndex = self._towerData:getBattleIndex() + 1
	local num = cell:getChildByFullName("num")

	if num then
		num:setString(data:getIndex() + 1)
	end

	local nameBg = cell:getChildByFullName("nameBg")
	local name = cell:getChildByFullName("name")

	name:setString(Strings:get(towerEnemyConfig.Name))

	if nameBg then
		nameBg:setContentSize(cc.size(name:getAutoRenderWidth() + 19, 41))
	end

	local color = win and cc.c3b(200, 200, 200) or cc.c3b(255, 255, 255)

	cell:setColor(color)
	panel:getChildByFullName("image_tongguan"):setVisible(win)
	cell:getChildByFullName("button_battle"):setVisible(battleIndex == index)
	cell:getChildByFullName("button_battle.text_battlename"):setString(Strings:get("Tower_1_UI_2"))
	cell:getChildByFullName("bg_sel"):setVisible(battleIndex == index)

	local roleNode = cell:getChildByFullName("roleNode")

	roleNode:removeAllChildren()

	local useAnim = battleIndex == index

	if index == 9 then
		if battleIndex == 9 then
			cell:setLocalZOrder(101)
		end

		local info = {
			useAnim = true,
			frameId = "bustframe6_6",
			id = towerEnemyConfig.PointHead
		}
		local masterIcon = IconFactory:createRoleIconSpriteNew(info)

		masterIcon:setAnchorPoint(cc.p(0.5, 0.5))
		masterIcon:addTo(roleNode):center(roleNode:getContentSize())
		masterIcon:setRotation(-45)
	else
		local s = cc.size(245, 350)
		local m = towerEnemyConfig.PointHead
		local info = {
			frameId = "bustframe7_1",
			id = m,
			useAnim = useAnim
		}
		local masterIcon = IconFactory:createRoleIconSpriteNew(info)

		masterIcon:setAnchorPoint(cc.p(0.5, 0.5))
		masterIcon:addTo(roleNode):center(roleNode:getContentSize()):offset(0, -20)
		masterIcon:setScale(0.7)
	end
end

function TowerPointMediator:refreshProgress()
	return
end

function TowerPointMediator:onClickFight(index, rival)
	if self._towerData:getBattleIndex() + 1 == index then
		self._towerSystem:showTowerTeamBattleView()

		return
	end

	self:dispatch(ShowTipEvent({
		tip = Strings:get("Tower_WrongPoint_Tips", {
			num = self._towerData:getBattleIndex() + 1
		})
	}))
end

function TowerPointMediator:callBack(towerId, data)
	return
end

function TowerPointMediator:onClickRule(sender, eventType, oppoRecord)
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

function TowerPointMediator:onClickBack(sender, eventType)
	self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
		viewName = "TowerMainView"
	}))
end

function TowerPointMediator:leaveWithData()
	self:dispatch(Event:new(EVT_POP_TO_TARGETVIEW, {
		viewName = "TowerMainView"
	}))
end
