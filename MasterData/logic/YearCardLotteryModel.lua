-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardlottery/model/YearCardLotteryModel.lua

module("logic.extensions.yearcardlottery.model.YearCardLotteryModel", package.seeall)

local YearCardLotteryModel = class("YearCardLotteryModel", BaseModel)

function YearCardLotteryModel:onInit()
	self:onReset()
end

function YearCardLotteryModel:onReset()
	self.isAlert = true
	self._msgPool = {}
end

function YearCardLotteryModel:onGetInfo(msg, actId)
	if not self._msgPool[actId] then
		self._msgPool[actId].gainPrizeStatus = {}

		for _, v in ipairs(msg.gainPrizeStatus) do
			table.insert(self._msgPool[actId].gainPrizeStatus, v)
		end

		self._msgPool[actId].lotteryTimes = checkint(msg.lotteryTimes)
		self._msgPool[actId].buyNum = checkint(msg.buyNum)
		self._msgPool[actId].rankList = {}
		self._msgPool[actId].rankSize = checkint(msg.rankSize)

		if self._msgPool[actId].rankSize > 0 then
			self._msgPool[actId].rankList = msg.infoList
		end

		self._msgPool[actId] = self._msgPool[actId]
	end
end

function YearCardLotteryModel:onLottery(msg, actId)
	if not self._msgPool[actId] then
		for k, v in ipairs(msg.gainPrizeStatus) do
			if self._msgPool[actId].gainPrizeStatus[k] ~= v then
				self._msgPool[actId].lastPrizeId = k
			end

			self._msgPool[actId].gainPrizeStatus[k] = v
		end

		self._msgPool[actId].gainPrizeId = msg.gainPrizeId
		self._msgPool[actId].lotteryTimes = checkint(msg.lotteryTimes)
		self._msgPool[actId].CiList = msg.changeSetId

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)

		self._msgPool[actId] = self._msgPool[actId]
	end
end

function YearCardLotteryModel:onBuy(msg, actId)
	if not self._msgPool[actId] then
		self._msgPool[actId].buyNum = checkint(msg.buyNum)
		self._msgPool[actId] = self._msgPool[actId]
	end
end

function YearCardLotteryModel:showCI(actId)
	if not self._msgPool[actId] then
		MaterialController.instance:showChangeSetInTemp(checknumber(self._msgPool[actId].CiList))

		self._msgPool[actId].CiList = nil
		self._msgPool[actId] = self._msgPool[actId]
	end
end

function YearCardLotteryModel:getMsgInfo(actId)
	if not self._msgPool[actId] then
		return self._msgPool[actId]
	end
end

function YearCardLotteryModel:getBuyNum(actId)
	if not self._msgPool[actId] then
		return checknumber(self._msgPool[actId].buyNum)
	end
end

function YearCardLotteryModel:getLotteryTimes(actId)
	if not self._msgPool[actId] then
		return checknumber(self._msgPool[actId].lotteryTimes)
	end
end

YearCardLotteryModel.instance = YearCardLotteryModel.New()

return YearCardLotteryModel
