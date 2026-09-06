-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/escort/model/EscortModel.lua

module("logic.extensions.escort.model.EscortModel", package.seeall)

local EscortModel = class("EscortModel", BaseListModel)

function EscortModel:ctor()
	EscortModel.super.ctor(self)

	self.escortBaseInfo = nil
	self.battlePlayerList = nil
	self.escortReportList = nil
	self.isOpenEscort = false
	self.isPickupEscort = false
	self.nowTimeInfo = nil
	self.npcInfoList = nil
	self.isCanUpdata = true
	self.battlePlayer = nil
	self.isBattleJuan = false
	self.escortRedPoint = nil
	self.isDownTimer = false
	self.escortEndTimer = -1
	self.onceEndTimer = -1
	self.buzhengTimer = 30
end

function EscortModel:onInit()
	EscortModel.super.onInit(self)
	self:onReset()
end

function EscortModel:onReset()
	self.boxBaseCfg = EscortConfig.instance:GetBaxBaseInfo()

	removetimer(self.SetFunctionOpenTime, self)
	removetimer(self.SetEscortAndTaskTime, self)
	self:ResetEscortAndTaskTime()

	self.escortBaseInfo = nil
	self.battlePlayerList = nil
	self.escortReportList = nil
	self.isCanUpdata = true
	self.npcInfoList = nil
	self.nowTimeInfo = nil
	self.battlePlayer = nil
	self.isBattleJuan = false
	self.escortRedPoint = nil
	self.buzhengTimer = 30
end

function EscortModel:IsOpenEscortView()
	return self.isOpenEscort, self.escortEndTimer
end

function EscortModel:IsPickupEscort()
	return self.isPickupEscort, self.onceEndTimer
end

function EscortModel:GetEscortAndTaskTime()
	return self.escortEndTimer, self.onceEndTimer
end

function EscortModel:InitFunctionOpenTime()
	removetimer(self.SetFunctionOpenTime, self)
	self:SetFunctionOpenTime()
end

function EscortModel:SetFunctionOpenTime()
	local openTimes = self.boxBaseCfg.openTimeArr

	if openTimes == nil or #openTimes == 0 then
		return
	end

	local now = ServerTime.now()
	local startTime = -1
	local endTime = -1
	local tomorrowTime = 1

	for i, str in ipairs(openTimes) do
		local arr = string.split(str, "-")

		if arr and #arr == 2 then
			local timeLimitStart = "0-0-0 " .. arr[1]
			local timeLimitEnd = "0-0-0 " .. arr[2]
			local tmpTimeStart = GameUtil.string2time(timeLimitStart)
			local tmpTimeEnd = GameUtil.string2time(timeLimitEnd)
			local type = GameUtil.getTimePeriodTypeBySec(tmpTimeStart, tmpTimeEnd)

			if i == 1 then
				tomorrowTime = tmpTimeStart - now + 86400
			end

			if now < tmpTimeEnd then
				startTime = tmpTimeStart
				endTime = tmpTimeEnd

				break
			end
		end
	end

	local valueOff = 0
	local startOff = startTime - now

	if now < startTime then
		valueOff = startOff

		self:ResetEscortAndTaskTime()
	else
		local endOff = endTime - now

		if endOff > 0 then
			if startOff < 0 then
				if not self:JudgeOpenCondition() then
					self:ResetEscortAndTaskTime()
					settimer(2, self.SetFunctionOpenTime, self, false)

					return
				end

				valueOff = endOff

				if not self.isDownTimer then
					removetimer(self.SetEscortAndTaskTime, self)

					self.isOpenEscort = true
					self.isDownTimer = true
					self.escortEndTimer = endTime

					GlobalDispatcher:dispatch("UpdataCustomOpensItem", true, 1, endOff)
					RedPointController.instance:setRedPointInfo(RedPointModel.ID_Family_Escort, true, true, 0, self.escortEndTimer)
					settimer(1, self.SetEscortAndTaskTime, self, true)
					self:SetMainActivityRedpoint()
				end
			else
				valueOff = startOff

				self:ResetEscortAndTaskTime()
			end
		else
			valueOff = tomorrowTime
		end
	end

	local updataTime = 1

	if valueOff > 3600 then
		updataTime = 3600
	elseif valueOff > 120 then
		updataTime = 120
	elseif valueOff > 10 then
		updataTime = 10
	end

	settimer(updataTime, self.SetFunctionOpenTime, self, false)
