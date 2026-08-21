-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\MultiDragHeroDlg.lua

local DragPlane = require("UI/Control/Com/DragPlane")
local CommonHeroListPanel = require("UI/Battle/CommonHeroListPanel")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResClientNotice = require("ClientData/ResClientNotice")
local CampEnhanceInfoPanel = require("UI/Battle/CampEnhanceInfoPanel")
local DragHeroMixin = require("UI/Battle/DragHeroMixin")
local HeroEquipInfoPanel = require("UI/MainState/HeroEquipInfoPanel")
local MultiHeroScrollCell = require("UI/Battle/MultiHeroScrollCell")
local strClassName = "MultiDragHeroDlg"
local MultiDragHeroDlg = Class(strClassName, UIControls.Window)

MixinClass(MultiDragHeroDlg, DragHeroMixin)

function MultiDragHeroDlg:ctor()
	self.MAX_TEAM_NUM = 3

	self:initUI()
end

function MultiDragHeroDlg:_initUI()
	self.listHeros:initHeroList(MultiHeroScrollCell, "System/Hero/GridHeroCard")

	self.teamBtns = {}

	for index = 1, self.MAX_TEAM_NUM do
		local newBtn = UIControls.Button(self, "TeamPanel/BtnTeam" .. index)

		newBtn.teamIndex = index
		newBtn.imgHide = UIControls.Image(self, "TeamPanel/BtnTeam" .. index .. "/ImgHide")
		newBtn.imgNew = UIControls.Image(self, "TeamPanel/BtnTeam" .. index .. "/IconNew")

		newBtn:addEventClick(self.onTeamSelect)
		newBtn:setVisible(true)
		table.insert(self.teamBtns, newBtn)
	end

	self.btnSwitch = UIControls.Button(self, "TeamPanel/BtnTeamSwitch")

	self.btnSwitch:addEventClick(self.onSwitchTeam)

	if self.battleType == BattleConst.FORMATION_TYPE_MULTIPVP_DEFEND or self.battleType == BattleConst.FORMATION_TYPE_OPACT_PVP or self.battleType == BattleConst.FORMATION_TYPE_TOP_PVP then
		self.btnClose:setText(Lang.get(330))
	else
		self.btnClose:setText(Lang.get(1505))
	end
end

function MultiDragHeroDlg:onBtnCloseClick(sender)
	if self.battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP or self.battleType == BattleConst.BATTLE_TYPE_OPACT_PVP or self.battleType == BattleConst.BATTLE_TYPE_TOP_PVP_GROUPMATCH then
		self:exit()
	elseif self:isSameFormation() == false and self:haveEmptyTeam() == false then
		local function save(...)
			self:_onConfirm()
		end

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", ResClientNotice[157].notice, save, Slot(self.exit, self))
	else
		self:exit()
	end
end

function MultiDragHeroDlg:exit(...)
	DragPlane.stop()
	UIManager.getUI("battleDragHeroTips", false)
	self:setVisible(false)

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	GameFsm.getCurState():exitBattle()
end

function MultiDragHeroDlg:onOpenOver()
	MultiDragHeroDlg.super.onOpenOver(self)
	self:onListToggle(self.btnListOpen)
end

function MultiDragHeroDlg:isSameFormation()
	for i = 1, self.MAX_TEAM_NUM do
		local formation = CurAvatar:getNowFormation(Const["FORMATION_MULTIPVP_DEFEND_" .. i])
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

function MultiDragHeroDlg:updateHeroBag()
	if not self.teamFormations then
		self:_initTeamFormation()
	end

	local herosField = {}

	for pos, obj in pairs(DragPlane.fieldObjs or {}) do
		if obj.hero and pos > 0 then
			herosField[obj.hero.gid] = true
		end
	end

	for nowIndex, form in ipairs(self.teamFormations) do
		if nowIndex ~= self.selectTeam then
			for gid, pos in pairs(form) do
				herosField[gid] = true
			end
		end
	end

	self.listHeros:updateHeroBag(nil, herosField)
	self:updatePlayerCampEnhance()
	self:_updateHeroBag()
	self:refreshRedDot()
end

