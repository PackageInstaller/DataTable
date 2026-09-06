-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/view/VrspacebuffView.lua

module("logic.extensions.vrspace.view.VrspacebuffView", package.seeall)

local VrspacebuffView = class("VrspacebuffView", ViewComponent)

function VrspacebuffView:ctor()
	VrspacebuffView.super.ctor(self)
end

function VrspacebuffView:unbindEvents()
	VrspacebuffView.super.unbindEvents(self)
end

function VrspacebuffView:bindEvents()
	VrspacebuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function VrspacebuffView:buildUI()
	VrspacebuffView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnClose = self:getGo("btnClose")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function VrspacebuffView:onExit()
	VrspacebuffView.super.onExit(self)
	self._scrollList:dispose()
end

function VrspacebuffView:onEnter()
	VrspacebuffView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._info = params[2] or {}
	self._taskParam = params[3] or {}
	self._selectBuffLv = checknumber(self._info.selectBuffLv)

	if not self._taskParam.info then
		local taskInfo = {}

		self._signDay = checknumber(taskInfo.signInDays)

		local cfgs = SignInBuffConfig.instance:getBuffCfgsByActId(self._activityId) or {}
		local list = {}
		local temp = {}

		temp.buffLevel = 0
		temp.signInDays = 0
		temp.des = "无效果"

		table.insert(list, temp)

		for i, v in ipairs(cfgs) do
			table.insert(list, v)
		end

		self._scrollList:reloadData(list)
	end
end

function VrspacebuffView:_updateCell(view, cell, data, tag)
	local txtLvl = goutil.findChildTextComponent(cell, "txtLvl")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtLock = goutil.findChildTextComponent(cell, "txtLock")
	local checkBox = goutil.findChild(cell, "checkBox")
	local img = goutil.findChild(cell, "checkBox/img")

	txtLvl.text = langPara("%s级", data.buffLevel)
	txtDesc.text = data.des

	GameUtil.SetActive(img, data.buffLevel == self._selectBuffLv)
	GameUtil.SetActive(txtLock, data.buffLevel == self._signDay + 1)
	GameUtil.SetActive(checkBox, data.buffLevel <= self._signDay)
	GameUtil.addClickHandler(checkBox, GameUtil.handler(self._onClickBox, self, data))
end

function VrspacebuffView:_clearCell(cell)
	return
end

function VrspacebuffView:_onClickBox(data)
	self._selectBuffLv = data.buffLevel

	self._scrollList:refresh()
end

function VrspacebuffView:_onClickSure()
	VRSpaceController.instance:sendSelectBuff(self._activityId, self._selectBuffLv)
	self:close()
end

return VrspacebuffView
