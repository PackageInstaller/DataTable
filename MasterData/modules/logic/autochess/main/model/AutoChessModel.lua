-- chunkname: @modules/logic/autochess/main/model/AutoChessModel.lua

module("modules.logic.autochess.main.model.AutoChessModel", package.seeall)

local AutoChessModel = class("AutoChessModel", BaseModel)

function AutoChessModel:enterSceneReply(moduleId, scene, actId)
	self.actId = actId
	self.moduleId = moduleId

	local mo = AutoChessMO.New()

	mo:updateSvrScene(scene)

	self.chessMo = mo
end

function AutoChessModel:setEpisodeId(id)
	self.episodeId = id
end

function AutoChessModel:getChessMo(noError)
	if self.chessMo then
		return self.chessMo
	end

	if not noError then
		logError("异常:不存在游戏数据%s")
	end
end

function AutoChessModel:svrResultData(data)
	self.resultData = data
end

function AutoChessModel:svrSettleData(data)
	self.settleData = data
end

function AutoChessModel:clearData()
	self.actId = nil
	self.moduleId = nil
	self.episodeId = nil
	self.chessMo = nil
end

AutoChessModel.instance = AutoChessModel.New()

return AutoChessModel
