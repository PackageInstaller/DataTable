-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/SurveylistView.lua

module("logic.extensions.bonus.view.SurveylistView", package.seeall)

local SurveylistView = class("SurveylistView", ViewComponent)

function SurveylistView:ctor()
	SurveylistView.super.ctor(self)
end

function SurveylistView:unbindEvents()
	SurveylistView.super.unbindEvents(self)
end

function SurveylistView:bindEvents()
	SurveylistView.super.bindEvents(self)
end

function SurveylistView:buildUI()
	SurveylistView.super.buildUI(self)

	self._con = self:getGo("con")
	self._cell = self:getGo("cell")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SurveylistView:onExit()
	SurveylistView.super.onExit(self)
	self._scrollList:dispose()
	RoleObjectPool.instance:removeRole(self._loader)
end

function SurveylistView:onEnter()
	SurveylistView.super.onEnter(self)

	self._cellMap = {}

	self.addGEvent(self, GlobalNotify.SURVEY_LIST_INFO_UPDATE, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.SURVEY_LIST_INFO_SUCCESS, self._sendGetInfo, self)

	local p = self:getFirstParam()

	if p then
		self:_sendGetInfo()
	end

	self:_refreshUI()

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, 1802101, self._con)
end

function SurveylistView:_sendGetInfo()
	SurveyController.instance:sendPM_SignForSdkSurveyReq()
end

function SurveylistView:_refreshUI()
	local list = SurveyController.instance:getAllSurveyList() or {}

	self._scrollList:reloadData(list)
end

function SurveylistView:_updateCell(view, cell, data, tag)
	local tableview = goutil.findChild(cell, "tableview")
	local btnGo = goutil.findChild(cell, "btnGo")
	local finishGo = goutil.findChild(cell, "finishGo")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")

	self._cellMap[cell] = self._cellMap[cell] or ScrollerList.create(tableview, self._cell, GameUtil.handler(self._updateMatCell, self), GameUtil.handler(self._clearMatCell, self))

	if not data.goods then
		local goods = {}

		GameUtil.SetActive(tableview, #goods > 0)
		self._cellMap[cell]:reloadData(goods)

		txtTitle.text = data.surveyName

		local date = GameUtil.string2date(data.endTime)

		txtTime.text = date and date.year >= 2038 and "" or GameUtil.formatTimeString("%Y.%m.%d", data.startTime) .. "-" .. GameUtil.formatTimeString("%Y.%m.%d", data.endTime)

		GameUtil.SetActive(finishGo, checkbool(data.finish) == true)
		GameUtil.SetActive(btnGo, checkbool(data.finish) == false)
		GameUtil.addClickHandler(btnGo, function()
			if Framework.OSDef.isEditor then
				UnityEngine.Application.OpenURL(data.linkUrl)
			else
				InnerWebController.instance:openWebView(data.linkUrl)
			end
		end)
	end
end

function SurveylistView:_clearCell(cell)
	if self._cellMap[cell] then
		self._cellMap[cell]:dispose()
	end
end

function SurveylistView:_updateMatCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data.id .. ":" .. data.num, cell)
end

function SurveylistView:_clearMatCell(cell)
	MaterialMgr.resetAll()
end

return SurveylistView
