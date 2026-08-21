-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\SeniorPVP\\SeniorPvpRankCell.lua

local SeniorFormationPanel = require("UI/PVPMode/SeniorPVP/SeniorFormationPanel")
local PVPCommon = require("Logic/PVP/PVPCommon")
local strClassName = "SeniorPvpRankCell"
local SeniorPvpRankCell = Class(strClassName, UIControls.BtnPlayerRankCellLoop)
local INIT_HEIGHT = 122
local MAX_HEIGHT = 466

function SeniorPvpRankCell:ctor(...)
	self:_initUI()
end

function SeniorPvpRankCell:_initUI(...)
	self.btnTeam = UIControls.Button(self, "BgPanel/BtnTeam")

	self.btnTeam:addEventClick(self.onBtnTeamClick)

	self.txtPower = UIControls.Label(self, "BgPanel/TextPower")
	self.panelTeamInfo = UIControls.Panel(self, "TeamInfo")
	self.panelFormation = SeniorFormationPanel(self, "TeamInfo/TeamInfoPanel")
	self.rankUIData = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "BgPanel"

	for i, name in ipairs(uiNames) do
		self.rankUIData[i] = UIControls.Image(self, path .. name)
	end
end

function SeniorPvpRankCell:setData(data, idx)
	SeniorPvpRankCell.super.setData(self, data, idx)

	local info = PVPCommon.getRankPartInfo(data.rank)

	PVPCommon.setRankUI(self.rankUIData, info)
	self.playerHead:checkRobotInfo(Const.ROLEINFO_ROBOT_TYPE_MULTIPVP)
end

function SeniorPvpRankCell:extend(v)
	if v then
		self:setLayoutSize(nil, MAX_HEIGHT)
		self:checkFormation()
	else
		self.panelTeamInfo:setVisible(false)
		self:setLayoutSize(nil, INIT_HEIGHT)
	end
end

function SeniorPvpRankCell:checkFormation(...)
	local formation

	if utils.isRobot(self.data.data.comm.uid) then
		formation = PVPCommon.getMultiPvpRobotServerFormation(self.data.data.comm.uid)
	else
		formation = CurAvatar:getSeniorPvpFormation(self.data.data.comm.uid)
	end

	if formation then
		self.panelFormation:setFormation(formation, false)
		self.panelTeamInfo:setVisible(true)

		local power = PVPCommon.getFormationPower(formation)

		self.data.data.power = power

		self:refreshPower(power)
	end
end

function SeniorPvpRankCell:refreshPower(power)
	self.txtPower:setText(power)
end

function SeniorPvpRankCell:onBtnTeamClick(...)
	self.mParent:extendCell(self.idx)
end

return SeniorPvpRankCell
