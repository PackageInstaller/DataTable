local CSkillShow_Common = BeanManager.GetTableByName("skill.cskillshow_common")
local CRandomAbilityTable = BeanManager.GetTableByName("equip.crandomability")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local EquipListSkillCell = class("EquipListSkillCell", Dialog)
EquipListSkillCell.AssetBundleName = "ui/layouts.equip"
EquipListSkillCell.AssetName = "EquipListSkill"

function EquipListSkillCell:Ctor(...)
  EquipListSkillCell.super.Ctor(self, ...)
end

function EquipListSkillCell:OnCreate()
  self._image = self:GetChild("Image")
  self._text = self:GetChild("Txt")
  self._width, self._height = self._text:GetRectSize()
  local _ = 0
  _, self._oneline = self._text:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._text:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._text:GetPosition()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function EquipListSkillCell:OnDestroy()
end

function EquipListSkillCell:RefreshCell(data)
  local imageRecord = CImagePathTable:GetRecorder(11470) or DataCommon.DefaultImageAsset
  self._image:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = ""
  local name = CSkillShow_Common:GetRecorder(data.skillId).nameTextID
  name = TextManager.GetText(name)
  local discribe = CSkillShow_Common:GetRecorder(data.skillId).exDiscribeTextID
  discribe = TextManager.GetText(discribe)
  discribe = string.gsub(discribe, "%%", "%%%%")
  str = TextManager.GetText(CStringRes:GetRecorder(1208).msgTextID)
  str = string.gsub(str, "%$parameter1%$", name)
  str = string.gsub(str, "%$parameter2%$", discribe)
  self._text:SetText(str)
  local _, textheight = self._text:GetPreferredSize()
  if textheight > self._height then
    local line = math.ceil((textheight - self._height) / self._oneline)
    local delta = line * self._oneline
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
    self:GetRootWindow():SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y - delta)
  else
    self._text:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
    self._text:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
    self:GetRootWindow():SetPosition(self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y)
  end
end

return EquipListSkillCell
