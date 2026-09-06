-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ItemGene.lua

module("logic.extensions.zoo.view.ItemGene", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemGene = class("ItemGene")

ItemGene.ResPath = "ui/views/zoo/item_gene.prefab"

function ItemGene:ctor(go)
	self.mainGO = go

	self:buildUI()
end

function ItemGene.AddOnce(go)
	local component = ItemPet.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemGene)

	return component
end

function ItemGene:buildUI()
	self._name = goutil.findChildTextComponent(self.mainGO, "name")
	self._effectiveIcon = goutil.findChild(self.mainGO, "effectiveIcon")
	self._icon = goutil.findChild(self.mainGO, "icon")
	self._changeIcon = self._icon:GetComponent(ComponentType.UIImageSpriteChange)
end

function ItemGene:setData(data)
	self._data = data
	self._name.text = data.name
	self._btn = Framework.ButtonAdapter.Get(self.mainGO.gameObject)

	self._btn:RemoveClickListener()
	self._btn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.GeneTipView, self._data, self.mainGO:GetComponent(goutil.Type_RectTransform))
	end)

	if data.part then
		self._changeIcon:SetState(data.part - 1)
	else
		self._changeIcon:SetState(8)
	end

	goutil.setActive(self._effectiveIcon, false)
end

function ItemGene:setEffective(flag)
	goutil.setActive(self._effectiveIcon, flag)
end

function ItemGene:setClickCallBack(callBack, callBackObject)
	self._btn:RemoveClickListener()
	self._btn:AddClickListener(function()
		callBack(callBackObject, self._data)
	end)
end

return ItemGene
