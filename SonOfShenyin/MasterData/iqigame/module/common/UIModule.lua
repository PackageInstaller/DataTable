-- chunkname: @IQIGame\\Module\\Common\\UIModule.lua

UIModule = {
	__mainUIVisible = false,
	uiNameList = {},
	__groupTopUI = {}
}

function UIModule.Initialize()
	UIModule.timerQueue = {}

	UIModule.__InitGroupTopUIName()
	GameEntry.LuaEvent:Subscribe(UIFreezeCompleteOnOpenEventArgs.EventId, UIModule.OnOpenTargetUISuccess)
	GameEntry.LuaEvent:Subscribe(CloseUIFormCompleteEventArgs.EventId, UIModule.__OnCloseUIFormCompleteEvent)
end

function UIModule.Shutdown()
	GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, UIModule.OnOpenTargetUISuccess)
	GameEntry.LuaEvent:Unsubscribe(CloseUIFormCompleteEventArgs.EventId, UIModule.__OnCloseUIFormCompleteEvent)
end

function UIModule.Open(uiName, layer, userData, allowMultiple, ignoreBlur)
	if not ignoreBlur then
		local drawblur = GameEntry.UI:TryDrawBlurBg(uiName)

		if drawblur then
			local timer = FrameTimer.New(function()
				UIModule.Open(uiName, layer, userData, allowMultiple, true)
				table.remove(UIModule.timerQueue, 1)

				if #UIModule.timerQueue > 0 then
					UIModule.timerQueue[1]:Start()
				end
			end, 2, 1)

			if not UIModule.timerQueue then
				UIModule.timerQueue = {}
			end

			if #UIModule.timerQueue <= 0 then
				timer:Start()
			end

			table.insert(UIModule.timerQueue, timer)

			return
		end
	end

	local ret = GameEntry.UI:OpenUIFormByName(uiName, layer, userData, allowMultiple)
	local fadeType = UIModule.GetFadeType(uiName)

	if fadeType ~= Constant.UITransitionEffectType.OpenClose and fadeType ~= Constant.UITransitionEffectType.Open or UIModule.CheckFading() then
		return
	end

	if ret ~= 0 then
		UIModule.ShowFadeIn(fadeType)
	end
end

function UIModule.Close(uiName)
	local success = GameEntry.UI:CloseUIFormByName(uiName)

	if not success then
		return
	end

	UIModule.__ShowFadeOutWhenCloseUI(uiName)
end

function UIModule.__CloseByUIForm(uiForm, uiName)
	local success = GameEntry.UI:CloseUIForm(uiForm)

	if not success then
		return
	end

	UIModule.__ShowFadeOutWhenCloseUI(uiName)
end

function UIModule.__ShowFadeOutWhenCloseUI(uiName)
	local fadeType = UIModule.GetFadeType(uiName)

	if fadeType == Constant.UITransitionEffectType.None or UIModule.CheckFading() then
		return
	end

	UIModule.ShowFadeOut(fadeType)
end

function UIModule.CloseSelf(targetUI)
	if targetUI ~= nil and targetUI.UIController ~= nil and not LuaCodeInterface.GameObjIsDestroy(targetUI.UIController) then
		UIModule.__CloseByUIForm(targetUI.UIController.UIForm, targetUI.UIController.UIName)
	end
end

function UIModule.OnFadeFinished()
	return
end

function UIModule.OnOpenTargetUISuccess(sender, args)
	if args.UIName == Constant.UIControllerName.ComExcessiveUI then
		return
	end

	if UIModule.CheckFading() then
		UIModule.ShowFadeOut()
	end

	UIModule.__UpdateGroupTopUIName(true)
end

function UIModule.__OnCloseUIFormCompleteEvent(sender, args)
	UIModule.__UpdateGroupTopUIName(true)
end

function UIModule.ShowFadeIn(fadeType)
	if fadeType == Constant.UITransitionEffectType.OpenClose or fadeType == Constant.UITransitionEffectType.Open then
		GameEntry.MouseEffect:Stop()

		UIModule.isFading = true

		GameEntry.UI:OpenUIFormByName(Constant.UIControllerName.ComExcessiveUI, Constant.UILayer.Tooltip, {
			UIModule.OnFadeFinished
		})
	end
end

function UIModule.ShowFadeOut(fadeType)
	UIModule.isFading = false

	GameEntry.UI:CloseUIFormByName(Constant.UIControllerName.ComExcessiveUI)

	if fadeType ~= nil and fadeType == Constant.UITransitionEffectType.Open then
		return
	end

	if fadeType == nil or fadeType == Constant.UITransitionEffectType.OpenClose or fadeType == Constant.UITransitionEffectType.Close then
		LuaCodeInterface.ShowCloseUIFadeout()
	end
