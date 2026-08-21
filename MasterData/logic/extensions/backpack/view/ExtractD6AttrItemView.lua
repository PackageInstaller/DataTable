-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/ExtractD6AttrItemView.lua

module("logic.extensions.backpack.view.ExtractD6AttrItemView", package.seeall)

local M = class("ExtractD6AttrItemView")
local iconPrefix = "25010"

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()

	self._data = nil
end

function M:_buildUI()
	self._imgColorDiGo = goutil.findChildImageComponent(self._mainGo, "d6_lay/d6_attribute_item1/unlock/imgDi")
	self._txtD6AttributeUnlock = goutil.findChildTextComponent(self._mainGo, "d6_lay/d6_attribute_item1/unlock/txtD6Attribute")
	self._txtD6AttributeLock = goutil.findChildTextComponent(self._mainGo, "d6_lay/d6_attribute_item1/lock/txtLock")
	self._imgIcon = goutil.findChildImageComponent(self._mainGo, "cell/backpack_item/imgIcon")
	self._imgQuality = goutil.findChildImageComponent(self._mainGo, "cell/backpack_item/imgQuality")

	local equipHoleItemGo = goutil.findChild(self._mainGo, "d6_lay/d6_attribute_item1/equip_hole_item")

	self._equipHoleItemView = Astral.LuaComponentContainer.Add(equipHoleItemGo, EquipHoleItemView)
	self._currentGo = goutil.findChild(self._mainGo, "d6_lay/d6_attribute_item1/unlock/current")

	self._currentGo:SetActive(false)
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
end

function M:setData(diceAttrMo, part, quality)
	self._dice = diceAttrMo
	self._data = diceAttrMo:getEffectAttr():getCopyForExtract()
	self._txtD6AttributeUnlock.text = self._data:getDesc()
	self._txtD6AttributeLock.text = self._txtD6AttributeUnlock.text

	self._equipHoleItemView:setData(self._data)
	IconLoader.setSprite(self._imgIcon, IconType.D6Icon, self:getIcon(part, quality))
end

function M:getIcon(part, quality)
	local qualityIcon = EquipEnum.EquipD6Quality2IconNum[quality]

	return iconPrefix .. part .. qualityIcon
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._equipHoleItemView = nil
end

function M:setCurrentGoVisible(visible)
	self._currentGo:SetActive(visible)
end

function M:setStatus(status)
	for i = 1, 6 do
		self._statusGo[i]:SetActive(false)
	end

	goutil.setActive(self._statusGo[status], true)
	self._equipHoleItemView:setStatus(status)
end

return M
