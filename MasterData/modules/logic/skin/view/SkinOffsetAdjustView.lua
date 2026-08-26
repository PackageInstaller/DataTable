-- chunkname: @modules/logic/skin/view/SkinOffsetAdjustView.lua

module("modules.logic.skin.view.SkinOffsetAdjustView", package.seeall)

local SkinOffsetAdjustView = class("SkinOffsetAdjustView", BaseView)
local triggerNum = 5

function SkinOffsetAdjustView:onInitView()
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_block")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._gotrigger = gohelper.findChild(self.viewGO, "#go_container/#go_trigger")
	self._gotrigger34 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger3_4")
	self._gotrigger33 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger3_3")
	self._gotrigger32 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger3_2")
	self._gotrigger31 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger3_1")
	self._gotrigger14 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger1_4")
	self._gotrigger13 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger1_3")
	self._gotrigger12 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger1_2")
	self._gotrigger11 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger1_1")
	self._gotrigger24 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger2_4")
	self._gotrigger23 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger2_3")
	self._gotrigger22 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger2_2")
	self._gotrigger21 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger2_1")
	self._gotrigger44 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger4_4")
	self._gotrigger43 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger4_3")
	self._gotrigger42 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger4_2")
	self._gotrigger41 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger4_1")
	self._gotrigger54 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger5_4")
	self._gotrigger53 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger5_3")
	self._gotrigger52 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger5_2")
	self._gotrigger51 = gohelper.findChild(self.viewGO, "#go_container/#go_trigger/#go_trigger5_1")
	self._btnsaveTrigger = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/#go_trigger/#btn_saveTrigger")
	self._gooffset = gohelper.findChild(self.viewGO, "#go_container/component/#go_offset")
	self._txtoffsetkey = gohelper.findChildText(self.viewGO, "#go_container/component/#go_offset/#txt_offsetkey")
	self._txtoffsetParentKey = gohelper.findChildText(self.viewGO, "#go_container/component/#go_offset/#txt_offsetParentKey")
	self._txtoffsetValue = gohelper.findChildText(self.viewGO, "#go_container/component/#go_offset/#txt_offsetValue")
	self._slideroffsetx = gohelper.findChildSlider(self.viewGO, "#go_container/component/#go_offset/offsets/offset1/#slider_offsetx")
	self._txtoffsetx = gohelper.findChildText(self.viewGO, "#go_container/component/#go_offset/offsets/offset1/#txt_offsetx")
	self._slideroffsety = gohelper.findChildSlider(self.viewGO, "#go_container/component/#go_offset/offsets/offset2/#slider_offsety")
	self._txtoffsety = gohelper.findChildText(self.viewGO, "#go_container/component/#go_offset/offsets/offset2/#txt_offsety")
	self._slideroffsetscale = gohelper.findChildSlider(self.viewGO, "#go_container/component/#go_offset/offsets/offset3/#slider_offsetscale")
	self._txtoffsetscale = gohelper.findChildText(self.viewGO, "#go_container/component/#go_offset/offsets/offset3/#txt_offsetscale")
	self._btnsaveOffset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/component/#go_offset/#btn_saveOffset")
	self._btnresetOffset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/component/#go_offset/#btn_resetOffset")
	self._btnswitchOffset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/component/#go_offset/#btn_switchOffset")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/component/#btn_close")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_switch")
	self._txtswitch = gohelper.findChildText(self.viewGO, "#btn_switch/#txt_switch")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkinOffsetAdjustView:addEvents()
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
	self._btnsaveTrigger:AddClickListener(self._btnsaveTriggerOnClick, self)
	self._btnsaveOffset:AddClickListener(self._btnsaveOffsetOnClick, self)
	self._btnresetOffset:AddClickListener(self._btnresetOffsetOnClick, self)
	self._btnswitchOffset:AddClickListener(self._btnswitchOffsetOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
end

function SkinOffsetAdjustView:removeEvents()
	self._btnblock:RemoveClickListener()
	self._btnsaveTrigger:RemoveClickListener()
	self._btnsaveOffset:RemoveClickListener()
	self._btnresetOffset:RemoveClickListener()
	self._btnswitchOffset:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
end

SkinOffsetAdjustView.key2ParentKeyConstIdDict = {
	mainThumbnailViewOffset = 506,
	playercardViewImgOffset = 507,
	fightSuccViewOffset = 504,
	fullScreenLive2dOffset = 507,
	playercardViewLive2dOffset = 507,
	characterRankUpViewOffset = 503,
	characterGetViewOffset = 505,
	characterDataTitleViewOffset = 501,
	characterDataVoiceViewOffset = 502
}

function SkinOffsetAdjustView:_btnswitchOffsetOnClick()
	if self._curOffsetKey == "haloOffset" then
		self:_onCharacterViewUpdate()
	else
		self:_onCharacterHoloUpdate()
	end
end

function SkinOffsetAdjustView:_btnswitchOnClick()
	gohelper.setActive(self._gocontainer, not self._gocontainer.activeSelf)

	self._txtswitch.text = self._gocontainer.activeSelf and "点击隐藏" or "点击显示"
end

function SkinOffsetAdjustView:_btnresetOffsetOnClick()
	SkinOffsetAdjustModel.instance:resetTempOffset(self._curSkinInfo, self._curOffsetKey)

	local x, y, s = SkinOffsetAdjustModel.instance:getOffset(self._curSkinInfo, self._curOffsetKey)

	self:initSliderValue(x, y, s)
	self._changeOffsetCallback(x, y, s)
end

function SkinOffsetAdjustView:_btnsaveTriggerOnClick()
	for i = 1, triggerNum do
		self:saveTrigger(i)
	end
end

function SkinOffsetAdjustView:_btncloseOnClick()
	self:closeThis()
end

function SkinOffsetAdjustView:_btnsaveOffsetOnClick()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local x = string.format(self:_getXPrecision(), self._slideroffsetx:GetValue())
	local y = string.format(self:_getYPrecision(), self._slideroffsety:GetValue())
	local s = string.format(self:_getSPrecision(), self._slideroffsetscale:GetValue())

	if self._curOffsetKey == "decorateskinOffset" or self._curOffsetKey == "decorateskinl2dOffset" or self._curOffsetKey == "decorateskinl2dBgOffset" or self._curOffsetKey == "skin2dParams" then
		logError(string.format("%s,%s#%s", x, y, s))

		return
	end

	SkinOffsetAdjustModel.instance:setOffset(self._curSkinInfo, self._curOffsetKey, x, y, s)

	local isHeadiconImg = self._curViewInfo[8]

	if isHeadiconImg and tonumber(s) >= 1.2 then
		MessageBoxController.instance:showMsgBoxByStr("放大倍数过大，可能导致模糊, 请检查图片效果。\n如需使用4096尺寸请联系程序调整。", MsgBoxEnum.BoxType.Yes)
	end
end

function SkinOffsetAdjustView:_btnblockOnClick()
	self.isShowSkinContainer = false
	self.isShowViewContainer = false

	gohelper.setActive(self._goskinscroll, false)
	gohelper.setActive(self._goviewcroll, false)
end

function SkinOffsetAdjustView:onSkinContainerClick()
	gohelper.setActive(self._goskinscroll, true)

	self.isShowSkinContainer = true

	SkinOffsetSkinListModel.instance:initSkinList()
end

function SkinOffsetAdjustView:onViewContainerClick()
	if self.isShowViewContainer then
		self:_btnblockOnClick()

		return
	end

	gohelper.setActive(self._goviewcroll, true)

	self.isShowViewContainer = true
end

function SkinOffsetAdjustView:_onDragBegin(param, pointerEventData)
	self.startDragPosX = pointerEventData.position.x
end

function SkinOffsetAdjustView:_onDragEnd(param, pointerEventData)
	local endDragPosX = pointerEventData.position.x

	if math.abs(endDragPosX - self.startDragPosX) > 30 then
		if endDragPosX < self.startDragPosX then
			SkinOffsetSkinListModel.instance:slideNext()
		else
			SkinOffsetSkinListModel.instance:slidePre()
		end
	end
end

function SkinOffsetAdjustView:_editableInitView()
	SkinOffsetSkinListModel.instance:initOriginSkinList()
	SkinOffsetSkinListModel.instance:setScrollView(self)

	self.drag = SLFramework.UGUI.UIDragListener.Get(self._btnblock.gameObject)

	self.drag:AddDragBeginListener(self._onDragBegin, self)
	self.drag:AddDragEndListener(self._onDragEnd, self)

	self._simageList = self:getUserDataTb_()

	gohelper.setLayer(self.viewGO, UnityLayer.UITop, true)

	self._goskincontainer = gohelper.findChild(self.viewGO, "#go_container/component/#go_skincontainer")
	self._goskinscroll = gohelper.findChild(self.viewGO, "#go_container/component/#go_skincontainer/#scroll_skin")
	self._goskinscrollrect = SLFramework.UGUI.ScrollRectWrap.Get(self._goskinscroll)
	self._inputSkinLabel = gohelper.findChildTextMeshInputField(self.viewGO, "#go_container/component/#go_skincontainer/input_label")

	self._inputSkinLabel:AddOnValueChanged(self.onSkinInputValueChanged, self)

	self.goFullSkinContainer = gohelper.findChild(self.viewGO, "fullSkinContainer")
	self._inputCameraSize = gohelper.findChildTextMeshInputField(self.viewGO, "fullSkinContainer/camera_input")

	self._inputCameraSize:AddOnValueChanged(self.onCameraSizeInput, self)

	self._txtScale = gohelper.findChildText(self.viewGO, "fullSkinContainer/txt_scale")
	self._btnSearch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_container/component/#go_skincontainer/input_label/#btn_search")

	self._btnSearch:AddClickListener(self.onClickSearch, self)

	self._goviewcontainer = gohelper.findChild(self.viewGO, "#go_container/component/#go_viewcontainer")
	self._goviewcroll = gohelper.findChild(self.viewGO, "#go_container/component/#go_viewcontainer/#scroll_view")
	self._txtviewlabel = gohelper.findChildText(self.viewGO, "#go_container/component/#go_viewcontainer/#txt_label")
	self._goviewitem = gohelper.findChild(self.viewGO, "#go_container/component/#go_viewcontainer/#scroll_view/Viewport/Content/item")

	gohelper.setActive(self._goviewitem, false)

	self._goskincontainerclick = gohelper.getClick(self._inputSkinLabel.gameObject)

	self._goskincontainerclick:AddClickListener(self.onSkinContainerClick, self)

	self._goviewcontainerclick = gohelper.getClick(self._goviewcontainer)

	self._goviewcontainerclick:AddClickListener(self.onViewContainerClick, self)
	self:_initViewList()
	self:_initSkinList()
	self:initSlider(self._slideroffsetx, 2000, -2000, self._onOffsetXChange)
	self:initSlider(self._slideroffsety, 2000, -2000, self._onOffsetYChange)
	self:initSlider(self._slideroffsetscale, 3, 0, self._onOffsetScaleChange)

	self._goOffset1 = gohelper.findChild(self.viewGO, "#go_container/component/#go_offset/offsets/offset1")
	self._goOffset2 = gohelper.findChild(self.viewGO, "#go_container/component/#go_offset/offsets/offset2")
	self._goOffset3 = gohelper.findChild(self.viewGO, "#go_container/component/#go_offset/offsets/offset3")
	self._btnList = {}

	self:initOffsetItem(self._goOffset1, self._slideroffsetx, "x")
	self:initOffsetItem(self._goOffset2, self._slideroffsety, "y")
	self:initOffsetItem(self._goOffset3, self._slideroffsetscale, "s")
	gohelper.setActive(self._gooffset, false)
	gohelper.setActive(self._btnswitchOffset.gameObject, false)

	self._txtoffsetParentKey.text = ""
	self._txtoffsetValue.text = ""
end

function SkinOffsetAdjustView:setSkinScrollRectVertical(verticalNormalizedPosition)
	self._goskinscrollrect.verticalNormalizedPosition = verticalNormalizedPosition
end

function SkinOffsetAdjustView:initSlider(slider, maxValue, minValue, callback)
	if callback then
		slider:AddOnValueChanged(callback, self)

		local drag = SLFramework.UGUI.UIDragListener.Get(slider.gameObject)

		drag:AddDragBeginListener(function(param, pointerEventData)
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				slider.slider.enabled = false
			end
		end, nil)
		drag:AddDragEndListener(function(param, pointerEventData)
			if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				slider.slider.enabled = true
			end
		end, nil)
		drag:AddDragListener(function(param, pointerEventData)
			local v = pointerEventData.delta.x

			if slider == self._slideroffsetscale then
				v = pointerEventData.delta.x < 0 and -0.1 or 0.1

				if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
					v = v * 0.1
				end
			elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
				v = pointerEventData.delta.x < 0 and -0.1 or 0.1
			end

			slider:SetValue(slider:GetValue() + v)
		end, nil)
	end

	slider.slider.maxValue = maxValue
	slider.slider.minValue = minValue
end

function SkinOffsetAdjustView:initOffsetItem(offsetGo, slider, propName)
	local addBtn = gohelper.findChildButtonWithAudio(offsetGo, "AddBtn")
	local reduceBtn = gohelper.findChildButtonWithAudio(offsetGo, "ReduceBtn")
	local intervalField = gohelper.findChildTextMeshInputField(offsetGo, "IntervalField")

	intervalField:SetText(1)
	addBtn:AddClickListener(self.addBtnClick, self, {
		intervalField = intervalField,
		slider = slider,
		propName = propName
	})
	reduceBtn:AddClickListener(self.reduceBtnClick, self, {
		intervalField = intervalField,
		slider = slider,
		propName = propName
	})
	table.insert(self._btnList, addBtn)
	table.insert(self._btnList, reduceBtn)
end

function SkinOffsetAdjustView:addBtnClick(param)
	local interval = tonumber(param.intervalField:GetText())
	local currentVal = tonumber(param.slider:GetValue())

	param.slider:SetValue(currentVal + interval)
end

function SkinOffsetAdjustView:reduceBtnClick(param)
	local interval = tonumber(param.intervalField:GetText())
	local currentVal = tonumber(param.slider:GetValue())

	param.slider:SetValue(currentVal - interval)
end

function SkinOffsetAdjustView:_onOffsetXChange(param, value)
	self._txtoffsetx.text = string.format("x:" .. self:_getXPrecision(), value)

	self:_onOffsetChange()
end

function SkinOffsetAdjustView:_onOffsetYChange(param, value)
	self._txtoffsety.text = string.format("y:" .. self:_getYPrecision(), value)

	self:_onOffsetChange()
end

function SkinOffsetAdjustView:_onOffsetScaleChange(param, value)
	self._txtoffsetscale.text = string.format("s:" .. self:_getSPrecision(), value)

	self:_onOffsetChange()
end

function SkinOffsetAdjustView:_onOffsetChange()
	if self._changeOffsetCallback then
		local x = string.format(self:_getXPrecision(), self._slideroffsetx:GetValue())
		local y = string.format(self:_getYPrecision(), self._slideroffsety:GetValue())
		local s = string.format(self:_getSPrecision(), self._slideroffsetscale:GetValue())

		SkinOffsetAdjustModel.instance:setTempOffset(self._curSkinInfo, self._curOffsetKey, tonumber(x), tonumber(y), tonumber(s))
		self._changeOffsetCallback(tonumber(x), tonumber(y), tonumber(s))
	end
end

function SkinOffsetAdjustView:initSliderValue(x, y, s)
	self._slideroffsetx:SetValue(x)
	self._slideroffsety:SetValue(y)
	self._slideroffsetscale:SetValue(s)

	self._txtoffsetx.text = string.format("x:" .. self:_getXPrecision(), x)
	self._txtoffsety.text = string.format("y:" .. self:_getYPrecision(), y)
	self._txtoffsetscale.text = string.format("s:" .. self:_getSPrecision(), s)
end

function SkinOffsetAdjustView:_getXPrecision()
	return "%." .. ((self._precisionDefine or nil) and (self._precisionDefine.x or 1)) .. "f"
end

function SkinOffsetAdjustView:_getYPrecision()
	return "%." .. ((self._precisionDefine or nil) and (self._precisionDefine.y or 1)) .. "f"
end

function SkinOffsetAdjustView:_getSPrecision()
	return "%." .. ((self._precisionDefine or nil) and (self._precisionDefine.s or 2)) .. "f"
end

function SkinOffsetAdjustView:_initSkinList()
	SkinOffsetSkinListModel.instance:initSkinList()
	self:_btnblockOnClick()
end

function SkinOffsetAdjustView:_initViewList()
	self._viewList = {}
	self._viewNameList = {}

	table.insert(self._viewNameList, "0#动态立绘(常量表的501~505设置相对偏移)")
	self:_addView("主界面", ViewName.MainView, self._onMainViewOpen, self._onMainViewUpdate, "#go_spine_scale/lightspine/#go_lightspine", "mainViewOffset")
	self:_addView("相框", ViewName.MainView, self._onMainViewFrameOpen, self._onMainViewFrameUpdate, "#go_spine_scale/lightspine/#go_lightspine", "mainViewFrameOffset")
	self:_addView("主界面缩略图界面", ViewName.MainThumbnailView, self.onMainThumbnailViewOpen, self.onMainThumbnailViewUpdate, "#go_spine_scale/lightspine/#go_lightspine", "mainThumbnailViewOffset", "mainViewOffset")
	self:_addView("角色切换界面 -> 复用主界面, 不能特殊设置", ViewName.CharacterSwitchView, self._onCommonCharacterViewOpen, self._onCharacterSwitchUpdate, "#go_spine_scale/lightspine/#go_lightspine", "mainViewOffset")
	self:_addView("角色界面", ViewName.CharacterView, self._onCharacterViewOpen, self._onCharacterViewUpdate, "anim/#go_herocontainer/dynamiccontainer/#go_spine", "characterViewOffset")
	self:_addView("洞悉界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterRankUpView, self._onCommonCharacterViewOpen, self._onCharacterRankUpViewUpdate, "spineContainer/#go_spine", "characterRankUpViewOffset", "characterViewOffset")
	self:_addView("结算界面 -> 复用角色界面, 可以特殊设置", ViewName.FightSuccView, self._onCommonCharacterViewOpen, self._onCharacterRankUpViewUpdate, "spineContainer/spine", "fightSuccViewOffset", "characterViewOffset")
	self:_addView("角色获得界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterGetView, self._onCharacterGetViewOpen, self._onCharacterRankUpViewUpdate, "charactercontainer/#go_spine", "characterGetViewOffset", "characterViewOffset")
	self:_addView("角色封面界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterDataView, self._onCharacterDataViewOpen, self._onCharacterSkinViewUpdate, "content/characterdatatitleview(Clone)/content/character/charactericoncontainer/#go_spine", "characterDataTitleViewOffset", "characterViewOffset")
	self:_addView("语音界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterDataView, self._onCharacterDataViewOpen, self._onCharacterDataVoiceViewUpdate, "content/characterdatavoiceview(Clone)/content/#simage_characterbg/charactercontainer/#go_spine", "characterDataVoiceViewOffset", "characterViewOffset")
	self:_addView("个人名片 -> 复用角色界面, 可以特殊设置", ViewName.NewPlayerCardContentView, self._onPlayerCardViewOpen, self._onPlayerCardViewUpdate, "view", "playercardViewLive2dOffset", "characterViewOffset")
	self:_addView("装饰商店", ViewName.StoreView, self._onDecorateStoreViewOpen, self._onDecorateStoreViewUpdate, "#go_store/decoratestoreview(Clone)/Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer", "decorateskinl2dOffset")
	self:_addView("皮肤商店", ViewName.StoreView, self._onClothesStoreViewOpen, self._onClothesStoreViewUpdate, "#go_store/storeskinview2(Clone)/#go_has/character/bg/characterSpine/#go_skincontainer", "skin2dParams")
	self:_addView("皮肤界面 -> 复用角色界面, 可以特殊设置", ViewName.CharacterSkinView, self._onCharacterSkinSwitchViewOpenDynamic, self._onCharacterSkinDynamicDrawingViewUpdate1, "characterSpine/#go_skincontainer", "skinSwitchLive2dOffset")
	table.insert(self._viewNameList, "0#静态立绘")
	self:_addView("角色封面界面静态立绘偏移", ViewName.CharacterDataView, self._onCharacterDataViewOpenFromHandbook, self._onCharacterStaticSkinViewUpdate, "content/characterdatatitleview(Clone)/content/character/#simage_characterstaticskin", "characterTitleViewStaticOffset", nil, nil, nil, true)
	self:_addView("皮肤界面静态立绘", ViewName.CharacterSkinView, self._onCharacterSkinSwitchViewOpen, self._onCharacterSkinStaticDrawingViewUpdate1, "characterSpine/#go_skincontainer/#simage_skin", "skinViewImgOffset", nil, nil, nil, true)
	self:_addView("皮肤获得界面静态立绘", ViewName.CharacterSkinGainView, self._onCharacterSkinGainViewOpen, self._onCharacterSkinStaticDrawingViewUpdate, "root/bgroot/#go_skincontainer/#simage_icon", "skinGainViewImgOffset", nil, nil, nil, true)
	self:_addView("角色界面静态立绘", ViewName.CharacterView, self._onCharacterViewChangeStaticDrawingOpen, self._onCharacterViewSkinStaticDrawingViewUpdate, "anim/#go_herocontainer/staticcontainer/#simage_static", "characterViewImgOffset", nil, nil, nil, true)
	self:_addView("招募界面静态立绘", ViewName.SummonHeroDetailView, self._onCharacterGetViewOpen, self._onCharacterSkinStaticDrawingViewUpdate, "charactercontainer/#simage_character", "summonHeroViewOffset", nil, nil, nil, true)
	self:_addView("个人名片", ViewName.NewPlayerCardContentView, self._onPlayerCardViewOpen, self._onPlayerCardViewStaticDrawingUpdate, "view", "playercardViewImgOffset", "characterViewImgOffset", nil, nil, true)
	self:_addView("装饰商店静态立绘", ViewName.StoreView, self._onDecorateStoreStaticViewOpen, self._onDecorateStoreStaticViewUpdate, "#go_store/decoratestoreview(Clone)/Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer", "decorateskinOffset", nil, nil, nil, true)
	self:_addView("6选3Up", ViewName.SummonThreeCustomPickView, self._onSummonCustomThreePickOpen, self._onSummonCustomThreePickDataUpdate, "#go_ui/current/#go_selected/#go_role%s/#simage_role%s", "summonPickUpImgOffset", nil, nil, nil, true)
	table.insert(self._viewNameList, "0#spine小人")
	self:_addView("皮肤界面小人Spine", ViewName.CharacterSkinView, self._onCharacterSkinSwitchViewOpen, self._onCharacterSkinSwitchViewUpdate, "smalldynamiccontainer/#go_smallspine", "skinSpineOffset")
	table.insert(self._viewNameList, "0#皮肤放大缩小界面")
	self:_addView("皮肤放大缩小界面live2d", ViewName.CharacterSkinFullScreenView, self._onCharacterSkinFullViewOpen, self._onCharacterSkinFullViewUpdate, "#go_scroll/dynamicContainer/#go_spinecontainer/#go_spine", "fullScreenLive2dOffset", "characterViewOffset", self.beforeOpenSkinFullView, self.beforeCloseSkinFullView)
	self:initViewItem()
end

function SkinOffsetAdjustView:_addView(name, moduleViewName, openCallback, updateCallback, containerName, offsetName, parentOffsetName, beforeOpenView, beforeCloseView, isHeadiconImg)
	local param = {
		viewInfo = {
			name,
			moduleViewName,
			openCallback,
			updateCallback,
			containerName,
			offsetName,
			parentOffsetName,
			isHeadiconImg
		},
		beforeOpenView = beforeOpenView,
		beforeCloseView = beforeCloseView
	}

	table.insert(self._viewList, param)
	table.insert(self._viewNameList, name)
end

function SkinOffsetAdjustView:initViewItem()
	local index = 0
	local viewItem

	self.viewItemList = {}

	for i, viewName in ipairs(self._viewNameList) do
		viewItem = self:getUserDataTb_()
		viewItem.go = gohelper.cloneInPlace(self._goviewitem, i)
		viewItem.goSelect = gohelper.findChild(viewItem.go, "#go_select")

		gohelper.setActive(viewItem.go, true)
		gohelper.setActive(viewItem.goSelect, false)

		if self:isHeaderView(viewName) then
			viewName = string.gsub(viewName, "^0#", "")
		else
			index = index + 1
			viewItem.click = gohelper.getClick(viewItem.go)

			viewItem.click:AddClickListener(self._onViewValueClick, self, viewItem)

			viewName = "    " .. index .. "." .. viewName

			table.insert(self.viewItemList, viewItem)
		end

		viewItem.viewName = viewName
		viewItem.index = index
		gohelper.findChildText(viewItem.go, "#txt_skinname").text = viewName
	end
end

function SkinOffsetAdjustView:isHeaderView(viewName)
	return string.match(viewName, "^0#.*")
end

function SkinOffsetAdjustView:_onMainViewOpen(viewInfo)
	self:_onMainViewUpdate()
end

function SkinOffsetAdjustView:_onMainViewFrameOpen(viewInfo)
	self:_onMainViewFrameUpdate()
end

function SkinOffsetAdjustView:showTrigger()
	gohelper.setActive(self._gotrigger, true)

	for i = 1, triggerNum do
		self:updateTrigger(i)
	end
end

function SkinOffsetAdjustView:updateTrigger(index)
	local list = SkinOffsetAdjustModel.instance:getTrigger(self._curSkinInfo, "triggerArea" .. index)

	for i = 1, 4 do
		local triggerGo = self["_gotrigger" .. index .. i]
		local value = list[i]

		if value then
			gohelper.setActive(triggerGo, true)

			local startX, startY, endX, endY = unpack(value)

			recthelper.setAnchor(triggerGo.transform, startX, startY)
			recthelper.setSize(triggerGo.transform, endX - startX, startY - endY)
		else
			gohelper.setActive(triggerGo, false)
		end
	end
end

function SkinOffsetAdjustView:saveTrigger(index)
	local result = {}

	for i = 1, 4 do
		local value = self:getOneTrigger(index, i)

		if value then
			table.insert(result, value)
		end
	end

	if #result == 0 then
		return
	end

	SkinOffsetAdjustModel.instance:setTrigger(self._curSkinInfo, "triggerArea" .. index, result)
end

function SkinOffsetAdjustView:getOneTrigger(index, i)
	local triggerGo = self["_gotrigger" .. index .. i]

	if not triggerGo.activeSelf then
		return
	end

	local startX, startY = recthelper.getAnchor(triggerGo.transform)
	local width, height = recthelper.getWidth(triggerGo.transform), recthelper.getHeight(triggerGo.transform)
	local endX = width + startX
	local endY = startY - height

	startX = string.format("%.1f", startX)
	startY = string.format("%.1f", startY)
	endX = string.format("%.1f", endX)
	endY = string.format("%.1f", endY)

	return {
		startX,
		startY,
		endX,
		endY
	}
end

function SkinOffsetAdjustView:setOffset(skinInfo, key, callback, defaultOffset, parentKey, precisionDefine)
	gohelper.setActive(self._gooffset, true)

	local constId = -1

	self._txtoffsetkey.text = "currentKey : " .. key

	if string.nilorempty(parentKey) then
		self._txtoffsetParentKey.text = ""
		self._txtoffsetValue.text = ""
	else
		self._txtoffsetParentKey.text = "parentKey : " .. parentKey
		constId = SkinOffsetAdjustView.key2ParentKeyConstIdDict[key]

		if not SkinOffsetAdjustView.key2ParentKeyConstIdDict[key] then
			logError(string.format("'%s' -> '%s' not config const id", key, parentKey))
		end

		self._txtoffsetValue.text = "offsetValue  : " .. CommonConfig.instance:getConstStr(constId)
	end

	self._curOffsetKey = key

	if key == "decorateskinOffset" or key == "decorateskinl2dOffset" then
		local decorateCo = DecorateStoreConfig.instance:getDecorateConfig(700005)
		local offsets = string.splitToNumber(decorateCo[key], "#")
		local x, y, s = defaultOffset[1], defaultOffset[2], defaultOffset[3]

		if #offsets == 3 then
			x = offsets[1]
			y = offsets[2]
			s = offsets[3]
		end

		callback(x, y, s)

		self._changeOffsetCallback = callback
		self._precisionDefine = precisionDefine

		self:initSliderValue(x, y, s)
	elseif key == "skin2dParams" then
		local offsets = string.split(self._curSkinInfo[key], "#")
		local pos = offsets[2] and string.splitToNumber(offsets[2], ",") or {
			0,
			0
		}
		local s = offsets[3] and tonumber(offsets[3]) or 1
		local x = pos[1]
		local y = pos[2]

		callback(x, y, s)

		self._changeOffsetCallback = callback
		self._precisionDefine = precisionDefine

		self:initSliderValue(x, y, s)
	else
		local x, y, s, isNull = SkinOffsetAdjustModel.instance:getOffset(self._curSkinInfo, key, parentKey, constId)

		if isNull and defaultOffset then
			x = defaultOffset[1]
			y = defaultOffset[2]
			s = defaultOffset[3]
		end

		callback(x, y, s)

		self._changeOffsetCallback = callback
		self._precisionDefine = precisionDefine

		self:initSliderValue(x, y, s)
	end
end

function SkinOffsetAdjustView:getCurViewGo()
	local viewName = self._curViewInfo[2]
	local viewContainer = ViewMgr.instance:getContainer(viewName)

	if not viewContainer then
		logError("view Container is nil, " .. tostring(viewName))

		return
	end

	return viewContainer.viewGO
end

function SkinOffsetAdjustView:_onMainViewFrameUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = "mainViewOffset"
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local container = gohelper.findChild(viewGo, containerName)

	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = container.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end)
	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, self._curSkinInfo, true)
	TaskDispatcher.runDelay(function()
		MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, self._curSkinInfo, false)

		local offsetName = self._curViewInfo[6]
		local container = gohelper.find(string.format("cameraroot/SceneRoot/MainScene/%s_p(Clone)/s01_obj_a/Anim/Drawing/spine", MainSceneSwitchModel.instance:getCurSceneResName()))

		self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
			local transform = container.transform

			transformhelper.setLocalPosXY(transform, x, y)

			transform.localScale = Vector3.one * s
		end, {
			3.11,
			0.51,
			0.39
		}, nil, {
			s = 2,
			x = 2,
			y = 2
		})
	end, nil, 0.5)
end

function SkinOffsetAdjustView:_onMainViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	self:_onMainViewSwitchHeroUpdate()
	self:showTrigger()
end

function SkinOffsetAdjustView:_onMainViewSwitchHeroUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local container = gohelper.findChild(viewGo, containerName)

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, self._curSkinInfo, true)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = container.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end)
end

