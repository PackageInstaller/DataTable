-- chunkname: @/tmp/or_script/lua_compile/cocos/ui/DeprecatedUIFunc.lua

if ccui == nil then
	return
end

local function deprecatedTip(old_name, new_name)
	print("\n********** \n" .. old_name .. " was deprecated please use " .. new_name .. " instead.\n**********")
end

local TextDeprecated = {}

function TextDeprecated:setText(str)
	deprecatedTip("ccui.Text:setText", "ccui.Text:setString")

	return self:setString(str)
end

ccui.Text.setText = TextDeprecated.setText

function TextDeprecated:getStringValue()
	deprecatedTip("ccui.Text:getStringValue", "ccui.Text:getString")

	return self:getString()
end

ccui.Text.getStringValue = TextDeprecated.getStringValue

local TextAtlasDeprecated = {}

function TextAtlasDeprecated:setStringValue(str)
	deprecatedTip("ccui.TextAtlas:setStringValue", "ccui.TextAtlas:setString")

	return self:setString(str)
end

ccui.TextAtlas.setStringValue = TextAtlasDeprecated.setStringValue

function TextAtlasDeprecated:getStringValue()
	deprecatedTip("ccui.TextAtlas:getStringValue", "ccui.TextAtlas:getString")

	return self:getString()
end

ccui.TextAtlas.getStringValue = TextAtlasDeprecated.getStringValue

local TextBMFontDeprecated = {}

function TextBMFontDeprecated:setText(str)
	deprecatedTip("ccui.TextBMFont:setText", "ccui.TextBMFont:setString")

	return self:setString(str)
end

ccui.TextBMFont.setText = TextBMFontDeprecated.setText

function TextBMFontDeprecated:getStringValue()
	deprecatedTip("ccui.Text:getStringValue", "ccui.TextBMFont:getString")

	return self:getString()
end

ccui.Text.getStringValue = TextBMFontDeprecated.getStringValue

local ShaderCacheDeprecated = {}

function ShaderCacheDeprecated:getProgram(strShader)
	deprecatedTip("cc.ShaderCache:getProgram", "cc.ShaderCache:getGLProgram")

	return self:getGLProgram(strShader)
end

cc.ShaderCache.getProgram = ShaderCacheDeprecated.getProgram

local UIWidgetDeprecated = {}

function UIWidgetDeprecated:getLeftInParent()
	deprecatedTip("ccui.Widget:getLeftInParent", "ccui.Widget:getLeftBoundary")

	return self:getLeftBoundary()
end

ccui.Widget.getLeftInParent = UIWidgetDeprecated.getLeftInParent

function UIWidgetDeprecated:getBottomInParent()
	deprecatedTip("ccui.Widget:getBottomInParent", "ccui.Widget:getBottomBoundary")

	return self:getBottomBoundary()
end

ccui.Widget.getBottomInParent = UIWidgetDeprecated.getBottomInParent

function UIWidgetDeprecated:getRightInParent()
	deprecatedTip("ccui.Widget:getRightInParent", "ccui.Widget:getRightBoundary")

	return self:getRightBoundary()
end

ccui.Widget.getRightInParent = UIWidgetDeprecated.getRightInParent

function UIWidgetDeprecated:getTopInParent()
	deprecatedTip("ccui.Widget:getTopInParent", "ccui.Widget:getTopBoundary")

	return self:getTopBoundary()
end

ccui.Widget.getTopInParent = UIWidgetDeprecated.getTopInParent

function UIWidgetDeprecated:getSize()
	deprecatedTip("ccui.Widget:getSize", "ccui.Widget:getContentSize")

	return self:getContentSize()
end

ccui.Widget.getSize = UIWidgetDeprecated.getSize

function UIWidgetDeprecated:setSize(...)
	deprecatedTip("ccui.Widget:setSize", "ccui.Widget:setContentSize")

	return self:setContentSize(...)
end

ccui.Widget.setSize = UIWidgetDeprecated.setSize

local UICheckBoxDeprecated = {}

function UICheckBoxDeprecated:addEventListenerCheckBox(handler)
	deprecatedTip("ccui.CheckBox:addEventListenerCheckBox", "ccui.CheckBox:addEventListener")

	return self:addEventListener(handler)
end

ccui.CheckBox.addEventListenerCheckBox = UICheckBoxDeprecated.addEventListenerCheckBox

function UICheckBoxDeprecated:setSelectedState(flag)
	deprecatedTip("ccui.CheckBox:setSelectedState", "ccui.CheckBox:setSelected")

	return self:setSelected(flag)
end

ccui.CheckBox.setSelectedState = UICheckBoxDeprecated.setSelectedState

function UICheckBoxDeprecated:getSelectedState()
	deprecatedTip("ccui.CheckBox:getSelectedState", "ccui.CheckBox:getSelected")

	return self:getSelected()
end

ccui.CheckBox.getSelectedState = UICheckBoxDeprecated.setSelectedState

local UISliderDeprecated = {}

