-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/model/KingWayModel.lua

module("logic.extensions.kingway.model.KingWayModel", package.seeall)

local KingWayModel = class("KingWayModel", BaseListModel)

function KingWayModel:ctor()
	KingWayModel.super.ctor(self)

	self.kingBaseInfo = nil
	self.npcIdList = {
		1081003,
		1081002
	}
	self.isUpdata = false
	self.isOpenKingView = false
end

function KingWayModel:onInit()
	KingWayModel.super.onInit(self)
	self:onReset()
end

function KingWayModel:onReset()
	self.kingBaseInfo = nil
	self.isUpdata = false
	self.isOpenKingView = false
	self._higestVerifiedZdl = 0
	self._verifyPlanId = 1
end

function KingWayModel:SetKingInitData(msg)
	self.kingBaseInfo = nil

	if msg == nil then
		return
	end

	self.isUpdata = true
	self.kingBaseInfo = {
		allKingWayCount = 8,
		battleId = msg.passedClg,
		stageId = msg.passedStage
	}

	GlobalDispatcher:dispatch("UpdataKingWayView")
	KingWayModel.instance:SetNpcAndObstacleShow()
end

function KingWayModel:SetBattleAndStageId(msg)
	if msg == nil or not msg.isWin then
		self:SetReturnOpenKingView(false)

		return
	end

	self.isUpdata = true
	self.kingBaseInfo = {
		allKingWayCount = 8,
		battleId = msg.challenge,
		stageId = msg.stage
	}

	self:SetReturnOpenKingView(true)
	GlobalDispatcher:dispatch("UpdataKingWayView")
	KingWayModel.instance:SetNpcAndObstacleShow()
end

function KingWayModel:GetKingAllBattleCount()
	if self.kingBaseInfo == nil or self.kingBaseInfo.allKingWayCount == nil then
		return 8
	end

	return self.kingBaseInfo.allKingWayCount
end

function KingWayModel:GetKingBattleAndStageId()
	if self.kingBaseInfo == nil then
		return 0, 0
	end

	if self.isUpdata then
		self.isUpdata = false

		local baId = self.kingBaseInfo.battleId
		local stId = self.kingBaseInfo.stageId

		if baId <= 0 then
			self.kingBaseInfo.battleId = 1
			self.kingBaseInfo.stageId = 0
		else
			local list = KingWayConfig.instance:GetWayStageCfg(baId)

			if list then
				if not #list then
					local count = 5

					if count <= stId then
						self.kingBaseInfo.battleId = self.kingBaseInfo.battleId + 1
						self.kingBaseInfo.stageId = 0
					end
				end
			end
		end
	end

	return self.kingBaseInfo.battleId, self.kingBaseInfo.stageId
end

function KingWayModel:IsKingWayAllFinished()
	local all = self:GetKingAllBattleCount()
	local batId, staId = self:GetKingBattleAndStageId()

	if all < batId then
		return true
	end

	return false
end

function KingWayModel:SetReturnOpenKingView(isWin)
	if not self.isOpenKingView then
		return
	end

	self.isOpenKingView = false

	local baId, stId = self:GetKingBattleAndStageId()

	if isWin and stId <= 0 then
		UIJumper.instance:pushOneStack(ViewName.KingWay, true)

		return
	end

	UIJumper.instance:pushOneStack(ViewName.KingBattle, true, baId)
end

function KingWayModel:GetWayStageGoods(battleId, stageId)
	if checknumber(battleId) <= 0 or checknumber(stageId) <= 0 then
		return
	end

	local cfg = KingWayConfig.instance:GetWayStageCfg(battleId, stageId)

	if cfg == nil or string.nilorempty(cfg.passPrize) then
		return
	end

	local goodsList = string.split(cfg.passPrize, "#")

	if goodsList and #goodsList > 0 then
		return goodsList
	end
end

function KingWayModel:ClickKingWayLastNpcBtn()
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if mainPlayer then
		if self:GetLastNpcIsUnlock() then
			if not self.npcIdList[2] then
				local npcId = self.npcIdList[1]

				TaskController.instance:foreceClearState()
				mainPlayer:gotoNpcCrossSceneWithFullScenePath(npcId)
			end
		end
	end
end

