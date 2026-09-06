-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playmusic/controller/PlayMusicController.lua

module("logic.extensions.playmusic.controller.PlayMusicController", package.seeall)

local PlayMusicController = class("PlayMusicController", BaseController)

function PlayMusicController:ctor()
	return
end

function PlayMusicController:onInit()
	self:onReset()
end

function PlayMusicController:onReset()
	return
end

function PlayMusicController:getLoadSymbolIdList()
	local gamePlanId = PlayMusicConfig.instance:getCurGamePlanId()
	local lineCfg = PlayMusicConfig.instance:getPmLineCfgById(gamePlanId)
	local symbolIdPool = {}

	for _, lineData in ipairs(lineCfg) do
		if not string.nilorempty(lineData.symbolProbability) then
			local symbolStrArray = string.split(lineData.symbolProbability)

			for _, symbolStr in ipairs(symbolStrArray) do
				local fieldArray = string.split(symbolStr, ":")
				local symbolId = checknumber(fieldArray[1])

				symbolIdPool[symbolId] = symbolId
			end
		end
	end

	return (table.values(symbolIdPool))
end

PlayMusicController.instance = PlayMusicController.New()

return PlayMusicController
