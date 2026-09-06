-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemsetting/controller/RedPointSetController.lua

module("logic.extensions.systemsetting.controller.RedPointSetController", package.seeall)

local RedPointSetController = class("RedPointSetController", BaseController)

function RedPointSetController:ctor()
	return
end

function RedPointSetController:onInit()
	self:onReset()
end

function RedPointSetController:onReset()
	self._localKeyMap = {}
end

function RedPointSetController:isOnOfCommandIdList(commandIdList)
	for _, commandId in ipairs(commandIdList) do
		if self:getRedPointSetCommandValue(commandId) then
			return true
		end
	end

	return false
end

function RedPointSetController:getRedPointSetCommandValue(commandId)
	self._localKeyMap = self._localKeyMap or {}

	local key = self:getRedPointSetCommandKey(commandId)
	local flag = self._localKeyMap[key]

	if flag == nil then
		flag = GameUtil.getLocalString(key)
		self._localKeyMap[key] = flag
	end

	return flag == "true"
end

function RedPointSetController:setRedPointSetCommandValue(commandId, value)
	self._localKeyMap = self._localKeyMap or {}

	local key = self:getRedPointSetCommandKey(commandId)
	local flag = value and "true" or "false"

	self._localKeyMap[key] = flag

	GameUtil.setLocalString(key, flag)
end

function RedPointSetController:getRedPointSetCommandKey(commandId)
	return string.format("%s_RedPointSet_%s", NotificationConfig.SaveFlag, commandId)
end

function RedPointSetController:notifyRedPointSetCommandChange(commandId)
	GlobalDispatcher:dispatch(GlobalNotify.RedPointSetCommandChange, commandId)
end

function RedPointSetController:isOnOfMainuiArea(area)
	local isOn = true

	if not string.nilorempty(area) then
		local commandIdList = self:getCommandIdListOfMainuiArea(area)

		isOn = self:isOnOfCommandIdList(commandIdList)
	end

	return isOn
end

function RedPointSetController:getCommandIdListOfMainuiArea(area)
	local commandIdList = {}
	local dataList = RedPointSetConfig.instance:getRdsCommandDataListByHudParam(area)

	if dataList then
		for _, data in ipairs(dataList) do
			table.insert(commandIdList, data.commandId)
		end
	end

	return commandIdList
end

function RedPointSetController:isOnOfMainHudQuickEntry()
	local commandIdList = {}
	local commandType = RedPointSetEnum.CommandTypes_MainHudQuickEntry
	local dataList = RedPointSetConfig.instance:getRdsCommandDataListByType(commandType)

	if dataList then
		for _, data in ipairs(dataList) do
			table.insert(commandIdList, data.commandId)
		end
	end

	return self:isOnOfCommandIdList(commandIdList)
end

function RedPointSetController:isOnOfBagRed()
	local commandIdList = {}
	local commandType = RedPointSetEnum.CommandTypes_BagRed
	local dataList = RedPointSetConfig.instance:getRdsCommandDataListByType(commandType)

	if dataList then
		for _, data in ipairs(dataList) do
			table.insert(commandIdList, data.commandId)
		end
	end

	return self:isOnOfCommandIdList(commandIdList)
end

RedPointSetController.instance = RedPointSetController.New()

return RedPointSetController
