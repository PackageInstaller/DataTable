-- chunkname: @modules/logic/college/view/building/CollegeAreaView.lua

module("modules.logic.college.view.building.CollegeAreaView", package.seeall)

local CollegeAreaView = class("CollegeAreaView", CollegeBottomInfoView)

function CollegeAreaView:onInitView()
	CollegeAreaView.super.onInitView(self)

	self._compList = {}

	table.insert(self._compList, MonoHelper.addNoUpdateLuaComOnceToGo(self._goInfoDispatch, CollegeAreaActorSlotView))
	table.insert(self._compList, MonoHelper.addNoUpdateLuaComOnceToGo(self._goInfoBuff, CollegeBuildingRefinedPropView, CollegeEnum.SceneType.Map))
	table.insert(self._compList, MonoHelper.addNoUpdateLuaComOnceToGo(self._goExploreInfo, CollegeAreaExploreInfoView))
	gohelper.setActive(self._goBuildInfo, false)
	gohelper.setActive(self._goStateInfo, true)
	gohelper.setActive(self._goCostRow, false)
end

function CollegeAreaView:addEvents()
	CollegeAreaView.super.addEvents(self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateArea, self.updateData, self)
end

function CollegeAreaView:onOpen()
	self:updateData(self.viewParam and self.viewParam.data)
end

function CollegeAreaView:updateData(data)
	self._mapAreaMo = data or self._mapAreaMo
	self._mapAreaCo = self._mapAreaMo.co

	self:refreshUI()
end

function CollegeAreaView:refreshUI()
	self._txtTitle.text = self._mapAreaCo.name

	for _, comp in ipairs(self._compList) do
		comp:onUpdateMO(self._mapAreaMo)
	end
end

return CollegeAreaView
