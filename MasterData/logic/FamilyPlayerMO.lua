-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyscene/model/FamilyPlayerMO.lua

module("logic.extensions.familyscene.model.FamilyPlayerMO", package.seeall)

local FamilyPlayerMO = class("FamilyPlayerMO")

function FamilyPlayerMO:ctor()
	self.userVar = UserVar.New()
end

function FamilyPlayerMO:initData(data)
	self.user = data
	self.id = data.id
	self.name = data.name
	self.sex = 0
	self.vip = 0
	self.x = data.pos.x
	self.y = data.pos.y
	self.z = data.pos.z
	self.underBridge = data.pos.y ~= 0

	self:updateVariables(data.variabls)
end

function FamilyPlayerMO:updateVariables(userVariabls)
	self.userVar:updateData(userVariabls)
end

function FamilyPlayerMO:getDisplayVar(userVarKey)
	return self.userVar:getDisplayVar(userVarKey)
end

function FamilyPlayerMO:getOriginVar(userVarKey)
	return self.userVar:getOriginVar(userVarKey)
end

return FamilyPlayerMO
