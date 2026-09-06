-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/view/FormTeamFetterView.lua

module("logic.extensions.formteam.view.FormTeamFetterView", package.seeall)

local FormTeamFetterView = class("FormTeamFetterView", ViewComponent)

function FormTeamFetterView:buildUI()
	FormTeamFetterView.super.buildUI(self)

	self._goCell = self:getGo("cell")
	self._goTableview = self:getGo("tableview")
	self._tableview = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._btnRule = self:getGo("btnRule")
	self._txtCurActive = self:getTxt("curActive/txt")
	self._goEmpty = self:getGo("empty")
end

function FormTeamFetterView:bindEvents()
	FormTeamFetterView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function FormTeamFetterView:unbindEvents()
	FormTeamFetterView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
end

function FormTeamFetterView:onEnter()
	FormTeamFetterView.super.onEnter(self)
	self:_refreshView()
end

function FormTeamFetterView:onExit()
	FormTeamFetterView.super.onExit(self)
	self._tableview:dispose()
end

function FormTeamFetterView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local headInfo = data.headInfo

	HeadItemController.instance:setHeadCellByInfo(cell.headItem, headInfo)

	cell.txtName.text = headInfo.userName
	cell.txtFetter.text = data.curFetter

	local value = self:_getBuffValue(data.curFetter)

	if value > 0 then
		cell.txtCurActive.text = "激活效果：" .. langPara(self._showBuffDesc, value)
	end
end

function FormTeamFetterView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.headItem = goutil.findChild(cell.go, "headItem")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtCurActive = goutil.findChildTextComponent(cell.go, "curActive/txt")
	cell.txtFetter = goutil.findChildTextComponent(cell.go, "txtFetter/txt")
	cell.txtCurActive.text = lang("激活效果：无激活效果")
	cell.txtFetter.text = 0

	HeadItemController.instance:resetHeadCell(cell.headItem)

	return cell
end

function FormTeamFetterView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "friendbattle_rule")
end

function FormTeamFetterView:_refreshView()
	local curTeamInfo = FormTeamModel.instance:getCurTeamInfo()

	self._curDataList = curTeamInfo:getCurFetterInfoList()

	local teamCfg, typeCfg = curTeamInfo:getTeamCfgAndTypeCfg()

	self._buffCfgs = typeCfg and FormTeamConfig.instance:getFetterBuffById(typeCfg.buffPlanId)
	self._showBuffDesc = self._buffCfgs and self._buffCfgs[1] and self._buffCfgs[1].desc
	self._buffLimit = self._buffCfgs and self._buffCfgs[1] and self._buffCfgs[1].valueLimit

	if self._buffCfgs then
		self._tableview:reloadData(self._curDataList)
	end

	goutil.setActive(self._goEmpty, #self._curDataList <= 0)

	self._txtCurActive.text = self:_getCurShowDesc()
end

function FormTeamFetterView:_getBuffValue(fetter)
	local value = 0

	if self._buffCfgs then
		for i, v in ipairs(self._buffCfgs) do
			if fetter <= v.fetter then
				return value
			end

			value = v.showValue
		end
	end

	return value
end

function FormTeamFetterView:_getCurShowDesc()
	local desc = lang("无激活效果")
	local showValue = 0

	if self._buffCfgs and self._curDataList then
		for k, v in ipairs(self._curDataList) do
			showValue = showValue + self:_getBuffValue(v.curFetter)
		end

		showValue = math.min(showValue, self._buffLimit)
	end

	return (showValue > 0 or nil) and langPara(self._showBuffDesc, showValue)
end

return FormTeamFetterView
