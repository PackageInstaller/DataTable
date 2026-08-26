-- chunkname: @modules/logic/gm/view/FightGmCustomFightCharacterItem.lua

module("modules.logic.gm.view.FightGmCustomFightCharacterItem", package.seeall)

local FightGmCustomFightCharacterItem = class("FightGmCustomFightCharacterItem", FightBaseView)

function FightGmCustomFightCharacterItem:onInitView()
	self.btnDel = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn_del")
	self.posText = gohelper.findChildText(self.viewGO, "pos")
	self.nameText = gohelper.findChildText(self.viewGO, "name")
	self.nameBtn = gohelper.findChildClickWithDefaultAudio(self.viewGO, "name")
	self.levelInput = gohelper.findChildInputField(self.viewGO, "level")
	self.exLevelInput = gohelper.findChildInputField(self.viewGO, "exLevel")
	self.equipText = gohelper.findChildText(self.viewGO, "equip")
	self.equipBtn = gohelper.findChildClickWithDefaultAudio(self.viewGO, "equip")
	self.equipLevelInput = gohelper.findChildInputField(self.viewGO, "equipLevel")
	self.talentLevelInput = gohelper.findChildInputField(self.viewGO, "talentLevel")
	self.talentStyleInput = gohelper.findChildInputField(self.viewGO, "talentStyle")
	self.factsIdInput = gohelper.findChildInputField(self.viewGO, "factsId")
	self.extraPassiveSkillInput = gohelper.findChildInputField(self.viewGO, "extraPassiveSkill")
	self.extraAttrInput = gohelper.findChildInputField(self.viewGO, "extraAttr")
end

function FightGmCustomFightCharacterItem:addEvents()
	self:com_registClick(self.btnDel, self.onClickDelBtn)
	self:com_registClick(self.nameBtn, self.onClickNameBtn)
	self:com_registClick(self.equipBtn, self.onClickEquipBtn)
	self.levelInput:AddOnValueChanged(self.onLevelInputChange, self)
	self.exLevelInput:AddOnValueChanged(self.onExLevelInputChange, self)
	self.equipLevelInput:AddOnValueChanged(self.onEquipLevelInputChange, self)
	self.talentLevelInput:AddOnValueChanged(self.onTalentLevelInputChange, self)
	self.talentStyleInput:AddOnValueChanged(self.onTalentStyleInputChange, self)
	self.factsIdInput:AddOnValueChanged(self.onFactsIdInputChange, self)
	self.extraPassiveSkillInput:AddOnValueChanged(self.onExtraPassiveSkillInputChange, self)
	self.extraAttrInput:AddOnValueChanged(self.onExtraAttrInputChange, self)
end

function FightGmCustomFightCharacterItem:onClickDelBtn()
	self.data.heroId = 0

	self:onRefreshItemData(self.data)
end

function FightGmCustomFightCharacterItem:onClickNameBtn()
	self.PARENT_VIEW:onClickSelectCharacter(self)
end

function FightGmCustomFightCharacterItem:onClickEquipBtn()
	self.PARENT_VIEW:onClickEquipCharacter(self)
end

function FightGmCustomFightCharacterItem:onRefreshItemData(data)
	self.data = data
	self.posText.text = self.data.pos
	self.characterConfig = lua_character.configDict[self.data.heroId]

	if self.characterConfig then
		self.nameText.text = self.characterConfig.name or "nil"
	end

	self.levelInput:SetText(tostring(self.data.level))
	self.exLevelInput:SetText(tostring(self.data.exLevel))

	if lua_equip.configDict[self.data.equipId] then
		self.equipText.text = lua_equip.configDict[self.data.equipId].name

		self.equipLevelInput:SetText(tostring(self.data.equipLevel))
		self.talentLevelInput:SetText(tostring(self.data.talentLevel))
		self.talentStyleInput:SetText(tostring(self.data.talentStyle))
		self.factsIdInput:SetText(tostring(self.data.factsId))
		self.extraPassiveSkillInput:SetText(tostring(self.data.extraPassiveSkill))
		self.extraAttrInput:SetText(tostring(self.data.extraAttr))
	end
end

function FightGmCustomFightCharacterItem:onLevelInputChange()
	local text = self.levelInput:GetText()

	self.data.level = tonumber(text)
end

function FightGmCustomFightCharacterItem:onExLevelInputChange()
	local text = self.exLevelInput:GetText()

	self.data.exLevel = tonumber(text)
end

function FightGmCustomFightCharacterItem:onEquipLevelInputChange()
	local text = self.equipLevelInput:GetText()

	self.data.equipLevel = tonumber(text)
end

function FightGmCustomFightCharacterItem:onTalentLevelInputChange()
	local text = self.talentLevelInput:GetText()

	self.data.talentLevel = tonumber(text)
end

function FightGmCustomFightCharacterItem:onTalentStyleInputChange()
	local text = self.talentStyleInput:GetText()

	self.data.talentStyle = tonumber(text)
end

function FightGmCustomFightCharacterItem:onFactsIdInputChange()
	local text = self.factsIdInput:GetText()

	self.data.factsId = tonumber(text)
end

function FightGmCustomFightCharacterItem:onExtraPassiveSkillInputChange()
	self.data.extraPassiveSkill = self.extraPassiveSkillInput:GetText()
end

function FightGmCustomFightCharacterItem:onExtraAttrInputChange()
	self.data.extraAttr = self.extraAttrInput:GetText()
end

function FightGmCustomFightCharacterItem:onDestructor()
	self.levelInput:RemoveOnValueChanged()
	self.exLevelInput:RemoveOnValueChanged()
	self.equipLevelInput:RemoveOnValueChanged()
	self.talentLevelInput:RemoveOnValueChanged()
	self.talentStyleInput:RemoveOnValueChanged()
	self.factsIdInput:RemoveOnValueChanged()
	self.extraPassiveSkillInput:RemoveOnValueChanged()
	self.extraAttrInput:RemoveOnValueChanged()
end

return FightGmCustomFightCharacterItem
