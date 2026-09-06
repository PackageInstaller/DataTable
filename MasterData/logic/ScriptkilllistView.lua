-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scriptkill/view/ScriptkilllistView.lua

module("logic.extensions.scriptkill.view.ScriptkilllistView", package.seeall)

local ScriptkilllistView = class("ScriptkilllistView", ViewComponent)

function ScriptkilllistView:ctor()
	ScriptkilllistView.super.ctor(self)
end

function ScriptkilllistView:unbindEvents()
	ScriptkilllistView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ScriptkilllistView:bindEvents()
	ScriptkilllistView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ScriptkilllistView:buildUI()
	ScriptkilllistView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._item = self:getGo("item")

	GameUtil.SetActive(self._item, false)

	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function ScriptkilllistView:onExit()
	ScriptkilllistView.super.onExit(self)
	self._scrollList:dispose()
end

function ScriptkilllistView:onEnter()
	ScriptkilllistView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = ScriptKillController.instance:getActivityId()
	end

	self.addGEvent(self, GlobalNotify.ScriptKillInfoUpdate, self._refreshUI, self)
	ScriptKillController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()
end

function ScriptkilllistView:_refreshUI()
	local list = ScriptKillConfig.instance:getChapterListById(self._activityId) or {}

	self._scrollList:reloadData(list)
	self._scrollList:setCenterMode(true)
end

function ScriptkilllistView:_updateCell(view, cell, data, tag)
	local items = goutil.findChild(cell, "items")
	local txtTips = goutil.findChildTextComponent(cell, "txtTips")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local con = goutil.findChild(cell, "img/con")

	txtName.text = data.name
	txtTips.text = ""

	local timeStart = GameUtil.string2time(data.openDateTime)
	local now = ServerTime.now()

	if now < timeStart then
		local endDate = GameUtil.time2date(timeStart)
		local timeStr = langPara("%02d.%02d %02d:%02d", endDate.month, endDate.day, endDate.hour, endDate.min)

		txtTips.text = langPara("%s后解锁", timeStr)
	elseif not ScriptKillModel.instance:checkFinishLast(self._activityId, data.chapterId) then
		txtTips.text = langPara("完成上一章后解锁")
	end

	uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/scriptkill", data.img))

	local childCount = items.transform.childCount

	for i = 1, childCount do
		local trans = items.transform:GetChild(i - 1)
		local go = trans.gameObject

		MaterialMgr.resetAll(go)
	end

	goutil.clearChildren(items)

	local arr = string.split(data.prize or "", "#")

	for i, v in ipairs(arr) do
		local go = goutil.clone(self._item, "item_" .. i)

		GameUtil.SetActive(go, true)
		goutil.addChildToParent(go, items)
		MaterialMgr.setCellByCfg(v, go)
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, data))
end

function ScriptkilllistView:clearCell(cell)
	local items = goutil.findChild(cell, "items")
	local childCount = items.transform.childCount

	for i = 1, childCount do
		local trans = items.transform:GetChild(i - 1)
		local go = trans.gameObject

		MaterialMgr.resetAll(go)
	end

	goutil.clearChildren(items)

	local con = goutil.findChild(cell, "img/con")

	uGuiUtil.clearImage(con)
end

function ScriptkilllistView:_onClickCell(data)
	if not ScriptKillModel.instance:checkFinishLast(self._activityId, data.chapterId) then
		TipsFacade.instance:openCommonTips("请先完成上一章节")

		return
	end

	local timeStart = GameUtil.string2time(data.openDateTime)
	local now = ServerTime.now()

	if now < timeStart then
		local endDate = GameUtil.time2date(timeStart)
		local timeStr = langPara("%02d.%02d %02d:%02d后解锁", endDate.month, endDate.day, endDate.hour, endDate.min)

		TipsFacade.instance:openCommonTips(timeStr)
	else
		UIStateManager.instance:push(ViewName.ScriptkillchapteriewView, self._activityId, data.chapterId)
	end
end

function ScriptkilllistView:_onClickTip()
	return
end

return ScriptkilllistView
