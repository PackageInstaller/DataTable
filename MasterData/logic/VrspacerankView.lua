-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/view/VrspacerankView.lua

module("logic.extensions.vrspace.view.VrspacerankView", package.seeall)

local VrspacerankView = class("VrspacerankView", ViewComponent)

function VrspacerankView:ctor()
	VrspacerankView.super.ctor(self)
end

function VrspacerankView:unbindEvents()
	VrspacerankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function VrspacerankView:bindEvents()
	VrspacerankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function VrspacerankView:buildUI()
	VrspacerankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyStep = self:getTxt("right/myRank/txtMyStep")
	self._txtEmptyTips = self:getGo("right/myRank/txtEmptyTips")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._itemTablecell = self:getGo("itemTablecell")
	self._itemTableview = self:getGo("right/myRank/itemTableview")
	self._tableview = self:getGo("right/tableview")
	self._tablecell = self:getGo("right/tableview/tablecell")
	self._rankTableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemTableList = ScrollerList.create(self._itemTableview, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
end

function VrspacerankView:onExit()
	VrspacerankView.super.onExit(self)
	self._rankTableList:dispose()
	self._itemTableList:dispose()
end

function VrspacerankView:onEnter()
	VrspacerankView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = VRSpaceController.instance:getDefaultActivityId()
	end

	self._itemTableListDir = {}

	self.addGEvent(self, GlobalNotify.VR_SPACE_RANK_INFO_UPDATE, self._onRefreshUI, self)
	VRSpaceController.instance:sendGetRankInfo(self._activityId)
	self:_onRefreshUI()
end

function VrspacerankView:_onRefreshUI()
	self._rankInfo = VRSpaceModel.instance:getRankInfo(self._activityId) or {}

	if not self._rankInfo.rankInfos then
		local list = {}

		self._rankTableList:reloadData(list)
		GameUtil.SetActive(self._goEmpty, #list == 0)

		local rank = checknumber(self._rankInfo.myRank)

		self._txtMyRank.text = rank <= 0 and lang("未上榜") or rank
	end
end

function VrspacerankView:_updateRankCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgChangeRank = goutil.findChildComponent(go, "imgRank", "UIImageSpriteChange")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "imgHeadIcon")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtTime = goutil.findChildTextComponent(go, "txtTime")
	local itemTableView = goutil.findChild(go, "itemTableview")
	local rankInfo = data
	local rank = rankInfo.rank

	txtRank.text = rank

	GameUtil.SetActive(imgChangeRank, rankInfo.rank <= 3 and rankInfo.rank > 0)

	if rankInfo.rank <= 3 and rankInfo.rank > 0 then
		imgChangeRank:SetState(rankInfo.rank - 1)
		GameUtil.SetActive(imgChangeRank, true)
		GameUtil.SetActive(txtRank, false)
	else
		GameUtil.SetActive(imgChangeRank, false)
		GameUtil.SetActive(txtRank, true)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, rankInfo.headInfo, true)

	txtName.text = rankInfo.headInfo.userName

	local date = GameUtil.time2date(checknumber(rankInfo.time) / 1000)

	txtScore.text = rankInfo.headInfo.areaName
	txtTime.text = langPara("%d月%d日 %02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	local prizeArray = {}
	local rankPrizeCfgs = VRSpaceConfig.instance:getRankListCfgById(self._activityId) or {}

	for k, v in pairs(rankPrizeCfgs) do
		if rank >= v.rankRange[1] and rank <= v.rankRange[2] then
			prizeArray = string.split(v.prize, "#")

			break
		end
	end

	if itemTableView and self._itemTablecell then
		if not self._itemTableListDir[itemTableView] then
			local itemTableList = ScrollerList.create(itemTableView, self._itemTablecell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemTableListDir[itemTableView] = self._itemTableListDir[itemTableView]

			self._itemTableListDir[itemTableView]:reloadData(prizeArray)
		end
	end
end

function VrspacerankView:_clearRankCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "imgHeadIcon")

	HeadItemController.instance:resetHeadCell(imgIcon)

	local itemTableView = goutil.findChild(go, "itemTableview")

	if self._itemTableListDir[itemTableView] then
		self._itemTableListDir[itemTableView]:dispose()

		self._itemTableListDir[itemTableView] = nil
	end
end

function VrspacerankView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
	MaterialMgr.setCellByCfg(data, go)
end

function VrspacerankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

return VrspacerankView
