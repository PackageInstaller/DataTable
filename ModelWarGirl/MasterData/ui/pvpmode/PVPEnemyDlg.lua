-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPEnemyDlg.lua

local ResAsyncPVPMisc = require("ClientData/ResAsyncPVPMisc")
local UserData = require("Helper/UserData")
local ResColor = require("ClientData/ResColor")
local Formation = require("UI/PVPMode/Formation")
local ResItem = require("ClientData/ResItem")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")
local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "PVPEnemyDlg"
local PVPEnemyDlg = Class(strClassName, UIControls.Window)
local PVPEnemyCell = Class("PVPEnemyCell", UIControls.ScrollViewLoopCell)
local sweepItem = ResAsyncPVPMisc[1].sweep_item
local sweepConTimes = ResAsyncPVPMisc[1].sweep_con_times
local INIT_HEIGHT = 130
local MAX_HEIGHT = 395
local config = UIConst.MONEY_ID2INFO[Const.MONEY_ID_PVP_TICKET]

function PVPEnemyCell:ctor()
	self:initUI()
end

function PVPEnemyCell:initUI()
	self.txtPlayerName = UIControls.Label(self, "BtnPVPEnemy/TextPlayerName")
	self.txtPower = UIControls.Label(self, "BtnPVPEnemy/TextPowerTitle/TextPower")
	self.txtScore = UIControls.Label(self, "BtnPVPEnemy/TextScore")
	self.btnTeam = UIControls.Button(self, "BtnPVPEnemy/BtnTeam")

	self.btnTeam:addEventClick(self.onBtnTeamClick)

	self.btnBattle = UIControls.Button(self, "BtnPVPEnemy/BtnBattle", "Text")

	self.btnBattle:addEventClick(self.onBtnBattleClick)

	self.btnBattle.imgIcon = UIControls.Image(self, "BtnPVPEnemy/BtnBattle/Icon")

	self.btnBattle.imgIcon:setImage(config[1], config[2])

	self.btnBattle.txtNum = UIControls.Label(self, "BtnPVPEnemy/BtnBattle/TextNum")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BtnPVPEnemy/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.formation = Formation(self, "TeamInfo")
end

local challengeType = {
	CHALLENGE = 2,
	CLEAN = 1
}

function PVPEnemyCell:initData(enemyData)
	self.enemyData = enemyData

	local data = enemyData.data
	local uid = data.base.comm.uid
	local power = data.base.power

	if CurAvatar.rankFormation and CurAvatar.rankFormation[uid] then
		data.formation = CurAvatar.rankFormation[uid].formation
	end

	if data.formation then
		self.formation:initData(data.formation)

		power = CapacityHelper.getFormationCapacity(data.formation)
	end

	self.txtPower:setText(power)

	self.power = power

	self.txtScore:setText(data.score)

	if CurAvatar:getPvpCounter(Const.DayPvpCountId) >= CurAvatar:getPvpFreeCount() then
		self.btnBattle.imgIcon:setVisible(true)
		self.btnBattle.txtNum:setText(1)
		self.btnBattle.txtNum:setVisible(true)

		if self:isCleanMode(self.enemyData) then
			self.btnBattle:setText(Lang.get(82))

			self.challengeType = challengeType.CLEAN
		else
			self.btnBattle:setText(Lang.get(217))

			self.challengeType = challengeType.CHALLENGE
		end
	else
		self.btnBattle.imgIcon:setVisible(false)
		self.btnBattle.txtNum:setVisible(true)
		self.btnBattle.txtNum:setText(Lang.get(1261))

		if self:isCleanMode(self.enemyData) then
			self.btnBattle:setText(Lang.get(82))

			self.challengeType = challengeType.CLEAN
		else
			self.btnBattle:setText(Lang.get(217))

			self.challengeType = challengeType.CHALLENGE
		end
	end

	if CurAvatar:getItemNumById(sweepItem) > 0 or CurAvatar:getPvpCounter(Const.DayPvpCountId) < CurAvatar:getPvpFreeCount() then
		self.btnBattle.txtNum:setFontColor(ResColor.WHITE)
	else
		self.btnBattle.txtNum:setFontColor(ResColor.RED)
	end

	local name = utils.GetPlayerName(data.base.comm.name)

	self.txtPlayerName:setText(name)
	self.btnHead:setCommInfo(data.base.comm, true, self)
	self.btnHead:checkRobotInfo(Const.ROLEINFO_ROBOT_TYPE_ASYNCPVP)
	self:extend(self.enemyData.extend)
