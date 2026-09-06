-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/talent/view/ItemTalent.lua

module("logic.extensions.talent.view.ItemTalent", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local StarCount = 5
local ItemTalent = class("ItemTalent")

function ItemTalent.AddOnce(go)
	local component = ItemTalent.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemTalent)

	return component
end

function ItemTalent.Remove(go)
	LuaComponentContainer.Remove(go, ItemTalent)
end

function ItemTalent.Get(go)
	return (LuaComponentContainer.Get(go, ItemTalent))
end

function ItemTalent:ctor(target)
	self.attrType = nil
	self._value = 0
	self._star = 0
	self._isOnStrength = false
	self.go = target.gameObject
	self._animator = self.go:GetComponent("Animator")
	self._ImgC_Bg = self.go:GetComponent("UIImageColorChange")
	self._ImgC_Icon = goutil.findChild(self.go, "ImgC_Icon"):GetComponent("UIImageSpriteChange")
	self._TxtC_Name = goutil.findChild(self.go, "TxtC_Name"):GetComponent("Text")
	self._Stars = {}

	for i = 1, StarCount do
		self._Stars[i] = goutil.findChild(self.go, string.format("Nego_Star/ImgC_Star%d", i)):GetComponent("UIImageSpriteChange")
	end

	self._TxtC_Value = goutil.findChild(self.go, "TxtC_Value"):GetComponent("Text")
	self._ImgC_UpDown = goutil.findChild(self.go, "ImgC_UpDown"):GetComponent("UIImageSpriteChange")
	self._TxtC_ValueNew = goutil.findChild(self.go, "TxtC_ValueNew"):GetComponent("Text")
	self._Btn_Strength = goutil.findChild(self.go, "Btn_Strength")
	self._Btn_Strength_Text = goutil.findChild(self._Btn_Strength, "Text"):GetComponent("Text")

	GameUtil.addClickHandler(self._Btn_Strength, self._OnClickStrength, self)
end

function ItemTalent:Init(attrType)
	self._attrType = attrType

	self._ImgC_Icon:SetState(attrType - 1)

	self._TxtC_Name.text = ConstString.Attr[attrType]
end

function ItemTalent:SetNormal(value, star)
	self._value, self._star = value, star
	self._TxtC_Value.text = value

	self:_SetStar(star)
	self._animator:Play(string.format("talent_item_%s_idle", self._isOnStrength and "strength" or "training"))
	self:_CheckStrengthState()
end

function ItemTalent:SetChange(oldValue, newValue, newStar)
	if oldValue == newValue then
		self:SetNormal(newValue, newStar)

		return
	end

	self._value, self._star = newValue, newStar
	self._TxtC_Value.text = oldValue
	self._TxtC_ValueNew.text = newValue

	self._ImgC_UpDown:SetState(oldValue < newValue and 0 or 1)
	self:_SetStar(newStar)
	self._animator:Play(string.format("talent_item_%s_change", self._isOnStrength and "strength" or "training"))
	self:_CheckStrengthState()
end

function ItemTalent:SetBg(isShow)
	self._ImgC_Bg:SetState(isShow and 1 or 0)
end

function ItemTalent:SetOnStrength(isOnStrength)
	self._isOnStrength = isOnStrength
	self._TxtC_Value.text = self._value

	self._animator:Play(self._isOnStrength and "talent_item_strength_idle" or "talent_item_training_idle")
end

function ItemTalent:_SetStar(count)
	local starType = count == 5 and 1 or 0

	for i = 1, StarCount do
		self._Stars[i]:SetState(i <= count and starType or 2)
	end
end

function ItemTalent:_CheckStrengthState()
	local isEnable = TalentConfig.instance:GetGeniusMaxValue() > self._value

	uGuiUtil.setGoGrayState(self._Btn_Strength, not isEnable)

	self._Btn_Strength_Text.text = isEnable and lang("tips_strength") or "MAX"
end

function ItemTalent:AddClickStrengthListner(cb)
	self._cb = cb
end

function ItemTalent:_OnClickStrength()
	if self._cb then
		self._cb(self._attrType)
	end
end

return ItemTalent
