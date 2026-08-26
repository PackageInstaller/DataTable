-- chunkname: @modules/logic/fight/view/FightBottomRightView.lua

module("modules.logic.fight.view.FightBottomRightView", package.seeall)

local FightBottomRightView = class("FightBottomRightView", FightBaseView)

function FightBottomRightView:onInitView()
	return
end

function FightBottomRightView:addEvents()
	return
end

function FightBottomRightView:removeEvents()
	return
end

function FightBottomRightView:onOpen()
	self.handCardSkinMgr = self:newClass(FightViewHandCardSkinMgr)
end

function FightBottomRightView:onClose()
	return
end

function FightBottomRightView:onDestroyView()
	return
end

return FightBottomRightView
