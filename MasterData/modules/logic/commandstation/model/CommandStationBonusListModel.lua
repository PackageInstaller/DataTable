-- chunkname: @modules/logic/commandstation/model/CommandStationBonusListModel.lua

module("modules.logic.commandstation.model.CommandStationBonusListModel", package.seeall)

local CommandStationBonusListModel = class("CommandStationBonusListModel", MixScrollModel)

function CommandStationBonusListModel:ctor()
	CommandStationBonusListModel.super.ctor(self)

	self._itemCounts = {}
end

function CommandStationBonusListModel:setData(data, countList)
	self._itemCounts = countList

	self:setList(data)
end

function CommandStationBonusListModel:getInfoList(scrollGO)
	self._mixCellInfo = {}

	for i, count in ipairs(self._itemCounts) do
		local width = count * 100 + 70
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(1, width, nil)

		table.insert(self._mixCellInfo, mixCellInfo)
	end

	return self._mixCellInfo
end

CommandStationBonusListModel.instance = CommandStationBonusListModel.New()

return CommandStationBonusListModel
