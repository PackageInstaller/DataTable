-- chunkname: @modules/logic/settings/model/SettingsKeyTopListModel.lua

module("modules.logic.settings.model.SettingsKeyTopListModel", package.seeall)

local SettingsKeyTopListModel = class("SettingsKeyTopListModel", ListScrollModel)
local listmodel = {
	{
		id = PCInputModel.Activity.MainActivity
	},
	{
		id = PCInputModel.Activity.thrityDoor
	},
	{
		id = PCInputModel.Activity.battle
	},
	{
		id = PCInputModel.Activity.room
	}
}

function SettingsKeyTopListModel:InitList()
	local list = {}
	local blockKey = pcInputConfig.instance:getKeyBlock()

	for _, v in ipairs(listmodel) do
		local config = blockKey[v.id]

		if config then
			table.insert(list, {
				id = v.id,
				name = config.name
			})
		end
	end

	self:setList(list)
end

SettingsKeyTopListModel.instance = SettingsKeyTopListModel.New()

return SettingsKeyTopListModel
