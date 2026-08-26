-- chunkname: @modules/logic/rouge2/outside/model/Rouge2_FavoriteModel.lua

module("modules.logic.rouge2.outside.model.Rouge2_FavoriteModel", package.seeall)

local Rouge2_FavoriteModel = class("Rouge2_FavoriteModel", BaseModel)

function Rouge2_FavoriteModel:onInit()
	self:reInit()
end

function Rouge2_FavoriteModel:reInit()
	self._reddots = {}
	self._reviewInfoList = {}
end

function Rouge2_FavoriteModel:initReddots(info)
	self._reddots = {}

	for i, v in ipairs(info) do
		local mo = RougeNewReddotNOMO.New()

		mo:init(v)

		self._reddots[v.type] = mo
	end
end

function Rouge2_FavoriteModel:getReddotNum(type)
	return self._reddots[type].idNum
end

function Rouge2_FavoriteModel:getReddotMap(type)
	return self._reddots[type].idMap
end

function Rouge2_FavoriteModel:getReddot(type, id)
	return self._reddots[type].idMap[id]
end

function Rouge2_FavoriteModel:deleteReddotId(type, id)
	self._reddots[type]:removeId(id)
end

function Rouge2_FavoriteModel:getAllReddotNum()
	local num = 0

	for k, v in pairs(self._reddots) do
		num = num + v.idNum
	end

	return num
end

function Rouge2_FavoriteModel:initReviews(infos)
	self._reviewInfoList = {}

	for _, review in ipairs(infos) do
		local reviewInfo = RougeReviewMO.New()

		reviewInfo:init(review)
		table.insert(self._reviewInfoList, reviewInfo)
	end
end

function Rouge2_FavoriteModel:getReviewInfoList()
	return self._reviewInfoList
end

function Rouge2_FavoriteModel:initUnlockCollectionIds(list)
	self._collectionMap = {}

	for i, v in ipairs(list) do
		self._collectionMap[v] = v
	end
end

function Rouge2_FavoriteModel:collectionIsUnlock(id)
	return self._collectionMap and self._collectionMap[id] ~= nil
end

Rouge2_FavoriteModel.instance = Rouge2_FavoriteModel.New()

return Rouge2_FavoriteModel
