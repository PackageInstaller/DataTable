-- chunkname: @modules/logic/mainuiswitch/view/MainUISkinMaterialTipViewBanner.lua

module("modules.logic.mainuiswitch.view.MainUISkinMaterialTipViewBanner", package.seeall)

local MainUISkinMaterialTipViewBanner = class("MainUISkinMaterialTipViewBanner", MainSceneSkinMaterialTipViewBanner)

function MainUISkinMaterialTipViewBanner:onInitView()
	MainUISkinMaterialTipViewBanner.super.onInitView(self)

	self._goSceneLogo = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._goSceneLogo2 = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo2")
	self._goSceneLogo3 = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo3")
	self._simageSceneLogo4 = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo4")
end

function MainUISkinMaterialTipViewBanner:_createInfoItemUserDataTb_(goItem)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._gotag = gohelper.findChild(goItem, "#go_tag")
	tb._txtdesc = gohelper.findChildText(goItem, "txt_desc")
	tb._txtname = gohelper.findChildText(goItem, "txt_desc/txt_name")
	tb._simageinfobg = gohelper.findChildSingleImage(goItem, "#simage_pic")
	tb._btn = gohelper.findChildButtonWithAudio(goItem, "txt_desc/txt_name/#btn_Info")

	tb._btn:AddClickListener(self._clickCheckBtn, self, tb)

	self._infoItemTbList = self._infoItemTbList or {}

	table.insert(self._infoItemTbList, tb)

	return tb
end

function MainUISkinMaterialTipViewBanner:_clickCheckBtn(tb)
	if not tb._uiSkinId then
		return
	end

	if self._classify == MainSwitchClassifyEnum.Classify.UI then
		MainUISwitchController.instance:openMainUISwitchInfoView(tb._uiSkinId, true, true)
	elseif self._classify == MainSwitchClassifyEnum.Classify.Click then
		ClickUISwitchController.instance:openClickUISwitchInfoView(tb._uiSkinId, true, true)
	end
end

function MainUISkinMaterialTipViewBanner:_updateInfoItemUI(itemUserDataTb, itemId, itemType)
	local tb = itemUserDataTb
	local config = ItemModel.instance:getItemConfig(itemType, itemId)

	tb._txtdesc.text = config.desc
	tb._txtname.text = config.name

	gohelper.setActive(tb._gotag, true)

	local uiConfig = self:_getUIConfig(itemId)

	tb._uiSkinId = uiConfig.id

	local icon = self._classify == MainSwitchClassifyEnum.Classify.Click and ResUrl.getMainSceneSwitchIcon(uiConfig.previewIcon) or ResUrl.getMainSceneSwitchLangIcon(uiConfig.previewIcon)

	tb._simageinfobg:LoadImage(icon)
end

function MainUISkinMaterialTipViewBanner:_refreshTitle()
	local logo = MainSwitchClassifyEnum.ClassifyShowInfo[self._classify].TitleLogo

	self._simageSceneLogo4:LoadImage(ResUrl.getMainSceneSwitchLangIcon(logo))
end

function MainUISkinMaterialTipViewBanner:onOpen()
	self._infoItemDataList = {}
	self._classify = MainSwitchClassifyEnum.Classify.UI
	self._itemSubType = ItemModel.instance:getItemConfig(self.viewParam.type, self.viewParam.id).subType

	tabletool.addValues(self._infoItemDataList, self:_getItemDataList())
	self:_refreshUI()
	self:_startAutoSwitch()
	gohelper.setActive(self._goSceneLogo, false)
	gohelper.setActive(self._goSceneLogo2, false)
	gohelper.setActive(self._goSceneLogo3, false)
	gohelper.setActive(self._simageSceneLogo4.gameObject, true)
	self:_refreshTitle()
end

function MainUISkinMaterialTipViewBanner:_getUIConfig(itemId)
	local uiConfig = MainUISwitchConfig.instance:getUISwitchCoByItemId(itemId)

	if uiConfig then
		self._classify = MainSwitchClassifyEnum.Classify.UI
	else
		self._classify = MainSwitchClassifyEnum.Classify.Click
		uiConfig = ClickUISwitchConfig.instance:getClickUICoByItemId(itemId)
	end

	return uiConfig
end

function MainUISkinMaterialTipViewBanner:onDestroyView()
	MainUISkinMaterialTipViewBanner.super.onDestroyView(self)
	self._simageSceneLogo4:UnLoadImage()
end

return MainUISkinMaterialTipViewBanner
