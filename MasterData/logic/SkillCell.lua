-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/skill/SkillCell.lua

module("logic.extensions.material.proxy.skill.SkillCell", package.seeall)

local SkillCell = class("SkillCell", MaterialCell)

function SkillCell:ctor(target)
	SkillCell.super.ctor(self, target)

	self._ImgC_Icon = goutil.findChild(self.target, "Mask/ImgC_Icon"):GetComponent("UIImageSpriteChange")
	self._ImgC_skill = goutil.findChild(self.target, "Mask/ImgC_Skill"):GetComponent("Image")
end

function SkillCell:_onCustomInputCallback(hover)
	if hover then
		print("skill cell down >>>>>>")
		GameUtil.callBack(self._DownCallback)
	end
end

function SkillCell:setCfgData(skillCo)
	if checknumber(self.skinId) > 0 then
		skillCo = BattleConfig.instance:getSkillCo(skillCo.id, self.skinId)
	end

	SkillCell.super.setCfgData(self, skillCo)

	if self._customInput then
		self._customInput:RemoveListener()
	end

	self._customInput = UICustomInput.Get(self.target.gameObject)

	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._ImgC_skill.gameObject:SetActive(false)
	self._ImgC_Icon.gameObject:SetActive(false)

	if skillCo then
		self:showSkillName(true)
		self._ImgC_skill.gameObject:SetActive(true)

		local skicon = skillCo.skillImg

		uGuiUtil.setSpriteToImage(self._ImgC_skill.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(skicon))
	end
end

function SkillCell:setPetFaceId(skinId)
	self.skinId = skinId

	if self.cfg then
		self:setCfgData(self.cfg)
	end
end

function SkillCell:dispose()
	SkillCell.super.dispose(self)

	self._clickBack = nil
	self._DownCallback = nil

	MaterialMgr.clearIcon(self._ImgC_skill.gameObject)
end

function SkillCell:setCallBack(cb)
	self._clickBack = cb
end

function SkillCell:setDownCallBack(cb)
	self._DownCallback = cb
end

function SkillCell:SetSummonPetId(petId)
	self.summonId = petId

	local raceId = BagPetsFacade.instance:getPetRaceId(petId)

	self:SetSummonPetRaceId(raceId)
end

function SkillCell:SetSummonPetRaceId(raceId)
	self.summonPetRaceId = raceId

	if self.cfg then
		local type = GameEnum.SkillNameToType[self.cfg.type]

		if type == GameEnum.SkillRaceType.Summon and raceId > 0 then
			self._ImgC_Icon.gameObject:SetActive(false)
			self._ImgC_skill.gameObject:SetActive(true)

			local modelCo = CharacterConfig.instance:getModelCo(checknumber(raceId))

			uGuiUtil.setSpriteToImage(self._ImgC_skill.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		end
	end
end

function SkillCell:SetRaceIdIcon(raceId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(raceId))

	if modelCo then
		self._ImgC_Icon.gameObject:SetActive(false)
		self._ImgC_skill.gameObject:SetActive(true)
		uGuiUtil.setSpriteToImage(self._ImgC_skill.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	end
end

function SkillCell:showSkillName(boo)
	return
end

return SkillCell
