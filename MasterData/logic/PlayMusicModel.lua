-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playmusic/model/PlayMusicModel.lua

module("logic.extensions.playmusic.model.PlayMusicModel", package.seeall)

local PlayMusicModel = class("PlayMusicModel", BaseModel)
local SymbolComps = {
	CircleSymbolCell
}

function PlayMusicModel:ctor()
	return
end

function PlayMusicModel:onInit()
	self:onReset()
end

function PlayMusicModel:onReset()
	return
end

function PlayMusicModel:getSymbolPrefabPath(symbolId)
	local symbolData = PlayMusicConfig.instance:getPmSymbolData(symbolId)

	return string.format("ui/views/%s.prefab", symbolData.prefabName)
end

function PlayMusicModel:getSymbolComp(symbolId)
	local symbolData = PlayMusicConfig.instance:getPmSymbolData(symbolId)

	return SymbolComps[symbolData.compId]
end

PlayMusicModel.instance = PlayMusicModel.New()

return PlayMusicModel
