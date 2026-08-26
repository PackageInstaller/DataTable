-- chunkname: @modules/logic/rouge2/map/view/dice/Rouge2_MapDiceFixItem.lua

module("modules.logic.rouge2.map.view.dice.Rouge2_MapDiceFixItem", package.seeall)

local Rouge2_MapDiceFixItem = class("Rouge2_MapDiceFixItem", LuaCompBase)

function Rouge2_MapDiceFixItem:init(go)
	self.go = go
	self.txtFixValue = gohelper.findChildText(self.go, "txt_FixValue")
	self.txtAttrName = gohelper.findChildText(self.go, "go_Attr/txt_AttrName")
	self.imageAttrIcon = gohelper.findChildImage(self.go, "go_Attr/image_AttrIcon")
	self.goAttr = gohelper.findChild(self.go, "go_Attr")
	self.goItem = gohelper.findChild(self.go, "go_Item")
	self.simageItemIcon = gohelper.findChildSingleImage(self.go, "go_Item/simage_ItemIcon")
	self.txtItemName = gohelper.findChildText(self.go, "go_Item/txt_ItemName")
	self.done = false
	self.fixValue = 0
	self.animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)
end

function Rouge2_MapDiceFixItem:addEventListeners()
	return
end

function Rouge2_MapDiceFixItem:removeEventListeners()
	return
end

function Rouge2_MapDiceFixItem:onUpdateMO(fixInfo)
	local fixType = fixInfo.fixType
	local fixValue = fixInfo.fixValue
	local fixAttrId = fixInfo.fixAttrId

	self.done = false
	self.fixValue = fixValue
	self.txtFixValue.text = string.format("+%s", fixValue)

	gohelper.setActive(self.goAttr, fixType == Rouge2_MapEnum.DiceFixType.Attr)
	gohelper.setActive(self.goItem, fixType == Rouge2_MapEnum.DiceFixType.Item)

	if fixType == Rouge2_MapEnum.DiceFixType.Attr then
		local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(fixAttrId)

		self.txtAttrName.text = attrCo and attrCo.name

		Rouge2_IconHelper.setAttributeIcon(fixAttrId, self.imageAttrIcon, Rouge2_Enum.AttrIconSuffix.Tag)
	elseif fixType == Rouge2_MapEnum.DiceFixType.Item then
		local itemCo = Rouge2_BackpackHelper.getItemConfig(fixAttrId)

		self.txtItemName.text = itemCo and itemCo.name

		Rouge2_IconHelper.setGameItemIcon(fixAttrId, self.simageItemIcon)
	end

	gohelper.setActive(self.txtFixValue.gameObject, true)
	self:setVisible(true)
	self:playAnim("idle")
end

function Rouge2_MapDiceFixItem:setFixValueMaskable(maskable)
	self.txtFixValue.maskable = maskable
end

function Rouge2_MapDiceFixItem:onEndMoveFixValue()
	self.done = true

	gohelper.setActive(self.txtFixValue.gameObject, false)
end

function Rouge2_MapDiceFixItem:playAnim(animName)
	self.animator:Play(animName, 0, 0)
end

function Rouge2_MapDiceFixItem:getGO()
	return self.go
end

function Rouge2_MapDiceFixItem:getFixValuePos()
	return self.txtFixValue.transform.position
end

function Rouge2_MapDiceFixItem:startFlying(goFlyMgr, tranFlyContent, endPos)
	if not self.uiFlying then
		self.goFlyMgr = gohelper.cloneInPlace(goFlyMgr)
		self.uiFlying = self.goFlyMgr:GetComponent(typeof(UnityEngine.UI.UIFlying))
	end

	self:playAnim("close")
	gohelper.setActive(self.goFlyMgr, true)

	local startWorldPos = self:getFixValuePos()

	self.uiFlying.startPosition = recthelper.rectToRelativeAnchorPos(startWorldPos, tranFlyContent)
	self.uiFlying.endPosition = endPos

	self.uiFlying:StartFlying()
end

function Rouge2_MapDiceFixItem:setVisible(visible)
	self._visible = visible

	gohelper.setActive(self.go, self._visible)
end

function Rouge2_MapDiceFixItem:onDestroy()
	self.simageItemIcon:UnLoadImage()
end

return Rouge2_MapDiceFixItem
