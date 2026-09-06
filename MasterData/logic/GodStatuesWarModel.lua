-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/model/GodStatuesWarModel.lua

module("logic.extensions.godstatueswar.model.GodStatuesWarModel", package.seeall)

local GodStatuesWarModel = class("GodStatuesWarModel", BaseModel)

function GodStatuesWarModel:ctor()
	return
end

function GodStatuesWarModel:onInit()
	self:onReset()
end

function GodStatuesWarModel:onReset()
	self._gswMoPool = self._gswMoPool or {}

	table.clear(self._gswMoPool)

	self._advanceCustomFmtMo = nil
	self._fightPillarCustomFmtMo = nil
	self._fightNestCustomFmtMo = nil
end

function GodStatuesWarModel:getGswMo(seasonId)
	if self._gswMoPool[seasonId] == nil then
		self._gswMoPool[seasonId] = GodStatuesWarMo.New(seasonId)
	end

	return self._gswMoPool[seasonId]
end

function GodStatuesWarModel:getGswAdvanceCustomFmtMo()
	if self._advanceCustomFmtMo == nil then
		self._advanceCustomFmtMo = GodStatuesWarAdvanceCustomFmtMo.New()
	end

	return self._advanceCustomFmtMo
end

function GodStatuesWarModel:getGswFightPillarCustomFmtMo()
	if self._fightPillarCustomFmtMo == nil then
		self._fightPillarCustomFmtMo = GodStatuesWarFightPillarCustomFmtMo.New()
	end

	return self._fightPillarCustomFmtMo
end

function GodStatuesWarModel:getGswFightNestCustomFmtMo()
	if self._fightNestCustomFmtMo == nil then
		self._fightNestCustomFmtMo = GodStatuesWarFightNestCustomFmtMo.New()
	end

	return self._fightNestCustomFmtMo
end

GodStatuesWarModel.instance = GodStatuesWarModel.New()

return GodStatuesWarModel
