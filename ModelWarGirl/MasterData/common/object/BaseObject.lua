-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\BaseObject.lua

local strClassName = "BaseObject"
local ResItem = require("ClientData/ResItem")
local BaseObject = GLDeclare(strClassName, Class(strClassName))
local ResItemSpecialConfig = require("ClientData/ResItemSpecialConfig")
local ResItemConvert = require("ClientData/ResItemConvert")
local ResRandClient = require("ClientData/ResRandClient")

function BaseObject.GetObject(resID, num, equipEnable, gemMainAttr)
	if not resID then
		return nil
	end

	local data = {}

	if resID < 100000 then
		return nil
	elseif resID >= 100000 and resID < 200000 then
		-- block empty
	elseif resID >= 200000 and resID < 300000 then
		local Hero = require("Common/Object/Hero")

		data.resid = resID

		if num and num > 4 then
			data.star = num
		end

		return Hero(data)
	elseif resID >= 300000 and resID < 400000 and (equipEnable or true) then
		local Equip = require("Common/Object/Equip")

		data.resid = resID
		data.init_props = 1
		data.prop = {}

		return Equip(data)
	elseif resID >= 400000 and resID < 460000 then
		local Artifact = require("Common/Object/Artifact")

		data.resid = resID

		return Artifact(data)
	elseif resID >= 600000 and resID < 700000 then
		local EquipTemplete = require("Common/Object/EquipTemplete")

		data.resid = resID

		return EquipTemplete(data)
	elseif resID >= 700000 and resID < 800000 then
		local Relic = require("Common/Object/Relic")

		data.id = resID
		data.level = 0

		return Relic(data)
	elseif resID >= 800000 and resID < 810000 then
		local Skin = require("Common/Object/Skin")

		data.id = resID

		return Skin(data)
	elseif resID >= 900000 and resID < 1000000 then
		local Pet = require("Common/Object/Pet")

		data.resid = resID

		return Pet(data)
	elseif resID >= 1000000 and resID < 1100000 then
		local PetAmulet = require("Common/Object/PetAmulet")

		data.resid = resID

		return PetAmulet(data)
	elseif resID >= 1100000 and resID < 1200000 then
		local PetGem = require("Common/Object/PetGem")

		data.resid = resID
		data.main_attr = gemMainAttr or {}

		local petGem = PetGem(data)

		petGem.num = num

		return petGem
	end

	local Item = require("Common/Object/Item")

	data.id = resID
	data.num = num or 1
	data.spec = {
		equip = {},
		simple = {},
		task = {}
	}

	return Item(data)
end

function BaseObject.GetObjectType(resID)
	if resID >= 200000 and resID < 300000 then
		return Const.ITEM_TYPE_HERO
	elseif resID >= 300000 and resID < 400000 then
		return Const.ITEM_TYPE_EQUIP
	elseif resID >= 400000 and resID < 460000 then
		return Const.ITEM_TYPE_ARTIFACT
	elseif resID >= 600000 and resID < 700000 then
		return Const.ITEM_TYPE_EQUIP_TEMPLETE
	elseif resID >= 700000 and resID < 800000 then
		return Const.ITEM_TYPE_RELIC
	elseif resID >= 800000 and resID < 810000 then
		return Const.ITEM_TYPE_SKIN
	elseif resID >= 900000 and resID < 1000000 then
		return Const.ITEM_TYPE_PET
	elseif resID >= 1000000 and resID < 1100000 then
		return Const.ITEM_TYPE_PET_AMULET
	elseif resID >= 1100000 and resID < 1200000 then
		return Const.ITEM_TYPE_PET_GEM
	else
		return Const.ITEM_TYPE_ITEM
	end
end

function BaseObject.ShowObjectTips(resID, num, fromUI, uiConfig)
	local fakeItem = BaseObject.GetObject(resID, num)

	if fakeItem.getType() == "Item" then
		if fakeItem:isFragmentItem() then
			UIManager.getUI("fragItemTips"):showObj(fromUI, fakeItem, uiConfig)
		else
			UIManager.getUI("itemTips"):showObj(fromUI, fakeItem, uiConfig)
		end
	elseif fakeItem.getType() == "EquipTemplete" then
		UIManager.getUI("equipTempleteTips"):showObj(fromUI, fakeItem, uiConfig)
	elseif fakeItem.getType() == "Artifact" then
		UIManager.getUI("artifactTips"):showObj(fromUI, fakeItem, uiConfig)
	elseif fakeItem.getType() == "Hero" then
		UIManager.getUI("heroPreviewTips"):showObj(fromUI, fakeItem, uiConfig)
	elseif fakeItem.getType() == "Skin" then
		if uiConfig and uiConfig.noPreview then
			UIManager.getUI("skinTips"):showObj(fromUI, fakeItem, uiConfig)
		else
			UIManager.getUI("skinPreviewTips"):setBySkinObj(fakeItem)
		end
	end
end

function BaseObject.isAttrs(resID)
	return resID >= 100000 and resID < 200000
end

