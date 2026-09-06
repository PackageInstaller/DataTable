-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petselect/view/ItemPetSelect.lua

module("logic.extensions.petselect.view.ItemPetSelect", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemPetSelect = class("ItemPetSelect")

ItemPetSelect.ResPath = "ui/views/petselect/item_petselect.prefab"

function ItemPetSelect.AddOnce(go)
	local component = ItemPetSelect.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemPetSelect)

	return component
end

function ItemPetSelect.Remove(go)
	LuaComponentContainer.Remove(go, ItemPetSelect)
end

function ItemPetSelect.Get(go)
	return (LuaComponentContainer.Get(go, ItemPetSelect))
end

function ItemPetSelect:ctor(target)
	self._target = target.gameObject
	self._Nego_Info = goutil.findChild(self._target, "Nego_Info")
	self.txtPower = goutil.findChildTextComponent(self._target, "powerImg/txtPower")
	self._TxtC_Name = goutil.findChild(self._target, "TxtC_Name"):GetComponent("Text")
	self.ImgC_Bg = goutil.findChild(self._target, "ImgC_Bg"):GetComponent("UIChangeGroup")
	self.stargod = goutil.findChild(self._target, "stargod")
	self.icon = goutil.findChild(self._target, "stargod/icon"):GetComponent("UIImageSpriteChange")
	self.txtName = goutil.findChildTextComponent(self._target, "stargod/txtName")
	self._awake = goutil.findChild(self._target, "awake")
	self._btnAwake = goutil.findChild(self._target, "awake/btnAwake")
	self._imgAwake = goutil.findChild(self._target, "awake/btnAwake/imgLv")
	self._powerImg = goutil.findChild(self._target, "powerImg")
	self._txtBagPetSkinName = goutil.findChildTextComponent(self._target, "txtBagPetSkinName")
	self._selectGo = goutil.findChild(self._target, "img_select")
	self._imgWaikuangGo = goutil.findChild(self._target, "ImgC_Bg/imgWaikuang")
	self._topGo = goutil.findChild(self._target, "ImgC_Bg/top")
end

function ItemPetSelect:Init(petId)
	self.petId = petId

	if not self.petMo then
		local petMo = BagPetsController.instance:getPet(petId)
		local petCo = CharacterConfig.instance:getPetCo(petMo.raceId)
		local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCo.faceIds))

		self.txtPower.text = "" .. petMo:getFightingPower()

		if petMo and petMo.runeSuit and petMo.runeSuit.runeSuitId and petMo.runeSuit.runeSuitId > 0 then
			GameUtil.SetActive(self.stargod, true)
			self.icon:SetState(petMo.runeSuit.runeSuitId - 1)

			local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, petMo.runeSuit.runeSuitId)

			self.txtName.text = cfg.name
		else
			GameUtil.SetActive(self.stargod, false)
		end

		GameUtil.SetActive(self._awake, false)

		local powerImgPosY = -17.7
		local bagpetskinName = ""
		local proxy

		if not self.isNotBagPet then
			proxy = MaterialMgr.setCellByGId(MatType.Pet, petId, self._Nego_Info)
		else
			proxy = MaterialMgr.setCellByCfg(MatType.Pet .. ":" .. petMo.curFaceId, self._Nego_Info)

			if self.showbagpetRaceName and petMo.curFaceId ~= petMo.raceId then
				powerImgPosY = -33.3

				local baseskinCfg = PetSkinConfig.instance:getPetSkinCfg(petMo.raceId)

				bagpetskinName = baseskinCfg.skinName
			end
		end

		self._txtBagPetSkinName.text = bagpetskinName

		Framework.TransformUtil.SetAnchoredPos(self._powerImg.transform, -33, powerImgPosY)

		self.proxy = proxy

		if proxy then
			if petMo then
				if checknumber(petMo.level) > 0 then
					proxy.binder:setLvl(petMo.level)
				end

				if checknumber(petMo.awakenLv) > 0 then
					GameUtil.SetActive(self._awake, true)
					GameUtil.setUIImageSpriteIdx(self._imgAwake, petMo.awakenLv)
				end
			end

			proxy:setAutoTips(false)
			proxy.binder:setCallBack(function()
				self:_OnClick()
			end)
		end

		self._TxtC_Name.text = petMo.name

		self:_CheckSelectState()
		self:_checkTopState(petMo.raceId)
		GameUtil.asBtn(goutil.findChild(self._target, "btnClick")):RemoveClickListener()
		GlobalDispatcher:removeListener(GlobalNotify.PetSelectChanged, self._CheckSelectState, self)
		GameUtil.asBtn(goutil.findChild(self._target, "btnClick")):AddClickListener(self._OnClick, self)
		GlobalDispatcher:addListener(GlobalNotify.PetSelectChanged, self._CheckSelectState, self)
	end
end

function ItemPetSelect:OnDestroy()
	MaterialMgr.resetAll(self._Nego_Info)

	self.proxy = nil
	self.isNotBagPet = nil
	self.petMo = nil

	self:setSelect(false)
	GameUtil.asBtn(goutil.findChild(self._target, "btnClick")):RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.PetSelectChanged, self._CheckSelectState, self)
end

function ItemPetSelect:_OnClick()
	local isGray = PetSelectController.instance:IsCannotSelect(self.petId)

	if isGray then
		-- block empty
	else
		PetSelectController.instance:OnPetSelectChanged(self.petId)
	end
end

function ItemPetSelect:_CheckSelectState()
	local isSelect = PetSelectController.instance:IsPetSelected(self.petId)

	self:setSelect(isSelect)

	local isGray = PetSelectController.instance:IsCannotSelect(self.petId)

	GameUtil.SetGray(self._target, isGray == true)

	if self.proxy then
		self.proxy.binder:setGray(isGray == true)
	end
end

function ItemPetSelect:setSelect(isSelect)
	goutil.setActive(self._selectGo, isSelect)
end

function ItemPetSelect:_checkTopState(raceId)
	local isTop = PetSelectController.instance:isTop(raceId)

	goutil.setActive(self._imgWaikuangGo, not isTop)
	goutil.setActive(self._topGo, isTop)
end

return ItemPetSelect
