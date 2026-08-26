-- chunkname: @modules/logic/sp01/odyssey/model/OdysseyEquipSuitTabListModel.lua

module("modules.logic.sp01.odyssey.model.OdysseyEquipSuitTabListModel", package.seeall)

local OdysseyEquipSuitTabListModel = class("OdysseyEquipSuitTabListModel", ListScrollModel)

function OdysseyEquipSuitTabListModel:onInit()
	self:reInit()
end

function OdysseyEquipSuitTabListModel:reInit()
	return
end

function OdysseyEquipSuitTabListModel:initList()
	local allConfigList = OdysseyConfig.instance:getEquipSuitConfigList()
	local tempMoList = {}
	local allMo = OdysseyEquipSuitMo.New()

	allMo:init(nil, nil, OdysseyEnum.EquipSuitType.All)
	table.insert(tempMoList, allMo)

	for _, config in ipairs(allConfigList) do
		if OdysseyItemModel.instance:haveSuitItem(config.id) then
			local mo = OdysseyEquipSuitMo.New()

			mo:init(config.id, config, OdysseyEnum.EquipSuitType.SingleType)
			table.insert(tempMoList, mo)
		end
	end

	self:setList(tempMoList)
end

function OdysseyEquipSuitTabListModel:clearSelect()
	local mo = self:getSelect()
	local view = self._scrollViews[1]

	if mo then
		view:selectCell(mo.id, false)
	end
end

function OdysseyEquipSuitTabListModel:getSelect()
	local view = self._scrollViews[1]

	if view then
		return (view:getFirstSelect())
	end
end

function OdysseyEquipSuitTabListModel:selectAllTag(dispatchEvent)
	self:clearSelect()

	local view = self._scrollViews[1]

	if view then
		view:selectCell(1, true)

		if dispatchEvent then
			local allMo = self:getByIndex(1)

			OdysseyController.instance:dispatchEvent(OdysseyEvent.OnEquipSuitSelect, allMo)
		end
	end
end

OdysseyEquipSuitTabListModel.instance = OdysseyEquipSuitTabListModel.New()

return OdysseyEquipSuitTabListModel
