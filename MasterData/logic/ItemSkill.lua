-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/item/ItemSkill.lua

module("logic.extensions.bag.view.item.ItemSkill", package.seeall)

local ItemSkill = class("ItemSkill")

ItemSkill.Events = {}
ItemSkill.Events.OnClick = "ItemSkill.Events.OnClick"
ItemSkill.ResPath = "ui/views/common/item_skill.prefab"
ItemSkill.SkillType = {
	物攻 = lang("attr_attack_physical"),
	魔攻 = lang("attr_attack_magic")
}
ItemSkill.SkillIdx = {
	魔攻 = 7,
	物攻 = 6
}

function ItemSkill.Get(go)
	local LuaComponentContainer = Framework.LuaComponentContainer
	local component = LuaComponentContainer.Get(go, ItemSkill)

	component = component or LuaComponentContainer.Add(go, ItemSkill)

	return component
end

function ItemSkill:ctor(target)
	NotifyDispatcher.extend(self)

	self._target = target
	self._ImgC_Bg = goutil.findChild(self._target, "ImgC_Bg"):GetComponent("UIImageSpriteChange")
	self._ImgC_Icon = goutil.findChild(self._target, "Mask/ImgC_Icon"):GetComponent("UIImageSpriteChange")
	self._ImgC_skill = goutil.findChild(self._target, "Mask/ImgC_Skill"):GetComponent("Image")
	self._ImgC_Type = goutil.findChild(self._target, "ImgC_Type"):GetComponent("UIImageSpriteChange")

	local txtObj = goutil.findChild(self._target, "TxtC_Type")

	if txtObj then
		self._TxtC_Type = txtObj:GetComponent("Text")
	end

	self.btn = Framework.ButtonAdapter.Get(target.gameObject)

	self.btn:AddClickListener(self._OnClick, self)
end

function ItemSkill:OnDestroy()
	self.btn:RemoveClickListener()
	self:removeAllListener(ItemSkill.Events.OnClick)

	self._target = nil
	self._ImgC_Icon = nil
	self._TxtC_Type = nil
	self._ImgC_Bg = nil
end

function ItemSkill:SetValue(type, skillId)
	self._skillType = type
	self._skillId = skillId

	local langStr = ConstString.SkillType[type]

	self._ImgC_Bg:SetState(type - 1)
	self._ImgC_Type:SetState(type - 1)
	self._ImgC_Icon:SetState(type - 1)
	self._ImgC_Icon.gameObject:SetActive(true)
	self._ImgC_skill.gameObject:SetActive(false)

	local conf = BattleConfig.instance:getSkillCo(skillId)

	if type == GameEnum.SkillRaceType.Normal then
		local powerType = conf.powerType

		langStr = ItemSkill.SkillType[powerType]

		local tem = ItemSkill.SkillIdx[powerType]

		self._ImgC_Icon:SetState(tem - 1)
	elseif type == GameEnum.SkillRaceType.Summon then
		-- block empty
	elseif type == GameEnum.SkillRaceType.Hero and conf ~= nil then
		local skicon = conf.skillIcon

		skicon = skicon == "" and "skill_" .. skillId or "skill_" .. skicon

		self._ImgC_Icon.gameObject:SetActive(false)
		self._ImgC_skill.gameObject:SetActive(true)
		uGuiUtil.setSpriteToImage(self._ImgC_skill.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(skicon))
	end

	if self._TxtC_Type then
		self._TxtC_Type.text = langStr
	end
end

function ItemSkill:SetContractValue(txt)
	if self._TxtC_Type then
		self._TxtC_Type.text = txt
	end
end

function ItemSkill:SetSummonPetId(id)
	local raceId = BagPetsFacade.instance:getPetRaceId(id)

	if raceId > 0 then
		self._ImgC_Icon.gameObject:SetActive(false)
		self._ImgC_skill.gameObject:SetActive(true)

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(raceId))

		uGuiUtil.setSpriteToImage(self._ImgC_skill.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
	end
end

function ItemSkill:_OnClick()
	self:dispatch(ItemSkill.Events.OnClick, self._skillType, self._skillId)
end

return ItemSkill
