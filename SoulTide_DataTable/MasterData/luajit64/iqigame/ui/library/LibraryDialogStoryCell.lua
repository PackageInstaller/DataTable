-- chunkname: @IQIGame\\UI\\Library\\LibraryDialogStoryCell.lua

local LibraryDialogStoryCell = {}

function LibraryDialogStoryCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_LibraryDialogStoryCell == nil then
		ui.__SUB_UI_MAP_LibraryDialogStoryCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_LibraryDialogStoryCell
	local areaCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		areaCell = LibraryDialogStoryCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = areaCell
	else
		areaCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return areaCell
end

function LibraryDialogStoryCell.__New(itemCellView)
	local itemCell = Clone(LibraryDialogStoryCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function LibraryDialogStoryCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.btnComponent = self.goView:GetComponent("Button")
	self.tweenPosition = self.goView:GetComponent("TweenPosition")

	function self.delegateClickBtn()
		self:OnClickBtn()
	end

	function self.delegateAlertCall()
		self:OpenDialog()
	end

	function self.delegateTweenEnd()
		self:OnTweenEnd()
	end

	self:AddListener()
end

function LibraryDialogStoryCell:AddListener()
	self.btnComponent.onClick:AddListener(self.delegateClickBtn)
end

function LibraryDialogStoryCell:RemoveListener()
	self.btnComponent.onClick:RemoveListener(self.delegateClickBtn)
end

function LibraryDialogStoryCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_LibraryDialogStoryCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_LibraryDialogStoryCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_LibraryDialogStoryCell = nil
end

function LibraryDialogStoryCell:SetData(data, index, resType)
	self.libraryStoryResData = data
	self.index = index
	self.resType = resType

	if data == nil then
		self:Clear()
	else
		self:Update()
	end
end

function LibraryDialogStoryCell:Update()
	self.dialogID, self.dialogName = self.libraryStoryResData:GetDialog()

	if self.libraryStoryResData.isLock then
		UGUIUtil.SetText(self.TextUnLock2, self.dialogName)
		UGUIUtil.SetText(self.TextLock2, self.dialogName)
	else
		UGUIUtil.SetText(self.TextUnLock2, LibraryStoryUIApi:GetString("TextLock"))
		UGUIUtil.SetText(self.TextLock2, LibraryStoryUIApi:GetString("TextLock"))
	end

	UGUIUtil.SetText(self.TextUnLock1, tostring(self.index))
	UGUIUtil.SetText(self.TextLock1, tostring(self.index))
	self.Unlock:SetActive(self.libraryStoryResData.isLock)
	self.Lock:SetActive(not self.libraryStoryResData.isLock)
end

function LibraryDialogStoryCell:OnClickBtn()
	self.tweenPosition.enabled = true

	self.tweenPosition:PlayForward()
	self.tweenPosition:SetOnFinished(self.delegateTweenEnd)
end

function LibraryDialogStoryCell:OnTweenEnd()
	self.tweenPosition:RemoveOnFinished(self.delegateTweenEnd)
	self.tweenPosition:ResetToBeginning()

	self.tweenPosition.enabled = false

	if self.libraryStoryResData.isLock == false then
		if self.libraryStoryResData.storyResType == Constant.LibraryStoryResType.ActionStoryMainType or self.libraryStoryResData.storyResType == Constant.LibraryStoryResType.ActionStoryBranchType then
			NoticeModule.ShowNotice(21041056)
		else
			NoticeModule.ShowNotice(21052004)
		end

		return
	end

	NoticeModule.ShowNotice(21040114, self.delegateAlertCall, nil, self)
end

function LibraryDialogStoryCell:OpenDialog()
	if self.dialogID > 0 then
		if self.resType == Constant.LibraryStoryResType.TownResMainType then
			UIModule.Open(Constant.UIControllerName.GirlOpening, Constant.UILayer.UI, {
				3,
				function(tab)
					DialogModule.OpenDialog(tab[1])
				end,
				{
					self.dialogID
				},
				self.dialogName
			})
		elseif self.resType == Constant.LibraryStoryResType.TownResBranchType then
			UIModule.Open(Constant.UIControllerName.GirlOpening, Constant.UILayer.UI, {
				4,
				function(tab)
					DialogModule.OpenDialog(tab[1])
				end,
				{
					self.dialogID
				},
				self.dialogName
			})
		elseif self.resType == Constant.LibraryStoryResType.SoulNewStoryResType then
			UIModule.Open(Constant.UIControllerName.GirlOpening, Constant.UILayer.UI, {
				1,
				function(tab)
					DialogModule.OpenDialog(tab[1])
				end,
				{
					self.dialogID
				},
				self.dialogName
			})
		elseif self.resType == Constant.LibraryStoryResType.SoulDatingResType then
			UIModule.Open(Constant.UIControllerName.GirlOpening, Constant.UILayer.UI, {
				2,
				function(tab)
					DialogModule.OpenDialog(tab[1])
				end,
				{
					self.dialogID
				},
				self.dialogName
			})
		else
			DialogModule.OpenDialog(self.dialogID)
		end
	else
		logError("对话ID错误　" .. self.libraryStoryResData.cfgID)
	end
end

function LibraryDialogStoryCell:Clear()
	self.goView:SetActive(false)
end

function LibraryDialogStoryCell:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return LibraryDialogStoryCell
