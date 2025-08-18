-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazePreviewBossDlg.lua

local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResNewMazeBattle = require("ClientData/ResNewMazeBattle")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local Monster = require("Common/Object/Monster")
local strClassName = "NewMazePreviewBossDlg"
local NewMazePreviewBossDlg = Class(strClassName, UIControls.Window)

function NewMazePreviewBossDlg:ctor()
	self:initUI()
end

function NewMazePreviewBossDlg:initUI()
	self.gridHeroPortrait = UIControls.Role(self, "BgPanel/GridHeroPortrait", 0, 0)
	self.textDes = UIControls.Label(self, "BgPanel/TextDes")
	self.btnMoreMonster = UIControls.Button(self, "BgPanel/MonsterList/BtnMoreMonster")

	self.btnMoreMonster:addEventClick(self.onBtnMoreMonsterClick)

	self.monsterCells = {}
end

function NewMazePreviewBossDlg:setData()
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		self.newMazeData = self.actObj.actData
	else
		return
	end

	if not self.newMazeData.previewBossData or #self.newMazeData.previewBossData == 0 then
		return
	end

	self.curPreviewBossData = self:getCurBossData()
	self.curPreviewBossEventId = self.curPreviewBossData.spec_id
	self.curPreviewBossLayer = self.curPreviewBossData.layer
	self.battleId = ResNewMazeBattle[self.curPreviewBossEventId].battle_id
	self.bossId = ResNewMazeBattle[self.curPreviewBossEventId].boss_port_id or 3210702
	self.battleConfig = ResBattleConfig[self.battleId]
	self.monsterObjs = {}

	local monsters = self.battleConfig.monsters

	for pos, monsterId in ipairs(monsters) do
		if monsterId and monsterId ~= 0 then
			local newMonster = Monster(monsterId, 220)

			table.insert(self.monsterObjs, newMonster)
		end
	end

	local needCount = 0

	if #self.monsterObjs <= 5 then
		needCount = #self.monsterObjs

		self.btnMoreMonster:setVisible(false)
	else
		self.btnMoreMonster:setVisible(true)

		needCount = 5
	end

	self:_initMonsters(needCount, self.monsterCells, "BgPanel/MonsterList")
	self.gridHeroPortrait:showRole(self.bossId)
	self.textDes:setText(string.format(ResNewMazeDisplay[13060071].desc, self.curPreviewBossLayer))
end

function NewMazePreviewBossDlg:getCurBossData()
	table.sort(self.newMazeData.previewBossData, function(a, b)
		return a.layer < b.layer
	end)

	for i, v in ipairs(self.newMazeData.previewBossData or {}) do
		if self.newMazeData.layer <= v.layer then
			return v
		end
	end
end

function NewMazePreviewBossDlg:_initMonsters(needCount, pool, path)
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

function NewMazePreviewBossDlg:onBtnMoreMonsterClick()
	UIManager.getUI("onceTowerMonsterDlg", true):onShow(self.monsterObjs or {})
end

return NewMazePreviewBossDlg