function KingWayModel:SetNpcAndObstacleShow()
	if self.kingBaseInfo == nil then
		return
	end

	local isNpcChange = false
	local isObsShow = true

	if self:GetLastNpcIsUnlock() then
		isNpcChange = true
		isObsShow = false
	end

	if not isNpcChange then
		if self.npcIdList[2] then
			SceneNpcsMgr.instance:removeNpc(self.npcIdList[2])
		end

		if self.npcIdList[1] then
			SceneNpcsMgr.instance:createNpc(self.npcIdList[1])
		end
	else
		if self.npcIdList[1] then
			SceneNpcsMgr.instance:removeNpc(self.npcIdList[1])
		end

		if self.npcIdList[2] then
			SceneNpcsMgr.instance:createNpc(self.npcIdList[2])
		end
	end

	BarriersMgr.instance:triggerBarrierGroup(108, 10801, isObsShow)

	if isObsShow then
		SceneNpcsMgr.instance:createNpc(1082011)
	else
		SceneNpcsMgr.instance:removeNpc(1082011)
	end
end

function KingWayModel:GetLastNpcIsUnlock(isPower)
	return true
end

function KingWayModel:OpenLastNpcBattleView()
	UIStateManager.instance:push(ViewName.KingBattle, 8)
end

function KingWayModel:GetKingViewRedPoint()
	if not FuncOpenModel.instance:getFuncIsOpen(67) then
		return
	end

	return self:GetBattleAndStageRedPoint(true) or self:GetBattleAndStageRedPoint()
end

function KingWayModel:GetBattleAndStageRedPoint(isWay)
	local baId, stId = self:GetKingBattleAndStageId()

	if baId > self:GetKingAllBattleCount() then
		return false
	end

	local nowPower = RoleModel.instance:getMaxPower() or 0
	local cfg = KingWayConfig.instance:GetWayBaseCfg(baId)

	if cfg == nil then
		return false
	end

	if nowPower < checknumber(cfg.zdlLimit) then
		return false
	end

	if isWay then
		if not self:GetBattlePlayerPrefs(true) or stId > 0 then
			return false
		end
	else
		stId = stId + 1

		if not self:GetBattlePlayerPrefs() then
			return false
		end

		local cfg = KingWayConfig.instance:GetWayStageCfg(baId, stId)

		if cfg == nil then
			return false
		end
	end

	return true
end

function KingWayModel:GetBattlePlayerPrefs(isWay)
	if self.kingBaseInfo == nil then
		return false
	end

	local baId, stId = self:GetKingBattleAndStageId()

	if baId > self:GetKingAllBattleCount() then
		return false
	end

	stId = stId + 1

	if isWay then
		if not ("KingWay_" .. baId) then
			local str = "KingBattle_" .. baId .. stId
			local lastStr = UnityEngine.PlayerPrefs.GetString(str)

			if string.nilorempty(lastStr) then
				return true
			end

			if isWay then
				return false
			end

			local now = ServerTime.nowDateServerLook()
			local nowStr = string.format("%sY%sM%sD", now.year, now.month, now.day)

			if lastStr == nowStr then
				return false
			end

			return true
		end
	end
end

function KingWayModel:SetBattlePlayerPrefs(isWay)
	if self.kingBaseInfo == nil then
		return
	end

	local baId, stId = self:GetKingBattleAndStageId()

	if baId > self:GetKingAllBattleCount() then
		return
	end

	stId = stId + 1

	if isWay then
		if not ("KingWay_" .. baId) then
			local str = "KingBattle_" .. baId .. stId
			local now = ServerTime.nowDateServerLook()
			local nowStr = string.format("%sY%sM%sD", now.year, now.month, now.day)

			UnityEngine.PlayerPrefs.SetString(str, nowStr)
		end
	end
end

function KingWayModel:GetKingWayProgress(battleId, stageId)
	if self.kingBaseInfo == nil then
		return false
	end

	if battleId > self.kingBaseInfo.battleId + 1 then
		return false
	end

	if battleId < self.kingBaseInfo.battleId + 1 then
		return true
	end

	return stageId <= self.kingBaseInfo.stageId
end