end

function EscortModel:JudgeOpenCondition()
	if self:IsPickupEscort() then
		return true
	end

	if FamilyController.instance:getFamilyLv() <= 0 then
		return false
	end

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(91)

	if cfg == nil or string.nilorempty(cfg.openCondition) then
		return true
	end

	local list = string.split(cfg.openCondition, ",")

	if list == nil or #list == 0 then
		return true
	end

	local isOpen = FuncOpenController.instance:checkCondition(list)

	if cfg.bindFuncId <= 0 then
		return isOpen
	end

	if not isOpen then
		return false
	end

	local othCfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.bindFuncId)

	if othCfg == nil or string.nilorempty(othCfg.openCondition) then
		return isOpen
	end

	list = string.split(othCfg.openCondition, ",")

	if list == nil or #list == 0 then
		return isOpen
	end

	return FuncOpenController.instance:checkCondition(list)
end

function EscortModel:IsUnlockEscortStep(npcId)
	if not self:IsOpenEscortView() and not self:IsPickupEscort() then
		return
	end

	local infoList = self:GetRouteNpcInfoList()
	local index = 1

	for i = 1, #infoList do
		if infoList[i] and infoList[i].npcId == checknumber(npcId) then
			index = i

			break
		end
	end

	if index <= 1 then
		return true
	end

	if infoList[index - 1] and infoList[index - 1].isPass then
		return true
	end

	return false
end

function EscortModel:SetEscortAndTaskTime()
	local nowTime = ServerTime.now()

	if self.isOpenEscort and self.escortEndTimer - nowTime <= 0 then
		self.isOpenEscort = false
		self.escortEndTimer = -1

		GlobalDispatcher:dispatch("UpdataCustomOpensItem", false, 1)
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_Family_Escort, false)
	end

	if self.isPickupEscort and self.onceEndTimer - nowTime <= 0 then
		self.onceEndTimer = -1
		self.isPickupEscort = false

		GlobalDispatcher:dispatch("UpdataCustomBtnsItem", false, 1)
		SceneMgr.instance:enabledTransition()
		EscortController.instance:CSConvoyOverTimeReq()
	end

	if not self.isOpenEscort and not self.isPickupEscort then
		self:ResetEscortAndTaskTime()
		removetimer(self.SetEscortAndTaskTime, self)
	end
end

function EscortModel:ResetEscortAndTaskTime()
	self.isDownTimer = false
	self.isOpenEscort = false
	self.isPickupEscort = false
	self.escortEndTimer = -1
	self.onceEndTimer = -1
end

function EscortModel:GetRouteNpcInfoList()
	if self.npcInfoList == nil then
		self.npcInfoList = {}

		local npcs = self.boxBaseCfg.convoyLines
		local icons = self.boxBaseCfg.npcWhereMapIcon

		for i = 1, #npcs do
			local npcId = npcs[i] and tonumber(npcs[i]) or 0
			local cfg = SceneConfig.instance:getNpcCo(npcId)

			if cfg then
				table.insert(self.npcInfoList, {
					isPass = false,
					npcId = npcId,
					sceneId = cfg.sceneId,
					mapIcon = icons[i]
				})
			end
		end
	end

	local curIndex = self.escortBaseInfo and checknumber(self.escortBaseInfo.curProgIndex) or 0

	for i = 1, #self.npcInfoList do
		if self.npcInfoList[i] then
			self.npcInfoList[i].isPass = i <= curIndex
		end
	end

	return self.npcInfoList
end

function EscortModel:GetEscortNpcInfo(index)
	local infoList = self:GetRouteNpcInfoList()

	index = checknumber(index)

	local npcInfo = infoList[index]

	if npcInfo == nil or npcInfo.isPass then
		for i = 1, #infoList do
			if infoList[i] and not infoList[i].isPass then
				npcInfo = infoList[i]

				break
			end
		end
	end

	if npcInfo and not npcInfo.isPass then
		return npcInfo
	end
