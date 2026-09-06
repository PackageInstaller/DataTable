-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/impl/LoadingView.lua

module(..., package.seeall)

local LoadingView = class("LoadingView", LoadingViewBase)

function LoadingView.createMainView(name)
	local prefab = CommonPreloader.instance:getAsset(CommonResPath.LoadingView)
	local go = goutil.clone(prefab, name)

	LoadingView._img = goutil.findChildImageComponent(go, "loading_bg")
	LoadingView._effRoot = goutil.findChild(go, "content/progressBar/dot/effRoot")

	goutil.setActive(go, false)

	return go
end

function LoadingView:show(isClear)
	LoadingView.super.show(self, isClear)

	LoadingView.loadingBgIndex = LoadingView.loadingBgIndex or LoadingTipsAndPicsModel.instance:getNextPicsIndex()

	uGuiUtil.setSpriteToImage(LoadingView._img.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getLoadingbgUrl(LoadingView.loadingBgIndex), function()
		LoadingView._img.gameObject:GetComponent("Image"):SetNativeSize()
	end)

	LoadingView._eff = UIEffectManager.instance:playHUDEffect("fx_ui_zairu/fx_ui_jindutiao_xiugai.prefab", LoadingView._effRoot, true, nil, nil, function(finishHandlerTarget, eff)
		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(LoadingView._effRoot) + 1)

		eff.effGo.transform.localScale = Vector3.one
	end, nil, false)
end

function LoadingView:close()
	LoadingView.super.close(self)

	local bigBg = LoadingView._img:GetComponent("ImageBigBG")

	if bigBg then
		bigBg:ClearImage()
	end

	if LoadingView._eff then
		UIEffectManager.instance:stopEffect(LoadingView._eff)

		LoadingView._eff = nil
	end
end

function LoadingView:_initComponents()
	self:_addComponent("progress", LoadingCompProgress)
	self:_addComponent("progressView", LoadingCompProgressView)
	self:_addComponent("autoRandomTips", LoadingCompAutoRandomTips)
end

return LoadingView