function KingWayModel:ClickWingWaySweepBtn(battleId, stageId)
	if ViewMgr.instance:isOpen(ViewName.MopupMainView) then
		ViewMgr.instance:close(ViewName.MopupMainView)
	end

	local function clickStartFunc(clickType, param)
		if not param.times then
			local comCount = 0

			if self.kingBaseInfo then
				comCount = self.kingBaseInfo.dayCommAllCount + self.kingBaseInfo.dayCommBuyCount - self.kingBaseInfo.dayCommUseCount
			end

			if comCount <= 0 or comCount < param.times then
				FloatWordMgr.instance:show("王者之路挑战次数不足" .. param.times .. "次")

				return
			end

			local roleCount = 0
			local batInfo = self:GetKingBattleInfo(battleId)

			if batInfo then
				roleCount = batInfo.todayAllTimes + batInfo.todayClgBuyTimes - batInfo.todayClgTimes
			end

			if roleCount <= 0 or roleCount < param.times then
				FloatWordMgr.instance:show(string.format("%s 挑战次数不足%s次", batInfo.battleName, param.times))

				return
			end

			if param.times and param.times <= 0 then
				FloatWordMgr.instance:show("请至少扫荡1次哦！")

				return
			end

			local function resFunc(msg)
				self:SetKingWaySweepRes(msg, param.func)
			end

			if clickType == MopupMainView.ClickType.Time then
				KingWayController.instance:CSSendSweepReq(battleId, stageId, param.times, resFunc)
			elseif clickType == MopupMainView.ClickType.Auto then
				error("sr_王者之路  KingWayModel:ClickWingWaySweepBtn()    没有自动扫荡 = " .. battleId .. stageId)
			end
		end
	end

	local function getOnceCostFunc()
		return 0
	end

	local function getConditionFunc()
		local lCount = 0
		local rCount = 0

		if self.kingBaseInfo then
			lCount = self.kingBaseInfo.dayCommAllCount + self.kingBaseInfo.dayCommBuyCount - self.kingBaseInfo.dayCommUseCount
			rCount = self.kingBaseInfo.dayCommAllCount
		end

		local condition2 = string.format("王者之路挑战次数：%s/%s", lCount, rCount)

		lCount = 0
		rCount = 0

		local name = "王者"
		local batInfo = self:GetKingBattleInfo(battleId)

		if batInfo then
			lCount = batInfo.todayAllTimes + batInfo.todayClgBuyTimes - batInfo.todayClgTimes
			rCount = batInfo.todayAllTimes
			name = batInfo.battleName
		end

		local condition1 = string.format("%s 挑战次数：%s/%s", name, lCount, rCount)

		return condition1, condition2
	end

	local function isAutoSweepFunc()
		return false
	end

	local function getBatCountFunc()
		local batInfo = self:GetKingBattleInfo(battleId)

		return math.min((batInfo or nil) and batInfo.todayAllTimes + batInfo.todayClgBuyTimes - batInfo.todayClgTimes, (self.kingBaseInfo or nil) and self.kingBaseInfo.dayCommAllCount + self.kingBaseInfo.dayCommBuyCount - self.kingBaseInfo.dayCommUseCount)
	end

	UIStateManager.instance:open(ViewName.MopupMainView, clickStartFunc, nil, getOnceCostFunc, getConditionFunc, nil, isAutoSweepFunc, getBatCountFunc)
end

function KingWayModel:SetKingWaySweepRes(msg, callback)
	if msg == nil then
		return
	end

	if msg.prizes == nil or #msg.prizes == 0 then
		error("sr_王者之路   KingWayModel:SetKingWaySweepRes()  扫荡获得奖励为空 = " .. msg.challenge .. msg.stage)

		return
	end

	if self.kingBaseInfo then
		self.kingBaseInfo.dayCommUseCount = self.kingBaseInfo.dayCommUseCount + #msg.prizes
	end

	if self.battleInfoList and self.battleInfoList[msg.challenge] then
		self.battleInfoList[msg.challenge].todayClgTimes = self.battleInfoList[msg.challenge].todayClgTimes + #msg.prizes

		GlobalDispatcher:dispatch("UpdataKingCount", msg.challenge)
	end

	local goodsList = {}

	for i = 1, #msg.prizes do
		if msg.prizes[i] then
			if msg.prizes[i].prizes and not string.nilorempty(msg.prizes[i].prizes) then
				table.insert(goodsList, {
					times = msg.prizes[i].times,
					list = string.split(msg.prizes[i].prizes, "#")
				})
			else
				table.insert(goodsList, {
					times = msg.prizes[i].times,
					list = {}
				})
			end
		end
	end

	if callback then
		callback(goodsList)
	end
end

function KingWayModel:getVerifyPlanId()
	return self._verifyPlanId
end

function KingWayModel:setVerifyPlanId(planId)
	self._verifyPlanId = planId
end

KingWayModel.instance = KingWayModel.New()

return KingWayModel
