-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooLogView.lua

module("logic.extensions.zoo.view.ZooLogView", package.seeall)

local ZooLogView = class("ZooLogView", ViewComponent)

function ZooLogView:buildUI()
	ZooLogView.super.buildUI(self)

	self._closeBtn = self:getBtn("close")
	self._recordCell = self:getGo("recordCell")
	self._recordView = ScrollerList.create(self:getGo("recordView"), self._recordCell, GameUtil.handler(self._updateCell, self))
	self._empty = self:getGo("empty")
end

function ZooLogView:bindEvents()
	ZooLogView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function ZooLogView:unbindEvents()
	ZooLogView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ZooLogView:onEnter()
	ZooLogView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooGetInteractionLog, self._getInteractionLog, self)
	ZooAgent.instance:sendPM_ZooGetInteractionLogReq()
	goutil.setActive(self._empty, true)
	self._recordView:reloadData({})
end

function ZooLogView:onExit()
	ZooLogView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooGetInteractionLog, self._getInteractionLog, self)
end

function ZooLogView:_getInteractionLog(msg)
	goutil.setActive(self._empty, #msg.logs == 0)
	self._recordView:reloadData(msg.logs)
end

function ZooLogView:_updateCell(view, cell, data, tag)
	local tab = GameUtil.time2date(ServerTime.now())

	goutil.findChildTextComponent(cell.gameObject, "date").text = string.format(lang("petzoo_log_date"), tab.month, tab.day)

	local friendMo = FriendModel.instance:getFriendMo(data.buddyId)
	local icon = goutil.findChildComponent(cell.gameObject, "icon", ComponentType.UIImageSpriteChange)
	local content = goutil.findChildTextComponent(cell.gameObject, "content")

	if data.actType == 1 then
		content.text = string.format(lang("petzoo_log_visit"), friendMo:getValue("name"))

		icon:SetState(0)
	elseif data.actType == 2 then
		icon:SetState(1)

		content.text = string.format(lang("petzoo_log_stealfriuts"), friendMo:getValue("name"), data.params[1])
	end
end

return ZooLogView
