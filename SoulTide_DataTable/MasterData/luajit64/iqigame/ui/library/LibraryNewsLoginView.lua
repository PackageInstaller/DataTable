-- chunkname: @IQIGame\\UI\\Library\\LibraryNewsLoginView.lua

local LibraryNewsLoginView = {}

function LibraryNewsLoginView.New(view, parent)
	local obj = Clone(LibraryNewsLoginView)

	obj:Init(view, parent)

	return obj
end

function LibraryNewsLoginView:Init(view, parent)
	self.View = view
	self.rootParent = parent

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextNewsTitle, LibraryNewsUIApi:GetString("TextNewsTitle"))
	UGUIUtil.SetText(self.TextTitle1, LibraryNewsUIApi:GetString("NewsType1"))
	UGUIUtil.SetText(self.TextTitle2, LibraryNewsUIApi:GetString("NewsTypeDes1"))
	UGUIUtil.SetText(self.TextTitle3, LibraryNewsUIApi:GetString("NewsType2"))
	UGUIUtil.SetText(self.TextTitle4, LibraryNewsUIApi:GetString("NewsTypeDes2"))

	function self.delegateBtnType1()
		self:OnBtnType1()
	end

	function self.delegateBtnType2()
		self:OnBtnType2()
	end

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateUpdateLibraryNews()
		self:UpdateRed()
	end

	self:OnAddListeners()
end

function LibraryNewsLoginView:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnType1:GetComponent("Button").onClick:AddListener(self.delegateBtnType1)
	self.BtnType2:GetComponent("Button").onClick:AddListener(self.delegateBtnType2)
	EventDispatcher.AddEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateLibraryNews)
end

function LibraryNewsLoginView:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnType1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnType1)
	self.BtnType2:GetComponent("Button").onClick:RemoveListener(self.delegateBtnType2)
	EventDispatcher.RemoveEventListener(EventID.UpdateLibraryNewsEvent, self.delegateUpdateLibraryNews)
end

function LibraryNewsLoginView:OnBtnType1()
	self.rootParent:OpenTypeNews(1)
end

function LibraryNewsLoginView:OnBtnType2()
	self.rootParent:OpenTypeNews(2)
end

function LibraryNewsLoginView:UpdateRed()
	local isRed1 = false
	local isRed2 = false

	for i, v in pairs(TownLibraryModule.newsTab) do
		if v.isLock and v.cfgInfo.PaperType == 1 then
			if isRed1 == false then
				isRed1 = v:IsGetReward()
			end
		elseif v.isLock and v.cfgInfo.PaperType == 2 and isRed2 == false then
			isRed2 = v:IsGetReward()
		end
	end

	self.ImgRedType1:SetActive(isRed1)
	self.ImgRedType2:SetActive(isRed2)
end

function LibraryNewsLoginView:Open()
	self.View:SetActive(true)
	self:UpdateRed()
end

function LibraryNewsLoginView:Close()
	self.View:SetActive(false)
end

function LibraryNewsLoginView:OnClickBtnClose()
	self.rootParent:OnBtnClose()
end

function LibraryNewsLoginView:Dispose()
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return LibraryNewsLoginView
