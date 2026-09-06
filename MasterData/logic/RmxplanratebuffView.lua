-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanratebuffView.lua

module("logic.extensions.richmanxplan.view.RmxplanratebuffView", package.seeall)

local RmxplanratebuffView = class("RmxplanratebuffView", ViewComponent)

function RmxplanratebuffView:ctor()
	RmxplanratebuffView.super.ctor(self)
end

function RmxplanratebuffView:unbindEvents()
	RmxplanratebuffView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function RmxplanratebuffView:bindEvents()
	RmxplanratebuffView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function RmxplanratebuffView:buildUI()
	RmxplanratebuffView.super.buildUI(self)

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getBtn("btnClose")
	self._goEmpty = self:getGo("empty")
end

function RmxplanratebuffView:onExit()
	RmxplanratebuffView.super.onExit(self)
	self._scrollerList:dispose()
end

function RmxplanratebuffView:onEnter()
	RmxplanratebuffView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._info = RichmanxplanModel.instance:getInfo(self._activityId)

	self:_updateUI()
end

function RmxplanratebuffView:_onClickbtnClose()
	self:close()
end

function RmxplanratebuffView:_updateUI()
	self:_updateData()
	self:_updateTable()
end

function RmxplanratebuffView:_updateData()
	self._datas = {}

	for i, v in ipairs(self._info.buffs or {}) do
		if v.leftTimes > 0 then
			table.insert(self._datas, {
				buff = true,
				value = v
			})
		end
	end

	for i, v in ipairs(self._info.lottery or {}) do
		if v.leftTimes > 0 then
			table.insert(self._datas, {
				lottery = true,
				value = v
			})
		end
	end
end

function RmxplanratebuffView:_updateTable()
	self._scrollerList:reloadData(self._datas)
	goutil.setActive(self._goEmpty, #self._datas <= 0)
end

function RmxplanratebuffView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtLeftTime = goutil.findChildTextComponent(cell.gameObject, "txtLeftTime")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local buffIconChange = goutil.findChild(cell.gameObject, "buffIcon"):GetComponent(ComponentType.UIImageSpriteChange)

	txtLeftTime.text = string.format("剩余%s次投骰", data.value.leftTimes)

	if data.buff then
		local buffCfg = RichmanxplanConfig.instance:getBuffCfg(self._activityId, data.value.buffId)

		txtName.text = buffCfg.name
		txtDesc.text = buffCfg.effectDesc

		buffIconChange:SetState(0)
	elseif data.lottery then
		local t = {}

		for i, v in ipairs(data.value.selectNumber) do
			table.insert(t, v)
		end

		txtName.text = "彩票开奖"
		txtDesc.text = string.format("当前一购买数字：%s", table.concat(t, "、"))

		buffIconChange:SetState(1)
	end
end

function RmxplanratebuffView:_clearCell(cell)
	return
end

return RmxplanratebuffView
