-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ResultPanelItem.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ResultPanelItem", package.seeall)

local V1a4_BossRush_ResultPanelItem = class("V1a4_BossRush_ResultPanelItem", ListScrollCellExtend)

function V1a4_BossRush_ResultPanelItem:onInitView()
	self._txtScore = gohelper.findChildText(self.viewGO, "txt_Score")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a4_BossRush_ResultPanelItem:addEvents()
	return
end

function V1a4_BossRush_ResultPanelItem:removeEvents()
	return
end

function V1a4_BossRush_ResultPanelItem:_editableInitView()
	self._img = gohelper.findChildImage(self.viewGO, "")
end

function V1a4_BossRush_ResultPanelItem:onUpdateMO(mo)
	self._mo = mo

	self:_refresh()
end

function V1a4_BossRush_ResultPanelItem:onSelect(isSelect)
	return
end

function V1a4_BossRush_ResultPanelItem:_refresh()
	local mo = self._mo
	local isGray = mo.isGray
	local stageRewardCO = mo.stageRewardCO
	local rewardPointNum = stageRewardCO.rewardPointNum

	if isGray then
		if not BossRushEnum.Color.GRAY then
			local color = BossRushEnum.Color.WHITE

			self:setDesc(BossRushConfig.instance:getScoreStr(rewardPointNum))
			self:setImgColor(color)
		end
	end
end

function V1a4_BossRush_ResultPanelItem:setDesc(desc)
	self._txtScore.text = desc
end

function V1a4_BossRush_ResultPanelItem:setActive(isActive)
	gohelper.setActive(self._go, isActive)
end

function V1a4_BossRush_ResultPanelItem:setImgColor(hexColor)
	UIColorHelper.set(self._img, hexColor)
end

function V1a4_BossRush_ResultPanelItem:onDestroyView()
	return
end

return V1a4_BossRush_ResultPanelItem
