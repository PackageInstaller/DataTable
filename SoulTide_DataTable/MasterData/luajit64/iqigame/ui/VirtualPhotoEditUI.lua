-- chunkname: @IQIGame\\UI\\VirtualPhotoEditUI.lua

require("IQIGame.UIExternalApi.VirtualPhotoEditUIApi")

local VirtualPhotoEditElementController = require("IQIGame.UI.VirtualPhoto.VirtualPhotoEditElementController")
local VirtualPhotoSharePanel = require("IQIGame.UI.VirtualPhoto.VirtualPhotoSharePanel")
local VirtualPhotoInputManager = require("IQIGame.UI.VirtualPhoto.VirtualPhotoInputManager")
local VirtualPhotoElementLayerPanel = require("IQIGame.UI.VirtualPhoto.VirtualPhotoElementLayerPanel")
local VirtualPhotoEditUI = {
	MaxElementNum = 5,
	S_IdGenerator = 0,
	BgMode = 0,
	CanvasMatchHeight = false,
	ElementControllers = {}
}

VirtualPhotoEditUI = Base:Extend("VirtualPhotoEditUI", "IQIGame.Onigao.UI.VirtualPhotoEditUI", VirtualPhotoEditUI)

function VirtualPhotoEditUI:OnInit()
	function self.DelegateOnClickElementLayerBtn()
		self:OnClickElementLayerBtn()
	end

	function self.DelegateOnClickPreviewBtn()
		self:OnClickPreviewBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickAddElementBtn()
		self:OnClickAddElementBtn()
	end

	function self.DelegateOnClickPreviewCloseBtn()
		self:OnClickPreviewCloseBtn()
	end

	function self.DelegateOnClickShareBtn()
		self:OnClickShareBtn()
	end

	function self.DelegateOnClickSaveBtn()
		self:OnClickSaveBtn()
	end

	function self.DelegateOnClickChangeBGBtn()
		self:OnClickChangeBGBtn()
	end

	self.SharePanel = VirtualPhotoSharePanel.New(self.ShareView, function(platform)
		self:ConfirmShare(platform)
	end, function()
		self:OnSharePanelClosed()
	end)
	self.ElementLayerPanel = VirtualPhotoElementLayerPanel.New(self.ElementLayerPanelView, self.UIController:GetComponent("Canvas"))

	UGUIUtil.SetText(self.TitleText, VirtualPhotoEditUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.PreviewCloseBtn, VirtualPhotoEditUIApi:GetString("PreviewCloseBtnText"))
end

function VirtualPhotoEditUI:GetPreloadAssetPaths()
	return nil
end

function VirtualPhotoEditUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function VirtualPhotoEditUI:IsManualShowOnOpen(userData)
	return false
end

function VirtualPhotoEditUI:GetBGM(userData)
	return nil
end

function VirtualPhotoEditUI:OnOpen(userData)
	local canvasScaler = self.UIController:GetComponent("CanvasScaler")

	self.CanvasMatchHeight = canvasScaler.matchWidthOrHeight == 1

	self:UpdateView(userData.texture, userData.mode)

	local canvas = self.UIController:GetComponent("Canvas")

	self.InputManager = VirtualPhotoInputManager.New(canvas.worldCamera, function()
		return self:GetCurrentElement()
	end)

	self.ElementLayerPanel:Hide()
end

function VirtualPhotoEditUI:OnClose(userData)
	self:ClearBgAssets()
	self:ClearElements()
	self.InputManager:Dispose()
	self.ElementLayerPanel:Hide()
	ModuleTimerUtil.Stop(Constant.UIControllerName.VirtualPhotoEditUI)
end

function VirtualPhotoEditUI:OnAddListeners()
	self.ElementLayerBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickElementLayerBtn)
	self.PreviewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPreviewBtn)
	self.AddElementBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickAddElementBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.PreviewCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPreviewCloseBtn)
	self.ShareBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShareBtn)
	self.SaveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSaveBtn)
	self.ChangeBGBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChangeBGBtn)
end

function VirtualPhotoEditUI:OnRemoveListeners()
	self.ElementLayerBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickElementLayerBtn)
	self.PreviewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPreviewBtn)
	self.AddElementBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickAddElementBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.PreviewCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPreviewCloseBtn)
	self.ShareBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShareBtn)
	self.SaveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSaveBtn)
	self.ChangeBGBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChangeBGBtn)
end

function VirtualPhotoEditUI:OnPause()
	return
end

function VirtualPhotoEditUI:OnResume()
	return
end

function VirtualPhotoEditUI:OnCover()
	return
end

function VirtualPhotoEditUI:OnReveal()
	return
end

function VirtualPhotoEditUI:OnRefocus(userData)
	return
end

function VirtualPhotoEditUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function VirtualPhotoEditUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	local spriteRenderer = self.PhotoImage:GetComponent(typeof(UnityEngine.SpriteRenderer))

	spriteRenderer.sortingOrder = self.UIController:GetComponent("Canvas").sortingOrder + 1
end

function VirtualPhotoEditUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function VirtualPhotoEditUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function VirtualPhotoEditUI:OnDestroy()
	self:ClearElements()
	self.SharePanel:Dispose()
	self.ElementLayerPanel:Dispose()
end

function VirtualPhotoEditUI:OnClickChangeBGBtn()
	if self.BgMode == 1 then
		VirtualPhotoUIModule.OpenCamera(function(texture)
			self:ClearBgAssets()
			self:RefreshBG(texture)
		end)
	else
		VirtualPhotoUIModule.OpenGallery(function(texture)
			self:ClearBgAssets()
			self:RefreshBG(texture)
		end)
	end
end

function VirtualPhotoEditUI:OnClickElementLayerBtn()
	self.ElementLayerPanel:Show(self.ElementControllers, function(id)
		self:SelectElement(id)
	end, function(id)
		self:RemoveElement(id)
	end, function()
		self:RefreshElementLayers()
	end)
end

function VirtualPhotoEditUI:OnClickPreviewBtn()
	self:ChangeViewMode(true)
end

function VirtualPhotoEditUI:OnClickAddElementBtn()
	UIModule.Open(Constant.UIControllerName.VirtualPhotoSelectElementUI, Constant.UILayer.UI, {
		callback = function(cid)
			self:OnSelectElement(cid)

			local openedBefore = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.VirtualPhotoNoticeDisabled)

			if openedBefore ~= 1 then
				UIModule.Open(Constant.UIControllerName.VirtualPhotoNoticeUI, Constant.UILayer.UI)
			end
		end
	})
end

function VirtualPhotoEditUI:OnClickCloseBtn()
	UIModule.Open(Constant.UIControllerName.VirtualPhotoStartUI, Constant.UILayer.UI)
	UIModule.CloseSelf(self)
end

function VirtualPhotoEditUI:OnClickPreviewCloseBtn()
	self:ChangeViewMode(false)
end

function VirtualPhotoEditUI:UpdateView(texture, bgMode)
	self.BgMode = bgMode

	self.SharePanel:Hide()
	self.RTCamera:SetActive(false)
	self.ShareExtView:SetActive(false)
	self:ChangeViewMode(false)

	local timer = FrameTimer.New(function()
		self:RefreshBG(texture)
	end, 1)

	timer:Start()
end

function VirtualPhotoEditUI:RefreshBG(texture)
	self.BgTexture = texture

	local spriteRenderer = self.PhotoImage:GetComponent(typeof(UnityEngine.SpriteRenderer))
	local sprite = LuaCodeInterface.ToSprite(self.BgTexture)

	spriteRenderer.sprite = sprite

	self:AutoAdaptPhotoSize(sprite.pixelsPerUnit)
	self:CreateRT()
	self:AutoAdaptRTCameraSize()
end

function VirtualPhotoEditUI:AutoAdaptPhotoSize(pixelsPerUnit)
	local textureWidth = self.BgTexture.width
	local textureHeight = self.BgTexture.height
	local textureWhRatio = textureWidth / textureHeight
	local parentTransRect = self.PhotoImage.transform.parent.rect
	local parentWidth = parentTransRect.w
	local parentHeight = parentTransRect.h
	local parentWhRatio = parentWidth / parentHeight
	local shareExtScale = 1

	if textureWhRatio < 1 then
		shareExtScale = 0.5
	end

	local photoImageWidth, photoImageHeight, spriteScale, shareExtViewOffsetX, shareExtViewOffsetY

	if parentWhRatio < textureWhRatio then
		photoImageWidth = parentWidth
		photoImageHeight = textureHeight * (photoImageWidth / textureWidth)

		local spriteRendererWidth = textureWidth / pixelsPerUnit

		spriteScale = photoImageWidth / spriteRendererWidth
		shareExtViewOffsetX = -20 * shareExtScale
		shareExtViewOffsetY = (parentHeight - photoImageHeight) / 2 + 20 * shareExtScale
	else
		photoImageHeight = parentHeight
		photoImageWidth = textureWidth * (photoImageHeight / textureHeight)

		local spriteRendererHeight = textureHeight / pixelsPerUnit

		spriteScale = photoImageHeight / spriteRendererHeight
		shareExtViewOffsetX = (photoImageWidth - parentWidth) / 2 - 20 * shareExtScale
		shareExtViewOffsetY = 20 * shareExtScale
	end

	self.PhotoImage.transform.localScale = Vector3(spriteScale, spriteScale, 1)
	self.ShareExtView.transform.anchoredPosition = Vector2(shareExtViewOffsetX, shareExtViewOffsetY)
	self.ShareExtView.transform.localScale = Vector3(shareExtScale, shareExtScale, 1)
