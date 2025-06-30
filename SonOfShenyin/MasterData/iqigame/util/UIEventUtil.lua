-- chunkname: @IQIGame\\Util\\UIEventUtil.lua

UIEventUtil = {
	ToggleValueChangeEventHandlerNameTemplate = "__On%sValueChangeHandler",
	ButtonClickEventHandlerNameTemplate = "__On%sClickHandler"
}

function UIEventUtil.HasClickEventListener_Button(owner, buttonName)
	if owner.__uiDelegateProxyTable == nil then
		return false
	end

	if owner.__uiDelegateProxyTable.buttonClick == nil then
		return false
	end

	local delegateProxyFunc = owner.__uiDelegateProxyTable.buttonClick[buttonName]

	if delegateProxyFunc == nil then
		return false
	end

	return true
end

function UIEventUtil.AddClickEventListener_Button(owner, buttonName, customHandler)
	if owner.__uiDelegateProxyTable == nil then
		owner.__uiDelegateProxyTable = {}
	end

	if owner.__uiDelegateProxyTable.buttonClick == nil then
		owner.__uiDelegateProxyTable.buttonClick = {}
	end

	local delegateProxyFunc = owner.__uiDelegateProxyTable.buttonClick[buttonName]

	if delegateProxyFunc ~= nil then
		logError("按钮 {0} 重复注册点击事件", buttonName)

		return nil
	end

	local btnCom = owner[buttonName].gameObject:GetComponent("Button")

	if btnCom == nil then
		logError("按钮点击事件注册失败，lua表 {0} 字段关联GameObject上找不到Button组件", buttonName)

		return nil
	end

	function delegateProxyFunc()
		local handler = customHandler

		if handler == nil then
			local handlerFuncName = UIEventUtil:__GetButtonClickHandlerFuncName(buttonName)

			handler = owner[handlerFuncName]

			if handler == nil then
				logError("未找到按钮 {0} 点击事件回调处理函数 {1}", buttonName, handlerFuncName)

				return
			end
		end

		handler(owner)
	end

	owner.__uiDelegateProxyTable.buttonClick[buttonName] = delegateProxyFunc

	btnCom.onClick:AddListener(delegateProxyFunc)

	return btnCom
end

function UIEventUtil.RemoveClickEventListener_Button(owner, buttonName)
	if owner.__uiDelegateProxyTable == nil then
		return
	end

	if owner.__uiDelegateProxyTable.buttonClick == nil then
		return
	end

	local delegateProxyFunc = owner.__uiDelegateProxyTable.buttonClick[buttonName]

	if delegateProxyFunc == nil then
		return
	end

	local btnCom = owner[buttonName].gameObject:GetComponent("Button")

	if btnCom == nil then
		logError("按钮点击事件移除失败，lua表 {0} 字段关联GameObject上找不到Button组件", buttonName)

		return
	end

	btnCom.onClick:RemoveListener(delegateProxyFunc)

	owner.__uiDelegateProxyTable.buttonClick[buttonName] = nil
end

function UIEventUtil.AddClickEventListener_DoubleButton(owner, buttonName, customHandler)
	if owner.__uiDelegateProxyTable == nil then
		owner.__uiDelegateProxyTable = {}
	end

	if owner.__uiDelegateProxyTable.buttonDoubleClick == nil then
		owner.__uiDelegateProxyTable.buttonDoubleClick = {}
	end

	local delegateProxyFunc = owner.__uiDelegateProxyTable.buttonDoubleClick[buttonName]

	if delegateProxyFunc ~= nil then
		logError("按钮 {0} 重复注册点击事件", buttonName)

		return nil
	end

	local btnCom = owner[buttonName].gameObject:GetComponent("DoubleButton")

	if btnCom == nil then
		logError("按钮点击事件注册失败，lua表 {0} 字段关联GameObject上找不到Button组件", buttonName)

		return nil
	end

	function delegateProxyFunc()
		local handler = customHandler

		if handler == nil then
			local handlerFuncName = UIEventUtil:__GetButtonClickHandlerFuncName(buttonName)

			handler = owner[handlerFuncName]

			if handler == nil then
				logError("未找到按钮 {0} 点击事件回调处理函数 {1}", buttonName, handlerFuncName)

				return
			end
		end

		handler(owner)
	end

	owner.__uiDelegateProxyTable.buttonDoubleClick[buttonName] = delegateProxyFunc

	btnCom.onDoubleClick:AddListener(delegateProxyFunc)

	return btnCom
end

