-- chunkname: @IQIGame\\UI\\VirtualPhotoStartUI.lua

require("IQIGame.UI.VirtualPhoto.VirtualPhotoUIModule")

local VirtualPhotoStartUI = {}

VirtualPhotoStartUI = Base:Extend("VirtualPhotoStartUI", "IQIGame.Onigao.UI.VirtualPhotoStartUI", VirtualPhotoStartUI)

function VirtualPhotoStartUI:OnInit()
	function self.DelegateOnClickGalleryBtn()
		self:OnClickGalleryBtn()
	end

	function self.DelegateOnClickCameraBtn()
		self:OnClickCameraBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function VirtualPhotoStartUI:GetPreloadAssetPaths()
	return nil
end

function VirtualPhotoStartUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function VirtualPhotoStartUI:IsManualShowOnOpen(userData)
	return false
end

function VirtualPhotoStartUI:GetBGM(userData)
	return nil
end

function VirtualPhotoStartUI:OnOpen(userData)
	return
end

function VirtualPhotoStartUI:OnClose(userData)
	return
end

function VirtualPhotoStartUI:OnAddListeners()
	self.GalleryBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGalleryBtn)
	self.CameraBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCameraBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function VirtualPhotoStartUI:OnRemoveListeners()
	self.GalleryBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGalleryBtn)
	self.CameraBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCameraBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function VirtualPhotoStartUI:OnPause()
	return
end

function VirtualPhotoStartUI:OnResume()
	return
end

function VirtualPhotoStartUI:OnCover()
	return
end

function VirtualPhotoStartUI:OnReveal()
	return
end

function VirtualPhotoStartUI:OnRefocus(userData)
	return
end

function VirtualPhotoStartUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function VirtualPhotoStartUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function VirtualPhotoStartUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function VirtualPhotoStartUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function VirtualPhotoStartUI:OnDestroy()
	return
end

function VirtualPhotoStartUI:OnClickGalleryBtn()
	VirtualPhotoUIModule.OpenGallery(function(texture)
		UIModule.Open(Constant.UIControllerName.VirtualPhotoEditUI, Constant.UILayer.UI, {
			mode = 2,
			texture = texture
		})
		UIModule.CloseSelf(self)
	end)
end

function VirtualPhotoStartUI:OnClickCameraBtn()
	VirtualPhotoUIModule.OpenCamera(function(texture)
		UIModule.Open(Constant.UIControllerName.VirtualPhotoEditUI, Constant.UILayer.UI, {
			mode = 1,
			texture = texture
		})
		UIModule.CloseSelf(self)
	end)
end

function VirtualPhotoStartUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

return VirtualPhotoStartUI