end

function EscortModel:GetNumByEscortNpcId(npcId)
	local infoList = self:GetRouteNpcInfoList()

	for i = 1, #infoList do
		if infoList[i] and infoList[i].npcId == checknumber(npcId) then
			return i
		end
	end

	return 1
end

function EscortModel:OnTalkFinishToNPC(npcId)
	if not self:IsOpenEscortView() and not self:IsPickupEscort() then
		return
	end

	if npcId == nil or npcId <= 0 then
		return
	end

	if self.npcInfoList == nil or #self.npcInfoList == 0 then
		return
	end

	for i = 1, #self.npcInfoList do
		if self.npcInfoList[i] and not self.npcInfoList[i].isPass and self.npcInfoList[i].npcId == npcId then
			self.npcInfoList[i].isPass = true

			if self.escortBaseInfo then
				self.escortBaseInfo.curProgIndex = i
			end

			if i > 1 and i < #self.npcInfoList then
				EscortController.instance:CSConvoyTalkToNPCReq(npcId)
			end

			return
		end
	end
end

function EscortModel:StartFindGotoNPC(index)
	if not self:IsOpenEscortView() and not self:IsPickupEscort() then
		return
	end

	local npcInfo = self:GetEscortNpcInfo(index)

	if npcInfo and not npcInfo.isPass then
		self:GotoNpcCrossScene(npcInfo.npcId)
	end
end

function EscortModel:GotoNpcCrossScene(npcId, onfinished, onfinishedObj)
	if TaskController.instance._escortCallBack then
		return
	end

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	TaskController.instance:foreceClearState()

	if mainPlayer then
		mainPlayer:gotoNpcCrossSceneWithFullScenePath(npcId)
	end
end

function EscortModel:OnOverEscort()
	UIJumper.instance:removeTopState(ViewName.EscortBattle)

	if self.escortBaseInfo then
		self.escortBaseInfo.curProgIndex = 0
	end

	self:GetRouteNpcInfoList()

	self.isPickupEscort = false
	self.onceEndTimer = 0
	self.isCanUpdata = true

	EscortController.instance:CSRequestEscortInfo()

	if self.isOpenEscort and self.escortEndTimer > ServerTime.now() then
		GlobalDispatcher:dispatch("UpdataCustomOpensItem", true, 1)
	end
end

function EscortModel:IsFinishStep(npcId)
	if checknumber(npcId) <= 0 then
		return false
	end

	local infoList = self:GetRouteNpcInfoList()

	for i = 1, #infoList do
		if infoList[i] and infoList[i].npcId == npcId then
			return infoList[i].isPass
		end
	end

	return false
end

function EscortModel:SetEscortBaseInfo(msg)
	local startTimer = 0
	local startTimer

	if self.escortBaseInfo == nil then
		startTimer = {}

		if self.boxBaseCfg then
			startTimer.escortTimer = self.boxBaseCfg.convoyPeriod or 180
		end

		if self.boxBaseCfg then
			startTimer.freeUpdataCount = self.boxBaseCfg.freeUpdataCount or 3
		end

		if self.boxBaseCfg then
			startTimer.freeEscortCount = self.boxBaseCfg.maxConvoyTimes or 2
		end

		if self.boxBaseCfg then
			startTimer.freeChallCount = self.boxBaseCfg.maxFreeChallengeTimes or 2
		end

		if self.boxBaseCfg then
			startTimer.freeBeChallCount = self.boxBaseCfg.maxBeChallengedTimes or 2
		end

		self.escortBaseInfo = startTimer
	end

	if msg then
		self.escortBaseInfo.supEscortCount = msg.restConvoyTimes
		self.escortBaseInfo.useUpdataCount = msg.upgradeBoxTimes
		self.escortBaseInfo.supFreeChall = msg.restChallengeTimes
		self.escortBaseInfo.supCanChall = msg.restBeChallengedTimes
		startTimer = math.ceil(tonumber(msg.convoyStartTime) / 1000)
		self.escortBaseInfo.curGoodsId = msg.curBoxId
		self.escortBaseInfo.curProgIndex = msg.curConvoyIndex
		self.escortBaseInfo.daibiCount = msg.convoyDaiBiNum
	else
		self.escortBaseInfo.supEscortCount = 2
		self.escortBaseInfo.useUpdataCount = 0
		self.escortBaseInfo.supFreeChall = 2
		self.escortBaseInfo.supCanChall = 0
		self.escortBaseInfo.curGoodsId = 1
		self.escortBaseInfo.curProgIndex = 0
		self.escortBaseInfo.daibiCount = 0
	end

	self:UpdataEscortStartTimer(startTimer)
	self:SetMainActivityRedpoint()

	if not self:IsPickupEscort() then
		self:SetEscortDaibiCount(true)
	end

	GlobalDispatcher:dispatch("EscortTimeOver")
