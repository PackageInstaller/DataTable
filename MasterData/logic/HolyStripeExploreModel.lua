-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripeexplore/model/HolyStripeExploreModel.lua

module("logic.extensions.holystripeexplore.model.HolyStripeExploreModel", package.seeall)

local HolyStripeExploreModel = class("HolyStripeExploreModel", BaseModel)

function HolyStripeExploreModel:onInit()
	self:onReset()
end

function HolyStripeExploreModel:onReset()
	self._curInfo = nil
	self._curGrid = 0
	self._curMapId = 0
	self._curSpeed = 0
	self._curPrizeId = 0
	self._curEndTime = -1
	self._curGameTimes = 0
	self._curBuyTimes = 0
	self._curNumberList = 0
	self._curClientKey = nil
	self._curServerKey = nil
	self.CiList = nil
end

function HolyStripeExploreModel:onGetInfo(msg)
	self:onReset()

	if msg.info and checkint(msg.info.endTime) > 0 then
		self._curInfo = msg.info
		self._curGrid = self._curInfo.gridId
		self._curMapId = self._curInfo.mapId

		local cfg = HolyStripeExploreConfig.instance:getSpeedById(self._curInfo.speedPlanId)

		self._curSpeed = cfg and cfg.speed
		self._curEndTime = checkint(self._curInfo.endTime)
		self._curGameTimes = checkint(self._curInfo.gameCount)
		self._curBuyTimes = checkint(self._curInfo.buyGameCount)
		self._curNumberList = HolyStripeExploreConfig.instance:getNumberListById(self._curInfo.numberPlanId)
	end
end

function HolyStripeExploreModel:onStartGame(msg)
	self._curClientKey = msg.clientKey
	self._curServerKey = msg.serverKey
end

function HolyStripeExploreModel:onGameMove(msg)
	self._curGrid = msg.gridId

	local cfg = HolyStripeExploreConfig.instance:getSpeedById(self._curInfo.speedPlanId)

	self._curSpeed = cfg and cfg.speed
	self._curNumberList = HolyStripeExploreConfig.instance:getNumberListById(msg.numberPlanId)
	self._curGameTimes = checkint(msg.gameCount)
	self.CiList = msg.changeSetId

	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
end

function HolyStripeExploreModel:onBuyTime(msg)
	self._curBuyTimes = checkint(msg.buyGameCount)
end

function HolyStripeExploreModel:showCI()
	MaterialController.instance:showChangeSetInTemp(checknumber(self.CiList))

	self.CiList = nil
end

function HolyStripeExploreModel:getEncryptedKey(...)
	local clientKey = self._curClientKey
	local serverKey = self._curServerKey
	local nums = {
		...
	}
	local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, nums)

	return tostring(encryptedKey)
end

function HolyStripeExploreModel:getCurInfo()
	if self._curInfo then
		local timeNow = ServerTime.now()

		if timeNow > self:getCurEndTime() then
			self:onReset()
		end
	end

	return self._curInfo
end

function HolyStripeExploreModel:getCurSpeed()
	return self._curSpeed or 1
end

function HolyStripeExploreModel:getCurNumberList()
	return self._curNumberList
end

function HolyStripeExploreModel:getCurMapInfos()
	local infoList = {}
	local mapCfgs = HolyStripeExploreConfig.instance:getMapCfgById(self._curMapId)
	local totalChessNum = table.nums(mapCfgs)

	for i = 1, totalChessNum do
		local info = {}

		info.id = i - 1

		local mapCfg = mapCfgs[info.id]

		if mapCfg then
			info.posX = mapCfg.posX or 0
		end

		if mapCfg then
			info.posY = mapCfg.posY or 0
		end

		table.insert(infoList, info)
	end

	infoList[1].isFirst = true
	infoList[totalChessNum].isEnd = true

	return infoList
end

function HolyStripeExploreModel:getCurGridId()
	return Mathf.Clamp(checkint(self._curGrid) + 1, 1, #self:getCurMapInfos())
end

function HolyStripeExploreModel:checkHasGetBigPrize()
	return self:getCurGridId() >= #self:getCurMapInfos()
end

function HolyStripeExploreModel:getCurLeftGameTime()
	local gameLimitTime = checkint(HolyStripeExploreConfig.instance:getCommonValue("INIT_STEP_COUNT"))
	local curLeftGameTime = self._curBuyTimes + gameLimitTime - self._curGameTimes

	return math.max(0, curLeftGameTime)
end

function HolyStripeExploreModel:getCurLeftBuyTimeAndTimeLimit()
	local buyLimitTime = checkint(HolyStripeExploreConfig.instance:getCommonValue("BUY_TIME_LIMIT"))
	local curLeftBuyTime = buyLimitTime - self._curBuyTimes

	return math.max(0, curLeftBuyTime), buyLimitTime
end

function HolyStripeExploreModel:getCurEndTime()
	return math.floor(self._curEndTime / 1000)
end

HolyStripeExploreModel.instance = HolyStripeExploreModel.New()

return HolyStripeExploreModel
