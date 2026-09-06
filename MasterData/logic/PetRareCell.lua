-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/rare/PetRareCell.lua

module("logic.extensions.material.proxy.rare.PetRareCell", package.seeall)

local PetRareCell = class("PetRareCell", RareCell)

PetRareCell.State_None = 0
PetRareCell.State_Pet = 1
PetRareCell.State_PetSkin = 2

function PetRareCell:ctor(target)
	PetRareCell.super.ctor(self, target)

	self._skinQuality = goutil.findChild(self._targetObj, "skinQuality")
	self._imgSex = goutil.findChild(self._targetObj, "imgSex")

	self:_setState(0)
end

function PetRareCell:setCfgData(cfg)
	if cfg.raceId == cfg.skinId then
		self:_setState(PetRareCell.State_Pet)

		cfg = CharacterConfig.instance:getPetCo(cfg.raceId)

		PetRareCell.super.setCfgData(self, cfg)
	else
		self:_setState(PetRareCell.State_PetSkin)

		if checknumber(cfg.isChangeSex) == 1 then
			GameUtil.SetActive(self._imgSex, true)
			GameUtil.SetActive(self._skinQuality, false)
		else
			GameUtil.SetActive(self._imgSex, false)

			if cfg.quality > 0 then
				GameUtil.SetActive(self._skinQuality, true)
				GameUtil.setUIImageSpriteIdx(self._skinQuality, cfg.quality)
			else
				GameUtil.SetActive(self._skinQuality, false)
			end
		end
	end
end

function PetRareCell:_setState(state)
	for i = 1, #self.imgList do
		GameUtil.SetActive(self.imgList[i], state == 1)
	end

	GameUtil.SetActive(self._skinQuality, state == PetRareCell.State_PetSkin)
	GameUtil.SetActive(self._imgSex, state == PetRareCell.State_PetSkin)
end

return PetRareCell
