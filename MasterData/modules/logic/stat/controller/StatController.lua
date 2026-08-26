-- chunkname: @modules/logic/stat/controller/StatController.lua

module("modules.logic.stat.controller.StatController", package.seeall)

local StatController = class("StatController", BaseController)

function StatController:onInit()
	return
end

function StatController:reInit()
	return
end

function StatController:sendBaseProperties()
	local basePropertiesStr = ""

	basePropertiesStr = SDKDataTrackMgr.instance:getDataTrackProperties()

	if string.nilorempty(basePropertiesStr) then
		basePropertiesStr = cjson.encode(StatEnum.DefaultBaseProperties)
	end

	logNormal(basePropertiesStr)
	StatModel.instance:updateBaseProperties(basePropertiesStr)
	StatRpc.instance:sendClientStatBaseInfoRequest(basePropertiesStr)
end

function StatController:onLogin()
	self:sendBaseProperties()

	local userId = PlayerModel.instance:getMyUserId()

	SDKDataTrackMgr.instance:roleLogin(tostring(userId))

	local playerinfo = PlayerModel.instance:getPlayinfo()

	if not string.nilorempty(playerinfo.name) then
		SDKMgr.instance:enterGame(StatModel.instance:generateRoleInfo())
	end
end

function StatController:setUserProperties(properties)
	SDKDataTrackMgr.instance:profileSet(properties)
end

function StatController:track(eventName, properties)
	properties = properties or {}

	local eventCommonProperties = StatModel.instance:getEventCommonProperties()

	for k, v in pairs(eventCommonProperties) do
		properties[k] = v
	end

	local emptyPropertyNames = {}

	for propertyName, param in pairs(properties) do
		local definedType = StatEnum.PropertyTypes[propertyName]

		if not string.nilorempty(definedType) and type(param) ~= SDKDataTrackMgr.DefinedTypeToLuaType[definedType] then
			logError(string.format("埋点 属性类型不一致, propertyName: %s, param: %s, currentType: %s, definedType: %s", tostring(propertyName), tostring(param), type(param), SDKDataTrackMgr.DefinedTypeToLuaType[definedType]))
		end

		if definedType == "array" or definedType == "list" then
			JsonUtil.markAsArray(param)
		end

		if definedType == "array" and #param <= 0 then
			table.insert(emptyPropertyNames, propertyName)
		end
	end

	for i, emptyPropertyName in ipairs(emptyPropertyNames) do
		properties[emptyPropertyName] = nil
	end

	SDKDataTrackMgr.instance:track(eventName, properties)
end

function StatController:onInitFinish()
	return
end

StatController.instance = StatController.New()

return StatController