function SkinOffsetAdjustView:_onCharacterSwitchUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local container = gohelper.findChild(viewGo, containerName)

	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, self._curSkinInfo, true)

	self._lightSpine = LightModelAgent.Create(container, true)

	self._lightSpine:setResPath(self._curSkinInfo)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = container.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end)
end

function SkinOffsetAdjustView:_onCharacterViewUpdate(needReset)
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	if needReset then
		self:_onCharacterHoloUpdate()
	end

	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local container = gohelper.findChild(viewGo, containerName)

	self._uiSpine = GuiModelAgent.Create(container, true)

	self._uiSpine:setResPath(self._curSkinInfo)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = container.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end)
end

function SkinOffsetAdjustView:_onCharacterHoloUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local containerName = "anim/bgcanvas/bg/#simage_playerbg"
	local container = gohelper.findChild(viewGo, containerName)

	self:setOffset(self._curSkinInfo, "haloOffset", function(x, y, s)
		local transform = container.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end)
end

function SkinOffsetAdjustView:_onCharacterRankUpViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local parentOffsetName = self._curViewInfo[7]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local container = gohelper.findChild(viewGo, containerName)

	self._uiSpine = GuiModelAgent.Create(container, true)

	self._uiSpine:setResPath(self._curSkinInfo)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = container.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end, {
		0,
		0,
		1
	}, parentOffsetName)
