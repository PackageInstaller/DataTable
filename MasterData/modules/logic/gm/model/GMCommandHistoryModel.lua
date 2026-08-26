-- chunkname: @modules/logic/gm/model/GMCommandHistoryModel.lua

module("modules.logic.gm.model.GMCommandHistoryModel", package.seeall)

local GMCommandHistoryModel = class("GMCommandHistoryModel")
local delimiter = "|@|"
local maxNum = 30

function GMCommandHistoryModel:_initCommandList()
	if self._commandList then
		return
	end

	local str = PlayerPrefsHelper.getString(PlayerPrefsKey.GMToolViewHistory, "")
	local list = string.split(str, delimiter)

	self._commandList = list or {}
end

function GMCommandHistoryModel:getCommandHistory()
	self:_initCommandList()

	return self._commandList
end

function GMCommandHistoryModel:addCommandHistory(command)
	self:_initCommandList()
	tabletool.removeValue(self._commandList, command)
	table.insert(self._commandList, 1, command)
	self:_saveCommandList()
end

function GMCommandHistoryModel:removeCommandHistory(command)
	self:_initCommandList()
	tabletool.removeValue(self._commandList, command)
	self:_saveCommandList()
end

function GMCommandHistoryModel:_saveCommandList()
	while #self._commandList > maxNum do
		table.remove(self._commandList, #self._commandList)
	end

	local str = table.concat(self._commandList, delimiter)

	PlayerPrefsHelper.setString(PlayerPrefsKey.GMToolViewHistory, str)
end

GMCommandHistoryModel.instance = GMCommandHistoryModel.New()

return GMCommandHistoryModel
