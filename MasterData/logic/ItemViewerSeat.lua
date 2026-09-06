-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/ItemViewerSeat.lua

module("logic.extensions.formation.view.ItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemViewerSeat = class("ItemViewerSeat")

function ItemViewerSeat.AddOnce(go)
	local component = ItemViewerSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemViewerSeat)

	return component
end

function ItemViewerSeat.Get(go)
	return (LuaComponentContainer.Get(go, ItemViewerSeat))
end

function ItemViewerSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, ItemViewerSeat)
end

function ItemViewerSeat:ctor(target)
	self._character = nil
	self._posId = 0
	self._order = 0
	self._isHiding = false
	self._target = target

	local Nego_Left = self._target.transform.parent.parent
	local index = string.sub(self._target.name, -1)
	local pathLayerBg = "layerBg/item" .. index
	local pathLayerUI = "layerUI/item" .. index
	local pathLayerRole = "layerRole/item" .. index
	local layerBgGo = goutil.findChild(Nego_Left, pathLayerBg)
	local layerUIGo = goutil.findChild(Nego_Left, pathLayerUI)
	local layerRoleGo = goutil.findChild(Nego_Left, pathLayerRole)

	self._ImgC_Forbid = goutil.findChild(layerBgGo, "ImgC_Forbid"):GetComponent("UIImageSpriteChange")
	self._ImgC_Sel = goutil.findChild(layerBgGo, "ImgC_Sel")
	self._restrainTxt = goutil.findChildTextComponent(layerBgGo, "Text")
	self._Nego_Character = goutil.findChild(layerRoleGo, "Nego_Character")
	self._ImgC_Info = goutil.findChild(layerUIGo, "ImgC_Info"):GetComponent("UIImageSpriteChange")
	self._Btn_Summon = goutil.findChild(layerUIGo, "Btn_Summon")
	self._ImgC_Title = goutil.findChildComponent(layerUIGo, "ImgC_Title", "UIImageSpriteChange")
	self._txtTitle = goutil.findChildComponent(layerUIGo, "txtTitle", goutil.Type_UIText)

	if self._txtTitle then
		self._txtTitle.gameObject:SetActive(false)
	end

	if self._ImgC_Title then
		self._ImgC_Title.gameObject:SetActive(false)
	end
end

function ItemViewerSeat:OnDestroy()
	return
end

function ItemViewerSeat:GetPosition()
	return self._posId
end

function ItemViewerSeat:SetSeatInfo(posId, pet)
	self._posId = posId
	self._isHiding = false
	self._pet = pet

	local isOpen = pet

	if self._pet then
		local hasPet = self._pet.raceId > 0

		if isOpen then
			self._ImgC_Forbid:SetState(1)
		else
			self._ImgC_Forbid:SetState(0)
		end

		self._ImgC_Info.gameObject:SetActive(hasPet)
		self._Nego_Character.gameObject:SetActive(hasPet)
		self._Btn_Summon.gameObject:SetActive(not isOpen and hasPet)

		if not hasPet then
			return
		end

		local petCo = CharacterConfig.instance:getPetCo(self._pet.raceId)
		local curFaceId = checknumber(pet.curFaceId)

		if checknumber(curFaceId) <= 0 then
			curFaceId = tonumber(petCo.faceIds)
		end

		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(curFaceId)

		self._ImgC_Info:SetState(race - 1)

		local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(tonumber(curFaceId))

		if not modelCfg[1] then
			local x = 0

			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					self._loader, self._lastCallBack, self._character = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._character)
					self._loader, self._lastCallBack = RoleObjectPool.instance:getRoleAsset(curFaceId, function(go)
						go:SetActive(true)
						goutil.addChildToParent(go, self._Nego_Character)
						Framework.TransformUtil.SetLocalPos(go.transform, x, y, 0)
						Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)

						self._character = go
					end, false)

					if self._ImgC_Title and self._txtTitle then
						local petTitleId = 0

						if pet then
							petTitleId = pet.petTitleId
						end

						local hasPetTitle = petTitleId and petTitleId > 0

						if hasPetTitle then
							local petTitleConf = PetTitleConfig.instance:getPetTitleConfig(petTitleId)

							self._txtTitle.text = petTitleConf.simpleName

							self._ImgC_Title:ChangeSprite(petTitleConf.icon2)
						end

						self._txtTitle.gameObject:SetActive(hasPetTitle)
						self._ImgC_Title.gameObject:SetActive(hasPetTitle)
					end
				end
			end
		end
	end
end

function ItemViewerSeat:HidePet()
	if not self._character then
		return
	end

	self._character.gameObject:SetActive(false)

	self._isHiding = true
end

function ItemViewerSeat:ShowPet()
	if not self._character then
		return
	end

	self._character.gameObject:SetActive(true)

	self._isHiding = false
end

function ItemViewerSeat:IsHiding()
	return self._isHiding
end

function ItemViewerSeat:IsOpen()
	return true
end

function ItemViewerSeat:SetSelect(visible)
	self._ImgC_Sel.gameObject:SetActive(visible)
end

function ItemViewerSeat:SetRestrain(txt, visible)
	if self._restrainTxt then
		self._restrainTxt.gameObject:SetActive(visible)

		self._restrainTxt.text = txt
	end
end

function ItemViewerSeat:GetData()
	return self._pet
end

return ItemViewerSeat
