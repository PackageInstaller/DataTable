-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/copy/YushenBossFailView.lua

module("logic.extensions.dragonxiuer.view.YushenBossFailView", package.seeall)

local YushenBossFailView = class("YushenBossFailView", ViewComponent)

function YushenBossFailView:ctor()
	YushenBossFailView.super.ctor(self)
end

function YushenBossFailView:unbindEvents()
	YushenBossFailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function YushenBossFailView:bindEvents()
	YushenBossFailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function YushenBossFailView:buildUI()
	YushenBossFailView.super.buildUI(self)

	self._btnClose = self:getGo("viewBoxGo")
end

function YushenBossFailView:onExit()
	YushenBossFailView.super.onExit(self)
end

function YushenBossFailView:onEnter()
	YushenBossFailView.super.onEnter(self)
	DragonXiuerController.instance:resetNeedNotifyReset()
end

return YushenBossFailView
