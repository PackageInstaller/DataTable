-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGloryHitdot.lua

module("logic.extensions.recastglory.view.RecastGloryHitdot", package.seeall)

local RecastGloryHitdot = class("RecastGloryHitdot", RecastGloryGameBase)

function RecastGloryHitdot:onEnter()
	RecastGloryHitdot.super.onEnter(self)

	self._hitTotalCount = 0
	self._curHitCount = 0
end

function RecastGloryHitdot:_setHitTotalCount(count)
	self._hitTotalCount = count
end

function RecastGloryHitdot:_addHitCount()
	if self._curHitCount >= self._hitTotalCount then
		return
	end

	self._curHitCount = self._curHitCount + 1
end

function RecastGloryHitdot:_getCurHitCount()
	return self._curHitCount
end

return RecastGloryHitdot
