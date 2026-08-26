-- chunkname: @modules/logic/bossrush/view/v3a9/fight/V3a9_BossRush_ExpandBondsExpandPanel.lua

module("modules.logic.bossrush.view.v3a9.fight.V3a9_BossRush_ExpandBondsExpandPanel", package.seeall)

local V3a9_BossRush_ExpandBondsExpandPanel = class("V3a9_BossRush_ExpandBondsExpandPanel", LuaCompBase)

function V3a9_BossRush_ExpandBondsExpandPanel:init(go)
	self.viewGO = go
	self._gohas = gohelper.findChild(self.viewGO, "has")
	self._goempty = gohelper.findChild(self.viewGO, "empty")
	self._gofold = gohelper.findChild(self.viewGO, "has/fold")
	self._gofoldgrid = gohelper.findChild(self.viewGO, "has/fold/grid")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "has/fold/grid/#btn_fold")
	self._goexpand = gohelper.findChild(self.viewGO, "has/expand")
	self._goexpandgrid = gohelper.findChild(self.viewGO, "has/expand/grid")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "has/expand/#btn_close")
	self._btnexpand = gohelper.findChildButtonWithAudio(self.viewGO, "has/expand/grid/#btn_expand")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_ExpandBondsExpandPanel:addEventListeners()
	self._btnfold:AddClickListener(self._btnfoldOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnexpand:AddClickListener(self._btnexpandOnClick, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refresh, self)
	self.addEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.OnModifyHeroGroup, self.refresh, self)
	self.addEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.onRefreshV3a9ModeTeamInfo, self.refresh, self)
end

function V3a9_BossRush_ExpandBondsExpandPanel:removeEventListeners()
	self._btnfold:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnexpand:RemoveClickListener()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, self.refresh, self)
	self.removeEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.OnModifyHeroGroup, self.refresh, self)
	self.removeEventCb(self, V3a9_BossRushController.instance, V3a9_BossRushEvent.onRefreshV3a9ModeTeamInfo, self.refresh, self)
end

function V3a9_BossRush_ExpandBondsExpandPanel:_btnfoldOnClick()
	self:_openFold(true)
end

function V3a9_BossRush_ExpandBondsExpandPanel:_btncloseOnClick()
	if not V3a9_BossRushController.instance:closeExpandBondsTipView() then
		self:_openFold(false)
	end
end

function V3a9_BossRush_ExpandBondsExpandPanel:_btnexpandOnClick()
	self:_openFold(false)
end

function V3a9_BossRush_ExpandBondsExpandPanel:_editableInitView()
	gohelper.setActive(self.viewGO, true)

	local param = {
		isShowMaxNum = true,
		isOpenTipView = true,
		isPlayAnim = true
	}

	self._bondGroupGrid = MonoHelper.addNoUpdateLuaComOnceToGo(self._gofoldgrid, V3a9_BossRush_ExpandBondsGrid, param)
	self._expandGroupGrid = MonoHelper.addNoUpdateLuaComOnceToGo(self._goexpandgrid, V3a9_BossRush_ExpandBondsGrid, param)
end

function V3a9_BossRush_ExpandBondsExpandPanel:setItemRes(itemRes, closeRoot)
	self._closeRoot = closeRoot

	self._bondGroupGrid:setItemRes(itemRes, closeRoot)
	self._expandGroupGrid:setItemRes(itemRes, closeRoot)
end

function V3a9_BossRush_ExpandBondsExpandPanel:onOpen()
	local stage, actId = V3a9_BossRushModel.instance:getEnterActStage()

	self._stage = stage
	self._isOpenFold = true

	self:_openFold(false)
end

function V3a9_BossRush_ExpandBondsExpandPanel:setParam(foldMaxShowCount, isShowEmpty)
	self._foldMaxShowCount = foldMaxShowCount
	self._isShowEmpty = isShowEmpty
end

function V3a9_BossRush_ExpandBondsExpandPanel:refresh()
	self:refreshExpandBonds()
end

function V3a9_BossRush_ExpandBondsExpandPanel:refreshExpandBonds()
	local hasExpandBonds = self:_hasExpandBonds()

	if hasExpandBonds then
		local count = self._bondGroupGrid:refreshExpandBonds(self._foldMaxShowCount)
		local isOver = not self._foldMaxShowCount or count > self._foldMaxShowCount

		gohelper.setActive(self._btnfold.gameObject, isOver)

		if isOver then
			self._expandGroupGrid:refreshExpandBonds()
		end
	end

	gohelper.setActive(self._gohas, hasExpandBonds)
	gohelper.setActive(self._goempty, not hasExpandBonds and self._isShowEmpty)
end

function V3a9_BossRush_ExpandBondsExpandPanel:_hasExpandBonds()
	return V3a9_BossRushExpandBondModel.instance:hasBossRushExpand()
end

function V3a9_BossRush_ExpandBondsExpandPanel:_openFold(isOpen)
	if self._isOpenFold == isOpen then
		return
	end

	self._isOpenFold = isOpen

	gohelper.setActive(self._goexpand, self._isOpenFold)
	gohelper.setActive(self._gofold, not self._isOpenFold)
	self:refreshExpandBonds()
end

function V3a9_BossRush_ExpandBondsExpandPanel:onDestroy()
	return
end

return V3a9_BossRush_ExpandBondsExpandPanel
