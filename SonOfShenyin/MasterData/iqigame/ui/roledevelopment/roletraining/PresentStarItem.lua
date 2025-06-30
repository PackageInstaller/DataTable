-- chunkname: @IQIGame\\UI\\RoleDevelopment\\RoleTraining\\PresentStarItem.lua

local m = {}
local anim = {
	"presentStarItemPrefab_01_In",
	"presentStarItemPrefab_02_In",
	"presentStarItemPrefab_03_In",
	"presentStarItemPrefab_04_Out"
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.animCom = self.View:GetComponent("Animation")

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(lv)
	self.off:SetActive(false)
	AssetUtil.LoadImage(self, RoleDevelopmentApi:GetRoleStarImg(lv), self.on:GetComponent("Image"))
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:PlayAnim(index, showEffect)
	self.animCom:Play(anim[index])

	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	if showEffect then
		self.effectID = GameEntry.Effect:PlayUIMountPointEffect(10007, 50000, 0, self.EffectParent, 0)
	end
end

function m:Dispose()
	if self.effectID ~= nil then
		GameEntry.Effect:StopEffect(self.effectID)
	end

	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
