-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/operator/BattleHeroInfoDetailComp.lua

module("logic.extensions.battle.viewmain.operator.BattleHeroInfoDetailComp", package.seeall)

local M = class("BattleHeroInfoDetailComp", BattleHeroInfoDetailCompBase)

function M:buildUI(gameObject)
	self.super.buildUI(self, gameObject)

	self._txtBloodOfNormal = goutil.findChildTextComponent(self.mainGO, "progress/txtBlood_unit")
	self._txtBloodOfWeak = goutil.findChildTextComponent(self.mainGO, "progress/txtBlood_boss")
	self._btnClickType2 = Astral.ButtonAdapter.GetFrom(self.mainGO, "clickReturn")
end

function M:setTipsHolder(holder)
	self._tipsHolder = holder
end

function M:bindEvents()
	self.super.bindEvents(self)
	self._btnClickType2:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self.super.unbindEvents(self)
	self._btnClickType2:RemoveClickListener()
end

function M:_updateViewInfoOfType2()
	self.super._updateViewInfoOfType2(self)
end

function M:_updateHp(curHp, maxHp, showWeakPoint)
	self:_setActive(self._txtBloodOfNormal.gameObject, not showWeakPoint)
	self:_setActive(self._txtBloodOfWeak.gameObject, showWeakPoint)

	if showWeakPoint then
		self._txtBloodOfWeak.text = string.format("%d/<size=22>%d</size>", curHp, maxHp)
	else
		self._txtBloodOfNormal.text = string.format("%d/<size=22>%d</size>", curHp, maxHp)
	end
end

function M:setVisible(visible)
	local preVisible = self._visible

	self.super.setVisible(self, visible)

	if preVisible ~= self._visible or self._buffClosed and self._visible then
		self:_onBuffTipsUpdate(self._visible)
	end
end

function M:_onBuffTipsUpdate(status)
	if status then
		self:_showBuffTips()
	else
		self._buffClosed = true

		ViewMgr.instance:close(ViewName.ToolTipsBattleBuffViewPresentor)
	end
end

function M:closeTips()
	self:_onBuffTipsUpdate(false)
end

function M:_showBuffTips()
	if not self._unit then
		return
	end

	if BattleExternalDataModel.instance:isPreShowSkillTips() then
		return
	end

	local buffComp = self._unit.buff

	if #buffComp:getAllBuff() > 0 then
		local forceAlign = UnityEngine.TextAnchor.LowerLeft
		local forceTipsAlignVer = CommEnum.TipsAlignType.Up

		self._buffClosed = false

		ToolTipsMgr.showBattleBuffTips(self._unit, self._tipsHolder, forceAlign, forceTipsAlignVer, true)
	end
end

function M:_onSkillTipsCloseOrOpen(_, isEnter, viewName)
	if isEnter then
		BattleExternalDataModel.instance:setPreShowSkillTips(false)

		self._buffClosed = true

		ViewMgr.instance:close(ViewName.ToolTipsBattleBuffViewPresentor)
	elseif self._visible then
		self:_showBuffTips()
	end

	self.super._onSkillTipsCloseOrOpen(self, _, isEnter, viewName)
end

function M:_onClickBuffIcon()
	return
end

return M
