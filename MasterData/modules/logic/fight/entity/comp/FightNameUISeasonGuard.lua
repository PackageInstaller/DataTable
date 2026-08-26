-- chunkname: @modules/logic/fight/entity/comp/FightNameUISeasonGuard.lua

module("modules.logic.fight.entity.comp.FightNameUISeasonGuard", package.seeall)

local FightNameUISeasonGuard = class("FightNameUISeasonGuard", UserDataDispose)

function FightNameUISeasonGuard:ctor(parentView)
	self:__onInit()

	self._parentView = parentView
	self._entity = self._parentView.entity
end

function FightNameUISeasonGuard:init(viewGO)
	self.viewGO = viewGO

	gohelper.setActive(viewGO, true)

	self._shieldText = gohelper.findChildText(viewGO, "#txt_Shield")
	self._aniPlayer = SLFramework.AnimatorPlayer.Get(viewGO)
	self._ani = gohelper.onceAddComponent(viewGO, typeof(UnityEngine.Animator))

	self:_refreshUI()
	FightController.instance:registerCallback(FightEvent.EntityGuardChange, self._onEntityGuardChange, self)

	self._btnGuardTran = gohelper.findChild(viewGO, "btn_guard").transform
	self._btnGuard = gohelper.findChildClick(self.viewGO, "btn_guard")

	self.addClickCb(self, self._btnGuard, self._onBtnGuardClick, self)
	FightController.instance:registerCallback(FightEvent.StageChanged, self._onStageChanged, self)
end

function FightNameUISeasonGuard:_onBtnGuardClick()
	if not FightDataHelper.stageMgr:isFree() then
		return
	end

	local hud = ViewMgr.instance:getUILayer(UILayerName.Hud)
	local rectPos1X, rectPos1Y = recthelper.rectToRelativeAnchorPos2(self._btnGuardTran.position, hud.transform)

	FightController.instance:dispatchEvent(FightEvent.ShowSeasonGuardIntro, self._entity.id, rectPos1X, rectPos1Y)
end

function FightNameUISeasonGuard:_onEntityGuardChange(entityId, offset, final)
	if entityId == self._entity.id then
		self:_refreshUI()

		if offset == -1 then
			self:_playAni("shake1")
		elseif offset < -1 then
			self:_playAni("shake2")
		else
			self:_refreshAni()
		end
	end
end

function FightNameUISeasonGuard:_refreshAni()
	if not self.viewGO then
		return
	end

	local entityMO = self._entity:getMO()

	if not entityMO then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	if entityMO.guard == 1 then
		if self._curAniName == "idle3" then
			self:_playAni("idle3_out")
		else
			self:_playIdle("idle2")
		end
	elseif entityMO.guard > 1 then
		if self._curAniName == "idle3" then
			self:_playAni("idle3_out")
		else
			self:_playIdle("idle")
		end
	elseif self._curAniName ~= "idle3" and self._curAniName ~= "idle3_in" then
		self:_playAni("idle3_in")
	else
		self:_playIdle("idle3")
	end
end

function FightNameUISeasonGuard:_playIdle(name)
	self._curAniName = name
	self._ani.enabled = true

	self._ani:Play(name)
end

function FightNameUISeasonGuard:_playAni(name)
	self._curAniName = name

	self._aniPlayer:Play(name, self._refreshAni, self)
end

function FightNameUISeasonGuard:_refreshUI()
	local entityMO = self._entity:getMO()

	self._shieldText.text = entityMO.guard
end

function FightNameUISeasonGuard:_onStageChanged()
	self:_refreshAni()
end

function FightNameUISeasonGuard:releaseSelf()
	FightController.instance:unregisterCallback(FightEvent.EntityGuardChange, self._onEntityGuardChange, self)
	FightController.instance:unregisterCallback(FightEvent.StageChanged, self._onStageChanged, self)
	self:__onDispose()
end

return FightNameUISeasonGuard
