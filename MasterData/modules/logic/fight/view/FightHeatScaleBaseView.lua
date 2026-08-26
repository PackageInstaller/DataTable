-- chunkname: @modules/logic/fight/view/FightHeatScaleBaseView.lua

module("modules.logic.fight.view.FightHeatScaleBaseView", package.seeall)

local FightHeatScaleBaseView = class("FightHeatScaleBaseView", UserDataDispose)

function FightHeatScaleBaseView:initView(viewGo, teamType)
	self:__onInit()

	self.viewGo = viewGo
	self.teamType = teamType
end

function FightHeatScaleBaseView:addEvents()
	return
end

function FightHeatScaleBaseView:onOpen()
	return
end

function FightHeatScaleBaseView:destroy()
	gohelper.destroy(self.viewGo)
	self:__onDispose()
end

return FightHeatScaleBaseView
