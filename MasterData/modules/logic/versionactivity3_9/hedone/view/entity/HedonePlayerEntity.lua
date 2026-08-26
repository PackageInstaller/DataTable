-- chunkname: @modules/logic/versionactivity3_9/hedone/view/entity/HedonePlayerEntity.lua

module("modules.logic.versionactivity3_9.hedone.view.entity.HedonePlayerEntity", package.seeall)

local HedonePlayerEntity = class("HedonePlayerEntity", HedoneBaseEntity)

function HedonePlayerEntity:_onInit()
	local spineNode = gohelper.findChild(self._go, "#go_spine")

	self._spine = GuiSpine.Create(spineNode)

	if self._spine then
		self._spine:setResPath(HedoneGameEnum.Const.PlayerSpineRes, self._onPlayerSpineLoaded, self)
	end

	self._animator = spineNode:GetComponent(gohelper.Type_Animator)

	self._animator:Play(HedoneGameEnum.EntityAnimName.PlayerAttack, 0, 1)

	self._goLvUpEff = gohelper.findChild(self._go, "ChatarterExpUpEff")

	gohelper.setActive(self._goLvUpEff, false)
	self:setUid(HedoneGameEnum.Const.PlayerUid)
end

function HedonePlayerEntity:playAnim(animName, cb, cbObj, cbParams)
	if animName == HedoneGameEnum.EntityAnimName.Hit then
		if self._hitAnim then
			self._hitAnim:Play()
		end
	else
		self._animator:Play(animName, 0, 0)
	end
end

function HedonePlayerEntity:_onPlayerSpineLoaded()
	local spineGO = self._spine:getSpineGo()

	if gohelper.isNil(spineGO) then
		return
	end

	self._hitAnim = spineGO:GetComponent(typeof(UnityEngine.Animation))
end

function HedonePlayerEntity:onLevelUp()
	gohelper.setActive(self._goLvUpEff, false)
	gohelper.setActive(self._goLvUpEff, true)
end

return HedonePlayerEntity
