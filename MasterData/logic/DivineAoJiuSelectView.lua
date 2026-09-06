-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuSelectView.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuSelectView", package.seeall)

local DivineAoJiuSelectView = class("DivineAoJiuSelectView", ViewComponent)

function DivineAoJiuSelectView:ctor()
	DivineAoJiuSelectView.super.ctor(self)
end

function DivineAoJiuSelectView:unbindEvents()
	DivineAoJiuSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineAoJiuSelectView:bindEvents()
	DivineAoJiuSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineAoJiuSelectView:buildUI()
	DivineAoJiuSelectView.super.buildUI(self)

	self._btnSure = self:getGo("typeSelect/btnSure")
	self._btnClose = self:getGo("typeSelect/btnClose")
	self._typeTableView = self:getGo("typeSelect/typeTableView")
	self._typeTableCell = self:getGo("typeSelect/typeTableView/typeTableCell")
	self._typeTableList = ScrollerList.create(self._typeTableView, self._typeTableCell, GameUtil.handler(self._updateTypeCell, self), GameUtil.handler(self._clearTypeCell, self))
	self._ownTableCell = self:getGo("typeSelect/ownTableView/ownTableCell")
	self._ownTableView = self:getGo("typeSelect/ownTableView")
	self._ownTableList = ScrollerList.create(self._ownTableView, self._ownTableCell, GameUtil.handler(self._updateOwnCell, self), GameUtil.handler(self._clearOwnCell, self))
end

function DivineAoJiuSelectView:onExit()
	DivineAoJiuSelectView.super.onExit(self)
end

function DivineAoJiuSelectView:onEnter()
	DivineAoJiuSelectView.super.onEnter(self)

	self._fmtMo = self:getFirstParam()

	self:_refreshView()
end

function DivineAoJiuSelectView:_refreshView()
	local activityId = self._fmtMo.activityId
	local stageId = self._fmtMo.stageId
	local stageCfg = DivineAoJiuConfig.instance:getExtremeStageCfg(activityId, stageId)

	self._typeTableList:reloadData(stageCfg.buffIds)

	local activityCfg = DivineAoJiuConfig.instance:getActivityCfg(activityId)
	local passBufflist = {}

	for i, v in ipairs(activityCfg.extremeClgBuffTypeNeed) do
		table.insert(passBufflist, {
			buffType = i,
			needCount = v
		})
	end

	self._ownTableList:reloadData(passBufflist)
end

function DivineAoJiuSelectView:_updateTypeCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtType = goutil.findChildTextComponent(go, "txtType")
	local select = goutil.findChild(go, "select")
	local selectBg = goutil.findChild(go, "selectBg")
	local btn = goutil.findChild(go, "btn")
	local imgTypeChange = goutil.findChildComponent(go, "imgType", ComponentType.UIImageSpriteChange)
	local buffCfg = DivineAoJiuConfig.instance:getBuffCfg(self._fmtMo.activityId, data)

	txtDesc.text = buffCfg.desc
	txtType.text = DivineAoJiuConfig.instance:getBuffName(self._fmtMo.activityId, buffCfg.buffType)

	imgTypeChange:SetState(buffCfg.buffType - 1)
	GameUtil.SetActive(selectBg, data == self._fmtMo.selectBuffId)
	GameUtil.SetActive(select, data == self._fmtMo.selectBuffId)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickType(data)
	end)
end

function DivineAoJiuSelectView:_clearTypeCell(cell)
	return
end

function DivineAoJiuSelectView:_updateOwnCell(view, cell, data, tag)
	local go = cell.gameObject
	local txt = goutil.findChildTextComponent(go, "txt")
	local imgTypeChange = goutil.findChildComponent(go, "img", ComponentType.UIImageSpriteChange)
	local name = DivineAoJiuConfig.instance:getBuffName(self._fmtMo.activityId, data.buffType)
	local curCount = DivineAoJiuModel.instance:getBuffTypeCount(self._fmtMo.activityId, data.buffType)

	imgTypeChange:SetState(data.buffType - 1)

	txt.text = langPara("%s：%d/%d", name, curCount, data.needCount)
end

function DivineAoJiuSelectView:_clearOwnCell(cell)
	return
end

function DivineAoJiuSelectView:_onClickType(buffId)
	self._fmtMo.selectBuffId = buffId

	self:_refreshView()
	GlobalDispatcher:dispatch(GlobalNotify.DivineAoJiuClgSelectBuff, buffId)
end

return DivineAoJiuSelectView
