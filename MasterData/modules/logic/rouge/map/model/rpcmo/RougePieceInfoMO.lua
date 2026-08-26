-- chunkname: @modules/logic/rouge/map/model/rpcmo/RougePieceInfoMO.lua

module("modules.logic.rouge.map.model.rpcmo.RougePieceInfoMO", package.seeall)

local RougePieceInfoMO = pureTable("RougePieceInfoMO")

function RougePieceInfoMO:init(pieceInfo)
	self.index = pieceInfo.index
	self.id = pieceInfo.id
	self.talkId = pieceInfo.talkId
	self.finish = pieceInfo.finish
	self.selectId = pieceInfo.selectId

	self:updateTriggerStr(pieceInfo.triggerStr)

	self.pieceCo = RougeMapConfig.instance:getPieceCo(self.id)
end

function RougePieceInfoMO:update(pieceInfo)
	self.finish = pieceInfo.finish
	self.selectId = pieceInfo.selectId

	self:updateTriggerStr(pieceInfo.triggerStr)
end

function RougePieceInfoMO:updateTriggerStr(triggerStr)
	if string.nilorempty(triggerStr) or triggerStr == "null" then
		self.triggerStr = nil
	else
		self.triggerStr = cjson.decode(triggerStr)
	end
end

function RougePieceInfoMO:getPieceCo()
	return self.pieceCo
end

function RougePieceInfoMO:isFinish()
	return self.finish
end

return RougePieceInfoMO
