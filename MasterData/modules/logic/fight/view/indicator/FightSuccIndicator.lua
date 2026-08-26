-- chunkname: @modules/logic/fight/view/indicator/FightSuccIndicator.lua

module("modules.logic.fight.view.indicator.FightSuccIndicator", package.seeall)

local FightSuccIndicator = class("FightSuccIndicator", FightIndicatorBaseView)
local prefabPath = "ui/viewres/versionactivity_1_2/versionactivity_1_2_successitem.prefab"

function FightSuccIndicator:initView(indicatorMgrView, indicatorId, totalIndicatorNum)
	FightSuccIndicator.super.initView(self, indicatorMgrView, indicatorId, totalIndicatorNum)

	self.goSuccContainer = gohelper.findChild(self.goIndicatorRoot, "success_indicator")
end

function FightSuccIndicator:startLoadPrefab()
	gohelper.setActive(self.goSuccContainer, true)

	self.loader = PrefabInstantiate.Create(self.goSuccContainer)

	self.loader:startLoad(prefabPath, self.onLoadCallback, self)
end

function FightSuccIndicator:onLoadCallback()
	self.loadDone = true
	self.instanceGo = self.loader:getInstGO()
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.instanceGo)
	self.txtIndicatorProcess = gohelper.findChildText(self.instanceGo, "txt_itemProcess")

	local num = FightDataHelper.fieldMgr:getIndicatorNum(self.indicatorId)

	self.txtIndicatorProcess.text = string.format("%d/%d", num, self.totalIndicatorNum)
end

function FightSuccIndicator:onIndicatorChange()
	if not self.loadDone then
		return
	end

	self:updateUI()
end

function FightSuccIndicator:updateUI()
	if not self.loadDone then
		return
	end

	local num = FightDataHelper.fieldMgr:getIndicatorNum(self.indicatorId)

	self.txtIndicatorProcess.text = string.format("%d/%d", num, self.totalIndicatorNum)

	FightModel.instance:setWaitIndicatorAnimation(true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_triumph_dreamepilogue_collect)
	self.animatorPlayer:Play("add", self.onAddAnimationDone, self)
end

function FightSuccIndicator:onAddAnimationDone()
	local num = FightDataHelper.fieldMgr:getIndicatorNum(self.indicatorId)

	if num == self.totalIndicatorNum then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_triumph_dreamepilogue_achieve)
		self.animatorPlayer:Play("finish", self.onFinishAnimationDone, self)
	else
		FightController.instance:dispatchEvent(FightEvent.OnIndicatorAnimationDone)
	end
end

function FightSuccIndicator:onFinishAnimationDone()
	FightController.instance:dispatchEvent(FightEvent.OnIndicatorAnimationDone)
end

function FightSuccIndicator:onDestroy()
	if self.loader then
		self.loader:dispose()
	end

	FightSuccIndicator.super.onDestroy(self)
end

return FightSuccIndicator
