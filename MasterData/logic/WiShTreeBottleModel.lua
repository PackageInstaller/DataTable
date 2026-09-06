-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wishtreebottle/model/WiShTreeBottleModel.lua

module("logic.extensions.wishtreebottle.model.WiShTreeBottleModel", package.seeall)

local WiShTreeBottleModel = class("WiShTreeBottleModel", BaseModel)

function WiShTreeBottleModel:ctor()
	return
end

function WiShTreeBottleModel:onInit()
	self:onReset()
end

function WiShTreeBottleModel:onReset()
	self.info = {}
	self.hotsRank = {}
	self.newsRank = {}
	self.rankInfo = {}
	self.wishData = {}

	self:resetWishData()

	self.bottleTypeId = 1
	self.dailyLikeNum = 0
	self.likeIds = nil
end

function WiShTreeBottleModel:setInfo(msg)
	GameUtil.pbToTable(msg, self.info)
	self:setDailyLikeNum()
	self:setDailyLikeData()
end

function WiShTreeBottleModel:getInfo()
	return self.info
end

function WiShTreeBottleModel:getDailyLikeIds()
	return self.likeIds
end

function WiShTreeBottleModel:setDailyLikeData()
	self.likeIds = {}
	self.likeIds = self.info.dailyLikeIds
end

function WiShTreeBottleModel:addLikeIds(id)
	self.likeIds = self.likeIds or {}

	table.insert(self.likeIds, id)
end

function WiShTreeBottleModel:setDailyLikeNum()
	if self.info.dailyLikeIds then
		self.dailyLikeNum = #self.info.dailyLikeIds

		return
	end

	self.dailyLikeNum = 0
end

function WiShTreeBottleModel:addDailylikeNum()
	self.dailyLikeNum = self.dailyLikeNum + 1
end

function WiShTreeBottleModel:getDailyLikeNum()
	return self.dailyLikeNum
end

function WiShTreeBottleModel:getWishBottle()
	return self.info.myBottle
end

function WiShTreeBottleModel:setRankInfo(msg)
	GameUtil.pbToTable(msg.hots, self.hotsRank)
	GameUtil.pbToTable(msg.news, self.newsRank)
end

function WiShTreeBottleModel:getHotRankInfo()
	return self.hotsRank
end

function WiShTreeBottleModel:getNewRankInfo()
	return self.newsRank
end

function WiShTreeBottleModel:setWishCache(data)
	self.wishData = data
end

function WiShTreeBottleModel:resetWishData()
	self.wishData.titleId = 1
	self.wishData.desc = ""
end

function WiShTreeBottleModel:getWishData()
	return self.wishData
end

function WiShTreeBottleModel:setBottleTypeId(id)
	self.bottleTypeId = id
end

function WiShTreeBottleModel:getBottleTypeId()
	return self.bottleTypeId
end

WiShTreeBottleModel.instance = WiShTreeBottleModel.New()

return WiShTreeBottleModel
