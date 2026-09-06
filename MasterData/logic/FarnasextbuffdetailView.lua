-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/view/FarnasextbuffdetailView.lua

module("logic.extensions.farnas.view.FarnasextbuffdetailView", package.seeall)

local FarnasextbuffdetailView = class("FarnasextbuffdetailView", ViewComponent)

function FarnasextbuffdetailView:ctor()
	FarnasextbuffdetailView.super.ctor(self)
end

function FarnasextbuffdetailView:unbindEvents()
	FarnasextbuffdetailView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function FarnasextbuffdetailView:bindEvents()
	FarnasextbuffdetailView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function FarnasextbuffdetailView:buildUI()
	FarnasextbuffdetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtLockNum = self:getTxt("txtLockNum")
	self._slider = self:getSlider("tableview/Viewport/Content/slider")
end

function FarnasextbuffdetailView:onExit()
	FarnasextbuffdetailView.super.onExit(self)
	self._scrollerList:dispose()
end

function FarnasextbuffdetailView:onEnter()
	FarnasextbuffdetailView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	self:_updateUI()
end

function FarnasextbuffdetailView:_onClickbtnClose()
	self:close()
end

function FarnasextbuffdetailView:_updateUI()
	local lockNum = FarnasModel.instance:getAllLockNums(self._activityId)

	self._txtLockNum.text = lockNum

	local temps = FarnasConfig.instance:getExtBuffCfgs(self._activityId)
	local cfgs = table.values(temps)

	table.sort(cfgs, function(a, b)
		return a.lockRaceCount < b.lockRaceCount
	end)

	local scoreList = FarnasConfig.instance:getExtBuffCfgNumList(self._activityId)

	self._scrollerList:reloadData(cfgs)
	self._scrollerList:updateUnderSlider(self._slider, lockNum, scoreList)
end

function FarnasextbuffdetailView:_updateCell(view, cell, buffCfg, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	txtNum.text = buffCfg.lockRaceCount
	txtDesc.text = buffCfg.desc
end

function FarnasextbuffdetailView:_clearCell(cell)
	return
end

return FarnasextbuffdetailView
