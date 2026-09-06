-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkageintroduction/view/LinkageintroductionView.lua

module("logic.extensions.linkageintroduction.view.LinkageintroductionView", package.seeall)

local LinkageintroductionView = class("LinkageintroductionView", ViewComponent)

function LinkageintroductionView:ctor()
	LinkageintroductionView.super.ctor(self)
end

function LinkageintroductionView:unbindEvents()
	LinkageintroductionView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, v in pairs(self._btnList) do
		GameUtil.rmClickHandler(self._btnList[i].go)
	end
end

function LinkageintroductionView:bindEvents()
	LinkageintroductionView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)

	for i, v in pairs(self._btnList) do
		GameUtil.addClickHandler(self._btnList[i].go, function()
			self:_updatePageData(i)
		end, self)
	end
end

function LinkageintroductionView:buildUI()
	LinkageintroductionView.super.buildUI(self)

	self._container = self:getGo("container")
	self._btns = self:getGo("btns")
	self._btnClose = self:getBtn("btnClose")
	self._btnList = {}

	for i = 1, self._btns.transform.childCount do
		local go = self:getGo("btns/btn_" .. i)

		if go then
			local btn = {}

			btn.go = go
			btn.select = goutil.findChild(btn.go, "select")
			btn.redPoint = goutil.findChild(btn.go, "redPoint")
			btn.txtTitle = goutil.findChildTextComponent(btn.go, "txt")
			self._btnList[i] = btn
		end
	end
end

function LinkageintroductionView:onExit()
	LinkageintroductionView.super.onExit(self)

	for i, v in pairs(self._btnList) do
		RedPointController.instance:unregRedPoint(self._btnList[i].redPoint)
	end
end

function LinkageintroductionView:onEnter()
	LinkageintroductionView.super.onEnter(self)
	self:_activityTime(179001)

	self._cfg = LinkageConfig.instance:getCfgById(1)

	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_LINKAGE_ONCE, true)

	for i, v in pairs(self._btnList) do
		if not string.nilorempty(self._cfg[i].redPointId) then
			RedPointController.instance:regRedPoint(self._btnList[i].redPoint, self._cfg[i].redPointId)
		end
	end

	self:_initData()
end

function LinkageintroductionView:_initData()
	self._curSelectIndex = -1

	self:_updatePageData(1)

	for i, v in pairs(self._btnList) do
		if not string.nilorempty(self._cfg[i].redPointId) then
			LinkageController.instance:lightRedPoint(i, self._cfg[i].redPointId)
		end
	end
end

function LinkageintroductionView:_activityTime(id)
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SAINT_KNIGHT_MO, id)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)
end

function LinkageintroductionView:_updatePageData(id)
	if self._curSelectIndex ~= id then
		self:showTabAt(self._container, self._cfg[id].viewName, id)

		self._curSelectIndex = id

		if LinkageController.instance:isOfficalAndUrl(id) and not string.nilorempty(self._cfg[id].redPointId) then
			RedPointController.instance:saveUserOnceRedPoint(self._cfg[id].redPointId, true)
		end
	end

	for i, v in ipairs(self._btnList) do
		v.txtTitle.text = self._cfg[i].name

		GameUtil.SetActive(v.select, id == i)
	end
end

function LinkageintroductionView:_onClickClose()
	self:close()
end

return LinkageintroductionView
