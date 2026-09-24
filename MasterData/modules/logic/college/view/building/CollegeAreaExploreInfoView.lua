-- chunkname: @modules/logic/college/view/building/CollegeAreaExploreInfoView.lua

module("modules.logic.college.view.building.CollegeAreaExploreInfoView", package.seeall)

local CollegeAreaExploreInfoView = class("CollegeAreaExploreInfoView", ListScrollCellExtend)

function CollegeAreaExploreInfoView:onInitView()
	self._goExploreStateInfo = gohelper.findChild(self.viewGO, "ExploreStateInfo")
	self._txtExploreDesc = gohelper.findChildText(self.viewGO, "#scroll_ExploreDescr/Viewport/#txt_ExploreDescr")
	self._exploreComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goExploreStateInfo, CollegeAreaExploreComp)

	gohelper.setActive(self.viewGO, true)
end

function CollegeAreaExploreInfoView:onUpdateMO(mapAreaMo)
	self:initData(mapAreaMo or self._mapAreaMo)
end

function CollegeAreaExploreInfoView:initData(mapAreaMo)
	self._mapAreaMo = mapAreaMo
	self._mapAreaCo = mapAreaMo.co
	self._areaId = mapAreaMo.id

	self._exploreComp:onUpdateMO(mapAreaMo)
	self:refreshUI()
end

function CollegeAreaExploreInfoView:refreshUI()
	gohelper.setActive(self._goExploreStateInfo, not self._mapAreaMo.isFinish)

	self._txtExploreDesc.text = self._mapAreaMo.isFinish and CollegeHelper.instance:getBuildingDesc(self._mapAreaCo) or GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("college_bottominfoview_arearule"), self._mapAreaCo.turnsPerStep, self._mapAreaCo.progressPerStep)
end

return CollegeAreaExploreInfoView
