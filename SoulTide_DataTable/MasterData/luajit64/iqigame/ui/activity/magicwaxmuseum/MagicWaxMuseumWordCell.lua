-- chunkname: @IQIGame\\UI\\Activity\\MagicWaxMuseum\\MagicWaxMuseumWordCell.lua

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
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnTip)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnTip)
end

function m:SetData(cfgData)
	self.cfgData = cfgData

	UGUIUtil.SetText(self.TextName, self.cfgData.EffectName)
end

function m:OnBtnTip()
	local describeStr = LinkTipUIApi:GetString("goDesc", self.cfgData.Describe)

	UIModule.Open(Constant.UIControllerName.MagicWaxMuseumTipUI, Constant.UILayer.UI, {
		name = self.cfgData.EffectName,
		describe = describeStr,
		refTrans = self.View.transform
	})
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
