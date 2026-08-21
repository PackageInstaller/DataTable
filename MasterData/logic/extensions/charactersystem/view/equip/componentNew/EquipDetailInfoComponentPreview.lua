-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/componentNew/EquipDetailInfoComponentPreview.lua

module("logic.extensions.charactersystem.view.equip.componentNew.EquipDetailInfoComponentPreview", package.seeall)

local M = class("EquipDetailInfoComponentPreview", EquipDetailInfoComponentNew)
local kAttributeMaxNum = 2

function M:_buildUI()
	self._btnLock = self:getBtn("backpack_equip_detail_tips_copy_1967695515")
	self._btnDisboard = self:getBtn("4&com_btn_2_-31477526")
	self._btnExchange = self:getBtn("0&com_btn_2_-31477526")
	self._btnWear = self:getBtn("1&com_btn_2_-31477526")
	self._btnIntensify = Astral.SimpleLuaComponentContainer.Add(self._registry:getGo("2&btn_right_1251431307"), CommButton)
	self._btnLvUp = self:getBtn("3&btn_middle_-31477526")
	self._txtEquipName = self:getText("backpack_equip_detail_tips_copy_673794678")
	self._txtLevel = self:getText("backpack_equip_detail_tips_copy_1769378791")
	self._txtSuitName = self:getText("backpack_equip_detail_tips_copy_-234148544")
	self._suitNameImg1Go = goutil.findChild(self._txtSuitName.gameObject, "img1")
	self._suitNameImg2Go = goutil.findChild(self._txtSuitName.gameObject, "img2")
	self._txtSuitNum = self:getText("backpack_equip_detail_tips_copy_629227193")
	self._txtSuitAttrGo = self:getGo("backpack_equip_detail_tips_copy_-1939983079")

	goutil.setActive(self._txtSuitAttrGo, false)

	self._btnSuitAttribute = self:getBtn("backpack_equip_detail_tips_copy_311937878")
	self._txtDesc = self:getText("backpack_equip_detail_tips_copy_-184207483")
	self._objRecommend = self:getGo("backpack_equip_detail_tips_copy_-331108247")

	local suitAniGo = self:getGo("backpack_equip_detail_tips_copy_-213986641")

	self._suitContentGo = suitAniGo
	self._suitAni = suitAniGo:GetComponent(ComponentType.Animation)
	self._suitEffectGo = goutil.findChild(suitAniGo, "effect")
	self._suitEffectImg1Go = goutil.findChild(suitAniGo, "Image (1)")
	self._suitEffectImg2Go = goutil.findChild(suitAniGo, "Image (4)")
	self._attributeRootList = {}
	self._attributeTxtList = {}
	self._attrNumTxtList = {}

	for i = 1, kAttributeMaxNum do
		local attributeRoot = goutil.findChild(self._mainGo, "node/scroll/view/content/content1/attribute_" .. i)
		local attributeTxt = goutil.findChildTextComponent(attributeRoot, "txtAttribute")
		local attrNumTxt = goutil.findChildTextComponent(attributeRoot, "txtNum")

		table.insert(self._attributeRootList, attributeRoot)
		table.insert(self._attributeTxtList, attributeTxt)
		table.insert(self._attrNumTxtList, attrNumTxt)
	end

	local d6AttributeLayoutGo = self:getGo("backpack_equip_detail_tips_copy_-771903693")

	self._d6AttrParent = d6AttributeLayoutGo

	local d6AttributeItemTemplate = goutil.findChild(d6AttributeLayoutGo, "d6_attribute_item")

	goutil.setActive(d6AttributeItemTemplate, false)

	self._d6attributeItemViewList = {}
	self._gameObjectD6 = {}

	for index = 2, EquipEnum.MaxHoleCount + 1 do
		local d6AttributeItemGo = goutil.clone(d6AttributeItemTemplate)

		table.insert(self._gameObjectD6, d6AttributeItemGo)
		goutil.addChildToParent(d6AttributeItemGo, d6AttributeLayoutGo)

		local itemView = Astral.LuaComponentContainer.Add(d6AttributeItemGo, EquipTipsD6ItemView)

		table.insert(self._d6attributeItemViewList, itemView)
		itemView:expendAsBotton()
		itemView:setClickCallback(function()
			self:_onClickHole(index)
		end)
	end

	self._d6LineGo = self:getGo("backpack_equip_detail_tips_copy_905317766")
	self._suitLineGo = self:getGo("backpack_equip_detail_tips_copy_407645594")
	self._lvMaxGo = self:getGo("backpack_equip_detail_tips_copy_1524723379")
	self._imgEquipIcon = self:getImage("backpack_equip_detail_tips_copy_1168876333")
	self._lockRootGo = self:getGo("backpack_equip_detail_tips_copy_-1416040178")
	self._lock = self:getGo("backpack_equip_detail_tips_copy_882602538")
	self._unlock = self:getGo("backpack_equip_detail_tips_copy_-153103076")
	self._headGo = self:getGo("backpack_equip_detail_tips_copy_-912076755")
	self._headIcon = self:getImage("backpack_equip_detail_tips_copy_-691117322")
	self._statusGo = self:getGo("backpack_equip_detail_tips_copy_-1286867792")
	self._isShowStatus = true

	goutil.setActive(self._btnDisboard.gameObject, false)
	goutil.setActive(self._btnExchange.gameObject, false)
	goutil.setActive(self._btnWear.gameObject, false)
	self._btnIntensify:setActive(false)
	goutil.setActive(self._btnLvUp.gameObject, false)
	goutil.setActive(self._lvMaxGo, false)
