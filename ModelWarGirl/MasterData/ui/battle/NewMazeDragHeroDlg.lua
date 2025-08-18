-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\NewMazeDragHeroDlg.lua

local DragPlane = require("UI/Control/Com/DragPlane")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local ResNewMazeBattle = require("ClientData/ResNewMazeBattle")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local BattleConst = require("Common/FrameBattle/BattleConst")
local DragHeroMixin = require("UI/Battle/DragHeroMixin")
local HeroGridSolderCard = require("UI/NewMaze/HeroGridSolderCard")
local NewMazeLosderTipsInfoPanel = require("UI/NewMaze/NewMazeLosderTipsInfoPanel")
local NewMazeLosderGrid = require("UI/NewMaze/NewMazeLosderGrid")
local DebuffGrid = require("UI/NewMaze/DebuffGrid")
local DebuffTipsInfoPanel = require("UI/NewMaze/DebuffTipsInfoPanel")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeFetters = require("ClientData/ResNewMazeFetters")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local NewMazeHeroScrollCell = Class("NewMazeHeroScrollCell", HeroGridSolderCard)

function NewMazeHeroScrollCell:ctor()
	self.checkHeroEnhance = true
end

local function getNewMazeNowNum()
	local num = 0

	for pos, dragObj in pairs(DragPlane.fieldObjs) do
		if dragObj.hero then
			num = num + 1
		end
	end

	return num
end

function NewMazeHeroScrollCell:onDragGet(sender)
	local obj = DragPlane.addDragObj(true, self.hero, nil, BattleConst.CAMP_PLAYER)

	DragPlane.showBlock(obj, self.hero)

	if self.selectCallback then
		self.selectCallback(self)
	end
end

function NewMazeHeroScrollCell:onDragClick(sender)
	local tips = UIManager.getUI("battleDragHeroTips")

	tips:show(self)
	tips:correctPos(true)

	if self.selectCallback then
		self.selectCallback(self)
	end
end

function NewMazeHeroScrollCell:setSelected(isSelected)
	self.beSelected = isSelected
end

local strClassName = "NewMazeDragHeroDlg"
local NewMazeDragHeroDlg = Class(strClassName, UIControls.Window)

MixinClass(NewMazeDragHeroDlg, DragHeroMixin)

function NewMazeDragHeroDlg:ctor()
	local modeStr = UserData.loadCommonData(BattleConst.INFO_SHOW_TIPS)

	if modeStr == "1" then
		DragPlane.showTips = true
	else
		DragPlane.showTips = false
	end

	self:initUI()
end

function NewMazeDragHeroDlg:_initUI()
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj and self.actObj:isValid() then
		self.newMazeData = self.actObj.actData
	else
		return
	end

	local allHeros = self.newMazeData:initAllHeros()

	self.hasHeroCount = #allHeros

	if self.campLimit then
		self.listHeros:initHeroList(NewMazeHeroScrollCell, "System/Hero/GridHeroCardSolder", nil, UIConst.HERO_DEFAULT_FILTER_PANEL_MAP, allHeros)
		self.listHeros:setHeroAttrFilter({
			{
				"camp",
				self.campLimit
			},
			{
				"specialCamp",
				self.campLimit
			}
		})
	else
		self.listHeros:initHeroList(NewMazeHeroScrollCell, "System/Hero/GridHeroCardSolder", nil, UIConst.HERO_NO_CAMP_FILTER_PANEL_MAP, allHeros)
	end

	self.targetPanel = UIControls.Panel(self, "TargetPanel")
	self.textTitle = UIControls.Label(self, "TargetPanel/Target1/TextTitle")
	self.panelNumLimit = UIControls.Panel(self, "SpePanel/SpeLimit")

	self.panelNumLimit:setVisible(true)

	self.textNumLimit = UIControls.Label(self, "SpePanel/SpeLimit/TextNum")
	self.losderPanel1 = UIControls.Panel(self, "LosderPanel1")
	self.losderPanel = UIControls.Panel(self, "LosderPanel")
	self.awardDeBuffPanel = UIControls.Panel(self, "BtnModeChange/AwardDeBuffPanel")
	self.debuffTipPanel = UIControls.Panel(self, "BtnModeChange/AwardDeBuffPanel/DeBuffTipsPanel")
	self.uIClickThrough2 = UIControls.Button(self, "BtnModeChange/AwardDeBuffPanel/DeBuffTipsPanel/UIClickThrough")

	self.uIClickThrough2:addEventClick(self.onUIClickThroughClick)

	self.panelTrapShow = UIControls.Panel(self, "TrapInfoShowPanel")
	self.textTrapShowName = UIControls.Label(self, "TrapInfoShowPanel/TextName")
	self.textTrapShowDesc = UIControls.Label(self, "TrapInfoShowPanel/TextEffect")
	self.buffCells = {}
	self.fettersCellList = {}

	self:getController():SetInAnimName("ShowTeamSetMainTrap")
