-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\SeniorPVP\\SeniorPvpRecordDlg.lua

local SeniorFormationPanel = require("UI/PVPMode/SeniorPVP/SeniorFormationPanel")
local PVPCommon = require("Logic/PVP/PVPCommon")
local BattleConst = require("Common/FrameBattle/BattleConst")
local BtnSeniorPvpRecordCell = Class("BtnSeniorPvpRecordCell", UIControls.ScrollViewLoopCell)
local INIT_HEIGHT = 130
local MAX_HEIGHT = 460
local ICON_PATH = "Atlas/OtherBattleAtlas/AsynPVPAtlas2"
local ICON_PATH2 = "Atlas/OtherBattleAtlas/AsynPVPAtlas"
local ICON_PATH3 = "Atlas/OtherBattleAtlas/SeniorPVPAtlas/SeniorPVPAtlas2"

function BtnSeniorPvpRecordCell:ctor(...)
	self:initUI()
end

function BtnSeniorPvpRecordCell:initUI(...)
	self.imgBg = UIControls.Image(self, "BtnPVPRecord/Bg")
	self.imgType = UIControls.Image(self, "BtnPVPRecord/ImgType")
	self.imgTypeDes = UIControls.Image(self, "BtnPVPRecord/ImgTypeDes")
	self.imgResult = UIControls.Image(self, "BtnPVPRecord/ImgResult")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BtnPVPRecord/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnTeam = UIControls.Button(self, "BtnPVPRecord/BtnTeam")

	self.btnTeam:addEventClick(self.onBtnTeamClick)

	self.btnReplay = UIControls.Button(self, "BtnPVPRecord/BtnReplay")

	self.btnReplay:addEventClick(self.onBtnReplayClick)

	self.txtTime = UIControls.Label(self, "BtnPVPRecord/TextTime")
	self.txtPlayerName = UIControls.Label(self, "BtnPVPRecord/TextPlayerName")
	self.panelTeamInfo = UIControls.Panel(self, "TeamInfo")
	self.panelFormation = SeniorFormationPanel(self, "TeamInfo/TeamInfoPanel")
	self.rankUIData = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "BtnPVPRecord"

	for i, name in ipairs(uiNames) do
		self.rankUIData[i] = UIControls.Image(self, path .. name)
	end
end

function BtnSeniorPvpRecordCell:setData(data)
	self.data = data
	self.baseData = data.baseData

	self:_initUIData()
end

function BtnSeniorPvpRecordCell:_initUIData(...)
	local name = utils.GetPlayerName(self.baseData.data.comm.name)

	self.txtPlayerName:setText(name)

	local info = PVPCommon.getRankPartInfo(self.baseData.data.rank)

	PVPCommon.setRankUI(self.rankUIData, info)
	self.btnHead:setCommInfo(self.baseData.data.comm, true, self)
	self.btnHead:checkRobotInfo(Const.ROLEINFO_ROBOT_TYPE_MULTIPVP)

	if self.baseData.replay_id ~= "0" then
		self.btnReplay:setVisible(true)
	else
		self.btnReplay:setVisible(false)
	end

	local isAttack = self.baseData.attack == 1

	self.isMyAttack = isAttack

	local isWin = self.baseData.result == 1

	if isAttack then
		self.imgType:setImage(ICON_PATH3, "TxtAttack")
		self.imgTypeDes:setImage(ICON_PATH, "BgAttack")
	else
		self.imgType:setImage(ICON_PATH3, "TxtDefense")
		self.imgTypeDes:setImage(ICON_PATH, "BgDefense")
	end

	if isWin then
		self.imgResult:setImage(ICON_PATH, "IconWin")
		self.imgBg:setImage(ICON_PATH3, "BgRank1")
	else
		self.imgResult:setImage(ICON_PATH, "IconDefeat")
		self.imgBg:setImage(ICON_PATH3, "BgRankOther")
	end

	self.txtTime:setText(ClientUtils.timeFormat4Record(ClientUtils.getServerTime() - self.baseData.tick))
	self:extend(self.data.extend)
end

