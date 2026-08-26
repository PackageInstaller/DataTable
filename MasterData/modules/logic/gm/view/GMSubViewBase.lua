-- chunkname: @modules/logic/gm/view/GMSubViewBase.lua

module("modules.logic.gm.view.GMSubViewBase", package.seeall)

local GMSubViewBase = class("GMSubViewBase", BaseView)
local groupBgColor = Color.New(1, 1, 1, 0.2)
local tabOnColor = Color.New(0.88, 0.84, 0.5, 1)
local tabOffColor = Color.New(0.75, 0.75, 0.75, 0.75)
local lineColor = Color.New(0, 0, 0, 0.5)

function GMSubViewBase:onInitView()
	self._mainViewBg = gohelper.findChild(self.viewGO, "imgBg")
	self._mainViewPort = gohelper.findChild(self.viewGO, "viewport")
	self._mainViewScrollBar = gohelper.findChild(self.viewGO, "Scrollbar")
	self._goSubViews = gohelper.findChild(self.viewGO, "SubViews")
	self._goSubViewTabs = gohelper.findChild(self._goSubViews, "tabRect/Viewport/SubViewTabs")
	self._goTabTemplate = gohelper.findChild(self._goSubViewTabs, "template")
	self._goSubViewTemplate = gohelper.findChild(self._goSubViews, "SubViewTemplate")
	self._goButtonTemplate = gohelper.findChild(self._goSubViews, "ButtonTemplate")
	self._goWikiButtonTemplate = gohelper.findChild(self._goSubViews, "WikiButtonTemplate")
	self._goLabelTemplate = gohelper.findChild(self._goSubViews, "LabelTemplate")
	self._goInputTextTemplate = gohelper.findChild(self._goSubViews, "InputTextTemplate")
	self._goToggleTemplate = gohelper.findChild(self._goSubViews, "ToggleTemplate")
	self._goSliderTemplate = gohelper.findChild(self._goSubViews, "SliderTemplate")
	self._goDropDownTemplate = gohelper.findChild(self._goSubViews, "DropDownTemplate")
	self._goTitleSplitLine = gohelper.findChild(self._goSubViews, "TitleSplitLineTemplate")
	self._scrollViewTemplate = gohelper.findChild(self._goSubViews, "ScrollViewTemplate")
	self._subViewToggleGroup = self._goSubViewTabs:GetComponent(typeof(UnityEngine.UI.ToggleGroup))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GMSubViewBase:_editableInitView()
	self._goTitles = self:getUserDataTb_()
	self._horizontalGroups = self:getUserDataTb_()
	self._buttons = self:getUserDataTb_()
	self._inputTexts = self:getUserDataTb_()
	self._toggles = self:getUserDataTb_()
	self._sliders = self:getUserDataTb_()
	self._dropDowns = self:getUserDataTb_()
	self._verticalGroupDict = self:getUserDataTb_()
	self._wikiURLs = {}
end

function GMSubViewBase:addEvents()
	return
end

function GMSubViewBase:removeEvents()
	return
end

function GMSubViewBase:onOpen()
	local str = PlayerPrefsHelper.getString("GMHideTabNames", "")

	if self.tabName and not tabletool.indexOf((not string.nilorempty(str) or nil) and string.split(str, "#"), self.tabName) then
		self:addSubViewGo(self.tabName)
	end
end

function GMSubViewBase:onClose()
	if self._toggleWrap then
		self._toggleWrap:RemoveOnValueChanged()
	end

	for _, buttonComp in ipairs(self._buttons) do
		buttonComp:RemoveClickListener()
	end

	for _, inputTextComp in ipairs(self._inputTexts) do
		inputTextComp:RemoveOnValueChanged()
	end

	for _, toggleComp in ipairs(self._toggles) do
		toggleComp:RemoveOnValueChanged()
	end

	for _, sliderComp in ipairs(self._sliders) do
		sliderComp:RemoveOnValueChanged()
	end

	for _, dropDownComp in ipairs(self._dropDowns) do
		dropDownComp:RemoveOnValueChanged()
	end
end