end

function NewMazeDragHeroDlg:_updateHeroBag()
	self.textNumLimit:setText(DragPlane.getObjectEnableNum())
end

function NewMazeDragHeroDlg:setLosderPanel()
	local tisPanelPath = "LosderPanel/LosderTipsPanel"

	self.cellPath = "LosderPanel/LosderList/Content"

	if self.battlePreInfo.newMazeData.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.SpecialFight then
		local eventId = self.battlePreInfo.newMazeData.eventId

		self.losderPanel:setVisible(false)
		self.losderPanel1:setVisible(true)

		tisPanelPath = "LosderPanel1/LosderTipsPanel"
		self.cellPath = "LosderPanel1/LosderList/Content"

		local battleId = ResNewMazeBattle[eventId].battle_id or 0
		local targetId = ResBattleConfig[battleId].target_id

		if ResBattleTarget[targetId] then
			local targetDesc = ResBattleTarget[targetId].targets[1].desc

			self.targetPanel:setVisible(true)
			self.textTitle:setText(targetDesc)
		else
			self.targetPanel:setVisible(false)
		end
	else
		self.losderPanel:setVisible(true)
		self.losderPanel1:setVisible(false)

		tisPanelPath = "LosderPanel/LosderTipsPanel"
		self.cellPath = "LosderPanel/LosderList/Content"
	end

	self.losderTipsPanel = UIControls.Panel(self, tisPanelPath)
	self.uIClickThrough1 = UIControls.Button(self, tisPanelPath .. "/UIClickThrough")

	self.uIClickThrough1:addEventClick(self.onUIClickThroughClick)

	if self.losderTipsInfoPanel == nil then
		self.losderTipsInfoPanel = NewMazeLosderTipsInfoPanel(self, tisPanelPath, "System/Rogue/LosderTipsInfoPanel")
	end

	self:initDebuff()
	self.textTrapShowName:setText(ResNewMazeDisplay[13060021].desc or "")

	local eventId = self.battlePreInfo.newMazeData.eventId
	local effectDescId = ResNewMazeBattle[eventId].need_settle == 1 and 13060077 or 13060022

	self.textTrapShowDesc:setText(ResNewMazeDisplay[effectDescId].desc or "")
	self.panelTrapShow:setVisible(true)
end

function NewMazeDragHeroDlg:refreshFettersUI()
	local formation = {}

	for pos, obj in pairs(DragPlane.fieldObjs) do
		if pos > 0 and obj.hero then
			formation[obj.hero.gid] = pos
		end
	end

	local cellPath = "LosderPanel/LosderList/Content"

	if self.battlePreInfo.newMazeData.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.SpecialFight then
		cellPath = "LosderPanel1/LosderList/Content"
	end

	local lastAllFetters = self.allFetters or {}

	self.allFetters = self.newMazeData:getAllFetters(formation)

	for i, fetters in pairs(self.allFetters or {}) do
		local fettersCell = self.fettersCellList[i]

		if fettersCell == nil then
			fettersCell = NewMazeLosderGrid(self, cellPath, "System/Common/Grid/GridLosder", 0, 0, true)
		end

		fettersCell:setData(fetters)
		fettersCell:setGridClick(Slot(self.gridLosderClick, self))

		self.fettersCellList[i] = fettersCell
	end

	local curDragHeroFetters = {}

	for _, fetter in ipairs(lastAllFetters) do
		for _, nowFetter in ipairs(self.allFetters or {}) do
			if fetter.type == nowFetter.type then
				if fetter.formationNum < nowFetter.formationNum then
					table.insert(curDragHeroFetters, fetter.type)
				end

				break
			end
		end
	end

	for i, cell in ipairs(self.fettersCellList) do
		if utils.tableIsContainsElement(curDragHeroFetters, cell.fettersType) then
			cell:playEfx()
		end
	end
