-- chunkname: @modules/logic/dungeon/view/advplay/fragments/DungeonExploreComp.lua

module("modules.logic.dungeon.view.advplay.fragments.DungeonExploreComp", package.seeall)

local DungeonExploreComp = class("DungeonExploreComp", AdvPlayFragmentBase)

function DungeonExploreComp:onInit()
	self.btn_start = gohelper.findChildButtonWithAudio(self.viewGO, "right/contain/#btn_start")
	self.go_red = gohelper.findChild(self.viewGO, "right/contain/#go_red")

	RedDotController.instance:addRedDot(self.go_red, RedDotEnum.DotNode.AdvPlay_Explore)
end

function DungeonExploreComp:onAddListeners()
	self.addClickCb(self, self.btn_start, self.onClickBtnStart, self)
end

function DungeonExploreComp:onClickBtnStart()
	if OptionPackageController.instance:checkNeedDownload(OptionPackageEnum.Package.Explore) then
		return
	end

	ViewMgr.instance:openView(ViewName.DungeonExploreView)
end

return DungeonExploreComp
