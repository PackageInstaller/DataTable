-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/item/ItemAttr.lua

module("logic.extensions.bag.view.item.ItemAttr", package.seeall)

local ItemAttr = class("ItemAttr")

ItemAttr.ResPath = "ui/views/common/item_attr.prefab"

function ItemAttr.Get(go)
	local LuaComponentContainer = Framework.LuaComponentContainer
	local component = LuaComponentContainer.Get(go, ItemAttr)

	component = component or LuaComponentContainer.Add(go, ItemAttr)

	return component
end

function ItemAttr:ctor(target)
	self._target = target
	self._ImgC_Icon = goutil.findChild(self._target, "ImgC_Icon"):GetComponent("UIImageSpriteChange")
	self._TxtC_Name = goutil.findChild(self._target, "TxtC_Name"):GetComponent("Text")
	self._TxtC_Value = goutil.findChild(self._target, "TxtC_Value"):GetComponent("Text")
	self._ImgC_Score = goutil.findChildComponent(self._target, "ImgC_Score", typeof(UIImageSpriteChange))

	self._ImgC_Score.gameObject:SetActive(false)

	self.rcdColor = self._TxtC_Value.color
	self._animPlay = false
	self._animDelta = 0
end

function ItemAttr:OnDestroy()
	self._target = nil
	self._ImgC_Icon = nil
	self._TxtC_Name = nil
	self._TxtC_Value = nil
end

function ItemAttr:SetIsRate(boo)
	self.isRate = boo
end

function ItemAttr:SetValue(type, value, isRace)
	self._ImgC_Icon:SetState(type - 1)

	self._TxtC_Name.text = ConstString.Attr[type]
	self._showValue = value
	self._TxtC_Value.text = self.isRate and GameUtil.getMillesimalStr(value * 1000) or value
end

function ItemAttr:setScore(score)
	if score ~= nil and score >= GameEnum.PetAttrScore.D and score <= GameEnum.PetAttrScore.SSS then
		self._ImgC_Score.gameObject:SetActive(true)
		self._ImgC_Score:SetState(score)
	else
		self._ImgC_Score.gameObject:SetActive(false)
	end
end

function ItemAttr:ChangeValue(type, value, isRace)
	self._ImgC_Icon:SetState(type - 1)

	self._TxtC_Name.text = ConstString.Attr[type]

	local last = self._showValue

	self._showValue = value
	self._TxtC_Value.text = self.isRate and GameUtil.getMillesimalStr(value * 1000) or value

	if value ~= last then
		self:_Animation()
	end
end

function ItemAttr:_Animation()
	self._animDelta = ServerTime.now()

	if self._animPlay then
		return
	end

	self._TxtC_Value.color = Color.green
	self._TxtC_Value.transform.localScale = Vector3.one * 1.2

	settimer(0, self._AnimationDone, self, true)
end

function ItemAttr:_AnimationDone()
	if ServerTime.now() - self._animDelta < 1 then
		return
	end

	self._TxtC_Value.color = self.rcdColor
	self._TxtC_Value.transform.localScale = Vector3.one
	self._animPlay = false

	removetimer(self._AnimationDone, self)
end

function ItemAttr:setExt(open)
	GameUtil.SetActive(self._TxtC_Name, open)

	if open then
		GameUtil.setAnchoredPos(self._TxtC_Value, 50, 0)
	else
		GameUtil.setAnchoredPos(self._TxtC_Value, 5, 0)
	end
end

return ItemAttr
