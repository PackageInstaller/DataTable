local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRoleRarityCfgTable = BeanManager.GetTableByName("role.croleraritycfg")
local cImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CWordColor = BeanManager.GetTableByName("message.cwordcolor")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local Role = require("logic.manager.experimental.types.role")
local GachaRateUpCellCell = class("GachaRateUpCellCell", Dialog)
GachaRateUpCellCell.AssetBundleName = "ui/layouts.gacha"
GachaRateUpCellCell.AssetName = "GachaRateUpCell"

function GachaRateUpCellCell:Ctor(...)
  GachaRateUpCellCell.super.Ctor(self, ...)
end

function GachaRateUpCellCell:OnCreate()
  self._rank = self:GetChild("Image")
  self._name = self:GetChild("Name")
  self._rateTxt = self:GetChild("Text")
  self._width, self._height = self._name:GetRectSize()
  local _ = 0
  _, self._oneline = self._name:GetPreferredSize()
  self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y = self._name:GetSize()
  self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y = self._name:GetPosition()
  self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y = self:GetRootWindow():GetSize()
  self._talk_pos_x, self._talk_pos_offset_x, self._talk_pos_y, self._talk_pos_offset_y = self:GetRootWindow():GetPosition()
end

function GachaRateUpCellCell:OnDestroy()
end

function GachaRateUpCellCell:RefreshCell(data)
  local rarityStr = {
    "R",
    "SR",
    "SSR",
    "UR"
  }
  local drawinfoId = CRoleRarityCfgTable:GetRecorder(data.rarity).drawinfo
  local imageRecord = cImagePathTable:GetRecorder(drawinfoId) or DataCommon.DefaultImageAsset
  self._rank:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = TextManager.GetText(CStringRes:GetRecorder(1112).msgTextID)
  str = string.gsub(str, "%$parameter1%$", tostring(data.rate))
  str = string.gsub(str, "%$parameter2%$", rarityStr[data.rarity])
  if rarityStr[data.rarity] == "UR" then
    self._rateTxt:SetText("<color=#" .. CWordColor:GetRecorder(11).wordcolor .. ">" .. str .. "</color>")
  elseif rarityStr[data.rarity] == "SSR" then
    self._rateTxt:SetText("<color=#" .. CWordColor:GetRecorder(8).wordcolor .. ">" .. str .. "</color>")
  elseif rarityStr[data.rarity] == "SR" then
    self._rateTxt:SetText("<color=#" .. CWordColor:GetRecorder(9).wordcolor .. ">" .. str .. "</color>")
  elseif rarityStr[data.rarity] == "R" then
    self._rateTxt:SetText("<color=#" .. CWordColor:GetRecorder(10).wordcolor .. ">" .. str .. "</color>")
  end
  local roleNameList = {}
  local roleConfigRecord, name
  for _, id in ipairs(data.roleIdList) do
    roleConfigRecord = RoleConfigTable:GetRecorder(id)
    if roleConfigRecord then
      name = TextManager.GetText(roleConfigRecord.nameTextID)
      table.insert(roleNameList, name)
    end
  end
  str = ""
  local notLast = ""
  for _, name in ipairs(roleNameList) do
    str = notLast .. name
    notLast = notLast .. name .. " / "
  end
  self._name:SetText(str)
  local fontsize = self._name:GetFontSize()
  local _, textheight = self._name:GetPreferredSize()
  if textheight > self._height then
    local line = math.ceil((textheight - self._height) / self._oneline)
    local delta = line * fontsize
    self._name:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y + delta)
    self._name:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y - delta)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y + delta)
  else
    self._name:SetSize(self._text_size_x, self._text_size_offset_x, self._text_size_y, self._text_size_offset_y)
    self._name:SetPosition(self._text_pos_x, self._text_pos_offset_x, self._text_pos_y, self._text_pos_offset_y)
    self:GetRootWindow():SetSize(self._talk_size_x, self._talk_size_offset_x, self._talk_size_y, self._talk_size_offset_y)
  end
end

return GachaRateUpCellCell
