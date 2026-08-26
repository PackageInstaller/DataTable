-- chunkname: @modules/logic/survival/view/shelter/ShelterSceneUnitView.lua

module("modules.logic.survival.view.shelter.ShelterSceneUnitView", package.seeall)

local ShelterSceneUnitView = class("ShelterSceneUnitView", BaseView)

function ShelterSceneUnitView:onInitView()
	self._sceneroot = gohelper.findChild(self.viewGO, "go_ui")
	self._sceneroot2 = gohelper.findChild(self.viewGO, "go_ui2")
end

function ShelterSceneUnitView:addEvents()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterMapUnitDel, self._onUnitDel, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterMapUnitAdd, self._onUnitAdd, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterMapUnitChange, self._onUnitChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMainViewVisible, self.onMainViewVisible, self)
end

function ShelterSceneUnitView:removeEvents()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterMapUnitDel, self._onUnitDel, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterMapUnitAdd, self._onUnitAdd, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterMapUnitChange, self._onUnitChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMainViewVisible, self.onMainViewVisible, self)
end

function ShelterSceneUnitView:onMainViewVisible(isVisible)
	if not self._allUI then
		return
	end

	for _, unitDict in pairs(self._allUI) do
		for _, unit in pairs(unitDict) do
			unit:playAnim((isVisible or nil) and (UIAnimationName.Open or UIAnimationName.Close))
		end
	end
end

function ShelterSceneUnitView:onOpen()
	self._allUI = {}
	self._itemResPath = self.viewContainer._viewSetting.otherRes.unititem
	self._allLayers = self:getUserDataTb_()

	self:initAllUnit()
end

function ShelterSceneUnitView:initAllUnit()
	local allUnit = SurvivalMapHelper.instance:getAllShelterEntity()

	if not allUnit then
		return
	end

	for unitType, unitDict in pairs(allUnit) do
		for unitId, unit in pairs(unitDict) do
			self:addUnitUI(unitType, unitId)
		end
	end
end

function ShelterSceneUnitView:_onUnitDel(unitType, unitId)
	self:removeUnitUI(unitType, unitId)
end

function ShelterSceneUnitView:_onUnitAdd(unitType, unitId)
	self:addUnitUI(unitType, unitId)
end

function ShelterSceneUnitView:_onUnitChange(unitType, unitId)
	self:refreshUnitUI(unitType, unitId)
end

function ShelterSceneUnitView:addUnitUI(unitType, unitId)
	local dict = self:getUnitDict(unitType)
	local unit = dict[unitId]

	if not unit then
		local entity = SurvivalMapHelper.instance:getShelterEntity(unitType, unitId)

		if entity and entity:needUI() then
			local layer = unitType * 100
			local layerGO = self:getLayerGO(layer)
			local name = string.format("%s_%s", SurvivalEnum.ShelterUnitTypeToName[unitType], unitId)
			local go = self:getResInst(self._itemResPath, layerGO, name)

			unit = MonoHelper.addNoUpdateLuaComOnceToGo(go, ShelterUnitUIItem, {
				unitType = unitType,
				unitId = unitId,
				root1 = layerGO,
				root2 = self._sceneroot2
			})
			dict[unitId] = unit
		end
	end

	return unit
end

function ShelterSceneUnitView:removeUnitUI(unitType, unitId)
	local dict = self:getUnitDict(unitType)
	local unit = dict[unitId]

	if unit then
		unit:dispose()

		dict[unitId] = nil
	end
end

function ShelterSceneUnitView:refreshUnitUI(unitType, unitId)
	local dict = self:getUnitDict(unitType)

	if unitId then
		local unit = dict[unitId]

		if unit then
			unit:refreshInfo()
		end
	else
		for _, unit in pairs(dict) do
			unit:refreshInfo()
		end
	end

	if unitType == SurvivalEnum.ShelterUnitType.Player then
		self:refreshUnitUI(SurvivalEnum.ShelterUnitType.Monster)
		self:refreshUnitUI(SurvivalEnum.ShelterUnitType.Npc)
	end
end

function ShelterSceneUnitView:getUnitDict(unitType)
	local dict = self._allUI[unitType]

	if not dict then
		dict = {}
		self._allUI[unitType] = dict
	end

	return dict
end

function ShelterSceneUnitView:getLayerGO(layer)
	layer = layer or 0
	self._allLayers[layer] = self._allLayers[layer] or gohelper.create2d(self._sceneroot, "Layer" .. layer)

	return self._allLayers[layer]
end

return ShelterSceneUnitView