end

function PVPEnemyCell:onBtnBattleClick(...)
	if CurAvatar:getItemNumById(sweepItem) <= 0 and CurAvatar:getPvpCounter(Const.DayPvpCountId) >= CurAvatar:getPvpFreeCount() then
		local itemName = ResItem[sweepItem] and ResItem[sweepItem].name or ""

		MsgManager.notice(string.format(Lang.get(30029), itemName))

		return
	end

	if self.challengeType == challengeType.CLEAN then
		CurAvatar.cachedSweepData = {
			name = self.enemyData.data.base.comm.name,
			formation = self.enemyData.data.formation,
			level = self.enemyData.data.base.comm.level,
			head = self.enemyData.data.base.comm.head,
			headFrameId = self.enemyData.data.base.comm.head_frame_id,
			power = self.power
		}

		RPC.asyncPVPSweep(self.enemyData.data.base.comm.uid)
		self.mWindow:refreshListData(self.index, self.enemyData.data.base.comm.uid)
		self.mWindow:randomRefresh()
	else
		RPC.asyncPVPTargetCache(self.enemyData.data.base.comm.uid)
		self.mWindow:refreshListData(self.index, self.enemyData.data.base.comm.uid)
	end
end

function PVPEnemyCell:isCleanMode(data)
	return self.mWindow:isCleanMode(data)
end

function PVPEnemyCell:onBtnTeamClick()
	self.mWindow:clearSelect(self.enemyData)
end

function PVPEnemyCell:isNeedRequest(uid)
	if not CurAvatar.rankFormation[uid] or Time.time - CurAvatar.rankFormation[uid].tick >= Const.FORMATION_GET_INTERVAL then
		local uids = self.mWindow:getUids(true)
		local result = false

		if #uids > 0 then
			RPC.asyncPVPGetDetail(uids)

			result = true
		end

		return result
	else
		return false
	end
end

function PVPEnemyCell:extend(v)
	if v then
		self:setLayoutSize(nil, MAX_HEIGHT)

		local uid = self.enemyData.data.base.comm.uid

		if self:isNeedRequest(uid) then
			self.formation:setVisible(false)
		else
			self.formation:setVisible(true)
		end
	else
		self.formation:setVisible(v)
		self:setLayoutSize(nil, INIT_HEIGHT)
	end
end

function PVPEnemyDlg:ctor()
	self:initUI()
end

function PVPEnemyDlg:initUI()
	self.txtPower = UIControls.Label(self, "BgPanel/TextPower")
	self.btnRefresh = UIControls.Button(self, "BgPanel/BtnRefresh")

	self.btnRefresh:addEventClick(self.onBtnRefreshClick)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/EnemyList", 0, self.onCellChanged)
	self.imgEmpty = UIControls.Image(self, "BgPanel/NoContent")
	self.imgTicketIcon = UIControls.Image(self, "BgPanel/TicketNumPanel/Icon")

	self.imgTicketIcon:setImage(config[1], config[2])

	self.txtTicketNum = UIControls.Label(self, "BgPanel/TicketNumPanel/TextNum")
	self.enemyDatas = {}

	self:refreshTicketNum()
	self:setMyPower()
end

function PVPEnemyDlg:show(refresh)
	self:initData(refresh)
	self:setMyPower()
end

function PVPEnemyDlg:onOpen(...)
	PVPEnemyDlg.super.onOpen(self)
	self:refreshScore()
