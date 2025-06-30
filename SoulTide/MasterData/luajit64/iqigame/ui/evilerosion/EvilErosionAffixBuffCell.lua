-- chunkname: @IQIGame\\UI\\EvilErosion\\EvilErosionAffixBuffCell.lua

local m = {
	SkillSpecialEffectExplainCid = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickView()
		self:OnClickView()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickView)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickView)
end

function m:SetData(cid)
	self.SkillSpecialEffectExplainCid = cid

	local cfgSkillSpecialEffectExplainData = CfgSkillSpecialEffectExplainTable[cid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgSkillSpecialEffectExplainData.Icon), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.NameText, cfgSkillSpecialEffectExplainData.EffectName)
end

function m:OnClickView()
	UIModule.Open(Constant.UIControllerName.EvilErosionBuffTipsUI, Constant.UILayer.UI, {
		speEffectCids = EvilErosionModule.GetAffixSkillSpeEffects(),
		srcTrans = self.View.transform,
		srcSide = UGUISide.TopLeft,
		tipSide = UGUISide.BottomLeft
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
