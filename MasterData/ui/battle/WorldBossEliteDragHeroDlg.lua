-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\WorldBossEliteDragHeroDlg.lua

local DragPlane = require("UI/Control/Com/DragPlane")
local MultiDragHeroDlg = require("UI/Battle/MultiDragHeroDlg")
local UserData = require("Helper/UserData")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local MultiHeroScrollCell = require("UI/Battle/MultiHeroScrollCell")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResMonster = require("ClientData/ResMonster")
local Monster = require("Common/Object/Monster")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResWorldBossMisc = require("ClientData/ResWorldBossMisc")
local strClassName = "WorldBossEliteDragHeroDlg"
local WorldBossEliteDragHeroDlg = Class(strClassName, MultiDragHeroDlg)

function WorldBossEliteDragHeroDlg:ctor(...)
	return
end

function WorldBossEliteDragHeroDlg:_initUI(...)
	self.MAX_TEAM_NUM = 2

	self.listHeros:initHeroList(MultiHeroScrollCell, "System/Hero/GridHeroCard")

	self.btnQuickBattle = UIControls.Button(self, "BtnSkip")
	self.textQuick = UIControls.Label(self, "BtnSkip/Text")

	self.btnQuickBattle:addEventClick(self.onBtnQuickBattle)
	self.btnQuickBattle:setVisible(false)

	self.btnRecommendForm = UIControls.Button(self, "BtnRecommend")

	self.btnRecommendForm:setVisible(false)

	self.panelNumLimit = UIControls.Panel(self, "SpePanel/SpeLimit")

	self.panelNumLimit:setVisible(true)

	self.textNumLimit = UIControls.Label(self, "SpePanel/SpeLimit/TextNum")
	self.teamBtns = {}
	self.panelTeam = UIControls.Panel(self, "TeamPanel")

	self.panelTeam:setVisible(true)

	for index = 1, self.MAX_TEAM_NUM do
		local newButton = UIControls.Button(self, "TeamPanel/BtnTeam" .. index)

		newButton:addEventClick(self.onTeamSelect)

		newButton.teamIndex = index

		newButton:setVisible(true)
		table.insert(self.teamBtns, newButton)
	end
end

function WorldBossEliteDragHeroDlg:_initTeamFormation(...)
	self.multiTeamsIndex = self.battlePreInfo.worldBossData.multiTeamsIndex or {}
	self.teamFormations = {}
	self.teamPets = {}

	if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		for index = 1, self.MAX_TEAM_NUM do
			if self.multiTeamsIndex[index] then
				self.teamFormations[index] = utils.copyTable(CurAvatar:getNowFormation(self.multiTeamsIndex[index]))
				self.teamPets[index] = utils.copyTable(CurAvatar:getFormationOtherInfo(self.multiTeamsIndex[index]))
			end
		end
	end

	if self:checkSameFormationHero() then
		if self:checkSameFormationPet() then
			self.teamPets[2] = {}
		end

		MsgManager.notice(Lang.get(101657))

		self.teamFormations[2] = {}

		self:onTeamSelect(self.teamBtns[2])

		return
	elseif self:checkSameFormationPet() then
		MsgManager.notice(Lang.get(101658))

		self.teamPets[2] = {}

		self:onTeamSelect(self.teamBtns[2])

		return
	end

	self:onTeamSelect(self.teamBtns[1])
end

function WorldBossEliteDragHeroDlg:refreshRedDot(...)
	return
end

function WorldBossEliteDragHeroDlg:handleSpecBattle()
	self.strQuickBattleTip = Lang.get(60948)

	if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS and self.battlePreInfo.worldBossData.layer == 3 then
		self:setBtnQuickState(self.battlePreInfo.worldBossData.checkQuickFightOpen, true)

		self.strQuickBattleTip = string.format(ResClientNotice[766].notice, ResWorldBossMisc[1].hard_time_limit)
	end
end

function WorldBossEliteDragHeroDlg:setBtnQuickState(isShow, specialShow)
	local btnImageName, textColorR
	local isShowedQuickBtn = UserData.loadCommonData(CurAvatar.uid .. BattleConst.INFO_SHOW_QUICK_BTN) == "1"

	local function setBtnData(btnImageName, textColorR)
		local colorRGB = textColorR / 255

		self.btnQuickBattle:setImage("Atlas/CommonAtlas/BtnAtlas2", btnImageName)
		self.textQuick:setColorByRGBA(colorRGB, colorRGB, colorRGB)

		self.canSkipBattle = isShow

		self.btnQuickBattle:setVisible(true)
	end

	if isShow then
		setBtnData("BtnCommonSec00Nml", 106)

		if not isShowedQuickBtn then
			UserData.saveCommonData(CurAvatar.uid .. BattleConst.INFO_SHOW_QUICK_BTN, "1")
		end
	elseif isShowedQuickBtn or specialShow then
		setBtnData("BtnCommonSec01Dis", 60)
	end
end

function WorldBossEliteDragHeroDlg:refreshTeamObjects()
	local isOnlyClearPlayer = true

	if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS and self.battlePreInfo and self.battlePreInfo.worldBossData.eliteMode and self.battlePreInfo.worldBossData.multiPveId[self.selectTeam] then
		isOnlyClearPlayer = false
	end

	DragPlane.clearObject(isOnlyClearPlayer)
	DragPlane.startObjEntering()

	if not isOnlyClearPlayer then
		self:refreshMonObjects(self.battlePreInfo.worldBossData.multiPveId[self.selectTeam])
	end

	local teams = self.teamFormations[self.selectTeam]

	for gid, pos in pairs(teams) do
		local hero = CurAvatar.heroDic[gid]

		if hero then
			DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
		end
	end

	self:updateHeroBag()
	self:refreshPetObject()
	self:updatePlayerCampEnhance()
	self:updateMonsterCampEnhance()
	self:refreshWearRedDot()
