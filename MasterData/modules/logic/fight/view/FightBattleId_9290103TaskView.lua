-- chunkname: @modules/logic/fight/view/FightBattleId_9290103TaskView.lua

module("modules.logic.fight.view.FightBattleId_9290103TaskView", package.seeall)

local FightBattleId_9290103TaskView = class("FightBattleId_9290103TaskView", FightBaseView)

function FightBattleId_9290103TaskView:onInitView()
	self._descText = gohelper.findChildText(self.viewGO, "#txt_dec")

	local goTitle = gohelper.findChild(self.viewGO, "#txt_title")
	local goStar = gohelper.findChild(self.viewGO, "#image_star")

	gohelper.setActive(goTitle, false)
	gohelper.setActive(goStar, false)
end

function FightBattleId_9290103TaskView:addEvents()
	self:com_registFightEvent(FightEvent.OnBuffUpdate, self._onBuffUpdate)
end

function FightBattleId_9290103TaskView:removeEvents()
	return
end

function FightBattleId_9290103TaskView:onConstructor()
	return
end

function FightBattleId_9290103TaskView:onOpen()
	self:_refreshData()
end

local SpecialBuffId = 6295031

function FightBattleId_9290103TaskView:_onBuffUpdate(entityId, effectType, buffId)
	if buffId ~= SpecialBuffId then
		return
	end

	self:_refreshData()
end

FightBattleId_9290103TaskView.TempEnemyList = {}

function FightBattleId_9290103TaskView:_refreshData()
	local enemyList = FightBattleId_9290103TaskView.TempEnemyList

	tabletool.clear(enemyList)

	enemyList = FightDataHelper.entityMgr:getEnemyNormalList(enemyList)

	local count = 0

	for _, entityMo in ipairs(enemyList) do
		local buffDict = entityMo:getBuffDic()

		for _, buffMo in pairs(buffDict) do
			if buffMo.buffId == SpecialBuffId then
				count = count + buffMo.layer
			end
		end
	end

	self._descText.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("battle_id_9290103_task_text"), count)
end

function FightBattleId_9290103TaskView:onClose()
	return
end

function FightBattleId_9290103TaskView:onDestroyView()
	return
end

return FightBattleId_9290103TaskView
