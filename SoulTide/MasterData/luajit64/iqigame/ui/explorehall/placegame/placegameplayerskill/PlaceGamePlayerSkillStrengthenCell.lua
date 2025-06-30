-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGamePlayerSkill\\PlaceGamePlayerSkillStrengthenCell.lua

local m = {
	checkTxt = ""
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnEffectTxt()
		self:OnBtnEffectTxt()
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateBtnEffectTxt)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnEffectTxt)
end

function m:OnBtnEffectTxt()
	if self.clickEffectTxt then
		self.clickEffectTxt(self.checkTxt)
	end
end

function m:SetData(desStr, unlock)
	self.checkTxt = desStr

	self.Lock:SetActive(not unlock)
	self.UnLock:SetActive(unlock)
	UGUIUtil.SetText(self.TextDes, UIGlobalApi.GetTextWithoutKeywordTag(desStr))
end

function m:Dispose()
	self.OnClickEffectTxt = nil

	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
