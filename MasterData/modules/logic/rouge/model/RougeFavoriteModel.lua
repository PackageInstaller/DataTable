-- chunkname: @modules/logic/rouge/model/RougeFavoriteModel.lua

module("modules.logic.rouge.model.RougeFavoriteModel", package.seeall)

local RougeFavoriteModel = class("RougeFavoriteModel", BaseModel)

function RougeFavoriteModel:onInit()
	self:reInit()
end

function RougeFavoriteModel:reInit()
	self._reddots = {}
	self._reviewInfoList = {}
end

function RougeFavoriteModel:initReddots(info)
	self._reddots = {}

	for i, v in ipairs(info) do
		local mo = RougeNewReddotNOMO.New()

		mo:init(v)

		self._reddots[v.type] = mo
	end
end

function RougeFavoriteModel:getReddotNum(type)
	return self._reddots[type].idNum
end

function RougeFavoriteModel:getReddotMap(type)
	return self._reddots[type].idMap
end

function RougeFavoriteModel:getReddot(type, id)
	return self._reddots[type].idMap[id]
end

function RougeFavoriteModel:deleteReddotId(type, id)
	self._reddots[type]:removeId(id)
end

function RougeFavoriteModel:getAllReddotNum()
	local num = 0

	for k, v in pairs(self._reddots) do
		num = num + v.idNum
	end

	return num
end

function RougeFavoriteModel:initReviews(infos)
	self._reviewInfoList = {}

	for _, review in ipairs(infos) do
		local reviewInfo = RougeReviewMO.New()

		reviewInfo:init(review)
		table.insert(self._reviewInfoList, reviewInfo)
	end
end

function RougeFavoriteModel:getReviewInfoList()
	return self._reviewInfoList
end

function RougeFavoriteModel:initUnlockCollectionIds(list)
	self._collectionMap = {}

	for i, v in ipairs(list) do
		self._collectionMap[v] = v
	end
end

function RougeFavoriteModel:collectionIsUnlock(id)
	return self._collectionMap and self._collectionMap[id] ~= nil
end

RougeFavoriteModel.instance = RougeFavoriteModel.New()

return RougeFavoriteModel
