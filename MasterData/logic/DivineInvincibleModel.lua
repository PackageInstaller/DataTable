-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/model/DivineInvincibleModel.lua

module("logic.extensions.divineinvincible.model.DivineInvincibleModel", package.seeall)

local DivineInvincibleModel = class("DivineInvincibleModel", BaseModel)

function DivineInvincibleModel:onInit()
	self:onReset()
end

function DivineInvincibleModel:onReset()
	self._moPool = self._moPool or {}

	for key, mo in pairs(self._moPool) do
		mo:dispose()

		self._moPool[key] = nil
	end

	self._extFmtMo = nil
	self._norFmtMo = nil
end

function DivineInvincibleModel:getClgMo(activityId)
	if self._moPool[activityId] == nil then
		self._moPool[activityId] = DivineInvincibleMo.New(activityId)
	end

	return self._moPool[activityId]
end

function DivineInvincibleModel:getExtremeFmtMo()
	if self._extFmtMo == nil then
		self._extFmtMo = DivineInvincibleExtremeFmtMo.New()
	end

	return self._extFmtMo
end

function DivineInvincibleModel:getNormalFmtMo()
	if self._norFmtMo == nil then
		self._norFmtMo = DivineInvincibleNormalFmtMo.New()
	end

	return self._norFmtMo
end

DivineInvincibleModel.instance = DivineInvincibleModel.New()

return DivineInvincibleModel
