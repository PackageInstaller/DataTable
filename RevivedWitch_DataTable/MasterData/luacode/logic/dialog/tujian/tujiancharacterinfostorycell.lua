-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/tujian/tujiancharacterinfostorycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local TuJianCharacterInfoStoryCell = class("TuJianCharacterInfoStoryCell", Dialog)
TuJianCharacterInfoStoryCell.AssetBundleName = "ui/layouts.tujian"
TuJianCharacterInfoStoryCell.AssetName = "TuJianCharInfoStory"
TuJianCharacterInfoStoryCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TuJianCharacterInfoStoryCell
  ((TuJianCharacterInfoStoryCell.super).Ctor)(self, ...)
end

TuJianCharacterInfoStoryCell.OnCreate = function(self)
  -- function num : 0_1
  self._describe = self:GetChild("Describe/Name")
  self._story = self:GetChild("Story/Name")
end

TuJianCharacterInfoStoryCell.OnDestroy = function(self)
  -- function num : 0_2
end

TuJianCharacterInfoStoryCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CRoleConfigTable, _ENV
  local roleConfig = CRoleConfigTable:GetRecorder(data.id)
  ;
  (self._describe):SetText((TextManager.GetText)(roleConfig.shortintro))
  ;
  (self._story):SetText((TextManager.GetText)(roleConfig.backstory))
end

return TuJianCharacterInfoStoryCell

