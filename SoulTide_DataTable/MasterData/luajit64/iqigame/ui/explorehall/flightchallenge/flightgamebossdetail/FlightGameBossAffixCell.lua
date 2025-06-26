-- chunkname: @IQIGame\\UI\\ExploreHall\\FlightChallenge\\FlightGameBossDetail\\FlightGameBossAffixCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnSelf()
		self:OnBtnSelf()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnSelf)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnSelf)
end

function m:SetData(cfgData)
	self.cfgData = cfgData

	UGUIUtil.SetText(self.TextName, self.cfgData.EffectName)
end

function m:OnBtnSelf()
	UIModule.Open(Constant.UIControllerName.MagicWaxMuseumTipUI, Constant.UILayer.UI, {
		name = self.cfgData.EffectName,
		describe = self.cfgData.Describe,
		refTrans = self.View.transform
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
