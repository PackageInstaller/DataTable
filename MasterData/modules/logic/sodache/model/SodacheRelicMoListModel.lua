-- chunkname: @modules/logic/sodache/model/SodacheRelicMoListModel.lua

module("modules.logic.sodache.model.SodacheRelicMoListModel", package.seeall)

local SodacheRelicMoListModel = class("SodacheRelicMoListModel", ListScrollModel)

function SodacheRelicMoListModel:setData(quality)
	local relicMoList = {}
	local outsideMo = SodacheModel.instance:getOutsideMo()
	local relics = outsideMo.relicBox.relics

	for _, mo in pairs(relics) do
		if quality == 0 then
			relicMoList[#relicMoList + 1] = mo
		elseif mo.itemCo.quality == quality then
			relicMoList[#relicMoList + 1] = mo
		end
	end

	self:setList(relicMoList)
end

SodacheRelicMoListModel.instance = SodacheRelicMoListModel.New()

return SodacheRelicMoListModel
