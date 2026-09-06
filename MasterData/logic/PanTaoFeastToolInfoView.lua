-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastToolInfoView.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastToolInfoView", package.seeall)

local PanTaoFeastToolInfoView = class("PanTaoFeastToolInfoView", ViewComponent)

function PanTaoFeastToolInfoView:ctor()
	PanTaoFeastToolInfoView.super.ctor(self)
end

function PanTaoFeastToolInfoView:unbindEvents()
	PanTaoFeastToolInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PanTaoFeastToolInfoView:bindEvents()
	PanTaoFeastToolInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PanTaoFeastToolInfoView:buildUI()
	PanTaoFeastToolInfoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtDesc = self:getTxt("txtDesc")

	local goCell = self:getGo("tableview/tablecell")
	local goTab = self:getGo("tableview")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local goCellProduce = self:getGo("tableviewproduce/tablecell")
	local goTabProduce = self:getGo("tableviewproduce")

	self._tableViewProduce = ScrollerList.create(goTabProduce, goCellProduce, GameUtil.handler(self._updateCellProduce, self), GameUtil.handler(self._clearCellProduce, self))
end

function PanTaoFeastToolInfoView:onExit()
	PanTaoFeastToolInfoView.super.onExit(self)
	self._tableView:dispose()
	self._tableViewProduce:dispose()

	self._curElementId = 0
end

function PanTaoFeastToolInfoView:onEnter()
	PanTaoFeastToolInfoView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = PanTaoFeastController.instance:getDefaultActivityId() or 0
	end

	self:_switchCurElementId(checknumber(params[2]))

	local isVaild = self._curElementId ~= 0

	if not isVaild then
		TipsFacade.instance:openCommonTips(lang("传参数据异常"))
		self:close()

		return
	end

	self:_updateUIByInfo()
end

function PanTaoFeastToolInfoView:_updateUIByCfg()
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

	self._produceElementMap = PanTaoFeastConfig.instance:getProduceDropCfgsByWorkshop(self._activityId, self._curElementId) or {}
	self._produceElementList = {}

	for _, dropCfg in pairs(self._produceElementMap) do
		table.insert(self._produceElementList, dropCfg)
	end

	table.sort(self._produceElementList, function(a, b)
		return a.dropElementId < b.dropElementId
	end)
	self._tableViewProduce:reloadData(self._produceElementList)
end

function PanTaoFeastToolInfoView:_updateUIByInfo()
	return
end

function PanTaoFeastToolInfoView:_updateCell(view, cell, data)
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
		else
			uGuiUtil.clearImage(icon)
		end

		local isSelect = self._curElementId == cfg.elementId

		goutil.setActive(markSelect, isSelect)

		local btn = goutil.findChild(go, "btn")

		GameUtil.rmClickHandler(btn)
		GameUtil.addClickHandler(btn, function()
			self:_switchCurElementId(cfg.elementId)
		end, self)
	end
end

function PanTaoFeastToolInfoView:_clearCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)

	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function PanTaoFeastToolInfoView:_updateCellProduce(view, cell, data)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")
	local elementId = checknumber(data.dropElementId)
	local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementId)

	uGuiUtil.clearImage(icon)

	if not GameUtil.isEmptyString(iconPath) then
		local spriteName = GameUrl.getItemIconUrl(iconPath)

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
	end

	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		PanTaoFeastController.instance:forcePushView(ViewName.PanTaoFeastMatInfoView, self._activityId, elementId)
	end, self)
end

function PanTaoFeastToolInfoView:_clearCellProduce(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)

	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function PanTaoFeastToolInfoView:_switchCurElementId(elementId)
	if self._curElementId == elementId then
		return
	end

	self._curElementId = elementId

	self:_updateUIByCfg()
end

return PanTaoFeastToolInfoView