function GMSubViewBase:addSubViewGo(subViewName)
	local tabGo = gohelper.clone(self._goTabTemplate, self._goSubViewTabs, subViewName .. "Tab")

	gohelper.setActive(tabGo, true)

	local tabToggle = gohelper.onceAddComponent(tabGo, typeof(UnityEngine.UI.Toggle))

	self._toggleImage = gohelper.onceAddComponent(tabGo, typeof(UnityEngine.UI.Image))
	tabToggle.group = self._subViewToggleGroup
	self._tabText = gohelper.findChildText(tabGo, "Text")
	self._tabText.text = subViewName
	self._toggleWrap = gohelper.onceAddComponent(tabGo, typeof(SLFramework.UGUI.ToggleWrap))

	self._toggleWrap:AddOnValueChanged(self._onToggleValueChanged, self)

	self._subViewGo = gohelper.clone(self._goSubViewTemplate, self._goSubViews, subViewName)
	self._content = gohelper.findChild(self._subViewGo, "viewport/content")

	gohelper.setActive(self._subViewGo, false)
	self.viewContainer:addSubViewToggle(self._toggleWrap)
end

function GMSubViewBase:initViewContent()
	self._inited = true
end

function GMSubViewBase:_onToggleValueChanged(toggleId, isOn)
	if isOn then
		if not self._subViewContent then
			self:initViewContent()
		end

		self.viewContainer:selectToggle(self._toggleWrap)
	end

	local anyToggleOn = self._subViewToggleGroup:AnyTogglesOn()

	gohelper.setActive(self._mainViewBg, not isOn and not anyToggleOn)
	gohelper.setActive(self._mainViewPort, not isOn and not anyToggleOn)

	if isOn then
		self._toggleImage.color = tabOnColor or tabOffColor
	end

	gohelper.setActive(self._subViewGo, isOn)
end

function GMSubViewBase:addHorizontalGroup(groupId, width, height)
	local horizontalGroupGo = UnityEngine.GameObject.New()

	gohelper.addChild(self._content, horizontalGroupGo)

	horizontalGroupGo.name = "horizontal" .. groupId

	local hLayoutGroup = gohelper.onceAddComponent(horizontalGroupGo, gohelper.Type_HorizontalLayoutGroup)
	local padding = hLayoutGroup.padding

	padding.left = 10
	padding.right = 10
	hLayoutGroup.spacing = 20
	hLayoutGroup.childForceExpandWidth = false
	hLayoutGroup.childControlWidth = false
	hLayoutGroup.childControlHeight = false
	hLayoutGroup.childAlignment = UnityEngine.TextAnchor.MiddleLeft

	local groupBgImage = gohelper.onceAddComponent(horizontalGroupGo, gohelper.Type_Image)

	groupBgImage.raycastTarget = false
	groupBgImage.color = groupBgColor

	local hLayoutRectTrans = horizontalGroupGo:GetComponent(gohelper.Type_RectTransform)

	recthelper.setSize(hLayoutRectTrans, width or 1400, height or 100)

	self._horizontalGroups[groupId] = horizontalGroupGo

	return hLayoutGroup
end

function GMSubViewBase:addVerticalGroup(groupId, verticalGroupId, width, height)
	if not self._horizontalGroups[groupId] then
		self:addHorizontalGroup(groupId)
	end

	local groupGo = self._horizontalGroups[groupId]
	local verticalGroupGo = UnityEngine.GameObject.New()

	gohelper.addChild(groupGo, verticalGroupGo)

	verticalGroupGo.name = "vertical" .. verticalGroupId

	local vLayoutGroup = gohelper.onceAddComponent(verticalGroupGo, gohelper.Type_VerticalLayoutGroup)
	local padding = vLayoutGroup.padding

	padding.left = 10
	padding.right = 10
	vLayoutGroup.spacing = 20
	vLayoutGroup.childForceExpandWidth = false
	vLayoutGroup.childControlWidth = false
	vLayoutGroup.childControlHeight = false
	vLayoutGroup.childAlignment = UnityEngine.TextAnchor.MiddleLeft

	local hLayoutRectTrans = verticalGroupGo:GetComponent(gohelper.Type_RectTransform)

	recthelper.setSize(hLayoutRectTrans, width, height)

	self._verticalGroupDict[verticalGroupId] = verticalGroupGo

	return verticalGroupGo
end

