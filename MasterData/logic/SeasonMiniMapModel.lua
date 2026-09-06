-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/model/SeasonMiniMapModel.lua

module("logic.extensions.season.model.SeasonMiniMapModel", package.seeall)

local SeasonMiniMapModel = class("SeasonMiniMapModel", BaseModel)

function SeasonMiniMapModel:onInit()
	return
end

function SeasonMiniMapModel:onReset()
	if self._minimapRes then
		self._minimapRes:Release()

		self._minimapRes = nil
	end

	self._minimapTexture = nil

	if self._regionMinimapTexture then
		for k, v in pairs(self._regionMinimapTexture) do
			UnityEngine.RenderTexture.ReleaseTemporary(v)
		end
	end

	self._regionMinimapTexture = nil
end

function SeasonMiniMapModel:getMinimapTexture()
	return self._minimapTexture
end

function SeasonMiniMapModel:setMinimapTexture(minimapTexture)
	self._minimapTexture = minimapTexture
end

function SeasonMiniMapModel:setMinimapRes(res)
	if self._minimapRes then
		self._minimapRes:Release()
	end

	self._minimapRes = res

	if self._minimapRes then
		self._minimapRes:Retain()
	end
end

function SeasonMiniMapModel:getRegionMinimapTexture(index)
	if not self._regionMinimapTexture then
		return
	end

	return self._regionMinimapTexture[index]
end

function SeasonMiniMapModel:setRegionMinimapTexture(index, minimapTexture)
	self._regionMinimapTexture = self._regionMinimapTexture or {}
	self._regionMinimapTexture[index] = minimapTexture
end

SeasonMiniMapModel.instance = SeasonMiniMapModel.New()

return SeasonMiniMapModel
