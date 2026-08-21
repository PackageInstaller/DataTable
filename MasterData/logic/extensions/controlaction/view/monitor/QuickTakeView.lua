-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/monitor/QuickTakeView.lua

module("logic.extensions.controlaction.view.monitor.QuickTakeView", package.seeall)

local M = class("QuickTakeView", EquipExploreMultiplicityFightTipsView)

function M:ctor()
	M.super.ctor(self)
end

function M:onEnter()
	local info = self:getFirstParam()

	self._viewId = info.viewId
	self._difficultIndex = info.difficultIndex
	self._rewardCodeConst = info.rewardCodeConst
	self._rewardCodeInfo = info.rewardCodeInfo
	self._rewardCodeZone = info.rewardCodeZone

	self:setDungeonId(info.dungeonMo:getId())

	self._dungeonMo = info.dungeonMo
	self._gamePlay = info.gamePlay

	if not self._dungeonMo then
		printError(string.format("无法从DungeonModel找到dungeonId[%s]的数据", info.dungeonMo:getId()))
		self:close()

		return
	end

	self:_init(info.maxMultiCount, info.canProxy)
end

function M:_initRewardView()
	local allRewardList = {}
	local normalList1 = ControlActionModel.instance:getRewardLstNormal(self._rewardCodeConst)
	local randomList1 = ControlActionModel.instance:getRewardLstRandom(self._rewardCodeConst)

	self:_mergeList(allRewardList, normalList1)
	self:_mergeList(allRewardList, randomList1)

	local normalList2 = ControlActionModel.instance:getRewardLstNormal(self._rewardCodeInfo)
	local randomList2 = ControlActionModel.instance:getRewardLstRandom(self._rewardCodeInfo)

	self:_mergeList(allRewardList, normalList2)
	self:_mergeList(allRewardList, randomList2)

	local normalList3 = ControlActionModel.instance:getRewardLstNormal(self._rewardCodeZone)
	local randomList3 = ControlActionModel.instance:getRewardLstRandom(self._rewardCodeZone)

	self:_mergeList(allRewardList, normalList3)
	self:_mergeList(allRewardList, randomList3)

	self._rewardList = allRewardList

	table.sort(self._rewardList, ItemUtil.commonSortFunc)

	local len = self._rewardList and #self._rewardList or 0

	self._canScroll = len > 7

	if len > 0 then
		self._scroll.enabled = self._canScroll

		self._loopList:SetListItemCount(len, true)
		self._loopList:RefreshAllShownItem()

		local layoutEnabled = not self._canScroll

		self._gridLayoutContent.enabled = false
		self._gridLayoutContent.enabled = layoutEnabled

		if layoutEnabled then
			local width = RectTransformUtils.GetWidth(self._rectTrScroll)

			RectTransformUtils.SetWidth(self._rectTrContent, width)
		end
	else
		self._loopList:ClearCells()
	end
end

function M:_onClickFight()
	if self:isItemEnough() then
		local info = {}

		info.dungeonId = self:getDungeonId()
		info.multiCount = self:getCurDoubleCount()
		info.quickFight = self:getQuickFightOn()
		info.gamePlay = self:getProxyOn() and self._gamePlay or BattleEnum.GamePlayType.NORMAL

		GlobalDispatcher:dispatchEvent(EventType.ON_MULTI_FIGHT_TIPS_CONFIRM, info)
		ControlActionModel.instance:setBattleInfo(self._viewId, self._difficultIndex)
		self:close()
	else
		ToolTipsMgr.showHealthExchangeTips()
	end
end

return M
