-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesspets/view/GuessPetsWorldScoreEffPool.lua

module("logic.extensions.goddessglory.view.GuessPetsWorldScoreEffPool", package.seeall)

local GuessPetsWorldScoreEffPool = class("GuessPetsWorldScoreEffPool")

function GuessPetsWorldScoreEffPool:ctor(viewGO)
	self._viewGO = viewGO
	self._usingEffs = {}
	self._freeEffs = {}
end

function GuessPetsWorldScoreEffPool:playEffect(startNode, destNode)
	local eff

	if self._freeEffs and #self._freeEffs > 0 then
		eff = table.remove(self._freeEffs, 1)
	end

	eff = eff or GuessPetsWorldScoreEff.New(self._viewGO, self)

	eff:playEffect(startNode, destNode)

	self._usingEffs = self._usingEffs or {}

	table.insert(self._usingEffs, eff)
end

function GuessPetsWorldScoreEffPool:stopEffect(eff)
	self._freeEffs = self._freeEffs or {}

	table.insert(self._freeEffs, eff)
end

function GuessPetsWorldScoreEffPool:clear()
	if self._usingEffs then
		for i = 1, #self._usingEffs do
			self._usingEffs[i]:clear()
		end
	end

	if self._freeEffs then
		for i = 1, #self._freeEffs do
			self._freeEffs[i]:clear()
		end
	end

	self._usingEffs = nil
	self._freeEffs = nil
end

return GuessPetsWorldScoreEffPool
