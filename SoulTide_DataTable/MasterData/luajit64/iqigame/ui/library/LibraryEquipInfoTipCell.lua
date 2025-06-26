-- chunkname: @IQIGame\\UI\\Library\\LibraryEquipInfoTipCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnTip()
		self:OnBtnTip()
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
end

function m:RemoveListener()
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
end

function m:SetData(str)
	self.sourceDescTxt = LibraryEquipApi:GetString("TextAbility", str)

	local str = UIGlobalApi.GetTextWithoutKeywordTag(self.sourceDescTxt)

	UGUIUtil.SetText(self.TextDes, str)
end

function m:OnBtnTip()
	if UIGlobalApi.CheckExistKeywordTag(self.sourceDescTxt) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			self.sourceDescTxt,
			self.View
		})
	end
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
