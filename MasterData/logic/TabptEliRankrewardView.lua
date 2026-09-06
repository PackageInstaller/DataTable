-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/rewarddesc/TabptEliRankrewardView.lua

module("logic.extensions.peaktournament.view.common.rewarddesc.TabptEliRankrewardView", package.seeall)

local TabptEliRankrewardView = class("TabptEliRankrewardView", ViewComponent)

function TabptEliRankrewardView:ctor()
	TabptEliRankrewardView.super.ctor(self)
end

function TabptEliRankrewardView:unbindEvents()
	TabptEliRankrewardView.super.unbindEvents(self)
end

function TabptEliRankrewardView:bindEvents()
	TabptEliRankrewardView.super.bindEvents(self)
end

function TabptEliRankrewardView:buildUI()
	TabptEliRankrewardView.super.buildUI(self)

	self._rewardView = self:getGo("rewardView")
	self._rewardCell = self:getGo("rewardCell")
	self._itemCell = self:getGo("itemCell")
	self._scrollRect = self._rewardView:GetComponent("ScrollRect")
	self._ScrollList = ScrollerList.create(self._rewardView, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function TabptEliRankrewardView:onExit()
	TabptEliRankrewardView.super.onExit(self)
	self._ScrollList:dispose()
end

function TabptEliRankrewardView:onEnter()
	TabptEliRankrewardView.super.onEnter(self)

	self._cellPool = {}

	GameUtil.SetActive(self._rewardCell, false)

	self._activityId = PeakTournamentController.instance:getCurActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")
		self:close()

		return
	end

	local params = self:getOpenParam()
	local isSpaceRank = checknumber(params[2]) == 1
	local actCfg = PeakTournamentConfig.instance:getPtBaseData(self._activityId)
	local ptEliRoundCfg = PeakTournamentConfig.instance:getPtEliRankPrizeCfg(actCfg.eliRankPrizePlanId)

	if isSpaceRank == true and checknumber(actCfg.spaceRankPrizePlanId) > 0 then
		ptEliRoundCfg = PeakTournamentConfig.instance:getPtEliRankPrizeCfg(actCfg.spaceRankPrizePlanId)
	end

	if #ptEliRoundCfg > 0 then
		self._ScrollList:reloadData(ptEliRoundCfg)
	end
end

function TabptEliRankrewardView:_updateRewardCell(view, cell, data)
	local cellGo = self:_clearRewardCell(cell)

	cellGo.txtRank.text = data.txtTitle

	local rewardCfg = string.split(data.prize, "#")

	cellGo.itemScrollerview:reloadData(rewardCfg)
	cellGo.dragExclusive:AddDragListener(self._onDrag, self)
	cellGo.dragExclusive:AddBeginDragListener(self._onBeginDrag, self)
	cellGo.dragExclusive:AddEndDragListener(self._onEndDrag, self)
end

function TabptEliRankrewardView:_clearRewardCell(cell)
	local cellGo = self._cellPool[cell]

	if cellGo == nil then
		cellGo = {
			go = cell,
			txtRank = goutil.findChildTextComponent(cell, "txtRank"),
			itemTableview = goutil.findChild(cell, "itemScrollerview")
		}
		cellGo.itemScrollerview = ScrollerList.create(cellGo.itemTableview, self._itemCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		cellGo.dragExclusive = Framework.UIDragTrigger.Get(cellGo.itemTableview)
		self._cellPool[cell] = cellGo
	end

	cellGo.itemScrollerview:dispose()
	cellGo.dragExclusive:RemoveDragListener()
	cellGo.dragExclusive:RemoveBeginDragListener()
	cellGo.dragExclusive:RemoveEndDragListener()

	return cellGo
end

function TabptEliRankrewardView:_updateItemCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function TabptEliRankrewardView:_clearItemCell(cell)
	MaterialMgr.resetAll(cell)
end

function TabptEliRankrewardView:_onDrag(eventData)
	self._scrollRect:OnDrag(eventData)
end

function TabptEliRankrewardView:_onBeginDrag(eventData)
	self._scrollRect:OnBeginDrag(eventData)
end

function TabptEliRankrewardView:_onEndDrag(eventData)
	self._scrollRect:OnEndDrag(eventData)
end

return TabptEliRankrewardView