end

function PVPEnemyDlg:refreshScore(...)
	if not CurAvatar.pvpScoreRefreshTime or ClientUtils.getServerTime() - CurAvatar.pvpScoreRefreshTime > Const.PVP_SCORE_GET_INTERVAL then
		local uids = self:getUids()

		if #uids > 0 then
			RPC.asyncPVPScore(uids)
		end

		CurAvatar.pvpScoreRefreshTime = ClientUtils.getServerTime()
	end

	self:refreshList()
end

function PVPEnemyDlg:refreshTicketNum()
	self.txtTicketNum:setText(CurAvatar:getItemNumById(sweepItem))
end

function PVPEnemyDlg:getUids(isFormation)
	local uids = {}

	if isFormation then
		if self.showEnemyDatas then
			local map = {}

			for _, data in ipairs(self.showEnemyDatas) do
				local uid = data.data.base.comm.uid

				if (not CurAvatar.rankFormation[uid] or Time.time - CurAvatar.rankFormation[uid].tick >= Const.FORMATION_GET_INTERVAL) and not map[uid] then
					table.insert(uids, uid)

					map[uid] = true
				end
			end
		end
	elseif ClientUtils.record.allOpponent then
		for _, opponents in pairs(ClientUtils.record.allOpponent) do
			for _, data in pairs(opponents) do
				table.insert(uids, data.data.base.comm.uid)
			end
		end
	end

	return uids
end

function PVPEnemyDlg:initData(refresh)
	for _, d in ipairs(ClientUtils.record.allOpponent) do
		for id, enemy in ipairs(d) do
			-- block empty
		end
	end

	ClientUtils[CurAvatar.uid] = ClientUtils[CurAvatar.uid] or {}

	if refresh or self.showEnemyDatas == nil then
		self.showEnemyDatas = {}
	end

	self:refreshTicketNum()
	self:onBtnRefreshClick(true)
end

function PVPEnemyDlg:setMyPower(...)
	local power = CurAvatar:getNowFormationCapacity(Const.FORMATION_MAIN_STAGE)

	self.txtPower:setText(power)
end

function PVPEnemyDlg:setEmpty(v)
	self.imgEmpty:setVisible(v)
end

function PVPEnemyDlg:isCleanMode(data)
	if CurAvatar.pvpAttackTimes < sweepConTimes then
		return false
	end

	return data.canClean == true
end

function PVPEnemyDlg:dataSort()
	if #self.showEnemyDatas == 0 then
		return
	end

	table.sort(self.showEnemyDatas, function(v1, v2)
		local canClean1 = self:isCleanMode(v1)
		local canClean2 = self:isCleanMode(v2)

		if canClean2 == canClean1 then
			return v1.data.score > v2.data.score
		elseif canClean1 == true then
			return false
		else
			return true
		end
	end)
end

local MIN_MATCH_COUNT = Const.ASYNC_PVP_MATCH_SHOW_COUNT

