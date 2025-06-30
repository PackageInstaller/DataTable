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
	self:InitComponent()
	self:InitDelegate()
	self:AddEventListener()
end

function GuidePictureGuideView:InitComponent()
	self.ImagePicture = self.PictureImg:GetComponent("Image")
end

function GuidePictureGuideView:InitDelegate()
	function self.ClickDelegate()
		self:OnClick()
	end

	function self.OnImageLoadDelegate()
		self:OnImageLoad()
	end
end

function GuidePictureGuideView:AddEventListener()
	self.PictureImg:GetComponent("Button").onClick:AddListener(self.ClickDelegate)
end

function GuidePictureGuideView:RemoveEventListener()
	self.PictureImg:GetComponent("Button").onClick:RemoveListener(self.ClickDelegate)
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

	local path = self.guideModuleData[2]

	LuaUtility.LoadImage(self, path, self.ImagePicture, self.OnImageLoadDelegate)
	LuaUtility.SetGameObjectShow(self.rootUI, true)
end

function GuidePictureGuideView:Close()
	LuaUtility.SetGameObjectShow(self.rootUI, false)
end

function GuidePictureGuideView:TriggerSelf()
	return
end

function GuidePictureGuideView:OnClick()
	self:Close()
	self.rootParent:ShowGuideNext()
end

function GuidePictureGuideView:OnImageLoad()
	self.ImagePicture:SetNativeSize()
end

return GuidePictureGuideView
