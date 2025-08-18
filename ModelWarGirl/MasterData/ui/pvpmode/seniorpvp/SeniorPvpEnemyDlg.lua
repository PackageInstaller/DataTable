-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\SeniorPVP\\SeniorPvpEnemyDlg.lua

local SeniorFormationPanel = require("UI/PVPMode/SeniorPVP/SeniorFormationPanel")
local PVPCommon = require("Logic/PVP/PVPCommon")
local ResMultiPVPMisc = require("ClientData/ResMultiPVPMisc")
local ResColor = require("ClientData/ResColor")
local ResItem = require("ClientData/ResItem")
local BtnSeniorPvpEnemyCell = Class("BtnSeniorPvpEnemyCell", UIControls.ScrollViewLoopCell)
local INIT_HEIGHT = 130
local MAX_HEIGHT = 460
local ticketId = ResMultiPVPMisc[1].item_id

function BtnSeniorPvpEnemyCell:ctor(...)
	self:initUI()
end

function BtnSeniorPvpEnemyCell:initUI(...)
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BtnPVPEnemy/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnTeam = UIControls.Button(self, "BtnPVPEnemy/BtnTeam")

	self.btnTeam:addEventClick(self.onBtnTeamClick)

	self.btnBattle = UIControls.Button(self, "BtnPVPEnemy/BtnBattle", "Text")

	self.btnBattle:addEventClick(self.onBtnBattleClick)

	self.txtName = UIControls.Label(self, "BtnPVPEnemy/TextPlayerName")
	self.txtPower = UIControls.Label(self, "BtnPVPEnemy/TextPower")
	self.txtAwardNum = UIControls.Label(self, "BtnPVPEnemy/AwardSpeedPanel/TextNum")
	self.txtTicketNum = UIControls.Label(self, "BtnPVPEnemy/BtnBattle/TextNum")
	self.imgAwardIcon = UIControls.Image(self, "BtnPVPEnemy/AwardSpeedPanel/Icon")
	self.imgBattleIcon = UIControls.Image(self, "BtnPVPEnemy/BtnBattle/Icon")
	self.panelTeamInfo = UIControls.Panel(self, "TeamInfo")
	self.panelFormation = SeniorFormationPanel(self, "TeamInfo/TeamInfoPanel")
	self.rankUIData = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "BtnPVPEnemy"

	for i, name in ipairs(uiNames) do
		self.rankUIData[i] = UIControls.Image(self, path .. name)
	end
end

function BtnSeniorPvpEnemyCell:setData(data)
	self.data = data
	self.baseData = data.baseData

	self:_initUIData()
end

function BtnSeniorPvpEnemyCell:_initUIData(...)
	local name = utils.GetPlayerName(self.baseData.comm.name)

	self.txtName:setText(name)
	self.txtPower:setText(self.baseData.power)
	self.btnHead:setCommInfo(self.baseData.comm, true, self)
	self.btnHead:checkRobotInfo(Const.ROLEINFO_ROBOT_TYPE_MULTIPVP)

	if self:isFree() == false then
		self.imgBattleIcon:setVisible(true)
		self.txtTicketNum:setVisible(true)
		self.btnBattle:setText(Lang.get(217))
		self.txtTicketNum:setText(1)

		if self:isTicketEnough() then
			self.txtTicketNum:setFontColor(ResColor.WHITE)
		else
			self.txtTicketNum:setFontColor(ResColor.RED)
		end
	else
		self.imgBattleIcon:setVisible(false)
		self.txtTicketNum:setVisible(false)
		self.btnBattle:setText(Lang.get(30657))
	end

	local info = PVPCommon.getRankPartInfo(CurAvatar.seniorPvpData.rank)
	local otherInfo = PVPCommon.getRankPartInfo(self.baseData.rank)

	PVPCommon.setRankUI(self.rankUIData, otherInfo)

	local path = PVPCommon.getSeniorPvpAwardIcon()

	self.imgAwardIcon:setImage(path[1], path[2])

	path = PVPCommon.getMultiPvpTicketIconPath()

	self.imgBattleIcon:setImage(path[1], path[2])
	self.txtAwardNum:setText(PVPCommon.getSpeedStr(otherInfo.award_speed - info.award_speed, true))
	self:extend(self.data.extend)
