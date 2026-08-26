-- chunkname: @modules/logic/versionactivity1_3/va3chess/model/Va3ChessModel.lua

module("modules.logic.versionactivity1_3.va3chess.model.Va3ChessModel", package.seeall)

local Va3ChessModel = class("Va3ChessModel", BaseModel)

function Va3ChessModel:onInit()
	return
end

function Va3ChessModel:reInit()
	return
end

function Va3ChessModel:_registerModelIns()
	return {
		[Va3ChessEnum.ActivityId.Act120] = Activity120Model.instance,
		[Va3ChessEnum.ActivityId.Act122] = Activity122Model.instance,
		[Va3ChessEnum.ActivityId.Act142] = Activity142Model.instance
	}
end

function Va3ChessModel:_getModelIns(actId)
	if not self._acModelInsMap then
		self._acModelInsMap = self:_registerModelIns()

		local funcNames = {
			"getEpisodeData"
		}

		for _, insCls in pairs(self._acModelInsMap) do
			for __, funName in ipairs(funcNames) do
				if not insCls[funName] or type(insCls[funName]) ~= "function" then
					logError(string.format("[%s] can not find function [%s]", insCls.__cname, funName))
				end
			end
		end
	end

	local modelIns = self._acModelInsMap[actId]

	if not modelIns then
		logError(string.format("棋盘小游戏Model没注册，activityId[%s]", actId))
	end

	return modelIns
end

function Va3ChessModel:setEpisodeId(episodeId)
	self._currentEpisodeId = episodeId

	if not episodeId then
		self._currentMapId = nil

		return
	end

	local episodeCfg = Va3ChessConfig.instance:getEpisodeCo(self._activityId, episodeId)

	if episodeCfg then
		if episodeCfg.mapId then
			self._currentMapId = episodeCfg.mapId
		elseif episodeCfg.mapIds then
			local mapIds = string.split(episodeCfg.mapIds, "#")

			self._currentMapId = tonumber(mapIds[1])
		end
	else
		logError("activity109_episode not found! id = " .. tostring(episodeId) .. ", in act = " .. tostring(self._activityId))

		self._currentMapId = nil
	end
end

function Va3ChessModel:setActId(actId)
	self._activityId = actId
end

function Va3ChessModel:getActId()
	return self._activityId
end

function Va3ChessModel:getEpisodeId()
	return self._currentEpisodeId
end

function Va3ChessModel:getMapId()
	return self._currentMapId
end

function Va3ChessModel:getEpisodeData(episodeId)
	local modelIns = self:_getModelIns(self._activityId)

	if modelIns then
		return modelIns:getEpisodeData(episodeId)
	end
end

Va3ChessModel.instance = Va3ChessModel.New()

return Va3ChessModel
