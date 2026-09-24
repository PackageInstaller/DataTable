-- chunkname: @modules/logic/decorate/view/DecoratePackageBuyViewBanner.lua

module("modules.logic.decorate.view.DecoratePackageBuyViewBanner", package.seeall)

local DecoratePackageBuyViewBanner = class("DecoratePackageBuyViewBanner", DecorateMaterialTipViewBanner)

function DecoratePackageBuyViewBanner:onOpen()
	self._goodsId = self.viewParam.goodsId
	self._goodsIds = self.viewParam.goodsIds

	self:_refreshGoods()
end

function DecoratePackageBuyViewBanner:setGoodsTab(goodsId)
	self._goodsId = goodsId

	self:_refreshGoods()
end

function DecoratePackageBuyViewBanner:_refreshGoods()
	self._infoItemDataList = {}

	tabletool.addValues(self._infoItemDataList, self:_getItemDataList())
	self:_refreshUI()
	self:_startAutoSwitch()
end

function DecoratePackageBuyViewBanner:_getItemDataList()
	local list = {}

	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)

	local goodsCo = StoreConfig.instance:getGoodsConfig(self._goodsId)
	local productsList = GameUtil.splitString2(goodsCo.product, true, "|", "#")
	local data = {}

	self._isPackage = self._decorateConfig.bundleType > 0

	if self._isPackage then
		if self._decorateConfig.subType == ItemEnum.SubType.SceneUIPackage then
			local sceneConfig = MainSceneSwitchConfig.instance:getConfigByItemId(productsList[1][2])

			self._sceneSkinId = sceneConfig.id

			local uiConfig = MainUISwitchConfig.instance:getUISwitchCoByItemId(productsList[2][2])

			self._uiSkinId = uiConfig.id
		end
	else
		local products = productsList[1]

		self._config = ItemModel.instance:getItemConfig(products[1], products[2])
		data.itemType = products[1]
		data.itemId = products[2]
	end

	table.insert(list, data)

	return list
end

function DecoratePackageBuyViewBanner:_updateInfoItemUI(tb, itemId, itemType)
	local isShowCheckInfo = false
	local previewIcon

	if self._isPackage then
		if self._decorateConfig.subType == ItemEnum.SubType.SceneUIPackage then
			previewIcon = ResUrl.getMainSceneSwitchLangIcon(self._decorateConfig.buylmg)
			isShowCheckInfo = true
		else
			previewIcon = ResUrl.getDecorateStoreImg(self._decorateConfig.buylmg)
		end

		local goodsCo = StoreConfig.instance:getGoodsConfig(self._goodsId)

		tb._txtdesc.text = self._decorateConfig.desc
		tb._txtname.text = goodsCo.name
	else
		previewIcon = DecorateModel.instance:getGoodsBuyIcon(self._config, self._goodsId)
		isShowCheckInfo = DecorateModel.instance:isCanOpenPreviewView(self._config.subType)
		tb._txtdesc.text = self._config.desc
		tb._txtname.text = self._config.name

		gohelper.setActive(tb._gotag, true)
	end

	gohelper.setActive(tb._btn.gameObject, isShowCheckInfo)

	if not string.nilorempty(previewIcon) then
		tb._simageinfobg:LoadImage(previewIcon)
	end

	self:_refreshLogo(tb, itemId, itemType)
end

function DecoratePackageBuyViewBanner:_refreshLogo(tb, itemId, itemType)
	if not tb then
		return
	end

	local isShowHeadBg
	local title = self._decorateConfig.typeName
	local tag
	local info = DecorateEnum.DecorateUIParams[self._decorateConfig.subType]

	if info then
		tag = info.Tag
		isShowHeadBg = info.IsShowHeadBg
	end

	if not string.nilorempty(title) then
		tb._txtSceneLogo.text = title
	end

	gohelper.setActive(tb._goSceneLogo, not string.nilorempty(title))

	if not string.nilorempty(tag) then
		tb._txttag.text = luaLang(tag)
	end

	gohelper.setActive(tb._gotag, not string.nilorempty(tag))
	gohelper.setActive(tb._goheadiconbg, isShowHeadBg)
end

function DecoratePackageBuyViewBanner:_createInfoItemUserDataTb_(goItem)
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

function DecoratePackageBuyViewBanner:_clickItemBtn(tb)
	if not self._decorateConfig or not self._isPackage and not DecorateModel.instance:isCanOpenPreviewView(self._decorateConfig.subType) then
		return
	end

	if self._isPackage then
		if self._decorateConfig.subType == ItemEnum.SubType.SceneUIPackage then
			MainUISwitchController.instance:openPreviewPackageGoods(self._uiSkinId, self._sceneSkinId, self._goodsId)
		end
	else
		DecorateController.instance:openPreviewView(self._config)
	end
end

return DecoratePackageBuyViewBanner
