-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/cg/HandbookCGItemCell.lua

module("logic.extensions.playerinfo.view.handbook.cg.HandbookCGItemCell", package.seeall)

local M = class("HandbookCGItemCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
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

	self._imgCg = registry:findUIElement("handbook_cg_item_874995039", UIComponentType.Image)
	self._goEmptyMark = registry:findUIElement("handbook_cg_item_1490074061")
	self._txtCgName = registry:findUIElement("handbook_cg_item_2118165283", UIComponentType.Text)
	self._defaultCgName = self._txtCgName.text
	self._goNewSignMark = registry:findUIElement("handbook_cg_item_271463519")
	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("handbook_cg_item_2111546667"))
end

function M:destroyUI()
	self:setHandler(nil)

	self.mainGO = nil
	self._imgCg = nil
	self._goEmptyMark = nil
	self._txtCgName = nil
	self._goNewSignMark = nil
	self._btnClick = nil

	if self._registry then
		self._registry:cleanRegistry()

		self._registry = false
	end
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self:setHandler(nil)
	self._btnClick:RemoveClickListener()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:getHandler()
	return self._handler
end

function M:getRegistry()
	return self._registry
end

function M:_onClickSelf()
	local handler = self:getHandler()

	if handler then
		handler:onCellClick(self)
	end
end

function M:setData(cfgData)
	local isLock = not GalleryModel.instance:getIsUnLock(GameEnum.UnlockTypeEnum.CG, cfgData.id)

	if self:getTyp() ~= cfgData.typ or self:getId() ~= cfgData.id then
		if not isLock then
			self:_updateCGShow(cfgData.icon)
		end
	elseif not isLock and self:getIsLock() ~= isLock then
		self:_updateCGShow(cfgData.icon)
	end

	self._typ = cfgData.typ
	self._id = cfgData.id
	self._txtCgName.text = isLock and self._defaultCgName or cfgData.name

	self:setLock(isLock)
	self:setNewMark(GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.CG, self._id))
end

function M:_updateCGShow(res)
	IconLoader.setSprite(self._imgCg, IconType.HandbookCG, res)
end

function M:setLock(lock)
	self._isLock = lock

	goutil.setActive(self._goEmptyMark, lock)
	goutil.setActive(self._imgCg.gameObject, not lock)
end

function M:getIsLock()
	return self._isLock
end

function M:setNewMark(show)
	self._isNew = show

	goutil.setActive(self._goNewSignMark, show)
end

function M:getIsNew()
	return self._isNew
end

function M:getId()
	return self._id or -1
end

function M:getTyp()
	return self._typ or -1
end

return M
