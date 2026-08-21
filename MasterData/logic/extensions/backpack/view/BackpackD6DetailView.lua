-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/BackpackD6DetailView.lua

module("logic.extensions.backpack.view.BackpackD6DetailView", package.seeall)

local M = class("BackpackD6DetailView")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()
end

function M:_buildUI()
	self._imgIcon = self:getImage("attriubte_d6_right_tips_copy_40758660")
	self._lock = self:getGo("attriubte_d6_right_tips_copy_284539718")
	self._unlock = self:getGo("attriubte_d6_right_tips_copy_1092915799")
	self._btnLock = self:getBtn("attriubte_d6_right_tips_copy_1431375964")
	self._lockRootGo = self:getGo("attriubte_d6_right_tips_copy_-1030982751")
	self._txtName = self:getText("attriubte_d6_right_tips_copy_619354886")

	local attributeD6LayoutGo = goutil.findChild(self:getGo("attriubte_d6_right_tips_copy_-726530779"), "d6AttributeLayout")
	local attributeD6Template = goutil.findChild(attributeD6LayoutGo, "d6_attribute_item1")

	goutil.setActive(attributeD6Template, false)

	self._attrViewList = {}

	for index = 1, EquipEnum.MaxD6AttrHoleCount do
		local d6AttributeItemGo = goutil.clone(attributeD6Template)

		goutil.setActive(d6AttributeItemGo, true)
		goutil.addChildToParent(d6AttributeItemGo, attributeD6LayoutGo)

		local view = Astral.LuaComponentContainer.Add(d6AttributeItemGo, D6AttrItemView)

		table.insert(self._attrViewList, view)
	end

	goutil.setActive(goutil.findChild(self._mainGo, "node/dice"), false)
	goutil.setActive(goutil.findChild(self._mainGo, "node/content3"), true)
	goutil.setActive(self:getGo("attriubte_d6_right_tips_copy_1068676203"), true)
	goutil.setActive(goutil.findChild(self._mainGo, "node/content3/btnReset"), false)
	goutil.setActive(goutil.findChild(self._mainGo, "node/content3/com_price"), false)
	goutil.setActive(self:getGo("attriubte_d6_right_tips_copy_1974939526"), false)
end

function M:_bindEvents()
	self._btnLock:AddClickListener(self._onClickLockBtn, self)

	for index = 1, EquipEnum.MaxD6AttrHoleCount do
		self._attrViewList[index]:expendAsBotton()
		self._attrViewList[index]:setClickCallback(function()
			self:_onClickHole(index)
		end)
	end
end

function M:_unbindEvents()
	self._btnLock:RemoveClickListener()

	for index = 1, EquipEnum.MaxD6AttrHoleCount do
		self._attrViewList[index]:cancleButton()
	end
end

function M:onEnter()
	self:_bindEvents()
end

function M:onExit()
	self:_unbindEvents()
end

function M:refreshView()
	if not self._itemData then
		return
	end

	local quality = self._itemData:getQuality()
	local qualityName = lang(CommEnum.Quality2Lang[quality])

	self._txtName.text = qualityName .. self._itemData:getName()

	IconLoader.setSprite(self._imgIcon, IconType.D6Icon, self._itemData:getIcon())

	local attrs = self._itemData:getAttrs()

	for index, attrItem in ipairs(self._attrViewList) do
		local diceAttrMo = attrs[index]

		if diceAttrMo then
			attrItem:setVisible(true)
			attrItem:setData(diceAttrMo)
			attrItem:setRomeNum(index)
		else
			attrItem:setVisible(false)
		end
	end

	self:_refreshStatus()
end

function M:_onClickHole(index)
	local view = self._attrViewList[index]
	local data = view:getData()

	if data then
		local buffCodes, tagCodes = data:getBuffsAndTags()

		if buffCodes then
			local bindGo = view:getButtonGo()

			ToolTipsMgr.showSkillBuffTagSideTipsWithCodes(buffCodes, tagCodes, bindGo, false)
		end
	end
end

function M:_refreshStatus()
	goutil.setActive(self._lockRootGo, self._isShowStatus)

	if not self._isShowStatus then
		return
	end

	local isLock = self._itemData:getIsLock()

	goutil.setActive(self._lock, isLock)
	goutil.setActive(self._unlock, not isLock)
end

function M:setItemData(itemData)
	self._itemData = itemData

	self:refreshView()
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	return
end

function M:_onClickLockBtn()
	local uuid = self._itemData:getUuid()
	local isLock = self._itemData:getIsLock()

	if not isLock then
		EquipmentAgent.instance:sendDiceLockToggleRequest(uuid)
	else
		local dialog = Dialog.showMessage(lang("tip_sure_unlock"), lang("tip_unlock_d6"))

		dialog:setConfirmListener(function()
			EquipmentAgent.instance:sendDiceLockToggleRequest(uuid)
		end, self)
	end
end

function M:_onClickDiscard()
	local equipId = self._itemData:getUuid()

	EquipmentAgent.instance:sendDiceDiscardToggleRequest(equipId)
end

function M:setEquipStatusVisible(visible)
	self._isShowStatus = visible

	goutil.setActive(self._lockRootGo, visible)
end

return M
