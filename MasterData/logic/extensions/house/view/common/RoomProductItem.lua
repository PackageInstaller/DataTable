-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/common/RoomProductItem.lua

module("logic.extensions.house.view.common.RoomProductItem", package.seeall)

local M = class("RoomProductItem")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:OnDestroy()
	self:unbindEvents()

	self._materialCallback = nil
	self._materialHandler = nil
	self._detailCallback = nil
	self._detailHandler = nil
end

function M:_buildUI()
	self._btnMaterial = UIComponentType.ButtonAdapter(self._mainGO)
	self._btnMaterialDetail = UIComponentType.ButtonAdapter(goutil.findChild(self._mainGO, "detail/btnDetail"))
	self._imgIcon = goutil.findChildImageComponent(self._mainGO, "icon")
	self._imgProgress = goutil.findChildImageComponent(self._mainGO, "fill")
	self._txtProgress = goutil.findChildTextComponent(self._mainGO, "txtProgress")
	self._goLock = goutil.findChild(self._mainGO, "lock")
	self._goNotAdd = goutil.findChild(self._mainGO, "notAdd")

	self:bindEvents()
end

function M:bindEvents()
	self._btnMaterial:AddClickListener(self._onClickBtnMaterial, self)
	self._btnMaterialDetail:AddClickListener(self._onClickBtnMaterialDetail, self)
end

function M:unbindEvents()
	self._btnMaterial:RemoveClickListener()
	self._btnMaterialDetail:RemoveClickListener()
end

function M:setClickMaterialCallback(callback, handler)
	self._materialCallback = callback
	self._materialHandler = handler
end

function M:setClickDetailCallback(callback, handler)
	self._detailCallback = callback
	self._detailHandler = handler
end

function M:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function M:setLock(visible)
	goutil.setActive(self._goLock, visible)
end

function M:setNotAdd(visible)
	goutil.setActive(self._goNotAdd, visible)
end

function M:setIcon(itemId)
	local itemCo = BackpackConfig.instance:getItemInfoByItemId(itemId)

	IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, itemCo.icon)
end

function M:setImgProgress(progress)
	self._imgProgress.fillAmount = progress
end

function M:setTextProgerss(str)
	self._txtProgress.text = str
end

function M:_onClickBtnMaterial()
	if self._materialCallback then
		self._materialCallback(self._materialHandler, self)
	end
end

function M:_onClickBtnMaterialDetail()
	if self._detailCallback then
		self._detailCallback(self._detailHandler, self)
	end
end

return M
