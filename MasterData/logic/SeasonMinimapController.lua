-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/controller/SeasonMinimapController.lua

module("logic.extensions.season.controller.SeasonMinimapController", package.seeall)

local SeasonMinimapController = class("SeasonMinimapController", BaseController)
local minimapResPath = "ui/bigbg/season/season_minimap.png"

function SeasonMinimapController:onInit()
	return
end

function SeasonMinimapController:onReset()
	self._minimapLoadedCallback = nil
	self._minimapLoadedCallbackObj = nil

	removeresl(minimapResPath, self._onMinimapLoaded, self)
end

function SeasonMinimapController:loadMinimap(callback, callbackObj)
	self._minimapLoadedCallback = callback
	self._minimapLoadedCallbackObj = callbackObj

	local minimapTexture = SeasonMiniMapModel.instance:getMinimapTexture()

	if minimapTexture then
		callback(callbackObj)

		return
	end

	getres(minimapResPath, self._onMinimapLoaded, self)
end

function SeasonMinimapController:_onMinimapLoaded(res)
	SeasonMiniMapModel.instance:setMinimapRes(res)

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	SeasonMiniMapModel.instance:setMinimapTexture(mainAsset)

	if self._minimapLoadedCallback then
		self._minimapLoadedCallback(self._minimapLoadedCallbackObj)
	end
end

SeasonMinimapController.instance = SeasonMinimapController.New()

return SeasonMinimapController
