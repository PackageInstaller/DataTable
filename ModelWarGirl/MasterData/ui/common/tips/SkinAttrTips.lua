-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\SkinAttrTips.lua

local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local ResItemHeroSkin = require("ClientData/ResItemHeroSkin")
local ResItemHeroBase = require("ClientData/ResItemHeroBase")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local SkinAttrCell = Class("SkinAttrCell", UIControls.Child)

function SkinAttrCell:ctor()
	self.btn = UIControls.Button(self, "")
	self.txtName = UIControls.Label(self, "TxtVerName")
	self.txtState = UIControls.Label(self, "Txt")
end

function SkinAttrCell:setData(info, isGet, skinType)
	local attrInfo = info.prop
	local attrTab = {}

	for i = 1, 2 do
		attrTab[i] = HeroAttrPanel(self, "Attr" .. i)
	end

	for idx = 1, 2 do
		if attrInfo[idx] then
			local skinAttr = attrInfo[idx]
			local name, valueStr = ClientUtils.getRolePropZhNameByType(skinAttr.type, skinAttr.value)

			attrTab[idx]:setVisible(true)
			attrTab[idx]:setData(name, valueStr)
		else
			attrTab[idx]:setVisible(false)
		end
	end

	if isGet then
		self.txtState:setText(Lang.get(32799))
	else
		self.txtState:setText(Lang.get(195))
	end

	self.btn:setEnable(isGet)
	self.txtName:setText(info.name)
end

local strClassName = "SkinAttrTips"
local SkinAttrTips = Class(strClassName, UIControls.Window)

function SkinAttrTips:ctor()
	self.attrSkinList = {}
	self.attrBaseList = {}
end

function SkinAttrTips:setData(heroId)
	local skin = ResItemHeroSkin[heroId] or {}
	local attrCfg = UIMiscConfig.SKIN_DEFAULT_ATTRTYPE_SKIN
	local attrsValue = {}

	for _, info in ipairs(skin) do
		if (not info.condition_id or not ConditionLimitManager.inLimitState(info.condition_id)) and info.not_show ~= 1 and not not ClientUtils.isTimeConfigPassed(info.valid_time_id) and info.prop and not CurAvatar:checkHasUpgradeSkinAndGet(info.hero_id, info.id) and (not info.is_upgrade_skin or info.is_upgrade_skin == 1 and CurAvatar:hasGetSkinByHeroAndSkinId(info.hero_id, info.id)) then
			local isGet = false
			local skinObj = BaseObject.GetObject(info.item_id)

			if skinObj and skinObj:isGet() then
				isGet = true
			end

			local cell = SkinAttrCell(self, "Bg/AttrLessList1/Content", "System/Hero/AttrListCell")

			cell:setData(info, isGet, Const.SKIN_TYPE_SKIN)
			cell:setVisible(true)

			if isGet then
				for i, attr in ipairs(info.prop) do
					if not attrsValue[attr.type] then
						attrsValue[attr.type] = 0
					end

					attrsValue[attr.type] = attrsValue[attr.type] + attr.value
				end
			end
		end
	end

	local skinAttrs = {}

	for idx, attrType in ipairs(attrCfg) do
		local attrValue = attrsValue[attrType] or 0

		skinAttrs[idx] = {
			attrType,
			attrValue
		}
	end

	local base = ResItemHeroBase[heroId] or {}

	attrCfg = UIMiscConfig.SKIN_DEFAULT_ATTRTYPE_BASE
	attrsValue = {}

	for _, info in ipairs(base) do
		if info.prop then
			local isGet = false
			local skinSvrData = CurAvatar:getSkinDataByHeroId(info.hero_id)
			local baseData = skinSvrData.base or {}

			if baseData[info.id] then
				isGet = true
			end

			local cell = SkinAttrCell(self, "Bg/AttrLessList2/Content", "System/Hero/AttrListCell")

			cell:setData(info, isGet, Const.SKIN_TYPE_BASE)
			cell:setVisible(true)

			if isGet then
				for i, attr in ipairs(info.prop) do
					if not attrsValue[attr.type] then
						attrsValue[attr.type] = 0
					end

					attrsValue[attr.type] = attrsValue[attr.type] + attr.value
				end
			end
		end
	end

	local baseAttrs = {}

	for idx, attrType in ipairs(attrCfg) do
		local attrValue = attrsValue[attrType] or 0

		baseAttrs[idx] = {
			attrType,
			attrValue
		}
	end

	self:setAddAttr(skinAttrs, Const.SKIN_TYPE_SKIN)
	self:setAddAttr(baseAttrs, Const.SKIN_TYPE_BASE)
end

function SkinAttrTips:setAddAttr(attr, type)
	local attrList = {}

	for i = 1, 2 do
		if type == Const.SKIN_TYPE_SKIN then
			attrList[i] = HeroAttrPanel(self, "Bg/AttrLessPanel1/Attr" .. i)
		else
			attrList[i] = HeroAttrPanel(self, "Bg/AttrLessPanel2/Attr" .. i)
		end
	end

	for idx = 1, 2 do
		if attr[idx] then
			local attrData = attr[idx]
			local name, valueStr = ClientUtils.getRolePropZhNameByType(attrData[1], attrData[2])

			attrList[idx]:setVisible(true)
			attrList[idx]:setData(name, valueStr)
		else
			attrList[idx]:setVisible(false)
		end
	end
end

return SkinAttrTips
