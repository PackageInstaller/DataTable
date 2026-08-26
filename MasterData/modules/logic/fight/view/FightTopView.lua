-- chunkname: @modules/logic/fight/view/FightTopView.lua

module("modules.logic.fight.view.FightTopView", package.seeall)

local FightTopView = class("FightTopView", FightBaseView)

function FightTopView:onInitView()
	return
end

function FightTopView:addEvents()
	return
end

function FightTopView:removeEvents()
	return
end

function FightTopView:onOpen()
	self:com_openSubView(FightCheckShowPower10View, self.viewGO)
	self:com_openSubView(FightBossPassiveTipsView, self.viewGO)
end

function FightTopView:onClose()
	return
end

function FightTopView:onDestroyView()
	return
end

return FightTopView
