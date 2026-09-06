-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/domaincultivate/view/DomainCultivateDetailView.lua

module("logic.extensions.domaincultivate.view.DomainCultivateDetailView", package.seeall)

local DomainCultivateDetailView = class("DomainCultivateDetailView", ViewComponent)

function DomainCultivateDetailView:ctor()
	DomainCultivateDetailView.super.ctor(self)
end

function DomainCultivateDetailView:unbindEvents()
	DomainCultivateDetailView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DomainCultivateDetailView:bindEvents()
	DomainCultivateDetailView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function DomainCultivateDetailView:buildUI()
	DomainCultivateDetailView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._cell = self:getGo("cell")

	self._cell:SetActive(false)

	self._goContent = self:getGo("tableview/Viewport/Content")
	self._contentSizeFitter = self._goContent:GetComponent("ContentSizeFitter")
end

function DomainCultivateDetailView:onExit()
	DomainCultivateDetailView.super.onExit(self)
end

function DomainCultivateDetailView:onEnter()
	DomainCultivateDetailView.super.onEnter(self)

	self._petId = self:getFirstParam()
	self._petMo = BagPetsController.instance:getPet(self._petId)
	self._kamuiInfos = self._petMo:getKamuiInfos()

	self:_refresh()
end

function DomainCultivateDetailView:_refresh()
	self._cells = self._cells or {}

	for i = #self._cells, #self._kamuiInfos - 1 do
		local cell = goutil.cloneAndSetParent(self._cell, self._goContent.transform)

		goutil.setActive(cell, true)
		table.insert(self._cells, cell)
	end

	for i = #self._cells, #self._kamuiInfos + 1, -1 do
		self:_destroyCell(self._cells[i])
		table.remove(self._cells, i)
	end

	for i = 1, #self._cells do
		self:_setCell(self._cells[i], self._kamuiInfos[i])
	end

	settimer(0.005, self._refreshLayout, self, false)
end

function DomainCultivateDetailView:_setCell(cell, data, isOnForm)
	self:_clearCell(cell)

	if data == nil then
		return
	end

	local id = data.kamuiId
	local kamuiCfg = DomainCultivateConfig.instance:getDefineCfg(id)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell, "name/txt")
	local img = goutil.findChild(cell, "Image")

	txtDesc.text = kamuiCfg.desc
	txtName.text = kamuiCfg.name

	uGuiUtil.setSpriteToImage(img, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(kamuiCfg.icon))
end

function DomainCultivateDetailView:_destroyCell(cell)
	self:_clearCell(cell)
	goutil.destroy(cell)
end

function DomainCultivateDetailView:_clearCell(cell)
	uGuiUtil.clearImage(goutil.findChild(cell, "Image"))
end

function DomainCultivateDetailView:_refreshLayout()
	if self._cells then
		for _, v in ipairs(self._cells) do
			self:_refreshCellLayout(v)
		end
	end

	self._contentSizeFitter.enabled = true

	settimer(0.005, self._finishLayout, self, false)
end

function DomainCultivateDetailView:_refreshCellLayout(cell)
	local goTxtDesc = goutil.findChild(cell, "txtDesc")

	goTxtDesc:GetComponent("ContentSizeFitter").enabled = true
	cell:GetComponent("ContentSizeFitter").enabled = true
end

function DomainCultivateDetailView:_finishLayout()
	if self._bondCells then
		for _, v in ipairs(self._bondCells) do
			self:_finishCellLayout(v)
		end
	end
end

function DomainCultivateDetailView:_finishCellLayout(cell, isFirst)
	local goTxtDesc = goutil.findChild(cell, "txtDesc")

	goTxtDesc:GetComponent("ContentSizeFitter").enabled = false
	cell:GetComponent("ContentSizeFitter").enabled = false
end

return DomainCultivateDetailView
