-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_StrategyItem.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_StrategyItem", package.seeall)

local V3a2_BossRush_StrategyItem = class("V3a2_BossRush_StrategyItem", ListScrollCellExtend)

function V3a2_BossRush_StrategyItem:onInitView()
	self._txtstrategy = gohelper.findChildText(self.viewGO, "#txt_strategy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_StrategyItem:addEvents()
	return
end

function V3a2_BossRush_StrategyItem:removeEvents()
	return
end

function V3a2_BossRush_StrategyItem:_editableInitView()
	return
end

function V3a2_BossRush_StrategyItem:onUpdateParam()
	return
end

function V3a2_BossRush_StrategyItem:onOpen()
	return
end

function V3a2_BossRush_StrategyItem:refreshUI(mo)
	local config = BossRushConfig.instance:getTagCo(mo)

	self._txtstrategy.text = config.name
end

function V3a2_BossRush_StrategyItem:onClose()
	return
end

function V3a2_BossRush_StrategyItem:onDestroyView()
	return
end

return V3a2_BossRush_StrategyItem
