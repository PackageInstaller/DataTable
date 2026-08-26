-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackAttrTabItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackAttrTabItem", package.seeall)

local Rouge2_BackpackAttrTabItem = class("Rouge2_BackpackAttrTabItem", LuaCompBase)

function Rouge2_BackpackAttrTabItem:init(go)
	self.go = go
	self._goUnSelected = gohelper.findChild(self.go, "#go_UnSelected")
	self._goSelected = gohelper.findChild(self.go, "#go_Selected")
	self._imageIcon1 = gohelper.findChildImage(self.go, "#go_UnSelected/#image_Icon")
	self._txtName1 = gohelper.findChildText(self.go, "#go_UnSelected/#txt_Name")
	self._goNum1 = gohelper.findChild(self.go, "#go_UnSelected/#go_Num1")
	self._txtNum1 = gohelper.findChildText(self.go, "#go_UnSelected/#go_Num1/#txt_Num1")
	self._imageIcon2 = gohelper.findChildImage(self.go, "#go_Selected/#image_Icon")
	self._txtName2 = gohelper.findChildText(self.go, "#go_Selected/#txt_Name")
	self._goNum2 = gohelper.findChild(self.go, "#go_Selected/#go_Num2")
	self._txtNum2 = gohelper.findChildText(self.go, "#go_Selected/#go_Num2/#txt_Num2")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click")
end

function Rouge2_BackpackAttrTabItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_BackpackAttrTabItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_BackpackAttrTabItem:initEventFlag(eventFlag)
	self._eventFlag = eventFlag
end

function Rouge2_BackpackAttrTabItem:initRefreshNumFlagFunc(refreshFunc, refreshFuncObj)
	self._numFlagRefreshFunc = refreshFunc
	self._numFlagRefreshFuncObj = refreshFuncObj
end

function Rouge2_BackpackAttrTabItem:onUpdateMO(attrId)
	self._attrId = attrId

	self:refreshUI()
end

function Rouge2_BackpackAttrTabItem:refreshUI()
	if self._attrId ~= 0 then
		local attrCo = Rouge2_AttributeConfig.instance:getAttributeConfig(self._attrId)
		local attrName = attrCo and attrCo.name

		self._txtName1.text = attrName
		self._txtName2.text = attrName

		Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageIcon1)
		Rouge2_IconHelper.setAttributeIcon(self._attrId, self._imageIcon2)
	else
		self._txtName1.text = luaLang("rouge2_attrsplittoolbar_all")
		self._txtName2.text = luaLang("rouge2_attrsplittoolbar_all")

		UISpriteSetMgr.instance:setRouge6Sprite(self._imageIcon1, "rouge2_attrsplittoolbar_all")
		UISpriteSetMgr.instance:setRouge6Sprite(self._imageIcon2, "rouge2_attrsplittoolbar_allselected")
	end

	self:refreshNumFlag()
	gohelper.setActive(self.go, true)
end

function Rouge2_BackpackAttrTabItem:refreshNumFlag()
	if not self._numFlagRefreshFunc then
		gohelper.setActive(self._goNum1, false)
		gohelper.setActive(self._goNum2, false)

		return
	end

	local isVisible, flagStr = self._numFlagRefreshFunc(self._numFlagRefreshFuncObj, self._attrId)

	self._txtNum1.text = flagStr or ""
	self._txtNum2.text = flagStr or ""

	gohelper.setActive(self._goNum1, isVisible)
	gohelper.setActive(self._goNum2, isVisible)
end

function Rouge2_BackpackAttrTabItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goSelected, isSelect)
	gohelper.setActive(self._goUnSelected, not isSelect)
end

function Rouge2_BackpackAttrTabItem:_btnClickOnClick()
	if self._isSelect or not self._eventFlag then
		return
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSwitchAttrTabItem, self._eventFlag, self._attrId)
end

function Rouge2_BackpackAttrTabItem:onDestroy()
	self._clickCallback = nil
	self._clickCallbackObj = nil
end

return Rouge2_BackpackAttrTabItem
