-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataClanClear.lua

local ResOpActClanBossStage = require("ClientData/ResOpActClanBossStage")
local ResOpActClanBossMisc = require("ClientData/ResOpActClanBossMisc")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local Hero = require("Common/Object/Hero")
local ActivityDataClanClear = Class("ActivityDataClanClear", ActivityDataBase)

function ActivityDataClanClear:ctor()
	self.nowDispatchForms = {}
	self.nowBonusData = {}
end

function ActivityDataClanClear:updateClientData(actId)
	local detailId = self.actObject.templateData.detail_id

	self.clientData = ResOpActClanBossStage[detailId] or {}
	self.miscData = ResOpActClanBossMisc[actId]

	self:checkCalcTimer()
end

function ActivityDataClanClear:onStateChange(opActState)
	if opActState == Const.OPACT_STATE_FREEZE then
		self.actObject:checkNew()
	end
end

function ActivityDataClanClear:updateRoleData(roleData)
	self.nowDispatchForms = {}
	self.nowBonusData = {}
	self.formSetTime = roleData.clan_boss.reset_time

	local formInTime = ClientUtils.isTickToday(self.formSetTime)

	for bossId, serverData in ipairs(roleData.clan_boss.boss) do
		self.nowBonusData[bossId] = {}

		for layer, layerData in ipairs(serverData.award) do
			self.nowBonusData[bossId][layer] = ClientUtils.getBitsDictFromByteString(layerData.awarded)
		end

		if formInTime then
			self.nowDispatchForms[bossId] = {}

			for index, heroInfo in ipairs(serverData.dispatch) do
				if heroInfo.hero.gid and CurAvatar.heroDic[heroInfo.hero.gid] then
					table.insert(self.nowDispatchForms[bossId], CurAvatar.heroDic[heroInfo.hero.gid])
				else
					table.insert(self.nowDispatchForms[bossId], Hero(utils.deepcopy(heroInfo.hero)))
				end
			end
		end
	end

	if formInTime then
		self.sendAchieveGot = roleData.clan_boss.dispatch_awarded == 1
	else
		self.sendAchieveGot = false
	end

	self:checkCalcTimer()
end

function ActivityDataClanClear:checkCalcTimer()
	if self.miscData then
		if not self.timerCalcResult then
			self.timerCalcResult = Timer.New(Functor(self.timerCalcClanMember, self), 5, 1)
		end

		local nowState, nextStateDuration = self:getNowTimeState()

		self.timerCalcResult.duration = nextStateDuration

		self.timerCalcResult:Restart()
	end
end

function ActivityDataClanClear:timerCalcClanMember()
	local nowState, nextStateDuration = self:getNowTimeState()

	if nowState == 1 then
		local myCircle = CurAvatar.myCircle

		if myCircle then
			myCircle:timerCalcClanClearMember(self.actObject.opId)
		end
	end

	self:checkCalcTimer()

	local activityClanClearDlg = UIManager.tryGetUI("activityClanClearDlg")

	if activityClanClearDlg then
		activityClanClearDlg:updateActivityData()
	end

	self.actObject:checkNew()
end

function ActivityDataClanClear:checkNew()
	for bossId, _ in pairs(self.clientData or {}) do
		if self:_bossIdHasNew(bossId) then
			return true
		end
	end

	if self:isSendAchieveNew() then
		return true
	end
end

