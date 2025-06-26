-- chunkname: @IQIGame\\UI\\Guide\\GuideArrowPointingView.lua

local GuideArrowPointingView = {}

function GuideArrowPointingView.__New(ui, parent)
	local o = Clone(GuideArrowPointingView)

	o:InitView(ui, parent)

	return o
end

function GuideArrowPointingView:InitView(ui, parent)
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)
end

function GuideArrowPointingView:AddEventListener()
	return
end

function GuideArrowPointingView:RemoveEventListener()
	return
end

function GuideArrowPointingView:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.targetObj ~= nil and self.targetUITransform ~= nil and self.guideModuleData ~= nil then
		local checkPos = GuideUIUtil.FindObjectAndRefreshCache(self, self.guideModuleData[6], Vector3.New(self.guideModuleData[8], self.guideModuleData[9], 0))

		if checkPos ~= self.createPos then
			self.createPos = checkPos
			self.ArrowImg.transform.anchoredPosition = self.createPos
		end
	end
end

function GuideArrowPointingView:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuideArrowPointingView:UpDateView()
	self.rootUI:GetComponent("SortedComponentOrder").Order = self.guideModuleData[2]

	local pos = GuideUIUtil.FindObjectAndRefreshCache(self, self.guideModuleData[6], Vector3.New(self.guideModuleData[8], self.guideModuleData[9], 0))
	local path = UIGlobalApi.GetImagePath(self.guideModuleData[3])

	AssetUtil.LoadImage(self, path, self.ArrowImg:GetComponent("Image"))

	self.ArrowImg.transform.anchoredPosition = pos
	self.ArrowImg.transform.sizeDelta = Vector2.New(self.guideModuleData[4], self.guideModuleData[5])
	self.ArrowImg.transform.rotation = Quaternion.Euler(0, 0, self.guideModuleData[7])
end

function GuideArrowPointingView:Dispose()
	self.targetUITransform = nil
	self.targetObj = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function GuideArrowPointingView:Open(data, guideSubID)
	self.guideModuleData = data
	self.guideSubID = guideSubID

	self:AddEventListener()
	self:UpDateView()

	local startShow = self.guideModuleData[10]
	local endShow = self.guideModuleData[11]

	self.timerShow = Timer.New(function()
		self.rootUI:SetActive(true)
	end, startShow)

	self.timerShow:Start()

	if endShow > 0 then
		self.timerEnd = Timer.New(function()
			self:Close()
		end, endShow)

		self.timerEnd:Start()
	end
end

function GuideArrowPointingView:Close()
	self:RemoveEventListener()
	self.rootUI:SetActive(false)

	if self.timerShow ~= nil then
		self.timerShow:Stop()

		self.timerShow = nil
	end

	if self.timerEnd ~= nil then
		self.timerEnd:Stop()

		self.timerEnd = nil
	end
end

return GuideArrowPointingView
