-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyRankView.lua

module("logic.extensions.newfamily.view.FamilyRankView", package.seeall)

local FamilyRankView = class("FamilyRankView", ViewComponent)
local tab_Datas = {
	{
		rankTips = "1、本排行榜为全服家族排名，以历史最高积分的高低进行排名，每10分钟更新一次\n2、仅显示前100名家族",
		name = "家族排行榜",
		titleName = "家族名称",
		rankTitleText = "家族排行",
		rankType = GameEnum.FamilyRankType.FamilyRank
	},
	{
		rankTips = "本排行榜为家族内成员排行榜，每10分钟更新一次",
		name = "成员排行榜",
		titleName = "奥奇名称",
		rankTitleText = "我的排名",
		rankType = GameEnum.FamilyRankType.MemberRank
	}
}

function FamilyRankView:ctor()
	FamilyRankView.super.ctor(self)

	self._tableCellList = {}
	self._rankType = nil
end

function FamilyRankView:unbindEvents()
	FamilyRankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function FamilyRankView:bindEvents()
	FamilyRankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.onClickClose, self)
end

function FamilyRankView:onExit()
	FamilyRankView.super.onExit(self)
	self:_clearTableList()
	GlobalDispatcher:removeListener(GlobalNotify.FamilyRankData, self._updateRankData, self)
end

function FamilyRankView:buildUI()
	FamilyRankView.super.buildUI(self)

	self._closeBtn = self:getBtn("Close")
	self._tableCell = self:getGo("tablecell")
	self._tableCellParent = self:getGo("tableview/Nego_Viewport/Nego_Content")
	self._rankCell = self:getGo("right/rankCell")
	self._rankScroll = self:getGo("right/rankListView")
	self._nameTxt = self:getTxt("right/description/txtName")
	self._rankTxt = self:getTxt("right/description/txtRank")
	self._overTimeTxt = self:getTxt("right/description/txtOverTime")
	self._severOrScoreTxt = self:getTxt("right/description/txtFamily")
	self._rankCellParent = self:getGo("right/rankListView/Nego_Viewport/Nego_Content")
	self._myRankTitleTxt = self:getTxt("right/myRank/txtMyRankTitle")
	self._myRankTxt = self:getTxt("right/myRank/txtMyRank")
	self._rankTips = self:getTxt("right/myRank/txtTip")
	self._scoreTxt = self:getGo("right/description/txtScore")
	self._areaTxt = self:getGo("right/description/txtArea")
	self._historyMaxScoreTxt = self:getGo("right/description/txtHistoryMaxScore")
	self._rankScrollList = ScrollerList.create(self._rankScroll, self._rankCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearItemCell, self))
end

function FamilyRankView:onEnter()
	FamilyRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FamilyRankData, self._updateRankData, self)
	self:_initTableView()
end

function FamilyRankView:onClickClose()
	self:close()
end

function FamilyRankView:_initTableView()
	for i, v in ipairs(tab_Datas) do
		local go = self:_getTableCell(v)

		go.name = "tablecell" .. i

		goutil.addChildToParent(go, self._tableCellParent.transform)
		goutil.setActive(go, true)
		table.insert(self._tableCellList, go)
	end

	self:_refreshTableList(tab_Datas[1])
	goutil.setActive(goutil.findChild(self._tableCellParent, "tablecell1/leafCell/imgSelected"), true)
end

function FamilyRankView:_getTableCell(data)
	local go = goutil.clone(self._tableCell)
	local nameTxt = goutil.findChildTextComponent(go, "leafCell/txtName")
	local selectImg = goutil.findChild(go, "leafCell/imgSelected")
	local goBtn = goutil.findChildButtonComponent(go, "leafCell")

	nameTxt.text = data.name

	GameUtil.asBtn(goBtn):AddClickListener(function()
		self:_refreshTableList(data)
		goutil.setActive(selectImg, true)
	end, self)

	return go
end

function FamilyRankView:_refreshTableList(data)
	for _, v in pairs(self._tableCellList) do
		local selectImg = goutil.findChild(v, "leafCell/imgSelected")

		goutil.setActive(selectImg, false)
	end

	self._rankType = data.rankType

	self:_sendRankInfos(data.rankType)

	self._myRankTitleTxt.text = data.rankTitleText
	self._rankTips.text = data.rankTips
	self._nameTxt.text = data.titleName
end

function FamilyRankView:_clearTableList()
	for _, v in pairs(self._tableCellList) do
		local goBtn = goutil.findChildButtonComponent(v, "leafCell")

		GameUtil.asBtn(goBtn):RemoveClickListener()
	end

	self._tableCellList = {}

	goutil.clearChildren(self._tableCellParent)
end

