-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonRewardToastView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonRewardToastView", package.seeall)

local AtomicDungeonRewardToastView = class("AtomicDungeonRewardToastView", AtomicDungeonToastBaseView)

function AtomicDungeonRewardToastView:onInitView()
	self._gorewardToastContent = gohelper.findChild(self.viewGO, "root/#go_rewardToastContent")
	self._gorewardToastItem = gohelper.findChild(self.viewGO, "root/#go_rewardToastContent/#go_rewardToastItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

local OutSidePos = -10000
local FightRewardShowDelay = 0.5

function AtomicDungeonRewardToastView:_editableInitView()
	AtomicDungeonRewardToastView.super._editableInitView(self)
	gohelper.setActive(self._gorewardToastItem, false)
	recthelper.setAnchor(self._gorewardToastItem.transform, OutSidePos, 0)
end

function AtomicDungeonRewardToastView:onOpen()
	self.maxTalentCoinNum = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.AtomicTalentMaxCoinNum, true)

	tabletool.addValues(self._cacheMsgList, AtomicDungeonModel.instance.showRewardToastList)
	tabletool.clear(AtomicDungeonModel.instance.showRewardToastList)
	self:addToastMsg()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.RecycleRewardToast, self._doRecycleAnimation, self)
	self.addEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnLoadSceneFinish, self.checkShowFightReward, self)
end

function AtomicDungeonRewardToastView:createToastItem()
	local go = gohelper.clone(self._gorewardToastItem, self._gorewardToastContent, "rewardToastItem")

	return (MonoHelper.addNoUpdateLuaComOnceToGo(go, AtomicRewardToastItem, {
		toastView = self
	}))
end

function AtomicDungeonRewardToastView:checkShowFightReward()
	self.fightResultData = AtomicDungeonModel.instance:getFightResultData()

	if self.fightResultData and #self.fightResultData.bonuseList > 0 then
		TaskDispatcher.runDelay(self.showFightRewardToast, self, FightRewardShowDelay)
	end
end

function AtomicDungeonRewardToastView:showFightRewardToast()
	local costTalentNum = AtomicModel.instance:getAllUnlockTalentCost()

	for _, materialDataMo in ipairs(self.fightResultData.bonuseList) do
		local curTalentNum = ItemModel.instance:getItemQuantity(materialDataMo.materilType, materialDataMo.materilId)

		if curTalentNum + costTalentNum < self.maxTalentCoinNum then
			self:addToastMsg(materialDataMo)
		end
	end
end

function AtomicDungeonRewardToastView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		local list = CommonPropListModel.instance._moList
		local costTalentNum = AtomicModel.instance:getAllUnlockTalentCost()

		for _, materialDataMo in ipairs(list) do
			local curTalentNum = ItemModel.instance:getItemQuantity(materialDataMo.materilType, materialDataMo.materilId)

			if curTalentNum + costTalentNum < self.maxTalentCoinNum then
				self:addToastMsg(materialDataMo)
			end
		end
	end
end

function AtomicDungeonRewardToastView:onClose()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.RecycleRewardToast, self._doRecycleAnimation, self)
	self.removeEventCb(self, AtomicDungeonController.instance, AtomicDungeonEvent.OnLoadSceneFinish, self.checkShowFightReward, self)
	TaskDispatcher.cancelTask(self._showToast, self)
	TaskDispatcher.cancelTask(self.showFightRewardToast, self)

	self.hadTask = false

	AtomicDungeonModel.instance:cleanFightResultData()
end

return AtomicDungeonRewardToastView