end

function EscortModel:GetEscortBaseInfo()
	if self.escortBaseInfo == nil then
		return
	end

	self.escortBaseInfo.nowTimeInfo = self.nowTimeInfo

	return self.escortBaseInfo
end

function EscortModel:SetEscortDaibiCount(isInit, num)
	if self.escortBaseInfo == nil then
		return
	end

	if isInit then
		local wuziCfg = EscortConfig.instance:GetBoxWuziInfo(self.escortBaseInfo.curGoodsId)

		if wuziCfg then
			self.escortBaseInfo.daibiCount = wuziCfg.convoyNum or 0
		end

		return
	end

	self.escortBaseInfo.daibiCount = checknumber(self.escortBaseInfo.daibiCount) + checknumber(num)

	GlobalDispatcher:dispatch("UpdataEscortBaseInfo")
end

function EscortModel:UpdataEscortBaseBoxID(boxId)
	boxId = checknumber(boxId)

	if boxId < self.escortBaseInfo.curGoodsId then
		return
	end

	local baseInfo = self:GetEscortBaseInfo()
	local des = "货箱未升级!"
	local isUpgrade = false

	if boxId > self.escortBaseInfo.curGoodsId then
		isUpgrade = true

		local boxCfg = EscortConfig.instance:GetBoxWuziInfo(boxId)

		if boxCfg then
			des = string.format("成功刷到%s货箱", boxCfg.boxName)
		end
	end

	self.escortBaseInfo.useUpdataCount = self.escortBaseInfo.useUpdataCount + 1
	self.escortBaseInfo.curGoodsId = boxId

	self:SetEscortDaibiCount(true)
	GlobalDispatcher:dispatch("UpdataEscortBaseInfo")
	GlobalDispatcher:dispatch("UpdataTipsShow", isUpgrade, des)
end

function EscortModel:UpdataEscortStartTimer(timer)
	self.onceEndTimer = timer + self.escortBaseInfo.escortTimer * 60

	local supTime = self.onceEndTimer - ServerTime.now()

	if supTime > 0 then
		removetimer(self.SetEscortAndTaskTime, self)

		self.isPickupEscort = true

		GlobalDispatcher:dispatch("UpdataCustomBtnsItem", true, 1, supTime)
		SceneMgr.instance:disableTransition()
		self:SetPlayerMoveSpeed()
		settimer(1, self.SetEscortAndTaskTime, self, true)
	else
		self.isPickupEscort = false

		GlobalDispatcher:dispatch("UpdataCustomBtnsItem", false, 1)
		SceneMgr.instance:enabledTransition()
		self:SetPlayerMoveSpeed(true)

		if timer > 0 then
			EscortController.instance:CSConvoyOverTimeReq()
		end
	end
end