end

function VirtualPhotoEditUI:CreateRT()
	local rtCameraCom = self.RTCamera:GetComponent("Camera")
	local widthLimitRatio = self.BgTexture.width / 2048
	local heightLimitRatio = self.BgTexture.height / 2048
	local maxEdgeRatio = 1

	if widthLimitRatio > 1 or heightLimitRatio > 1 then
		maxEdgeRatio = heightLimitRatio < widthLimitRatio and widthLimitRatio or heightLimitRatio
	end

	local rtRatio = 1 / maxEdgeRatio
	local rtWidth = math.floor(self.BgTexture.width * rtRatio)
	local rtHeight = math.floor(self.BgTexture.height * rtRatio)
	local renderTexture = UnityEngine.RenderTexture(rtWidth, rtHeight, 0)

	rtCameraCom.targetTexture = renderTexture
end

function VirtualPhotoEditUI:AutoAdaptRTCameraSize()
	local rtCameraCom = self.RTCamera:GetComponent("Camera")
	local textureWidth = self.BgTexture.width
	local textureHeight = self.BgTexture.height
	local textureWhRatio = textureWidth / textureHeight
	local parentTransRect = self.PhotoImage.transform.parent.rect
	local parentWidth = parentTransRect.w
	local parentHeight = parentTransRect.h
	local parentWhRatio = parentWidth / parentHeight
	local rootHeight = self.UIController.transform.sizeDelta.y
	local textureUIHeight

	if parentWhRatio < textureWhRatio then
		textureUIHeight = parentWidth / textureWhRatio
	else
		textureUIHeight = parentHeight
	end

	rtCameraCom.orthographicSize = textureUIHeight / rootHeight * 10
end

function VirtualPhotoEditUI:ClearBgAssets()
	local spriteRenderer = self.PhotoImage:GetComponent(typeof(UnityEngine.SpriteRenderer))
	local sprite = spriteRenderer.sprite

	spriteRenderer.sprite = nil

	if not LuaCodeInterface.GameObjIsDestroy(sprite) then
		UnityEngine.Object.Destroy(sprite)
	end

	if not LuaCodeInterface.GameObjIsDestroy(self.BgTexture) then
		UnityEngine.Object.Destroy(self.BgTexture)
	end

	self.BgTexture = nil

	local rtCameraCom = self.RTCamera:GetComponent("Camera")
	local renderTexture = rtCameraCom.targetTexture

	rtCameraCom.targetTexture = nil

	if not LuaCodeInterface.GameObjIsDestroy(renderTexture) then
		UnityEngine.Object.Destroy(renderTexture)
	end
end

function VirtualPhotoEditUI:ChangeViewMode(isPreview)
	self.TitleView:SetActive(not isPreview)
	self.EditBottomView:SetActive(not isPreview)
	self.PreviewCloseBtn:SetActive(isPreview)
	self.PreviewBottomView:SetActive(isPreview)

	for i = 1, #self.ElementControllers do
		local controller = self.ElementControllers[i]

		controller:SetPreviewMode(isPreview)
	end
end

function VirtualPhotoEditUI:OnClickSaveBtn()
	local texture = self:GetTextureFromRTCamera()

	IQIGame.Onigao.Game.GameEntry.Photo:SaveImageToGallery(texture, "SoulTide", "VirtualMemory_" .. self:GetImageTimeExt(), function(success, path, permission)
		if success then
			NoticeModule.ShowNotice(21064049)
		elseif permission == Constant.GalleryPermission.Denied then
			NoticeModule.ShowNotice(21064046)
		end
	end)
end

function VirtualPhotoEditUI:OnClickShareBtn()
	self.RTCamera:SetActive(true)
	self.ShareExtView:SetActive(true)

	local rtCameraCom = self.RTCamera:GetComponent("Camera")

	self.SharePanel:Show(rtCameraCom.targetTexture)
end

function VirtualPhotoEditUI:OnSharePanelClosed()
	self.RTCamera:SetActive(false)
	self.ShareExtView:SetActive(false)
end

