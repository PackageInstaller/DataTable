-- chunkname: @IQIGame\\UI\\SoulHandbook\\SoulHandBookCell.lua

local SoulHandBookCell = {}

function SoulHandBookCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_SoulHandBookCell == nil then
		ui.__SUB_UI_MAP_SoulHandBookCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_SoulHandBookCell
	local handBookCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		handBookCell = SoulHandBookCell.__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = handBookCell
	else
		handBookCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	handBookCell.bookUI = ui.parent

	return handBookCell
end

function SoulHandBookCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_SoulHandBookCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_SoulHandBookCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_SoulHandBookCell = nil
end

function SoulHandBookCell:AddListener()
	self.btnSelfComponent.onClick:AddListener(self.delegateBtnSelf)
end

function SoulHandBookCell:RemoveListener()
	self.btnSelfComponent.onClick:RemoveListener(self.delegateBtnSelf)
end

function SoulHandBookCell.__New(view)
	local obj = Clone(SoulHandBookCell)

	obj:Init(view)

	return obj
end

function SoulHandBookCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnSelfComponent = self.ImgBG:GetComponent("Button")

	function self.delegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function SoulHandBookCell:SetData(soulHandBookData)
	self.handBookData = soulHandBookData
	self.soulData = SoulModule.GetSoulData(self.handBookData.cfgInfo.SoulId)

	if self.handBookData == nil then
		self:Clear()
	else
		self:Update()
	end
end

function SoulHandBookCell:Update()
	if self.handBookData ~= nil then
		if self.handBookData.cfgInfo.BookType == Constant.BookType.BookTypeCG then
			self:ShowCG()
		elseif self.handBookData.cfgInfo.BookType == Constant.BookType.BookTypeCV then
			self:ShowCV()
		elseif self.handBookData.cfgInfo.BookType == Constant.BookType.BookTypeDialog then
			self:ShowDialog()
		elseif self.handBookData.cfgInfo.BookType == Constant.BookType.BookTypeMovie then
			self:ShowMovie()
		end

		local path = SoulHandBookUIApi:GetString("BtnIconPath", self.handBookData.cfgInfo.BookType)

		AssetUtil.LoadImage(self, path, self.IconBtn:GetComponent("Image"))
	end
end

function SoulHandBookCell:ShowMovie()
	self.Lock:SetActive(not self.handBookData.open)

	local cfgCGInfo = CfgCGTable[self.handBookData.cfgInfo.CGCVId]
	local isFullLv = self.soulData.favorLv >= self.handBookData.cfgInfo.NeedSoulFavorLv

	self.TextCondition:GetComponent("Text").text = SoulHandBookUIApi:GetString("TextCondition", self.handBookData.cfgInfo.LockingDescribe, self.handBookData.cfgInfo.NeedSoulFavorLv, isFullLv)
	self.TextName:GetComponent("Text").text = SoulHandBookUIApi:GetString("HandBookName", cfgCGInfo.CGName, self.handBookData.open)

	local path = UIGlobalApi.GetHarmoniousImagePath(cfgCGInfo.CGPicture)

	AssetUtil.LoadImage(self, path, self.ImgBG:GetComponent("Image"))
	self.View:GetComponent("ImageGroupGrayComponent"):EnableGray(not self.handBookData.open)
	self.BtnIcon:SetActive(self.handBookData.open)
	self.NewTag:SetActive(self.handBookData:IsNewState(self.soulData.favorLv))
end

function SoulHandBookCell:ShowDialog()
	self.Lock:SetActive(not self.handBookData.open)

	local isFullLv = self.soulData.favorLv >= self.handBookData.cfgInfo.NeedSoulFavorLv

	self.TextCondition:GetComponent("Text").text = SoulHandBookUIApi:GetString("TextCondition", self.handBookData.cfgInfo.LockingDescribe, self.handBookData.cfgInfo.NeedSoulFavorLv, isFullLv)
	self.TextName:GetComponent("Text").text = SoulHandBookUIApi:GetString("HandBookName", self.handBookData.cfgInfo.DialogName, self.handBookData.open)

	local path = UIGlobalApi.GetHarmoniousImagePath(self.handBookData.cfgInfo.CGPicture)

	AssetUtil.LoadImage(self, path, self.ImgBG:GetComponent("Image"))
	self.View:GetComponent("ImageGroupGrayComponent"):EnableGray(not self.handBookData.open)
	self.BtnIcon:SetActive(self.handBookData.open)
	self.NewTag:SetActive(self.handBookData:IsNewState(self.soulData.favorLv))
end