end

function WorldBossEliteDragHeroDlg:refreshMonObjects(id)
	local battleData = ResBattleConfig[id] or {}

	DragPlane.resetTrap(battleData)

	local friends = battleData.friends or {}
	local monsterLevel = battleData.monster_level or 1
	local monsters = {}

	for pos, monsterID in ipairs(battleData.monsters or {}) do
		if ResMonster[monsterID] then
			monsters[pos] = {
				monsterID,
				monsterLevel
			}
		end
	end

	for pos, monsterInfo in pairs(monsters) do
		local monster = Monster(monsterInfo[1], monsterInfo[2])

		pos = -pos

		if monster.mazeHp ~= 0 then
			local obj = DragPlane.addDragObj(false, monster, pos, BattleConst.CAMP_MONSTER)
		end
	end
end

function WorldBossEliteDragHeroDlg:onBtnCloseClick(sender)
	local result = {}

	for pos, obj in pairs(DragPlane.fieldObjs) do
		if pos > 0 and obj.hero then
			table.insert(result, {
				idx = pos,
				gid = obj.hero.gid
			})
		end
	end

	if self.teamFormations then
		self:saveNowFormation()
		self:saveFormationToServer()
	end

	self:exit()
end

function WorldBossEliteDragHeroDlg:_updateHeroBag()
	self.textNumLimit:setText(DragPlane.getObjectEnableNum())
	self:refreshWearRedDot()
end

function WorldBossEliteDragHeroDlg:checkSameFormationPet()
	if not self.teamPets then
		return false
	end

	local flag = false
	local hash = {}

	for _, v in ipairs(self.teamPets) do
		if v.petId and v.petId ~= 0 then
			if hash[v.petId] then
				flag = true

				break
			end

			hash[v.petId] = true
		end
	end

	return flag
end

function WorldBossEliteDragHeroDlg:checkSameFormationHero()
	if not self.teamFormations then
		return false
	end

	local flag = false
	local tables = {}

	for i = 1, #self.teamFormations do
		if self.teamFormations[i] then
			table.insert(tables, self.teamFormations[i])
		end
	end

	if not tables then
		return flag
	end

	local cache_table = {}

	for _, v in ipairs(tables) do
		for gid, pos in pairs(v) do
			if cache_table[gid] then
				flag = true

				break
			end

			cache_table[gid] = true
		end
	end

	return flag
end

function WorldBossEliteDragHeroDlg:saveFormationToServer(saveType)
	local res = {}

	for index, formationIdx in pairs(self.multiTeamsIndex) do
		local petId

		if self.teamPets[index] then
			petId = self.teamPets[index].petId or nil
		end

		res[index] = {
			item = {
				hero = {},
				pet = petId
			},
			pos = formationIdx
		}

		for gid, pos in pairs(self.teamFormations[index] or {}) do
			if pos > 0 then
				table.insert(res[index].item.hero, {
					idx = pos,
					gid = gid
				})
			end
		end
	end

	RPC.formationsUpdateByPos(res)
end

function WorldBossEliteDragHeroDlg:onBtnQuickBattle(sender)
	if not self.canSkipBattle then
		MsgManager.notice(self.strQuickBattleTip)
	else
		self.quickMode = true

		self:_onConfirm()
	end
end

function WorldBossEliteDragHeroDlg:_onConfirm(...)
	local isEmpty, minIndex = self:haveEmptyTeam()

	if self.battlePreInfo.type == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		if WorldBossCommon.isInFrozenTime() then
			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ClientUtils.getClientNotice(279), Slot(self.onBtnCloseClick, self))
		end

		if isEmpty == true then
			MsgManager.clientNotice(261)
			self:onTeamSelect(self.teamBtns[minIndex])

			return
		end

		local isLessTeam, minIndex = self:haveLessTeam()

		if isLessTeam == true then
			local function cancelFunc(...)
				self:onTeamSelect(self.teamBtns[minIndex])
			end

			local function confirmFunc(...)
				self:startBattle()
			end

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(259), confirmFunc, cancelFunc)

			return
		end

		self:startBattle()
	end
end

function WorldBossEliteDragHeroDlg:_RealStartBattle()
	if self:checkSameFormationHero() then
		if self:checkSameFormationPet() then
			self.teamPets[2] = {}
		end

		MsgManager.notice(Lang.get(101657))

		self.teamFormations[2] = {}

		self:onTeamSelect(self.teamBtns[2])

		return
	elseif self:checkSameFormationPet() then
		MsgManager.notice(Lang.get(101658))

		self.teamPets[2] = {}

		self:onTeamSelect(self.teamBtns[2])

		return
	end

	self:saveFormationToServer()

	local specData = {}
	local world_boss = {}

	if self.battlePreInfo.worldBossData then
		world_boss.is_mode_two = self.battlePreInfo.worldBossData.eliteMode and 1 or 0
		world_boss.team = 1
		world_boss.type = self.battlePreInfo.worldBossData.type
		world_boss.hard = self.battlePreInfo.worldBossData.layer
		world_boss.week_index = self.battlePreInfo.worldBossData.week_index
	end

	specData.world_boss = world_boss

	RPC.pVEStart(self.battlePreInfo.type, specData)
	CurAvatar:battleMiscReq()

	if self.quickMode then
		GameFsm.getCurState():onQuickEndGame()
	else
		UIManager.getUI("battleStartWorldBossEliteDlg1", true)
	end

	self:setVisible(false)
end

return WorldBossEliteDragHeroDlg
