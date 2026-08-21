-- chunkname: @IQIGame\\UI\\Guide\\GuidePictureGuideView.lua

local GuidePictureGuideView = {}

function GuidePictureGuideView.__New(ui, parent)
	local o = Clone(GuidePictureGuideView)

	o:InitView(ui, parent)

	return o
end

function GuidePictureGuideView:InitView(ui, parent)
	self.rootParent = parent
	self.rootUI = ui

	self.rootUI:SetActive(false)
	LuaCodeInterface.BindOutlet(self.rootUI, self)
end

function GuidePictureGuideView:AddEventListener()
	return
end

function GuidePictureGuideView:RemoveEventListener()
	return
end

function GuidePictureGuideView:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuidePictureGuideView:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuidePictureGuideView:UpDateView()
	self.rootUI:GetComponent("SortedComponentOrder").Order = self.guideModuleData[2]

	local path = UIGlobalApi.GetImagePath(self.guideModuleData[3])

	AssetUtil.LoadImage(self, path, self.PictureImg:GetComponent("Image"))

	self.PictureImg.transform.sizeDelta = Vector2.New(self.guideModuleData[4], self.guideModuleData[5])
end

function GuidePictureGuideView:UpDatePose()
	return
end

function GuidePictureGuideView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
	self.rootParent = nil
end

function GuidePictureGuideView:Open(data, guideSubID)
	self.guideModuleData = data
	self.guideSubID = guideSubID

	self:AddEventListener()
	self:UpDateView()

	local startShow = self.guideModuleData[6]
	local endShow = self.guideModuleData[7]

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

function GuidePictureGuideView:Close()
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

return GuidePictureGuideView
