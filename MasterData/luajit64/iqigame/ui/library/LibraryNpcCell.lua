-- chunkname: @IQIGame\\UI\\Library\\LibraryNpcCell.lua

local LibraryNpcCell = {}

function LibraryNpcCell.New(view)
	local obj = Clone(LibraryNpcCell)

	obj:Init(view)

	return obj
end

function LibraryNpcCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnSelf = self.View:GetComponent("Button")

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function LibraryNpcCell:AddListener()
	self.btnSelf.onClick:AddListener(self.delegateBtnSelf)
end

function LibraryNpcCell:RemoveListener()
	self.btnSelf.onClick:RemoveListener(self.delegateBtnSelf)
end

function LibraryNpcCell:SetData(data)
	self.townLibraryNpcData = data

	self:UpdateView()
end

function LibraryNpcCell:UpdateView()
	self.RedPoint:SetActive(false)
	self.UnLock:SetActive(self.townLibraryNpcData.isLock)
	self.Lock:SetActive(not self.townLibraryNpcData.isLock)
	UGUIUtil.SetText(self.TextNameUnLock, LibraryNpcListUIApi:GetString("TextNpcName", self.townLibraryNpcData.cfgInfo.Name, self.townLibraryNpcData.isLock))
	UGUIUtil.SetText(self.TextNameLock, LibraryNpcListUIApi:GetString("TextNpcName", self.townLibraryNpcData.cfgInfo.Name, self.townLibraryNpcData.isLock))

	local iconPath = UIGlobalApi.GetImagePath(self.townLibraryNpcData.cfgInfo.Image)

	AssetUtil.LoadImage(self, iconPath, self.ImgIconUnLock:GetComponent("Image"))
	AssetUtil.LoadImage(self, iconPath, self.ImgIconLock:GetComponent("Image"))
end

function LibraryNpcCell:OnBtnSelf()
	UIModule.Open(Constant.UIControllerName.LibraryNpcInfoUI, Constant.UILayer.UI, self.townLibraryNpcData)
end

function LibraryNpcCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryNpcCell
