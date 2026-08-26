-- chunkname: @modules/logic/rouge2/common/controller/Rouge2_AttrDropDescHelper.lua

module("modules.logic.rouge2.common.controller.Rouge2_AttrDropDescHelper", package.seeall)

local Rouge2_AttrDropDescHelper = _M

function Rouge2_AttrDropDescHelper.getAttrDropDesc(dropId)
	local dropItemList = Rouge2_Model.instance:getAttrDropItemList(dropId)

	if dropItemList then
		if not #dropItemList then
			local dropItemNum = 0
			local imLevelUpDescStr = ""

			if dropItemNum > 0 then
				local itemDescList = {}

				for _, itemId in ipairs(dropItemList) do
					local itemList = Rouge2_BackpackModel.instance:getItemListByItemId(itemId)
					local itemMo = itemList and itemList[1]
					local itemUid = itemMo and itemMo:getUid()
					local itemCo = itemMo and itemMo:getConfig()
					local itemDescStr = Rouge2_ItemDescHelper.getItemDescStr(Rouge2_Enum.ItemDataType.Server, itemUid, Rouge2_Enum.ItemDescMode.Full)

					if itemCo then
						if not itemCo.name then
							local itemName = ""
							local result = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge2_careerattributetipsview_attrbuff"), {
								itemName,
								itemDescStr
							})

							table.insert(itemDescList, result)
						end
					end
				end

				imLevelUpDescStr = table.concat(itemDescList, "\n")
			end

			return imLevelUpDescStr, dropItemList
		end
	end
end

function Rouge2_AttrDropDescHelper.LoadAttrDropDesc(dropId, goItem, percentColor, bracketColor)
	local result, dropItemList = Rouge2_AttrDropDescHelper.getAttrDropDesc(dropId)
	local dropCo = Rouge2_AttributeConfig.instance:getAttrDropConfig(dropId)

	if dropCo then
		if not dropCo.needNum then
			local level = 0
			local hasGet = Rouge2_Model.instance:isGetAttrDrop(dropId)
			local canGet = not hasGet and Rouge2_AttrDropDescHelper.isAttrOverDropCondition(dropId)
			local goLock = gohelper.findChild(goItem, "go_Lock")
			local goHasGet = gohelper.findChild(goItem, "go_HasGet")
			local goCanGet = gohelper.findChild(goItem, "go_CanGet")

			gohelper.setActive(goCanGet, canGet)
			gohelper.setActive(goHasGet, hasGet)
			gohelper.setActive(goLock, not hasGet and not canGet)

			if hasGet then
				local txtHasGetDesc = gohelper.findChildText(goHasGet, "txt_Desc")
				local imageRare = gohelper.findChildImage(goHasGet, "txt_Desc/#image_icon")
				local dropItemId = dropItemList and dropItemList[1]

				Rouge2_IconHelper.setGameItemRare(dropItemId, imageRare)
				Rouge2_ItemDescHelper.buildAndSetDesc(txtHasGetDesc, result, percentColor, bracketColor)
			elseif canGet then
				local txtCanGetDesc = gohelper.findChildText(goCanGet, "txt_Desc")
				local txtCanGetName = gohelper.findChildText(goCanGet, "txt_Name")

				txtCanGetName.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_careerattributetipsview_title2"), level)

				Rouge2_ItemDescHelper.buildAndSetDesc(txtCanGetDesc, luaLang("rouge2_careerattributetipsview_lockdesc"), percentColor, bracketColor)
			else
				local txtLockDesc = gohelper.findChildText(goLock, "txt_Desc")
				local txtLockName = gohelper.findChildText(goLock, "txt_Name")

				txtLockName.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_careerattributetipsview_title"), level)

				Rouge2_ItemDescHelper.buildAndSetDesc(txtLockDesc, luaLang("rouge2_careerattributetipsview_lockdesc"), percentColor, bracketColor)
			end
		end
	end
end

function Rouge2_AttrDropDescHelper.isAttrOverDropCondition(dropId)
	local dropCo = Rouge2_AttributeConfig.instance:getAttrDropConfig(dropId)

	if dropCo then
		if not dropCo.needNum then
			local level = 0
			local attrValue = Rouge2_Model.instance:getAttrValue(dropCo.attr)

			return level <= attrValue
		end
	end
end

function Rouge2_AttrDropDescHelper.loadAttrDropLevelList(careerId, attrId, txtComp, include, arrowType, unlockColor, lockColor, difficulty)
	local contentList = Rouge2_AttrDropDescHelper.getAttrDropLevelList(careerId, attrId, arrowType, unlockColor, lockColor, difficulty)

	if contentList then
		if not #contentList then
			local contentNum = 0

			gohelper.setActive(txtComp.gameObject, contentNum > 0)

			if contentNum <= 0 then
				return
			end

			if include == nil or include == true then
				table.insert(contentList, 1, "(")
				table.insert(contentList, ")")
			end

			txtComp.text = table.concat(contentList, "")
		end
	end
end

function Rouge2_AttrDropDescHelper.getAttrDropLevelList(careerId, attrId, arrowType, unlockColor, lockColor, difficulty)
	lockColor = lockColor or unlockColor

	local minAttrValue, maxAttrValue = Rouge2_BackpackController.instance:getAttrValueRange(difficulty, attrId)
	local attrDropList = Rouge2_AttributeConfig.instance:getLimitAttrDropList(careerId, attrId, difficulty) or {}

	if attrDropList then
		if not #attrDropList then
			local attrDropNum = 0
			local contentList = {}

			for i = 1, attrDropNum do
				if i ~= 1 then
					arrowType = arrowType or Rouge2_Enum.AttrDropArrowType.White

					local spriteIndex = Rouge2_Enum.AttrDropArrowSpriteIndex[arrowType]

					table.insert(contentList, string.format("<sprite=%s>", spriteIndex))
				end

				local dropCo = attrDropList[i]

				if not dropCo.needNum then
					local isUnlock = Rouge2_AttrDropDescHelper.isAttrOverDropCondition(dropCo.id)

					if isUnlock and unlockColor then
						table.insert(contentList, string.format("<%s>%s</color>", unlockColor, dropCo.needNum))
					elseif not isUnlock and lockColor then
						table.insert(contentList, string.format("<%s>%s</color>", lockColor, dropCo.needNum))
					else
						table.insert(contentList, dropCo.needNum)
					end
				end
			end

			return contentList
		end
	end
end

return Rouge2_AttrDropDescHelper
