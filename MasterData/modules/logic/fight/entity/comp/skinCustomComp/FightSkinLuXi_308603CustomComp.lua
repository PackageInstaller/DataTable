-- chunkname: @modules/logic/fight/entity/comp/skinCustomComp/FightSkinLuXi_308603CustomComp.lua

module("modules.logic.fight.entity.comp.skinCustomComp.FightSkinLuXi_308603CustomComp", package.seeall)

local FightSkinLuXi_308603CustomComp = class("FightSkinLuXi_308603CustomComp", FightSkinCustomCompBase)

function FightSkinLuXi_308603CustomComp:ctor(entity)
	self.entity = entity
	self.skinId = entity:getMO().skin
	self.entityId = entity.id
end

function FightSkinLuXi_308603CustomComp:init(go)
	self.go = go
	self.effectList = {}

	self.entity.spine:addAnimEventCallback(self.onAnimEvent, self)
	FightController.instance:registerCallback(FightEvent.OnStartFightPlayBornNormal, self.onStartFightPlayBornNormal, self)
	FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, self.onBeforeDeadEffect, self)
end

function FightSkinLuXi_308603CustomComp:removeEventListeners()
	self.entity.spine:removeAnimEventCallback(self.onAnimEvent, self)
	FightController.instance:unregisterCallback(FightEvent.OnStartFightPlayBornNormal, self.onStartFightPlayBornNormal, self)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, self.onBeforeDeadEffect, self)
end

function FightSkinLuXi_308603CustomComp:onStartFightPlayBornNormal(entityId)
	if entityId ~= self.entityId then
		return
	end

	TaskDispatcher.runDelay(self.addBornEffect, self, 0.01)
end

function FightSkinLuXi_308603CustomComp:addBornEffect()
	local co = lua_fight_luxi_skin_effect.configDict[self.skinId]

	if not co then
		return
	end

	self:removeAllEffect()
	self:addEffect(co[SpineAnimState.born])
end

function FightSkinLuXi_308603CustomComp:onBeforeDeadEffect(entityId)
	if entityId ~= self.entityId then
		return
	end

	local co = lua_fight_luxi_skin_effect.configDict[self.skinId]

	if not co then
		return
	end

	self:removeAllEffect()
	self:addEffect(co[SpineAnimState.die])
end

function FightSkinLuXi_308603CustomComp:onAnimEvent(actionName, eventName, eventArgs)
	if eventName == SpineAnimEvent.ActionComplete and actionName == SpineAnimState.born then
		self:removeAllEffect()
	end
end

function FightSkinLuXi_308603CustomComp:addEffect(co)
	if not co then
		return
	end

	local effectRes = co.effect
	local hangPoints = co.effectHangPoint

	if not string.nilorempty(effectRes) then
		local effectList = string.split(effectRes, "#")
		local hangPoint = string.split(hangPoints, "#")

		for i, path in ipairs(effectList) do
			local effectWrap = self.entity.effect:addHangEffect(path, hangPoint[i])

			effectWrap:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(self.entity.id, effectWrap)
			table.insert(self.effectList, effectWrap)
		end
	end

	local audioId = co.audio

	if audioId > 0 then
		local entityMO = self.entity:getMO()

		if not entityMO then
			return
		end

		local audioLang
		local heroId = self.entity:getMO().modelId

		if not heroId then
			return
		end

		local charVoiceLangId, langStr, usingDefaultLang = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
		local charVoiceLang = LangSettings.shortcutTab[charVoiceLangId]

		FightAudioMgr.instance:playAudioWithLang(audioId, (not string.nilorempty(charVoiceLang) and not usingDefaultLang or nil) and charVoiceLang)
	end
end

function FightSkinLuXi_308603CustomComp:removeAllEffect()
	for _, effectWrap in ipairs(self.effectList) do
		self.entity.effect:removeEffect(effectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(self.entity.id, effectWrap)
	end

	tabletool.clear(self.effectList)
end

function FightSkinLuXi_308603CustomComp:onDestroy()
	TaskDispatcher.cancelTask(self.addBornEffect, self)
	self:removeAllEffect()
end

return FightSkinLuXi_308603CustomComp
