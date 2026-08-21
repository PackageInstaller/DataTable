-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentTeamSetupDlg.lua

local RentTeamCellBase = require("UI/RentTask/RentTeamCellBase")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local strClassName = "RentTeamSetupDlg"
local RentTeamSetupDlg = Class(strClassName, UIControls.Window)
local RentSelfTeamInfoCell = Class("RentSelfTeamInfoCell", UIControls.Child)

function RentSelfTeamInfoCell:ctor(...)
	self:initUI()
end

function RentSelfTeamInfoCell:initUI(...)
	self.basePanel = RentTeamCellBase(self, "CaseTaskChooseInfoCell")
	self.statePanel = UIControls.Panel(self, "CaseTaskChooseInfoCell/ImgSupport")
	self.teamLockPanel = UIControls.Panel(self, "DisCaseTaskChooseInfoCell")
	self.lockTeamTitle = UIControls.Label(self, "DisCaseTaskChooseInfoCell/TextNum")
	self.editBtn = UIControls.Button(self, "BtnEdit")

	self.editBtn:addEventClick(self._onClickEdit)

	self.normalBtn = UIControls.Panel(self, "BtnEdit/NmlEdit")
	self.disBtn = UIControls.Panel(self, "BtnEdit/DisEdit")
end

function RentSelfTeamInfoCell:setTeamInfo(teamId, isLock)
	self.teamId = teamId

	self.basePanel:setVisible(not isLock)
	self.teamLockPanel:setVisible(isLock)
	self.normalBtn:setVisible(not isLock)
	self.disBtn:setVisible(isLock)

	self.isLock = isLock

	if not isLock then
		if CurAvatar:isFormationSnapShot(Const.FORMATION_RENT_TEAMS[1]) then
			local formation = CurAvatar:getFormationSnapshot(Const.FORMATION_RENT_TEAMS[teamId])

			self.basePanel:setRentFormation(formation, teamId)
		else
			local formation = CurAvatar:getNowFormation(Const.FORMATION_RENT_TEAMS[teamId])

			self.basePanel:setRentFormationWithLocalData(formation, teamId, nil, Const.FORMATION_RENT_TEAMS[teamId])
		end

		self.statePanel:setVisible(RentTaskUtils.teamIsBusy(teamId))
	else
		self.lockTeamTitle:setText(string.format(Lang.get(30732), Const.NUMBER_TO_WORD[teamId]))
	end
end

function RentSelfTeamInfoCell:_onClickEdit()
	if self.isLock then
		if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_HANDBOOK_TEAM) then
			MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_HANDBOOK_TEAM))

			return
		end

		UIManager.getUI("handBookTeamOverviewDlg", true):onBtnHelpClick()
	elseif self.mParent.snapshotOn then
		UIManager.showConfirmWithId(1034, Slot(self._realEditFormation, self))
	else
		self:_realEditFormation()
	end
end

function RentSelfTeamInfoCell:_realEditFormation()
	local battleData = {}

	battleData.rentData = {}
	battleData.rentData.formationIndex = self.teamId

	CurAvatar:enterFormation(BattleConst.EMPTY_BATTLE_NO, BattleConst.FORMATION_TYPE_RENT_DEFEND, battleData)

	if self.mParent.snapshotOn then
		RPC.formationSnapshot(Const.FORMATION_RENT_TEAMS[1], 0)
	end
end

function RentTeamSetupDlg:ctor(...)
	self:initUI()
end

function RentTeamSetupDlg:initUI(...)
	self.playerNameTxt = UIControls.Label(self, "BgPanel/PlayerInfoPanel/TextName")
	self.playerHeadBtn = UIControls.PlayerHeadGridChild(self, "BgPanel/PlayerInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.playerHeadBtn:setEnable(false)

	self.snapshotBtn = UIControls.CustomToggle(self, "BgPanel/LockPanel/BtnLock")

	self.snapshotBtn:addEventOnToggleClick(Slot(self._onClickSnapshot, self))

	self.teamCells = {}
	self.maxTeamCount = RentTaskUtils.selfMaxTeamCount()

	if not self.maxTeamCount or self.maxTeamCount <= 0 then
		return
	end

	for i = 1, self.maxTeamCount do
		local cell = RentSelfTeamInfoCell(self, "BgPanel/TeamInfoList/Content", "System/CaseTask/SetupTeamCell", 0, 0, true)

		self.teamCells[i] = cell
	end
end

function RentTeamSetupDlg:onOpen(...)
	RentTeamSetupDlg.super.onOpen(self)

	local rentMainDlg = UIManager.getUI("rentTaskMainDlg", nil, false)

	if rentMainDlg then
		self:bindWindow(rentMainDlg)
	end

	self:initTeamSetupDlg()
	self:refreshTeamSetupDlg()
end

function RentTeamSetupDlg:initTeamSetupDlg()
	if not CurAvatar then
		return
	end

	self.playerNameTxt:setText(CurAvatar:getPlayerName() or "")
	self.playerHeadBtn:setCommInfo(CurAvatar:getMyCommInfo(), false, self)
	self.snapshotBtn:setToggleValue(CurAvatar:isFormationSnapShot(Const.FORMATION_RENT_TEAMS[1]))
end

function RentTeamSetupDlg:refreshTeamSetupDlg(...)
	local nowTeams = CurAvatar.rentMaxUnlockTeams

	for i = 1, self.maxTeamCount do
		if i > nowTeams + 1 then
			self.teamCells[i]:setVisible(false)
		else
			self.teamCells[i]:setVisible(true)
			self.teamCells[i]:setTeamInfo(i, nowTeams < i)
		end
	end

	local snapshotOn = CurAvatar:isFormationSnapShot(Const.FORMATION_RENT_TEAMS[1])

	if self.snapshotOn ~= snapshotOn then
		self.snapshotBtn:refreshToggleValue(snapshotOn)
	end

	self.snapshotOn = snapshotOn
end

function RentTeamSetupDlg:_onClickSnapshot(isOn)
	if not CurAvatar:isFormationSnapShot(Const.FORMATION_RENT_TEAMS[1]) then
		local function yesFunc(...)
			RPC.formationSnapshot(Const.FORMATION_RENT_TEAMS[1], 1)
		end

		UIManager.showConfirmWithId(1032, yesFunc)
	else
		local function yesFunc(...)
			RPC.formationSnapshot(Const.FORMATION_RENT_TEAMS[1], 0)
		end

		UIManager.showConfirmWithId(1033, yesFunc)
	end
end

return RentTeamSetupDlg
