-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ActivityPVP\\ActivityPvpCheckTeamDlg.lua

local PVPCommon = require("Logic/PVP/PVPCommon")
local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local strClassName = "ActivityPvpCheckTeamDlg"
local ActivityPvpCheckTeamDlg = Class(strClassName, UIControls.Window)
local OPRATION = {
	NORMAL = 3,
	CHANGE = 2
}

function ActivityPvpCheckTeamDlg:ctor(...)
	self:initUI()
end

function ActivityPvpCheckTeamDlg:initUI(...)
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:setEnable(false)

	self.btnLock = UIControls.Button(self, "BgPanel/LockPanel/BtnLock")

	self.btnLock:addEventClick(self.onBtnLockClick)

	self.btnRandom = UIControls.Button(self, "BgPanel/LockPanel/BtnRandom")

	self.btnRandom:addEventClick(self.onBtnRandomClick)

	self.txtName = UIControls.Label(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/TextName")
	self.panelLock = UIControls.Panel(self, "BgPanel/LockPanel")
	self.imgAni = UIControls.Image(self, "BgPanel/LockPanel/BtnLock/Img")
	self.imgRandAni = UIControls.Image(self, "BgPanel/LockPanel/BtnRandom/Img")
	self.teamInfos = {}

	local path

	for i = 1, 3 do
		local info = {}

		path = "BgPanel/SelfInfoPanel/TeamInfoPanel/Team" .. i
		info.formation = SeniorFormation(self, path, "System/AsynPVP/SeniorPVPTeamInfoCell")
		info.imgBg = UIControls.Image(self, path .. "/BtnChange")
		info.btnChange = UIControls.Button(self, path .. "/BtnChange")

		info.btnChange:addEventClick(self.onBtnChangeClick)

		info.btnChange.index = i
		info.btnEdit = UIControls.Button(self, path .. "/BtnEdit")

		info.btnEdit:addEventClick(self.onBtnEditClick)

		info.btnEdit.index = i
		self.teamInfos[i] = info
	end

	self.panelLock:setVisible(true)
end

function ActivityPvpCheckTeamDlg:show()
	self:initData()
end

function ActivityPvpCheckTeamDlg:initData(...)
	self.opration = OPRATION.NORMAL
	self.oprationTarget = nil

	local commInfo = CurAvatar:getMyCommInfo()

	self.btnHead:setCommInfo(commInfo, false, self)
	self.txtName:setText(commInfo.name)

	self.formations = {}
	self.hideMode = CurAvatar:getPVPArenaFormationHideMode()

	local actData = CurAvatar:getPVPArenaActData()

	if actData then
		local partInfo = actData:getMyCurPartInfo()

		if partInfo then
			self.btnRandom:setVisible(partInfo.hide_mode == 4)
		else
			self.btnRandom:setVisible(false)
		end
	end

	if CurAvatar:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) then
		RPC.formationSnapshotGet(Const.FORMATION_OPACTPVP_DEFEND_1)
	end

	local keyStr = "FORMATION_OPACTPVP_DEFEND_"

	for i, info in ipairs(self.teamInfos) do
		local formation = CurAvatar:getNowFormation(Const[keyStr .. i])
		local otherInfo = CurAvatar:getFormationOtherInfo(Const[keyStr .. i])

		table.insert(self.formations, {
			formation = formation,
			otherInfo = otherInfo
		})
	end

	self:_refreshFormationUI()
	self:refreshLockUI()
	self:refreshRandTeamUI()
end

function ActivityPvpCheckTeamDlg:setSnapShotFormation(formation)
	if formation.type == Const.FORMATION_OPACTPVP_DEFEND_1 then
		self.snapShotFormation = {}

		for i, data in ipairs(formation.item) do
			table.insert(self.snapShotFormation, data)
		end

		self:_refreshFormationUI()
	end
end

function ActivityPvpCheckTeamDlg:refreshLockUI(isOut)
	if isOut and CurAvatar:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) then
		RPC.formationSnapshotGet(Const.FORMATION_OPACTPVP_DEFEND_1)
	end

	if not CurAvatar:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) then
		self.imgAni:playAnimator("BtnSwitchSetOff")
	else
		self.imgAni:playAnimator("BtnSwitchSetOn")
	end

	self:_refreshFormationUI()
end

function ActivityPvpCheckTeamDlg:_refreshFormationUI(...)
	if CurAvatar:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) then
		if self.snapShotFormation then
			for i, info in ipairs(self.teamInfos) do
				info.formation:setFormation(self.snapShotFormation[i], i)
				info.formation:setSideState(true)

				if self.hideMode then
					info.formation:setMyHideMode(self.hideMode[i] and self.hideMode[i].hide == 1)
				end
			end
		end
	else
		for i, info in ipairs(self.teamInfos) do
			info.formation:setFormationWithLocalFormation(self.formations[i], i)
			info.formation:setSideState(true)

			if self.hideMode then
				info.formation:setMyHideMode(self.hideMode[i] and self.hideMode[i].hide == 1)
			end
		end
	end
