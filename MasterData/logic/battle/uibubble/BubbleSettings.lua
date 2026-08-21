-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uibubble/BubbleSettings.lua

module("logic.battle.uibubble.BubbleSettings", package.seeall)

local BubbleSettings = {}

BubbleSettings.BubbleRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.Bubble)

local kBubbleTypeSettings = {}

kBubbleTypeSettings[BattleEnum.BubbleType.CRIT_DAMAGE] = {
	class = BubbleNumber
}
kBubbleTypeSettings[BattleEnum.BubbleType.NORMAL_DAMAGE] = {
	class = BubbleNumber
}
kBubbleTypeSettings[BattleEnum.BubbleType.NORMAL_RECOVERY] = {
	class = BubbleNumber
}
kBubbleTypeSettings[BattleEnum.BubbleType.SKILL_TRIGGER_HINT] = {
	class = BubbleSkillTriggerHint
}
kBubbleTypeSettings[BattleEnum.BubbleType.BUFF_TRIGGER_HINT] = {
	class = BubbleBuffTriggerHint
}
kBubbleTypeSettings[BattleEnum.BubbleType.STATUS_HINT] = {
	class = BubbleStatusHint
}
kBubbleTypeSettings[BattleEnum.BubbleType.BUFF_ADD_HINT] = {
	class = BubbleBuffAddGroup,
	bubbleGroup = BuffBubbleGroup
}

function BubbleSettings.bubbleType2BubbleGroup(bubbleType)
	local settings = kBubbleTypeSettings[bubbleType]

	return settings.bubbleGroup or BubbleGroup
end

function BubbleSettings.bubbleType2BubbleClass(bubbleType)
	local settings = kBubbleTypeSettings[bubbleType]

	return settings.class
end

function BubbleSettings.bubbleType2NumberType(bubbleType)
	local settings = kBubbleTypeSettings[bubbleType]

	return settings.numberSize
end

function BubbleSettings.bubbleType2NumberColorString(bubbleType)
	local settings = kBubbleTypeSettings[bubbleType]

	return settings.colorString
end

return BubbleSettings
