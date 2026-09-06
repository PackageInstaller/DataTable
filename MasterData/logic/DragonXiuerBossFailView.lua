-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/DragonXiuerBossFailView.lua

module("logic.extensions.dragonxiuer.view.DragonXiuerBossFailView", package.seeall)

local DragonXiuerBossFailView = class("DragonXiuerBossFailView", ViewComponent)

function DragonXiuerBossFailView:ctor()
	DragonXiuerBossFailView.super.ctor(self)
end

function DragonXiuerBossFailView:unbindEvents()
	DragonXiuerBossFailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DragonXiuerBossFailView:bindEvents()
	DragonXiuerBossFailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DragonXiuerBossFailView:buildUI()
	DragonXiuerBossFailView.super.buildUI(self)

	self._btnClose = self:getGo("viewBoxGo")
end

function DragonXiuerBossFailView:onExit()
	DragonXiuerBossFailView.super.onExit(self)
end

function DragonXiuerBossFailView:onEnter()
	DragonXiuerBossFailView.super.onEnter(self)
	DragonXiuerController.instance:resetNeedNotifyReset()
end

return DragonXiuerBossFailView
