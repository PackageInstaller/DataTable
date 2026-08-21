-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpPlayerDetailsDlg.lua

local strClassName = "TopPvpPlayerDetailsDlg"
local TopPvpPlayerDetailsDlg = Class(strClassName, UIControls.Window)
local SeniorFormation = require("UI/PVPMode/SeniorPVP/SeniorFormation")

function TopPvpPlayerDetailsDlg:ctor(...)
	self:initUI()
end

function TopPvpPlayerDetailsDlg:initUI(...)
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:setEnable(false)

	self.teamInfos = {}

	local path

	for i = 1, 3 do
		local info = {}

		path = "BgPanel/SelfInfoPanel/TeamInfoPanel/Team" .. i
		info.formation = SeniorFormation(self, path, "System/AsynPVP/SeniorPVPTeamInfoCell")
		info.btnChange = UIControls.Button(self, path .. "/BtnChange")

		info.btnChange:setVisible(false)

		info.btnEdit = UIControls.Button(self, path .. "/BtnEdit")

		info.btnEdit:setVisible(false)

		self.teamInfos[i] = info
	end

	self.txtPlayerName = UIControls.Label(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/TextName")
	self.txtTitle = UIControls.Label(self, "BgPanel/SelfInfoPanel/TeamInfoPanel/TextTitle")

	self.txtTitle:setVisible(true)

	self.panelPower = UIControls.Panel(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/PowerPanel")

	self.panelPower:setVisible(true)

	self.txtPowerNum = UIControls.Label(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/PowerPanel/TextNum")
	self.panelProgress = UIControls.Panel(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/ProgressPanel")
	self.txtProgressNum = UIControls.Label(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/ProgressPanel/TextNum")
	self.imgState = UIControls.Image(self, "BgPanel/SelfInfoPanel/PlayerInfoPanel/TextName/ImgState")
end

function TopPvpPlayerDetailsDlg:_parseStage(stage)
	if stage == nil then
		return 0
	end

	if type(stage) ~= "number" then
		return
	end

	local s1, s2, s3

	s1 = stage % 100
	s2 = math.floor(stage / 100) % 100
	s3 = math.floor(stage / 10000)

	return ClientUtils.getMainStageLevelStr(s3, s2, s1)
end

function TopPvpPlayerDetailsDlg:show(comm)
	self.txtPowerNum:setText(comm.power)

	local name = utils.GetPlayerName(comm.comm.name)

	self.txtPlayerName:setText(name)
	self.btnHead:setCommInfo(comm.comm, true, self)

	local actId = CurAvatar:getTopPVPActivityOpId()
	local actData = CurAvatar:getTopPVPActivityData()

	self.comm = comm.comm

	if comm.stage then
		self.panelProgress:setVisible(true)

		if type(comm.stage) == "string" then
			self.txtProgressNum:setText(comm.stage)
		else
			local stage = self:_parseStage(comm.stage)

			if stage then
				self.txtProgressNum:setText(stage)
			else
				self.panelProgress:setVisible(false)
			end
		end
	else
		self.panelProgress:setVisible(false)
	end

	RPC.bPPvpGroupDetailGet(actId, comm.comm.uid, 1)
end

function TopPvpPlayerDetailsDlg:setFormationData(data)
	if data and data.formation and data.uid and self.comm and self.comm.uid and self.comm.uid == data.uid then
		local formation = data.formation

		for i, info in ipairs(self.teamInfos) do
			info.formation:setFormation(formation[i], i)
			info.formation:setSideState(true)
			info.formation:setMyHideMode(true)
		end
	end
end

return TopPvpPlayerDetailsDlg
