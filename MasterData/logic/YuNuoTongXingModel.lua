-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunuotongxing/model/YuNuoTongXingModel.lua

module("logic.extensions.yunuotongxing.model.YuNuoTongXingModel", package.seeall)

local YuNuoTongXingModel = class("YuNuoTongXingModel", BaseModel)

function YuNuoTongXingModel:onInit()
	self:onReset()
end

function YuNuoTongXingModel:onReset()
	self._msgPool = {}
	self._randomPieceIdsMap = {}
end

function YuNuoTongXingModel:getInfo(activityId)
	return self._msgPool[activityId]
end

function YuNuoTongXingModel:getRandomPieceIds(activityId)
	local cache = self._randomPieceIdsMap[activityId]

	if cache then
		return cache
	end

	local pieceCfgs = YuNuoTongXingConfig.instance:getPiecePlanCfgs(activityId) or {}

	cache = {}

	for _, cfg in ipairs(pieceCfgs) do
		table.insert(cache, cfg.pieceId)
	end

	MathUtil.randArray(cache)

	self._randomPieceIdsMap[activityId] = cache

	return cache
end

function YuNuoTongXingModel:onGetInfo(msg)
	local activityId = msg.activityId

	self._msgPool[activityId] = GameUtil.pbToTable(msg)
end

function YuNuoTongXingModel:onSetPiece(msg)
	local activityId = msg.activityId
	local pieceId = msg.pieceId
	local info = self._msgPool[activityId]

	if info then
		info.gainPieceIds = info.gainPieceIds or {}
		info.placePieceIds = info.placePieceIds or {}

		table.insert(info.placePieceIds, pieceId)
	end
end

function YuNuoTongXingModel:onGetPrize(msg)
	local activityId = msg.activityId
	local prizeId = msg.prizeId
	local info = self._msgPool[activityId]

	if info then
		info.gainProgressPrizeIds = info.gainProgressPrizeIds or {}

		table.insert(info.gainProgressPrizeIds, prizeId)
	end
end

YuNuoTongXingModel.instance = YuNuoTongXingModel.New()

return YuNuoTongXingModel