function FamilyRankView:_updateRankData()
	local rankList

	if self._rankType == GameEnum.FamilyRankType.FamilyRank then
		rankList = FamilyCallOrderModel.instance:getFamilySummonCommandViewFamilyRank()
	elseif self._rankType == GameEnum.FamilyRankType.MemberRank then
		rankList = FamilyCallOrderModel.instance:getFamilySummonCommandViewMemberRank()
	end

	local myRank = self:nullOrLoser(rankList.myRank)
	local myFamilyRank = self:nullOrLoser(rankList.myFamilyRank)

	self._rankViewDatas = rankList.familyRankInfos or rankList.memberRankInfos
	self._myRankTxt.text = myFamilyRank or myRank

	self._rankScrollList:reloadData(self._rankViewDatas)
	goutil.setActive(self._scoreTxt, self._rankType == GameEnum.FamilyRankType.MemberRank)
	goutil.setActive(self._areaTxt, self._rankType == GameEnum.FamilyRankType.FamilyRank)
	goutil.setActive(self._historyMaxScoreTxt, self._rankType == GameEnum.FamilyRankType.FamilyRank)
end

function FamilyRankView:nullOrLoser(rank)
	if rank ~= nil and rank <= 0 then
		rank = "未上榜"
	end

	return rank
end

function FamilyRankView:_updataRankScrollByFamilyRank(data, cell)
	local go = goutil.findChildComponent(cell, "imgFamilyIcon", "UIImageSpriteChange")
	local nameTxt = goutil.findChildTextComponent(cell, "txtName")
	local areaTxt = goutil.findChildTextComponent(cell, "txtArea")
	local historyMaxScoreTxt = goutil.findChildTextComponent(cell, "txtHistoryMaxScore")

	historyMaxScoreTxt.text = data.historyMaxScore or ""
	areaTxt.text = data.areaName or ""

	goutil.setActive(go.gameObject, true)
	goutil.clearChildren(go)

	if data ~= nil and data.familyIconId ~= nil then
		go:SetState(data.familyIconId)

		nameTxt.text = data.familyName
	end
end

function FamilyRankView:_updataRankScrollByMemberRank(data, cell)
	local go = goutil.findChild(cell, "imgIcon")
	local nameTxt = goutil.findChildTextComponent(cell, "txtName")
	local scoreTxt = goutil.findChildTextComponent(cell, "txtScore")

	scoreTxt.text = data.score or ""

	goutil.setActive(goutil.findChild(cell, "imgFamilyIcon"), false)
	goutil.clearChildren(go)

	if data.headInfo ~= nil then
		HeadItemController.instance:setHeadCellByInfo(go, data.headInfo)

		nameTxt.text = data.headInfo.userName
	end
end

function FamilyRankView:_updateRankCell(view, cell, data, tag)
	if data == nil then
		return
	end

	local rankTxt = goutil.findChildTextComponent(cell, "txtRank")
	local rankImg = goutil.findChild(cell, "txtRank/imgRank")
	local passTimeTxt = goutil.findChildTextComponent(cell, "passTime/txtPassTime")

	rankTxt.text = data.rank
	passTimeTxt.text = data.time

	if data.rank ~= nil and checknumber(data.rank) <= 3 and checknumber(data.rank) > 0 then
		goutil.setActive(rankImg, true)
		rankImg:GetComponent("UIImageSpriteChange"):SetState(checknumber(data.rank) - 1)
	else
		goutil.setActive(rankImg, false)
	end

	if checknumber(data.time) > 0 then
		local time = GameUtil.time2date(checknumber(data.time / 1000))

		passTimeTxt.text = string.format("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
	end

	self:_updateCellByInfo(data, cell)
end

function FamilyRankView:_sendRankInfos(rankType)
	if rankType == GameEnum.FamilyRankType.FamilyRank then
		FamilyCallOrderController.instance:sendPM_FamilySummonCommandViewFamilyRankReq()
	elseif rankType == GameEnum.FamilyRankType.MemberRank then
		FamilyCallOrderController.instance:sendPM_FamilySummonCommandViewMemberRankReq()
	end
end

function FamilyRankView:_updateCellByInfo(data, cell)
	if self._rankType == GameEnum.FamilyRankType.FamilyRank then
		self:_updataRankScrollByFamilyRank(data, cell)
	elseif self._rankType == GameEnum.FamilyRankType.MemberRank then
		self:_updataRankScrollByMemberRank(data, cell)
	end

	self:_cellIsActive(cell)
end

function FamilyRankView:_cellIsActive(cell)
	local scoreTxt = goutil.findChild(cell, "txtScore")
	local areaTxt = goutil.findChild(cell, "txtArea")
	local historyMaxScoreTxt = goutil.findChild(cell, "txtHistoryMaxScore")

	goutil.setActive(scoreTxt, self._rankType == GameEnum.FamilyRankType.MemberRank)
	goutil.setActive(areaTxt, self._rankType == GameEnum.FamilyRankType.FamilyRank)
	goutil.setActive(historyMaxScoreTxt, self._rankType == GameEnum.FamilyRankType.FamilyRank)
end

function FamilyRankView:_clearItemCell(cell)
	local go = goutil.findChild(cell, "imgIcon")

	HeadItemController.instance:resetHeadCell(go)
end

return FamilyRankView
