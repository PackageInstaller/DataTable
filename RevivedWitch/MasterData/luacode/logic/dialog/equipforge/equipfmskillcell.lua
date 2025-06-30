-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipfmskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillShow_Common = (BeanManager.GetTableByName)("skill.cskillshow_common")
local EquipFMSkillCell = class("EquipFMSkillCell", Dialog)
EquipFMSkillCell.AssetBundleName = "ui/layouts.equip"
EquipFMSkillCell.AssetName = "EquipFMSkill"
EquipFMSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipFMSkillCell
  ((EquipFMSkillCell.super).Ctor)(self, ...)
end

EquipFMSkillCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Num")
  self._unlockDescription = self:GetChild("Txt2")
  self._toggle = self:GetChild("_Toggle_0")
  ;
  (self._toggle):SetIsOnType(false)
  ;
  (self._toggle):Subscribe_PointerClickEvent(self.OnToggleClicked, self)
end

EquipFMSkillCell.OnDestroy = function(self)
  -- function num : 0_2
end

EquipFMSkillCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CSkillShow_Common, _ENV
  local name = (CSkillShow_Common:GetRecorder(data.skillId)).nameTextID
  name = (TextManager.GetText)(name)
  ;
  (self._name):SetText(name)
end

EquipFMSkillCell.OnToggleClicked = function(self)
  -- function num : 0_4
  (self._delegate):OnToggleClicked((self._cellData).skillId)
  ;
  (self._toggle):SetIsOnType(true)
end

EquipFMSkillCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if eventName == "OffAllToggle" then
    (self._toggle):SetIsOnType(false)
  end
end

return EquipFMSkillCell

