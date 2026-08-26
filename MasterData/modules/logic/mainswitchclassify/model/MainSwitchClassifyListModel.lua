-- chunkname: @modules/logic/mainswitchclassify/model/MainSwitchClassifyListModel.lua

module("modules.logic.mainswitchclassify.model.MainSwitchClassifyListModel", package.seeall)

local MainSwitchClassifyListModel = class("MainSwitchClassifyListModel", ListScrollModel)

function MainSwitchClassifyListModel:initMoList()
	local moList = {}

	for _, info in ipairs(MainSwitchClassifyEnum.StyleClassifyInfo) do
		table.insert(moList, info)
	end

	table.sort(moList, function(a, b)
		return a.Sort < b.Sort
	end)
	self:setList(moList)
	self:selectCell(1, true)
end

MainSwitchClassifyListModel.instance = MainSwitchClassifyListModel.New()

return MainSwitchClassifyListModel
