-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/view/SlackOffResultView.lua

module("logic.extensions.slackoffgame.view.SlackOffResultView", package.seeall)

local SlackOffResultView = class("SlackOffResultView", ViewComponent)

function SlackOffResultView:ctor()
	SlackOffResultView.super.ctor(self)
end

function SlackOffResultView:buildUI()
	SlackOffResultView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SlackOffResultView:bindEvents()
	SlackOffResultView.super.bindEvents(self)
end

function SlackOffResultView:unbindEvents()
	SlackOffResultView.super.unbindEvents(self)
end

function SlackOffResultView:onExit()
	SlackOffResultView.super.onExit(self)
	self._scrollerList:dispose()
end

function SlackOffResultView:onEnter()
	SlackOffResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SlackOffGameEndRes, self.close, self)

	local params = self:getOpenParam()

	if not params then
		self:close()

		return
	end

	self._activityId = params[1] or 442001
	self._studenInfos = params[2]

	local activityInfo = SlackOffGameModel.instance:getActivityInfo(self._activityId)

	if activityInfo then
		students = activityInfo.students or {}
	end

	for i, info in pairs(self._studenInfos) do
		info.curProg = 0

		for i, msg in pairs(students) do
			if info.studentId == msg.studentId then
				info.curProg = msg.progress

				break
			end
		end
	end

	self._scrollerList:reloadData(self._studenInfos)
end

function SlackOffResultView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtProg = goutil.findChildTextComponent(cell, "txtProgress")
	local bgGo = goutil.findChild(cell, "bg")

	goutil.setActive(bgGo, cell.data % 2 == 0)

	txtName.text = data.studentName

	local str = string.format("%d%s", data.curProg, data.isPass and " + 1" or "")

	txtProg.text = data.curProg < data.maxProg and str or "进度已满"
end

function SlackOffResultView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function SlackOffResultView:_sendGameEndReq()
	local isPass = true

	SlackOffGameController.instance:sendGameEndReq(self._activityId, isPass, self._studenInfos)
	self:close()
end

function SlackOffResultView:sendEndAndClose()
	self:_sendGameEndReq()
end

return SlackOffResultView
