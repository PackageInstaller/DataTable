-- chunkname: @IQIGame\\UI\\Battle\\DamageCell.lua

local DamageCell = {
	PrefabType = 0
}
local BuffCell = require("IQIGame.UI.Common.BuffCell")

function DamageCell.New(view, prefabType)
	local obj = Clone(DamageCell)

	obj:Init(view, prefabType)

	return obj
end

function DamageCell:Init(view, prefabType)
	self.View = view
	self.PrefabType = prefabType

	LuaCodeInterface.BindOutlet(self.View, self)

	self.Animator = self.View:GetComponentInChildren(typeof(UnityEngine.Animator))

	if self.BuffIcon ~= nil then
		self.BuffCell = BuffCell.New(self.BuffIcon)
	end

	local rootTrans = self.View.transform:Find("Root")

	if rootTrans ~= nil then
		for i = 1, 6 do
			local imageTrans = rootTrans:Find("Image_0" .. i)

			if imageTrans ~= nil then
				if i == 1 then
					self.ElementIcons = {}
				end

				self.ElementIcons[i] = imageTrans.gameObject
			end
		end
	end
end

function DamageCell:SetData(skillType, damageType, value, hasEnergyShield, troopType)
	local text, colorTop, colorBottom, outlineColor = BattleDamageUIApi:GetString("DamageTextAndColor", skillType, damageType, value, hasEnergyShield, troopType == Constant.BattleTroopType.Defend)
	local textComponent = self.DamageTxt:GetComponent("Text")

	textComponent.text = text

	local gradientColor = self.DamageTxt:GetComponent("GradientColor")

	gradientColor.colorTop = colorTop
	gradientColor.colorBottom = colorBottom

	local outline = self.DamageTxt:GetComponent("Outline")

	outline.effectColor = outlineColor

	if self.ElementIcons ~= nil then
		for i = 1, #self.ElementIcons do
			self.ElementIcons[i]:SetActive(i == damageType)
		end
	end
end

function DamageCell:SetBuffText(buffCid, text, stack, troopType)
	local cfgBuffData = CfgBuffTable[buffCid]

	self.BuffCell.goView:SetActive(cfgBuffData.IsVisible)

	if cfgBuffData.IsVisible then
		self.BuffCell:Refresh(CfgBuffTable[buffCid], false, nil, nil, troopType)
	end

	self.DamageTxt:GetComponent("Text").text = BattleDamageUIApi:GetString("BuffText", text, stack)
end

function DamageCell:SetText(text)
	self.DamageTxt:GetComponent("Text").text = text
end

function DamageCell:IsFinished()
	return self.Animator:IsInTransition(0)
end

function DamageCell:Dispose()
	AssetUtil.UnloadAsset(self)

	if self.BuffCell ~= nil then
		self.BuffCell:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return DamageCell
