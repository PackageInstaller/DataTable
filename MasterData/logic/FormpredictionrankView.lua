-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formprediction/view/FormpredictionrankView.lua

module("logic.extensions.formprediction.view.FormpredictionrankView", package.seeall)

local FormpredictionrankView = class("FormpredictionrankView", ViewComponent)

function FormpredictionrankView:ctor()
	FormpredictionrankView.super.ctor(self)
end

function FormpredictionrankView:unbindEvents()
	FormpredictionrankView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FormpredictionrankView:bindEvents()
	FormpredictionrankView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FormpredictionrankView:buildUI()
	FormpredictionrankView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtMyRank = self:getTxt("right/myRank/txtMyRank")
	self._rankScrollRect = self:getGo("right/rankScrollRect")
	self._cell = self:getGo("right/cell")
	self._goEmpty = self:getGo("right/goEmpty")
	self._itemScrollercell = self:getGo("right/itemScrollercell")
	self._itemScrollerview = self:getGo("right/myRank/itemScrollerview")
	self.scrollerGo = self:getGo("tabList")
	self.cellGo = self:getGo("tabCell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self._scrollList:regGetCellSize(function()
		return 100, 70
	end)

	self._rankScrollList = ScrollerList.create(self._rankScrollRect, self._cell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._downScrollList = ScrollerList.create(self._itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
end

function FormpredictionrankView:onExit()
	FormpredictionrankView.super.onExit(self)
	self._scrollList:dispose()
	self._rankScrollList:dispose()

	for k, v in pairs(self._itemScrollListDic) do
		v:dispose()
	end
end

function FormpredictionrankView:onEnter()
	FormpredictionrankView.super.onEnter(self)

	self._activityId = 385001
	self._curFormId = 0
	self._itemScrollListDic = {}

	local param = self:getOpenParam() or {}
	local actId = checknumber(param[1])

	if actId > 0 then
		self._activityId = actId
	end

	local formId = checknumber(param[2])

	if formId > 0 then
		self._curFormId = formId
	end

	local tabCfg = FormPredictionConfig.instance:getFormationListCfgById(self._activityId) or {}
	local tabList = {}

	for k, v in pairs(tabCfg) do
		table.insert(tabList, v)
	end

	ArraySort.sortOn(tabList, "formId", ArraySort.NUMERIC)

	if self._curFormId == 0 and tabList and #tabList > 0 then
		self._curFormId = tabList[1].formId
	end

	self._scrollList:reloadData(tabList)
	self.addGEvent(self, GlobalNotify.FORMPREDICTION_RANK_UPDATE, self._onRefreshUI, self)
	FormPredictionController.instance:sendGetRank(self._activityId, self._curFormId)
	self:_onRefreshUI()
end

function FormpredictionrankView:_onRefreshUI()
	local tabCfg = FormPredictionConfig.instance:getFormationCfgById(self._activityId, self._curFormId) or {}

	self._rankPrizePlanId = tabCfg.rankPrizePlanId

	local info = FormPredictionModel.instance:getRankInfo(self._activityId, self._curFormId) or {}

	if not info.rankInfoList then
		local list = {}

		self._rankScrollList:reloadData(list)
		GameUtil.SetActive(self._goEmpty, #list == 0)
		GameUtil.SetActive(self._itemScrollerview, false)

		if checknumber(info.myRank) > 0 then
			self._txtMyRank.text = info.myRank

			GameUtil.SetActive(self._itemScrollerview, true)

			local rankCfg = FormPredictionConfig.instance:getRankCfg(self._rankPrizePlanId, info.myRank)

			self._downScrollList:reloadData((rankCfg or nil) and string.split(rankCfg.prize, "#"))
		else
			self._txtMyRank.text = lang("未上榜")
		end
	end
end

function FormpredictionrankView:_updateRankCell(view, cell, data, tag)
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
		GameUtil.SetActive(txtRank, false)
		imgRank:SetState(data.rank - 1)
	end

	local proxy = HeadItemController.instance:setHeadCellByInfo(imgHeadIcon, data.headInfo, true)

	txtName.text = data.headInfo.userName
	txtScore.text = data.value

	local date = GameUtil.time2date(checknumber(data.time) / 1000)

	txtTime.text = langPara("%d月%d日\n%02d:%02d:%02d", date.month, date.day, date.hour, date.min, date.sec)

	local rankCfg = FormPredictionConfig.instance:getRankCfg(self._rankPrizePlanId, data.rank)
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

function FormpredictionrankView:_clearRankCell(cell)
	return
end

function FormpredictionrankView:_updateItemCell(view, cell, prizeStr, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, go)
end

function FormpredictionrankView:_clearItemCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function FormpredictionrankView:_updateTabCell(view, cell, data, tag)
	local change = cell.gameObject:GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "nameTxt")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	txtName.text = data.name

	change:SetState(self._curFormId == data.formId and 1 or 0)
	btn:AddClickListener(function()
		self:_switchTab(data.formId)
	end)
end

function FormpredictionrankView:_clearTabCell(cell)
	return
end

function FormpredictionrankView:_switchTab(index, force)
	local tabCfg = FormPredictionConfig.instance:getFormationCfgById(self._activityId, index) or {}
	local publicationTime = tabCfg.publicationTime
	local lastTime = GameUtil.string2time(publicationTime)
	local now = ServerTime.now()

	if now < lastTime then
		TipsFacade.instance:openCommonTips("揭晓榜单后开启~")
	else
		if self._curFormId == index and not force then
			return
		end

		self._curFormId = index

		self._scrollList:refresh()
		FormPredictionController.instance:sendGetRank(self._activityId, self._curFormId)
	end
end

return FormpredictionrankView
