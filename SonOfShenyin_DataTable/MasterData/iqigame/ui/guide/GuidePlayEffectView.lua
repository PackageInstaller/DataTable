-- chunkname: @IQIGame\\UI\\Guide\\GuidePlayEffectView.lua

local GuidePlayEffectView = {}

function GuidePlayEffectView.__New(ui, parent)
	local o = Clone(GuidePlayEffectView)

	o:InitView(ui, parent)

	return o
end

function GuidePlayEffectView:InitView(ui, parent)
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)

	self.ParentView = parent

	LuaCodeInterface.BindOutlet(self.rootUI, self)
	self:AddEventListener()
end

function GuidePlayEffectView:AddEventListener()
	return
end

function GuidePlayEffectView:RemoveEventListener()
	return
end

function GuidePlayEffectView:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuidePlayEffectView:OnUpdate(elapseSeconds, realElapseSeconds)
	if not self.guideModuleData then
		return
	end

	local checkPos = GuideUIUtil.FindObjectAndRefreshCache(self, self.guideModuleData[4], Vector3.New(self.guideModuleData[5], self.guideModuleData[6], 0))

	if not checkPos then
		return
	end

	if self.createPos and checkPos.x == self.createPos.x and checkPos.y == self.createPos.y then
		return
	end

	if self.goEffect then
		self.createPos = checkPos

		LuaUtility.SetLocalPositionWithGameObject(self.goEffect, self.createPos.x, self.createPos.y, 0)
	end
end

function GuidePlayEffectView:UpDateView()
	self.createPos = GuideUIUtil.FindObjectAndRefreshCache(self, self.guideModuleData[4], Vector3.New(self.guideModuleData[5], self.guideModuleData[6], 0))

	local path = UIGlobalApi.GetUIFxEffectPath(self.guideModuleData[3])

	AssetUtil.LoadAsset(self, path, self.OnLoadEffectAssetSucceed, nil, {
		self.createPos
	})
end

function GuidePlayEffectView:OnLoadEffectAssetSucceed(assetName, asset, duration, userData)
	self.goEffect = UnityEngine.Object.Instantiate(asset)

	self.goEffect.transform:SetParent(self.rootUI.transform, false)

	if self.createPos then
		self.goEffect.transform.localPosition = self.createPos
	else
		self.goEffect.transform.localPosition = Vector3.New(0, 0)
	end

	local scalePath = self.guideModuleData[11]

	if scalePath then
		local scaleTrans = self.goEffect.transform:Find(scalePath)

		if scaleTrans then
			local scaleX = self.guideModuleData[9]
			local scaleY = self.guideModuleData[10]

			if scaleX == nil or scaleY == nil then
				scaleX = 1
				scaleY = 1
			end

			scaleTrans.localScale = Vector3.New(scaleX, scaleY, 1)
		end
	end
end

function GuidePlayEffectView:Dispose()
	self:RemoveEventListener()

	self.targetUITransform = nil
	self.targetObj = nil

	if self.goEffect then
		GameObject.Destroy(self.goEffect)

		self.goEffect = nil
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function GuidePlayEffectView:Open(data, guideSubID)
	self.guideModuleData = data
	self.guideSubID = guideSubID
	self.cfgSubGuide = GuideModule.GetSubGuide(self.guideSubID)

	self:UpDateView()
	LuaUtility.SetGameObjectShow(self.rootUI, true)
end

function GuidePlayEffectView:Close()
	self.targetObj = nil

	LuaUtility.SetGameObjectShow(self.rootUI, false)

	if self.goEffect then
		GameObject.Destroy(self.goEffect)

		self.goEffect = nil
	end
end

function GuidePlayEffectView:TriggerSelf()
	return
end

return GuidePlayEffectView
