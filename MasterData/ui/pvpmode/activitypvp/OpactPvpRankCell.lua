-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ActivityPVP\\OpactPvpRankCell.lua

local SeniorFormationPanel = require("UI/PVPMode/SeniorPVP/SeniorFormationPanel")
local PVPCommon = require("Logic/PVP/PVPCommon")
local strClassName = "OpactPvpRankCell"
local OpactPvpRankCell = Class(strClassName, UIControls.BtnPlayerRankCellLoop)
local INIT_HEIGHT = 122
local MAX_HEIGHT = 466

function OpactPvpRankCell:ctor(...)
	self:_initUI()
end

function OpactPvpRankCell:_initUI(...)
	self.btnTeam = UIControls.Button(self, "BgPanel/BtnTeam")

	self.btnTeam:addEventClick(self.onBtnTeamClick)

	self.btnChallenge = UIControls.Button(self, "BgPanel/BtnChallenge", "Text")

	self.btnChallenge:addEventClick(self.onBtnChallengeClick)

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

function OpactPvpRankCell:setData(data, idx)
	if data.data.comm.uid == CurAvatar.uid then
		data.data.power = PVPCommon.getOpactPvpDefendPower()
	end

	OpactPvpRankCell.super.setData(self, data, idx)

	local info = PVPCommon.getPartInfoByScore(data.data.score)

	if info then
		PVPCommon.setRankUI(self.rankUIData, info)
	end

	self.isOpactFighted = PVPCommon.isOpactPvpChallenged(self.data.data.comm.uid)

	if self.data.data.comm.uid == CurAvatar.uid then
		self.btnChallenge:setVisible(false)
	else
		self.btnChallenge:setVisible(true)

		if self.isOpactFighted then
			self.btnChallenge:setText(Lang.get(30655))
			self.btnChallenge:setEnable(false)
			self.btnChallenge:setImage("Atlas/OtherBattleAtlas/ActivityPVPAtlas/ActivityPVPAtlas", "BtnBattleDis")
		else
			self.btnChallenge:setText(Lang.get(217))
			self.btnChallenge:setEnable(true)
			self.btnChallenge:setImage("Atlas/OtherBattleAtlas/ActivityPVPAtlas/ActivityPVPAtlas", "BtnBattleNml")
		end
	end
end

function OpactPvpRankCell:extend(v)
	if v then
		self:setLayoutSize(nil, MAX_HEIGHT)
		self:checkFormation()
	else
		self.panelTeamInfo:setVisible(false)
		self:setLayoutSize(nil, INIT_HEIGHT)
	end
end

function OpactPvpRankCell:checkFormation(...)
	local formation = CurAvatar:getOpactPvpFormation(self.data.data.comm.uid)

	if formation then
		self.panelFormation:setFormation(formation, false)
		self.panelTeamInfo:setVisible(true)
		self.panelFormation:setCommonHideMode()
	end
end

function OpactPvpRankCell:refreshPower(power)
	self.txtPower:setText(power)
end

function OpactPvpRankCell:onBtnTeamClick(...)
	local result, hint = PVPCommon.isOpactPvpValid()

	if not result then
		MsgManager.notice(hint)

		return
	end

	self.mParent:extendCell(self.idx)
end

function OpactPvpRankCell:onBtnChallengeClick(...)
	local result, hint = PVPCommon.isOpactPvpValid()

	if not result then
		MsgManager.notice(hint)

		return
	end

	local formation = CurAvatar:getNowFormation(Const.FORMATION_MULTIPVP_DEFEND_1)

	if formation == nil or next(formation) == nil then
		formation = CurAvatar:getNowFormation(Const.FORMATION_OPACTPVP_DEFEND_1)

		if formation == nil or next(formation) == nil then
			MsgManager.clientNotice(326)

			return
		end
	end

	local leftTimes = PVPCommon.getLeftChallengeTimes()

	if leftTimes <= 0 then
		MsgManager.clientNotice(320)

		return
	end

	CurAvatar.opactPvpReadyFightUid = self.data.data.comm.uid
	ClientUtils.record.opactPvpCacheData = {}
	ClientUtils.record.opactPvpCacheData.rank = CurAvatar.opactPvpRank

	local actData = CurAvatar:getPVPArenaActivityData()
	local score = 0

	if actData then
		score = actData.score
	end

	ClientUtils.record.opactPvpCacheData.score = score
	ClientUtils.record.opactPvpCacheData.comm = self.data.data.comm

	local actId = CurAvatar:getPVPArenaActivityOpId()

	if actId then
		RPC.opactArenaDetailGet(actId, self.data.data.comm.uid)
	end
end

return OpactPvpRankCell
