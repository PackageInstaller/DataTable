-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GswCompletePillarInfoCtrl.lua

module("logic.extensions.godstatueswar.data.GswCompletePillarInfoCtrl", package.seeall)

local GswCompletePillarInfoCtrl = class("GswCompletePillarInfoCtrl")

function GswCompletePillarInfoCtrl:ctor()
	self._pillarInfoMoPool = {}
end

function GswCompletePillarInfoCtrl:onReset()
	table.clear(self._pillarInfoMoPool)
end

function GswCompletePillarInfoCtrl:updateData(msg)
	local familyId = msg.familyId
	local pillarInfoMo = self._pillarInfoMoPool[familyId]

	if pillarInfoMo == nil then
		self._pillarInfoMoPool[familyId] = GswCompletePillarInfoMo.New()
		pillarInfoMo = self._pillarInfoMoPool[familyId]
	end

	pillarInfoMo:initData(msg)
end

function GswCompletePillarInfoCtrl:getPillarInfoMo(familyId)
	return self._pillarInfoMoPool[familyId]
end

return GswCompletePillarInfoCtrl
