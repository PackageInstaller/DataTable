-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/city/model/CityPlayerMO.lua

module("logic.extensions.city.model.CityPlayerMO", package.seeall)

local CityPlayerMO = class("CityPlayerMO")

function CityPlayerMO:ctor()
	self.userVar = UserVar.New()
end

function CityPlayerMO:initData(data)
	self.user = data
	self.id = data.userId
	self.name = data.userName
	self.sex = 0
	self.vip = 0
	self.x = data.pos.x
	self.y = data.pos.z
	self.underBridge = data.pos.y ~= 0

	self:updateVariables(data.userVariabls)
end

function CityPlayerMO:updateVariables(userVariabls)
	self.userVar:updateData(userVariabls)
end

function CityPlayerMO:getDisplayVar(userVarKey)
	return self.userVar:getDisplayVar(userVarKey)
end

function CityPlayerMO:getOriginVar(userVarKey)
	return self.userVar:getOriginVar(userVarKey)
end

return CityPlayerMO
