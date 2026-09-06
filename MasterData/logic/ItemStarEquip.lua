-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starequipment/view/ItemStarEquip.lua

module("logic.extensions.starequipment.view.ItemStarEquip", package.seeall)

local ItemStarEquip = class("ItemStarEquip")
local LuaComponentContainer = Framework.LuaComponentContainer

function ItemStarEquip:ctor(go)
	self.mainGO = go

	local container = goutil.findChild(go, "item")

	self._imgIcon = goutil.findChild(container, "imgIcon")
	self._imgQua = goutil.findChildComponent(container, "imgQua", "UIImageSpriteChange")
	self._txtName = goutil.findChildComponent(container, "txtName", "Text")
	self._txtNum = goutil.findChildComponent(container, "txtNum", "Text")
	self._txtLevel = goutil.findChildComponent(container, "txtLevel", "Text")
	self._selected = goutil.findChild(container, "selected")
	self._btn = Framework.ButtonAdapter.Get(container)

	self._btn:AddClickListener(self._onClickSelf, self)

	self._longPressed = container:GetComponent("UILongPressed")
	self._imgPetIcon = goutil.findChild(container, "imgPetIcon")
	self._selectedX = goutil.findChild(container, "selectedX")
end

function ItemStarEquip.AddOnce(go)
	local component = LuaComponentContainer.Get(go, ItemStarEquip)

	component = component or LuaComponentContainer.Add(go, ItemStarEquip)

	return component
end

function ItemStarEquip:onSetMo(data)
	self._mo = data

	uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.cfg.icon))

	if data.matType == MatType.StarEquipment then
		self._imgQua:SetState(1 + data.cfg.quality)
	elseif data.matType == MatType.Item then
		self._imgQua:SetState(1 + data.cfg.quality)
	end

	self._txtName.text = data.cfg.name
	self._txtLevel.text = ""

	self._longPressed:RemoveListener()

	local petId = checknumber(data.petId)
	local petMo = BagPetsController.instance:getPet(petId)

	goutil.setActive(self._imgPetIcon, petMo ~= nil)

	self._petMo = petMo

	if petMo ~= nil then
		local modelCo = CharacterConfig.instance:getModelCo(petMo.raceId)

		uGuiUtil.setSpriteToImage(self._imgPetIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

		self._txtLevel.text = string.format("Lv.%s", checknumber(data.level))
		self._txtNum.text = ""
	end

	self._longPressed:AddListener(function(target, isUp)
		self:_onLongPressed(isUp)
	end, self)
end

function ItemStarEquip:setSelectedNum(selectedNum)
	selectedNum = checknumber(selectedNum)

	goutil.setActive(self._selected, selectedNum > 0)

	self._txtNum.text = self._petMo == nil and math.max(0, self._mo.num - selectedNum) or ""
end

function ItemStarEquip:setSelected(selected)
	goutil.setActive(self._selectedX, selected)
end

function ItemStarEquip:setClickCall(handler, handlerTarget)
	self._handler = handler
	self._handlerTarget = handlerTarget
end

function ItemStarEquip:setLongPressedCall(handler, handlerTarget)
	self._longPressHandler = handler
	self._longPressHandlerTarget = handlerTarget
end

function ItemStarEquip:_onClickSelf()
	if self._handlerTarget ~= nil and self._handler ~= nil then
		self._handler(self._handlerTarget, self, self._mo)
	end
end

function ItemStarEquip:_onLongPressed(isUp)
	print("long press equip item isUp = " .. tostring(isUp))

	if self._longPressHandler ~= nil and self._longPressHandlerTarget ~= nil then
		self._longPressHandler(self._longPressHandlerTarget, self, self._mo, isUp)
	end
end

return ItemStarEquip
