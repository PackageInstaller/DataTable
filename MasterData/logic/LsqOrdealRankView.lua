-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/view/LsqOrdealRankView.lua

module("logic.extensions.luoshiqiordeal.view.LsqOrdealRankView", package.seeall)

local LsqOrdealRankView = class("LsqOrdealRankView", ViewComponent)
local RankType = {
	Crazy = 2,
	Normal = 1
}

function LsqOrdealRankView:ctor()
	LsqOrdealRankView.super.ctor(self)
end

function LsqOrdealRankView:buildUI()
	LsqOrdealRankView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tabCell = self:getGo("tabcell")
	self._tabtableview = self:getGo("tabscrollview")
	self.scrollList = ScrollerList.create(self._tabtableview, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._normalTitle = self:getGo("container/normal")
	self._crazyTitle = self:getGo("container/crazy")
	self._emptyTip = self:getGo("container/empty")
	self._rankCell = self:getGo("container/cell")
	self._rankTableview = self:getGo("container/tableview")
	self._rankScrollList = ScrollerList.create(self._rankTableview, self._rankCell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._myReward = self:getGo("container/myRank/reward")
	self._txtMyRank = self:getTxt("container/myRank/txtMyRank")
	self._txtTip = self:getTxt("container/myRank/txtTip")
end

function LsqOrdealRankView:bindEvents()
	LsqOrdealRankView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function LsqOrdealRankView:unbindEvents()
	LsqOrdealRankView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function LsqOrdealRankView:onEnter()
	LsqOrdealRankView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayGetRankRes, self._onGetRankRes, self)

	self._activityId = self:getFirstParam()

	self:_initTab()
	self:_updateInfoByType(RankType.Normal)

	self._isRequestNormal = false
	self._isRequestCrazy = false

	local isCrazy = false

	XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayGetRankReq(self._activityId, isCrazy)
end

function LsqOrdealRankView:onExit()
	LsqOrdealRankView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayGetRankRes, self._onGetRankRes, self)
	MaterialMgr.resetAll(self._myReward)
end

function LsqOrdealRankView:_onClickClose()
	self:close()
end

function LsqOrdealRankView:_onGetRankRes(isCrazy)
	if isCrazy then
		if not RankType.Crazy then
			local selectIndex = RankType.Normal

			self:_updateTab(selectIndex, true)
		end
	end
end

function LsqOrdealRankView:_updateTabCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local uiChangeGroup = goutil.findChild(cell, "imgBg"):GetComponent(ComponentType.UIChangeGroup)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btn:AddClickListener(function()
		if data.tabType == RankType.Crazy and not self._isRequestCrazy then
			XiaoNuoBirthdayGiftAgent:sendPM_XiaoNuoBirthdayGetRankReq(self._activityId, true)
		else
			self:_updateTab(data.tabType)
		end
	end)

	txtName.text = data.tabType == RankType.Normal and lang("lsqordeal_desc14") or lang("lsqordeal_desc15")

	uiChangeGroup:SetState(data.isSelect and 1 or 0)
end

function LsqOrdealRankView:_clearTabCell(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	btn:RemoveClickListener()
end

function LsqOrdealRankView:_updateRankCell(view, cell, data, tag)
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local spriteChange = goutil.findChild(cell, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local headGo = goutil.findChild(cell, "head")
	local txt1 = goutil.findChildTextComponent(cell, "txt1")
	local txt2 = goutil.findChildTextComponent(cell, "txt2")
	local txt3 = goutil.findChildTextComponent(cell, "txt3")

	txtRank.text = data.rank

	if data.rank <= 3 then
		goutil.setActive(spriteChange.gameObject, true)
		spriteChange:SetState(data.rank - 1)
	else
		goutil.setActive(spriteChange.gameObject, false)
	end

	txt1.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)

	if self._curSelectIndex == RankType.Normal then
		txt2.text = data.areaName
		txt3.text = data.totalDamage
	else
		txt2.text = data.totalDamage
		txt3.text = GameUtil.formatTimeStamp("%Y-%m-%d %H:%M:%S", data.timeStamp / 1000)
	end
end

function LsqOrdealRankView:_clearRankCell(cell)
	local headGo = goutil.findChild(cell, "head")

	MaterialMgr.resetAll(headGo)
end

function LsqOrdealRankView:_initTab()
	self._curSelectIndex = nil

	self:_updateRankList(self._curSelectIndex)
	self:_updateMyRank(self._curSelectIndex)

	local list = {}

	if LuoShiQiOrdealConfig.instance:getRankNormalCfg(self._activityId) then
		if self._curSelectIndex == nil then
			self._curSelectIndex = RankType.Normal
		end

		local element = {}

		element.tabType = RankType.Normal
		element.isSelect = RankType.Normal == self._curSelectIndex

		table.insert(list, element)
	end

	if LuoShiQiOrdealConfig.instance:getRankCrazyCfg(self._activityId) then
		if self._curSelectIndex == nil then
			self._curSelectIndex = RankType.Crazy
		end

		local element = {}

		element.tabType = RankType.Crazy
		element.isSelect = RankType.Crazy == self._curSelectIndex

		table.insert(list, element)
	end

	self.scrollList:reloadData(list)
end

function LsqOrdealRankView:_updateTab(tabType, isForce)
	if not isForce and self._curSelectIndex == tabType then
		return
	end

	local curViewDatas = self.scrollList:getData()

	for i, v in ipairs(curViewDatas) do
		v.isSelect = i == tabType
	end

	self.scrollList:refresh()

	self._curSelectIndex = tabType

	self:_updateRankList(self._curSelectIndex)
	self:_updateMyRank(self._curSelectIndex)
	self:_updateInfoByType(tabType)
end

function LsqOrdealRankView:_updateRankList(tabType)
	local rankList = LuoShiQiOrdealModel.instance:getRankList(tabType)

	goutil.setActive(self._emptyTip, #rankList == 0)
	goutil.setActive(self._normalTitle, tabType == RankType.Normal)
	goutil.setActive(self._crazyTitle, tabType == RankType.Crazy)
	self._rankScrollList:reloadData(rankList)
end

function LsqOrdealRankView:_updateMyRank(tabType)
	local rankNum = LuoShiQiOrdealModel.instance:getMyRank(tabType)

	self._txtMyRank.text = rankNum > 0 and rankNum or lang("text_rank_notrank")
end

function LsqOrdealRankView:_updateInfoByType(tabType)
	if tabType == RankType.Normal then
		local cfg = LuoShiQiOrdealConfig.instance:getRankNormalCfg(self._activityId)

		if cfg then
			self._txtTip.text = cfg.desc

			MaterialMgr.resetAll(self._myReward)
			MaterialMgr.setCellByCfg(cfg.prize, self._myReward)
		end
	else
		local cfg = LuoShiQiOrdealConfig.instance:getRankCrazyCfg(self._activityId)

		if cfg then
			self._txtTip.text = cfg.desc

			MaterialMgr.resetAll(self._myReward)
			MaterialMgr.setCellByCfg(cfg.prize, self._myReward)
		end
	end
end

return LsqOrdealRankView
