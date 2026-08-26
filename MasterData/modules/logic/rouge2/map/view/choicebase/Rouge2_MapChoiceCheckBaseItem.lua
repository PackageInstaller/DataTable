-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MapChoiceCheckBaseItem.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MapChoiceCheckBaseItem", package.seeall)

local Rouge2_MapChoiceCheckBaseItem = class("Rouge2_MapChoiceCheckBaseItem", LuaCompBase)

function Rouge2_MapChoiceCheckBaseItem.Get(go, itemType)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_MapChoiceCheckBaseItem, itemType)
end

function Rouge2_MapChoiceCheckBaseItem:ctor(itemType)
	self._itemType = itemType or Rouge2_MapEnum.ChoiceCheckItemType.Normal
end

function Rouge2_MapChoiceCheckBaseItem:init(go)
	self.go = go
	self._isCheck = false
	self._isSelect = false
	self._isLoadCoreDone = false

	self:loadCheckCoreItem()
end

function Rouge2_MapChoiceCheckBaseItem:loadCheckCoreItem()
	local loader = PrefabInstantiate.Create(self.go)

	loader:startLoad(Rouge2_Enum.ResPath.ChoiceCheckItem, self._onLoadCheckCoreItemDone, self)
end

function Rouge2_MapChoiceCheckBaseItem:_onLoadCheckCoreItemDone(loader)
	self._goCheck = loader:getInstGO()
	self._goRoot1 = gohelper.findChild(self._goCheck, "#go_Root1")
	self._imageAttribute1 = gohelper.findChildImage(self._goRoot1, "#image_Attribute")
	self._imageIcon1 = gohelper.findChildImage(self._goRoot1, "#image_Icon")
	self._txtValue1 = gohelper.findChildText(self._goRoot1, "#txt_Value")
	self._goWarning1 = gohelper.findChild(self._goRoot1, "#txt_Value/#go_warning")
	self._goRoot2 = gohelper.findChild(self._goCheck, "#go_Root2")
	self._imageAttribute2 = gohelper.findChildImage(self._goRoot2, "#image_Attribute")
	self._imageIcon2 = gohelper.findChildImage(self._goRoot2, "#image_Icon")
	self._txtValue2 = gohelper.findChildText(self._goRoot2, "#txt_Value")
	self._goWarning2 = gohelper.findChild(self._goRoot2, "#txt_Value/#go_warning")
	self._isLoadCoreDone = true

	self:refreshUI()
end

function Rouge2_MapChoiceCheckBaseItem:updateInfo(attrType, checkRate)
	self:initInfo(attrType, checkRate)
	self:refreshUI()
end

function Rouge2_MapChoiceCheckBaseItem:initInfo(attrType, checkRate)
	self._checkRate = checkRate
	self._attrType = attrType
end

function Rouge2_MapChoiceCheckBaseItem:refreshUI()
	if not self._isLoadCoreDone then
		return
	end

	gohelper.setActive(self.go, self._isCheck)

	if not self._isCheck then
		return
	end

	gohelper.setActive(self._goRoot1, self._itemType == Rouge2_MapEnum.ChoiceCheckItemType.Normal)
	gohelper.setActive(self._goRoot2, self._itemType == Rouge2_MapEnum.ChoiceCheckItemType.Explore)

	local rateStr = Rouge2_MapAttrCheckHelper.formatCheckRate(self._checkRate)
	local iconName = self._isSelect and "rouge2_mapchoicecheckitem_bg2" or "rouge2_mapchoicecheckitem_bg1"
	local warningRate = tonumber(lua_rouge2_const.configDict[Rouge2_MapEnum.ConstKey.CheckRateWarning].value)
	local isWaring = warningRate > self._checkRate

	if self._itemType == Rouge2_MapEnum.ChoiceCheckItemType.Normal then
		self._txtValue1.text = rateStr

		gohelper.setActive(self._goWarning1, isWaring)
		UISpriteSetMgr.instance:setRouge6Sprite(self._imageIcon1, iconName)
		Rouge2_IconHelper.setAttributeIcon(self._attrType, self._imageAttribute1)
	elseif self._itemType == Rouge2_MapEnum.ChoiceCheckItemType.Explore then
		self._txtValue2.text = rateStr

		gohelper.setActive(self._goWarning2, isWaring)
		UISpriteSetMgr.instance:setRouge6Sprite(self._imageIcon2, iconName)
		Rouge2_IconHelper.setAttributeIcon(self._attrType, self._imageAttribute2)
	else
		logError(string.format("肉鸽未定义选项检定显示类型 itemType = %s", self._itemType))
	end
end

function Rouge2_MapChoiceCheckBaseItem:onSelect(isSelect)
	self._isSelect = isSelect

	self:refreshUI()
end

function Rouge2_MapChoiceCheckBaseItem:refreshIcon()
	return
end

return Rouge2_MapChoiceCheckBaseItem
