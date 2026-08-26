-- chunkname: @modules/logic/fight/view/FightViewDragChangeSubHero.lua

module("modules.logic.fight.view.FightViewDragChangeSubHero", package.seeall)

local FightViewDragChangeSubHero = class("FightViewDragChangeSubHero", BaseView)

function FightViewDragChangeSubHero:onInitView()
	self._containerGO = gohelper.findChild(self.viewGO, "root/changeSub")

	gohelper.setActive(self._containerGO, false)
end

function FightViewDragChangeSubHero:addEvents()
	return
end

function FightViewDragChangeSubHero:removeEvents()
	return
end

function FightViewDragChangeSubHero:onOpen()
	return
end

function FightViewDragChangeSubHero:onClose()
	return
end

return FightViewDragChangeSubHero
