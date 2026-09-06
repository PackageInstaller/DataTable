-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/controller/DuolaMMcontroller.lua

module("logic.extensions.duolamengmeng.controller.DuolaMMcontroller", package.seeall)

local DuolaMMcontroller = class("DuolaMMcontroller", BaseController)

function DuolaMMcontroller:onInit()
	DuolaMMcontroller.super.onInit(self)
	self:onReset()
	DuoLaMMClgAgent.instance:addHandler(DuoLaMMClgAgent.PM_DuoLaMMClgGetInfoRes, self.handleGetInfo, self)
	DuoLaMMClgAgent.instance:addHandler(DuoLaMMClgAgent.PM_DuoLaMMClgBuyGameTimesRes, self.handleBuyGameTimes, self)
	DuoLaMMClgAgent.instance:addHandler(DuoLaMMClgAgent.PM_DuoLaMMClgEndGameRes, self.handleEndGame, self)
	DuoLaMMClgAgent.instance:addHandler(DuoLaMMClgAgent.PM_DuoLaMMClgEvolveSucRes, self._handleEvolveSuccess, self)
	GlobalDispatcher:addListener(DuoLaMMClgAgent.PM_DuoLaMMClgBuyPieceRes, self.handleBuyPiece, self)
	GlobalDispatcher:addListener(DuoLaMMClgAgent.PM_DuoLaMMClgReliveRes, self.handleReborn, self)
end

function DuolaMMcontroller:onReset()
	self.getInfoCallBackList = nil
end

function DuolaMMcontroller:openDuolaGame(prizeList, gameCfg, dropPlanCfg, rebornCfg, rebornCallBack, finishCallBack)
	local params = {}

	params.prizeList = prizeList
	params.gameCfg = gameCfg

	local dropPlanList = {}

	for k, v in pairs(dropPlanCfg) do
		local tempList = {}

		for k2, v2 in pairs(v) do
			table.insert(tempList, v2)
		end

		table.sort(tempList, function(a, b)
			return a.type < b.type
		end)

		dropPlanList[k] = tempList
	end

	params.dropPlanCfg = dropPlanList
	params.rebornCfg = rebornCfg
	params.rebornCallBack = rebornCallBack
	params.finishCallBack = finishCallBack

	UIStateManager.instance:push(ViewName.DuolaGameView, params)
end

function DuolaMMcontroller:calculateDistance(pos1, pos2)
	local diffX = math.abs(pos1.x - pos2.x)
	local diffY = math.abs(pos1.y - pos2.y)

	return checknumber(math.sqrt(diffX * diffX + diffY * diffY))
end

function DuolaMMcontroller:getInfo()
	DuoLaMMClgAgent.instance:sendPM_DuoLaMMClgGetInfoReq()
end

function DuolaMMcontroller:handleGetInfo(msg)
	DuolaMMmodel.instance:setEverEvolvePet(msg.everEvolvePet)

	if msg:HasField("hasOpenEvolve") then
		DuolaMMmodel.instance:setHasOpenEvolve(msg.hasOpenEvolve)
	end

	if msg:HasField("gameInfo") then
		DuolaMMmodel.instance:setBuyGameTime(msg.gameInfo.todayBuyGameTimes)
		DuolaMMmodel.instance:setPlayGameTime(msg.gameInfo.todayGameTimes)
	end

	for k, v in ipairs(msg.pieceInfos) do
		DuolaMMmodel.instance:setPieceInfo(v)
	end

	DuolaMMmodel.instance:setHasGetData(true)
	self:notify(GlobalNotify.DuoLaMMDataRefresh)
end

function DuolaMMcontroller:buyGameTimes()
	DuoLaMMClgAgent.instance:sendPM_DuoLaMMClgBuyGameTimesReq()
end

function DuolaMMcontroller:handleBuyGameTimes(msg, status)
	DuolaMMmodel.instance:setBuyGameTime(msg.todayBuyGameTimes)
	self:notify(GlobalNotify.DuoLaMMGameTimesDataRefresh, status)
end

function DuolaMMcontroller:buyPiece(itemId, count)
	DuoLaMMClgAgent.instance:sendPM_DuoLaMMClgBuyPieceReq(itemId, count)
end

function DuolaMMcontroller:handleBuyPiece(status, msg)
	if status == 0 then
		DuolaMMmodel.instance:setPieceInfo(msg.pieceInfo)
		self:notify(GlobalNotify.DuoLaMMDataRefresh)
	else
		MaterialMgr.openGetSourceByStr(MatType.Diamond .. ":" .. MatType.Diamond_Normal)
	end
end

function DuolaMMcontroller:checkEnoughEvolution()
	local res = true

	for i = 1, DuolaMMmodel.PIECE_NUM do
		local buyCount = DuolaMMmodel.instance:getBuyCount(i)
		local gameCount = DuolaMMmodel.instance:getGameGainCount(i)
		local prizeCfg = DuolaMMconfig.instance:getPieceCfg()
		local maxNum = prizeCfg[i].gainLimit

		if maxNum > buyCount + gameCount then
			res = false

			break
		end
	end

	return res
end

function DuolaMMcontroller:endGame(prizeList, key)
	DuoLaMMClgAgent.instance:sendPM_DuoLaMMClgEndGameReq(prizeList, key)
end

function DuolaMMcontroller:handleEndGame(msg)
	if msg:HasField("gameInfo") then
		DuolaMMmodel.instance:setBuyGameTime(msg.gameInfo.todayBuyGameTimes)
		DuolaMMmodel.instance:setPlayGameTime(msg.gameInfo.todayGameTimes)
	end

	for k, v in ipairs(msg.pieceInfos) do
		DuolaMMmodel.instance:setPieceInfo(v)
	end

	self:notify(GlobalNotify.DuoLaMMDataRefresh)
end

function DuolaMMcontroller:sendReborn()
	DuoLaMMClgAgent.instance:sendPM_DuoLaMMClgReliveReq()
end

function DuolaMMcontroller:handleReborn(status, msg)
	self:notify(GlobalNotify.DuoLaMMGameReborn, status)
end

function DuolaMMcontroller:_handleEvolveSuccess(msg)
	DuolaMMmodel.instance:setEverEvolvePet(true)

	local root = GameEnum.RankType.DuolaMM_RANK
	local leaf = 0
	local rankMo = RankModel.instance:getRankMo(root, leaf)

	rankMo.myRank = checknumber(msg.myRank)

	self:notify(GlobalNotify.DuoLaMMDataRefresh)
end

DuolaMMcontroller.instance = DuolaMMcontroller.New()

return DuolaMMcontroller