end

function SkinOffsetAdjustView:_onCharacterSkinViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local parentOffsetName = self._curViewInfo[7]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local container = gohelper.findChild(viewGo, containerName)

	self._uiSpine = GuiModelAgent.Create(container, true)

	self._uiSpine:setResPath(self._curSkinInfo)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = container.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end, {
		0,
		0,
		1
	}, parentOffsetName)
end

function SkinOffsetAdjustView:_onCharacterStaticSkinViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local imgGo = gohelper.findChild(viewGo, containerName)
	local img = gohelper.getSingleImage(imgGo)

	img:LoadImage(ResUrl.getHeadIconImg(self._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(img.gameObject)
	end, nil)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = img.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end, {
		-400,
		500,
		0.68
	})
end

function SkinOffsetAdjustView:_onCharacterSkinSwitchViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local container = gohelper.findChild(viewGo, containerName)

	self._uiSpine = GuiSpine.Create(container, false)

	self._uiSpine:setResPath(ResUrl.getSpineUIPrefab(self._curSkinInfo.spine))
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = container.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end)
end

function SkinOffsetAdjustView:_onPlayerCardViewStaticDrawingUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local childviewcontainer = gohelper.findChild(viewGo, containerName)
	local viewgo = childviewcontainer.transform:GetChild(0).gameObject
	local offsetName = self._curViewInfo[6]
	local parentOffsetName = self._curViewInfo[7]
	local imgGo = gohelper.findChild(viewgo, "root/main/top/role/skinnode/#simage_role")
	local img = gohelper.getSingleImage(imgGo)

	img:LoadImage(ResUrl.getHeadIconImg(self._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(img.gameObject)
	end, nil)

	self.playCardViewStaticDrawingDefaultOffset = self.playCardViewStaticDrawingDefaultOffset or {
		-150,
		-150,
		0.6
	}

	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = img.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end, self.playCardViewStaticDrawingDefaultOffset, parentOffsetName)