end

function BtnSeniorPvpEnemyCell:isTicketEnough(...)
	return CurAvatar:getItemNumById(ticketId) > 0
end

function BtnSeniorPvpEnemyCell:isFree(...)
	return CurAvatar:getMultiPvpCounter(Const.DayMultiPvpCountId) < PVPCommon.getSeniorPvpDailyFreeTimes()
end

function BtnSeniorPvpEnemyCell:extend(v)
	if v then
		self:setLayoutSize(nil, MAX_HEIGHT)
		self:checkFormation()
	else
		self.panelTeamInfo:setVisible(false)
		self:setLayoutSize(nil, INIT_HEIGHT)
	end
end

function BtnSeniorPvpEnemyCell:refreshPower(formation)
	local power = PVPCommon.getFormationPower(formation)

	if self.baseData.power == power then
		-- block empty
	else
		self.baseData.power = power

		self.txtPower:setText(self.baseData.power)
	end
end

function BtnSeniorPvpEnemyCell:checkFormation(...)
	if self.data.robotFormation then
		self:refreshPower(self.data.robotFormation)
		self.panelFormation:setFormation(self.data.robotFormation, false)
		self.panelTeamInfo:setVisible(true)

		return
	end

	local formation = CurAvatar:getSeniorPvpFormation(self.baseData.comm.uid)

	if formation then
		self:refreshPower(formation)
		self.panelFormation:setFormation(formation, false)
		self.panelTeamInfo:setVisible(true)
	end
end

function BtnSeniorPvpEnemyCell:onBtnBattleClick(...)
	if self:isTicketEnough() == false and self:isFree() == false then
		local itemName = ResItem[ticketId] and ResItem[ticketId].name or ""

		MsgManager.notice(string.format(Lang.get(30029), itemName))

		return
	end

	CurAvatar.seniorPvpReadyFightUid = self.baseData.comm.uid

	RPC.multiPVPTargetCache(self.baseData.comm.uid)

	ClientUtils.record.seniorPvpCacheData = {
		comm = self.baseData.comm,
		otherRank = self.baseData.rank
	}
end

function BtnSeniorPvpEnemyCell:onBtnTeamClick(...)
	self.mWindow:onCellExtendChange(self.data)
end

local strClassName = "SeniorPvpEnemyDlg"
local SeniorPvpEnemyDlg = Class(strClassName, UIControls.Window)

function SeniorPvpEnemyDlg:ctor()
	self:iniUI()
	self:initData()
end

function SeniorPvpEnemyDlg:iniUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnRefresh = UIControls.Button(self, "BgPanel/BtnRefresh")

	self.btnRefresh:addEventClick(self.onBtnRefreshClick)

	self.txtPower = UIControls.Label(self, "BgPanel/TextPower")
	self.txtPowerNone = UIControls.Label(self, "BgPanel/TextPowerNone")
	self.txtTicketNum = UIControls.Label(self, "BgPanel/TicketNumPanel/TextNum")
	self.txtRefresh = UIControls.Label(self, "BgPanel/BtnRefresh/Text")
	self.imgTicket = UIControls.Image(self, "BgPanel/TicketNumPanel/Icon")
	self.panelEmpty = UIControls.Panel(self, "BgPanel/NoContent")
	self.panelNoEnemy = UIControls.Panel(self, "BgPanel/NoEnemy")
	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/EnemyList", 0, self.onCellChanged)
end

function SeniorPvpEnemyDlg:show(...)
	self:refreshData()
	self:refreshUI()
