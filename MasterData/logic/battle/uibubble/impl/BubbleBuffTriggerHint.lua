-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/impl/BubbleBuffTriggerHint.lua

module("logic.battle.uibubble.impl.BubbleBuffTriggerHint", package.seeall)

local BubbleBuffTriggerHint = class("BubbleBuffTriggerHint", BubbleBase)

function BubbleBuffTriggerHint:_getBubbleResourcePath()
	return BattleResourceName.UIBubbleSkillTriggerHint
end

function BubbleBuffTriggerHint:buildUI()
	self._animation = goutil.findChildComponent(self.mainGO, "Skill", ComponentType.Animation)
	self._imgSkillIcon = goutil.findChildImageComponent(self.mainGO, "Skill/imgSkill")
	self._txtSkillName = goutil.findChildTextComponent(self.mainGO, "Skill/txtHeartAnchorName")
end

function BubbleBuffTriggerHint:destroyUI()
	self._animation = nil
	self._imgSkillIcon = nil
	self._txtSkillName = nil
end

function BubbleBuffTriggerHint:resetUI()
	return
end

function BubbleBuffTriggerHint:getHeight()
	return 50
end

function BubbleBuffTriggerHint:getPriority()
	return 10
end

function BubbleBuffTriggerHint:setBubbleContent(buffCode)
	local buffCO = BuffConfig.instance:getBuffCO(buffCode)

	self._txtSkillName.text = buffCO.name

	IconLoader.setSprite(self._imgSkillIcon, IconType.BuffIcon, buffCO.buffIcon)
	AnimationUtils.SetPlaySpeed(self._animation, BattleTime.timeScale)
end

return BubbleBuffTriggerHint
