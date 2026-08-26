-- chunkname: @modules/logic/survival/view/map/SurvivalMapUnitView.lua

module("modules.logic.survival.view.map.SurvivalMapUnitView", package.seeall)

local SurvivalMapUnitView = class("SurvivalMapUnitView", BaseView)

function SurvivalMapUnitView:onInitView()
	self._sceneroot = gohelper.findChild(self.viewGO, "#go_sceneui")
	self._gobubble = gohelper.findChild(self.viewGO, "#go_sceneicon/#go_item")
end

function SurvivalMapUnitView:onOpen()
	self._allUI = {}
	self._allBubble = {}
	self._itemResPath = self.viewContainer._viewSetting.otherRes.unititem
	self._allLayers = self:getUserDataTb_()

	self:initAllUnit()
end

function SurvivalMapUnitView:addEvents()
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitDel, self._onUnitDel, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitAdd, self._onUnitAdd, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitChange, self._onUnitChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.UpdateUnitIsShow, self._onUnitIsShowChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnFollowTaskUpdate, self._onFollowTaskUpdate, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.ShowUnitBubble, self._onShowUnitBubble, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.HideUnitBubble, self._onHideUnitBubble, self)
end

function SurvivalMapUnitView:removeEvents()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitDel, self._onUnitDel, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitAdd, self._onUnitAdd, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitChange, self._onUnitChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.UpdateUnitIsShow, self._onUnitIsShowChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnFollowTaskUpdate, self._onFollowTaskUpdate, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.ShowUnitBubble, self._onShowUnitBubble, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.HideUnitBubble, self._onHideUnitBubble, self)
end

function SurvivalMapUnitView:initAllUnit()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local allUnitMos = sceneMo.unitsById

	for id, unitMo in pairs(allUnitMos) do
		if unitMo.fall then
			self:_onShowUnitBubble(unitMo.id, 1, -1)
		end

		self:addUnitUI(id, unitMo)

		if SurvivalMapHelper.instance:isPetrifactionTar(unitMo) then
			local sceneMo = SurvivalMapModel.instance:getSceneMo()
			local blockType = sceneMo:getBlockTypeByPos(unitMo.pos)

			if blockType and blockType == SurvivalEnum.UnitSubType.Petrifaction then
				self:_onShowUnitBubble(unitMo.id, 1, 0)
			end
		end
	end

	self:addUnitUI(0, sceneMo.player, 99999)
	self:initRoleSkillConfirmItem()
	self:_onUnitIsShowChange(0)
end

function SurvivalMapUnitView:addUnitUI(id, unitMo, layer)
	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	if id ~= 0 and sceneMo:isNoShowIcon(unitMo) then
		return
	end

	if self._allUI[id] then
		return
	end

	if not layer then
		layer = 0

		if unitMo.co and unitMo.co.priority then
			layer = unitMo.co.priority
		end
	end

	if not self._allLayers[layer] then
		self._allLayers[layer] = gohelper.create2d(self._sceneroot, "Layer" .. layer)

		local index = 0

		for val in pairs(self._allLayers) do
			if val < layer then
				index = index + 1
			end
		end

		gohelper.setSibling(self._allLayers[layer], index)
	end

	local name = string.format("%s_%s", SurvivalEnum.UnitTypeToName[unitMo.unitType], unitMo.id)
	local go = self:getResInst(self._itemResPath, self._allLayers[layer], name)
	local cls = self:getUnitCls(id, unitMo)

	self._allUI[id] = MonoHelper.addNoUpdateLuaComOnceToGo(go, cls, unitMo)

	if self._allBubble[id] then
		gohelper.setActive(go, false)
	end
end

function SurvivalMapUnitView:getUnitCls(id, unitMo)
	local cls = SurvivalUnitUIItem

	if id == 0 then
		cls = SurvivalPlayerUIItem
	elseif unitMo.unitType == SurvivalEnum.UnitType.Battle then
		cls = SurvivalFightUIItem
	end

	return cls
end

function SurvivalMapUnitView:_onUnitDel(unitMo)
	self:removeUnitUI(unitMo.id)

	if self._allBubble[unitMo.id] then
		self:_onHideUnitBubble(unitMo.id)
	end
end

function SurvivalMapUnitView:_onUnitAdd(unitMo)
	self:addUnitUI(unitMo.id, unitMo)
end

function SurvivalMapUnitView:_onUnitChange(id)
	local unitMo = SurvivalMapModel.instance:getSceneMo().unitsById[id]

	if not unitMo then
		return
	end

	if self._allUI[id] then
		local cls = self:getUnitCls(id, unitMo)

		if cls == self._allUI[id].class then
			self._allUI[id]:refreshInfo()
		else
			self:removeUnitUI(id)
			self:addUnitUI(id, unitMo)
		end
	end

	if unitMo.fall then
		self:_onShowUnitBubble(id, 1, -1)
	else
		self:_onHideUnitBubble(id)
	end
end

function SurvivalMapUnitView:removeUnitUI(id, isPlayAnim)
	if self._allUI[id] then
		if isPlayAnim then
			self._allUI[id]:playCloseAnim()
		else
			self._allUI[id]:dispose()
		end

		self._allUI[id] = nil
	end
end

function SurvivalMapUnitView:_onUnitIsShowChange(id)
	if id == 0 and self._allUI[id] then
		local entity = SurvivalMapHelper.instance:getEntity(id)

		if not entity then
			return
		end

		self._allUI[id]:setIconEnable(not entity.isShow)
	end
end

function SurvivalMapUnitView:_onFollowTaskUpdate()
	for id, ui in pairs(self._allUI) do
		ui:_onFollowTaskUpdate()
	end
end

function SurvivalMapUnitView:_onShowUnitBubble(unitId, type, time)
	local params = {
		type = type,
		time = time,
		callback = self._onHideUnitBubble,
		callobj = self,
		unitId = unitId
	}

	if self._allBubble[unitId] then
		self._allBubble[unitId]:updateParam(params)
	else
		local go = gohelper.cloneInPlace(self._gobubble)

		gohelper.setActive(go, true)

		self._allBubble[unitId] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalUnitBubbleItem, params)
	end

	if self._allUI[unitId] then
		gohelper.setActive(self._allUI[unitId].go, false)
	end
end

function SurvivalMapUnitView:_onHideUnitBubble(unitId)
	if self._allBubble[unitId] then
		self._allBubble[unitId]:tryDestroy()

		self._allBubble[unitId] = nil
	end

	if self._allUI[unitId] then
		gohelper.setActive(self._allUI[unitId].go, true)
	end
end

function SurvivalMapUnitView:initRoleSkillConfirmItem()
	if not self._roleSkillConfirmItem then
		local path = self.viewContainer._viewSetting.otherRes.roleSkillConfirmItem
		local go = self:getResInst(path, self._allLayers[99999], "roleskillconfirmitem")

		self._roleSkillConfirmItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalRoleSkillConfirmItem)
	end
end

function SurvivalMapUnitView:onDestroyView()
	return
end

return SurvivalMapUnitView
