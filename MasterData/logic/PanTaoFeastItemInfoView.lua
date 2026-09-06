-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastItemInfoView.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastItemInfoView", package.seeall)

local PanTaoFeastItemInfoView = class("PanTaoFeastItemInfoView", ViewComponent)

function PanTaoFeastItemInfoView:ctor()
	PanTaoFeastItemInfoView.super.ctor(self)
end

function PanTaoFeastItemInfoView:unbindEvents()
	PanTaoFeastItemInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PanTaoFeastItemInfoView:bindEvents()
	PanTaoFeastItemInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PanTaoFeastItemInfoView:buildUI()
	PanTaoFeastItemInfoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtDesc = self:getTxt("txtDesc")

	local goCell = self:getGo("tableview/tablecell")
	local goTab = self:getGo("tableview")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function PanTaoFeastItemInfoView:onExit()
	PanTaoFeastItemInfoView.super.onExit(self)
	self._tableView:dispose()
end

function PanTaoFeastItemInfoView:onEnter()
	PanTaoFeastItemInfoView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = PanTaoFeastController.instance:getDefaultActivityId() or 0
	end

	self._curElementId = checknumber(params[2])

	local isVaild = self._curElementId ~= 0

	if not isVaild then
		TipsFacade.instance:openCommonTips(lang("传参数据异常"))
		self:close()

		return
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
end

function PanTaoFeastItemInfoView:_updateUIByCfg()
	self._showDataList = PanTaoFeastConfig.instance:getElementChainListByElementId(self._activityId, self._curElementId) or {}

	self._tableView:reloadData(self._showDataList)

	local elementNode = PanTaoFeastConfig.instance:getElementChainNodeByElementId(self._activityId, self._curElementId)

	if elementNode then
		if elementNode.cfg then
			if not elementNode.cfg.showDesc then
				self._txtDesc.text = ""
			end
		end
	else
		self._txtDesc.text = ""
	end
end

function PanTaoFeastItemInfoView:_updateUIByInfo()
	return
end

function PanTaoFeastItemInfoView:_updateCell(view, cell, data)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local markSelect = goutil.findChild(go, "markSelect")
	local markNext = goutil.findChild(go, "markNext")

	if data.next then
		local isExistNext = data.next.cfg ~= nil

		goutil.setActive(markNext, isExistNext)

		local cfg = data.cfg

		if cfg then
			local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, cfg.elementId)

			if not GameUtil.isEmptyString(iconPath) then
				local spriteName = GameUrl.getItemIconUrl(iconPath)

				uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
			end

			local isSelect = self._curElementId == cfg.elementId

			goutil.setActive(markSelect, isSelect)
		else
			uGuiUtil.clearImage(icon)
		end
	end
end

function PanTaoFeastItemInfoView:_clearCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)
end

return PanTaoFeastItemInfoView