end

function NewMazeDragHeroDlg:gridLosderClick(grid)
	self.losderTipsInfoPanel:setData(grid.fettersData, grid.fettersTableData)
	self.losderTipsPanel:setVisible(true)
	self.losderTipsInfoPanel:setVisible(true)

	for i, cell in pairs(self.fettersCellList) do
		cell.imgSel:setVisible(grid.fettersType == cell.fettersType)
	end
end

function NewMazeDragHeroDlg:initDebuff()
	if self.newMazeData.nextFightBuff then
		self.awardDeBuffPanel:setVisible(true)

		if self.buffGrid == nil then
			self.buffGrid = DebuffGrid(self, "BtnModeChange/AwardDeBuffPanel/DeBuffPanel", "System/Common/Grid/GridDeBuff", 0, 0, true)
		end

		self.buffGrid:setData(self.newMazeData.nextFightBuff)
		self.buffGrid:setClickCallBack(Slot(self.onClickDebuff, self))

		if self.debuffTipInfoPanel == nil then
			self.debuffTipInfoPanel = DebuffTipsInfoPanel(self, "BtnModeChange/AwardDeBuffPanel/DeBuffTipsPanel", "System/Common/Tips/DeBuffTipsInfoPanel")
		end
	else
		self.awardDeBuffPanel:setVisible(false)
	end
end

function NewMazeDragHeroDlg:onClickDebuff(grid)
	self.debuffTipInfoPanel:setData(grid.buffId)
	self.debuffTipPanel:setVisible(true)
	self.debuffTipInfoPanel:setVisible(true)
end

function NewMazeDragHeroDlg:onBattleConfirm(sender)
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		-- block empty
	else
		return
	end

	self.result = {}

	local isContainInitHero = false

	for pos, obj in pairs(DragPlane.fieldObjs) do
		if pos > 0 and obj.hero then
			if obj.hero.id == self.actObj.actData.heroId then
				isContainInitHero = true
			end

			table.insert(self.result, {
				idx = pos,
				gid = obj.hero.gid
			})
		end
	end

	if #self.result < 1 then
		MsgManager.clientNotice(148)

		return
	end

	if not isContainInitHero then
		MsgManager.notice(string.format(Lang.get(63154), ResNewMazeHero[self.actObj.actData.heroId].name))

		return
	end

	self.maxHeroNum = self:getNewMazeMaxHeroNum()

	if #self.result < self.maxHeroNum and #self.result < self.hasHeroCount then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(109), Slot(self._RealStartBattle, self))
	else
		self:_RealStartBattle()
	end
end

