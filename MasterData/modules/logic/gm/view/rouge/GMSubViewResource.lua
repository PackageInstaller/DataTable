-- chunkname: @modules/logic/gm/view/rouge/GMSubViewResource.lua

module("modules.logic.gm.view.rouge.GMSubViewResource", package.seeall)

local GMSubViewResource = class("GMSubViewResource", GMSubViewBase)

function GMSubViewResource:ctor()
	self.tabName = "资源"
end

function GMSubViewResource:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewResource:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewResource:addFilterVerticalGroup(count)
	self.verticalId = self.verticalId or 0
	self.verticalId = self.verticalId + 1

	local verticalGo = self:addVerticalGroup(self:getLineGroup(), self.verticalId, GMSubViewResource.FilterItemSize.Width, self.filterGroupHeight)
	local inputList = self:getUserDataTb_()

	for i = 1, count do
		table.insert(inputList, self:addVerticalInput(verticalGo, "", "正则表达式"))
	end

	return inputList
end

GMSubViewResource.FilterItemSize = {
	Height = 80,
	Width = 500
}

function GMSubViewResource:addVerticalInput(verticalGo, defaultValue, holderValue)
	local inputTextGo = gohelper.clone(self._goInputTextTemplate, verticalGo, "InputText")

	gohelper.setActive(inputTextGo, true)

	local contentText = gohelper.findChildText(inputTextGo, "Text")
	local placeHolderText = gohelper.findChildText(inputTextGo, "Placeholder")

	self._setFontSize(contentText, nil, 30)
	self._setRectTransSize(inputTextGo, nil, GMSubViewResource.FilterItemSize.Width, GMSubViewResource.FilterItemSize.Height)

	local inputField = SLFramework.UGUI.InputFieldWrap.Get(inputTextGo)
	local type_linetype = tolua.findtype("UnityEngine.UI.InputField+LineType")

	inputField.inputField.lineType = System.Enum.Parse(type_linetype, "MultiLineSubmit")
	placeHolderText.text = holderValue or ""

	inputField:SetText(defaultValue or "")
	inputField:AddOnValueChanged(self.onInputFilterValueChange, self)

	self._inputTexts[#self._inputTexts + 1] = inputField

	return inputField
end

function GMSubViewResource:initViewContent()
	if self._inited then
		return
	end

	self.lineIndex = 1
	self.startToggle = self.addToggle(self, self:getLineGroup(), "开启资源慢加载", self.onStartToggleChange, self)
	self.strategyList = {
		DelayLoadResMgr.DelayStrategyEnum.Multiple,
		DelayLoadResMgr.DelayStrategyEnum.Fixed
	}
	self.strategyNameList = {}

	for _, strategy in ipairs(self.strategyList) do
		table.insert(self.strategyNameList, DelayLoadResMgr.DelayStrategyName[strategy])
	end

	self.strategyDrop = self.addDropDown(self, self:getLineGroup(), "延时策略", self.strategyNameList, self.onStrategyDropValueChange, self)
	self.strategyInput = self.addInputText(self, self:getLineGroup(), "", "延迟数值", self.onStrategyInputValueChange, self)

	self:addLineIndex()
	self:addLabel(self:getLineGroup(), "默认全部文件都会开开启慢加载，如果设置了任意'启用慢加载'， 那么只有匹配的文件才会启用慢加载。'禁用慢加载文件'优先级最高", {
		w = 1200,
		fsize = 25,
		h = 160
	})
	self:addLineIndex()

	self.filterGroupHeight = 500
	self.filterGroupHeight = 500

	local topLeftParam = {
		w = 50,
		h = self.filterGroupHeight,
		align = TMPro.TextAlignmentOptions.Top
	}

	self:addHorizontalGroup(self:getLineGroup(), nil, self.filterGroupHeight)
	self:addLabel(self:getLineGroup(), "启用慢加载文件", topLeftParam)

	self.enablePatternInputList = self:addFilterVerticalGroup(5)

	self:addLabel(self:getLineGroup(), "禁用慢加载文件", topLeftParam)

	self.disablePatternInputList = self:addFilterVerticalGroup(5)

	self:initUIValue()
	GMSubViewResource.super.initViewContent(self)
end

function GMSubViewResource:initUIValue()
	self.startToggle.isOn = DelayLoadResMgr.instance:isStartDelayLoad()

	local curStrategy = DelayLoadResMgr.instance:getDelayStrategy()

	for i, strategy in ipairs(self.strategyList) do
		if curStrategy == strategy then
			self.strategyDrop:SetValue(i - 1)
		end
	end

	local value = DelayLoadResMgr.instance:getDelayStrategyValue()

	self.strategyInput:SetText(value)

	self.enablePatternList = tabletool.copy(DelayLoadResMgr.instance:getEnablePatternList())
	self.disablePatternList = tabletool.copy(DelayLoadResMgr.instance:getDisablePatternList())

	for i, pattern in ipairs(self.enablePatternList) do
		self.enablePatternInputList[i]:SetText(pattern)
	end

	for i, pattern in ipairs(self.disablePatternList) do
		self.disablePatternInputList[i]:SetText(pattern)
	end
end

function GMSubViewResource:onInputFilterValueChange()
	if not self._inited then
		return
	end

	for i, input in ipairs(self.enablePatternInputList) do
		self.enablePatternList[i] = input:GetText()
	end

	for i, input in ipairs(self.disablePatternInputList) do
		self.disablePatternList[i] = input:GetText()
	end

	DelayLoadResMgr.instance:setEnablePatternList(self.enablePatternList)
	DelayLoadResMgr.instance:setDisablePatternList(self.disablePatternList)
end

function GMSubViewResource:onStartToggleChange()
	if not self._inited then
		return
	end

	if self.startToggle.isOn then
		DelayLoadResMgr.instance:startDelayLoad()
	else
		DelayLoadResMgr.instance:stopDelayLoad()
	end
end

function GMSubViewResource:onStrategyDropValueChange(index)
	if not self._inited then
		return
	end

	DelayLoadResMgr.instance:setDelayStrategy(self.strategyList[index + 1])
end

function GMSubViewResource:onStrategyInputValueChange()
	if not self._inited then
		return
	end

	local value = self.strategyInput:GetText()

	value = tonumber(value)

	if not value then
		return
	end

	DelayLoadResMgr.instance:setDelayStrategyValue(value)
end

return GMSubViewResource
