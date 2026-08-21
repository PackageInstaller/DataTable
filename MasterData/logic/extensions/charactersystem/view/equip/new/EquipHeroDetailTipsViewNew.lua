-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/new/EquipHeroDetailTipsViewNew.lua

module("logic.extensions.charactersystem.view.equip.new.EquipHeroDetailTipsViewNew", package.seeall)

local M = class("EquipHeroDetailTipsViewNew", ViewComponent)

function M:buildUI()
	self._btnLock = Astral.ButtonAdapter.GetFrom(self.mainGO, "universal_second_tips_common_bg/content/btnClose")

	local propertyListGo = self:getGo("timing_detail_tips_1920160237")

	self._propertyItemList = {}

	for index = 1, EquipEnum.MaxAttrCount do
		local propertyItemGo = goutil.findChild(propertyListGo, "attribute_" .. index)

		table.insert(self._propertyItemList, propertyItemGo)
	end

	local suitListGo = self:getGo("timing_detail_tips_1030498562")

	self._txtSuitDesc = goutil.findChild(suitListGo, "txtDescSuitAttribute")
	self._txtSuitTitle = goutil.findChildTextComponent(suitListGo, "txtNameSuitAttribute")
	self._goSuitEmpty = goutil.findChild(suitListGo, "txtEmpty")
	self._suitListGo = suitListGo
	self._attrTipsGo = self:getGo("timing_detail_tips_878088631")
	self._attributeD6Template = self:getGo("timing_detail_tips_577759808")

	goutil.setActive(self._d6AttributeItemGo, false)
	goutil.setActive(self._txtSuitDesc, false)
end

function M:bindEvents()
	self._btnLock:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnLock:RemoveClickListener()
end

function M:onEnter()
	self._equipHeroData = self:getFirstParam()

	if self._equipHeroData then
		self:_refreshEquipAttr()
		self:_refreshSuitAttr()
		self:_refreshD6attr()
	end
end

function M:onExit()
	return
end

function M:destroyUI()
	return
end

function M:_onClickClose()
	self:close()
end

function M:_refreshEquipAttr()
	local attrList = self._equipHeroData:getAllEquipAttr()

	for index = 1, EquipEnum.MaxAttrCount do
		local propertyItemGo = self._propertyItemList[index]

		if attrList[index] then
			propertyItemGo:SetActive(true)

			goutil.findChildTextComponent(propertyItemGo, "Text1").text = attrList[index].name
			goutil.findChildTextComponent(propertyItemGo, "Text2").text = attrList[index].num
		else
			propertyItemGo:SetActive(false)
		end
	end
end

function M:_refreshSuitAttr()
	local suitId = self._equipHeroData:getAvailableSuitId()

	if suitId then
		local suitData = EquipSuitModel.instance:getSuitDataById(suitId)

		self._txtSuitTitle.text = string.format("%s(3/3):", suitData:getName())

		local trs = self._suitListGo.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1).gameObject

			if child.name == "txtDescSuitAttribute(Clone)" then
				UnityEngine.GameObject.Destroy(child.gameObject)
			end
		end

		local suitDescList = suitData:getSuit3DescList()

		for _, descAttr in ipairs(suitDescList) do
			local itemGo = goutil.clone(self._txtSuitDesc)

			itemGo:SetActive(true)

			local txtSuitAttribute = goutil.addComponentOnce(itemGo, UIComponentType.TMPText)

			if txtSuitAttribute then
				txtSuitAttribute.text = descAttr
			end

			goutil.addChildToParent(itemGo, self._suitListGo)
		end

		goutil.setActive(self._goSuitEmpty, false)
		goutil.setActive(self._txtSuitTitle.gameObject, true)
	else
		goutil.setActive(self._goSuitEmpty, true)
		goutil.setActive(self._txtSuitTitle.gameObject, false)
	end
end

function M:_refreshD6attr()
	local attrs = self._equipHeroData:getAllD6Attr()
	local attrsNum = #attrs

	goutil.setActive(self._attrTipsGo, attrsNum > 0)

	if attrsNum > 0 then
		local trs = self._attrTipsGo.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1).gameObject
			local matcher = string.match(child.name, "imgTitle")

			if not matcher then
				UnityEngine.GameObject.Destroy(child.gameObject)
			end
		end

		for index = 1, attrsNum do
			local d6AttributeItemGo = goutil.clone(self._attributeD6Template)

			goutil.setActive(d6AttributeItemGo, true)
			goutil.addChildToParent(d6AttributeItemGo, self._attrTipsGo)

			local itemView = Astral.LuaComponentContainer.Add(d6AttributeItemGo, D6AttrComponentItem)

			itemView:setData(attrs[index])
			itemView:setFaceVisible(false)
		end
	end
end

return M
