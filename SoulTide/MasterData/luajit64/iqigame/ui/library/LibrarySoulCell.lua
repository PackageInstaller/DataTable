-- chunkname: @IQIGame\\UI\\Library\\LibrarySoulCell.lua

local LibrarySoulCell = {}

function LibrarySoulCell.New(view)
	local obj = Clone(LibrarySoulCell)

	obj:Init(view)

	return obj
end

function LibrarySoulCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnSelf = self.View:GetComponent("Button")

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function LibrarySoulCell:AddListener()
	self.btnSelf.onClick:AddListener(self.delegateBtnSelf)
end

function LibrarySoulCell:RemoveListener()
	self.btnSelf.onClick:RemoveListener(self.delegateBtnSelf)
end

function LibrarySoulCell:SetData(data)
	self.townLibrarySoulData = data

	self:UpdateView()
end

function LibrarySoulCell:UpdateView()
	self.UnLock:SetActive(self.townLibrarySoulData.isLock)
	self.Lock:SetActive(not self.townLibrarySoulData.isLock)
	UGUIUtil.SetText(self.TextNameUnLock, LibrarySoulApi:GetString("TextSoulName", self.townLibrarySoulData.cfgInfo.Name, self.townLibrarySoulData.isLock))
	UGUIUtil.SetText(self.TextNameLock, LibrarySoulApi:GetString("TextSoulName", self.townLibrarySoulData.cfgInfo.Name, self.townLibrarySoulData.isLock))

	local iconPath = UIGlobalApi.GetImagePath(self.townLibrarySoulData.cfgInfo.SoulArchieveHead)

	AssetUtil.LoadImage(self, iconPath, self.ImgIconUnLock:GetComponent("Image"))
	AssetUtil.LoadImage(self, iconPath, self.ImgIconLock:GetComponent("Image"))
end

function LibrarySoulCell:OnBtnSelf()
	UIModule.Open(Constant.UIControllerName.LibrarySoulInfoUI, Constant.UILayer.UI, {
		self.townLibrarySoulData,
		true
	})
end

function LibrarySoulCell:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibrarySoulCell
