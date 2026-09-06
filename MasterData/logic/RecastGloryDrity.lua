-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGloryDrity.lua

module("logic.extensions.recastglory.view.RecastGloryDrity", package.seeall)

local RecastGloryDrity = class("RecastGloryDrity", RecastGloryGameBase)
local unityTime = UnityEngine.Time

function RecastGloryDrity:onEnter()
	RecastGloryDrity.super.onEnter(self)

	self._washingTime = 0
	self._disapperTime = 1
	self._dirtyImage = self._gameGo:GetComponent("Image")

	Game.ImageUtil.SetImageAlpha(self._dirtyImage, 1)
end

function RecastGloryDrity:onExit()
	RecastGloryDrity.super.onExit(self)

	self._washingTime = 0
end

function RecastGloryDrity:_startWashing()
	if self:isDisapear() then
		return
	end

	self:_washTimeCal()
end

function RecastGloryDrity:_washTimeCal()
	local deltaTime = unityTime.deltaTime

	self._washingTime = self._washingTime + deltaTime

	local alpha = 1 - 1 / self._disapperTime * self._washingTime

	Game.ImageUtil.SetImageAlpha(self._dirtyImage, alpha)
end

function RecastGloryDrity:_stopWashing()
	if self:isDisapear() then
		return
	end
end

function RecastGloryDrity:isDisapear()
	if self._washingTime >= self._disapperTime then
		return true
	end

	return false
end

return RecastGloryDrity