function VirtualPhotoEditUI:ConfirmShare(platform)
	self.ShareExtView:SetActive(true)

	local timer = ModuleTimerUtil.NewFrameTimer(Constant.UIControllerName.VirtualPhotoEditUI, function()
		local texture = self:GetTextureFromRTCamera()

		self.ShareExtView:SetActive(false)
		self.SharePanel:Hide()

		local shareDirectory = UnityEngine.Application.persistentDataPath .. "/VirtualMemoryShare"
		local tempPath = shareDirectory .. "/VirtualMemory_Share_" .. self:GetImageTimeExt() .. ".jpeg"

		if not LuaCodeInterface.Directory.Exists(shareDirectory) then
			LuaCodeInterface.Directory.CreateDirectory(shareDirectory)
		end

		LuaCodeInterface.File.WriteAllBytes(tempPath, texture:EncodeToJPG(100))

		local timerShare = ModuleTimerUtil.NewTimer(Constant.UIControllerName.VirtualPhotoEditUI, function()
			SDKLoginModule.Share(platform, tempPath, function(msg)
				NoticeModule.ShowNotice(21064050)
				LuaCodeInterface.File.Delete(tempPath)
			end, function(msg)
				NoticeModule.ShowNotice(21064052)
				LuaCodeInterface.File.Delete(tempPath)
			end, function(msg)
				NoticeModule.ShowNotice(21064052)
				LuaCodeInterface.File.Delete(tempPath)
			end)
		end, 1)

		timerShare:Start()
	end, 1)

	timer:Start()
end

function VirtualPhotoEditUI:GetImageTimeExt()
	local dateTime = getDateTimeTable(PlayerModule.GetServerTime())
	local year = string.sub(tostring(dateTime.year), 3)
	local month = dateTime.month < 10 and "0" .. dateTime.month or dateTime.month
	local day = dateTime.day < 10 and "0" .. dateTime.day or dateTime.day

	return year .. month .. day
end

function VirtualPhotoEditUI:GetTextureFromRTCamera()
	self.RTCamera:SetActive(true)

	local rtCameraCom = self.RTCamera:GetComponent("Camera")
	local currentRT = UnityEngine.RenderTexture.active

	UnityEngine.RenderTexture.active = rtCameraCom.targetTexture

	rtCameraCom:Render()

	local texture = UnityEngine.Texture2D(rtCameraCom.targetTexture.width, rtCameraCom.targetTexture.height, UnityEngine.TextureFormat.ARGB32, true)

	texture:ReadPixels(Rect(0, 0, rtCameraCom.targetTexture.width, rtCameraCom.targetTexture.height), 0, 0)
	texture:Apply()

	UnityEngine.RenderTexture.active = currentRT

	self.RTCamera:SetActive(false)

	return texture
end

function VirtualPhotoEditUI:ClearElements()
	for i = 1, #self.ElementControllers do
		local controller = self.ElementControllers[i]
		local v = controller.View

		controller:Dispose()
		UnityEngine.GameObject.Destroy(v)
	end

	self.ElementControllers = {}
end

function VirtualPhotoEditUI:OnSelectElement(cid)
	self:AddElement(cid)
end

function VirtualPhotoEditUI:AddElement(cid)
	if #self.ElementControllers >= self.MaxElementNum then
		logError("元素数量不能超过 " .. self.MaxElementNum .. "个。")

		return
	end

	local id = self:GenerateElementID()
	local controller = VirtualPhotoEditElementController.New(id, cid, self.UIController:GetComponent("Canvas"))

	controller.View.transform:SetParent(self.ElementNode.transform, false)
	controller:SetIndex(#self.ElementControllers + 1)
	table.insert(self.ElementControllers, controller)
	self:SelectElement(id)
end

function VirtualPhotoEditUI:SelectElement(id)
	for i = 1, #self.ElementControllers do
		local controller = self.ElementControllers[i]

		controller:SetSelect(controller.Id == id)
	end
end

function VirtualPhotoEditUI:RemoveElement(id)
	local index = -1
	local targetController

	for i = 1, #self.ElementControllers do
		local controller = self.ElementControllers[i]

		if controller.Id == id then
			index = i
			targetController = controller

			break
		end
	end

	if index ~= -1 then
		table.remove(self.ElementControllers, index)

		if targetController.IsSelected and #self.ElementControllers > 0 then
			local newSelectedController = self.ElementControllers[1]

			newSelectedController:SetSelect(true)
		end

		local v = targetController.View

		targetController:Dispose()
		UnityEngine.GameObject.Destroy(v)
	end
end

function VirtualPhotoEditUI:GenerateElementID()
	VirtualPhotoEditUI.S_IdGenerator = VirtualPhotoEditUI.S_IdGenerator + 1

	return VirtualPhotoEditUI.S_IdGenerator
end

function VirtualPhotoEditUI:GetCurrentElement()
	for i = 1, #self.ElementControllers do
		local controller = self.ElementControllers[i]

		if controller.IsSelected then
			return controller
		end
	end

	return nil
end

function VirtualPhotoEditUI:RefreshElementLayers()
	for i = 1, #self.ElementControllers do
		local controller = self.ElementControllers[i]

		controller:SetIndex(i)
	end
end

return VirtualPhotoEditUI
