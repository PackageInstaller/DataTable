-- chunkname: @IQIGame\\UI\\FloatNoticeUI.lua

local FloatNoticeUI = Base:Extend("FloatNoticeUI", "IQIGame.Onigao.UI.FloatNoticeUI", {
	Timer = 0,
	TARGET_POS_Y = 150,
	DURATION = 2
})

function FloatNoticeUI:OnInit()
	return
end

function FloatNoticeUI:GetPreloadAssetPaths()
	return nil
end

function FloatNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FloatNoticeUI:OnOpen(userData)
	self:UpdateView(userData)
	self:Reset()
end

function FloatNoticeUI:OnClose(userData)
	return
end

function FloatNoticeUI:OnAddListeners()
	return
end

function FloatNoticeUI:OnRemoveListeners()
	return
end

function FloatNoticeUI:OnPause()
	return
end

function FloatNoticeUI:OnResume()
	return
end

function FloatNoticeUI:OnCover()
	return
end

function FloatNoticeUI:OnReveal()
	return
end

function FloatNoticeUI:OnRefocus(userData)
	return
end

function FloatNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.Timer < FloatNoticeUI.DURATION then
		self.Timer = self.Timer + realElapseSeconds

		local alpha = 1
		local progress = self.Timer / FloatNoticeUI.DURATION

		if progress > 0.8 then
			alpha = (1 - progress) / 0.2
		end

		LuaCodeInterface.SetAlphaTo(self.Container, alpha)
	else
		UIModule.Close(Constant.UIControllerName.FloatNoticeUI)
	end
end

function FloatNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FloatNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FloatNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FloatNoticeUI:OnDestroy()
	return
end

function FloatNoticeUI:UpdateView(userData)
	local cfgNoticeData = CfgNoticeTable[userData.cid]

	if cfgNoticeData == nil then
		logColorInfo("没有找到 CfgNoticeTable 对应的Key=>" .. userData.cid, colorCode.Red)

		return
	end

	local content = string.format(cfgNoticeData.Describe, unpack(userData.args))

	self.FloatItem:GetComponent("Text").text = content

	local tween = TweenScale.Begin(self.Container, 0.2, Vector3.zero, Vector3.one)

	tween:SetOnFinished(function()
		UnityEngine.GameObject.Destroy(tween)
		self:OnMovePositon()
	end)
end

function FloatNoticeUI:OnMovePositon()
	local tween = TweenPosition.Begin(self.Container, 0.4, Vector3.New(0, 150, 0))

	tween:SetOnFinished(function()
		UnityEngine.GameObject.Destroy(tween)
	end)
end

function FloatNoticeUI:Reset()
	self.Container.transform.anchoredPosition = Vector2.zero

	LuaCodeInterface.SetAlphaTo(self.Container, 1)

	self.Timer = 0
end

return FloatNoticeUI
