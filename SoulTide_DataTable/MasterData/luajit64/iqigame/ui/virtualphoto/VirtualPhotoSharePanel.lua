-- chunkname: @IQIGame\\UI\\VirtualPhoto\\VirtualPhotoSharePanel.lua

local m = {}

function m.New(view, onShare, onClose)
	local obj = Clone(m)

	obj:Init(view, onShare, onClose)

	return obj
end

function m:Init(view, onShare, onClose)
	self.View = view
	self.OnShareCallback = onShare
	self.OnCloseCallback = onClose

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickShareBtn1()
		self:OnClickShareBtn(1)
	end

	function self.DelegateOnClickShareBtn2()
		self:OnClickShareBtn(2)
	end

	function self.DelegateOnClickShareBtn3()
		self:OnClickShareBtn(3)
	end

	function self.DelegateOnClickShareBtn4()
		self:OnClickShareBtn(4)
	end

	local text, platformConst = VirtualPhotoEditUIApi:GetString("SharePanel_ShareInfo", 1)

	UGUIUtil.SetTextInChildren(self.ShareBtn1, text)

	text, platformConst = VirtualPhotoEditUIApi:GetString("SharePanel_ShareInfo", 2)

	UGUIUtil.SetTextInChildren(self.ShareBtn2, text)

	text, platformConst = VirtualPhotoEditUIApi:GetString("SharePanel_ShareInfo", 3)

	UGUIUtil.SetTextInChildren(self.ShareBtn3, text)

	text, platformConst = VirtualPhotoEditUIApi:GetString("SharePanel_ShareInfo", 4)

	UGUIUtil.SetTextInChildren(self.ShareBtn4, text)
	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.ShareBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShareBtn1)
	self.ShareBtn2:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShareBtn2)
	self.ShareBtn3:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShareBtn3)
	self.ShareBtn4:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShareBtn4)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.ShareBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShareBtn1)
	self.ShareBtn2:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShareBtn2)
	self.ShareBtn3:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShareBtn3)
	self.ShareBtn4:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShareBtn4)
end

function m:Show(rt)
	self.View:SetActive(true)

	local image = self.PreviewImage:GetComponent(typeof(UnityEngine.UI.RawImage))

	image.texture = rt

	local textureWidth = rt.width
	local textureHeight = rt.height
	local textureWhRatio = textureWidth / textureHeight
	local parentTransRect = self.PreviewImage.transform.parent.rect
	local parentWidth = parentTransRect.w
	local parentHeight = parentTransRect.h
	local parentWhRatio = parentWidth / parentHeight
	local photoImageWidth, photoImageHeight

	if parentWhRatio < textureWhRatio then
		photoImageWidth = parentWidth
		photoImageHeight = textureHeight * (photoImageWidth / textureWidth)
	else
		photoImageHeight = parentHeight
		photoImageWidth = textureWidth * (photoImageHeight / textureHeight)
	end

	self.PreviewImage.transform.sizeDelta = Vector2(photoImageWidth, photoImageHeight)
end

function m:Hide()
	local image = self.PreviewImage:GetComponent(typeof(UnityEngine.UI.RawImage))

	image.texture = nil

	self.View:SetActive(false)
end

function m:OnClickCloseBtn()
	self:Hide()
	self.OnCloseCallback()
end

function m:OnClickShareBtn(index)
	local text, platform = VirtualPhotoEditUIApi:GetString("SharePanel_ShareInfo", index)

	self.OnShareCallback(platform)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnShareCallback = nil
	self.OnCloseCallback = nil
end

return m
