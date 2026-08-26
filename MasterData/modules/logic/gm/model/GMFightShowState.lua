-- chunkname: @modules/logic/gm/model/GMFightShowState.lua

module("modules.logic.gm.model.GMFightShowState", package.seeall)

local GMFightShowState = _M

GMFightShowState.clothSkill = true
GMFightShowState.Desc_clothSkill = "维尔汀的技能"
GMFightShowState.topRightPause = true
GMFightShowState.Desc_topRightPause = "暂停退出按钮"
GMFightShowState.topRightRound = true
GMFightShowState.Desc_topRightRound = "轮次回合计数"
GMFightShowState.monsterSelect = true
GMFightShowState.Desc_monsterSelect = "技能集火图标"
GMFightShowState.handCardRestrain = true
GMFightShowState.Desc_handCardRestrain = "手牌克制标签"
GMFightShowState.bottomEnemyRound = true
GMFightShowState.Desc_bottomEnemyRound = "敌方回合提示"
GMFightShowState.topLeftTotal = true
GMFightShowState.Desc_topLeftTotal = "总的伤害计算"
GMFightShowState.bossHp = true
GMFightShowState.Desc_bossHp = "Boss血条"
GMFightShowState.leftMonster = true
GMFightShowState.Desc_leftMonster = "怪物剩余数量"
GMFightShowState.cards = true
GMFightShowState.Desc_cards = "手牌区出牌区"
GMFightShowState.enemyOp = true
GMFightShowState.Desc_enemyOp = "敌方头顶卡牌"
GMFightShowState.screenTouchEffect = true
GMFightShowState.Desc_screenTouchEffect = "屏幕触摸特效"
GMFightShowState.roundSpecialView = true
GMFightShowState.Desc_roundSpecialView = "入场战斗弹窗"
GMFightShowState.playSkillDes = true
GMFightShowState.Desc_playSkillDes = "技能卡描述"
GMFightShowState._descList = {
	{
		valueKey = "clothSkill"
	},
	{
		valueKey = "topRightPause"
	},
	{
		valueKey = "topRightRound"
	},
	{
		valueKey = "monsterSelect"
	},
	{
		valueKey = "handCardRestrain"
	},
	{
		valueKey = "bottomEnemyRound"
	},
	{
		valueKey = "topLeftTotal"
	},
	{
		valueKey = "bossHp"
	},
	{
		valueKey = "leftMonster"
	},
	{
		valueKey = "cards"
	},
	{
		valueKey = "enemyOp"
	},
	{
		valueKey = "screenTouchEffect"
	},
	{
		valueKey = "roundSpecialView"
	},
	{
		valueKey = "playSkillDes"
	}
}

function GMFightShowState.getList()
	for i, one in ipairs(GMFightShowState._descList) do
		if not one.id then
			one.id = i
			one.desc = GMFightShowState["Desc_" .. one.valueKey]
		end
	end

	return GMFightShowState._descList
end

function GMFightShowState.getStatus(valueKey)
	return GMFightShowState[valueKey]
end

function GMFightShowState.setStatus(valueKey, value)
	GMFightShowState[valueKey] = value
end

return GMFightShowState
