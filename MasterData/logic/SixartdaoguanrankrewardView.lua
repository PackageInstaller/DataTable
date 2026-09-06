-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sixartdaoguan/view/SixartdaoguanrankrewardView.lua

module("logic.extensions.sixartdaoguan.view.SixartdaoguanrankrewardView", package.seeall)

local SixartdaoguanrankrewardView = class("SixartdaoguanrankrewardView", ViewComponent)

function SixartdaoguanrankrewardView:ctor()
	SixartdaoguanrankrewardView.super.ctor(self)
end

function SixartdaoguanrankrewardView:unbindEvents()
	SixartdaoguanrankrewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SixartdaoguanrankrewardView:bindEvents()
	SixartdaoguanrankrewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function SixartdaoguanrankrewardView:buildUI()
	SixartdaoguanrankrewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._rankScrollercellGo = self:getGo("rankCol/rankScrollercell")
	self._itemScrollercellGo = self:getGo("rankCol/itemScrollercell")
	self._rankScrollerviewGo = self:getGo("rankCol/rankScrollerview")
	self._scrollerList = ScrollerList.create(self._rankScrollerviewGo, self._rankScrollercellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SixartdaoguanrankrewardView:onExit()
	SixartdaoguanrankrewardView.super.onExit(self)
	self._scrollerList:dispose()
end

function SixartdaoguanrankrewardView:onEnter()
	SixartdaoguanrankrewardView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	self:_updateUI()
end

function SixartdaoguanrankrewardView:_onClickbtnClose()
	self:close()
end

function SixartdaoguanrankrewardView:_updateUI()
	local cfgs = SixartdaoguanConfig.instance:getRankPrizeCfgsWithSort(self._activityId)

	self._scrollerList:reloadData(cfgs)
end

function SixartdaoguanrankrewardView:_updateCell(view, cell, cfg, tag)
	local goTableview = goutil.findChild(cell.gameObject, "itemScrollerview")
	local txtRank = goutil.findChildTextComponent(cell.gameObject, "txtRankRange")
	local rewardScroll = self:_getRewardScrollList(goTableview, self._itemScrollercellGo)
	local list = string.split(cfg.prize, "#")

	txtRank.text = cfg.rankRange[1] == cfg.rankRange[2] and string.format("第%s名", cfg.rankRange[1]) or string.format("第%s~%s名", cfg.rankRange[1], cfg.rankRange[2])

	rewardScroll:dragNotifyParent()
	rewardScroll:reloadData(list)
end

function SixartdaoguanrankrewardView:_clearCell(cell)
	local tableview = goutil.findChild(cell.gameObject, "tableview")

	self:_disposeRewardScrollList(tableview)
end

function SixartdaoguanrankrewardView:_getRewardScrollList(tableview, tablecell)
	self._rewardSrolls = self._rewardSrolls or {}

	if not self._rewardSrolls[tableview] then
		local scroller

		self._rewardSrolls[tableview] = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	end

	return self._rewardSrolls[tableview]
end

function SixartdaoguanrankrewardView:_disposeRewardScrollList(tableview)
	if self._rewardSrolls[tableview] then
		self._rewardSrolls[tableview]:dispose()

		self._rewardSrolls[tableview] = nil
	end
end

function SixartdaoguanrankrewardView:_updateRewardCell(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function SixartdaoguanrankrewardView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

return SixartdaoguanrankrewardView