end

function SeniorPvpEnemyDlg:initData(...)
	local path = PVPCommon.getMultiPvpTicketIconPath()

	self.imgTicket:setImage(path[1], path[2])
end

function SeniorPvpEnemyDlg:refreshUI(...)
	local power = 0

	for i = 1, 3 do
		power = power + CurAvatar:getNowFormationCapacity(Const["FORMATION_MULTIPVP_ATTACK_" .. i])
	end

	if power > 0 then
		self.txtPower:setText(power)
	end

	self.txtPower:setVisible(power > 0)
	self.txtPowerNone:setVisible(power == 0)

	if #self.matchData == 0 then
		if CurAvatar.seniorPvpData.rank == 1 then
			self.panelNoEnemy:setVisible(true)
			self.btnRefresh:setVisible(false)
		else
			self.panelEmpty:setVisible(true)
		end
	else
		self.panelNoEnemy:setVisible(false)
		self.panelEmpty:setVisible(false)
	end

	self.txtTicketNum:setText(PVPCommon.getTicketNum())
end

function SeniorPvpEnemyDlg:refreshData(...)
	local matchData = ClientUtils.record.seniorPvpMatchData

	self.matchData = {}

	local info

	for _, data in ipairs(matchData) do
		info = {
			baseData = data
		}
		info.extend = false

		if utils.isRobot(data.comm.uid) then
			data.comm = PVPCommon.getMultiPvpRobotCommInfo(data.comm.uid)
			info.robotFormation = PVPCommon.getMultiPvpRobotServerFormation(data.comm.uid)
			data.power = PVPCommon.getFormationPower(info.robotFormation)
		end

		table.insert(self.matchData, info)
	end

	table.sort(self.matchData, function(v1, v2)
		return v1.baseData.rank < v2.baseData.rank
	end)
	self:checkCD()
	self:refreshList()
end

function SeniorPvpEnemyDlg:refreshList(...)
	self.scrollView:setTotalCount(#self.matchData)
end

function SeniorPvpEnemyDlg:onCellExtendChange(data)
	for _, info in ipairs(self.matchData) do
		if info == data then
			info.extend = not info.extend
		else
			info.extend = false
		end
	end

	self:refreshList()
end

function SeniorPvpEnemyDlg:checkCD(...)
	local leftTime = self:getLeftTime()

	if leftTime < 0 then
		-- block empty
	elseif self.timer ~= nil then
		self.timer:Restart()
	else
		self.timer = Timer.New(Slot(self._timeDown, self), 0, -1)

		self.timer:Start()
	end
end

function SeniorPvpEnemyDlg:_timeDown()
	local leftTime = self:getLeftTime()

	if leftTime < 0 then
		self.txtRefresh:setText(Lang.get(296))
		self.timer:Pause()
	else
		self.txtRefresh:setText(string.format(Lang.get(30650), leftTime))
	end
end

function SeniorPvpEnemyDlg:getLeftTime(...)
	return (ClientUtils.record.seniorPvpNextMatchTime or 0) - ClientUtils.getServerTime()
end

function SeniorPvpEnemyDlg:destroy(...)
	SeniorPvpEnemyDlg.super.destroy(self)

	if self.timer then
		self.timer:Stop()
	end
end

function SeniorPvpEnemyDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BtnSeniorPvpEnemyCell(sender, "System/AsynPVP/BtnSeniorPVPEnemy", newIdx, 0, 0)
	end

	targetCell.index = newIdx

	targetCell:setData(self.matchData[newIdx])
end

function SeniorPvpEnemyDlg:onBtnRefreshClick(...)
	local leftTime = self:getLeftTime()

	if leftTime > 0 then
		MsgManager.notice(Lang.get(30658))
	else
		RPC.multiPVPMatch()
	end
end

function SeniorPvpEnemyDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

return SeniorPvpEnemyDlg