function PVPEnemyDlg:onBtnRefreshClick(canReq)
	self:setMyPower()

	if not ClientUtils.record.allOpponent then
		return
	end

	local totalMatch = self:totalNum(ClientUtils.record.allOpponent)

	if canReq == false or CurAvatar.nextMatchTick > ClientUtils.getServerTime() then
		local matchedMap = {}

		self.showEnemyDatas = {}

		local num = 0

		if totalMatch <= MIN_MATCH_COUNT then
			for _, k in ipairs(ClientUtils.record.allOpponent) do
				for _, v in ipairs(k) do
					table.insert(self.showEnemyDatas, v)

					ClientUtils.record.pvpMatchedUids[v.data.base.comm.uid] = true
				end
			end
		else
			local maxIndex = 1
			local maxCount = 0
			local enough = true
			local more = 2

			for i = 1, 3 do
				if maxCount <= #ClientUtils.record.allOpponent[i] then
					maxIndex = i
					maxCount = #ClientUtils.record.allOpponent[i]
				end

				if #ClientUtils.record.allOpponent[i] < 2 then
					enough = false
					more = more + 2 - #ClientUtils.record.allOpponent[i]
				end
			end

			local result = {}
			local needCount = 2

			for i = 1, 3 do
				num = 0

				local total = #ClientUtils.record.allOpponent[i]

				if enough then
					needCount = 2
				elseif i == maxIndex then
					needCount = more
				else
					needCount = 2
				end

				result = self:_getRandomOpponents(ClientUtils.record.allOpponent[i], needCount, true)

				for _, v in ipairs(result) do
					matchedMap[v.data.base.comm.uid] = true

					table.insert(self.showEnemyDatas, v)
				end
			end
		end

		ClientUtils.record.pvpMatchedUids = matchedMap

		self:dataSort()
		self:clearSelect()
		self.scrollView:setTotalCount(#self.showEnemyDatas)
	else
		ClientUtils.record.pvpMatchedUids = {}

		RPC.asyncPVPMatch()
	end
end

function PVPEnemyDlg:randomRefresh(...)
	self:onBtnRefreshClick(false)
end

function PVPEnemyDlg:_getRandomOpponents(data, needCount, canAllRandom)
	local total = #data

	if total <= needCount then
		return canAllRandom and data or {}
	end

	local tempData = {}
	local totalWeight = 0

	for _, v in ipairs(data) do
		table.insert(tempData, v)
	end

	local temp = {}

	for _, v in ipairs(data) do
		if not ClientUtils.record.pvpMatchedUids[v.data.base.comm.uid] then
			table.insert(temp, v)
		end
	end

	if needCount <= #temp then
		-- block empty
	elseif canAllRandom then
		temp = tempData
	else
		return {}
	end

	for _, v in ipairs(temp) do
		totalWeight = totalWeight + v.randomWeight
	end

	local result = {}
	local tempWeight = 0

	while needCount > #result do
		tempWeight = 0

		local randNum = math.random(totalWeight)

		for i = #temp, 1, -1 do
			tempWeight = tempWeight + temp[i].randomWeight

			if randNum <= tempWeight then
				totalWeight = totalWeight - temp[i].randomWeight

				table.insert(result, temp[i])
				table.remove(temp, i)

				break
			end
		end
	end

	return result
end

function PVPEnemyDlg:clearSelect(enemyData)
	for _, e in ipairs(self.showEnemyDatas) do
		if enemyData ~= e then
			e.extend = false
		elseif enemyData then
			enemyData.extend = not enemyData.extend
		end

		if enemyData == nil then
			-- block empty
		end
	end

	self.scrollView:setTotalCount(#self.showEnemyDatas)
end

function PVPEnemyDlg:refreshList()
	if ClientUtils[CurAvatar.uid] and self.showEnemyDatas then
		self:dataSort()
		self.scrollView:setTotalCount(#self.showEnemyDatas)
	end
end

function PVPEnemyDlg:refreshListData(removeIndex, lastUid)
	local index = math.ceil(removeIndex / 2)

	self.showEnemyDatas[removeIndex].randomWeight = math.max(1, self.showEnemyDatas[removeIndex].randomWeight - 50)
end

function PVPEnemyDlg:totalNum(t, isDict)
	local num = 0

	if isDict then
		if not t then
			return 0
		end

		for k, g in pairs(t) do
			if k then
				num = num + 1
			end
		end

		return num
	end

	for _, v in ipairs(t) do
		for _, k in ipairs(v) do
			if k then
				num = num + 1
			end
		end
	end

	return num
end

function PVPEnemyDlg:onBtnCloseClick()
	self:setVisible(false)
end

function PVPEnemyDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = PVPEnemyCell(sender, "System/AsynPVP/BtnPVPEnemy", newIdx, 0, 0)
	end

	targetCell.index = newIdx

	targetCell:initData(self.showEnemyDatas[newIdx])
end

return PVPEnemyDlg
