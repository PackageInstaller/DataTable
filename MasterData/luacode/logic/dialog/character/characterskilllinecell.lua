local CharacterSkillLineCell = class("CharacterSkillLineCell", Dialog)
CharacterSkillLineCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterSkillLineCell.AssetName = "CharSkillNewLine"

function CharacterSkillLineCell:Ctor(...)
  CharacterSkillLineCell.super.Ctor(self, ...)
end

function CharacterSkillLineCell:OnCreate()
end

function CharacterSkillLineCell:OnDestroy()
end

return CharacterSkillLineCell
