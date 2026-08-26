-- chunkname: @modules/logic/fight/view/FightCenterView.lua

module("modules.logic.fight.view.FightCenterView", package.seeall)

local FightCenterView = class("FightCenterView", FightBaseView)

function FightCenterView:onInitView()
	return
end

function FightCenterView:addEvents()
	return
end

function FightCenterView:removeEvents()
	return
end

function FightCenterView:onOpen()
	self:newClass(FightToughnessBreakEffect, self.viewGO)
end

function FightCenterView:onClose()
	return
end

function FightCenterView:onDestroyView()
	return
end

return FightCenterView