end

function ActivityPvpCheckTeamDlg:refreshRandTeamUI(...)
	local actData = CurAvatar:getPVPArenaActData()

	if actData then
		local isRand = actData:isRandTeam()

		if isRand then
			self.imgRandAni:playAnimator("BtnSwitchSetOn")
		else
			self.imgRandAni:playAnimator("BtnSwitchSetOff")
		end
	end
end

function ActivityPvpCheckTeamDlg:refreshButtonState()
	if self.oprationTarget == nil then
		self.opration = OPRATION.NORMAL

		for _, info in ipairs(self.teamInfos) do
			info.imgBg:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas", "BtnChangeNml")
		end
	else
		self.opration = OPRATION.CHANGE

		for _, info in ipairs(self.teamInfos) do
			if info.btnChange ~= self.oprationTarget then
				info.imgBg:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas", "BtnChangeSel")
			else
				info.imgBg:setImage("Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas", "BtnCancelNml")
			end
		end
	end
end

function ActivityPvpCheckTeamDlg:changeTeam(otherTarget)
	local id1, id2 = self.oprationTarget.index, otherTarget.index

	if CurAvatar:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) then
		self.orderToIndex = {
			0,
			1,
			2
		}
		self.orderToIndex[id1], self.orderToIndex[id2] = self.orderToIndex[id2], self.orderToIndex[id1]
		self.snapShotFormation[id1], self.snapShotFormation[id2] = self.snapShotFormation[id2], self.snapShotFormation[id1]
	end

	self.formations[id1], self.formations[id2] = self.formations[id2], self.formations[id1]

	self:_refreshFormationUI()
	self:saveFormationToServer()
end

function ActivityPvpCheckTeamDlg:saveFormationToServer(...)
	if CurAvatar:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) then
		RPC.formationSnapshotSwapIdx(Const.FORMATION_OPACTPVP_DEFEND_1, self.orderToIndex)
	else
		local result = {}

		for i, info in ipairs(self.formations) do
			local data = {
				hero = {}
			}

			for gid, pos in pairs(info.formation) do
				table.insert(data.hero, {
					idx = pos,
					gid = gid
				})
			end

			if info.otherInfo and info.otherInfo.petId then
				data.pet = info.otherInfo.petId
			end

			table.insert(result, data)
		end

		RPC.formationsUpdateByType(Const.FORMATION_TYPE_OPACTPVP_DEFEND, result)
	end
end

function ActivityPvpCheckTeamDlg:onBtnRandomClick(...)
	local actData = CurAvatar:getPVPArenaActData()

	if actData then
		local isRand = actData:isRandTeam()
		local actId = CurAvatar:getPVPArenaActivityOpId(...)

		if actId then
			local function yesFunc(...)
				RPC.opactArenaSetRandFormaion(actId, isRand and 0 or 1)
			end

			if not isRand then
				UIManager.showConfirmWithId(1045, yesFunc)
			else
				yesFunc()
			end
		end
	end
end

function ActivityPvpCheckTeamDlg:onBtnLockClick(...)
	if not CurAvatar:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) then
		local function yesFunc(...)
			RPC.formationSnapshot(Const.FORMATION_OPACTPVP_DEFEND_1, 1)
		end

		UIManager.showConfirmWithId(1019, yesFunc)
	else
		local function yesFunc(...)
			RPC.formationSnapshot(Const.FORMATION_OPACTPVP_DEFEND_1, 0)
		end

		UIManager.showConfirmWithId(1020, yesFunc)
	end
end

function ActivityPvpCheckTeamDlg:onBtnChangeClick(sender)
	if self.opration == OPRATION.NORMAL then
		self.oprationTarget = sender
	elseif self.oprationTarget == sender then
		self.oprationTarget = nil
	else
		self:changeTeam(sender)

		self.oprationTarget = nil
	end

	self:refreshButtonState()
end

function ActivityPvpCheckTeamDlg:onBtnEditClick(sender)
	local BattleConst = require("Common/FrameBattle/BattleConst")
	local battleData = {}

	if CurAvatar:isFormationSnapShot(Const.FORMATION_OPACTPVP_DEFEND_1) then
		local function yesFunc(...)
			RPC.formationSnapshot(Const.FORMATION_OPACTPVP_DEFEND_1, 0)
			self:_enterFormation(sender.index)
		end

		UIManager.showConfirmWithId(1021, yesFunc)

		return
	end

	self:_enterFormation(sender.index)
end

function ActivityPvpCheckTeamDlg:_enterFormation(index)
	local battleData = {}

	battleData.opactPvpData = {}

	local actObj = CurAvatar:getPVPArenaActivity()

	if actObj then
		battleData.opactPvpData.actId = actObj.actId
	end

	battleData.opactPvpData.formationIndex = index

	CurAvatar:enterFormation(10001, BattleConst.FORMATION_TYPE_OPACT_PVP, battleData)
end

return ActivityPvpCheckTeamDlg