function UISliderDeprecated:addEventListenerSlider(handler)
	deprecatedTip("ccui.Slider:addEventListenerSlider", "ccui.Slider:addEventListener")

	return self:addEventListener(handler)
end

ccui.Slider.addEventListenerSlider = UISliderDeprecated.addEventListenerSlider

local UITextFieldDeprecated = {}

function UITextFieldDeprecated:addEventListenerTextField(handler)
	deprecatedTip("ccui.TextField:addEventListenerTextField", "ccui.TextField:addEventListener")

	return self:addEventListener(handler)
end

ccui.TextField.addEventListenerTextField = UITextFieldDeprecated.addEventListenerTextField

function UITextFieldDeprecated:setText(str)
	deprecatedTip("ccui.TextField:setText", "ccui.TextField:setString")

	return self:setString(str)
end

ccui.TextField.setText = UITextFieldDeprecated.setText

function UITextFieldDeprecated:getStringValue()
	deprecatedTip("ccui.TextField:getStringValue", "ccui.TextField:getString")

	return self:getString()
end

ccui.TextField.getStringValue = UITextFieldDeprecated.getStringValue

local UIPageViewDeprecated = {}

function UIPageViewDeprecated:addEventListenerPageView(handler)
	deprecatedTip("ccui.PageView:addEventListenerPageView", "ccui.PageView:addEventListener")

	return self:addEventListener(handler)
end

ccui.PageView.addEventListenerPageView = UIPageViewDeprecated.addEventListenerPageView

function UIPageViewDeprecated:addWidgetToPage(widget, pageIdx)
	deprecatedTip("ccui.PageView:addWidgetToPage", "ccui.PageView:insertPage")

	return self:insertPage(widget, pageIdx)
end

ccui.PageView.addWidgetToPage = UIPageViewDeprecated.addWidgetToPage

function UIPageViewDeprecated:getCurPageIndex()
	deprecatedTip("ccui.PageView:getCurPageIndex", "ccui.PageView:getCurrentPageIndex")

	return self:getCurrentPageIndex()
end

ccui.PageView.getCurPageIndex = UIPageViewDeprecated.getCurPageIndex

function UIPageViewDeprecated:setCurPageIndex(index)
	deprecatedTip("ccui.PageView:setCurPageIndex", "ccui.PageView:setCurrentPageIndex")

	return self:setCurrentPageIndex(index)
end

ccui.PageView.setCurPageIndex = UIPageViewDeprecated.setCurPageIndex

function UIPageViewDeprecated:getPages()
	deprecatedTip("ccui.PageView:getPages", "ccui.PageView:getItems")

	return self:getItems()
end

ccui.PageView.getPages = UIPageViewDeprecated.getPages

function UIPageViewDeprecated:getPage(index)
	deprecatedTip("ccui.PageView:getPage", "ccui.PageView:getItem")

	return self:getItem(index)
end

ccui.PageView.getPage = UIPageViewDeprecated.getPage

function UIPageViewDeprecated:setCustomScrollThreshold()
	print("Since v3.9, this method has no effect.")
end

ccui.PageView.setCustomScrollThreshold = UIPageViewDeprecated.setCustomScrollThreshold

function UIPageViewDeprecated:getCustomScrollThreshold()
	print("Since v3.9, this method has no effect.")
end

ccui.PageView.getCustomScrollThreshold = UIPageViewDeprecated.getCustomScrollThreshold

function UIPageViewDeprecated:isUsingCustomScrollThreshold()
	print("Since v3.9, this method has no effect.")
end

ccui.PageView.isUsingCustomScrollThreshold = UIPageViewDeprecated.isUsingCustomScrollThreshold

function UIPageViewDeprecated:setUsingCustomScrollThreshold()
	print("Since v3.9, this method has no effect.")
end

ccui.PageView.setUsingCustomScrollThreshold = UIPageViewDeprecated.setUsingCustomScrollThreshold

local UIScrollViewDeprecated = {}

function UIScrollViewDeprecated:addEventListenerScrollView(handler)
	deprecatedTip("ccui.ScrollView:addEventListenerScrollView", "ccui.ScrollView:addEventListener")

	return self:addEventListener(handler)
end

ccui.ScrollView.addEventListenerScrollView = UIScrollViewDeprecated.addEventListenerScrollView

local UIListViewDeprecated = {}

function UIListViewDeprecated:addEventListenerListView(handler)
	deprecatedTip("ccui.ListView:addEventListenerListView", "ccui.ListView:addEventListener")

	return self:addEventListener(handler)
end

ccui.ListView.addEventListenerListView = UIListViewDeprecated.addEventListenerListView

function UIListViewDeprecated:requestRefreshView()
	deprecatedTip("ccui.ListView:requestRefreshView", "ccui.ListView:forceDoLayout")

	return self:forceDoLayout()
end

ccui.ListView.requestRefreshView = UIListViewDeprecated.requestRefreshView

function UIListViewDeprecated:refreshView()
	deprecatedTip("ccui.ListView:refreshView", "ccui.ListView:refreshView")

	return self:forceDoLayout()
end

ccui.ListView.refreshView = UIListViewDeprecated.refreshView
