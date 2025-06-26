-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogMazeCell.lua

local LibraryDialogMazeCell = {
	isLock = false,
	isOpen = false
}
local LibraryDialogMazeMsgView = require("IQIGame.UI.Library.LibraryDialogMazeMsgView")

function LibraryDialogMazeCell.New(view)
	local obj = Clone(LibraryDialogMazeCell)

	obj:Init(view)

	return obj
end

function LibraryDialogMazeCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.dialogMazeMsgView = LibraryDialogMazeMsgView.New(self.Content)
	self.btnTitle = self.Title:GetComponent("Button")

	function self.delegateBtnTitle()
		self:OnBtnTitle()
	end

	self:AddListener()
end

function LibraryDialogMazeCell:AddListener()
	self.btnTitle.onClick:AddListener(self.delegateBtnTitle)
end

function LibraryDialogMazeCell:RemoveListener()
	self.btnTitle.onClick:RemoveListener(self.delegateBtnTitle)
end

function LibraryDialogMazeCell:OnBtnTitle()
	if self.isLock then
		self.isOpen = not self.isOpen

		if self.isOpen then
			self.dialogMazeMsgView:Open()
			self.dialogMazeMsgView:SetDate(self.townLibraryStoryData)
		else
			self.dialogMazeMsgView:Close()
		end
	end

	if self.clickCallBack then
		self.clickCallBack(self)
	end

	self.ImgUnLock:SetActive(self.isLock and not self.isOpen)
end

function LibraryDialogMazeCell:CloseChildView()
	self.isOpen = false

	self.dialogMazeMsgView:Close()
	self.ImgUnLock:SetActive(self.isLock and not self.isOpen)
end

function LibraryDialogMazeCell:UpdateView()
	self.isLock = self.townLibraryStoryData:IsLock()

	self.Lock:SetActive(not self.isLock)
	self.ImgUnLock:SetActive(self.isLock and not self.isOpen)

	local cfgStoryBook = CfgTownStoryBookTable[self.townLibraryStoryData.cfgID]
	local iconPath = UIGlobalApi.GetImagePath(cfgStoryBook.ButtonImage)

	AssetUtil.LoadImage(self, iconPath, self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, cfgStoryBook.Name)
	UGUIUtil.SetText(self.TextNameEng, cfgStoryBook.EngName)
end

function LibraryDialogMazeCell:SetDate(data, index)
	self.dialogMazeMsgView:Close()

	self.townLibraryStoryData = data
	self.index = index

	self:UpdateView()
end

function LibraryDialogMazeCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self.dialogMazeMsgView:Dispose()
	self:RemoveListener()

	self.clickCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryDialogMazeCell
