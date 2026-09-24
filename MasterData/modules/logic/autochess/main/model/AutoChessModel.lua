-- chunkname: @modules/logic/autochess/main/model/AutoChessModel.lua

module("modules.logic.autochess.main.model.AutoChessModel", package.seeall)

local AutoChessModel = class("AutoChessModel", BaseModel)

function AutoChessModel:onEnterScene(moduleId, scene, actId)
	self.moduleId = moduleId

	local mo = AutoChessSceneMo.New()

	mo:init(scene)

	self.sceneMo = mo
	self.actId = actId
end

function AutoChessModel:setEpisodeId(id)
	self.episodeId = id
end

function AutoChessModel:getSceneMo(ignore)
	if self.sceneMo then
		return self.sceneMo
	elseif not ignore then
		logError("异常:不存在游戏数据")
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
	self.sceneMo = nil
end

AutoChessModel.instance = AutoChessModel.New()

return AutoChessModel