end

function SkinOffsetAdjustView:_onDecorateStoreStaticViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local viewgo = gohelper.findChild(viewGo, containerName)
	local simageSkin = gohelper.findChildSingleImage(viewgo, "#simage_skin")
	local offsetName = self._curViewInfo[6]

	simageSkin:LoadImage(ResUrl.getHeadIconImg(self._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(simageSkin.gameObject)

		local offsetStr = self._curSkinInfo.skinViewImgOffset

		if not string.nilorempty(offsetStr) then
			local offsets = string.splitToNumber(offsetStr, "#")

			recthelper.setAnchor(simageSkin.transform, tonumber(offsets[1]), tonumber(offsets[2]))
			transformhelper.setLocalScale(simageSkin.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
		else
			recthelper.setAnchor(simageSkin.transform, -150, -150)
			transformhelper.setLocalScale(simageSkin.transform, 0.6, 0.6, 0.6)
		end
	end, nil)

	local offset = {
		0,
		0,
		1
	}

	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = viewgo.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end, offset)
end

function SkinOffsetAdjustView:_onCharacterSkinStaticDrawingViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local imgGo = gohelper.findChild(viewGo, containerName)
	local img = gohelper.getSingleImage(imgGo)

	img:LoadImage(ResUrl.getHeadIconImg(self._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(img.gameObject)
	end, nil)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = img.transform.parent

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end)
end

function SkinOffsetAdjustView:_onCharacterSkinDynamicDrawingViewUpdate1()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local viewgo = gohelper.findChild(viewGo, containerName)
	local spineGo = gohelper.findChild(viewgo, "#go_spinecontainer/#go_spine")
	local simagel2d = gohelper.findChildSingleImage(viewgo, "#simage_l2d")
	local offsetName = self._curViewInfo[6]

	TaskDispatcher.runDelay(function()
		if not string.nilorempty(self._curSkinInfo.live2dbg) then
			gohelper.setActive(simagel2d.gameObject, true)
			simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(self._curSkinInfo.live2dbg))
		else
			gohelper.setActive(simagel2d.gameObject, false)
		end

		self._uiSpine = GuiModelAgent.Create(spineGo, true)

		self._uiSpine:setResPath(self._curSkinInfo, function()
			self._uiSpine:setAllLayer(UnityLayer.SceneEffect)

			local offsetStr = self._curSkinInfo.skinSwitchLive2dOffset

			if string.nilorempty(offsetStr) then
				offsetStr = self._curSkinInfo.characterViewOffset
			end

			local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

			recthelper.setAnchor(spineGo.transform, tonumber(offsets[1]), tonumber(offsets[2]))
			transformhelper.setLocalScale(spineGo.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
		end)

		local isLive2d = not string.nilorempty(self._curSkinInfo.live2d)

		if isLive2d then
			self._uiSpine:setLive2dCameraLoadedCallback(function()
				gohelper.setAsFirstSibling(simagel2d.gameObject)
			end)
		end

		self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
			local transform = viewgo.transform

			recthelper.setAnchor(transform, x, y)

			transform.localScale = Vector3.one * s
		end, {
			0,
			0,
			1
		})
	end, nil, 0.5)