function ActivityDataClanClear:_bossIdHasNew(bossId, onlyForm)
	if not onlyForm and self:getValidBonus(bossId) then
		return true
	end

	if self:getNowTimeState() == 0 and self.actObject:inOpenState() then
		local forms = self:getCurClanLayerFormation(bossId)

		if not forms or not (#forms > 0) then
			return true
		end
	end
end

function ActivityDataClanClear:getCurClanLayer(bossId)
	if CurAvatar.myCircle then
		return CurAvatar.myCircle:getClanClearLayerData(self.actObject.opId, bossId)
	else
		return 1, 0
	end
end

function ActivityDataClanClear:getClanYesterdayEvents(bossId)
	if CurAvatar.myCircle then
		return CurAvatar.myCircle:getClanYesterdayEvents(self.actObject.opId, bossId)
	end
end

function ActivityDataClanClear:curClanNormalLayerData(bossId)
	local layer = self:getCurClanLayer(bossId)
	local allLayerData = self.clientData[bossId] or {}

	if layer <= #allLayerData then
		local nowLayerData = allLayerData[layer]

		if nowLayerData.is_boss then
			return allLayerData[layer + 1]
		else
			return nowLayerData
		end
	else
		return allLayerData[layer - 1]
	end
end

function ActivityDataClanClear:curClanHardLayerData(bossId)
	local layer = self:getCurClanLayer(bossId)
	local allLayerData = self.clientData[bossId] or {}

	if layer <= #allLayerData then
		local nowLayerData = allLayerData[layer]

		if nowLayerData.is_boss then
			return nowLayerData
		else
			local lastBossLayerData

			for l, lData in ipairs(allLayerData) do
				if lData.is_boss then
					if layer < l then
						return lData
					end

					lastBossLayerData = lData
				end
			end

			return lastBossLayerData
		end
	end
end

function ActivityDataClanClear:getNowTimeState()
	local todayStart = ClientUtils.getServerTimeTodayStart()
	local nowTime = ClientUtils.getServerTime()
	local hour = nowTime - todayStart

	hour = hour / 3600

	if hour < self.miscData.day_start_time then
		return 2, todayStart + self.miscData.day_start_time * 3600 - nowTime
	elseif hour < self.miscData.day_award_time then
		return 0, todayStart + self.miscData.day_award_time * 3600 - nowTime
	elseif hour < self.miscData.day_show_time then
		return 1, todayStart + self.miscData.day_show_time * 3600 - nowTime
	else
		return 2, todayStart + Const.TIME_ONE_DAY + self.miscData.day_start_time * 3600 - nowTime
	end
end

function ActivityDataClanClear:getCurClanLayerFormation(bossId)
	if self.formSetTime and ClientUtils.isTickToday(self.formSetTime) then
		return self.nowDispatchForms[bossId]
	end
end

function ActivityDataClanClear:rpcGetAchieve()
	if self.sendAchieveGot then
		return
	end

	local sendNum, maxNum = self:getSendCountInfo()

	if maxNum <= sendNum then
		local opId = self.actObject.opId

		CurAvatar:activityRPC(RPC.opActClanBossGetAchieveAward, opId, opId)
	end
end

function ActivityDataClanClear:rpcSendStart(bossId, layer, gids)
	local opId = self.actObject.opId

	CurAvatar:activityRPC(RPC.opActClanBossDispatch, opId, opId, bossId, layer, gids)
end

function ActivityDataClanClear:rpcGetAward(bossId, layer, order, round)
	local opId = self.actObject.opId

	CurAvatar:activityRPC(RPC.opActClanBossGetStageAward, opId, opId, bossId, layer, order, round)
end

function ActivityDataClanClear:getValidBonus(bossId)
	if self:getNowTimeState() ~= 1 then
		local bData = self.clientData[bossId] or {}
		local bonusData = self.nowBonusData[bossId] or {}
		local nowLayer, nowScore, round = self:getCurClanLayer(bossId)

		for index = 1, nowLayer do
			local layerData = bData[index]

			if layerData and layerData.score_award then
				for aId, aInfo in ipairs(layerData.score_award) do
					if (index < nowLayer or nowScore >= aInfo.score) and (bonusData[index] == nil or bonusData[index][aId] == nil) then
						return index, aId
					end

					if nowLayer == #bData and round > 0 and (bonusData[#bData + round - 1] == nil or bonusData[#bData + round - 1][aId] == nil) then
						return #bData, aId
					end
				end
			end
		end
	end
end

function ActivityDataClanClear:getAllValidBonus(bossId)
	local validBonus = {}

	if self:getNowTimeState() ~= 1 then
		local bData = self.clientData[bossId] or {}
		local bonusData = self.nowBonusData[bossId] or {}
		local nowLayer, nowScore, round = self:getCurClanLayer(bossId)

		for index = 1, nowLayer do
			local layerData = bData[index]

			if layerData and layerData.score_award then
				for aId, aInfo in ipairs(layerData.score_award) do
					if (index < nowLayer or nowScore >= aInfo.score) and (bonusData[index] == nil or bonusData[index][aId] == nil) then
						table.insert(validBonus, {
							index,
							aId,
							aInfo
						})
					end
				end

				if index == #bData and nowLayer == #bData and round > 0 then
					for i = #bData, #bData + round - 1 do
						for aId, aInfo in ipairs(layerData.score_award) do
							if bonusData[i] == nil or bonusData[i][aId] == nil then
								local tmpRound = i - #bData

								table.insert(validBonus, {
									#bData,
									aId,
									aInfo,
									tmpRound
								})
							end
						end
					end
				end
			end
		end
	end

	return validBonus
end

function ActivityDataClanClear:bonusHasGot(bossId, layer, index)
	local bonusData = self.nowBonusData[bossId] or {}

	if bonusData[layer] and bonusData[layer][index] then
		return true
	end

	return false
end

function ActivityDataClanClear:isSendAchieveNew()
	if self.miscData then
		if self.formSetTime and not ClientUtils.isTickToday(self.formSetTime) then
			self.sendAchieveGot = false
		end

		if self.sendAchieveGot then
			return false
		end

		local sendNum, maxNum = self:getSendCountInfo()

		if maxNum <= sendNum then
			return true
		end
	end
end

function ActivityDataClanClear:isSendAchieveGot()
	if self.formSetTime and not ClientUtils.isTickToday(self.formSetTime) then
		self.sendAchieveGot = false
	end

	return self.sendAchieveGot
end

function ActivityDataClanClear:getSendCountInfo()
	local sendNum = 0

	for bossId, info in ipairs(self.clientData) do
		local forms = self:getCurClanLayerFormation(bossId)

		if forms and #forms > 0 then
			sendNum = sendNum + 1
		end
	end

	return sendNum, self.miscData.send_achieve_num or 3
end

function ActivityDataClanClear:destroy()
	if self.timerCalcResult then
		self.timerCalcResult:Stop()
	end
end

return ActivityDataClanClear