function MultiDragHeroDlg:_initTeamFormation()
	self.teamPets = {}
	self.teamFormations = {}

	local ketStr

	if self.battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		ketStr = "FORMATION_MULTIPVP_ATTACK_"

		local formation = CurAvatar:getNowFormation(Const.FORMATION_MULTIPVP_ATTACK_1)

		if formation == nil or next(formation) == nil then
			ketStr = "FORMATION_MULTIPVP_DEFEND_"
		end
	else
		ketStr = "FORMATION_MULTIPVP_DEFEND_"
	end

	for i = 1, 3 do
		self.teamFormations[i] = utils.copyTable(CurAvatar:getNowFormation(Const[ketStr .. i]))
		self.teamPets[i] = utils.copyTable(CurAvatar:getFormationOtherInfo(Const[ketStr .. i]))
	end

	self:onTeamSelect(self.teamBtns[self.battlePreInfo.multiPvpData.formationIndex or 1])
end

function MultiDragHeroDlg:onTeamSelect(sender)
	if self.selectTeam then
		self:saveNowFormation()
	end

	self.selectTeam = sender.teamIndex

	for index, btn in ipairs(self.teamBtns) do
		btn:setEnable(sender ~= btn)
	end

	if self.selectTeam == self.MAX_TEAM_NUM then
		if self.battleType == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM or self.battleType == BattleConst.FORMATION_TYPE_OPACT_PVP or self.battleType == BattleConst.FORMATION_TYPE_RENT_DEFEND or self.battleType == BattleConst.FORMATION_TYPE_TOP_PVP then
			self.btnConfirm:setText(Lang.get(30151))
		else
			self.btnConfirm:setText(Lang.get(699))
		end
	else
		self.btnConfirm:setText(Lang.get(30148))
	end

	self:refreshTeamObjects()
end

function MultiDragHeroDlg:isHeroIdInTeam(heroId)
	for nowIndex, form in ipairs(self.teamFormations) do
		if nowIndex ~= self.selectTeam then
			for gid, pos in pairs(form) do
				local hero = CurAvatar.heroDic[gid]

				if hero and hero.id == heroId then
					return nowIndex
				end
			end
		end
	end
end

function MultiDragHeroDlg:refreshTeamObjects()
	DragPlane.clearObject()
	DragPlane.startObjEntering()

	local teams = self.teamFormations[self.selectTeam]

	for gid, pos in pairs(teams) do
		local hero = CurAvatar.heroDic[gid]

		if hero then
			DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
		end
	end

	if self.battlePreInfo.type == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		if self.enemyFormations == nil then
			self.enemyFormations = {}

			if false and utils.isRobot(self.battlePreInfo.multiPvpData.pvpId) then
				self.enemyFormations = self.battlePreInfo.multiPvpData.formation
			else
				for i, info in ipairs(self.battlePreInfo.multiPvpData.formation) do
					local heroInfo = utils.getFormationHeros(info.data)

					table.insert(self.enemyFormations, heroInfo)
				end
			end
		end

		local teams = self.enemyFormations[self.selectTeam] or {}

		for i, hero in ipairs(teams) do
			DragPlane.addDragObj(true, hero, -hero.pos, BattleConst.CAMP_MONSTER)
		end
	end

	self:refreshPetObject()
	self:updatePlayerCampEnhance()
	self:updateMonsterCampEnhance()
	self:refreshWearRedDot()
end

function MultiDragHeroDlg:saveNowFormation()
	local form = {}

	for pos, obj in pairs(DragPlane.fieldObjs or {}) do
		if obj.hero and pos > 0 then
			form[obj.hero.gid] = pos
		end
	end

	self.teamFormations[self.selectTeam] = form

	local pet = {}

	pet.petId = self.nowSelectPetId
	self.teamPets[self.selectTeam] = pet
end

