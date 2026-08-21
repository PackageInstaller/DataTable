-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureSchemeItem.lua

module("logic.extensions.manufacture.view.ManufactureSchemeItem", package.seeall)

local M = class("ManufactureSchemeItem")

function M:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:_buildUI()
	self._goNormal = goutil.findChild(self._mainGO, "normal")
	self._goLock = goutil.findChild(self._mainGO, "lock")
	self._txtLock = goutil.findChildTextComponent(self._goLock, "txtLock")

	local clickGO = goutil.findChild(self._goNormal, "Image1")

	self._clickTrigger = Astral.UIClickTrigger.Get(clickGO)

	local materialGO = goutil.findChild(self._goNormal, "cell/backpack_item")

	self._materialItem = Astral.LuaComponentContainer.Add(materialGO, ItemCell)

	self._materialItem:getComponent("normal"):setClickListener(self._onClickMaterialItem, self)
	self._materialItem:getComponent("normal"):setOnceLongPressListener(self._onLongPressMaterialItem, self)

	self._txtCostTime = goutil.findChildTextComponent(self._goNormal, "txtTime")
	self._txtMaterialName = goutil.findChildTextComponent(self._goNormal, "txtName")
	self._txtCostProductNum = goutil.findChildTextComponent(self._goNormal, "txtNum1")
	self._txtCostStoreNum = goutil.findChildTextComponent(self._goNormal, "txtNum2")
	self._goDoing = goutil.findChild(self._goNormal, "doing")

	self:bindEvents()
end

function M:bindEvents()
	self._clickTrigger:AddClickListener(self._onClickSelf, self)
end

function M:unbindEvents()
	self._clickTrigger:RemoveClickListener()
end

function M:updateData(schemeCO, plantMO)
	self._schemeCO = schemeCO
	self._plantMO = plantMO

	local currLv = ManufactureModel.instance:getLv()
	local unLockLv = schemeCO.unlockLevel

	goutil.setActive(self._goNormal, true)
	goutil.setActive(self._goLock, currLv < unLockLv)

	self._txtLock.text = langF("tip_manufacturer_level_s_unlock", unLockLv)

	local itemData = ItemData.New({
		itemId = schemeCO.id
	})

	self._materialItem:updateData(itemData)

	self._txtMaterialName.text = itemData:getName()

	local productivity = plantMO:getProductSpeed()
	local minCount = MathUtil.preciseDecimal(schemeCO.need / productivity, 2)
	local costTime = math.floor(minCount * 60)

	self._txtCostTime.text = TimeUtil.instance:numberToTime(costTime, "h:m:s")
	self._txtCostProductNum.text = schemeCO.need
	self._txtCostStoreNum.text = schemeCO.store

	self._materialItem:getComponent("num"):setVisible(false)
	goutil.setActive(self._goDoing, schemeCO.id == plantMO:getSchemeId())
end

function M:getCostTimeStr()
	return self._txtCostTime.text
end

function M:_onClickSelf()
	ViewMgr.instance:open(ViewName.ManufactureSchemeEnsure, self._schemeCO, self._plantMO)
end

function M:_onClickMaterialItem()
	ViewMgr.instance:open(ViewName.ManufactureSchemeEnsure, self._schemeCO, self._plantMO)
end

function M:_onLongPressMaterialItem()
	local itemData = ItemData.New({
		itemId = self._schemeCO.id
	})
	local data = ToolTipsUtil.createItemTipsData(itemData, self._mainGO)

	ToolTipsMgr.showTips(data.viewName, data)
end

return M
