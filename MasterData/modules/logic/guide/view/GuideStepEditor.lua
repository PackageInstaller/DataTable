-- chunkname: @modules/logic/guide/view/GuideStepEditor.lua

module("modules.logic.guide.view.GuideStepEditor", package.seeall)

local GuideStepEditor = class("GuideStepEditor", BaseView)

function GuideStepEditor:onInitView()
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_block")
	self._gotrigger = gohelper.findChild(self.viewGO, "1/#go_trigger")
	self._gotrigger1 = gohelper.findChild(self.viewGO, "1/#go_trigger/#go_trigger1")
	self._gotrigger2 = gohelper.findChild(self.viewGO, "1/#go_trigger/#go_trigger2")
	self._gotrigger3 = gohelper.findChild(self.viewGO, "1/#go_trigger/#go_trigger3")
	self._btnsaveTrigger = gohelper.findChildButtonWithAudio(self.viewGO, "1/#go_trigger/#btn_saveTrigger")
	self._gooffset = gohelper.findChild(self.viewGO, "1/component/#go_offset")
	self._txtoffsetkey = gohelper.findChildText(self.viewGO, "1/component/#go_offset/#txt_offsetkey")
	self._btnsaveOffset = gohelper.findChildButtonWithAudio(self.viewGO, "1/component/#go_offset/#btn_saveOffset")
	self._btnresetOffset = gohelper.findChildButtonWithAudio(self.viewGO, "1/component/#go_offset/#btn_resetOffset")
	self._btnswitchOffset = gohelper.findChildButtonWithAudio(self.viewGO, "1/component/#go_offset/#btn_switchOffset")
	self._goedit = gohelper.findChild(self.viewGO, "#go_edit")
	self._goallmodules = gohelper.findChild(self.viewGO, "#go_edit/#go_allmodules")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_edit/#go_allmodules/#go_container")
	self._txttemp = gohelper.findChildText(self.viewGO, "#go_edit/#go_allmodules/#go_container/#txt_temp")
	self._btnusego = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#go_allmodules/#go_container/#btn_usego")
	self._btncopyuiInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#go_allmodules/#go_container/#btn_copyuiInfo")
	self._txtuse = gohelper.findChildText(self.viewGO, "#go_edit/#go_allmodules/#go_container/#txt_use")
	self._slideroffsetx = gohelper.findChildSlider(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#slider_offsetx")
	self._txtoffsetx = gohelper.findChildText(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#txt_offsetx")
	self._slideroffsety = gohelper.findChildSlider(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#slider_offsety")
	self._txtoffsety = gohelper.findChildText(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/offset/#txt_offsety")
	self._gowidthoffset = gohelper.findChild(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_widthoffset")
	self._slideroffsetw = gohelper.findChildSlider(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_widthoffset/#slider_offsetw")
	self._txtoffsetw = gohelper.findChildText(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_widthoffset/#txt_offsetw")
	self._goheightoffset = gohelper.findChild(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_heightoffset")
	self._slideroffseth = gohelper.findChildSlider(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_heightoffset/#slider_offseth")
	self._txtoffseth = gohelper.findChildText(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_heightoffset/#txt_offseth")
	self._goarrowxoffset = gohelper.findChild(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowxoffset")
	self._slideroffsetarrowx = gohelper.findChildSlider(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowxoffset/#slider_offsetarrowx")
	self._txtoffsetarrowx = gohelper.findChildText(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowxoffset/#txt_offsetarrowx")
	self._goarrowyoffset = gohelper.findChild(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowyoffset")
	self._slideroffsetarrowy = gohelper.findChildSlider(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowyoffset/#slider_offsetarrowy")
	self._txtoffsetarrowy = gohelper.findChildText(self.viewGO, "#go_edit/#go_allmodules/#go_container/offset/#go_arrowyoffset/#txt_offsetarrowy")
	self._togglemask = gohelper.findChildToggle(self.viewGO, "#go_edit/#go_allmodules/#go_container/toggles/#toggle_mask")
	self._toggleshape = gohelper.findChildToggle(self.viewGO, "#go_edit/#go_allmodules/#go_container/toggles/#toggle_shape")
	self._gotextContainer = gohelper.findChild(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer")
	self._slidertipsoffsetx = gohelper.findChildSlider(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#slider_tipsoffsetx")
	self._txttipsoffsetx = gohelper.findChildText(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#txt_tipsoffsetx")
	self._slidertipsoffsety = gohelper.findChildSlider(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#slider_tipsoffsety")
	self._txttipsoffsety = gohelper.findChildText(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer/offset/offset/#txt_tipsoffsety")
	self._btnresettextoffset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#btn_resettextoffset")
	self._btnclearGoPath = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#btn_clearGoPath")
	self._btncopytextinfo = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#btn_copytextinfo")
	self._toggletip = gohelper.findChildToggle(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer/toggles/#toggle_tip")
	self._toggledialogue = gohelper.findChildToggle(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer/toggles/#toggle_dialogue")
	self._inputtext = gohelper.findChildTextMeshInputField(self.viewGO, "#go_edit/#go_allmodules/#go_textContainer/#input_text")
	self._btnpaseuipath = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#go_allmodules/#btn_paseuipath")
	self._inputuse = gohelper.findChildTextMeshInputField(self.viewGO, "#go_edit/#go_allmodules/#input_use")
	self._inputoffset = gohelper.findChildTextMeshInputField(self.viewGO, "#go_edit/#go_allmodules/#input_offset")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#btn_switch")
	self._txtswitch = gohelper.findChildText(self.viewGO, "#go_edit/#btn_switch/#txt_switch")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#btn_close")
	self._btnswitchclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#btn_switchclick")
	self._btnswitchtext = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#btn_switchtext")
	self._btnswitchpos = gohelper.findChildButtonWithAudio(self.viewGO, "#go_edit/#btn_switchpos")
	self._gotype4 = gohelper.findChild(self.viewGO, "#go_type4")
	self._gotipsmask = gohelper.findChild(self.viewGO, "#go_tipsmask")
	self._godialogue = gohelper.findChild(self.viewGO, "#go_dialogue")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#go_dialogue/#txt_content")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_dialogue/#txt_name")
	self._simageleft = gohelper.findChildSingleImage(self.viewGO, "#go_dialogue/left/#simage_left")
	self._simageright = gohelper.findChildSingleImage(self.viewGO, "#go_dialogue/right/#simage_right")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GuideStepEditor:addEvents()
	self._btnblock:AddClickListener(self._btnblockOnClick, self)
	self._btnsaveTrigger:AddClickListener(self._btnsaveTriggerOnClick, self)
	self._btnsaveOffset:AddClickListener(self._btnsaveOffsetOnClick, self)
	self._btnresetOffset:AddClickListener(self._btnresetOffsetOnClick, self)
	self._btnswitchOffset:AddClickListener(self._btnswitchOffsetOnClick, self)
	self._btnusego:AddClickListener(self._btnusegoOnClick, self)
	self._btncopyuiInfo:AddClickListener(self._btncopyuiInfoOnClick, self)
	self._btnresettextoffset:AddClickListener(self._btnresettextoffsetOnClick, self)
	self._btnclearGoPath:AddClickListener(self._btnclearGoPathOnClick, self)
	self._btncopytextinfo:AddClickListener(self._btncopytextinfoOnClick, self)
	self._btnpaseuipath:AddClickListener(self._btnpaseuipathOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnswitchclick:AddClickListener(self._btnswitchclickOnClick, self)
	self._btnswitchtext:AddClickListener(self._btnswitchtextOnClick, self)
	self._btnswitchpos:AddClickListener(self._btnswitchposOnClick, self)
end

function GuideStepEditor:removeEvents()
	self._btnblock:RemoveClickListener()
	self._btnsaveTrigger:RemoveClickListener()
	self._btnsaveOffset:RemoveClickListener()
	self._btnresetOffset:RemoveClickListener()
	self._btnswitchOffset:RemoveClickListener()
	self._btnusego:RemoveClickListener()
	self._btncopyuiInfo:RemoveClickListener()
	self._btnresettextoffset:RemoveClickListener()
	self._btnclearGoPath:RemoveClickListener()
	self._btncopytextinfo:RemoveClickListener()
	self._btnpaseuipath:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnswitchclick:RemoveClickListener()
	self._btnswitchtext:RemoveClickListener()
	self._btnswitchpos:RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._txtoffsetx.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._txtoffsety.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._txtoffsetw.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._txtoffseth.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._txtoffsetarrowx.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._txtoffsetarrowy.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._txttipsoffsetx.gameObject):RemoveClickListener()
	SLFramework.UGUI.UIClickListener.Get(self._txttipsoffsety.gameObject):RemoveClickListener()
	self._inputtext:RemoveOnValueChanged()
	self._inputoffset:RemoveOnValueChanged()
	self._inputoffset:RemoveOnEndEdit()
end

function GuideStepEditor:_btnswitchposOnClick()
	self._changePos = not self._changePos

	if self._changePos then
		recthelper.setAnchor(self._goedit.transform, -634, -590)
	else
		recthelper.setAnchor(self._goedit.transform, 0, 0)
	end
end

function GuideStepEditor:_btnclearGoPathOnClick()
	self._selectedGo = nil
	self._useGo = self._selectedGo
	self._useGoPath = ""

	self._inputuse:SetText(self._useGoPath)

	if self._showText then
		self:updateText()
	end
end

function GuideStepEditor:_btnresettextoffsetOnClick()
	self._slidertipsoffsetx.slider.value = 0
	self._slidertipsoffsety.slider.value = 0
end

function GuideStepEditor:_btncopytextinfoOnClick()
	local str = self._tipPos

	ZProj.UGUIHelper.CopyText(str)
	print("请粘贴提示框信息：", str)
end

function GuideStepEditor:_btnswitchclickOnClick()
	self:_showModule(true)
	self:updateGuide()
end

function GuideStepEditor:_btnswitchtextOnClick()
	self:_showModule(false)
	self:updateText()
end

function GuideStepEditor:_showModule(showClick)
	self._showClick = showClick
	self._showText = not showClick

	gohelper.setActive(self._gocontainer, self._showClick)
	gohelper.setActive(self._gotextContainer, self._showText)
	gohelper.setActive(self._btnswitchtext.gameObject, self._showClick)
	gohelper.setActive(self._btnswitchclick.gameObject, self._showText)
end

function GuideStepEditor:_btnpaseuipathOnClick()
	local path = ZProj.UGUIHelper.GetSystemCopyBuffer()

	if string.nilorempty(path) then
		logError("路径为空")

		return
	end

	local targetGO = gohelper.find(path)

	if gohelper.isNil(targetGO) then
		logError("找不到路径对应的GameObject：" .. path)

		return
	end

	self._selectedGo = targetGO

	self:_btnusegoOnClick()

	if self._showClick then
		self:updateGuide()
	end

	if self._showText then
		self:updateText()
	end
end

function GuideStepEditor:_btncopyuiInfoOnClick()
	local str = string.format("%s\t%s\t%s", self._uiOffset, self._uiInfo, self._useGoPath)

	ZProj.UGUIHelper.CopyText(str)
	print("请粘贴指示框信息：", str)
end

function GuideStepEditor:_btnusegoOnClick()
	if gohelper.isNil(self._selectedGo) then
		return
	end

	local path
	local t = self._selectedGo.transform

	while t ~= nil do
		path = not path and t.name or t.name .. "/" .. path
		t = t.parent
	end

	self._useGo = self._selectedGo
	self._useGoPath = path

	self._inputuse:SetText(self._useGoPath)
end

function GuideStepEditor:_btnblockOnClick()
	return
end

function GuideStepEditor:_btnsaveTriggerOnClick()
	return
end

function GuideStepEditor:_btnsaveOffsetOnClick()
	return
end

function GuideStepEditor:_btnresetOffsetOnClick()
	return
end

function GuideStepEditor:_btnswitchOffsetOnClick()
	return
end

function GuideStepEditor:_btncloseOnClick()
	self:closeThis()
end

function GuideStepEditor:_btnswitchOnClick()
	gohelper.setActive(self._goallmodules, not self._goallmodules.activeSelf)

	self._txtswitch.text = self._goallmodules.activeSelf and "点击隐藏" or "点击显示"
end

function GuideStepEditor:_editableInitView()
	self:initDropUiInfo()
	self._goarrowxoffset:SetActive(false)
	self._goarrowyoffset:SetActive(false)
	self:initSlider(self._slideroffsetx, 1500, -1500, self._onOffsetXChange)
	self:initSlider(self._slideroffsety, 1500, -1500, self._onOffsetYChange)
	self:initSlider(self._slideroffsetarrowx, 1500, -1500, self._onOffsetArrowXChange)
	self:initSlider(self._slideroffsetarrowy, 1500, -1500, self._onOffsetArrowYChange)
	self:initSlider(self._slideroffsetw, 3000, -1, self._onOffsetWChange, 200)
	self:initSlider(self._slideroffseth, 1500, -1, self._onOffsetHChange, 200)
	self:initSlider(self._slidertipsoffsetx, 1500, -1500, self._onTipsOffsetXChange)
	self:initSlider(self._slidertipsoffsety, 1500, -1500, self._onTipsOffsetYChange)
	self._togglemask:AddOnValueChanged(self._onParamValueChange, self)
	self._toggleshape:AddOnValueChanged(self._onParamValueChange, self)
	self._toggledialogue:AddOnValueChanged(self._onTipsParamValueChange, self)
	self._toggletip:AddOnValueChanged(self._onTipsParamValueChange, self)
	self._inputtext:AddOnValueChanged(self._inputValueChanged, self)
	self._inputtext:SetText("这是测试文本！这是测试文本！这是测试文本！")
	self:_showModule(true)

	self._showContainer = true

	self:_cancelRaycastTarget()
	gohelper.setActive(self._inputoffset.gameObject, false)
	self:initTxtOffset(self._txtoffsetx, self._slideroffsetx)
	self:initTxtOffset(self._txtoffsety, self._slideroffsety)
	self:initTxtOffset(self._txtoffsetw, self._slideroffsetw)
	self:initTxtOffset(self._txtoffseth, self._slideroffseth)
	self:initTxtOffset(self._txtoffsetarrowx, self._slideroffsetarrowx)
	self:initTxtOffset(self._txtoffsetarrowy, self._slideroffsetarrowy)
	self:initTxtOffset(self._txttipsoffsetx, self._slidertipsoffsetx)
	self:initTxtOffset(self._txttipsoffsety, self._slidertipsoffsety)
end

function GuideStepEditor:_inputValueChanged()
	if self._showText then
		self:updateText()
	end
end

function GuideStepEditor:_cancelRaycastTarget()
	local leftImage = self._simageleft:GetComponent(gohelper.Type_Image)

	leftImage.raycastTarget = false

	local rightImage = self._simageright:GetComponent(gohelper.Type_Image)

	rightImage.raycastTarget = false

	local crs = self.viewGO:GetComponentsInChildren(typeof(ZProj.GuideMaskHole), true)
	local iter = crs:GetEnumerator()

	while iter:MoveNext() do
		iter.Current.raycastTarget = false
	end
end

function GuideStepEditor:initSlider(slider, maxValue, minValue, callback, defaultValue)
	if callback then
		slider.slider.maxValue = maxValue
		slider.slider.minValue = minValue
		slider.slider.value = defaultValue or 0

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
end

function GuideStepEditor:initTxtOffset(txtOffset, sliderOffset)
	local click = SLFramework.UGUI.UIClickListener.Get(txtOffset.gameObject)

	click:AddClickListener(self._onClickTextOffset, self, {
		txtOffset,
		sliderOffset
	})
end

function GuideStepEditor:_onClickTextOffset(param)
	local txt = param[1]
	local slider = param[2]

	if txt.text == "" then
		return
	end

	self._inputoffset:AddOnValueChanged(function(inputContent)
		local value = tonumber(inputContent)

		if value then
			slider:SetValue(value)
		end
	end, nil)
	self._inputoffset:AddOnEndEdit(function(inputContent)
		gohelper.setActive(self._inputoffset.gameObject, false)
	end, nil)
	gohelper.setActive(self._inputoffset.gameObject, true)
	self._inputoffset:SetText(math.ceil(slider:GetValue()))

	local sliderPos = recthelper.rectToRelativeAnchorPos(slider.transform.position, self._inputoffset.transform.parent)

	recthelper.setAnchorY(self._inputoffset.transform, sliderPos.y)
end

function GuideStepEditor:_onTipsOffsetXChange(param, value)
	self._txttipsoffsetx.text = string.format("x:%s", math.ceil(value))

	self:_onTipsParamValueChange()
end

function GuideStepEditor:_onTipsOffsetYChange(param, value)
	self._txttipsoffsety.text = string.format("y:%s", math.ceil(value))

	self:_onTipsParamValueChange()
end

function GuideStepEditor:_onTipsParamValueChange()
	self:updateText()
end

function GuideStepEditor:_onOffsetXChange(param, value)
	self._txtoffsetx.text = string.format("x:%s", math.ceil(value))

	self:_onParamValueChange()
end

function GuideStepEditor:_onOffsetYChange(param, value)
	self._txtoffsety.text = string.format("y:%s", math.ceil(value))

	self:_onParamValueChange()
end

function GuideStepEditor:_onOffsetArrowXChange(param, value)
	self._txtoffsetarrowx.text = string.format("x:%s", math.ceil(value))

	self:_onParamValueChange()
end

function GuideStepEditor:_onOffsetArrowYChange(param, value)
	self._txtoffsetarrowy.text = string.format("y:%s", math.ceil(value))

	self:_onParamValueChange()
end

function GuideStepEditor:_onOffsetWChange(param, value)
	self._txtoffsetw.text = string.format("w:%s", math.ceil(value))

	self:_onParamValueChange()
end

function GuideStepEditor:_onOffsetHChange(param, value)
	self._txtoffseth.text = string.format("h:%s", math.ceil(value))

	self:_onParamValueChange()
end

function GuideStepEditor:_getCorrectValue(value)
	return tonumber(value) == 0 and 0 or tonumber(value)
end

function GuideStepEditor:_onParamValueChange()
	self:updateGuide()
end

function GuideStepEditor:initDropUiInfo()
	self._dropUiInfo = gohelper.findChildDropdown(self._gocontainer, "#drop_uiInfo")

	self._dropUiInfo:AddOnValueChanged(self._onUiInfoValueChanged, self)

	self._uiInfoList = {
		"请选择类型",
		"圆形",
		"矩形",
		"无挖空遮罩",
		"战斗移牌动画",
		"箭头指示动画",
		"长按指示动画",
		"战斗移牌动画2"
	}

	self._dropUiInfo:AddOptions(self._uiInfoList)
end

function GuideStepEditor:_isArrowType()
	return self._index == GuideEnum.uiTypeArrow or self._index == GuideEnum.uiTypePressArrow
end

function GuideStepEditor:_getTargetWidthAndHeight()
	if self._index == GuideEnum.uiTypeArrow and self._selectedGo then
		if self._selectedGo:GetComponent("RectTransform") then
			local w = recthelper.getWidth(self._selectedGo.transform)
			local h = recthelper.getHeight(self._selectedGo.transform)

			self._slideroffsetw:SetValue(w)
			self._slideroffseth:SetValue(h)
		end

		self:updateGuide()
	end
end

function GuideStepEditor:_onUiInfoValueChanged(index)
	self._index = index

	self:_getTargetWidthAndHeight()
	self._goarrowxoffset:SetActive(self:_isArrowType())
	self._goarrowyoffset:SetActive(self:_isArrowType())
	self:updateGuide()
end

function GuideStepEditor:updateGuide()
	if not self._index or self._index == 0 then
		local param = self:_createGuideViewParam()

		param:initUiType(string.format("%s#%s", GuideEnum.uiTypeNoHole, 0))
		param:setUiOffset(string.format("%s#%s", 0, 0))
		ViewMgr.instance:openView(ViewName.GuideStepEditor, param)

		return
	end

	local x = self:_getCorrectValue(math.ceil(self._slideroffsetx:GetValue()))
	local y = self:_getCorrectValue(math.ceil(self._slideroffsety:GetValue()))
	local maskOn = self._togglemask.isOn and 1 or 0
	local param = self:_createGuideViewParam()

	param:setGoPath(self._useGoPath)

	self._uiOffset = string.format("%s#%s", x, y)

	param:setUiOffset(self._uiOffset)

	param._isStepEditor = true

	if maskOn == 1 then
		self:_setUIType(param, 0)
		ViewMgr.instance:openView(ViewName.GuideStepEditor, param)
	end

	self:_setUIType(param, maskOn)
	ViewMgr.instance:openView(ViewName.GuideStepEditor, param)
end

function GuideStepEditor:_setUIType(param, maskOn)
	local arrowx = self:_getCorrectValue(math.ceil(self._slideroffsetarrowx:GetValue()))
	local arrowy = self:_getCorrectValue(math.ceil(self._slideroffsetarrowy:GetValue()))
	local w = self:_getCorrectValue(math.ceil(self._slideroffsetw:GetValue()))
	local h = self:_getCorrectValue(math.ceil(self._slideroffseth:GetValue()))
	local shapeOn = self._toggleshape.isOn and 1 or 0

	if self._index == GuideEnum.uiTypeCircle then
		self._uiInfo = string.format("%s#%s#%s#%s", self._index, w, maskOn, shapeOn)
	elseif self._index == GuideEnum.uiTypeRectangle then
		self._uiInfo = string.format("%s#%s#%s#%s#%s", self._index, w, h, maskOn, shapeOn)
	elseif self._index == GuideEnum.uiTypeNoHole then
		self._uiInfo = string.format("%s#%s", self._index, maskOn)
	elseif self._index == GuideEnum.uiTypeDragCard or self._index == GuideEnum.uiTypeDragCard2 then
		self._uiInfo = string.format("%s#%s", self._index, maskOn)
	elseif self:_isArrowType() then
		self._uiInfo = string.format("%s#%s#%s#%s#%s#%s#%s#%s", self._index, 2, w, h, arrowx, arrowy, maskOn, shapeOn)
	end

	param:initUiType(self._uiInfo)
end

function GuideStepEditor:updateText()
	local x = self:_getCorrectValue(math.ceil(self._slidertipsoffsetx:GetValue()))
	local y = self:_getCorrectValue(math.ceil(self._slidertipsoffsety:GetValue()))
	local dialogueOn = self._toggledialogue.isOn
	local tipOn = self._toggletip.isOn
	local param = self:_createGuideViewParam()

	param.tipsPos = {
		x,
		y
	}
	self._tipPos = string.format("%s#%s", x, y)

	param:initUiType(string.format("%s#%s", GuideEnum.uiTypeNoHole, 0))
	param:setUiOffset(string.format("%s#%s", 0, 0))

	if dialogueOn then
		param.tipsHead = 302301
		param.tipsTalker = "测试名字"
		param.hasTips = true
	elseif tipOn then
		param.hasTips = true

		param:setGoPath(self._useGoPath)
	end

	param.tipsContent = self._inputtext:GetText()

	ViewMgr.instance:openView(ViewName.GuideStepEditor, param)
end

function GuideStepEditor:_createGuideViewParam()
	local param = GuideViewParam.New()

	param.hasAnyTouchAction = true

	return param
end

function GuideStepEditor:onUpdateParam()
	return
end

function GuideStepEditor:onOpen()
	TaskDispatcher.runRepeat(self._frameUpdate, self, 0.01)
end

function GuideStepEditor:_frameUpdate()
	if not UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftAlt) then
		return
	end

	local go = ZProj.GameHelper.GetLastPointerPress()

	if not gohelper.isNil(go) and go.name ~= "#btn_usego" then
		self._selectedGo = go

		self:_getTargetWidthAndHeight()
	end

	self._txttemp.text = gohelper.isNil(self._selectedGo) and "请选择对象" or self._selectedGo.name

	self:_btnusegoOnClick()

	if self._showClick then
		self:updateGuide()
	end

	if self._showText then
		self:updateText()
	end
end

function GuideStepEditor:onClose()
	TaskDispatcher.cancelTask(self._frameUpdate, self)
	self._dropUiInfo:RemoveOnValueChanged()
	self:clearSlider(self._slideroffsetx)
	self:clearSlider(self._slideroffsety)
	self:clearSlider(self._slideroffsetarrowx)
	self:clearSlider(self._slideroffsetarrowy)
	self:clearSlider(self._slideroffsetw)
	self:clearSlider(self._slideroffseth)
	self:clearSlider(self._slidertipsoffsetx)
	self:clearSlider(self._slidertipsoffsety)
	self._togglemask:RemoveOnValueChanged()
	self._toggleshape:RemoveOnValueChanged()
	self._toggledialogue:RemoveOnValueChanged()
	self._toggletip:RemoveOnValueChanged()
end

function GuideStepEditor:clearSlider(slider)
	slider:RemoveOnValueChanged()
	self:removeDragListener(SLFramework.UGUI.UIDragListener.Get(slider.gameObject))
end

function GuideStepEditor:removeDragListener(drag)
	drag:RemoveDragBeginListener()
	drag:RemoveDragListener()
	drag:RemoveDragEndListener()
end

function GuideStepEditor:onDestroyView()
	return
end

return GuideStepEditor
