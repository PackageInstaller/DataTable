-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheCardInfoLeft.lua

module("modules.logic.sodache.view.outside.comp.SodacheCardInfoLeft", package.seeall)

local SodacheCardInfoLeft = class("SodacheCardInfoLeft", LuaCompBase)

function SodacheCardInfoLeft:init(go)
	self.txtName = gohelper.findChildText(go, "txt_Name")
	self.txtDesc = gohelper.findChildText(go, "txt_Desc")
	self.imageQuality = gohelper.findChildImage(go, "Tag1/image_Quality")
	self.txtQuality = gohelper.findChildText(go, "Tag1/txt_Quality")
	self.txtType = gohelper.findChildText(go, "Tag2/txt_Type")
	self.imageType = gohelper.findChildImage(go, "Tag2/txt_Type/image_Type")
	self.txtMaterialDesc = gohelper.findChildText(go, "Type1/Scroll View/Viewport/Content/txt_MaterialDesc")
	self.txtAdventureDesc = gohelper.findChildText(go, "Type2/Scroll View/Viewport/Content/txt_AdventureDesc")
	self.goDiceItem = gohelper.findChild(go, "Type2/Scroll View/Viewport/Content/txt_AdventureDesc/Attr/Icons/go_DiceItem")

	gohelper.setActive(self.goDiceItem, false)

	self.txtBulletDesc = gohelper.findChildText(go, "Type3/Scroll View/Viewport/Content/txt_BulletDesc")
	self.goPartRefrain = gohelper.findChild(go, "Type3/Scroll View/Viewport/Content/txt_BulletDesc/Attr/go_PartRefrain")
	self.goAllRefrain = gohelper.findChild(go, "Type3/Scroll View/Viewport/Content/txt_BulletDesc/Attr/go_AllRefrain")
	self.txtBulletAttr = gohelper.findChildText(go, "Type3/Scroll View/Viewport/Content/txt_BulletDesc/Attr/txt_BulletAttr")
	self.txtBulletAttrEn = gohelper.findChildText(go, "Type3/Scroll View/Viewport/Content/txt_BulletDesc/Attr/txt_BulletAttrEn")
	self.goBulletAttr = gohelper.findChild(go, "Type3/Scroll View/Viewport/Content/txt_BulletDesc/Attr/Icons/go_BulletAttr")
	self.txtBuffDesc = gohelper.findChildText(go, "Type4/Scroll View/Viewport/Content/txt_BuffDesc")
	self.txtBuffEndDesc = gohelper.findChildText(go, "Type4/Scroll View/Viewport/Content/txt_BuffEndDesc")
	self.goRelicItem = gohelper.findChild(go, "Type5/Scroll View/Viewport/Content/go_RelicItem")

	gohelper.setActive(self.goRelicItem, false)

	self.goTypeMap = self:getUserDataTb_()

	for i = 1, 5 do
		self.goTypeMap[i] = gohelper.findChild(go, "Type" .. tostring(i))
	end
end

function SodacheCardInfoLeft:onDestroy()
	TaskDispatcher.cancelTask(self.delayHideEffect, self)
end

function SodacheCardInfoLeft:setNoShowPassive()
	self.isNoShowPassive = true
end

function SodacheCardInfoLeft:setData(data)
	self.cardMo = data
	self.config = self.cardMo.serverMo.itemCo
	self.txtName.text = self.config.name
	self.txtDesc.text = self.config.desc

	UISpriteSetMgr.instance:setSodache2Sprite(self.imageQuality, "sodache_carddetail_tag_0" .. tostring(self.config.quality))

	self.txtQuality.text = luaLang("sodache_cardquality_" .. tostring(self.config.quality))

	local itemType = self.config.type

	self.txtType.text = luaLang("sodache_cardtype_" .. tostring(itemType))

	UISpriteSetMgr.instance:setSodache2Sprite(self.imageType, "sodache_handbook_icon_" .. tostring(itemType))

	local func = self["refreshType" .. tostring(itemType)]

	if func then
		func(self)
	end

	for type, go in pairs(self.goTypeMap) do
		gohelper.setActive(go, type == itemType)
	end
end

function SodacheCardInfoLeft:refreshType1()
	self.txtMaterialDesc.text = SodacheUtil.changeDescColor(self.config.funcDesc)
end

function SodacheCardInfoLeft:refreshType2()
	self.txtAdventureDesc.text = SodacheUtil.changeDescColor(self.config.funcDesc)
	self.diceItemList = self.diceItemList or {}

	local diceIds = string.splitToNumber(self.config.diceList, "#")
	local diceCnt = #diceIds

	for i = 1, diceCnt do
		local diceItem = self.diceItemList[i]

		if not diceItem then
			local go = gohelper.cloneInPlace(self.goDiceItem)

			diceItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheDiceItem)
			self.diceItemList[i] = diceItem
		end

		diceItem:setData(diceIds[i], true)
		gohelper.setActive(diceItem.go, true)
	end

	for i = diceCnt + 1, #self.diceItemList do
		gohelper.setActive(self.diceItemList[i].go, false)
	end

	local scale = diceCnt <= 4 and 1 or 0.7

	transformhelper.setLocalScale(self.goDiceItem.transform.parent, scale, scale, 1)
