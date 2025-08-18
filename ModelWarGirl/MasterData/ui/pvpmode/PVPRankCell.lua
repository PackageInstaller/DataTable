-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPRankCell.lua

local Formation = require("UI/PVPMode/Formation")
local ResAsyncPvpMisc = require("ClientData/ResAsyncPvpMisc")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local strClassName = "PVPRankCell"
local PVPRankCell = Class(strClassName, UIControls.BtnPlayerRankCellLoop)

function PVPRankCell:ctor()
	self:_initUI()
end

local INIT_HEIGHT = 130
local MAX_HEIGHT = 395

function PVPRankCell:_initUI()
	self.txtPower = UIControls.Label(self, "BgPanel/TextPowerTitle/TextPower")
	self.btnTeam = UIControls.Button(self, "BgPanel/BtnTeam")

	self.btnTeam:addEventClick(self.onBtnTeamClick)

	self.formation = Formation(self, "TeamInfo")
end

function PVPRankCell:onBtnTeamClick()
	self.mParent:extendCell(self.idx)
end

function PVPRankCell:setData(data, idx)
	PVPRankCell.super.setData(self, data, idx)
	self.playerHead:checkRobotInfo(Const.ROLEINFO_ROBOT_TYPE_ASYNCPVP)
end

function PVPRankCell:extend(visible)
	local showImmediately = visible

	if visible then
		local uid = self.data.data.comm.uid

		if not CurAvatar.rankFormation[uid] or Time.time - CurAvatar.rankFormation[uid].tick >= ResAsyncPvpMisc[1].tick then
			RPC.asyncPVPGetDetail({
				uid
			})

			showImmediately = false
		else
			self.formation:initData(CurAvatar.rankFormation[uid].formation)
			self:refreshPower()
		end
	end

	self.formation:setVisible(showImmediately)

	if visible then
		self:setLayoutSize(nil, MAX_HEIGHT)
	else
		self:setLayoutSize(nil, INIT_HEIGHT)
	end
end

function PVPRankCell:refreshPower(power)
	local uid = self.data.data.comm.uid

	if uid == CurAvatar.uid then
		power = CurAvatar:getAsyncPVPFormationCapacity()

		self.txtPower:setText(power or 0)
	elseif not CurAvatar.rankFormation[uid] or Time.time - CurAvatar.rankFormation[uid].tick >= ResAsyncPvpMisc[1].tick then
		self.txtPower:setText(power or 0)
	else
		local formationPower = CapacityHelper.getFormationCapacity(CurAvatar.rankFormation[uid].formation)

		self.txtPower:setText(formationPower)
	end
end

return PVPRankCell
