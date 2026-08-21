-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\MazeDragHeroDlg.lua

local DragPlane = require("UI/Control/Com/DragPlane")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local BattleConst = require("Common/FrameBattle/BattleConst")
local HeroGridBloodCard = require("UI/Maze/HeroGridBloodCard")
local ResMazeMisc = require("ClientData/ResMazeMisc")
local CampEnhanceInfoPanel = require("UI/Battle/CampEnhanceInfoPanel")
local ResClientNotice = require("ClientData/ResClientNotice")
local DragHeroMixin = require("UI/Battle/DragHeroMixin")
local HeroEquipInfoPanel = require("UI/MainState/HeroEquipInfoPanel")
local MazeHeroScrollCell = Class("MazeHeroScrollCell", HeroGridBloodCard)

function MazeHeroScrollCell:ctor()
	self.checkHeroEnhance = true
end

local function getMazeNowNum()
	local num = CurAvatar.mazeHeroNum or 0

	for pos, dragObj in pairs(DragPlane.fieldObjs) do
		if dragObj.hero and (dragObj.hero.mazeStatus == 0 or dragObj.hero.mazeStatus == nil) then
			num = num + 1
		end
	end

	return num
end

function MazeHeroScrollCell:onDragGet(sender)
	if self.hero.mazeStatus == 0 or self.hero.mazeStatus == nil then
		local num = getMazeNowNum()

		if num >= self.mWindow:getMazeMaxHeroNum() then
			MsgManager.notice(string.format(Lang.get(30150), self.mWindow:getMazeMaxHeroNum()))

			return
		end
	elseif self.hero.mazeStatus == 1 then
		MsgManager.clientNotice(150)

		return
	end

	local obj = DragPlane.addDragObj(true, self.hero, nil, BattleConst.CAMP_PLAYER)

	DragPlane.showBlock(obj, self.hero)

	if self.selectCallback then
		self.selectCallback(self)
	end
end

function MazeHeroScrollCell:setSelected(isSelected)
	self.beSelected = isSelected
end

local strClassName = "MazeDragHeroDlg"
local MazeDragHeroDlg = Class(strClassName, UIControls.Window)

MixinClass(MazeDragHeroDlg, DragHeroMixin)

function MazeDragHeroDlg:ctor()
	local modeStr = UserData.loadCommonData(BattleConst.INFO_SHOW_TIPS)

	if modeStr == "1" then
		DragPlane.showTips = true
	else
		DragPlane.showTips = false
	end

	self:initUI()
end

function MazeDragHeroDlg:_initUI()
	self.textNum = UIControls.Label(self, self.HERO_LIST_PATH .. "/LimitPanel/TextNum")

	if self.campLimit then
		self.listHeros:initHeroList(MazeHeroScrollCell, "System/Hero/GridHeroCardBlood", UIConst.HERO_MAZE_SORT_MAP_HP, UIConst.HERO_MAZE_FILTER_PANEL_NO_CAMP_MAP)
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
		self.listHeros:initHeroList(MazeHeroScrollCell, "System/Hero/GridHeroCardBlood", UIConst.HERO_MAZE_SORT_MAP_HP, UIConst.HERO_MAZE_FILTER_PANEL_MAP)
	end

	self.panelNumLimit = UIControls.Panel(self, "SpePanel/SpeLimit")

	self.panelNumLimit:setVisible(true)

	self.textNumLimit = UIControls.Label(self, "SpePanel/SpeLimit/TextNum")
end

function MazeDragHeroDlg:_updateHeroBag()
	self.textNum:setText(getMazeNowNum() .. "/" .. self:getMazeMaxHeroNum())
	self.textNumLimit:setText(DragPlane.getObjectEnableNum())
end

function MazeDragHeroDlg:onBattleConfirm(sender)
	local result = {}

	for pos, obj in pairs(DragPlane.fieldObjs) do
		if pos > 0 and obj.hero then
			table.insert(result, {
				idx = pos,
				gid = obj.hero.gid
			})
		end
	end

	if #result < 1 then
		MsgManager.clientNotice(148)

		return
	end

	local function ConfirmBattleFormation()
		if #result > 0 then
			RPC.formationUpdate(Const.FORMATION_MAZE, result, self.nowSelectPetId)
		end

		local specData = {}

		specData.maze = {
			branch_index = self.battlePreInfo.mazeData.branchIndex
		}

		RPC.pVEStart(self.battlePreInfo.type, specData)
		CurAvatar:battleMiscReq()
		UIManager.getUI("battleStartDlg", true)
		self:setVisible(false)
	end

	local nodeType = ClientUtils.GetMazeNodeBranchType(self.battlePreInfo.mazeData.baseData, self.battlePreInfo.mazeData.branchIndex)

	if nodeType == Const.MAZE_DIE_BATTLE_NODE then
		UIManager.showConfirmWithId(1003, ConfirmBattleFormation)

		return
	elseif nodeType == Const.MAZE_BLOOD_BATTLE_NODE then
		UIManager.showConfirmWithId(1004, ConfirmBattleFormation)

		return
	end

	ConfirmBattleFormation()
end

function MazeDragHeroDlg:getMazeMaxHeroNum(...)
	if self.maxHeroNum == nil then
		self.maxHeroNum = CurAvatar:getMazeHeroLimit()
	end

	return self.maxHeroNum
end

return MazeDragHeroDlg
