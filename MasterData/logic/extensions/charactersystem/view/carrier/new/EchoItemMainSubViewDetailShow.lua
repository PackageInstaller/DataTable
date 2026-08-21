-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemMainSubViewDetailShow.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemMainSubViewDetailShow", package.seeall)

local M = class("EchoItemMainSubViewDetailShow")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self:getRegistry()

	self._go = registry:findUIElement("echo_view_copy_1863748862")
	self._txtName = registry:findUIElement("echo_view_copy_-1743119407", UIComponentType.Text)
	self._txtDesc = registry:findUIElement("echo_view_copy_-792174878", UIComponentType.Text)
	self._scroll = registry:findUIElement("echo_view_copy_1145886973", UIComponentType.ScrollRect)
	self._txtInfo = registry:findUIElement("echo_view_copy_146953030", UIComponentType.Text)
	self._txtContentTitle = registry:findUIElement("echo_view_copy_-388854791", UIComponentType.TextMeshProUGUI)
	self._txtContent = registry:findUIElement("echo_view_copy_-560571439", UIComponentType.TextMeshProUGUI)
end

function M:destroyUI()
	self.mainGO = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = nil
	end

	self._lastEchoItemId = nil
	self._handler = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	self._lastEchoItemId = nil
end

function M:setHandler(handler)
	self._handler = handler
end

function M:onPageTypChange(typ)
	local needShow = typ == EchoItemMainViewNew.SubViewType.Detail

	if needShow then
		local echoItemData = EchoItemMainController.instance:getSelectedEchoItem()
		local echoItemId = echoItemData and echoItemData:getId() or 0

		self:refreshView(echoItemId)
	end

	self:setVisible(needShow)
end

function M:refreshView(echoItemId)
	echoItemId = echoItemId or 0

	if self._lastEchoItemId and self._lastEchoItemId == echoItemId then
		return
	end

	self._lastEchoItemId = echoItemId

	local cfg = BackpackConfig.instance:getItemInfoByItemId(echoItemId)

	self._txtName.text = cfg and cfg.name or nil
	self._txtDesc.text = cfg and cfg.desc or nil
	self._txtInfo.text = cfg and cfg.useDesc or nil

	local reportStr = cfg and cfg.report or ""
	local reportTitleStr = cfg and cfg.reportTitle or ""

	self._txtContent.text = StringUtil.replaceTMPBlackBlock(reportStr)
	self._txtContentTitle.text = StringUtil.replaceTMPBlackBlock(reportTitleStr)
	self._scroll.verticalNormalizedPosition = 1
end

function M:setVisible(visible)
	goutil.setActive(self._go, visible)
end

return M