end

function SkinOffsetAdjustView:_onCharacterSkinStaticDrawingViewUpdate1()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local imgGo = gohelper.findChild(viewGo, containerName)
	local img = gohelper.getSingleImage(imgGo)

	img:LoadImage(ResUrl.getHeadIconImg(self._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(img.gameObject)
	end, nil)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		recthelper.setAnchor(img.transform, x, y)

		img.transform.localScale = Vector3.one * s
	end)
end

function SkinOffsetAdjustView:_onCharacterViewSkinStaticDrawingViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local imgGo = gohelper.findChild(viewGo, containerName)
	local img = gohelper.getSingleImage(imgGo)

	img:LoadImage(ResUrl.getHeadIconImg(self._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(img.gameObject)
	end, nil)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = img.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end)
end

function SkinOffsetAdjustView:_onCharacterSkinGetDetailViewBaseUpdate(imgPath)
	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local imgGo = gohelper.findChild(viewGo, containerName)
	local img = gohelper.getSingleImage(imgGo)

	img:LoadImage(imgPath, function()
		return
	end, nil)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = img.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end)
end

function SkinOffsetAdjustView:_onCharacterDataTitleViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	self:_onCharacterSkinGetDetailViewBaseUpdate(ResUrl.getHeadIconImg(self._curSkinInfo.id))
end

function SkinOffsetAdjustView:_onPlayerClothViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local container = gohelper.findChild(viewGo, containerName)
	local charactericon = gohelper.getSingleImage(container)

	charactericon:LoadImage(ResUrl.getHeadIconImg(self._curSkinInfo.id), function()
		ZProj.UGUIHelper.SetImageSize(charactericon.gameObject)
	end)

	self._simageList[charactericon] = true

	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = charactericon.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end)
end

function SkinOffsetAdjustView:_onCharacterDataVoiceViewUpdate()
	CharacterController.instance:dispatchEvent(CharacterEvent.SelectPage, 2)

	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local offsetName = self._curViewInfo[6]
	local parentOffsetName = self._curViewInfo[7]

	TaskDispatcher.runDelay(function()
		local containerName = self._curViewInfo[5]
		local viewGo = self:getCurViewGo()

		if not viewGo then
			return
		end

		local container = gohelper.findChild(viewGo, containerName)

		self._uiSpine = GuiModelAgent.Create(container, true)

		self._uiSpine:setResPath(self._curSkinInfo)
		self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
			local transform = container.transform

			recthelper.setAnchor(transform, x, y)

			transform.localScale = Vector3.one * s
		end, {
			0,
			0,
			1
		}, parentOffsetName)
	end, nil, 0.5)
