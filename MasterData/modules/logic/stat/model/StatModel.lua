-- chunkname: @modules/logic/stat/model/StatModel.lua

module("modules.logic.stat.model.StatModel", package.seeall)

local StatModel = class("StatModel", BaseModel)

function StatModel:onInit()
	self._basePropertiesStr = nil
	self._tempEventCommonProperties = nil
end

function StatModel:setRoleType(v)
	self._roleType = v
end

function StatModel:getRoleType()
	return self._roleType
end

function StatModel:reInit()
	self._basePropertiesStr = nil
	self._tempEventCommonProperties = nil
end

function StatModel:updateBaseProperties(basePropertiesStr)
	self._basePropertiesStr = basePropertiesStr
end

function StatModel:getEventCommonProperties()
	local playerinfo = PlayerModel.instance:getPlayinfo()

	if not self._tempEventCommonProperties then
		self._tempEventCommonProperties = {}
		self._tempEventCommonProperties[StatEnum.EventCommonProperties.ServerName] = LoginModel.instance.serverName
		self._tempEventCommonProperties[StatEnum.EventCommonProperties.RoleId] = tostring(playerinfo.userId)
		self._tempEventCommonProperties[StatEnum.EventCommonProperties.RoleEstablishTime] = TimeUtil.timestampToString(ServerTime.timeInLocal(playerinfo.registerTime / 1000))
		self._tempEventCommonProperties[StatEnum.EventCommonProperties.RoleType] = "正常"
	end

	local eventCommonProperties = {}
	local diamond = CurrencyModel.instance:getDiamond()
	local freeDiamond = CurrencyModel.instance:getFreeDiamond()
	local lastEpisodeConfig = DungeonConfig.instance:getEpisodeCO(playerinfo.lastEpisodeId)

	eventCommonProperties[StatEnum.EventCommonProperties.RoleName] = playerinfo.name
	eventCommonProperties[StatEnum.EventCommonProperties.GiveCurrencyNum] = freeDiamond
	eventCommonProperties[StatEnum.EventCommonProperties.PaidCurrencyNum] = diamond
	eventCommonProperties[StatEnum.EventCommonProperties.CurrencyNum] = diamond + freeDiamond
	eventCommonProperties[StatEnum.EventCommonProperties.RoleLevel] = playerinfo.level
	eventCommonProperties[StatEnum.EventCommonProperties.CurrentProgress] = lastEpisodeConfig and tostring(lastEpisodeConfig.name .. lastEpisodeConfig.id) or ""

	for k, v in pairs(self._tempEventCommonProperties) do
		eventCommonProperties[k] = v
	end

	if not LoginModel.instance:isDoneLogin() then
		self._tempEventCommonProperties = nil
	end

	return eventCommonProperties
end

function StatModel:generateRoleInfo()
	local roleInfo = PayModel.instance:getGameRoleInfo()
	local jsonRoleInfo = cjson.encode(roleInfo)

	logNormal(jsonRoleInfo)

	return jsonRoleInfo
end

function StatModel:getPayInfo()
	local payInfo = PayModel.instance:getGamePayInfo()
	local jsonPayInfo = cjson.encode(payInfo)

	logNormal("Pay Info " .. jsonPayInfo)

	return jsonPayInfo
end

StatModel.instance = StatModel.New()

return StatModel
