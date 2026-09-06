-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/flyingnuo/model/FlyNuoModel.lua

module("logic.extensions.flyingnuo.model.FlyNuoModel", package.seeall)

local json = require("cjson")
local FlyNuoModel = class("FlyNuoModel", BaseModel)

function FlyNuoModel:ctor()
	return
end

function FlyNuoModel:onInit()
	self:onReset()
end

function FlyNuoModel:onReset()
	self._everMaxScore = 0
	self._actInfo = false
	self._useWudiTag = false

	self:resetGame()
end

function FlyNuoModel:setActivityInfo(info)
	self._actInfo = info
end

function FlyNuoModel:getActivityInfo()
	return self._actInfo
end

function FlyNuoModel:getEverMaxScore()
	return self._everMaxScore
end

function FlyNuoModel:setEverMaxScore(score)
	self._everMaxScore = score
end

function FlyNuoModel:setBuySuccessed(activityId, type, times)
	if self._actInfo and self._actInfo.activityId == activityId then
		if type == 1 then
			self._actInfo.todayGameTimesBuyTimes = times
		else
			self._actInfo.todayGameStartItemBuyTimes = times
		end
	end
end

function FlyNuoModel:getTodayGameStartItemLeftBuyTimes(activityId)
	return FlyNuoConfig.instance:getCanbuyWudiTimes(activityId) - self._actInfo.todayGameStartItemBuyTimes
end

function FlyNuoModel:resetGame()
	self.playViewIsOpen = false
	self._pipeScore = 0
	self._propItemScore = 0
	self._hp = 3
	self._reliveTime = 0
	self._rankInfos = false
	self._hpItemRandomCount = 0
	self._scoreItemRandomCount = 0
	self._hpItemMaxRandomCount = FlyNuoConfig.instance:getHpItemRandomCount()
	self._scoreItemMaxRandomCount = FlyNuoConfig.instance:getScoreItemRandomCount()
end

function FlyNuoModel:addPipeScore()
	self._pipeScore = self._pipeScore + 1
end

function FlyNuoModel:addPropScore(score)
	self._propItemScore = self._propItemScore + score
end

function FlyNuoModel:getPropScore()
	return self._propItemScore
end

function FlyNuoModel:getPipeScore()
	return self._pipeScore * FlyNuoConfig.instance:getPipeScoreXishu()
end

function FlyNuoModel:getScore()
	return self:getPropScore() + self:getPipeScore()
end

function FlyNuoModel:addHp()
	self._hp = self._hp + 1
end

function FlyNuoModel:reduceHp()
	self._hp = math.max(0, self._hp - 1)
end

function FlyNuoModel:getHp()
	return self._hp
end

function FlyNuoModel:relive(reliveTimes)
	self._reliveTime = reliveTimes

	self:addHp()
end

function FlyNuoModel:getReliveTime()
	return self._reliveTime
end

function FlyNuoModel:isUseGameStartItem()
	return self._useGameStartItemFlag
end

function FlyNuoModel:setUseGameStartItem(bool)
	self._useGameStartItemFlag = bool
end

function FlyNuoModel:setRankInfo(ranklist, ranksize, myrank)
	local newRank = {}

	for _, v in ipairs(ranklist) do
		table.insert(newRank, json.decode(v))
	end

	local data = {
		rankList = newRank,
		rankSize = ranksize,
		myRank = myrank
	}

	RankModel.instance:setRankData(data, GameEnum.RankType.FlyNuo, 0)
end

function FlyNuoModel:getRankInfo()
	return self._rankInfos
end

function FlyNuoModel:getMyRank()
	return self._actInfo and self._actInfo.myrank
end

function FlyNuoModel:checkCanAddRandomItem(type)
	local canAdd = false

	if type == 1 then
		self._hpItemRandomCount = self._hpItemRandomCount + 1
		canAdd = self._hpItemRandomCount <= self._hpItemMaxRandomCount
	elseif type == 2 then
		self._scoreItemRandomCount = self._scoreItemRandomCount + 1
		canAdd = self._scoreItemRandomCount <= self._scoreItemMaxRandomCount
	end

	return canAdd
end

function FlyNuoModel:checkAllItemCanExchange(activityId)
	local dot = false
	local list = ActivityshopConfig.instance:getActivityShopCfg(GameEnum.ActivityType.FlyNuo, activityId)

	if list then
		for i, v in ipairs(list) do
			dot = self:checkItemCanExchange(activityId, v.shopItemId)

			if dot then
				break
			end
		end
	end

	return dot
end

function FlyNuoModel:checkItemCanExchange(activityId, itemId)
	local dot = false
	local actType = GameEnum.ActivityType.FlyNuo
	local cfg = ActivityshopConfig.instance:getActivityShopCfgByItemId(actType, activityId, itemId)
	local costNum = MaterialFacade.instance:getGoodCostByStr(cfg.sellPrice)
	local has_num = MaterialFacade.instance:getMatNumber(matType, matId)

	if cfg.sellPeriodLimit ~= "none" then
		local buyTimes = ActivityshopModel.instance:getActiveShopBuyTimes(actType, activityId, itemId)

		if buyTimes < cfg.sellLimitCount then
			dot = MaterialFacade.instance:isMatsEnough(cfg.sellPrice)
		end
	else
		dot = MaterialFacade.instance:isMatsEnough(cfg.sellPrice)
	end

	return dot
end

function FlyNuoModel:getUseWudiToggleTag()
	return self._useWudiTag
end

function FlyNuoModel:setWudiToggleTag(tag)
	self._useWudiTag = tag
end

FlyNuoModel.instance = FlyNuoModel.New()

return FlyNuoModel
