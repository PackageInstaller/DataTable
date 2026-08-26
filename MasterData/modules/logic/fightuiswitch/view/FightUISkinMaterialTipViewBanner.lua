-- chunkname: @modules/logic/fightuiswitch/view/FightUISkinMaterialTipViewBanner.lua

module("modules.logic.fightuiswitch.view.FightUISkinMaterialTipViewBanner", package.seeall)

local FightUISkinMaterialTipViewBanner = class("FightUISkinMaterialTipViewBanner", MainSceneSkinMaterialTipViewBanner)

function FightUISkinMaterialTipViewBanner:onInitView()
	FightUISkinMaterialTipViewBanner.super.onInitView(self)

	self._goSceneLogo = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._goSceneLogo2 = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo2")
	self._goSceneLogo3 = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo3")
	self._goSceneLogo4 = gohelper.findChild(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo4")
end

function FightUISkinMaterialTipViewBanner:_createInfoItemUserDataTb_(goItem)
	local tb = self:getUserDataTb_()

	tb._go = goItem
	tb._gotag = gohelper.findChild(goItem, "#go_tag")
	tb._gotag2 = gohelper.findChild(goItem, "#go_tag2")
	tb._gotagtxt = gohelper.findChildText(goItem, "#go_tag2/txt_name")
	tb._txtdesc = gohelper.findChildText(goItem, "txt_desc")
	tb._txtname = gohelper.findChildText(goItem, "txt_desc/txt_name")
	tb._simageinfobg = gohelper.findChildSingleImage(goItem, "#simage_pic")
	tb._btn = gohelper.findChildButtonWithAudio(goItem, "txt_desc/txt_name/#btn_Info")
	self._infoItemTbList = self._infoItemTbList or {}

	table.insert(self._infoItemTbList, tb)

	return tb
end

function FightUISkinMaterialTipViewBanner:_updateInfoItemUI(itemUserDataTb, itemId, itemType)
	local tb = itemUserDataTb
	local config = ItemModel.instance:getItemConfig(itemType, itemId)

	tb._txtdesc.text = config.desc
	tb._txtname.text = config.name

	gohelper.setActive(tb._gotag, false)
	gohelper.setActive(tb._gotag2, true)

	tb._gotagtxt.text = luaLang("p_mainsceneswitchview_title_3")

	self:_addClickFightUI(tb._btn, itemId)

	local mo = FightUISwitchModel.instance:getStyleMoByItemId(itemId)

	if mo then
		tb._uiSkinId = mo.id

		if not string.nilorempty(mo.co.previewImage) then
			tb._simageinfobg:LoadImage(ResUrl.getMainSceneSwitchIcon(mo.co.previewImage))
		end
	end
end

function FightUISkinMaterialTipViewBanner:onOpen()
	self._infoItemDataList = {}
	self._itemSubType = ItemModel.instance:getItemConfig(self.viewParam.type, self.viewParam.id).subType

	tabletool.addValues(self._infoItemDataList, self:_getItemDataList())
	self:_refreshUI()
	self:_startAutoSwitch()
	gohelper.setActive(self._goSceneLogo, false)
	gohelper.setActive(self._goSceneLogo2, self._itemSubType == ItemEnum.SubType.FightFloatType)
	gohelper.setActive(self._goSceneLogo3, self._itemSubType == ItemEnum.SubType.FightCard)
	gohelper.setActive(self._goSceneLogo4, false)
end

function FightUISkinMaterialTipViewBanner:_addClickFightUI(btn, itemId)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		FightUISwitchController.instance:openSceneView(itemId)
	end, self)
end

return FightUISkinMaterialTipViewBanner
