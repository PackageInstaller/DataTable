-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSkinMaterialTipViewBanner2.lua

module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipViewBanner2", package.seeall)

local MainSceneSkinMaterialTipViewBanner2 = class("MainSceneSkinMaterialTipViewBanner2", DecorateMaterialTipViewBanner)

function MainSceneSkinMaterialTipViewBanner2:onOpen()
	self._goodsId = self.viewParam.goodsId
	self._goodsIds = DecorateStoreModel.instance:getV3a4PackageStoreGoodsIds()

	self:_refreshGoods()
end

function MainSceneSkinMaterialTipViewBanner2:setGoodsTab(goodsId)
	self._goodsId = goodsId

	self:_refreshGoods()
end

function MainSceneSkinMaterialTipViewBanner2:_refreshGoods()
	self._infoItemDataList = {}

	tabletool.addValues(self._infoItemDataList, self:_getItemDataList())
	self:_refreshUI()
	self:_startAutoSwitch()
end

function MainSceneSkinMaterialTipViewBanner2:_getItemDataList()
	local list = {}

	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)

	local storeCo = StoreConfig.instance:getGoodsConfig(self._goodsId)
	local productsList = GameUtil.splitString2(storeCo.product, true, "|", "#")
	local data = {}

	if self._decorateConfig.subType == ItemEnum.SubType.SceneUIPackage then
		-- block empty
	else
		local products = productsList[1]

		self._config = ItemModel.instance:getItemConfig(products[1], products[2])
		data.itemType = products[1]
		data.itemId = products[2]
	end

	table.insert(list, data)

	return list
end

function MainSceneSkinMaterialTipViewBanner2:_updateInfoItemUI(tb, itemId, itemType)
	local previewIcon

	if self._decorateConfig.subType == ItemEnum.SubType.SceneUIPackage then
		previewIcon = ResUrl.getMainSceneSwitchLangIcon(self._decorateConfig.buylmg)

		local storeCo = StoreConfig.instance:getGoodsConfig(self._goodsId)
		local productsList = GameUtil.splitString2(storeCo.product, true, "|", "#")

		tb._txtdesc.text = luaLang(string.format("mainsceneuipackage_%s", self._goodsId))
		tb._txtname.text = storeCo.name

		local sceneConfig = MainSceneSwitchConfig.instance:getConfigByItemId(productsList[1][2])

		tb._sceneSkinId = sceneConfig.id

		local uiConfig = MainUISwitchConfig.instance:getUISwitchCoByItemId(productsList[2][2])

		tb._uiSkinId = uiConfig.id
	else
		local config = ItemModel.instance:getItemConfig(itemType, itemId)

		tb._txtdesc.text = config.desc
		tb._txtname.text = config.name

		gohelper.setActive(tb._gotag, true)

		if self._decorateConfig.subType == ItemEnum.SubType.MainSceneSkin then
			local sceneConfig = MainSceneSwitchConfig.instance:getConfigByItemId(itemId)

			tb._sceneSkinId = sceneConfig.id
			previewIcon = ResUrl.getMainSceneSwitchIcon(sceneConfig.previewIcon)
		elseif self._decorateConfig.subType == ItemEnum.SubType.MainUISkin then
			local uiConfig = MainUISwitchConfig.instance:getUISwitchCoByItemId(itemId)

			tb._uiSkinId = uiConfig.id
			previewIcon = ResUrl.getMainSceneSwitchLangIcon(uiConfig.previewIcon)
		end
	end

	if not string.nilorempty(previewIcon) then
		tb._simageinfobg:LoadImage(previewIcon)
	end

	self:_refreshLogo(tb, itemId, itemType)
end

function MainSceneSkinMaterialTipViewBanner2:_refreshLogo(tb, itemId, itemType)
	if not tb then
		return
	end

	local isShowHeadBg
	local info = DecorateEnum.DecorateUIParams[self._decorateConfig.subType]

	if info then
		local title = info.Title

		if not string.nilorempty(title) then
			local config = ItemModel.instance:getItemConfig(itemType, itemId)
			local decorateCo, classify = DecorateModel.instance:getItemDecorateCo(config)

			if classify and classify == MainSwitchClassifyEnum.Classify.Click then
				title = "main_switch_classify_title_3"
			end

			tb._txtSceneLogo.text = luaLang(title)
		end

		gohelper.setActive(tb._goSceneLogo, not string.nilorempty(title))

		if not string.nilorempty(info.Tag) then
			tb._txttag.text = luaLang(info.Tag)
		end

		gohelper.setActive(tb._gotag, not string.nilorempty(info.Tag))

		isShowHeadBg = info.IsShowHeadBg
	end

	gohelper.setActive(tb._goheadiconbg, isShowHeadBg)
end

function MainSceneSkinMaterialTipViewBanner2:_createInfoItemUserDataTb_(goItem)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._gotag = gohelper.findChild(goItem, "#go_tag")
	tb._txttag = gohelper.findChildText(goItem, "#go_tag/txt_name")
	tb._txtdesc = gohelper.findChildText(goItem, "txt_desc")
	tb._txtname = gohelper.findChildText(goItem, "txt_desc/txt_name")
	tb._simageinfobg = gohelper.findChildSingleImage(goItem, "#simage_pic")
	tb._txtSceneLogo = gohelper.findChildText(goItem, "image_frame/#go_SceneLogo/titlebg/#txt_SceneLogo")
	tb._btn = gohelper.findChildButtonWithAudio(goItem, "txt_desc/txt_name/#btn_Info")

	tb._btn:AddClickListener(self._clickItemBtn, self, tb)

	self._infoItemTbList = self._infoItemTbList or {}

	table.insert(self._infoItemTbList, tb)

	return tb
end

function MainSceneSkinMaterialTipViewBanner2:_clickItemBtn(tb)
	if not self._decorateConfig then
		return
	end

	if self._decorateConfig.subType == ItemEnum.SubType.MainSceneSkin then
		ViewMgr.instance:openView(ViewName.MainSceneSwitchInfoView, {
			isPreview = true,
			noInfoEffect = true,
			sceneSkinId = tb._sceneSkinId
		})
	elseif self._decorateConfig.subType == ItemEnum.SubType.MainUISkin then
		MainUISwitchController.instance:openMainUISwitchInfoView(tb._uiSkinId, true, true, true, true, true)
	elseif self._decorateConfig.subType == ItemEnum.SubType.SceneUIPackage then
		MainUISwitchController.instance:openMainUISwitchInfoViewGiftSet(tb._uiSkinId, tb._sceneSkinId, true, true, true)
	end
end

return MainSceneSkinMaterialTipViewBanner2
