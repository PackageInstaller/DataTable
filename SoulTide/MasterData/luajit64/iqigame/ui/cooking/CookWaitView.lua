-- chunkname: @IQIGame\\UI\\Cooking\\CookWaitView.lua

local CookWaitView = {}

function CookWaitView.New(view, parentView)
	local obj = Clone(CookWaitView)

	obj:Init(view, parentView)

	return obj
end

function CookWaitView:Init(view, parentView)
	self.View = view
	self.parentView = parentView

	LuaCodeInterface.BindOutlet(self.View, self)

	self.btnCancel = self.BtnCancel:GetComponent("Button")

	function self.delegateBtnCancel()
		self:OnBtnCancel()
	end

	function self.delegateCancelCook()
		self:OnCancelCook()
	end

	self:AddListener()
end

function CookWaitView:AddListener()
	self.btnCancel.onClick:AddListener(self.delegateBtnCancel)
end

function CookWaitView:RemoveListener()
	self.btnCancel.onClick:RemoveListener(self.delegateBtnCancel)
end

function CookWaitView:OnBtnCancel()
	local str = ""

	if self.parentView.queueData.cid ~= nil and self.parentView.queueData.cid ~= "" then
		local itemID = CfgCookCombinationTable[self.parentView.queueData.cid].ItemId[1]
		local itemData = CfgItemTable[itemID]

		if itemData then
			str = itemData.Name
		end
	end

	NoticeModule.ShowNotice(21042015, self.delegateCancelCook, nil, self)
end

function CookWaitView:OnCancelCook()
	HomeLandLuaModule.CancelCook(self.parentView.cfgBuildingID, self.parentView.queueData.id)
end

function CookWaitView:Open()
	self.View:SetActive(true)
	UGUIUtil.SetText(self.TextBtnCancel, HomeLandCookingUIApi:GetString("TextBtnCancel"))
	UGUIUtil.SetText(self.TextWait1, HomeLandCookingUIApi:GetString("TextPutViewWait1"))
	UGUIUtil.SetText(self.TextWait2, HomeLandCookingUIApi:GetString("TextPutViewWait2"))
end

function CookWaitView:Close()
	self.View:SetActive(false)
end

function CookWaitView:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return CookWaitView