function NewMazeDragHeroDlg:_RealStartBattle()
	if self.battlePreInfo.newMazeData.fromRandom and self.battlePreInfo.newMazeData.fromRandom == 1 or self.actObj.actData.monsterHpInfo then
		-- block empty
	else
		local curSelectNodeIndex = self.battlePreInfo.newMazeData.curSelectNodeIndex

		RPC.newMazeNodeSelect(self.actObj.opId, self.actObj.actData.layer, curSelectNodeIndex)
	end

	if self.battlePreInfo.newMazeData.eventType == Const.NEW_MAZE_NODE_EVENT_TYPE.BossFight and not self.actObj.actData.hasGotFirstPassAward[self.actObj.actData.ratingLevel] then
		self.actObj.actData.isFirstPassCurLevel = true
	end

	if #self.result > 0 then
		RPC.formationUpdate(Const.FORMATION_NEW_MAZE, self.result, self.nowSelectPetId)
	end

	local specData = {}
	local data = {}

	data.relic = self.actObj.actData.bagRelics

	local halos = {}

	for i, halo in pairs(self.actObj.actData.bagHalos or {}) do
		if halo.is_equip and halo.is_equip == 1 then
			table.insert(halos, {
				id = halo.id
			})
		end
	end

	data.halo = halos

	local fetterTableData = self:handleFetterTableData()
	local fetters = {}

	for i, data in pairs(self.allFetters) do
		if data.type < Const.SPECIAL_FETTERS_TYPE then
			if data.formationNum + #data.halo >= Const.FETTERS_ACTIVE_LEVEL2_NUM then
				local fId = fetterTableData[data.type][2].id

				table.insert(fetters, {
					id = fId
				})
			elseif data.formationNum + #data.halo >= Const.FETTERS_ACTIVE_NUM then
				local fId = fetterTableData[data.type][1].id

				table.insert(fetters, {
					id = fId
				})
			end
		elseif data.formationNum >= Const.CAREER_MAX_NUM and #data.formationHeros == 6 then
			local fettertCareer = 1
			local careerList = {}

			for i, career in pairs(data.formationHeros) do
				if not utils.tableIsContainsElement(careerList, career) then
					table.insert(careerList, career)
				else
					fettertCareer = career

					break
				end
			end

			local fId = fetterTableData[data.type][fettertCareer].id

			table.insert(fetters, {
				id = fId
			})
		elseif data.formationNum >= Const.CAREER_MAX_NUM and #data.formationHeros == 5 then
			local fId = fetterTableData[data.type][99].id

			table.insert(fetters, {
				id = fId
			})
		end
	end

	data.fetter = fetters
	data.is_retry = self.battlePreInfo.newMazeData.isRetry

	if self.actObj.actData.nextFightBuff then
		data.buff = {
			{
				id = self.actObj.actData.nextFightBuff
			}
		}
	else
		data.buff = {}
	end

	specData.new_maze = {
		data = data
	}

	RPC.pVEStart(self.battlePreInfo.type, specData)
	CurAvatar:battleMiscReq()
	UIManager.getUI("battleStartDlg", true)
	self:setVisible(false)
end

function NewMazeDragHeroDlg:handleFetterTableData()
	local fetterTableData = {}

	for _, fdata in pairs(ResNewMazeFetters) do
		if fetterTableData[fdata.type] == nil then
			fetterTableData[fdata.type] = {}
		end

		if fdata.type < Const.SPECIAL_FETTERS_TYPE then
			if fetterTableData[fdata.type][fdata.level] == nil then
				fetterTableData[fdata.type][fdata.level] = {}
			end

			fetterTableData[fdata.type][fdata.level] = fdata
		elseif fdata.career then
			if fetterTableData[fdata.type][fdata.career] == nil then
				fetterTableData[fdata.type][fdata.career] = {}
			end

			fetterTableData[fdata.type][fdata.career] = fdata
		else
			fetterTableData[fdata.type][99] = fdata
		end
	end

	return fetterTableData
end

function NewMazeDragHeroDlg:getNewMazeMaxHeroNum(...)
	if self.maxHeroNum == nil then
		local actData = CurAvatar:getNewMazeActData()

		if actData then
			self.maxHeroNum = actData.miscData.battle_num_max
		end
	end

	return self.maxHeroNum or 6
end

function NewMazeDragHeroDlg:onUIClickThroughClick()
	self.losderTipsInfoPanel:setVisible(false)
	self.losderTipsPanel:setVisible(false)

	if self.debuffTipInfoPanel then
		self.debuffTipPanel:setVisible(false)
		self.debuffTipInfoPanel:setVisible(false)
	end

	for i, cell in pairs(self.fettersCellList) do
		cell.imgSel:setVisible(false)
	end
end

return NewMazeDragHeroDlg
