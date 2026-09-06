-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/item/ItemEgg.lua

module("logic.extensions.bag.view.item.ItemEgg", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemEgg = class("ItemEgg")

ItemEgg.ResPath = "ui/views/common/item_egg.prefab"
ItemEgg.Events = {}
ItemEgg.Events.Click = "ItemEgg.Events.Click"

function ItemEgg.AddOnce(go)
	local component = ItemEgg.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemEgg)

	return component
end

function ItemEgg.Remove(go)
	LuaComponentContainer.Remove(go, ItemEgg)
end

function ItemEgg.Get(go)
	return (LuaComponentContainer.Get(go, ItemEgg))
end

function ItemEgg:ctor(target)
	NotifyDispatcher.extend(self)

	self._target = target.gameObject
	self._data = nil

	self:_InitChild(self._target)
end

function ItemEgg:_InitChild(target)
	self._icon = goutil.findChild(target, "Icon")

	if self._icon then
		self._spBg = goutil.findChild(target, "IconBg"):GetComponent("UIImageSpriteChange")
		self._spUp = goutil.findChild(target, "IconUp"):GetComponent("UIImageSpriteChange")

		local cgo = goutil.findChild(target, "Carrer")

		if cgo then
			self._carrerIcon = cgo:GetComponent("UIImageSpriteChange")
		end

		self.btn = Framework.ButtonAdapter.Get(target.gameObject)

		self.btn:AddClickListener(self._OnClick, self)
	end

	self._longPress = target.gameObject:GetComponent("UILongPressed")

	if self._longPress then
		self._longPress:AddListener(function(tar, isUp)
			self:_onLongPress(isUp)
		end, self)
	end
end

function ItemEgg:setLongPressFunc(downFunc, upFunc)
	self._longPressDownFunc = downFunc
	self._longPressUpFunc = upFunc
end

function ItemEgg:Init(cfg)
	self._data = cfg

	if self._icon == nil then
		self:_LoadAndShow()
	else
		self:_SetData()
	end

	return self
end

function ItemEgg:_LoadAndShow()
	self._prefabLoader = PrefabLoader.Get(self._target)

	self._prefabLoader:load(ItemEgg.ResPath, self._onBodyLoaded, self, true)
end

function ItemEgg:_onBodyLoaded(loader)
	self._prefabGO = self._prefabLoader:getInst()

	self:_InitChild(self._prefabGO)
	self:_SetData()
end

function ItemEgg:_SetData()
	local cfg = self._data

	if self._carrerIcon then
		self._carrerIcon.gameObject:SetActive(false)

		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.raceId)

		self._carrerIcon:SetState(firstJobIdx - 1)
	end

	local race = GameEnum.Races[GameUtil.splitRaceTypes(cfg.raceType)[1]]
	local petCo = CharacterConfig.instance:getPetCo(cfg.petId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

	uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	self._spBg:SetState(race - 1)
	self._spUp:SetState(race - 1)
end

function ItemEgg:OnDestroy()
	self.btn:RemoveClickListener()
	self:removeAllListener(ItemEgg.Events.Click)

	if self._longPress then
		self._longPress:RemoveListener()
	end

	self._target = nil
	self._data = nil
end

function ItemEgg:_OnClick()
	self:dispatch(ItemEgg.Events.Click, self._data)
end

function ItemEgg:_onLongPress(isUp)
	if isUp then
		if self._longPressUpFunc then
			self._longPressUpFunc()
		end
	elseif self._longPressDownFunc then
		self._longPressDownFunc()
	end
end

function ItemEgg:GetData()
	return self._data
end

return ItemEgg