function UIEventUtil.RemoveClickEventListener_DoubleButton(owner, buttonName)
	if owner.__uiDelegateProxyTable == nil then
		return
	end

	if owner.__uiDelegateProxyTable.buttonDoubleClick == nil then
		return
	end

	local delegateProxyFunc = owner.__uiDelegateProxyTable.buttonDoubleClick[buttonName]

	if delegateProxyFunc == nil then
		return
	end

	local btnCom = owner[buttonName].gameObject:GetComponent("DoubleButton")

	if btnCom == nil then
		logError("按钮点击事件移除失败，lua表 {0} 字段关联GameObject上找不到DoubleButton组件", buttonName)

		return
	end

	btnCom.onDoubleClick:RemoveListener(delegateProxyFunc)

	owner.__uiDelegateProxyTable.buttonDoubleClick[buttonName] = nil
end

function UIEventUtil:__GetButtonClickHandlerFuncName(buttonName)
	return string.format(UIEventUtil.ButtonClickEventHandlerNameTemplate, buttonName)
end

function UIEventUtil.AddToggleListener(owner, toggleName, customHandler)
	if owner.__uiDelegateProxyTable == nil then
		owner.__uiDelegateProxyTable = {}
	end

	if owner.__uiDelegateProxyTable.toggle == nil then
		owner.__uiDelegateProxyTable.toggle = {}
	end

	local delegateProxyFunc = owner.__uiDelegateProxyTable.toggle[toggleName]

	if delegateProxyFunc ~= nil then
		logError("按钮 {0} 重复注册点击事件", toggleName)

		return nil
	end

	local toggleCom = owner[toggleName].gameObject:GetComponent("Toggle")

	if toggleCom == nil then
		toggleCom("按钮点击事件注册失败，lua表 {0} 字段关联GameObject上找不到Toggle组件", toggleName)

		return nil
	end

	function delegateProxyFunc(_isOn)
		local handler = customHandler

		if handler == nil then
			local handlerFuncName = UIEventUtil:__GetToggleHandlerFuncName(toggleName)

			handler = owner[handlerFuncName]

			if handler == nil then
				logError("未找到按钮 {0} 点击事件回调处理函数 {1}", toggleName, handlerFuncName)

				return
			end
		end

		handler(owner, _isOn)
	end

	owner.__uiDelegateProxyTable.toggle[toggleName] = delegateProxyFunc

	toggleCom.onValueChanged:AddListener(delegateProxyFunc)

	return toggleCom
end

function UIEventUtil.RemoveToggleListener(owner, toggleName)
	if owner.__uiDelegateProxyTable == nil then
		return
	end

	if owner.__uiDelegateProxyTable.toggle == nil then
		return
	end

	local delegateProxyFunc = owner.__uiDelegateProxyTable.toggle[toggleName]

	if delegateProxyFunc == nil then
		return
	end

	local toggleCom = owner[toggleName].gameObject:GetComponent("Toggle")

	if toggleCom == nil then
		logError("按钮点击事件移除失败，lua表 {0} 字段关联GameObject上找不到Toggle组件", toggleName)

		return
	end

	toggleCom.onValueChanged:RemoveListener(delegateProxyFunc)

	owner.__uiDelegateProxyTable.toggle[toggleName] = nil
end

function UIEventUtil:__GetToggleHandlerFuncName(toggleName)
	return string.format(UIEventUtil.ToggleValueChangeEventHandlerNameTemplate, toggleName)
end

function UIEventUtil.ClearEventListener(owner)
	if owner.__uiDelegateProxyTable == nil then
		return
	end

	ForPairs(owner.__uiDelegateProxyTable.buttonClick, function(_btnName, _delegateProxyFunc)
		local btnCom = owner[_btnName].gameObject:GetComponent("Button")

		if btnCom == nil then
			logError("按钮点击事件移除失败，lua表 {0} 字段关联GameObject上找不到Button组件", _btnName)

			return
		end

		btnCom.onClick:RemoveListener(_delegateProxyFunc)
	end)
	ForPairs(owner.__uiDelegateProxyTable.buttonDoubleClick, function(_btnName, _delegateProxyFunc)
		local btnCom = owner[_btnName].gameObject:GetComponent("DoubleButton")

		if btnCom == nil then
			logError("按钮点击事件移除失败，lua表 {0} 字段关联GameObject上找不到Button组件", _btnName)

			return
		end

		btnCom.onDoubleClick:RemoveListener(_delegateProxyFunc)
	end)
	ForPairs(owner.__uiDelegateProxyTable.toggle, function(_toggleName, _delegateProxyFunc)
		local toggleCom = owner[_toggleName].gameObject:GetComponent("Toggle")

		if toggleCom == nil then
			logError("按钮点击事件移除失败，lua表 {0} 字段关联GameObject上找不到Toggle组件", _toggleName)

			return
		end

		toggleCom.onValueChanged:RemoveListener(_delegateProxyFunc)
	end)

	owner.__uiDelegateProxyTable = nil
end
