-- chunkname: @modules/logic/settings/model/SettingsCategoryListModel.lua

module("modules.logic.settings.model.SettingsCategoryListModel", package.seeall)

local SettingsCategoryListModel = class("SettingsCategoryListModel", ListScrollModel)

function SettingsCategoryListModel:setCategoryList(infos)
	local moList = infos and infos or {}

	table.sort(moList, function(a, b)
		return a.id < b.id
	end)
	self:setList(moList)
end

SettingsCategoryListModel.instance = SettingsCategoryListModel.New()

return SettingsCategoryListModel
