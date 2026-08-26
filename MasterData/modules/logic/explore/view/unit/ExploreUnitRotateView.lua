-- chunkname: @modules/logic/explore/view/unit/ExploreUnitRotateView.lua

module("modules.logic.explore.view.unit.ExploreUnitRotateView", package.seeall)

local ExploreUnitRotateView = class("ExploreUnitRotateView", ExploreUnitBaseView)
local paramsFormat = ExploreEnum.TriggerEvent.Rotate .. "#%d"

function ExploreUnitRotateView:ctor(unit)
	ExploreUnitRotateView.super.ctor(self, unit, "ui/viewres/explore/exploreunitrotate.prefab")
end

function ExploreUnitRotateView:onInit()
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_right")
end

function ExploreUnitRotateView:addEventListeners()
	self._btnLeft:AddClickListener(self.doRotate, self, false)
	self._btnRight:AddClickListener(self.doRotate, self, true)
end

function ExploreUnitRotateView:removeEventListeners()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function ExploreUnitRotateView:doRotate(isReverse)
	local stepIndex = 0
	local rotateAngle = 0

	for k, v in pairs(self.unit.mo.triggerEffects) do
		if v[1] == ExploreEnum.TriggerEvent.Rotate then
			stepIndex = k
			rotateAngle = tonumber(v[2])

			if isReverse then
				rotateAngle = -rotateAngle
			end

			break
		end
	end

	if stepIndex <= 0 then
		return
	end

	ExploreRpc.instance:sendExploreInteractRequest(self.unit.id, stepIndex, string.format(paramsFormat, rotateAngle), self.onRotateRecv, self)
end

function ExploreUnitRotateView:onRotateRecv(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	if not self.unit then
		return
	end

	local nowUnitDir = self.unit.mo.unitDir
	local dir = string.splitToNumber(msg.params, "#")[2]

	self.unit:doRotate(nowUnitDir - dir, nowUnitDir)
end

function ExploreUnitRotateView:onDestroy()
	self._btnLeft = nil
	self._btnRight = nil
end

return ExploreUnitRotateView
