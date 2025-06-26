-- chunkname: @IQIGame\\Module\\Common\\UIModule.lua

UIModule = {
	canPopTopConfirm = true,
	BugFixL2dUIList = {}
}

function UIModule.Initialize()
	GameEntry.LuaEvent:Subscribe(UIFreezeCompleteOnOpenEventArgs.EventId, UIModule.OnOpenTargetUISuccess)
end

function UIModule.Shutdown()
	GameEntry.LuaEvent:Unsubscribe(UIFreezeCompleteOnOpenEventArgs.EventId, UIModule.OnOpenTargetUISuccess)
end

function UIModule.Open(uiName, layer, userData, allowMultiple)
	local ret = GameEntry.UI:OpenUIFormByName(uiName, layer, userData, allowMultiple)
	local fadeType = UIModule.GetFadeType(uiName)

	if fadeType ~= Constant.UITransitionEffectType.OpenClose and fadeType ~= Constant.UITransitionEffectType.Open or UIModule.CheckFading() then
		return
	end

	if SettingModule.closeDark == 1 then
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

function UIModule._FixCheckFullScreen(closedUIName)
	local closedUICfg = CfgUIConfigurationTable.NameCfgMap[closedUIName]

	if closedUICfg == nil or not closedUICfg.FullScreen then
		return
	end

	local forms = GameEntry.UI:GetAllLoadedUIForms()
	local maxFullScreenDepth = 0

	for i = 0, forms.Length - 1 do
		local uiForm = forms[i]
		local cfg = CfgUIConfigurationTable.NameCfgMap[uiForm.Logic.UIName]

		if cfg ~= nil and cfg.FullScreen then
			local depth = uiForm:GetComponent("Canvas").sortingOrder

			maxFullScreenDepth = math.max(maxFullScreenDepth, depth)
		end
	end

	local topUICtrl
	local topOrder = -1

	for name, luaUICtrl in pairs(UIModule.BugFixL2dUIList) do
		local order = luaUICtrl.UIController:GetComponent("Canvas").sortingOrder

		if (maxFullScreenDepth == 0 or maxFullScreenDepth <= order) and (luaUICtrl.l2dBuilder ~= nil or luaUICtrl.live2DView ~= nil and luaUICtrl.live2DView.l2dBuilder ~= nil) and topOrder < order then
			topOrder = order
			topUICtrl = luaUICtrl
		end
	end

	if topUICtrl ~= nil then
		if topUICtrl.l2dBuilder ~= nil then
			topUICtrl.l2dBuilder:ResumeL2D()
		else
			topUICtrl.live2DView.l2dBuilder:ResumeL2D()
		end
	end
end

function UIModule.__ShowFadeOutWhenCloseUI(uiName)
	if SettingModule.closeDark == 1 then
		return
	end

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

function UIModule.HasUI(uiName)
	return GameEntry.UI:HasUIFormByName(uiName)
end

function UIModule.IsLoadingUI(uiName)
	return GameEntry.UI:IsLoadingUIFormByName(uiName)
end

function UIModule.ForceRelease()
	UIModule.__CacheReleaseInterval = GameEntry.UICom.InstanceAutoReleaseInterval
	UIModule.__CacheExpireTime = GameEntry.UICom.InstanceExpireTime
	GameEntry.UICom.InstanceAutoReleaseInterval = 0
	GameEntry.UICom.InstanceExpireTime = 0
end

function UIModule.RecoverAfterForceRelease()
	if UIModule.__CacheReleaseInterval == nil or GameEntry.UICom.InstanceExpireTime == nil then
		return
	end

	GameEntry.UICom.InstanceAutoReleaseInterval = UIModule.__CacheReleaseInterval
	GameEntry.UICom.InstanceExpireTime = UIModule.__CacheExpireTime
end
