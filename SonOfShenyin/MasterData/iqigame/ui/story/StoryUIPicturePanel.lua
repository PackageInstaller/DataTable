-- chunkname: @IQIGame\\UI\\Story\\StoryUIPicturePanel.lua

local StoryUIPicturePanel = class(nil, BaseChildrenPanel)

function StoryUIPicturePanel.New(go, mainView)
	local o = Clone(StoryUIPicturePanel)

	o:Initialize(go, mainView)

	return o
end

function StoryUIPicturePanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryUIPicturePanel:InitComponent()
	self.imagePicture = self.imagePicture:GetComponent("Image")
end

function StoryUIPicturePanel:InitDelegate()
	return
end

function StoryUIPicturePanel:AddListener()
	return
end

function StoryUIPicturePanel:RemoveListener()
	return
end

function StoryUIPicturePanel:OnDestroy()
	self:RemoveListener()
	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function StoryUIPicturePanel:Refresh(Data, posParam, ShowPictureTask)
	self.Data = Data

	if self.showPictureTask then
		self.showPictureTask:SetComplete()
	end

	self.showPictureTask = ShowPictureTask

	local path = CfgUtil.GetStoryResourceWithID(self.Data)

	if self.CurrentShow then
		LuaUtility.SetGameObjectShow(self.CurrentShow.gameObject, false)
	end

	if posParam == 0 then
		if LuaUtility.LoadImage(self, path, self.imagePicture, self._ImageLoadSuccess) == Constant.AssetUtilErrorCode.RepeatLoad then
			self:_ImageLoadSuccess()
		end

		LuaUtility.SetGameObjectShow(self.imagePicture.gameObject, true)

		self.CurrentShow = self.imagePicture
	else
		local img = self.SmallPictureRoot.transform:Find("Pos_" .. posParam):GetComponent("Image")
		local imgObject = img.gameObject

		self.CurrentShow = img

		if LuaUtility.LoadImage(self, path, img, self._NativeImageLoadSuccess) == Constant.AssetUtilErrorCode.RepeatLoad then
			self:_NativeImageLoadSuccess()
		end

		LuaUtility.SetGameObjectShow(imgObject, true)
	end
end

function StoryUIPicturePanel:_ImageLoadSuccess()
	if self.showPictureTask then
		self.showPictureTask:SetComplete()

		self.showPictureTask = nil
	end
end

function StoryUIPicturePanel:_NativeImageLoadSuccess()
	self.CurrentShow:SetNativeSize()

	if self.showPictureTask then
		self.showPictureTask:SetComplete()

		self.showPictureTask = nil
	end
end

return StoryUIPicturePanel
