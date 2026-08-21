-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeNodePanelMixin.lua

local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResRandClient = require("ClientData/ResRandClient")
local ResMazeNodeConfig = require("ClientData/ResMazeNodeConfig")
local Monster = require("Common/Object/Monster")
local BattleConst = require("Common/FrameBattle/BattleConst")
local MazeNodePanelMixin = {}

function MazeNodePanelMixin:ctorMixin(...)
	self:initCommonUI()
end

function MazeNodePanelMixin:initCommonUI(...)
	self.btnFunc = UIControls.Button(self, "FrontPanel/BtnFunc", "Text")

	self.btnFunc:addEventClick(self.onBtnFuncClick)

	self.txtTips = UIControls.Label(self, "BackPanel/TextTips")
	self.txtFrontLv = UIControls.Label(self, "FrontPanel/TextLv")
	self.txtBackLv = UIControls.Label(self, "BackPanel/TextLv")
end

function MazeNodePanelMixin:initMonsterUI(...)
	self.panelMonster = UIControls.Panel(self, "FrontPanel/MonsterPanel/MonsterList")
	self.panelMoreMonster = UIControls.Panel(self, "FrontPanel/MoreMonsterPanel")
	self.btnMoreMonster = UIControls.Button(self, "FrontPanel/MonsterPanel/BtnMoreMonster")

	self.btnMoreMonster:addEventClick(self.onBtnMoreMonsterClick)

	self.btnSensor = UIControls.Button(self, "FrontPanel/BtnSensor")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.monsterCells = {}
	self.moreMonsterCells = {}
end

function MazeNodePanelMixin:setDataMixin(branchData, branchIndex, baseData, isNextChangeNode)
	self.branchData = branchData
	self.branchIndex = branchIndex
	self.baseData = baseData
	self.isNextChangeNode = isNextChangeNode

	self.txtTips:setText(ResMazeNodeConfig[branchData.type].desc)
end

function MazeNodePanelMixin:setNodeInfo(infoTxt)
	self.txtFrontLv:setText(infoTxt)
	self.txtBackLv:setText(infoTxt)
end

function MazeNodePanelMixin:initMonsters(...)
	self.monsterObjs = {}

	local info = CurAvatar.mazeData.battle_cache[self.branchIndex]
	local pveId = 1111111

	if info ~= nil then
		pveId = info.id
	end

	local battleConfig = ResBattleConfig[pveId or 1] or {}

	self.battleConfig = battleConfig

	local monsters = battleConfig.monsters or {}

	for pos, monsterId in ipairs(monsters) do
		if monsterId and monsterId ~= 0 then
			local newMonster = Monster(monsterId, math.max(1, CurAvatar.mazeData.level + (self.baseData.level_offset or 0)))

			table.insert(self.monsterObjs, newMonster)
		end
	end

	local needCount = 0

	if #self.monsterObjs <= 4 then
		needCount = #self.monsterObjs

		self.btnMoreMonster:setVisible(false)
	else
		self.btnMoreMonster:setVisible(true)
		self:_initMonsters(#self.monsterObjs, self.moreMonsterCells, "FrontPanel/MoreMonsterPanel/MonsterList")

		needCount = 3
	end

	self:_initMonsters(needCount, self.monsterCells, "FrontPanel/MonsterPanel/MonsterList")
end

function MazeNodePanelMixin:_initMonsters(needCount, pool, path)
	local preCount = 1

	for idx, cell in ipairs(pool) do
		preCount = preCount + 1

		if idx <= needCount then
			cell:setVisible(true)
			cell.setObj(self.monsterObjs[idx])
		else
			cell:setVisible(false)
		end
	end

	for i = preCount, needCount do
		local newCell = UIControls.MonsterCardChild(self, path, "System/Common/Grid/GridMonster")

		table.insert(pool, newCell)
		newCell:setVisible(true)
		newCell:setObj(self.monsterObjs[i])
	end
end

function MazeNodePanelMixin:initAward(randId, path)
	path = path or "FrontPanel/AwardPanel/AwardList"

	local bonus = ResRandClient[randId] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}

	self.itemGrids = {}

	local id, num
	local hasExtra = CurAvatar:hasPrivilegeType(Const.PRIVITY_KEY_EBONUS_MAZE)

	for i = 1, #showNums do
		local newGrid = UIControls.getGridContainer(self, path)

		if showIds[i] then
			num = showNums[i]
			id = showIds[i]

			local extraValue = 0

			if hasExtra then
				extraValue = CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_EBONUS_MAZE, num, true)
			end

			if id == Const.MONEY_ID_MAZE then
				num = math.floor(CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_MAZE_COIN, num))
			elseif id == Const.MONEY_ID_GOLD then
				num = math.floor(CurAvatar:getPrivilegeValue(Const.PRIVITY_KEY_MAZE_GOLD, num))
			end

			num = num + extraValue

			local clientItem = BaseObject.GetObject(id, num)

			newGrid:setObj(clientItem)

			newGrid.grid.mDisableWays = true

			newGrid:setVisible(true)
		end

		table.insert(self.itemGrids, newGrid)
	end
end

function MazeNodePanelMixin:onBtnSensorClick(...)
	self.btnSensor:setVisible(false)
	self.panelMoreMonster:setVisible(false)
end

function MazeNodePanelMixin:onBtnMoreMonsterClick(...)
	self.btnSensor:setVisible(true)
	self.panelMoreMonster:setVisible(true)
end

function MazeNodePanelMixin:onBtnFuncClick(...)
	return
end

function MazeNodePanelMixin:battleFunc(...)
	local info = CurAvatar.mazeData.battle_cache[self.branchIndex]

	if info == nil then
		self.mWindow:hide()

		return
	end

	self.mWindow:setBattleState()

	local pveId = info.id
	local battleData = {}

	battleData.mazeData = {}
	battleData.mazeData.branchIndex = self.branchIndex
	battleData.mazeData.baseData = self.baseData

	CurAvatar:enterFormation(pveId, BattleConst.BATTLE_TYPE_MAZE, battleData)
end

function MazeNodePanelMixin:awardFunc(...)
	self.mWindow:hide()
	MsgManager.notice(Lang.get(30572))

	for _, itemGrid in ipairs(self.itemGrids) do
		if itemGrid:getVisible() then
			itemGrid.grid:flyToCommonFuncEntryPanel()
		end
	end

	RPC.mazeSelectBranch(self.branchIndex)

	if self.isNextChangeNode and CurAvatar:isMazeFirstPass() then
		UIManager.getUI("mazeFirstPassDlg", true):show()
	end
end

return MazeNodePanelMixin