end

function UIModule.GetFadeType(uiName)
	for i, v in pairsCfg(CfgUIConfigurationTable) do
		if v.UIName == uiName then
			return v.NeedFade
		end
	end

	return 0
end

function UIModule.CheckFading()
	return UIModule.isFading
end

function UIModule.CloseAllUIFrom(excludeUIName)
	excludeUIName = excludeUIName and excludeUIName or {}

	table.insert(excludeUIName, Constant.UIControllerName.GlobalNoticeUI)

	local UIForms = GameEntry.UICom:GetAllLoadedUIForms()
	local needCloseForms = {}

	for i = 1, UIForms.Length do
		local curUIName = string.gsub(UIForms[i - 1].Logic.Name, "%(Clone%)", "")

		if UIForms[i - 1].Logic.Visible and not UIModule._CheckHasUIName(excludeUIName, curUIName) then
			table.insert(needCloseForms, curUIName)
		end
	end

	for i, uiName in ipairs(needCloseForms) do
		UIModule.Close(uiName)
	end
end

function UIModule._CheckHasUIName(UINameList, targetUIName)
	for _, v in pairs(UINameList) do
		if v == targetUIName then
			return true
		end
	end

	return false
end

function UIModule.GetUIGameObjectByName(uiName)
	return GameEntry.UI:GetUIGameObjectByName(uiName)
end

function UIModule.HasUI(uiName)
	return GameEntry.UI:HasUIFormByName(uiName)
end

function UIModule.IsUIFormVisible(uiName)
	return GameEntry.UI:IsUIFormVisible(uiName)
end

function UIModule.IsLoadingUI(uiName)
	return GameEntry.UI:IsLoadingUIFormByName(uiName)
end

function UIModule.CheckUIByName(uiName)
	return GameEntry.UI:CheckUIByName(uiName)
end

function UIModule.HideUIFormByName(uiName)
	GameEntry.UI:HideUIFormByName(uiName)
end

function UIModule.__InitGroupTopUIName()
	UIModule.__mainUIVisible = false
	UIModule.__groupTopUI = {}
	UIModule.__groupTopUI[Constant.UILayer.DefaultUI] = GameEntry.UI:GetUIGroupTopUIName(Constant.UILayer.DefaultUI)
	UIModule.__groupTopUI[Constant.UILayer.UI] = GameEntry.UI:GetUIGroupTopUIName(Constant.UILayer.UI)
	UIModule.__groupTopUI[Constant.UILayer.Mid] = GameEntry.UI:GetUIGroupTopUIName(Constant.UILayer.Mid)
end

function UIModule.__UpdateGroupTopUIName(notice)
	ForPairs(UIModule.__groupTopUI, function(_groupName, _uiName)
		local uiName = GameEntry.UI:GetUIGroupTopUIName(_groupName)

		if uiName == _uiName then
			return
		end

		UIModule.__groupTopUI[_groupName] = uiName

		if not notice then
			return
		end

		EventDispatcher.Dispatch(EventID.UIGroupTopUIChange, _groupName, uiName)
	end)

	if UIModule.MainUIIsVisible() then
		if not UIModule.__mainUIVisible then
			UIModule.__mainUIVisible = true

			EventDispatcher.Dispatch(EventID.MainUIVisible)
		end
	else
		UIModule.__mainUIVisible = false
	end
end

function UIModule.MainUIIsVisible()
	local defaultGroupUIName = UIModule.__groupTopUI[Constant.UILayer.DefaultUI]

	if defaultGroupUIName ~= "MainUI(Clone)" then
		return false
	end

	local uiGroupUIName = UIModule.__groupTopUI[Constant.UILayer.UI]

	if not LuaUtility.StrIsNullOrEmpty(uiGroupUIName) then
		return false
	end

	return true
end

function UIModule.GetUINameWithoutClone(uiName)
	return string.gsub(uiName, "%(Clone%)", "", 1)
end

function UIModule.OpenCommonDialogPanel(userData)
	if not UIModule.HasUI(Constant.UIControllerName.CommonDialogPanel) then
		UIModule.Open(Constant.UIControllerName.CommonDialogPanel, Constant.UILayer.UI, userData)

		return
	end

	EventDispatcher.Dispatch(EventID.CommonDialogPanel_RefreshShowEvent, userData)
end
