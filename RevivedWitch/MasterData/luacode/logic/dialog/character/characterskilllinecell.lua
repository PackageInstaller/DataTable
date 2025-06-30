-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/characterskilllinecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CharacterSkillLineCell = class("CharacterSkillLineCell", Dialog)
CharacterSkillLineCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterSkillLineCell.AssetName = "CharSkillNewLine"
CharacterSkillLineCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterSkillLineCell
  ((CharacterSkillLineCell.super).Ctor)(self, ...)
end

CharacterSkillLineCell.OnCreate = function(self)
  -- function num : 0_1
end

CharacterSkillLineCell.OnDestroy = function(self)
  -- function num : 0_2
end

return CharacterSkillLineCell

