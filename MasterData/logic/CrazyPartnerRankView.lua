-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/crazypartner/view/CrazyPartnerRankView.lua

module("logic.extensions.crazypartner.view.CrazyPartnerRankView", package.seeall)

local CrazyPartnerRankView = class("CrazyPartnerRankView", TableViewComponent)

CrazyPartnerRankView.TabCfg = {
	{
		tabIndex = CrazyPartnerConfig.RankTypeDefine.Daily,
		tabName = lang("CrazyPartnerRankView__1")
	},
	{
		tabIndex = CrazyPartnerConfig.RankTypeDefine.Total,
		tabName = lang("CrazyPartnerRankView__2")
	}
}

function CrazyPartnerRankView:_getPath()
	return {
		cellPath = "right/cell",
		viewPath = "right/rankScrollRect"
	}
end

function CrazyPartnerRankView:unbindEvents()
	CrazyPartnerRankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function CrazyPartnerRankView:bindEvents()
	CrazyPartnerRankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function CrazyPartnerRankView:onExit()
	CrazyPartnerRankView.super.onExit(self)
	CrazyPartnerController.instance:unregisterLocalNotify(CrazyPartnerController.AfterRankInfoResponse, self._onRankInfoUpdate, self)
	self._scrollList:dispose()
end

function CrazyPartnerRankView:buildUI()
	CrazyPartnerRankView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTitle = self:getTxt("title/txtTitle")
	self._goEmpty = self:getGo("right/goEmpty")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._txtTip = self:getTxt("right/myRank/txtTip")
	self._scrollerGo = self:getGo("tabList")
	self._cellGo = self:getGo("tabCell")
	self._scrollList = ScrollerList.create(self._scrollerGo, self._cellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._scrollList:regGetCellSize(function()
		return 100, 70
	end)
end

function CrazyPartnerRankView:_updateTabCell(view, cell, data, tag)
	local change = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "nameTxt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txtName.text = data.tabName

	change:SetState(data.tabIndex == self._tabIndex and 1 or 0)
	btn:AddClickListener(function()
		self:_switchTab(data.tabIndex)
	end)
end

function CrazyPartnerRankView:_clearTabCell(cell)
	return
end

function CrazyPartnerRankView:onEnter()
	CrazyPartnerRankView.super.onEnter(self)
	CrazyPartnerController.instance:registerLocalNotify(CrazyPartnerController.AfterRankInfoResponse, self._onRankInfoUpdate, self)
	self:_switchTab(CrazyPartnerConfig.RankTypeDefine.Daily, true)
end

function CrazyPartnerRankView:_switchTab(index, force)
	if self._tabIndex == index and not force then
		return
	end

	self._tabRankId = CrazyPartnerRankView.TabCfg[index].tabIndex
	self._tabIndex = index

	self._scrollList:reloadData(CrazyPartnerRankView.TabCfg)

	self._txtTip.text = self._tabRankId == CrazyPartnerConfig.RankTypeDefine.Daily and lang("CrazyPartnerRankView__3") or lang("CrazyPartnerRankView__4")

	CrazyPartnerController.instance:reqRankInfo(self._tabRankId)
end

function CrazyPartnerRankView:_onRankInfoUpdate(rankType)
	if rankType == self._tabRankId then
		self:_onRefreshUI()
	end
end

function CrazyPartnerRankView:_onRefreshUI()
	self._rankInfo = CrazyPartnerModel.instance:getRankData(self._tabIndex)

	local myRank = checknumber(self._rankInfo.myRank)

	self._txtMyRank.text = myRank > 0 and myRank or lang("world_Boss_tip9")

	self._goEmpty:SetActive(#self._rankInfo.rankInfoList == 0)
	self:updateListData(self._rankInfo.rankInfoList)
end

function CrazyPartnerRankView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local imgRank = goutil.findChildComponent(go, "rankIma", typeof(UIImageSpriteChange))
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local imgIcon = goutil.findChild(go, "headGo")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtArea = goutil.findChildTextComponent(go, "txtArea")
	local petHead = goutil.findChild(go, "petHead")

	GameUtil.SetActive(petHead, false)

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtRank.text = data.rank
	txtScore.text = data.score
	txtArea.text = data.areaName

	local rank = checknumber(data.rank)
	local isTop3 = rank <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end
end

function CrazyPartnerRankView:_clearTableview(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "headGo")
	local petHead = goutil.findChild(go, "petHead")

	HeadItemController.instance:resetHeadCell(imgIcon)
	MaterialMgr.clearIcon(petHead)
end

return CrazyPartnerRankView