function BtnSeniorPvpRecordCell:extend(v)
	if v then
		if self.baseData.replay_id == "0" then
			MsgManager.notice(Lang.get(30660))

			return
		end

		self:setLayoutSize(nil, MAX_HEIGHT)
		self:checkFormation()
	else
		self.panelTeamInfo:setVisible(false)
		self:setLayoutSize(nil, INIT_HEIGHT)
	end
end

function BtnSeniorPvpRecordCell:checkFormation(...)
	if self.data.robotFormation then
		self.panelFormation:setFormation(self.data.robotFormation, false)
		self.panelTeamInfo:setVisible(true)

		return
	end

	local formationData, petData = CurAvatar:getTeamPvpReplayInfo(self.baseData.replay_id, true)

	if formationData then
		local camp = self.isMyAttack and BattleConst.CAMP_MONSTER or BattleConst.CAMP_PLAYER
		local heros = {}
		local pets = {}

		for i, info in ipairs(formationData) do
			heros[i] = {}

			local data = info[camp]

			if data then
				for _, hero in ipairs(data) do
					table.insert(heros[i], hero)
				end
			end

			if petData[i] and petData[i][camp] then
				pets[i] = petData[i][camp]
			end
		end

		self.panelFormation:setHeros(heros, false, pets)
		self.panelTeamInfo:setVisible(true)
	end
end

function BtnSeniorPvpRecordCell:onBtnReplayClick(...)
	CurAvatar.cachedSeniorPvpReplayData = self.baseData

	local replayEnv = {}

	replayEnv.replayId = self.baseData.replay_id

	GameFsm.getState(Const.STATE_BATTLE_REPLAY):recordReplayEnv(replayEnv)
	CurAvatar:getTeamPvpReplayInfo(self.baseData.replay_id, false)
end

function BtnSeniorPvpRecordCell:onBtnTeamClick(...)
	self.mWindow:onCellExtendChange(self.data)
end

local strClassName = "SeniorPvpRecordDlg"
local SeniorPvpRecordDlg = Class(strClassName, UIControls.Window)

function SeniorPvpRecordDlg:ctor(...)
	self:initUI()
end

function SeniorPvpRecordDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.panelEmpty = UIControls.Panel(self, "BgPanel/NoContent")
	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/RecordList", 0, self.onCellChanged)
end

function SeniorPvpRecordDlg:show(...)
	local reports = ClientUtils.record.seniorPvpReports

	self.reports = {}

	for _, data in ipairs(reports) do
		local info = {}

		info.baseData = data
		info.extend = false

		if utils.isRobot(data.data.comm.uid) then
			data.data.comm = PVPCommon.getMultiPvpRobotCommInfo(data.data.comm.uid)
			info.robotFormation = PVPCommon.getMultiPvpRobotServerFormation(data.data.comm.uid)
		end

		table.insert(self.reports, info)
	end

	table.sort(self.reports, function(v1, v2)
		return v1.baseData.tick > v2.baseData.tick
	end)
	self.panelEmpty:setVisible(#self.reports == 0)
	self:refreshList()
end

function SeniorPvpRecordDlg:refreshList(...)
	self.scrollView:setTotalCount(#self.reports)
end

function SeniorPvpRecordDlg:onCellExtendChange(data)
	for _, info in ipairs(self.reports) do
		if info == data then
			info.extend = not info.extend
		else
			info.extend = false
		end
	end

	self:refreshList()
end

function SeniorPvpRecordDlg:recoveryFromReplay(replayEnv)
	local idx = 0

	for i, data in ipairs(self.reports) do
		if data.baseData.replay_id == replayEnv.replayId then
			idx = i

			break
		end
	end

	if idx > 0 then
		self.scrollView:scrollToCell(idx)
		CurAvatar:getTeamPvpReplayInfo(self.reports[idx].baseData.replay_id, false)
	end
end

function SeniorPvpRecordDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BtnSeniorPvpRecordCell(sender, "System/AsynPVP/BtnSeniorPVPRecord", newIdx, 0, 0)
	end

	targetCell.index = newIdx

	targetCell:setData(self.reports[newIdx])
end

function SeniorPvpRecordDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

return SeniorPvpRecordDlg