function GMSubViewBase:addButton(groupId, label, callback, callbackObj, viewParams)
	if not self._horizontalGroups[groupId] then
		self:addHorizontalGroup(groupId)
	end

	local groupGo = self._horizontalGroups[groupId]
	local buttonGo = gohelper.clone(self._goButtonTemplate, groupGo, "button")

	gohelper.setActive(buttonGo, true)

	local buttonText = gohelper.findChildText(buttonGo, "Text")
	local buttonImage = buttonGo:GetComponent(gohelper.Type_Image)

	buttonText.text = label

	self._setFontSize(buttonText, viewParams, 36)
	self._setGraphicsColor(buttonImage, viewParams)
	self._setRectTransSize(buttonGo, viewParams, buttonText.preferredWidth + 20, 80)
	self._adjustGroupWidthHeight(buttonGo, groupGo)

	local buttonComp = gohelper.getClickWithDefaultAudio(buttonGo)

	buttonComp:AddClickListener(callback, callbackObj)

	self._buttons[#self._buttons + 1] = buttonComp

	return {
		buttonComp,
		buttonText
	}
end

function GMSubViewBase:addWikiButton(groupId, wikiURL)
	if not self._horizontalGroups[groupId] then
		self:addHorizontalGroup(groupId)
	end

	local groupGo = self._horizontalGroups[groupId]
	local buttonGo = gohelper.clone(self._goWikiButtonTemplate, groupGo, "wiki")

	gohelper.setActive(buttonGo, true)

	local buttonComp = gohelper.findChildButtonWithAudio(buttonGo, "Button")

	self._wikiURLs[#self._wikiURLs + 1] = wikiURL

	buttonComp:AddClickListener(self._openWikiURL, self, #self._wikiURLs)

	self._buttons[#self._buttons + 1] = buttonComp
end

function GMSubViewBase:addInputText(groupId, defaultValue, holderValue, valueChangeCb, cbObj, viewParams)
	if not self._horizontalGroups[groupId] then
		self:addHorizontalGroup(groupId)
	end

	local groupGo = self._horizontalGroups[groupId]
	local inputTextGo = gohelper.clone(self._goInputTextTemplate, groupGo, "InputText")

	gohelper.setActive(inputTextGo, true)

	local contentText = gohelper.findChildText(inputTextGo, "Text")
	local placeHolderText = gohelper.findChildText(inputTextGo, "Placeholder")

	self._setFontSize(contentText, viewParams, 36)
	self._setFontSize(placeHolderText, viewParams, 36)
	self._setRectTransSize(inputTextGo, viewParams, 300, 80)
	self._adjustGroupWidthHeight(inputTextGo, groupGo)
	self._setTextAlign(contentText, viewParams)

	local inputField = SLFramework.UGUI.InputFieldWrap.Get(inputTextGo)
	local type_linetype = tolua.findtype("UnityEngine.UI.InputField+LineType")

	inputField.inputField.lineType = System.Enum.Parse(type_linetype, "MultiLineSubmit")
	placeHolderText.text = holderValue or ""

	local prefsKey = string.format("GM_%s_%s_%s", self.__cname, groupId, holderValue)

	if string.nilorempty(defaultValue) then
		inputField:SetText(PlayerPrefsHelper.getString(prefsKey))
	else
		inputField:SetText(defaultValue)
	end

	local function changeCallback(callbackTarget, value)
		if valueChangeCb and cbObj then
			valueChangeCb(cbObj, value)
		end

		local text = inputField:GetText()

		PlayerPrefsHelper.setString(prefsKey, text)
	end

	inputField:AddOnValueChanged(changeCallback, self)

	self._inputTexts[#self._inputTexts + 1] = inputField

	return inputField
end

function GMSubViewBase:addLabel(groupId, labelStr, viewParams)
	if not self._horizontalGroups[groupId] then
		self:addHorizontalGroup(groupId)
	end

	local groupGo = self._horizontalGroups[groupId]
	local transform = groupGo.transform
	local childCount = transform.childCount
	local labelName = labelStr or childCount + 1
	local labelGo = gohelper.clone(self._goLabelTemplate, groupGo, labelName)

	gohelper.setActive(labelGo, true)

	local labelText = gohelper.findChildText(labelGo, "Text")

	labelText.text = labelName

	self._setFontSize(labelText, viewParams, 36)
	self._setGraphicsColor(labelText, viewParams)
	self._setRectTransSize(labelGo, viewParams, labelText.preferredWidth + 20, 80)
	self._setTextAlign(labelText, viewParams)

	return labelText
end

function GMSubViewBase:addToggle(groupId, labelStr, valueChangedCb, cbObj, viewParams)
	if not self._horizontalGroups[groupId] then
		self:addHorizontalGroup(groupId)
	end

	local groupGo = self._horizontalGroups[groupId]
	local transform = groupGo.transform
	local childCount = transform.childCount
	local labelName = labelStr or childCount + 1
	local toggleGo = gohelper.clone(self._goToggleTemplate, groupGo, labelName)

	gohelper.setActive(toggleGo, true)

	local labelText = gohelper.findChildText(toggleGo, "Label")

	labelText.text = labelName

	self._setFontSize(labelText, viewParams, 36)
	self._setGraphicsColor(labelText, viewParams)
	self._setRectTransSize(toggleGo, viewParams, labelText.preferredWidth + 100, 80)

	local toggleWrap = SLFramework.UGUI.ToggleWrap.Get(toggleGo)

	if valueChangedCb and cbObj then
		toggleWrap:AddOnValueChanged(valueChangedCb, cbObj)
	end

	self._toggles[#self._toggles + 1] = toggleWrap

	return toggleWrap
end

function GMSubViewBase:addSlider(groupId, labelStr, valueChangedCb, cbObj, viewParams)
	if not self._horizontalGroups[groupId] then
		self:addHorizontalGroup(groupId)
	end

	local groupGo = self._horizontalGroups[groupId]
	local sliderGo = gohelper.clone(self._goSliderTemplate, groupGo, "Slider")

	gohelper.setActive(sliderGo, true)

	local sliderText = gohelper.findChildText(sliderGo, "Text")

	sliderText.text = labelStr

	self._setGraphicsColor(sliderText, viewParams)
	self._setRectTransSize(sliderGo, viewParams, 600, 80)

	local valueText = gohelper.findChildText(sliderGo, "Slider/ValueTxt")
	local sliderWrap = SLFramework.UGUI.SliderWrap.GetWithPath(sliderGo, "Slider")

	if valueChangedCb and cbObj then
		sliderWrap:AddOnValueChanged(valueChangedCb, cbObj)
	end

	self._sliders[#self._sliders + 1] = sliderWrap

	return {
		sliderWrap,
		sliderText,
		valueText
	}
end

function GMSubViewBase:addDropDown(groupId, labelStr, optionList, valueChangedCb, cbObj, viewParams)
	if not self._horizontalGroups[groupId] then
		self:addHorizontalGroup(groupId)
	end

	local groupGo = self._horizontalGroups[groupId]
	local dropDownGo = gohelper.clone(self._goDropDownTemplate, groupGo, "Dropdown")

	gohelper.setActive(dropDownGo, true)

	local dropDownTitle = gohelper.findChildText(dropDownGo, "Text")
	local dropDownOptionGo = gohelper.findChild(dropDownGo, "Dropdown")

	dropDownTitle.text = labelStr

	self._setFontSize(dropDownTitle, viewParams, 36)
	self._setGraphicsColor(dropDownTitle, viewParams)
	self:_setRectTransSize(viewParams, (viewParams or nil) and (viewParams.total_w or dropDownTitle.preferredWidth + 300), 90)
	self:_setRectTransSize(viewParams, (viewParams or nil) and (viewParams.label_w or dropDownTitle.preferredWidth + 300), 90)
	self:_setRectTransSize(viewParams, (viewParams or nil) and (viewParams.drop_w or dropDownTitle.preferredWidth + 150), 90)

	local tempRectTr = gohelper.findChildComponent(dropDownGo, "Dropdown/Template", gohelper.Type_RectTransform)

	if viewParams and viewParams.tempH then
		recthelper.setHeight(tempRectTr, viewParams.tempH)
	end

	self._setOffset(tempRectTr, viewParams)

	local dropDownComp = gohelper.findChildDropdown(dropDownGo, "Dropdown")

	if valueChangedCb and cbObj then
		dropDownComp:AddOnValueChanged(valueChangedCb, cbObj)
	end

	dropDownComp:ClearOptions()

	if optionList then
		dropDownComp:AddOptions(optionList)
	end

	self._dropDowns[#self._dropDowns + 1] = dropDownComp

	return dropDownComp
end

function GMSubViewBase:addScrollViewLimit(groupId, labelStr, width, height)
	if not self._horizontalGroups[groupId] then
		self:addHorizontalGroup(groupId, width, height)
	end

	local groupGo = self._horizontalGroups[groupId]
	local transform = groupGo.transform
	local childCount = transform.childCount
	local labelName = labelStr or childCount + 1
	local scrollViewRect = gohelper.clone(self._scrollViewTemplate, groupGo, labelName)

	gohelper.setActive(scrollViewRect, true)

	local rectTrans = scrollViewRect:GetComponent(gohelper.Type_RectTransform)

	recthelper.setSize(rectTrans, width, height)

	return scrollViewRect
end

function GMSubViewBase:addSplitLine()
	local lineGo = UnityEngine.GameObject.New()

	gohelper.addChild(self._content, lineGo)

	local lineImage = gohelper.onceAddComponent(lineGo, gohelper.Type_Image)

	lineImage.color = lineColor

	local lineRectTrans = lineGo:GetComponent(gohelper.Type_RectTransform)

	recthelper.setSize(lineRectTrans, 1400, 3)

	return lineGo
end

function GMSubViewBase:addTitleSplitLine(title)
	local titleSplitLineGo = gohelper.clone(self._goTitleSplitLine, self._content, "titleSplitLine")

	gohelper.setActive(titleSplitLineGo, true)

	local titleText = gohelper.findChildText(titleSplitLineGo, "Text")

	titleText.text = title

	gohelper.setActive(titleText.gameObject, not string.nilorempty(title))
	table.insert(self._goTitles, titleSplitLineGo)

	return titleSplitLineGo
end

function GMSubViewBase._setGraphicsColor(graphicsComnp, params)
	if not params or not params.c then
		return
	end

	graphicsComnp.color = SLFramework.UGUI.GuiHelper.ParseColor(params.c)
end

function GMSubViewBase._setRectTransSize(rectGo, params, defaultWidth, defaultHeight)
	local rectTrans = rectGo:GetComponent(gohelper.Type_RectTransform)
	local width = params and params.w
	local height = params and params.h

	recthelper.setSize(rectTrans, width and width or defaultWidth, height and height or defaultHeight)
end

function GMSubViewBase._setFontSize(textComp, params, defaultSize)
	local fontSize = params and params.fsize

	textComp.fontSize = fontSize and fontSize or defaultSize
end

function GMSubViewBase._setTMPTextAlign(textComp, params)
	local align = params and params.align

	if align then
		textComp.alignment = align
	end
end

function GMSubViewBase._setTextAlign(textComp, params)
	local align = params and params.align

	if align then
		textComp.alignment = align
	end
end

function GMSubViewBase:_setOffset(rectTr, params)
	if params and params.offsetMin then
		rectTr.offsetMin = params.offsetMin
	end

	if params and params.offsetMax then
		rectTr.offsetMax = params.offsetMax
	end
end

function GMSubViewBase:_openWikiURL(idx)
	local url = self._wikiURLs[idx]

	if SLFramework.FrameworkSettings.IsEditor then
		UnityEngine.Application.OpenURL(url)
	end
end

function GMSubViewBase._adjustGroupWidthHeight(compGo, groupGo)
	local compRectTrans = compGo:GetComponent(gohelper.Type_RectTransform)
	local groupRectTrans = groupGo:GetComponent(gohelper.Type_RectTransform)
	local compHeight = recthelper.getHeight(compRectTrans)
	local groupHeight = recthelper.getHeight(groupRectTrans)
	local compWidth = recthelper.getWidth(compRectTrans)
	local groupWidth = recthelper.getWidth(groupRectTrans)

	if groupHeight < compHeight then
		recthelper.setHeight(groupRectTrans, compHeight)
	end

	if groupWidth < compWidth then
		recthelper.setWidth(groupRectTrans, compWidth)
	end
end

return GMSubViewBase
