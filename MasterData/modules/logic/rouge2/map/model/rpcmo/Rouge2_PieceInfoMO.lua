-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_PieceInfoMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_PieceInfoMO", package.seeall)

local Rouge2_PieceInfoMO = pureTable("Rouge2_PieceInfoMO")

function Rouge2_PieceInfoMO:init(pieceInfo)
	self.index = pieceInfo.index
	self.id = pieceInfo.id
	self.talkId = pieceInfo.talkId
	self.finish = pieceInfo.finish
	self.canSelectId = pieceInfo.canSelectId
	self.selectId = pieceInfo.selectId

	self:updateTriggerStr(pieceInfo.triggerStr)

	self.pieceCo = Rouge2_MapConfig.instance:getPieceCo(self.id)
end

function Rouge2_PieceInfoMO:update(pieceInfo)
	self.finish = pieceInfo.finish
	self.canSelectId = pieceInfo.canSelectId
	self.selectId = pieceInfo.selectId

	self:updateTriggerStr(pieceInfo.triggerStr)
end

function Rouge2_PieceInfoMO:updateTriggerStr(triggerStr)
	if string.nilorempty(triggerStr) or triggerStr == "null" then
		self.triggerStr = nil
	else
		self.triggerStr = cjson.decode(triggerStr)
	end
end

function Rouge2_PieceInfoMO:getPieceCo()
	return self.pieceCo
end

function Rouge2_PieceInfoMO:getSelectIdList()
	return self.selectId
end

function Rouge2_PieceInfoMO:getLastSelectId()
	if self.selectId then
		if not #self.selectId then
			local selectIdNum = 0

			return self.selectId and self.selectId[selectIdNum]
		end
	end
end

function Rouge2_PieceInfoMO:getSelectCheckResList()
	return self.triggerStr and self.triggerStr.selectCheckResList
end

function Rouge2_PieceInfoMO:getSelectCheckRate(selectId)
	if self.triggerStr then
		local checkRateMap = self.triggerStr.selectCheckRateMap
		local checkRate = checkRateMap and checkRateMap[tostring(selectId)]

		return checkRate or 0
	end
end

function Rouge2_PieceInfoMO:getCanselectIds()
	return self.canSelectId
end

function Rouge2_PieceInfoMO:getEndEpisodeId()
	return self.triggerStr and self.triggerStr.endEpisodeId
end

function Rouge2_PieceInfoMO:isFightFail()
	return self.triggerStr and self.triggerStr.fightFail
end

function Rouge2_PieceInfoMO:isFinish()
	return self.finish
end

return Rouge2_PieceInfoMO