function EscortModel:SetPlayerMoveSpeed(isDefault)
	if SceneMainPlayer.instance == nil or SceneMgr.instance == nil then
		return
	end

	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer == nil then
		return
	end

	if isDefault then
		SceneMainPlayer.instance:ResetPlayerVariables()
		mainPlayer:updateMoveSpeed()
		mainPlayer.actions:stopAllActions()

		return
	end

	local isPick, onceEndTime = EscortModel.instance:IsPickupEscort()

	if not isPick or onceEndTime <= 0 then
		return
	end

	local baseInfo = EscortModel.instance:GetEscortBaseInfo()

	if baseInfo then
		if not baseInfo.curGoodsId then
			local wuziIndex = 1
			local userVar = SceneMainPlayer.instance.userVar

			userVar:setBoolean(UserVarKey.CONVOY_STATE, true, true)
			userVar:setNumber(UserVarKey.CONVOY_BOX_ID, wuziIndex, true)
			userVar:updateDisplayUserVariabls()
			SceneMainPlayer.instance:updateVariablesView()
			mainPlayer:updateMoveSpeed()
		end
	end
end

function EscortModel:GetHuowuGoodsInfo()
	return string.split((self.boxBaseCfg and not string.nilorempty(self.boxBaseCfg.wuziStr) or nil) and self.boxBaseCfg.wuziStr, ":")
end

function EscortModel:GetHusongJuanInfo()
	local goodsList = string.split((self.boxBaseCfg and not string.nilorempty(self.boxBaseCfg.convoyItem) or nil) and self.boxBaseCfg.convoyItem, ":")

	return tonumber(goodsList[1]), tonumber(goodsList[2])
end

function EscortModel:GetTiaoZhanJuanInfo()
	local goodsList = string.split((self.boxBaseCfg and not string.nilorempty(self.boxBaseCfg.robberyItem) or nil) and self.boxBaseCfg.robberyItem, ":")

	return tonumber(goodsList[1]), tonumber(goodsList[2])
end

function EscortModel:SetBattlePlayerList(data)
	self.battlePlayerList = {}

	if data and #data > 0 then
		for i = 1, #data do
			local pb = data[i]

			if pb and pb.headInfo then
				local userInfo = {}

				userInfo.userId = checknumber(pb.headInfo.userId)
				userInfo.userName = pb.headInfo.userName
				userInfo.headInfo = pb.headInfo
				userInfo.maxPower = data[i].maxZdl
				userInfo.userBoxId = data[i].boxId
				userInfo.supBeChalNum = data[i].restBeChallengeTimes
				userInfo.isEnemy = data[i].pastChallenger
				userInfo.userLevel = data[i].headInfo.playerLv

				table.insert(self.battlePlayerList, userInfo)
			end
		end
	end

	GlobalDispatcher:dispatch("UpdataEscortBattleList")
end

function EscortModel:GetBattlePlayerList()
	return self.battlePlayerList or {}
end

function EscortModel:SetBattlePlayer(info, isJuan)
	self.battlePlayer = info
	self.battlePlayer.isJuan = isJuan
end

function EscortModel:GetBattlePlayer()
	return self.battlePlayer
end

function EscortModel:GetIsBattleJuan()
	if self.battlePlayer then
		return self.battlePlayer.isJuan
	end
end

function EscortModel:SetSupBattleCount()
	if self.escortBaseInfo == nil or self:GetIsBattleJuan() then
		return
	end

	if self.escortBaseInfo.supFreeChall then
		self.escortBaseInfo.supFreeChall = self.escortBaseInfo.supFreeChall - 1
	end

	if self.escortBaseInfo.supFreeChall == nil or self.escortBaseInfo.supFreeChall < 0 then
		self.escortBaseInfo.supFreeChall = 0
	end

	self:SetMainActivityRedpoint()
end

