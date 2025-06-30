-- chunkname: @IQIGame\\UI\\Memory\\MemoryFragmentDetailView.lua

MemoryFragmentDetailView = {}

function MemoryFragmentDetailView.New(ui, memoryChapterView)
	local cloneObject = Clone(MemoryFragmentDetailView)

	cloneObject:InitView(ui, memoryChapterView)

	return cloneObject
end

function MemoryFragmentDetailView:InitView(ui, memoryChapterView)
	self.ui = ui
	self.memoryChapterView = memoryChapterView

	LuaCodeInterface.BindOutlet(ui, self)

	self.imgFragmentIcon = self.img_FragmentIcon:GetComponent("Image")
	self.txtDescription = self.txt_Description:GetComponent("Text")
	self.btnClose = self.btn_Close:GetComponent("Button")
	self.txtCancelDescription = self.txt_CancelDescription:GetComponent("Text")

	function self.delegateOnClickBtnClose()
		self:OnClickBtnClose()
	end
end

function MemoryFragmentDetailView:AddEventListeners()
	self.btnClose.onClick:AddListener(self.delegateOnClickBtnClose)
end

function MemoryFragmentDetailView:RemoveEventListeners()
	self.btnClose.onClick:RemoveListener(self.delegateOnClickBtnClose)
end

function MemoryFragmentDetailView:CloseUI()
	self:RemoveEventListeners()
	self.ui.gameObject:SetActive(false)
end

function MemoryFragmentDetailView:Dispose()
	LuaCodeInterface.ClearOutlet(self.ui, self)

	self.ui = nil
end

function MemoryFragmentDetailView:OpenUI(fragmentData)
	self.ui.gameObject:SetActive(true)
	self:AddEventListeners()

	if self.cfgFragmentData == nil or self.cfgFragmentData.Id ~= fragmentData.Id then
		self.cfgFragmentData = fragmentData

		local iconPath = UIGlobalApi.GetImagePath(fragmentData.Icon)

		AssetUtil.LoadImage(self, iconPath, self.imgFragmentIcon, self.OnLoadSucceed, self.OnLoadFailed)

		self.txtDescription.text = fragmentData.Describe2
		self.txt_Title:GetComponent("Text").text = self.cfgFragmentData.Name
	end

	self.txtCancelDescription.text = MemoryUIApi:GetString("GetLabBtnCancelTxt")
end

function MemoryFragmentDetailView:OnClickBtnClose()
	self.memoryChapterView:CloseFragmentDetailView()
end

function MemoryFragmentDetailView.UnloadAsset()
	AssetUtil.UnloadAsset(self)
end
