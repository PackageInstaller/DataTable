-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceItemSeat.lua

module("logic.extensions.rankrace.view.RankRaceItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local RankRaceItemSeat = class("RankRaceItemSeat", ItemSeat)

function RankRaceItemSeat.AddOnce(go)
	local component = RankRaceItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, RankRaceItemSeat)

	return component
end

function RankRaceItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, RankRaceItemSeat))
end

function RankRaceItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, RankRaceItemSeat)
end

function RankRaceItemSeat:setRaceType(pet, raceMap)
	self._isHasPet = false

	self._ImgC_Forbid:SetState(0)

	if pet then
		self._isHasPet = true

		local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
		local race = 0
		local skinId = pet.raceId

		if raceMap and raceMap[pet.petId] ~= nil then
			race = raceMap[pet.petId]
		else
			if checknumber(pet.curFaceId) > 0 then
				skinId = checknumber(pet.curFaceId)
			end

			race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)
		end

		race = race % 10
		self.curRace = race

		self._ImgC_Info:SetState(race - 1)

		local rareNum = CharacterConfig.instance:getInitRare(pet.raceId)

		self._ImgC_Forbid:SetState(rareNum)

		if RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeClassics then
			self._txtLv.text = pet:getPetLv()
		elseif RankRaceController.instance:getCurViewType() == RankRaceController.MatchTypeLimit then
			self._txtLv.text = petCo.maxLv
		end

		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

		self._txtAtkType.text = ConstString.AtkTypeByIdx[firstJobIdx]
	end

	local hasPet = self._isHasPet

	self._layerUI:SetActive(hasPet)
	self._imageGo:SetActive(hasPet)
	self._ImgC_Info.gameObject:SetActive(hasPet)
	self._txtLv.gameObject:SetActive(hasPet)
	self._Nego_Character.gameObject:SetActive(hasPet)
	self._txtAtkType.gameObject:SetActive(hasPet)
	self._Btn_Summon.gameObject:SetActive(false)

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

return RankRaceItemSeat
