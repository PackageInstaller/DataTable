-- chunkname: @modules/logic/summonuiswitch/view/SummonUISkinMaterialTipViewBanner.lua

module("modules.logic.summonuiswitch.view.SummonUISkinMaterialTipViewBanner", package.seeall)

local SummonUISkinMaterialTipViewBanner = class("SummonUISkinMaterialTipViewBanner", MainSceneSkinMaterialTipViewBanner)

function SummonUISkinMaterialTipViewBanner:onInitView()
	SummonUISkinMaterialTipViewBanner.super.onInitView(self)

	self._simageSceneLogo = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._imageSceneLogo = gohelper.findChildImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._txtSceneLogo = gohelper.findChildText(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo/titlebg/#txt_SceneLogo")
end

function SummonUISkinMaterialTipViewBanner:_createInfoItemUserDataTb_(goItem)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._gotag = gohelper.findChild(goItem, "#go_tag")
	tb._gotag2 = gohelper.findChild(goItem, "#go_tag2")
	tb._gotag3 = gohelper.findChild(goItem, "#go_tag3")
	tb._txtdesc = gohelper.findChildText(goItem, "txt_desc")
	tb._txtname = gohelper.findChildText(goItem, "txt_desc/txt_name")
	tb._simageinfobg = gohelper.findChildSingleImage(goItem, "#simage_pic")
	tb._btn = gohelper.findChildButtonWithAudio(goItem, "txt_desc/txt_name/#btn_Info")
	self._infoItemTbList = self._infoItemTbList or {}

	table.insert(self._infoItemTbList, tb)

	return tb
end

function SummonUISkinMaterialTipViewBanner:_updateInfoItemUI(itemUserDataTb, itemId, itemType)
	local tb = itemUserDataTb
	local config = ItemModel.instance:getItemConfig(itemType, itemId)

	tb._txtdesc.text = config.desc
	tb._txtname.text = config.name

	gohelper.setActive(tb._gotag, true)
	gohelper.setActive(tb._gotag2, false)
	gohelper.setActive(tb._gotag3, false)
	self:_addClickSceneUI(tb._btn, itemId)

	local summonSwitchConfig = SummonUISwitchConfig.instance:getSummonSwitchConfigByItemId(itemId)

	if summonSwitchConfig then
		tb._uiSkinId = summonSwitchConfig.id

		if not string.nilorempty(summonSwitchConfig.previewIcon) then
			tb._simageinfobg:LoadImage(ResUrl.getMainSceneSwitchIcon(summonSwitchConfig.previewIcon))
		end
	end
end

function SummonUISkinMaterialTipViewBanner:onOpen()
	self._infoItemDataList = {}
	self._itemSubType = ItemModel.instance:getItemConfig(self.viewParam.type, self.viewParam.id).subType

	tabletool.addValues(self._infoItemDataList, self:_getItemDataList())
	self:_refreshUI()
	self:_startAutoSwitch()
end

function SummonUISkinMaterialTipViewBanner:_refreshUI()
	SummonUISkinMaterialTipViewBanner.super._refreshUI(self)

	self._txtSceneLogo.text = luaLang("main_switch_classify_title_4")
end

function SummonUISkinMaterialTipViewBanner:_addClickSceneUI(btn, itemId)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		local sceneConfig = SummonUISwitchConfig.instance:getSummonSwitchConfigByItemId(itemId)

		if not sceneConfig then
			return
		end

		local param = {}

		param.sceneSkinId = sceneConfig.id
		param._materialDataMOList = nil
		param.noInfoEffect = true

		ViewMgr.instance:openView(ViewName.SummonUISwitchInfoView, param)
	end, self)
end

return SummonUISkinMaterialTipViewBanner