function MultiDragHeroDlg:_onConfirm(...)
	local isEmpty, minIndex = self:haveEmptyTeam()

	if self.battlePreInfo.type == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM then
		if isEmpty == true then
			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ClientUtils.getClientNotice(258))

			return
		end

		self:saveFormationToServer(Const.FORMATION_TYPE_MULTIPVP_DEFEND)
		MsgManager.notice(Lang.get(30126))
		self:exit()
	elseif self.battlePreInfo.type == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		if isEmpty == true then
			MsgManager.clientNotice(261)
			self:onTeamSelect(self.teamBtns[minIndex])

			return
		end

		local isLessTeam, minIndex = self:haveLessTeam()

		if isLessTeam == true then
			if ClientUtils.record.multiPvpTeamLessTip == true then
				local function cancelFunc(...)
					self:onTeamSelect(self.teamBtns[minIndex])
				end

				local function confirmFunc(...)
					local isNoTip = self.confirmui:getToggleState()

					if isNoTip == true then
						ClientUtils.record.multiPvpTeamLessTip = false
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

function MultiDragHeroDlg:onBattleConfirm(sender)
	if self.selectTeam == self.MAX_TEAM_NUM then
		self:_onConfirm()
	else
		self:onTeamSelect(self.teamBtns[self.selectTeam + 1])
	end
end

function MultiDragHeroDlg:saveFormationToServer(saveType)
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

function MultiDragHeroDlg:refreshRedDot(...)
	local hasCount = CurAvatar:getHeroCount()
	local lessMap
	local allUsedHeroIdMap = {}

	for i = 1, self.MAX_TEAM_NUM do
		local count, usedHeroIdMap = self:getTeamPutCount(i)

		for heroId, state in pairs(usedHeroIdMap) do
			allUsedHeroIdMap[heroId] = state
		end

		hasCount = hasCount - count

		if count < 5 then
			lessMap = lessMap or {}
			lessMap[i] = true
		end
	end

	local canPut = false

	if hasCount > 0 and lessMap ~= nil then
		for gid, hero in pairs(CurAvatar.heroDic) do
			if allUsedHeroIdMap[hero.id] ~= true then
				canPut = true

				break
			end
		end
	end

	for i = 1, self.MAX_TEAM_NUM do
		self.teamBtns[i].imgNew:setVisible(lessMap ~= nil and lessMap[i] == true and canPut)
	end
end

function MultiDragHeroDlg:haveEmptyTeam(...)
	self:saveNowFormation()

	for index = 1, self.MAX_TEAM_NUM do
		if self:isEmpty(index) then
			return true, index
		end
	end

	return false
end

function MultiDragHeroDlg:haveLessTeam(...)
	local hasCount = CurAvatar:getHeroCount()
	local allUsedHeroIdMap = {}
	local minIndex

	for i = self.MAX_TEAM_NUM, 1, -1 do
		local count, usedHeroIdMap = self:getTeamPutCount(i)

		for heroId, state in pairs(usedHeroIdMap) do
			allUsedHeroIdMap[heroId] = state
		end

		hasCount = hasCount - count

		if count < 5 then
			minIndex = i
		end
	end

	if hasCount > 0 and minIndex ~= nil then
		for gid, hero in pairs(CurAvatar.heroDic) do
			if allUsedHeroIdMap[hero.id] ~= true then
				return true, minIndex
			end
		end
	end

	return false
end

function MultiDragHeroDlg:checkHeroEquipWear()
	for nowIndex, form in ipairs(self.teamFormations) do
		if nowIndex ~= self.selectTeam then
			for gid, pos in pairs(form) do
				local hero = CurAvatar.heroDic[gid]

				if hero and (hero:getHeroCanWearEquipEmptyPart() or hero:getHeroCanWearArtifactEmptyPart()) then
					return false
				end
			end
		else
			for pos, obj in pairs(DragPlane.fieldObjs or {}) do
				if obj.hero and pos > 0 and (obj.hero:getHeroCanWearEquipEmptyPart() or obj.hero:getHeroCanWearArtifactEmptyPart()) then
					return false
				end
			end
		end
	end

	return true
end

function MultiDragHeroDlg:getTeamPutCount(index)
	local count = 0
	local usedHeroIdMap = {}

	if index == self.selectTeam then
		for pos, obj in pairs(DragPlane.fieldObjs or {}) do
			if obj.hero and pos > 0 then
				usedHeroIdMap[obj.hero.id] = true
				count = count + 1
			end
		end
	else
		for gid, pos in pairs(self.teamFormations[index] or {}) do
			local hero = CurAvatar.heroDic[gid]

			if hero then
				count = count + 1
				usedHeroIdMap[hero.id] = true
			end
		end
	end

	return count, usedHeroIdMap
