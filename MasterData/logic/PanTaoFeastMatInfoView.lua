-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastMatInfoView.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastMatInfoView", package.seeall)

local PanTaoFeastMatInfoView = class("PanTaoFeastMatInfoView", ViewComponent)

function PanTaoFeastMatInfoView:ctor()
	PanTaoFeastMatInfoView.super.ctor(self)
end

function PanTaoFeastMatInfoView:unbindEvents()
	PanTaoFeastMatInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShowWorkShop)
end

function PanTaoFeastMatInfoView:bindEvents()
	PanTaoFeastMatInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnShowWorkShop, self._onClickShowWorkShop, self)
end

function PanTaoFeastMatInfoView:buildUI()
	PanTaoFeastMatInfoView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local goCell = self:getGo("tableview/tablecell")
	local goTab = self:getGo("tableview")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtNameWorkshop = self:getTxt("txtNameWorkshop")
	self._txtName = self:getTxt("txtName")
	self._showIcon = self:getGo("showIcon")
	self._btnShowWorkShop = self:getGo("btnShowWorkShop")
end

function PanTaoFeastMatInfoView:onExit()
	PanTaoFeastMatInfoView.super.onExit(self)

	self._curElementId = 0
	self._curShowWorkShopId = 0

	self._tableView:dispose()
	uGuiUtil.clearImage(self._showIcon)
end

function PanTaoFeastMatInfoView:onEnter()
	PanTaoFeastMatInfoView.super.onEnter(self)

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

function PanTaoFeastMatInfoView:_updateUIByCfg()
	self._showDataList = PanTaoFeastConfig.instance:getElementChainListByElementId(self._activityId, self._curElementId) or {}

	self._tableView:reloadData(self._showDataList)

	local elementNode = PanTaoFeastConfig.instance:getElementChainNodeByElementId(self._activityId, self._curElementId)

	if elementNode then
		if elementNode.cfg then
			if not elementNode.cfg.name then
				self._txtName.text = ""
			end
		end
	else
		self._txtName.text = ""
	end

	self._workshopIds = PanTaoFeastConfig.instance:getProduceDropToolIdsByElementId(self._activityId, self._curElementId) or {}
	self._curShowWorkShopId = self._workshopIds[1] or 0

	for i, workshopId in ipairs(self._workshopIds) do
		local isUnlock = PanTaoFeastModel.instance:hasGainBookPrize(self._activityId, workshopId)

		if not isUnlock then
			break
		end

		self._curShowWorkShopId = workshopId
	end

	local workshopNode = PanTaoFeastConfig.instance:getElementChainNodeByElementId(self._activityId, self._curShowWorkShopId)

	uGuiUtil.clearImage(self._showIcon)

	if workshopNode then
		if workshopNode.cfg then
			if not workshopNode.cfg.name then
				self._txtNameWorkshop.text = ""

				local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, self._curShowWorkShopId)

				if not GameUtil.isEmptyString(iconPath) then
					local spriteName = GameUrl.getItemIconUrl(iconPath)

					uGuiUtil.setSpriteToImage(self._showIcon, uGuiUtil.SpriteType.BigBg, spriteName)
				end
			end
		end
	else
		self._txtNameWorkshop.text = ""
	end
end

function PanTaoFeastMatInfoView:_updateUIByInfo()
	return
end

function PanTaoFeastMatInfoView:_updateCell(view, cell, data)
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

function PanTaoFeastMatInfoView:_clearCell(cell)
	local go = cell.gameObject
	local icon = goutil.findChild(go, "icon")

	uGuiUtil.clearImage(icon)

	local btn = goutil.findChild(go, "btn")

	GameUtil.rmClickHandler(btn)
end

function PanTaoFeastMatInfoView:_switchCurElementId(elementId)
	if self._curElementId == elementId then
		return
	end

	self._curElementId = elementId

	self:_updateUIByCfg()
end

function PanTaoFeastMatInfoView:_onClickShowWorkShop()
	if self._curShowWorkShopId == 0 then
		return
	end

	PanTaoFeastController.instance:forcePushView(ViewName.PanTaoFeastToolInfoView, self._activityId, self._curShowWorkShopId)
end

return PanTaoFeastMatInfoView
