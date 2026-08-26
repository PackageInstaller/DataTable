-- chunkname: @modules/logic/partygame/view/pedalingplaid/PedalingPlaidPlayerBuffComp.lua

module("modules.logic.partygame.view.pedalingplaid.PedalingPlaidPlayerBuffComp", package.seeall)

local PedalingPlaidPlayerBuffComp = class("PedalingPlaidPlayerBuffComp", LuaCompBase)

function PedalingPlaidPlayerBuffComp:ctor(playerMo)
	self._playerMo = playerMo
end

function PedalingPlaidPlayerBuffComp:init(go)
	self._goslider = go
	self._slider = gohelper.findChildImage(go, "slider")

	gohelper.setActive(self._goslider, false)

	self._uiFollower = gohelper.onceAddComponent(go, typeof(ZProj.UIFollower))

	self._uiFollower:SetEnable(true)

	local trans = PartyGame.Runtime.GameLogic.GameInterfaceBase.GetPlayerTransform(self._playerMo.uid)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower:Set(mainCamera, uiCamera, plane, trans, 0, 2.2, 0, 50, 0)
end

function PedalingPlaidPlayerBuffComp:onUpdate()
	if not self._playerMo then
		return
	end

	local value = PartyGameCSDefine.PedalingPlaidGameInterfaceCs.GetEffectProgress(self._playerMo.uid)

	ZProj.TweenHelper.KillByObj(self._slider)

	if value > 0 then
		if self._goslider.activeSelf then
			ZProj.TweenHelper.DOFillAmount(self._slider, value, 0.2)
		else
			gohelper.setActive(self._goslider, true)

			self._slider.fillAmount = value
		end
	else
		gohelper.setActive(self._goslider, false)
	end
end

return PedalingPlaidPlayerBuffComp