end

function MultiDragHeroDlg:startBattle()
	local checkHeroEquipOK = self:checkHeroEquipWear()

	if not checkHeroEquipOK then
		UIManager.showConfirmWithId(1044, nil, Slot(self._RealStartBattle, self))
	else
		self:_RealStartBattle()
	end
end

function MultiDragHeroDlg:_RealStartBattle()
	self:saveFormationToServer(Const.FORMATION_TYPE_MULTIPVP_ATTACK)
	RPC.pVEStart(self.battleType)
	CurAvatar:battleMiscReq()
	UIManager.getUI("battleStartMultiDlg", true):setRound(1)
	self:setVisible(false)
end

function MultiDragHeroDlg:isEmpty(formIndex)
	return self.teamFormations[formIndex] == nil or next(self.teamFormations[formIndex]) == nil
end

function MultiDragHeroDlg:onChangeFormation(fromIndex, toIndex)
	local tmpForm = self.teamFormations[fromIndex]

	self.teamFormations[fromIndex] = self.teamFormations[toIndex]
	self.teamFormations[toIndex] = tmpForm

	local tmpPets = self.teamPets[fromIndex]

	self.teamPets[fromIndex] = self.teamPets[toIndex]
	self.teamPets[toIndex] = tmpPets

	if fromIndex == self.selectTeam or toIndex == self.selectTeam then
		self:refreshTeamObjects()
	end

	self:onSwitchTeam()
	self:refreshRedDot()
end

function MultiDragHeroDlg:onSwitchTeam()
	self:saveNowFormation()

	local switchDlg = UIManager.getUI("multiDragSwitchDlg", nil, false)

	switchDlg = switchDlg or UIManager.getUI("multiDragSwitchDlg", true)

	if self.battleType == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM then
		switchDlg:onShow(self.teamFormations, nil, self.battleType, self.teamPets)
	else
		switchDlg:onShow(self.teamFormations, self.battlePreInfo.multiPvpData.formation, self.battleType, self.teamPets)
	end
end

function MultiDragHeroDlg:refreshPetObject()
	self.nowSelectPet = nil
	self.nowSelectPetId = nil
	self.otherPetIds = {}

	for teamId, info in pairs(self.teamPets) do
		if teamId ~= self.selectTeam and info.petId then
			self.otherPetIds[info.petId] = teamId
		end
	end

	if self.panelPetList and CurAvatar:petSystemEnable() then
		if #self.petData > 0 then
			local otherFormationInfo = self.teamPets[self.selectTeam]
			local defaultPetId

			if otherFormationInfo then
				defaultPetId = otherFormationInfo.petId
			end

			self.panelNonePet:setVisible(false)
			self.scrollPetList:setVisible(true)
			self.scrollPetList:setTotalCount(#self.petData)

			if defaultPetId then
				for _, pet in pairs(self.petData) do
					if pet.id == defaultPetId then
						self.nowSelectPet = pet
						self.nowSelectPetId = defaultPetId
					end
				end
			end

			self:refreshPetPart()
		else
			self.panelNonePet:setVisible(true)
			self.scrollPetList:setVisible(false)
			self.panelPetSkill:setVisible(false)
		end
	end
end

function MultiDragHeroDlg:onPetCellClick(sender)
	if self.otherPetIds and self.otherPetIds[sender.pet.id] then
		MsgManager.notice(string.format(Lang.get(75525), self.otherPetIds[sender.pet.id]))

		return
	end

	DragHeroMixin.onPetCellClick(self, sender)
end

function MultiDragHeroDlg:refreshPetPart()
	DragHeroMixin.refreshPetPart(self)

	for index, cell in pairs(self.petCells) do
		cell:setSelected(cell.pet == self.nowSelectPet, self.otherPetIds and self.otherPetIds[cell.pet.id])
	end
end

return MultiDragHeroDlg
