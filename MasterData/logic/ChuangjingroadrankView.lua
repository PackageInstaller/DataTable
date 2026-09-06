-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadrankView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadrankView", package.seeall)

local ChuangjingroadrankView = class("ChuangjingroadrankView", ViewComponent)

function ChuangjingroadrankView:unbindEvents()
	ChuangjingroadrankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ChuangjingroadrankView:bindEvents()
	ChuangjingroadrankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ChuangjingroadrankView:buildUI()
	ChuangjingroadrankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._rankScrollRect = self:getGo("right/rankScrollRect")
	self._cell = self:getGo("right/cell")
	self._goEmpty = self:getGo("right/goEmpty")
	self._itemScrollercell = self:getGo("right/itemScrollercell")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self.scrollerGo = self:getGo("tabList")
	self.cellGo = self:getGo("tabCell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._scrollList:regGetCellSize(function()
		return 100, 70
	end)

	self._rankScrollList = ScrollerList.create(self._rankScrollRect, self._cell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
end

function ChuangjingroadrankView:onExit()
	ChuangjingroadrankView.super.onExit(self)
	self._scrollList:dispose()
	self._rankScrollList:dispose()

	for k, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end
end

function ChuangjingroadrankView:onEnter()
	ChuangjingroadrankView.super.onEnter(self)

	self._activityId = 396001
	self._zoneId = 1

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])
	local zoneId = checknumber(params[2])

	if actId > 0 then
		self._activityId = actId
	end

	if zoneId > 0 then
		self._zoneId = zoneId
	end

	self._itemScrollListDic = {}

	local list = ChuangJingRoadConfig.instance:getZoneListById(self._activityId) or {}

	if self._zoneId == 0 and list and #list > 0 then
		self._zoneId = list[1].zoneId
	end

	self._scrollList:reloadData(list)
	self.addGEvent(self, GlobalNotify.CHUANG_JING_ROAD_RANK_INFO_UPDATE, self._onRefreshUI, self)
	ChuangJingRoadController.instance:sendGetRank(self._activityId, self._zoneId)
	self:_onRefreshUI()
end

function ChuangjingroadrankView:_onRefreshUI()
	local info = ChuangJingRoadModel.instance:getRankInfo(self._activityId, self._zoneId) or {}

	if not info.rankList then
		local list = {}

		self._rankScrollList:reloadData(list)

		local cfg = ChuangJingRoadConfig.instance:getZoneCfgById(self._activityId, self._zoneId) or {}

		self._txtTip.text = cfg.rankDesc

		GameUtil.SetActive(self._goEmpty, #list == 0)

		self._txtMyRank.text = checknumber(info.myRank) > 0 and info.myRank or lang("未上榜")
	end
end

function ChuangjingroadrankView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "rankIma", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgHeadIcon = goutil.findChild(go, "headGo")
	local itemScrollerview = goutil.findChild(go, "itemScrollerview")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local petHead = goutil.findChild(go, "petHead")

	GameUtil.SetActive(petHead, false)

	txtRank.text = data.rank

	GameUtil.SetActive(imgRank, data.rank <= 3 and data.rank > 0)
	GameUtil.SetActive(txtRank, true)

	if data.rank <= 3 and data.rank > 0 then
		imgRank:SetState(data.rank - 1)
		GameUtil.SetActive(txtRank, false)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo, true)

	txtName.text = data.headInfo.userName

	local date = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = langPara("%d月%d日\n%02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	local rankCfg = ChuangJingRoadConfig.instance:getRankCfg(self._activityId, self._zoneId, data.rank)
	local prizeStrArr = {}

	if rankCfg then
		prizeStrArr = string.split(rankCfg.prize, "#")
	end

	if not self._itemScrollListDic[go] then
		local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		self._itemScrollListDic[go] = itemScrollList

		itemScrollList:reloadData(prizeStrArr)
		itemScrollList:dragNotifyParent()
	end
end

function ChuangjingroadrankView:_clearRankCell(cell)
	return
end

function ChuangjingroadrankView:_updateItemCell(view, cell, prizeStr, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, go)
end

function ChuangjingroadrankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function ChuangjingroadrankView:_updateTabCell(view, cell, data, tag)
	local change = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "nameTxt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txtName.text = data.desc

	change:SetState(self._zoneId == data.zoneId and 1 or 0)
	btn:AddClickListener(function()
		self:_switchTab(data.zoneId)
	end)
end

function ChuangjingroadrankView:_clearTabCell(cell)
	return
end

function ChuangjingroadrankView:_switchTab(index, force)
	if self._zoneId == index and not force then
		return
	end

	self._zoneId = index

	self._scrollList:refresh()
	ChuangJingRoadController.instance:sendGetRank(self._activityId, self._zoneId)
end

return ChuangjingroadrankView
