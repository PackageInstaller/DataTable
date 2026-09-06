-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/codeword/view/CodeWordView.lua

module("logic.extensions.codeword.view.CodeWordView", package.seeall)

local CodeWordView = class("CodeWordView", ViewComponent)

function CodeWordView:ctor()
	CodeWordView.super.ctor(self)
end

function CodeWordView:buildUI()
	CodeWordView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self.cell = self:getGo("cell")
	self.tableview = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function CodeWordView:bindEvents()
	CodeWordView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function CodeWordView:unbindEvents()
	CodeWordView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function CodeWordView:onEnter()
	CodeWordView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GetCodeWordInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NotifyCodeWordChangeRes, self._onCodeWordChangeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CodeWordSelectChannel, self._onSelectChannel, self)
	ChatAgent.instance:sendPM_GetCodeWordInfoReq()
	settimer(1, self._onSecond, self)
end

function CodeWordView:onExit()
	CodeWordView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GetCodeWordInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyCodeWordChangeRes, self._onCodeWordChangeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CodeWordSelectChannel, self._onSelectChannel, self)
	removetimer(self._onSecond, self)
	self.scrollList:dispose()
end

function CodeWordView:_onClickClose()
	self:close()
end

function CodeWordView:_onGetInfoRes()
	self:_initScrollList()
end

function CodeWordView:_onCodeWordChangeRes()
	self:_initScrollList()
end

function CodeWordView:_onSelectChannel()
	self:_onClickClose()
end

function CodeWordView:_updateCell(view, cell, data, tag)
	local component = GameUtil.AddLuaOnce(cell.gameObject, CodeWordItem)

	component:init(data)
end

function CodeWordView:_clearCell(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, CodeWordItem)

	component:clear()
end

function CodeWordView:_initScrollList()
	local infoList = CodeWordModel.instance:getInfoList()
	local list = {}

	for i, v in ipairs(infoList) do
		local mo = {}

		mo.groupId = v.groupId
		mo.id = v.id
		mo.dailyTimes = v.dailyTimes

		local cfg = CodeWordConfig.instance:getWordGroupCfg(mo.groupId)

		mo.leftTime = Mathf.Max(cfg.dailyPrizeTimes - mo.dailyTimes, 0)

		table.insert(list, mo)
	end

	table.sort(list, function(a, b)
		return a.leftTime > b.leftTime
	end)
	self.scrollList:reloadData(list)
end

function CodeWordView:_onSecond()
	self:_refreshCountdown()
end

function CodeWordView:_refreshCountdown()
	local tableview = self.scrollList:getView()
	local cnt = tableview:GetVisibleCount() - 1

	for i = 0, cnt do
		local cell = tableview:GetCellByIndex(i)
		local cwItem = GameUtil.GetLua(cell.gameObject, CodeWordItem)

		if cwItem then
			cwItem:updateTime()
		end
	end
end

return CodeWordView
