-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\ActivityPvpDragHeroDlg.lua

local DragPlane = require("UI/Control/Com/DragPlane")
local MultiDragHeroDlg = require("UI/Battle/MultiDragHeroDlg")
local PVPCommon = require("Logic/PVP/PVPCommon")
local DragHeroMixin = require("UI/Battle/DragHeroMixin")
local strClassName = "ActivityPvpDragHeroDlg"
local ActivityPvpDragHeroDlg = Class(strClassName, MultiDragHeroDlg)

function ActivityPvpDragHeroDlg:ctor(...)
	return
end

function ActivityPvpDragHeroDlg:_initUI(...)
	ActivityPvpDragHeroDlg.super._initUI(self)
end

function ActivityPvpDragHeroDlg:_initTeamFormation()
	self.teamFormations = {}
	self.teamPets = {}

	local ketStr

	if self.battleType == BattleConst.BATTLE_TYPE_OPACT_PVP then
		ketStr = "FORMATION_OPACTPVP_ATTACK_"

		local formation = CurAvatar:getNowFormation(Const.FORMATION_OPACTPVP_ATTACK_1)

		if formation == nil or next(formation) == nil then
			ketStr = "FORMATION_OPACTPVP_DEFEND_"
		end
	else
		ketStr = "FORMATION_OPACTPVP_DEFEND_"

		local hideMode = CurAvatar:getPVPArenaFormationHideMode()

		for i, btn in ipairs(self.teamBtns) do
			btn.imgHide:setVisible(hideMode and hideMode[i] and hideMode[i].hide == 1)
		end
	end

	for i = 1, 3 do
		self.teamFormations[i] = utils.copyTable(CurAvatar:getNowFormation(Const[ketStr .. i]))
		self.teamPets[i] = utils.copyTable(CurAvatar:getFormationOtherInfo(Const[ketStr .. i]))
	end

	self:onTeamSelect(self.teamBtns[self.battlePreInfo.opactPvpData.formationIndex or 1])
end

function ActivityPvpDragHeroDlg:refreshTeamObjects()
	DragPlane.clearObject()
	DragPlane.startObjEntering()

	local teams = self.teamFormations[self.selectTeam]

	for gid, pos in pairs(teams) do
		local hero = CurAvatar.heroDic[gid]

		if hero then
			DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
		end
	end

	if self.battlePreInfo.type == BattleConst.BATTLE_TYPE_OPACT_PVP then
		if self.enemyFormations == nil then
			self.enemyFormations = {}

			for i, info in ipairs(self.battlePreInfo.opactPvpData.formation) do
				local heroInfo = utils.getFormationHeros(info.data)

				table.insert(self.enemyFormations, heroInfo)
			end
		end

		local teams = self.enemyFormations[self.selectTeam] or {}

		for i, hero in ipairs(teams) do
			DragPlane.addDragObj(false, hero, -hero.pos, BattleConst.CAMP_MONSTER)
		end
	end

	self:refreshPetObject()
	self:updatePlayerCampEnhance()
	self:refreshWearRedDot()
end

function ActivityPvpDragHeroDlg:onSwitchTeam()
	self:saveNowFormation()

	local switchDlg = UIManager.getUI("multiDragSwitchDlg", nil, false)

	switchDlg = switchDlg or UIManager.getUI("multiDragSwitchDlg", true)

	if self.battleType == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM then
		switchDlg:onShow(self.teamFormations, nil, self.battleType, self.teamPets)
	else
		switchDlg:onShow(self.teamFormations, self.battlePreInfo.opactPvpData.formation, self.battleType, self.teamPets)
	end
end

function ActivityPvpDragHeroDlg:saveFormationToServer(saveType)
	if self.battlePreInfo.type == BattleConst.BATTLE_TYPE_OPACT_PVP then
		saveType = Const.FORMATION_TYPE_OPACTPVP_ATTACK
	elseif self.battlePreInfo.type == BattleConst.FORMATION_TYPE_OPACT_PVP then
		saveType = Const.FORMATION_TYPE_OPACTPVP_DEFEND
	end

	local result = {}

	for i, info in ipairs(self.teamFormations) do
		local data = {
			hero = {}
		}

		for gid, pos in pairs(info) do
			table.insert(data.hero, {
				idx = pos,
				gid = gid
			})
		end

		if self.teamPets[i] and self.teamPets[i].petId then
			data.pet = self.teamPets[i].petId
		end

		table.insert(result, data)
	end

	RPC.formationsUpdateByType(saveType, result)
end

function ActivityPvpDragHeroDlg:isSameFormation()
	for i = 1, 3 do
		local formation = CurAvatar:getNowFormation(Const["FORMATION_OPACTPVP_DEFEND_" .. i])
		local isSame = true
		local preCount = utils.getTableElemCount(formation)
		local nowCount = 0

		for gid, pos in pairs(self.teamFormations[i]) do
			if pos > 0 then
				nowCount = nowCount + 1

				if formation[gid] and formation[gid] == pos then
					-- block empty
				else
					isSame = false

					break
				end
			end
		end

		if isSame and nowCount == preCount then
			-- block empty
		else
			return false
		end
	end

	return true
end

function ActivityPvpDragHeroDlg:_onConfirm(...)
	local isEmpty, minIndex = self:haveEmptyTeam()

	if self.battlePreInfo.type == BattleConst.FORMATION_TYPE_OPACT_PVP then
		if isEmpty == true then
			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ClientUtils.getClientNotice(258))

			return
		end

		self:saveFormationToServer()
		MsgManager.notice(Lang.get(30126))
		self:exit()
	elseif self.battlePreInfo.type == BattleConst.BATTLE_TYPE_OPACT_PVP then
		if isEmpty == true then
			MsgManager.clientNotice(261)
			self:onTeamSelect(self.teamBtns[minIndex])

			return
		end

		local isLessTeam, minIndex = self:haveLessTeam()

		if isLessTeam == true then
			if ClientUtils.record.opactPvpTeamLessTip == true then
				local function cancelFunc(...)
					self:onTeamSelect(self.teamBtns[minIndex])
				end

				local function confirmFunc(...)
					local isNoTip = self.confirmui:getToggleState()

					if isNoTip == true then
						ClientUtils.record.opactPvpTeamLessTip = false
					end

					self:startBattle()
				end

				UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ClientUtils.getClientNotice(259), confirmFunc, cancelFunc)

				self.confirmui = UIManager.getUI("confirmui", nil, false)

				self.confirmui:showToggle(nil, false)
			else
				self:startBattle()
			end

			return
		end

		self:startBattle()
	end
end

function ActivityPvpDragHeroDlg:startBattle()
	local checkHeroEquipOK = self:checkHeroEquipWear()

	if not checkHeroEquipOK then
		UIManager.showConfirmWithId(1044, nil, Slot(self._RealStartBattle, self))
	else
		self:_RealStartBattle()
	end
end

function ActivityPvpDragHeroDlg:_RealStartBattle()
	self:saveFormationToServer()

	local specData = {}
	local data = {}
	local actId = CurAvatar:getPVPArenaActivityOpId()

	if actId then
		data.act_id = actId
	end

	data.target_uid = self.battlePreInfo.opactPvpData.pvpId
	specData.arena = {
		data = data
	}

	RPC.pVEStart(self.battleType, specData)
	CurAvatar:battleMiscReq()
	UIManager.getUI("battleStartMultiDlg", true):setRound(1)
	self:setVisible(false)
end

return ActivityPvpDragHeroDlg