function SoulHandBookCell:ShowCG()
	self.Lock:SetActive(not self.handBookData.open)

	local cfgCGInfo = CfgCGTable[self.handBookData.cfgInfo.CGCVId]
	local isFullLv = self.soulData.favorLv >= self.handBookData.cfgInfo.NeedSoulFavorLv

	self.TextCondition:GetComponent("Text").text = SoulHandBookUIApi:GetString("TextCondition", self.handBookData.cfgInfo.LockingDescribe, self.handBookData.cfgInfo.NeedSoulFavorLv, isFullLv)
	self.TextName:GetComponent("Text").text = SoulHandBookUIApi:GetString("HandBookName", cfgCGInfo.CGName, self.handBookData.open)

	local path = UIGlobalApi.GetHarmoniousImagePath(cfgCGInfo.CGPicture)

	AssetUtil.LoadImage(self, path, self.ImgBG:GetComponent("Image"))
	self.View:GetComponent("ImageGroupGrayComponent"):EnableGray(not self.handBookData.open)
	self.BtnIcon:SetActive(self.handBookData.open)
	self.NewTag:SetActive(self.handBookData:IsNewState(self.soulData.favorLv))
end

function SoulHandBookCell:ShowCV()
	self.Lock:SetActive(not self.handBookData.open)

	local cfgSoulAction = CfgSoulActionTable[self.handBookData.cfgInfo.CGCVId]
	local isFullLv = self.soulData.favorLv >= self.handBookData.cfgInfo.NeedSoulFavorLv

	self.TextCondition:GetComponent("Text").text = SoulHandBookUIApi:GetString("TextCondition", self.handBookData.cfgInfo.LockingDescribe, self.handBookData.cfgInfo.NeedSoulFavorLv, isFullLv)
	self.TextName:GetComponent("Text").text = SoulHandBookUIApi:GetString("HandBookName", cfgSoulAction.ActionName, self.handBookData.open)

	local path = UIGlobalApi.GetHarmoniousImagePath(self.handBookData.cfgInfo.CGPicture)

	AssetUtil.LoadImage(self, path, self.ImgBG:GetComponent("Image"))
	self.View:GetComponent("ImageGroupGrayComponent"):EnableGray(not self.handBookData.open)
	self.BtnIcon:SetActive(self.handBookData.open)
	self.NewTag:SetActive(self.handBookData:IsNewState(self.soulData.favorLv))
end

function SoulHandBookCell:OnBtnSelf()
	if self.handBookData.cfgInfo.BookType == Constant.BookType.BookTypeCG then
		self:PlayCG()
	elseif self.handBookData.cfgInfo.BookType == Constant.BookType.BookTypeCV then
		self:PlayCV()
	elseif self.handBookData.cfgInfo.BookType == Constant.BookType.BookTypeDialog then
		self:PlayDialog()
	elseif self.handBookData.cfgInfo.BookType == Constant.BookType.BookTypeMovie then
		self:PlayMovie()
	end
end

function SoulHandBookCell:PlayDialog()
	if self.handBookData.open == false then
		NoticeModule.ShowNotice(21040128)

		return
	end

	DialogModule.OpenDialog(self.handBookData.cfgInfo.CGCVId)
end

function SoulHandBookCell:PlayMovie()
	if self.bookUI.avProView.isCurtain then
		return
	end

	if self.handBookData.open == false then
		NoticeModule.ShowNotice(21040128)

		return
	end

	self.bookUI:PlayMovie(CfgCGTable[self.handBookData.cfgInfo.CGCVId])
end

function SoulHandBookCell:PlayCG()
	if self.bookUI.avProView.isCurtain then
		return
	end

	if self.handBookData.open == false then
		NoticeModule.ShowNotice(21040128)

		return
	end

	local cfgCGInfo = CfgCGTable[self.handBookData.cfgInfo.CGCVId]
	local pathTab = {}

	table.insert(pathTab, UIGlobalApi.GetHarmoniousImagePath(cfgCGInfo.CgLink))

	if #cfgCGInfo.CgGroup > 0 then
		for i = 1, #cfgCGInfo.CgGroup do
			local str = cfgCGInfo.CgGroup[i]

			if str ~= nil and str ~= "" then
				table.insert(pathTab, UIGlobalApi.GetHarmoniousImagePath(str))
			end
		end
	end

	UIModule.Open(Constant.UIControllerName.SoulCgShowUI, Constant.UILayer.UI, {
		pathTab,
		cfgCGInfo.CgPicturePosition
	})
end

function SoulHandBookCell:PlayCV()
	if self.handBookData.open == false then
		NoticeModule.ShowNotice(21040128)

		return
	end

	local actionId = self.handBookData.cfgInfo.CGCVId

	if actionId > 0 then
		GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.HandBook_Action, actionId))
	end
end

function SoulHandBookCell:Clear()
	self.View:SetActive(false)
	self.bookUI.BtnJump:SetActive(false)

	self.handBookData = nil
end

function SoulHandBookCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return SoulHandBookCell
