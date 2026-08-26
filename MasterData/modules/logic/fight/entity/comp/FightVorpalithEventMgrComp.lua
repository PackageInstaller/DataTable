-- chunkname: @modules/logic/fight/entity/comp/FightVorpalithEventMgrComp.lua

module("modules.logic.fight.entity.comp.FightVorpalithEventMgrComp", package.seeall)

local FightVorpalithEventMgrComp = class("FightVorpalithEventMgrComp", FightBaseClass)

FightVorpalithEventMgrComp.Anchor = Vector2(556, 250)
FightVorpalithEventMgrComp.TweenTime = 2
FightVorpalithEventMgrComp.FloatEffectCDTime = 5
FightVorpalithEventMgrComp.EffectRes = "ui/viewres/fight/fightsurvivaleffectview.prefab"
FightVorpalithEventMgrComp.LoadStatus = {
	NotLoad = 0,
	Loaded = 2,
	Loading = 1
}

function FightVorpalithEventMgrComp:onConstructor(entity)
	self.entity = entity
	self.preShowEffectTime = -(FightVorpalithEventMgrComp.FloatEffectCDTime + 0.1)
	self.loadStatus = FightVorpalithEventMgrComp.LoadStatus.NotLoad

	self:com_registFightEvent(FightEvent.TriggerVorpalithSkill, self.onTriggerVorpalithSkill)
end

function FightVorpalithEventMgrComp:findClientEffect3(fightStepData)
	local effectList = fightStepData.actEffect

	if not effectList then
		return
	end

	local clientEffectType = FightEnum.EffectType.CLIENTEFFECT
	local fightStepEffectType = FightEnum.EffectType.FIGHTSTEP

	for _, effect in ipairs(effectList) do
		if effect.effectType == clientEffectType and effect.effectNum == FightWorkClientEffect339.ClientEffectEnum.TriggerVorpalithSkill then
			table.insert(self.tempActEffectList, fightStepData)
			table.insert(self.tempActEffectList, effect)
		elseif effect.effectType == fightStepEffectType then
			self:findClientEffect3(effect.fightStep)
		end
	end
end

function FightVorpalithEventMgrComp:onTriggerVorpalithSkill()
	if self.loadStatus == FightVorpalithEventMgrComp.LoadStatus.Loading then
		return
	end

	if self.loadStatus == FightVorpalithEventMgrComp.LoadStatus.Loaded then
		self:startFloat()

		return
	end

	self:startLoadRes()
end

function FightVorpalithEventMgrComp:startLoadRes()
	local viewContainer = ViewMgr.instance:getContainer(ViewName.FightView)
	local viewGo = viewContainer and viewContainer.viewGO
	local rootGo = viewGo and gohelper.findChild(viewGo, "root")

	if gohelper.isNil(rootGo) then
		return
	end

	self.loader = PrefabInstantiate.Create(rootGo)

	self.loader:startLoad(FightVorpalithEventMgrComp.EffectRes, self.onLoaded, self)

	self.loadStatus = FightVorpalithEventMgrComp.LoadStatus.Loading
end

function FightVorpalithEventMgrComp:onLoaded()
	self.loadStatus = FightVorpalithEventMgrComp.LoadStatus.Loaded

	self:initGo()
	self:startFloat()
end

function FightVorpalithEventMgrComp:initGo()
	self.instanceGo = self.loader:getInstGO()
	self.instanceRectTr = self.instanceGo:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(self.instanceRectTr, FightVorpalithEventMgrComp.Anchor.x, FightVorpalithEventMgrComp.Anchor.y)

	self.simageIcon = gohelper.findChildSingleImage(self.instanceGo, "#image_icon")

	gohelper.setActive(self.instanceGo, false)

	self.animator = self.instanceGo:GetComponent(gohelper.Type_Animator)
end

function FightVorpalithEventMgrComp:startFloat()
	local curTime = Time.realtimeSinceStartup

	if curTime - self.preShowEffectTime < self.FloatEffectCDTime then
		return
	end

	if FightDataHelper.fieldMgr.customData then
		local customData = FightDataHelper.fieldMgr.customData[FightCustomData.CustomDataType.Survival]
		local tagId = customData and customData.equipMaxTagId
		local tagCo = tagId and lua_survival_equip_found.configDict[tagId]
		local icon = tagCo and tagCo.icon2

		if string.nilorempty(icon) then
			logError(string.format("lua_survival_equip_found.icon2 is nil, customData : %s, tagId : %s", tostring(customData), tostring(tagId)))
		end

		self.simageIcon:LoadImage(string.format("singlebg/survival_singlebg/equip/icon/%s.png", icon))

		self.preShowEffectTime = curTime

		gohelper.setActive(self.instanceGo, true)
		self.animator:Play("open", 0, 0)
	end
end

function FightVorpalithEventMgrComp:onTweenDone()
	gohelper.setActive(self.instanceGo, false)

	self.tweenId = nil
end

function FightVorpalithEventMgrComp:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.ClearTween(self.tweenId)

		self.tweenId = nil
	end
end

function FightVorpalithEventMgrComp:clearStepWork()
	if self.stepWork then
		self.stepWork:onDestroy()

		self.stepWork = nil
	end
end

function FightVorpalithEventMgrComp:onDestructor()
	self:clearStepWork()

	if not gohelper.isNil(self.simageIcon) then
		self.simageIcon:UnLoadImage()

		self.simageIcon = nil
	end

	self.loadStatus = FightVorpalithEventMgrComp.LoadStatus.NotLoad

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

return FightVorpalithEventMgrComp