end

function M:_refreshAttrInfo()
	local itemId = self._equipMo:getItemId()
	local equip = EquipUtil.equipMaxLVData(itemId)
	local attrList = equip:getAttrList()

	for i = 1, kAttributeMaxNum do
		goutil.setActive(self._attributeRootList[i], i <= #attrList)

		if i <= #attrList then
			self._attributeTxtList[i].text = attrList[i]:getName()
			self._attrNumTxtList[i].text = attrList[i]:getValue()
		end
	end

	local unlockHoleCount = 0
	local enhances = {}
	local num = #self._equipMo:getAllD6s()

	if num > 0 then
		for index = 2, num + 1 do
			local itemView = self._d6attributeItemViewList[index]
			local holeIndex = index - 1
			local diceAttrMo
			local isHoldUnlock = false
			local isOriginHole = false
			local unlockTips = false

			if holeIndex == 0 then
				isHoldUnlock = self._equipMo:hasOriginalD6()

				if isHoldUnlock then
					local originD6 = self._equipMo:getOriginalD6()

					diceAttrMo = originD6:getEffectAttr()
					isOriginHole = true
					unlockHoleCount = unlockHoleCount + 1

					if diceAttrMo:isEnhanced() then
						local enhanceType = diceAttrMo:getEnhanceType()

						enhances[enhanceType] = {
							index
						}
					end
				else
					unlockTips = ""
				end
			else
				local fixedD6Mo = self._equipMo:getFixedD6ByHoleIndex(holeIndex)

				if fixedD6Mo then
					diceAttrMo = fixedD6Mo:getEffectAttr()

					local enhanceType = diceAttrMo:getEnhanceType()

					if enhances[enhanceType] then
						table.insert(enhances[enhanceType], index)
					else
						enhances[enhanceType] = {
							index
						}
					end
				else
					unlockTips = lang("tip_to_be_embedded")
				end
			end

			unlockHoleCount = unlockHoleCount + 1

			goutil.setActive(self._gameObjectD6[index].gameObject, true)
			itemView:setData(diceAttrMo, isOriginHole, unlockTips)
			itemView:closeEnhanceAni()
		end

		for _, v in pairs(enhances) do
			local enhanceNum = #v

			if enhanceNum and enhanceNum > 1 then
				for k, viewind in ipairs(v) do
					local itemView = self._d6attributeItemViewList[viewind]

					itemView:playEnhanceAni(enhanceNum)
				end
			end
		end

		goutil.setActive(self._objRecommend.gameObject, true)
	else
		for k, v in pairs(self._gameObjectD6) do
			goutil.setActive(v.gameObject, false)
		end

		goutil.setActive(self._objRecommend.gameObject, false)
	end

	goutil.setActive(self._d6LineGo, unlockHoleCount > 0)
end

function M:_onClickHole(index)
	local holeIndex = index - 1

	if not self._equipMo then
		return
	end

	local buffCodes, tagCodes = self._d6attributeItemViewList[holeIndex]:getBuffsAndTags()

	if buffCodes then
		local bindGo = self._d6attributeItemViewList[holeIndex]:getButtonGo()

		ToolTipsMgr.showSkillBuffTagSideTipsWithCodes(buffCodes, tagCodes, bindGo, false)
	end
end

return M
