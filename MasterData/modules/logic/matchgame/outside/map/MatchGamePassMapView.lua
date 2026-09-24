-- chunkname: @modules/logic/matchgame/outside/map/MatchGamePassMapView.lua

module("modules.logic.matchgame.outside.map.MatchGamePassMapView", package.seeall)

local MatchGamePassMapView = class("MatchGamePassMapView", BaseView)

function MatchGamePassMapView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGamePassMapView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function MatchGamePassMapView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function MatchGamePassMapView:_btnCloseOnClick()
	self:closeThis()
end

function MatchGamePassMapView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function MatchGamePassMapView:onOpen()
	AudioMgr.instance:trigger(MatchGameAudioEnum.PassGame)
end

function MatchGamePassMapView:onClose()
	return
end

function MatchGamePassMapView:onDestroyView()
	return
end

return MatchGamePassMapView
