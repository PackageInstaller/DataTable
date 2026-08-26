-- chunkname: @modules/logic/summon/view/limitationreplicationselfselect/SummonLimitationReplicationSelfSelectPoolView.lua

module("modules.logic.summon.view.limitationreplicationselfselect.SummonLimitationReplicationSelfSelectPoolView", package.seeall)

local SummonLimitationReplicationSelfSelectPoolView = class("SummonLimitationReplicationSelfSelectPoolView", BaseView)

function SummonLimitationReplicationSelfSelectPoolView:onInitView()
	self._gosummon = gohelper.findChild(self.viewGO, "#go_summon")
	self._goright = gohelper.findChild(self.viewGO, "#go_right")
	self._goheroitem = gohelper.findChild(self.viewGO, "#go_right/scroll_hero/Viewport/Content/#go_heroitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonLimitationReplicationSelfSelectPoolView:addEvents()
	self.addEventCb(self, SummonController.instance, SummonEvent.onLimitationReplicationSelectHero, self.onClickHeroTab, self)
end

function SummonLimitationReplicationSelfSelectPoolView:removeEvents()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onLimitationReplicationSelectHero, self.onClickHeroTab, self)
end

function SummonLimitationReplicationSelfSelectPoolView:_editableInitView()
	self._tabItemList = {}
	self._tempTabId = nil
	self._tabView = SummonLimitationReplicationSelfSelectTabViewGroup.New(4, "#go_summon")
	self._tabView.viewGO = self.viewGO
	self._tabView.viewContainer = self.viewContainer
	self._tabView.viewName = self.viewName

	self._tabView:onInitView()

	self.rightAnimator = gohelper.findChildComponent(self.viewGO, "#go_right", gohelper.Type_Animator)
end

function SummonLimitationReplicationSelfSelectPoolView:onUpdateParam()
	return
end

function SummonLimitationReplicationSelfSelectPoolView:onOpen()
	self._tabView:onOpen()
	self.rightAnimator:Play("in", 0, 0)

	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolId = curPool.id

	self.poolId = poolId
	self.poolConfig = SummonConfig.instance:getSummonPool(poolId)

	self:refreshUI()
end

function SummonLimitationReplicationSelfSelectPoolView:refreshUI()
	self:refreshPoolTab()
	self:refreshSelectHero()
end

function SummonLimitationReplicationSelfSelectPoolView:refreshSelectHero()
	local summonPoolMo = SummonMainModel.instance:getPoolServerMO(self.poolId)
	local customPickMO = summonPoolMo.customPickMO
	local selectHeroId = customPickMO.pickHeroIds[1]

	if selectHeroId == nil then
		selectHeroId = self._tabItemList[1].heroId
	end

	self:_switchTab(selectHeroId, true)
end

function SummonLimitationReplicationSelfSelectPoolView:refreshPoolTab()
	local config = self.poolConfig

	if string.nilorempty(config.param2) then
		logError("限定复刻卡池 没有up角色数据" .. tostring(config.id))
	end

	local paramList = string.splitToNumber(config.param2, "#")

	tabletool.clear(self._tabItemList)
	gohelper.CreateObjList(self, self.onTabItemShow, paramList, nil, self._goheroitem, SummonLimitationReplicationSelfSelectItem)
end

function SummonLimitationReplicationSelfSelectPoolView.sortHero(a, b)
	return b < a
end

function SummonLimitationReplicationSelfSelectPoolView:onTabItemShow(item, heroId, index)
	table.insert(self._tabItemList, item)
	item:setInfo(heroId)
end

function SummonLimitationReplicationSelfSelectPoolView:onClickHeroTab(heroId)
	self:_switchTab(heroId)
end

SummonLimitationReplicationSelfSelectPoolView.ForceEndDelay = 5

function SummonLimitationReplicationSelfSelectPoolView:_switchTab(heroId, isOpen)
	if self._selectTabId ~= heroId and self._tempTabId == nil then
		self._tempTabId = heroId

		if not isOpen then
			UIBlockMgr.instance:startBlock(self._UIBlockKey)
			TaskDispatcher.cancelTask(self.forceEndBlock, self)
			TaskDispatcher.runDelay(self.forceEndBlock, self, SummonLimitationReplicationSelfSelectPoolView.ForceEndDelay)

			local heroIdList = {
				heroId
			}

			SummonMainController.instance:setLimitReplicatePoolSelect(self.poolId, heroIdList, self.onSetHeroSelect, self)
		else
			self:onSetHeroSelect()
		end
	end
end

function SummonLimitationReplicationSelfSelectPoolView:forceEndBlock()
	logError("限定卡池 锁屏超时")
	UIBlockMgr.instance:endBlock(self._UIBlockKey)
end

function SummonLimitationReplicationSelfSelectPoolView:onSetHeroSelect()
	TaskDispatcher.cancelTask(self.forceEndBlock, self)
	UIBlockMgr.instance:endBlock(self._UIBlockKey)

	local tabId = self._selectTabId
	local curView = self._tabView._tabViews[tabId]

	if curView and curView.switchClose then
		curView:switchClose(self._onSwitchCloseAnimDone, self)
		TaskDispatcher.runDelay(self._onSwitchCloseAnimDone, self, 0.5)
	else
		self:_onSwitchCloseAnimDone()
	end
end

function SummonLimitationReplicationSelfSelectPoolView:_onSwitchCloseAnimDone()
	TaskDispatcher.cancelTask(self._onSwitchCloseAnimDone, self)
	self:_refreshTabs(self._tempTabId)
	self:refreshRightPage()

	self._selectTabId = self._tempTabId
	self._tempTabId = nil
end

function SummonLimitationReplicationSelfSelectPoolView:refreshRightPage()
	local tabId = self._tempTabId
	local config = SummonConfig.instance:getSummonLimitReplicateConfig(tabId)

	if self._tabView then
		local curTabId = self._tabView:getCurTabId()
		local curView = self._tabView._tabViews[curTabId]

		if curView then
			curView:stopAnimator()
		end
	end

	self.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 4, config.id)
end

function SummonLimitationReplicationSelfSelectPoolView:_refreshTabs(curHeroId)
	for _, item in ipairs(self._tabItemList) do
		item:setSelect(self._tempTabId)
	end
end

function SummonLimitationReplicationSelfSelectPoolView:onClose()
	self.rightAnimator:Play("out", 0, 0)

	local tabId = self._tabView:getCurTabId()
	local curView = self._tabView._tabViews[tabId]

	if curView then
		curView:stopAnimator()
	end

	self._tabView:onClose()

	self._selectTabId = nil
end

function SummonLimitationReplicationSelfSelectPoolView:onDestroyView()
	self._tabView:removeEvents()
	self._tabView:onDestroyView()
	TaskDispatcher.cancelTask(self._onSwitchCloseAnimDone, self)
	TaskDispatcher.cancelTask(self.forceEndBlock, self)
end

return SummonLimitationReplicationSelfSelectPoolView
