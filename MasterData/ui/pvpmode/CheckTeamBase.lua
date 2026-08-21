-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\CheckTeamBase.lua

local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")
local StrClassName = "CheckTeamBase"
local CheckTeamBase = Class(StrClassName, UIControls.Window)
local OPRATION = {
	NORMAL = 3,
	CHANGE = 2
}

function CheckTeamBase:ctor(...)
	self:initUI()
end

function CheckTeamBase:initUI(...)
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:setEnable(false)

	self.btnLock = UIControls.Button(self, "BgPanel/LockPanel/BtnLock")

	self.btnLock:addEventClick(self.onBtnLockClick)

	self.txtName = UIControls.Label(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/TextName")
	self.panelLock = UIControls.Panel(self, "BgPanel/LockPanel")
	self.imgAni = UIControls.Image(self, "BgPanel/LockPanel/BtnLock/Img")

	self:initTeamInfos()
	self.panelLock:setVisible(true)
end

function CheckTeamBase:initTeamInfos()
	self.teamInfos = {}

	local path

	self.teams = self:getTeamsPos()

	local num = #self.teams

	for i = 1, 3 do
		path = "BgPanel/SelfInfoPanel/TeamInfoPanel/Team" .. i

		local panel = UIControls.Panel(self, path)

		if num < i then
			panel:setVisible(false)
		else
			local info = {}

			info.formation = SeniorFormation(self, path, "System/AsynPVP/SeniorPVPTeamInfoCell")
			info.imgBg = UIControls.Image(self, path .. "/BtnChange")
			info.btnChange = UIControls.Button(self, path .. "/BtnChange")

			info.btnChange:addEventClick(self.onBtnChangeClick)

			info.btnChange.index = i
			info.btnEdit = UIControls.Button(self, path .. "/BtnEdit")

			info.btnEdit:addEventClick(self.onBtnEditClick)

			info.btnEdit.index = i
			self.teamInfos[i] = info

			if num == 1 and i == num then
				info.btnChange:setVisible(false)
			end
		end
	end
end

function CheckTeamBase:getTeamsPos(...)
	return {
		Const.FORMATION_ASYNC_DEFEND
	}
end

function CheckTeamBase:getHideMode(...)
	return
end

function CheckTeamBase:refreshSnapShotFormation(...)
	self.snapShotFormation = CurAvatar:getFormationSnapShotItemData(self.teams[1])

	self:_refreshFormationUI()
end

function CheckTeamBase:enterFormation(index)
	local battleData = {}

	battleData.opactPvpData = {}
	battleData.opactPvpData.formationIndex = index

	CurAvatar:enterFormation(10001, BattleConst.FORMATION_TYPE_OPACT_PVP, battleData)
end

function CheckTeamBase:getSaveType(...)
	return Const.FORMATION_TYPE_OPACTPVP_DEFEND
end

function CheckTeamBase:show(...)
	self:initData()
end

function CheckTeamBase:initData(...)
	self.opration = OPRATION.NORMAL
	self.oprationTarget = nil

	local commInfo = CurAvatar:getMyCommInfo()

	self.btnHead:setCommInfo(commInfo, false, self)
	self.txtName:setText(commInfo.name)

	self.formations = {}
	self.hideMode = self:getHideMode()

	if CurAvatar:isFormationSnapShot(self.teams[1]) then
		RPC.formationSnapshotGet(self.teams[1])
	end

	for i, info in ipairs(self.teamInfos) do
		local formation = CurAvatar:getNowFormation(self.teams[i])
		local otherInfo = CurAvatar:getFormationOtherInfo(self.teams[i])

		table.insert(self.formations, {
			formation = formation,
			otherInfo = otherInfo
		})
	end

	self:refreshLockUI()
end

function CheckTeamBase:_refreshFormationUI(...)
	if CurAvatar:isFormationSnapShot(self.teams[1]) then
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

function CheckTeamBase:refreshLockUI(isOut)
	if isOut and CurAvatar:isFormationSnapShot(self.teams[1]) then
		RPC.formationSnapshotGet(self.teams[1])
	end

	if not CurAvatar:isFormationSnapShot(self.teams[1]) then
		self.imgAni:playAnimator("BtnSwitchSetOff")
	else
		self.imgAni:playAnimator("BtnSwitchSetOn")
	end

	self:_refreshFormationUI()
end

function CheckTeamBase:refreshButtonState()
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

function CheckTeamBase:changeTeam(otherTarget)
	local id1, id2 = self.oprationTarget.index, otherTarget.index

	if CurAvatar:isFormationSnapShot(self.teams[1]) then
		self.orderToIndex = {}

		for i = 1, #self.teams do
			table.insert(self.orderToIndex, i - 1)
		end

		self.orderToIndex[id1], self.orderToIndex[id2] = self.orderToIndex[id2], self.orderToIndex[id1]
		self.snapShotFormation[id1], self.snapShotFormation[id2] = self.snapShotFormation[id2], self.snapShotFormation[id1]
	end

	self.formations[id1], self.formations[id2] = self.formations[id2], self.formations[id1]

	self:_refreshFormationUI()
	self:saveFormationToServer()
end

function CheckTeamBase:saveFormationToServer(...)
	if CurAvatar:isFormationSnapShot(self.teams[1]) then
		RPC.formationSnapshotSwapIdx(self.teams[1], self.orderToIndex)
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

		RPC.formationsUpdateByType(self:getSaveType(), result)
	end
end

function CheckTeamBase:onBtnLockClick(...)
	if not CurAvatar:isFormationSnapShot(self.teams[1]) then
		local function yesFunc(...)
			RPC.formationSnapshot(self.teams[1], 1)
		end

		UIManager.showConfirmWithId(1019, yesFunc)
	else
		local function yesFunc(...)
			RPC.formationSnapshot(self.teams[1], 0)
		end

		UIManager.showConfirmWithId(1020, yesFunc)
	end
end

function CheckTeamBase:onBtnChangeClick(sender)
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

function CheckTeamBase:onBtnEditClick(sender)
	local BattleConst = require("Common/FrameBattle/BattleConst")
	local battleData = {}

	if CurAvatar:isFormationSnapShot(self.teams[1]) then
		local function yesFunc(...)
			RPC.formationSnapshot(self.teams[1], 0)
			self:enterFormation(sender.index)
		end

		UIManager.showConfirmWithId(1021, yesFunc)

		return
	end

	self:enterFormation(sender.index)
end

return CheckTeamBase
