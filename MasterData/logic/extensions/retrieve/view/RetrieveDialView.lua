-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveDialView.lua

module("logic.extensions.retrieve.view.RetrieveDialView", package.seeall)

local M = class("RetrieveDialView", ViewComponent)

function M:buildUI()
	self._enterVideo = self:getGo("retrieve_dial_view_-1264721798")
	self._tipsGo = self:getGo("retrieve_dial_view_-1287000517")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	RetrieveDispatcher:addEventListener(RetrieveEventType.Retrieve_Show_Phone, self._onPlayFinished, self)
end

function M:unbindEvents()
	RetrieveDispatcher:removeEventListener(RetrieveEventType.Retrieve_Show_Phone, self._onPlayFinished, self)
end

function M:onEnter()
	goutil.setActive(self._tipsGo, false)
	goutil.setActive(self._enterVideo, false)
	CriwareAudioFacade.instance:playBgmInnerById(CriwareAudioEnum.music_main_zhaomu_02)
end

function M:_onPlayFinished()
	goutil.setActive(self._enterVideo, false)
	goutil.setActive(self._tipsGo, true)
end

function M:onExit()
	return
end

return M
