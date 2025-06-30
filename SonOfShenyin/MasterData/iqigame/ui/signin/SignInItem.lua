-- chunkname: @IQIGame\\UI\\SignIn\\SignInItem.lua

local m = {}

function m.New(view, Func)
	local obj = Clone(m)

	obj:Init(view, Func)

	return obj
end

function m:Init(view, Func)
	self.View = view
	self.SelectFunc = Func

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateSelectBtn()
		self:OnSelectBtnClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateSelectBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateSelectBtn)
end

function m:SetData(day, cfgData, isSign)
	self.Day = day

	UGUIUtil.SetText(self.ItemCount, cfgData.SignItemId[2])
	self:LoadImg(UIGlobalApi.GetIconPath(CfgItemTable[cfgData.SignItemId[1]].Icon), self.SlotImg)
	self.IsSingInImg:SetActive(isSign)
	self:LoadImg(SignInUIApi:GetDayImg(self.Day), self.DayImg)
end

function m:OnSelectBtnClick()
	if self.SelectFunc ~= nil then
		self.SelectFunc(self.Day)
	end
end

function m:Select()
	self.SelectImg:SetActive(true)
end

function m:UnSelect()
	self.SelectImg:SetActive(false)
end

function m:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"))
end

function m:SetVisible(state)
	self.View:SetActive(state)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
