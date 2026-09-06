-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/privilege/model/PrivilegeModel.lua

module("logic.extensions.privilege.model.PrivilegeModel", package.seeall)

local PrivilegeModel = class("PrivilegeModel", BaseModel)

function PrivilegeModel:ctor()
	return
end

function PrivilegeModel:onInit()
	self:onReset()
end

function PrivilegeModel:onReset()
	self._restDay = 0
	self._plusDay = 0
	self._isSupper = false
	self._hasPayGifts = {}
end

PrivilegeModel.instance = PrivilegeModel.New()

return PrivilegeModel