end

function SodacheCardInfoLeft:refreshType3()
	self.txtBulletDesc.text = SodacheUtil.changeDescColor(self.config.funcDesc)

	local refrains = string.splitToNumber(self.config.refrain, "#")
	local refrainCnt = #refrains

	gohelper.setActive(self.goPartRefrain, refrainCnt ~= 6)
	gohelper.setActive(self.goAllRefrain, refrainCnt == 6)

	if refrainCnt == 1 then
		self.txtBulletAttr.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sodache_refrain_single"), luaLang("sodache_cardsubtype_10" .. tostring(refrains[1])))
	elseif refrainCnt == 2 then
		self.txtBulletAttr.text = luaLang("sodache_refrain_native")
	elseif refrainCnt == 4 then
		self.txtBulletAttr.text = luaLang("sodache_refrain_nature")
	elseif refrainCnt == 6 then
		self.txtBulletAttr.text = luaLang("sodache_refrain_all")
	end

	self.bulletAttrList = self.bulletAttrList or {}

	local itemCnt = 0

	for k, attr in ipairs(refrains) do
		itemCnt = itemCnt + 1

		local item = self.bulletAttrList[k]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self.goBulletAttr)
			item.image = gohelper.findChildImage(item.go, "")
			self.bulletAttrList[k] = item
		end

		UISpriteSetMgr.instance:setCommonSprite(item.image, "career_" .. tostring(attr))
		gohelper.setActive(item.go, true)
	end

	for i = itemCnt + 1, #self.bulletAttrList do
		gohelper.setActive(self.bulletAttrList[i].go, false)
	end
end

function SodacheCardInfoLeft:refreshType4()
	self.txtBuffDesc.text = SodacheUtil.changeDescColor(self.config.funcDesc)
end

function SodacheCardInfoLeft:refreshType5()
	self.relicDescItemList = self.relicDescItemList or {}

	local relicCfgs = lua_sodache_upgrade.configDict[self.config.id]
	local relicLv = SodacheModel.instance:getOutsideMo().relicBox:getRelicLv(self.config.id)

	for k, config in ipairs(relicCfgs) do
		local item = self.relicDescItemList[k]

		if not item then
			item = self:getUserDataTb_()
			item.go = gohelper.cloneInPlace(self.goRelicItem)
			item.txtDesc = gohelper.findChildText(item.go, "txt_Desc")
			item.goStarList = self:getUserDataTb_()

			for i = 1, 5 do
				item.goStarList[i] = gohelper.findChild(item.go, "txt_Desc/Stars/star" .. i)
			end

			item.goSelect = gohelper.findChild(item.go, "go_Select")
			item.goEffect = gohelper.findChild(item.go, "vx_effect")
			self.relicDescItemList[k] = item
		end

		for i = 1, 5 do
			gohelper.setActive(item.goStarList[i], i <= k)
		end

		local passiveDesc, activeDesc

		if not self.isNoShowPassive and not string.nilorempty(config.effectDesc) then
			local passive = luaLang("sodache_relicupgrade_passive")

			passiveDesc = string.format("%s%s", passive, config.effectDesc)
		end

		if not string.nilorempty(config.effect2Desc) then
			local active = luaLang("sodache_relicupgrade_active")

			activeDesc = string.format("%s%s", active, config.effect2Desc)
		end

		local arr = {}

		table.insert(arr, passiveDesc)
		table.insert(arr, activeDesc)

		item.txtDesc.text = SodacheUtil.changeDescColor(table.concat(arr, "<br>"))

		gohelper.setActive(item.goSelect, relicLv == config.level)
		gohelper.setActive(item.go, true)
	end

	for i = #relicCfgs + 1, #self.relicDescItemList do
		local item = self.relicDescItemList[i]

		gohelper.setActive(item.go, false)
	end
end

function SodacheCardInfoLeft:playRelicEffect(level)
	local goEffect = self.relicDescItemList[level].goEffect

	gohelper.setActive(goEffect, true)
	TaskDispatcher.cancelTask(self.delayHideEffect, self)
	TaskDispatcher.runDelay(self.delayHideEffect, self, 1)
end

function SodacheCardInfoLeft:delayHideEffect()
	for _, item in ipairs(self.relicDescItemList) do
		gohelper.setActive(item.goEffect, false)
	end
end

return SodacheCardInfoLeft
