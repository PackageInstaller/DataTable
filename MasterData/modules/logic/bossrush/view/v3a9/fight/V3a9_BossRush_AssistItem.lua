-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_AssistItem.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_AssistItem", package.seeall)

local V3a9_BossRush_AssistItem = class("V3a9_BossRush_AssistItem", PickAssistItem)

function V3a9_BossRush_AssistItem:_checkClick()
	if not V3a9_BossRushModel.instance:isCanAssist(self._mo) then
		return false
	end

	return true
end

function V3a9_BossRush_AssistItem:_editableInitView()
	V3a9_BossRush_AssistItem.super._editableInitView(self)

	self._gobonds = gohelper.findChild(self.viewGO, "bonds")
	self._bondsItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gobonds, V3a9_BossRush_HeroExpandBondsItem)
end

function V3a9_BossRush_AssistItem:onUpdateMO(mo)
	V3a9_BossRush_AssistItem.super.onUpdateMO(self, mo)

	local heroMO = mo.heroMO

	self._bondsItem:onUpdateMO(heroMO.heroId)

	local isCanAssist = V3a9_BossRushModel.instance:isCanAssist(mo)

	self._heroItem:setRestrict(not isCanAssist)
	self._heroItem:setDamage(not isCanAssist)
end

return V3a9_BossRush_AssistItem
