-- chunkname: @modules/logic/tipdialog/config/TipDialogConfig.lua

module("modules.logic.tipdialog.config.TipDialogConfig", package.seeall)

local TipDialogConfig = class("TipDialogConfig", BaseConfig)

function TipDialogConfig:reqConfigNames()
	return {
		"tip_dialog"
	}
end

function TipDialogConfig:onInit()
	return
end

function TipDialogConfig:onConfigLoaded(configName, configTable)
	if configName == "tip_dialog" then
		self:_initDialog()
	end
end

function TipDialogConfig:_initDialog()
	self._dialogList = {}

	local sectionId
	local defaultId = "0"

	for i, v in ipairs(lua_tip_dialog.configList) do
		local group = self._dialogList[v.id]

		if not group then
			group = {}
			sectionId = defaultId
			self._dialogList[v.id] = group
		end

		group[sectionId] = group[sectionId] or {}

		table.insert(group[sectionId], v)
	end
end

function TipDialogConfig:getDialog(groupId, sectionId)
	local group = self._dialogList[groupId]

	return group and group[sectionId]
end

TipDialogConfig.instance = TipDialogConfig.New()

return TipDialogConfig
