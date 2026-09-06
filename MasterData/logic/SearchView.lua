-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/SearchView.lua

module("logic.extensions.tips.view.SearchView", package.seeall)

local SearchView = class("SearchView", TipsViewBase)

function SearchView:buildUI()
	SearchView.super.buildUI(self)

	self._inputField = Framework.InputFieldAdapter.GetFrom(self.mainGO, "InputField")
	self._doSearch = self:getBtn("Search")
	self._searchClose = self:getBtn("Close")
	self._input = self._inputField.input
	self._placeholder = self._input.placeholder:GetComponent("Text")
	self._adjustPosition = self.mainGO:GetComponent("UIAdjustPosition")
end

function SearchView:destroyUI()
	SearchView.super.destroyUI(self)

	self._adjustPosition = nil
	self._inputField = nil
	self._doSearch = nil
	self._searchClose = nil
	self._onSearch = nil
	self._onClose = nil
	self._onSearchTarget = nil
	self._input = nil
	self._placeholder = nil
	self._onValueChange = nil
	self._onEndEdit = nil
	self._eventTarget = nil
	self._closeOnSearch = nil
	self._closeOnClickOutside = nil
end

function SearchView:onEnter()
	SearchView.super.onEnter(self)
	self._doSearch:AddClickListener(self._onClickDoSearch, self)
	self._searchClose:AddClickListener(self._onClickSearchClose, self)
	self:_setupInputField(self._viewPresentor._openParam[1])
	self:_setupSearchConfig(self._viewPresentor._openParam[2])
end

function SearchView:_setupSearchConfig(searchConfig)
	self._onSearch = searchConfig.onSearchHandler
	self._onClose = searchConfig.onCloseHandler
	self._onSearchTarget = searchConfig.searchTarget
	self._closeOnClickOutside = searchConfig.closeOnClickOutside
	self._closeOnSearch = searchConfig.closeOnSearch

	if not searchConfig.pos then
		self._adjustPosition:AdjustScreenPosition()
	end
end

function SearchView:_setupInputField(inputConfig)
	self._placeholder.text = inputConfig.placeHolder
	self._onValueChange = inputConfig.onValueChange
	self._onEndEdit = inputConfig.onEndEdit
	self._eventTarget = inputConfig.eventTarget
	self._input.text = inputConfig.text
	self._input.keyboardType = inputConfig.keyboardType or UnityEngine.TouchScreenKeyboardType.Default
	self._input.inputType = inputConfig.inputType or UnityEngine.UI.InputField.InputType.Standard

	if inputConfig.onValueChange then
		self._inputField:AddOnValueChanged(self._onInputValueChange, self)
	end

	if inputConfig.onEndEdit then
		self._inputField:AddOnEndEdit(self._onInputEndEdit, self)
	end
end

function SearchView:onExit()
	SearchView.super.onExit(self)

	self._onSearch = nil
	self._onSearchTarget = nil
	self._input.text = nil
	self._placeholder.text = nil
	self._onClose = nil
	self._onValueChange = nil
	self._onEndEdit = nil
	self._eventTarget = nil
	self._closeOnClickOutside = nil
	self._closeOnSearch = nil

	self._doSearch:RemoveClickListener()
	self._searchClose:RemoveClickListener()
	self._inputField:RemoveOnValueChanged()
	self._inputField:RemoveOnEndEdit()
end

function SearchView:_onClickDoSearch()
	if self._onSearch then
		if self._onSearchTarget then
			self._onSearch(self._onSearchTarget, self._input.text)
		else
			self._onSearch(self._input.text)
		end
	end

	if self._closeOnSearch then
		self:close()
	end
end

function SearchView:_onClickSearchClose()
	if self._onClose then
		if self._onSearchTarget then
			self._onClose(self._onSearchTarget, self._input.text)
		else
			self._onClose(self._input.text)
		end
	end

	self:close()
end

function SearchView:_onInputValueChange()
	if self._onValueChange then
		if self._eventTarget then
			self._onValueChange(self._eventTarget, self._input.text)
		else
			self._onValueChange(self._input.text)
		end
	end
end

function SearchView:_onInputEndEdit()
	if self._onEndEdit then
		if self._eventTarget then
			self._onEndEdit(self._eventTarget, self._input.text)
		else
			self._onEndEdit(self._input.text)
		end
	end
end

function SearchView:_onCustomInputCallback(hover)
	if self._closeOnClickOutside and not hover and self:_isOnTop() then
		self:_onClickSearchClose()
	end
end

return SearchView