function EscortModel:SetEscortReportList(data)
	self.escortReportList = {}

	if data and #data > 0 then
		for i = 1, #data do
			local pb = data[i]

			if pb and pb.headInfo then
				local newInfo = {}

				newInfo.isAtt = data[i].type == 1
				newInfo.headInfo = pb.headInfo
				newInfo.userId = checknumber(pb.headInfo.userId)
				newInfo.userName = pb.headInfo.userName
				newInfo.daiBiNum = data[i].daiBiNum
				newInfo.isWin = false
				newInfo.ownPower = data[i].myZdl
				newInfo.userPower = data[i].rivalZdl
				newInfo.warTimer = tonumber(data[i].challengeTime)
				newInfo.ownLevel = data[i].myPlayerLv
				newInfo.userLevel = data[i].headInfo.playerLv
				newInfo.wuziDes = "未获得\n物品"

				if newInfo.isAtt then
					if data[i].daiBiNum > 0 then
						newInfo.wuziDes = "获得："
						newInfo.isWin = true
					end
				elseif data[i].daiBiNum > 0 then
					newInfo.wuziDes = "损失："
				else
					newInfo.isWin = true
					newInfo.wuziDes = "未损失\n物品"
				end

				table.insert(self.escortReportList, newInfo)
			end
		end
	end

	GlobalDispatcher:dispatch("UpdataEscortReportList")
end

function EscortModel:GetEscortReportList()
	if self.escortReportList and #self.escortReportList > 0 then
		table.sort(self.escortReportList, function(a, b)
			return a.warTimer > b.warTimer
		end)
	end

	return self.escortReportList or {}
end

function EscortModel:SetEscortRedPoint(viewName, isShow)
	self.escortRedPoint = self.escortRedPoint or {}

	if viewName == "all" then
		self.escortRedPoint.escortgoods = isShow
		self.escortRedPoint.escortbattle = isShow
		self.escortRedPoint.escortmain = isShow
	else
		self.escortRedPoint[viewName] = isShow
	end

	if viewName ~= "escortmain" then
		GlobalDispatcher:dispatch("UpdataEscortPoint", viewName, isShow)
	end

	if viewName == "all" or viewName == "escortmain" then
		GlobalDispatcher:dispatch("UpdataCustomBtnsPoint", 1, isShow)
	end
end

function EscortModel:GetEscortRedPoint(viewName)
	if self.escortRedPoint == nil or self.escortRedPoint[viewName] == nil then
		return false
	end

	return self.escortRedPoint[viewName]
end

function EscortModel:setOtherViewShowRed()
	if not self:JudgeOpenCondition() then
		return false
	end

	if not self:IsOpenEscortView() then
		return false
	end

	if self:IsPickupEscort() then
		return false
	end

	if self.escortBaseInfo == nil or self.escortBaseInfo.supEscortCount <= 0 then
		return false
	end

	return true
end

function EscortModel:SetMainActivityRedpoint(isFalse)
	if isFalse then
		self.isMainRedpoint = false

		return
	end

	if not self:IsOpenEscortView() then
		self.isMainRedpoint = false

		GlobalDispatcher:dispatch("UpdataCustomOpensPoint", 1, false)

		return
	end

	if not self.isCanUpdata then
		GlobalDispatcher:dispatch("UpdataCustomOpensPoint", 1, self.isMainRedpoint)

		return
	end

	self.isCanUpdata = false

	if self.escortBaseInfo == nil or self.escortBaseInfo.supEscortCount <= 0 then
		self.isMainRedpoint = false

		GlobalDispatcher:dispatch("UpdataCustomOpensPoint", 1, false)

		return
	end

	self.isMainRedpoint = true

	GlobalDispatcher:dispatch("UpdataCustomOpensPoint", 1, true)
end

function EscortModel:GetBuzhengTimer()
	return self.buzhengTimer
end

function EscortModel:SetBuzhengTimer(value)
	self.buzhengTimer = (value == nil or value <= 0) and 30 or value
end

function EscortModel:IsCanOpenView(viewName)
	if not self:IsPickupEscort() or string.nilorempty(viewName) then
		return true
	end

	local funcList = FuncOpenConfig.instance:getFuncIdByViewNameList(viewName)
	local list = self.boxBaseCfg.notOpenView

	if list == nil or #list == 0 then
		return true
	end

	for i, funcId in ipairs(funcList or {}) do
		if checknumber(funcId) > 0 and table.indexof(list, funcId) ~= false then
			local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

			if cfg then
				if not cfg.name then
					local nameStr = "指定功能"

					return false, nameStr
				end
			end
		end
	end

	return true
end

EscortModel.instance = EscortModel.New()

return EscortModel
