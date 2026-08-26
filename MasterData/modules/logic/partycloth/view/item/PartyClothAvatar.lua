-- chunkname: @modules/logic/partycloth/view/item/PartyClothAvatar.lua

module("modules.logic.partycloth.view.item.PartyClothAvatar", package.seeall)

local PartyClothAvatar = class("PartyClothAvatar", LuaCompBase)

function PartyClothAvatar:init(go)
	self.go = go

	gohelper.setLayer(go, UnityLayer.Scene, true)

	self._resLoader = SpinePrefabInstantiate.Create(go)
	self._resPath = PartyGameEnum.PartyGameSceneSpineRes

	self._resLoader:startLoad(self._resPath, self._resPath, self._onResLoaded, self)
end

function PartyClothAvatar:_onResLoaded()
	self._spineGo = self._resLoader:getInstGO()
	self._spineComp = self._spineGo:AddComponent(typeof(PartyGame.Runtime.Spine.PartyGameLobbySceneSpine))

	if self._skinResMap then
		self:refreshSkin(self._skinResMap)

		self._skinResMap = nil
	end
end

function PartyClothAvatar:onDestroy()
	if self._resLoader then
		self._resLoader:dispose()
	end
end

function PartyClothAvatar:refreshSkin(resMap)
	if self._spineComp then
		if not resMap[PartyClothEnum.ClothType.Body] then
			if not resMap[PartyClothEnum.ClothType.Head] then
				local head = ""

				if not resMap[PartyClothEnum.ClothType.Pant] then
					local pant = ""

					if not resMap[PartyClothEnum.ClothType.Shoes] then
						local shoes = ""

						if not resMap[PartyClothEnum.ClothType.Hat] then
							local hat = ""

							if not resMap[PartyClothEnum.ClothType.Jacket] then
								local jacket = ""

								self._spineComp:SetSkins(resMap[PartyClothEnum.ClothType.Body], head, pant, shoes, hat, jacket)
							end
						end
					end
				end
			end
		end
	else
		self._skinResMap = resMap
	end
end

return PartyClothAvatar
