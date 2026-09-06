-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonFindKeyGridShowView.lua

module("logic.extensions.season.view.SeasonFindKeyGridShowView", package.seeall)

local SeasonFindKeyGridShowView = class("SeasonFindKeyGridShowView", SeasonBaseGridShowView)

function SeasonFindKeyGridShowView:ctor()
	SeasonFindKeyGridShowView.super.ctor(self)
end

function SeasonFindKeyGridShowView:unbindEvents()
	SeasonFindKeyGridShowView.super.unbindEvents(self)
end

function SeasonFindKeyGridShowView:bindEvents()
	SeasonFindKeyGridShowView.super.bindEvents(self)
end

function SeasonFindKeyGridShowView:buildUI()
	SeasonFindKeyGridShowView.super.buildUI(self)

	self._txtDesc = self:getTxt("txtDesc")
	self._imgCon = self:getGo("imgCon")
end

function SeasonFindKeyGridShowView:onExit()
	SeasonFindKeyGridShowView.super.onExit(self)
	uGuiUtil.clearImage(self._imgCon)
end

function SeasonFindKeyGridShowView:onEnter()
	SeasonFindKeyGridShowView.super.onEnter(self)

	local params = self:getFirstParam()

	self._evtDetailConfig = params.evtDetailConfig
	self._txtDesc.text = self._evtDetailConfig.desc

	if not string.nilorempty(self._evtDetailConfig.keyRes) then
		uGuiUtil.setSpriteToImage(self._imgCon, nil, GameUrl.getBigbgFolderUrl("season", self._evtDetailConfig.keyRes))
	end
end

return SeasonFindKeyGridShowView