end

function SkinOffsetAdjustView:_onPlayerCardViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local childviewcontainer = gohelper.findChild(viewGo, containerName)
	local viewgo = childviewcontainer.transform:GetChild(0).gameObject
	local container = gohelper.findChild(viewgo, "root/main/top/role/skinnode/")
	local skinimage = gohelper.findChild(viewgo, "root/main/top/role/skinnode/#simage_role")

	gohelper.setActive(skinimage, false)

	local offsetName = self._curViewInfo[6]
	local parentOffsetName = self._curViewInfo[7]

	TaskDispatcher.runDelay(function()
		self._uiSpine = GuiModelAgent.Create(container, true)

		self._uiSpine:setResPath(self._curSkinInfo)
		self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
			local transform = container.transform

			recthelper.setAnchor(transform, x, y)

			transform.localScale = Vector3.one * s
		end, {
			0,
			0,
			1
		}, parentOffsetName)
	end, nil, 0.5)
end

function SkinOffsetAdjustView:_onDecorateStoreViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local viewgo = gohelper.findChild(viewGo, containerName)

	if not viewgo then
		logError("container name is nil .. " .. tostring(containerName))

		return
	end

	local spineGo = gohelper.findChild(viewgo, "#go_spinecontainer/#go_spine")
	local simagel2d = gohelper.findChildSingleImage(viewgo, "#go_spinecontainer/#simage_l2d")
	local offsetName = self._curViewInfo[6]

	TaskDispatcher.runDelay(function()
		if not string.nilorempty(self._curSkinInfo.live2dbg) then
			gohelper.setActive(simagel2d.gameObject, true)
			simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(self._curSkinInfo.live2dbg))
		else
			gohelper.setActive(simagel2d.gameObject, false)
		end

		self._uiSpine = GuiModelAgent.Create(spineGo, true)

		self._uiSpine:setResPath(self._curSkinInfo, function()
			local offsetStr = self._curSkinInfo.skinViewLive2dOffset

			if string.nilorempty(offsetStr) then
				offsetStr = self._curSkinInfo.characterViewOffset
			end

			local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

			recthelper.setAnchor(spineGo.transform, tonumber(offsets[1]), tonumber(offsets[2]))
			transformhelper.setLocalScale(spineGo.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
		end)

		local isLive2d = not string.nilorempty(self._curSkinInfo.live2d)

		if isLive2d then
			self._uiSpine:setLive2dCameraLoadedCallback(function()
				gohelper.setAsFirstSibling(simagel2d.gameObject)
			end)
		end

		self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
			local transform = viewgo.transform

			recthelper.setAnchor(transform, x, y)

			transform.localScale = Vector3.one * s
		end, {
			0,
			0,
			1
		})
	end, nil, 0.5)
end

function SkinOffsetAdjustView:_onClothesStoreViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local spineData = {}
	local spineParam = string.split(self._curSkinInfo.skin2dParams, "#")

	spineData.spinePath = spineParam[1]
	spineData.spinePos = spineParam[2] and string.splitToNumber(spineParam[2], ",") or {
		0,
		0
	}
	spineData.spineScale = spineParam[3] and tonumber(spineParam[3]) or 1

	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local viewgo = gohelper.findChild(viewGo, containerName)
	local spineGo = gohelper.findChild(viewgo, "#go_2d/#go_spinecontainer/#go_spine")
	local simagel2d = gohelper.findChildSingleImage(viewgo, "#go_2d/#simage_skin")

	local function bgCallback()
		ZProj.UGUIHelper.SetImageSize(simagel2d.gameObject)

		local offsetStr = self._curSkinInfo.skinViewImgOffset

		if not string.nilorempty(offsetStr) then
			local offsets = string.splitToNumber(offsetStr, "#")

			recthelper.setAnchor(simagel2d.transform, tonumber(offsets[1]), tonumber(offsets[2]))
			transformhelper.setLocalScale(simagel2d.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
		else
			recthelper.setAnchor(simagel2d.transform, -150, -150)
			transformhelper.setLocalScale(simagel2d.transform, 0.6, 0.6, 0.6)
		end
	end

	simagel2d:LoadImage(ResUrl.getHeadIconImg(self._curSkinInfo.id), bgCallback)
	gohelper.setActive(spineGo, true)

	local offsetName = self._curViewInfo[6]

	self._uiSpine = GuiSpine.Create(spineGo, false)

	local spineRootRect = spineGo.transform

	transformhelper.setLocalPos(spineRootRect, spineData.spinePos[1], spineData.spinePos[2], 0)
	transformhelper.setLocalScale(spineRootRect, spineData.spineScale, spineData.spineScale, spineData.spineScale)

	local function loadCallback()
		self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
			local transform = spineRootRect

			recthelper.setAnchor(transform, x, y)

			transform.localScale = Vector3.one * s
		end, {
			0,
			0,
			1
		})
	end

	TaskDispatcher.runDelay(function()
		self._uiSpine:setResPath(spineData.spinePath, loadCallback)
	end, nil, 0.5)
end

function SkinOffsetAdjustView:_onCharacterViewOpen()
	self:_onCommonCharacterViewOpen()
	gohelper.setActive(self._btnswitchOffset.gameObject, true)
end

function SkinOffsetAdjustView:_onCharacterViewChangeStaticDrawingOpen()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local param = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(param.heroId)

	param.isSettingSkinOffset = true

	local moduleViewName = self._curViewInfo[2]

	ViewMgr.instance:openView(moduleViewName, param)
end

function SkinOffsetAdjustView:_onCommonCharacterViewOpen()
	FightResultModel.instance.episodeId = 10101
	DungeonModel.instance.curSendEpisodeId = 10101
	DungeonModel.instance.curSendChapterId = 101

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local param = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(param.heroId)

	local moduleViewName = self._curViewInfo[2]

	ViewMgr.instance:openView(moduleViewName, param)
end

function SkinOffsetAdjustView:_onCharacterSkinSwitchViewOpenDynamic()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local param = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(param.heroId)

	local moduleViewName = self._curViewInfo[2]

	if moduleViewName == ViewName.CharacterSkinView then
		function CharacterSkinSwitchRightView.onOpen(view)
			CharacterController.instance:dispatchEvent(CharacterEvent.OnSwitchSkinVertical, true, view.viewName)
			view:initViewParam()
			view:refreshHadSkinDict()
			view:initSkinItem()
			view:refreshUI()
		end
	end

	ViewMgr.instance:openView(moduleViewName, param)
end

function SkinOffsetAdjustView:_onCharacterSkinSwitchViewOpen()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local param = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(param.heroId)

	local moduleViewName = self._curViewInfo[2]

	if moduleViewName == ViewName.CharacterSkinView then
		local oldFunc = CharacterSkinLeftView._editableInitView

		function CharacterSkinLeftView._editableInitView(view)
			oldFunc(view)

			view.showDynamicVertical = false
		end
	end

	ViewMgr.instance:openView(moduleViewName, param)
end

function SkinOffsetAdjustView:_onCharacterSkinGainViewOpen()
	local moduleViewName = self._curViewInfo[2]

	ViewMgr.instance:openView(moduleViewName, {
		skinId = 302503
	})
end

function SkinOffsetAdjustView:_onCharacterGetViewOpen()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local moduleViewName = self._curViewInfo[2]
	local param = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	ViewMgr.instance:openView(moduleViewName, {
		heroId = param.heroId
	})
end

function SkinOffsetAdjustView:_onCharacterDataViewOpen()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local param = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(param.heroId)

	local moduleViewName = self._curViewInfo[2]

	TaskDispatcher.runDelay(function()
		ViewMgr.instance:openView(moduleViewName, param.heroId)
	end, nil, 0.5)
end

function SkinOffsetAdjustView:_onPlayerCardViewOpen()
	PlayerCardController.instance:openPlayerCardView()
end

