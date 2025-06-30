-- chunkname: @IQIGame\\UI\\Guide\\GuidePlayEffectView.lua

local GuidePlayEffectView = {
	guideEffectID = 0
}

function GuidePlayEffectView.__New(ui, parent)
	local o = Clone(GuidePlayEffectView)

	o:InitView(ui, parent)

	return o
end

function GuidePlayEffectView:InitView(ui, parent)
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(true)
	LuaCodeInterface.BindOutlet(self.rootUI, self)
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
	if self.targetObj ~= nil and self.targetUITransform ~= nil and self.guideModuleData ~= nil then
		local checkPos = GuideUIUtil.FindObjectAndRefreshCache(self, self.guideModuleData[4], Vector3.New(self.guideModuleData[5], self.guideModuleData[6], 0))

		if checkPos ~= self.createPos then
			self.createPos = checkPos

			if self.guideEffectID ~= 0 then
				local uiEffect = GameEntry.Effect:GetEffectByPlayID(self.guideEffectID)

				if uiEffect and uiEffect.GoEffectEntity ~= nil and not LuaCodeInterface.GameObjIsDestroy(uiEffect.GoEffectEntity) then
					uiEffect.GoEffectEntity.transform.localPosition = self.createPos
				end
			end
		end
	end
end

function GuidePlayEffectView:UpDateView()
	self.createPos = GuideUIUtil.FindObjectAndRefreshCache(self, self.guideModuleData[4], Vector3.New(self.guideModuleData[5], self.guideModuleData[6], 0))

	local value = self.rootParent.UIController:GetComponent("Canvas").sortingOrder + self.guideModuleData[2]

	self.guideEffectID = GameEntry.Effect:PlayUIMountPointEffect(self.guideModuleData[3], 50000, 0, self.EffectNode, value, 0, 0, self.createPos)
end

function GuidePlayEffectView:Dispose()
	self.targetUITransform = nil
	self.targetObj = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function GuidePlayEffectView:Open(data, guideSubID)
	self.EffectNode:SetActive(true)

	self.guideModuleData = data
	self.guideSubID = guideSubID
	self.cfgSubGuide = GuideModule.GetSubGuide(self.guideSubID)

	self:AddEventListener()

	local startShow = self.guideModuleData[7]
	local endShow = self.guideModuleData[8]

	self.timerShow = Timer.New(function()
		self:UpDateView()
	end, startShow)

	self.timerShow:Start()

	if endShow > 0 then
		self.timerEnd = Timer.New(function()
			self:Close()
		end, endShow)

		self.timerEnd:Start()
	end
end

function GuidePlayEffectView:Close()
	self:RemoveEventListener()

	if self.timerShow ~= nil then
		self.timerShow:Stop()

		self.timerShow = nil
	end

	if self.timerEnd ~= nil then
		self.timerEnd:Stop()

		self.timerEnd = nil
	end

	if self.guideEffectID ~= 0 then
		GameEntry.Effect:StopEffect(self.guideEffectID)

		self.guideEffectID = 0
	end
end

return GuidePlayEffectView
