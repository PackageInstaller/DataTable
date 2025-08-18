-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpCheckTeamDlg.lua

local PVPCommon = require("Logic/PVP/PVPCommon")
local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")
local strClassName = "TopPvpCheckTeamDlg"
local TopPvpCheckTeamDlg = Class(strClassName, UIControls.Window)
local OPRATION = {
	NORMAL = 3,
	CHANGE = 2
}

function TopPvpCheckTeamDlg:ctor()
	self:initUI()
end

function TopPvpCheckTeamDlg:initUI()
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:setEnable(false)

	self.btnLock = UIControls.Button(self, "BgPanel/LockPanel/BtnLock")

	self.btnLock:addEventClick(self.onBtnLockClick)

	self.txtName = UIControls.Label(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/TextName")
	self.panelLock = UIControls.Panel(self, "BgPanel/LockPanel")
	self.imgAni = UIControls.Image(self, "BgPanel/LockPanel/BtnLock/Img")
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

	self.topPVPPanel = UIControls.Panel(self, "BgPanel/TopPVPPanel")
	self.txtTip = UIControls.Label(self, "BgPanel/TopPVPPanel/Text")
end

function TopPvpCheckTeamDlg:show(...)
	self:initData()
end

function TopPvpCheckTeamDlg:initData(...)
	self.opration = OPRATION.NORMAL
	self.oprationTarget = nil

	local commInfo = CurAvatar:getMyCommInfo()

	self.btnHead:setCommInfo(commInfo, false, self)
	self.txtName:setText(commInfo.name)

	self.formations = {}

	if CurAvatar:isFormationSnapShot(Const.FORMATION_TOPPVP_DEFEND_1) then
		RPC.formationSnapshotGet(Const.FORMATION_TOPPVP_DEFEND_1)
	end

	local keyStr = "FORMATION_TOPPVP_DEFEND_"

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

	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		local nowState = actData:getTopPvpStage()

		if nowState then
			self.topPVPPanel:setVisible(true)
			self.txtTip:setVisible(true)

			if nowState > actData.reStateMap.GroupFormation then
				for i = 1, 3 do
					self.teamInfos[i].btnChange:setVisible(false)
					self.teamInfos[i].btnEdit:setVisible(false)
				end

				self.panelLock:setVisible(false)
				self.txtTip:setText(Lang.get(77972))
			else
				self.txtTip:setText(Lang.get(75791))
			end
		end
	end
end

function TopPvpCheckTeamDlg:setSnapShotFormation(formation)
	if formation.type == Const.FORMATION_TOPPVP_DEFEND_1 then
		self.snapShotFormation = {}

		for i, data in ipairs(formation.item) do
			table.insert(self.snapShotFormation, data)
		end

		self:_refreshFormationUI()
	end
end

function TopPvpCheckTeamDlg:refreshLockUI(isOut)
	if isOut and CurAvatar:isFormationSnapShot(Const.FORMATION_TOPPVP_DEFEND_1) then
		RPC.formationSnapshotGet(Const.FORMATION_TOPPVP_DEFEND_1)
	end

	if not CurAvatar:isFormationSnapShot(Const.FORMATION_TOPPVP_DEFEND_1) then
		self.imgAni:playAnimator("BtnSwitchSetOff")
	else
		self.imgAni:playAnimator("BtnSwitchSetOn")
	end

	self:_refreshFormationUI()
end

function TopPvpCheckTeamDlg:_refreshFormationUI(...)
	if CurAvatar:isFormationSnapShot(Const.FORMATION_TOPPVP_DEFEND_1) then
		if self.snapShotFormation then
			for i, info in ipairs(self.teamInfos) do
				info.formation:setFormation(self.snapShotFormation[i], i)
				info.formation:setSideState(true)
				info.formation:setMyHideMode(true)
			end
		end
	else
		for i, info in ipairs(self.teamInfos) do
			info.formation:setFormationWithLocalFormation(self.formations[i], i)
			info.formation:setSideState(true)
			info.formation:setMyHideMode(true)
		end
	end
end

function TopPvpCheckTeamDlg:refreshButtonState()
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

function TopPvpCheckTeamDlg:changeTeam(otherTarget)
	local id1, id2 = self.oprationTarget.index, otherTarget.index

	if CurAvatar:isFormationSnapShot(Const.FORMATION_TOPPVP_DEFEND_1) then
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

function TopPvpCheckTeamDlg:saveFormationToServer(...)
	if CurAvatar:isFormationSnapShot(Const.FORMATION_TOPPVP_DEFEND_1) then
		RPC.formationSnapshotSwapIdx(Const.FORMATION_TOPPVP_DEFEND_1, self.orderToIndex)
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

		RPC.formationsUpdateByType(Const.FORMATION_TYPE_TOPPVP_DEFEND, result)
	end
end

function TopPvpCheckTeamDlg:onBtnLockClick(...)
	if not CurAvatar:isFormationSnapShot(Const.FORMATION_TOPPVP_DEFEND_1) then
		local function yesFunc(...)
			RPC.formationSnapshot(Const.FORMATION_TOPPVP_DEFEND_1, 1)
		end

		UIManager.showConfirmWithId(1019, yesFunc)
	else
		local function yesFunc(...)
			RPC.formationSnapshot(Const.FORMATION_TOPPVP_DEFEND_1, 0)
		end

		UIManager.showConfirmWithId(1020, yesFunc)
	end
end

function TopPvpCheckTeamDlg:onBtnChangeClick(sender)
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

function TopPvpCheckTeamDlg:onBtnEditClick(sender)
	local BattleConst = require("Common/FrameBattle/BattleConst")
	local battleData = {}

	if CurAvatar:isFormationSnapShot(Const.FORMATION_TOPPVP_DEFEND_1) then
		local function yesFunc(...)
			RPC.formationSnapshot(Const.FORMATION_TOPPVP_DEFEND_1, 0)
			self:_enterFormation(sender.index)
		end

		UIManager.showConfirmWithId(1021, yesFunc)

		return
	end

	self:_enterFormation(sender.index)
end

function TopPvpCheckTeamDlg:_enterFormation(index)
	local battleData = {}

	battleData.topPvpData = {}

	local actObj = CurAvatar:getTopPVPActivity()

	if actObj then
		battleData.topPvpData.actId = actObj.actId
	end

	battleData.topPvpData.formationIndex = index

	CurAvatar:enterFormation(ResBPPvpMisc[1].pve_id, BattleConst.FORMATION_TYPE_TOP_PVP, battleData)
end

return TopPvpCheckTeamDlg