function SkinOffsetAdjustView:_onDecorateStoreViewOpen()
	DecorateStoreModel.instance:setCurGood(700005)

	local moduleViewName = self._curViewInfo[2]

	if moduleViewName == ViewName.StoreView then
		local oldFunc = DecorateStoreView._editableInitView

		function DecorateStoreView._editableInitView(view)
			oldFunc(view)

			view._showLive2d = true
			view._adjust = true
		end
	end

	GameFacade.jump(JumpEnum.JumpId.DecorateStorePay)
end

function SkinOffsetAdjustView:_onDecorateStoreStaticViewOpen()
	DecorateStoreModel.instance:setCurGood(700005)

	local moduleViewName = self._curViewInfo[2]

	if moduleViewName == ViewName.StoreView then
		local oldFunc = DecorateStoreView._editableInitView

		function DecorateStoreView._editableInitView(view)
			oldFunc(view)

			view._showLive2d = false
			view._adjust = true
		end
	end

	GameFacade.jump(JumpEnum.JumpId.DecorateStorePay)
end

function SkinOffsetAdjustView:_onClothesStoreViewOpen()
	SkinOffsetSkinListModel.instance:onInit()

	local moduleViewName = self._curViewInfo[2]

	if moduleViewName == ViewName.StoreView then
		local oldFunc = ClothesStoreView._editableInitView

		function ClothesStoreView._editableInitView(view)
			oldFunc(view)

			view._adjust = true
		end
	end

	GameFacade.jump(10173)
end

function SkinOffsetAdjustView:_onSummonCustomThreePickOpen()
	local moduleViewName = self._curViewInfo[2]
	local poolId = 22161

	SummonMainModel.instance:trySetSelectPoolId(poolId)
	ViewMgr.instance:openView(moduleViewName)
	TaskDispatcher.runDelay(function()
		SummonCustomPickChoiceListModel.instance:initDatas(poolId)
		SummonCustomPickChoiceController.instance:setSelect(3071)
		SummonCustomPickChoiceController.instance:setSelect(3072)
		SummonCustomPickChoiceController.instance:setSelect(3073)

		local selectList = SummonCustomPickChoiceListModel.instance:getSelectIds()
		local pool = SummonMainModel.instance:getCurPool()
		local summonServerMO = SummonMainModel.instance:getPoolServerMO(pool.id)

		if summonServerMO and summonServerMO.customPickMO then
			local pickList = {}

			for _, heroId in ipairs(selectList) do
				table.insert(pickList, heroId)
			end

			summonServerMO.customPickMO.pickHeroIds = pickList
		end

		SummonController.instance:dispatchEvent(SummonEvent.onCustomPicked)
		SummonController.instance:dispatchEvent(SummonEvent.onSummonInfoGot)
	end, nil, 0.1)
end

function SkinOffsetAdjustView:_onSummonCustomThreePickDataUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local containerName = self._curViewInfo[5]
	local offlineName = "#go_ui/current/#go_selected/#go_role%s/#simage_role%s_outline"
	local offsetName = self._curViewInfo[6]
	local maxCount = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()
	local imgs = {}
	local offlines = {}

	for i = 1, maxCount do
		local indexStr = tostring(i)
		local path = string.format(containerName, indexStr, indexStr)
		local imgGo = gohelper.findChild(viewGo, path)
		local img = gohelper.getSingleImage(imgGo)

		img:LoadImage(ResUrl.getHeadIconImg(self._curSkinInfo.id), function()
			ZProj.UGUIHelper.SetImageSize(img.gameObject)
		end, nil)

		local offlinePath = string.format(offlineName, indexStr, indexStr)
		local offlineGo = gohelper.findChild(viewGo, offlinePath)
		local offline = gohelper.getSingleImage(offlineGo)

		offline:LoadImage(ResUrl.getHeadIconImg(self._curSkinInfo.id), function()
			ZProj.UGUIHelper.SetImageSize(offline.gameObject)
		end, nil)
		table.insert(imgs, img)
		table.insert(offlines, offline)
	end

	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local count = #imgs

		for i = 1, count do
			local transform = imgs[i].transform
			local offlineTransform = offlines[i].transform

			recthelper.setAnchor(transform, x, y)

			transform.localScale = Vector3.one * s

			recthelper.setAnchor(offlineTransform, x - 5, y + 2)

			offlineTransform.localScale = Vector3.one * s
		end
	end)
end

function SkinOffsetAdjustView:_onCharacterDataViewOpenFromHandbook()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.SkinOffsetAdjust)

	local param = CharacterBackpackCardListModel.instance:getCharacterCardList()[1]

	CharacterDataModel.instance:setCurHeroId(param.heroId)

	local moduleViewName = self._curViewInfo[2]

	TaskDispatcher.runDelay(function()
		ViewMgr.instance:openView(moduleViewName, {
			adjustStaticOffset = true,
			fromHandbookView = true,
			heroId = param.heroId
		})
	end, nil, 0.5)
end

function SkinOffsetAdjustView:onMainThumbnailViewOpen()
	MainController.instance:openMainThumbnailView()
end

function SkinOffsetAdjustView:onMainThumbnailViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local mainViewSpineContainerGo = UnityEngine.GameObject.Find("UIRoot/HUD/MainView/#go_spine_scale/lightspine")
	local mainThumbnailSpineContainerGo = UnityEngine.GameObject.Find("UIRoot/POPUP_TOP/MainThumbnailView/#go_spine_scale/lightspine")
	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local parentOffsetName = self._curViewInfo[7]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local container = gohelper.findChild(viewGo, containerName)

	container.transform:SetParent(mainViewSpineContainerGo.transform, false)
	MainController.instance:dispatchEvent(MainEvent.ChangeMainHeroSkin, self._curSkinInfo, true, false)
	container.transform:SetParent(mainThumbnailSpineContainerGo.transform, false)
	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = container.transform

		recthelper.setAnchor(transform, x, y)
	end, {
		0,
		0,
		1
	}, parentOffsetName)
end

function SkinOffsetAdjustView:_onViewValueClick(viewItem)
	if viewItem.index == self.selectIndex then
		return
	end

	if self.selectIndex then
		if self._viewList[self.selectIndex] then
			local beforeCloseViewFunc = self._viewList[self.selectIndex].beforeCloseView

			if beforeCloseViewFunc then
				self._viewList[self.selectIndex].beforeCloseView(self)
			end
		end
	end

	self.selectIndex = viewItem.index

	gohelper.setActive(self._btnswitchOffset.gameObject, false)
	gohelper.setActive(self._gotrigger, false)

	self._changeOffsetCallback = nil

	local viewParam = self._viewList[viewItem.index]
	local viewInfo = viewParam.viewInfo
	local openCallback = viewInfo[3]

	self._curViewInfo = viewInfo

	if self.lastSelectViewItem then
		gohelper.setActive(self.lastSelectViewItem.goSelect, false)
	end

	gohelper.setActive(viewItem.goSelect, true)

	self.lastSelectViewItem = viewItem
	self._txtviewlabel.text = viewItem.viewName

	self:_btnblockOnClick()
	self:backToHome()

	local beforeOpenViewFunc = viewParam.beforeOpenView

	if beforeOpenViewFunc then
		viewParam.beforeOpenView(self)
	end

	if openCallback then
		openCallback(self)
	end
end

function SkinOffsetAdjustView:backToHome()
	ViewMgr.instance:closeAllPopupViews()
	MainController.instance:enterMainScene()
end

function SkinOffsetAdjustView:refreshSkin(mo)
	self.selectMo = mo

	self._inputSkinLabel:SetText(mo.skinId .. "#" .. mo.skinName)
	self:_btnblockOnClick()

	self._curSkinInfo = SkinConfig.instance:getSkinCo(mo.skinId)

	self:updateSkin()
end

function SkinOffsetAdjustView:updateSkin()
	if not self._curViewInfo then
		return
	end

	local updateCallback = self._curViewInfo[4]

	if updateCallback then
		updateCallback(self, true)
	end
end

function SkinOffsetAdjustView:onUpdateParam()
	return
end

function SkinOffsetAdjustView:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenView, self)

	module_views.FightSuccView.viewType = ViewType.Full
	module_views.CharacterGetView.viewType = ViewType.Full
end