function BaseObject.CopyObject(obj)
	local data = obj._serverData

	if data == nil then
		return nil
	end

	local cls = obj:getClass()

	return cls(data)
end

function BaseObject.getItemIconPath(itemId)
	local resData = ResItem[itemId]

	if resData and resData.iconPath and resData.icon then
		return {
			UIConst.ITEM_ICON_PATH .. resData.iconPath,
			resData.icon
		}
	end
end

function BaseObject:ctor(data)
	self._serverData = data

	self:_initData()
end

function BaseObject:destroy()
	return
end

function BaseObject:_initData()
	return
end

function BaseObject:refreshObject(serverData)
	self._serverData = serverData

	self:_initData()
end

function BaseObject:getIconPath()
	if self.resData and self.resData.iconPath and self.resData.icon then
		return {
			UIConst.ITEM_ICON_PATH .. self.resData.iconPath,
			self.resData.icon
		}
	end
end

function BaseObject:getQualityPath()
	if self.quality then
		return UIConst.COMMON_QUALITY_CONFIG[self.quality]
	end
end

function BaseObject:isRare()
	return false
end

function BaseObject:getQualityName()
	if self.name == nil then
		return ""
	end

	local color = self:getQualityColor()

	if color and color ~= ResColor.QUALITYWHITE then
		return "<color=#" .. color.ff .. ">" .. self.name .. "</color>"
	else
		return self.name
	end
end

function BaseObject:getSellPriceStr()
	if self.resData then
		if self.resData.sell_price and self.resData.sell_coin_id then
			if ResItemSpecialConfig[self.resData.sell_coin_id] and ResItemSpecialConfig[self.resData.sell_coin_id].emoji_path then
				return self.resData.sell_price .. ResItemSpecialConfig[self.resData.sell_coin_id].emoji_path
			elseif ResItem[self.resData.sell_coin_id] then
				return self.resData.sell_price .. "*" .. (ResItem[self.resData.sell_coin_id].name or "")
			end
		end

		return self.resData.sell_price
	end
end

function BaseObject:getQualityColor(getQuality)
	local quality = getQuality or self.quality
	local ResColor = require("ClientData/ResColor")
	local color

	if quality == Const.OBJ_QUALITY_WHITE then
		color = ResColor.QUALITYWHITE
	elseif quality == Const.OBJ_QUALITY_GREEN then
		color = ResColor.QUALITYGREEN
	elseif quality == Const.OBJ_QUALITY_BLUE then
		color = ResColor.QUALITYBLUE
	elseif quality == Const.OBJ_QUALITY_PURPLE then
		color = ResColor.QUALITYPURPLE
	elseif quality == Const.OBJ_QUALITY_GOLD then
		color = ResColor.QUALITYORANGE
	end

	return color
end

function BaseObject.checkHasObject(object)
	if not object then
		return false
	end

	local checkHas = false
	local id = object.id
	local type = BaseObject.GetObjectType(id)

	if type == Const.ITEM_TYPE_ITEM then
		local resData = ResItem[id]

		if resData and resData.subtype then
			if resData.subtype == Const.ITEM_STYPE_HEAD_FRAME then
				checkHas = CurAvatar.headFrameIds ~= nil and CurAvatar.headFrameIds[id] ~= nil
			elseif resData.subtype == Const.ITEM_STYPE_DYNAMIC_ICON then
				checkHas = CurAvatar.dynamicIcons ~= nil and CurAvatar.dynamicIcons[id] ~= nil
			elseif resData.subtype == Const.ITEM_STYPE_REAR_HOUSE_PROPS then
				checkHas = CurAvatar:getItemNumById(id) > 0
			end
		end
	elseif type == Const.ITEM_TYPE_SKIN then
		checkHas = CurAvatar:hasGetHeroSkin(id)
	end

	return checkHas
end

function BaseObject.checkConvertObject(object)
	if not object or not ResItemConvert[object.id] then
		return false
	end

	local config = ResItemConvert[object.id]

	return LimitManager.checkConditionOK(config.limit_id)
end

function BaseObject.getConvertObject(object)
	if not BaseObject.checkConvertObject(object) then
		return nil
	end

	local id = object.id
	local num = object.num or 1
	local convertConfig = ResItemConvert[id]
	local randConfig = ResRandClient[convertConfig.randId]

	if not randConfig then
		return nil
	end

	local showIds = randConfig.show_ids
	local showNums = randConfig.show_nums

	if not showIds or #showIds == 0 then
		return nil
	end

	local convertNum = num

	if showNums and #showNums > 0 then
		convertNum = showNums[1] * num
	end

	return BaseObject.GetObject(showIds[1], convertNum)
end

function BaseObject:isCommonItem()
	return false
end

function BaseObject:isEquip()
	return false
end

function BaseObject:isFragmentItem()
	return false
end

function BaseObject:isArtifact()
	return false
end

function BaseObject:isHero()
	return false
end

function BaseObject:isPetGem()
	return false
end

function BaseObject:isSkin()
	return false
end

function BaseObject:getNumStr()
	return ""
end

function BaseObject:isFurniture()
	return false
end

return BaseObject
