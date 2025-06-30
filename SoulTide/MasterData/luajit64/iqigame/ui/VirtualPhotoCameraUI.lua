-- chunkname: @IQIGame\\UI\\VirtualPhotoCameraUI.lua

local VirtualPhotoCameraUI = {
	OriginalCameraCanvasScaleY = 1
}

VirtualPhotoCameraUI = Base:Extend("VirtualPhotoCameraUI", "IQIGame.Onigao.UI.VirtualPhotoCameraUI", VirtualPhotoCameraUI)

function VirtualPhotoCameraUI:OnInit()
	function self.DelegateOnClickShootBtn()
		self:OnClickShootBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function VirtualPhotoCameraUI:GetPreloadAssetPaths()
	return nil
end

function VirtualPhotoCameraUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function VirtualPhotoCameraUI:IsManualShowOnOpen(userData)
	return false
end

function VirtualPhotoCameraUI:GetBGM(userData)
	return nil
end

function VirtualPhotoCameraUI:OnOpen(userData)
	self:UpdateView(userData.webCamTexture, userData.onShoot)
end

function VirtualPhotoCameraUI:OnClose(userData)
	if self.BlockTimer ~= nil then
		self.BlockTimer:Stop()

		self.BlockTimer = nil
	end

	self.WebCamTexture = nil

	IQIGame.Onigao.Game.GameEntry.Photo:CloseCamera()
end

function VirtualPhotoCameraUI:OnAddListeners()
	self.ShootBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShootBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function VirtualPhotoCameraUI:OnRemoveListeners()
	self.ShootBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShootBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function VirtualPhotoCameraUI:OnPause()
	return
end

function VirtualPhotoCameraUI:OnResume()
	return
end

function VirtualPhotoCameraUI:OnCover()
	return
end

function VirtualPhotoCameraUI:OnReveal()
	return
end

function VirtualPhotoCameraUI:OnRefocus(userData)
	return
end

function VirtualPhotoCameraUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if not LuaCodeInterface.GameObjIsDestroy(self.WebCamTexture) then
		local videoVerticallyMirrored = self.WebCamTexture.videoVerticallyMirrored

		if self.VideoVerticallyMirrored ~= videoVerticallyMirrored then
			self.VideoVerticallyMirrored = videoVerticallyMirrored

			local scaleYRatio = self.VideoVerticallyMirrored and -1 or 1
			local scale = self.CameraCanvas.transform.localScale

			scale.y = self.OriginalCameraCanvasScaleY * scaleYRatio
			self.CameraCanvas.transform.localScale = scale
		end
	end
end

function VirtualPhotoCameraUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function VirtualPhotoCameraUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function VirtualPhotoCameraUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function VirtualPhotoCameraUI:OnDestroy()
	self.WebCamTexture = nil
end

function VirtualPhotoCameraUI:OnClickShootBtn()
	self.InputBlock:SetActive(true)
	self.ShootEffect:SetActive(true)

	self.BlockTimer = Timer.New(function()
		if self.BlockTimer.loop == 2 then
			self.ShootEffect:SetActive(false)
		else
			self.BlockTimer = nil

			local texture = UnityEngine.Texture2D(self.WebCamTexture.width, self.WebCamTexture.height, UnityEngine.TextureFormat.ARGB32, true)

			texture:SetPixels(self.WebCamTexture:GetPixels())
			texture:Apply()
			UIModule.CloseSelf(self)

			if self.OnShootCallback ~= nil then
				self.OnShootCallback(texture)

				self.OnShootCallback = nil
			end
		end
	end, 0.1, 2)

	self.BlockTimer:Start()
end

function VirtualPhotoCameraUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function VirtualPhotoCameraUI:UpdateView(webCamTexture, onShoot)
	self.WebCamTexture = webCamTexture
	self.OnShootCallback = onShoot
	self.OriginalCameraCanvasRotation = self.CameraCanvas.transform.rotation
	self.OriginalCameraCanvasScaleY = self.CameraCanvas.transform.localScale.y

	self.InputBlock:SetActive(false)
	self.ShootEffect:SetActive(false)
	self:AutoAdaptViewSize(self.WebCamTexture.width, self.WebCamTexture.height)

	local cameraCanvasImage = self.CameraCanvas:GetComponent("Image")

	cameraCanvasImage.material.mainTexture = self.WebCamTexture
end

function VirtualPhotoCameraUI:AutoAdaptViewSize(textureWidth, textureHeight)
	local textureWhRatio = textureWidth / textureHeight
	local rect = self.CameraCanvasAdaptor.transform.rect
	local parentWidth = rect.w
	local parentHeight = rect.h
	local parentWhRatio = parentWidth / parentHeight
	local photoImageWidth, photoImageHeight

	if parentWhRatio < textureWhRatio then
		photoImageWidth = parentWidth
		photoImageHeight = textureHeight * (photoImageWidth / textureWidth)
	else
		photoImageHeight = parentHeight
		photoImageWidth = textureWidth * (photoImageHeight / textureHeight)
	end

	self.CameraCanvas.transform.sizeDelta = Vector2(photoImageWidth, photoImageHeight)
	self.CameraCanvas.transform.rotation = self.OriginalCameraCanvasRotation * Quaternion.AngleAxis(self.WebCamTexture.videoRotationAngle, Vector3.up)
end

return VirtualPhotoCameraUI
