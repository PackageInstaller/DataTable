-- chunkname: @modules/logic/dungeon/view/advplay/fragments/DungeonSurvivalComp.lua

module("modules.logic.dungeon.view.advplay.fragments.DungeonSurvivalComp", package.seeall)

local DungeonSurvivalComp = class("DungeonSurvivalComp", AdvPlayFragmentBase)

function DungeonSurvivalComp:onInit()
	self.btn_start = gohelper.findChildButtonWithAudio(self.viewGO, "right/contain/#btn_start")
	self.go_red = gohelper.findChild(self.viewGO, "right/contain/#go_red")

	RedDotController.instance:addRedDot(self.go_red, RedDotEnum.DotNode.AdvPlay_Survival)
end

function DungeonSurvivalComp:onAddListeners()
	self.addClickCb(self, self.btn_start, self.onClickBtnStart, self)
end

function DungeonSurvivalComp:onClickBtnStart()
	SurvivalController.instance:openSurvivalView(false)
end

return DungeonSurvivalComp