function SkinOffsetAdjustView:_onOpenView(viewName)
	if not self._curViewInfo then
		return
	end

	local moduleViewName = self._curViewInfo[2]

	if viewName == moduleViewName then
		local updateCallback = self._curViewInfo[4]

		if updateCallback then
			updateCallback(self, true)
		end
	end
end

function SkinOffsetAdjustView:onClickSearch()
	local text = self._inputSkinLabel:GetText()

	if string.nilorempty(text) then
		SkinOffsetSkinListModel.instance:initSkinList()
	elseif string.match(text, "^%d+") then
		SkinOffsetSkinListModel.instance:filterById(text)
	else
		SkinOffsetSkinListModel.instance:filterByName(text)
	end
end

function SkinOffsetAdjustView:onSkinInputValueChanged(text)
	return
end

function SkinOffsetAdjustView:beforeOpenSkinFullView()
	self.isOpenSkinFullView = true
	self.skinViewOldFunc = CharacterSkinFullScreenView.setLocalScale

	function CharacterSkinFullScreenView.setLocalScale(skiView)
		self.skinViewOldFunc(skiView)

		self._txtScale.text = "Scale : " .. skiView.curScaleX
	end

	gohelper.setActive(self.goFullSkinContainer, true)
	SkinOffsetSkinListModel.instance:setInitFilterFunc(self.filterLive2dFunc)
	SkinOffsetSkinListModel.instance:initSkinList()
end

function SkinOffsetAdjustView:beforeCloseSkinFullView()
	self.isOpenSkinFullView = false
	self.live2dCamera = nil
	CharacterSkinFullScreenView.setLocalScale = self.skinViewOldFunc

	gohelper.setActive(self.goFullSkinContainer, false)
	SkinOffsetSkinListModel.instance:setInitFilterFunc(nil)
end

function SkinOffsetAdjustView:_onCharacterSkinFullViewOpen()
	SkinOffsetSkinListModel.instance:initSkinList()

	local skin = SkinOffsetSkinListModel.instance:getFirst()
	local skinCo = SkinConfig.instance:getSkinCo(skin.skinId)
	local param = {
		skinCo = skinCo,
		showEnum = CharacterEnum.ShowSkinEnum.Dynamic
	}

	self._curSkinInfo = skinCo

	ViewMgr.instance:openView(ViewName.CharacterSkinFullScreenView, param)
end

function SkinOffsetAdjustView:_onCharacterSkinFullViewUpdate()
	if not self._curViewInfo or not self._curSkinInfo then
		return
	end

	local cameraSize = SkinOffsetAdjustModel.instance:getCameraSize(self._curSkinInfo.id)

	if not cameraSize then
		cameraSize = self._curSkinInfo.fullScreenCameraSize

		if self._curSkinInfo.fullScreenCameraSize <= 0 then
			cameraSize = CharacterSkinFullScreenView.DefaultLive2dCameraSize
		end
	end

	self._inputCameraSize:SetText(cameraSize)

	local offsetName = self._curViewInfo[6]
	local containerName = self._curViewInfo[5]
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local container = gohelper.findChild(viewGo, containerName)

	self._uiSpine = GuiModelAgent.Create(container, true)

	self._uiSpine:setLive2dCameraLoadedCallback(self.onLive2dCameraLoadedCallback, self)
	self._uiSpine:setResPath(self._curSkinInfo, nil, nil, cameraSize)

	local parentOffsetName = self._curViewInfo[7]

	self:setOffset(self._curSkinInfo, offsetName, function(x, y, s)
		local transform = container.transform

		recthelper.setAnchor(transform, x, y)

		transform.localScale = Vector3.one * s
	end, {
		0,
		0,
		1
	}, parentOffsetName)
end

function SkinOffsetAdjustView:onLive2dCameraLoadedCallback(live2d)
	local viewGo = self:getCurViewGo()

	if not viewGo then
		return
	end

	local goDynamicContainer = gohelper.findChild(viewGo, "#go_scroll/dynamicContainer")

	gohelper.addChild(goDynamicContainer, live2d._rawImageGo)

	local goSpineContainer = gohelper.findChild(viewGo, "#go_scroll/dynamicContainer/#go_spinecontainer")
	local image = live2d._rawImageGo:GetComponent(gohelper.Type_RawImage)

	self.live2dCamera = live2d._camera
	self.live2dRwaImageTexture = image.texture

	recthelper.setAnchor(live2d._rawImageGo.transform, 0, CharacterSkinFullScreenView.DefaultLive2dOffsetY)
	recthelper.setAnchor(goSpineContainer.transform, 0, CharacterSkinFullScreenView.DefaultLive2dOffsetY)

	local previewImage = self:getPreviewImage()

	previewImage.texture = image.texture
end

function SkinOffsetAdjustView:getPreviewImage()
	if not self.previewImage then
		local goImageBg = gohelper.create2d(self.goFullSkinContainer, "previewImageBg")
		local tr = goImageBg.transform

		tr.anchorMin = RectTransformDefine.Anchor.RightMiddle
		tr.anchorMax = RectTransformDefine.Anchor.RightMiddle

		recthelper.setSize(tr, 200, 200)
		recthelper.setAnchor(tr, -100, -150)
		gohelper.onceAddComponent(goImageBg, gohelper.Type_RawImage)

		local goImage = gohelper.create2d(self.goFullSkinContainer, "previewImage")

		tr = goImage.transform
		tr.anchorMin = RectTransformDefine.Anchor.RightMiddle
		tr.anchorMax = RectTransformDefine.Anchor.RightMiddle

		recthelper.setSize(tr, 200, 200)
		recthelper.setAnchor(tr, -100, -150)

		self.previewImage = gohelper.onceAddComponent(goImage, gohelper.Type_RawImage)
	end

	return self.previewImage
end

function SkinOffsetAdjustView:onCameraSizeInput(value)
	value = tonumber(value)

	if not value or value <= 0 then
		value = 14
	end

	if self.live2dCamera then
		self.live2dCamera.orthographicSize = value

		SkinOffsetAdjustModel.instance:saveCameraSize(self._curSkinInfo, value)
	end
end

function SkinOffsetAdjustView.filterLive2dFunc(skinCo)
	return skinCo and not string.nilorempty(skinCo.live2d)
end

function SkinOffsetAdjustView:onClose()
	self._slideroffsetx:RemoveOnValueChanged()
	self._slideroffsety:RemoveOnValueChanged()
	self._slideroffsetscale:RemoveOnValueChanged()
	self:removeDragListener(SLFramework.UGUI.UIDragListener.Get(self._slideroffsetx.gameObject))
	self:removeDragListener(SLFramework.UGUI.UIDragListener.Get(self._slideroffsety.gameObject))
	self:removeDragListener(SLFramework.UGUI.UIDragListener.Get(self._slideroffsetscale.gameObject))

	for _, btn in ipairs(self._btnList) do
		btn:RemoveClickListener()
	end

	self._btnSearch:RemoveClickListener()
	self._goviewcontainerclick:RemoveClickListener()
	self._inputSkinLabel:RemoveOnValueChanged()
	self._inputCameraSize:RemoveOnValueChanged()

	for _, viewItem in ipairs(self.viewItemList) do
		if viewItem.click then
			viewItem.click:RemoveClickListener()
		end
	end

	self.drag:RemoveDragBeginListener()
	self.drag:RemoveDragEndListener()
	self._goskincontainerclick:RemoveClickListener()

	module_views.FightSuccView.viewType = ViewType.Modal
	module_views.CharacterGetView.viewType = ViewType.Normal

	logError("偏移编辑器修改了部分界面的参数，关闭偏移编辑器后应重开游戏再体验！！！")

	CharacterVoiceEnum.RTSizeLegacy = false

	NavigateButtonsView.homeClick()
end

function SkinOffsetAdjustView:removeDragListener(drag)
	drag:RemoveDragBeginListener()
	drag:RemoveDragListener()
	drag:RemoveDragEndListener()
end

function SkinOffsetAdjustView:onDestroyView()
	for k, v in pairs(self._simageList) do
		k:UnLoadImage()
	end
end

return SkinOffsetAdjustView
