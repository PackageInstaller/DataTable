-- chunkname: @modules/logic/explore/view/unit/ExploreRoleFixView.lua

module("modules.logic.explore.view.unit.ExploreRoleFixView", package.seeall)

local ExploreRoleFixView = class("ExploreRoleFixView", ExploreUnitBaseView)

function ExploreRoleFixView:ctor(unit)
	ExploreRoleFixView.super.ctor(self, unit, "ui/viewres/explore/exploreinteractiveitem.prefab")
end

function ExploreRoleFixView:onInit()
	self._goslider = gohelper.findChildImage(self.viewGO, "#image_progress")
	self._nowValue = 0

	TaskDispatcher.runRepeat(self._everyFrame, self, 0)
end

function ExploreRoleFixView:setFixUnit(unit)
	self._fixUnit = unit
end

function ExploreRoleFixView:_everyFrame()
	self._nowValue = self._nowValue + UnityEngine.Time.deltaTime

	local value = self._nowValue / (ExploreAnimEnum.RoleAnimLen[ExploreAnimEnum.RoleAnimStatus.Fix] or 1)

	self._goslider.fillAmount = value

	if value > 1 then
		if self._fixUnit then
			local effName, isOnce, audioId, isBindGo = ExploreConfig.instance:getUnitEffectConfig(self._fixUnit:getResPath(), "fix_finish")

			ExploreHelper.triggerAudio(audioId, isBindGo, self._fixUnit.go)
		end

		self.unit.uiComp:removeUI(ExploreRoleFixView)
	end
end

function ExploreRoleFixView:addEventListeners()
	return
end

function ExploreRoleFixView:removeEventListeners()
	return
end

function ExploreRoleFixView:onDestroy()
	TaskDispatcher.cancelTask(self._everyFrame, self)

	self._goslider = nil
	self._fixUnit = nil
end

return ExploreRoleFixView
