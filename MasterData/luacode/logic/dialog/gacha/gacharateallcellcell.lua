local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRoleRarityCfgTable = BeanManager.GetTableByName("role.croleraritycfg")
local CRoleItemTable = BeanManager.GetTableByName("item.croleitem")
local cImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CWordColor = BeanManager.GetTableByName("message.cwordcolor")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local Role = require("logic.manager.experimental.types.role")
local GachaRateAllCellCell = class("GachaRateAllCellCell", Dialog)
GachaRateAllCellCell.AssetBundleName = "ui/layouts.gacha"
GachaRateAllCellCell.AssetName = "GachaRateAllCell"

function GachaRateAllCellCell:Ctor(...)
  GachaRateAllCellCell.super.Ctor(self, ...)
end

function GachaRateAllCellCell:OnCreate()
  self._rank = self:GetChild("Image")
  self._nameList = self:GetChild("NameList")
  self._rateTxt = self:GetChild("TotalRate")
  self._rootWindow_anchorY, self._rootWindow_offsetY = self:GetRootWindow():GetHeight()
  self._sizeDelta_width, self._sizeDelta_height = self._nameList:GetRectSize()
  self._txt_anchorMinX, self._txt_anchorMinY, self._txt_anchorMaxX, self._txt_anchorMaxY, self._txt_offsetMinX, self._txt_offsetMinY, self._txt_offsetMaxX, self._txt_offsetMaxY = self._nameList:GetAnchorAndOffset()
end

function GachaRateAllCellCell:OnDestroy()
end

function GachaRateAllCellCell:RefreshCell(data)
  local id = CRoleRarityCfgTable:GetRecorder(data.rank).drawinfo
  local imageRecord = cImagePathTable:GetRecorder(id) or DataCommon.DefaultImageAsset
  self._rank:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = TextManager.GetText(CStringRes:GetRecorder(1113).msgTextID)
  str = string.gsub(str, "%$parameter1%$", tostring(data.rate))
  if data.rank == 3 then
    str = string.gsub(str, "%$parameter2%$", CWordColor:GetRecorder(8).wordcolor)
  elseif data.rank == 2 then
    str = string.gsub(str, "%$parameter2%$", CWordColor:GetRecorder(9).wordcolor)
  elseif data.rank == 1 then
    str = string.gsub(str, "%$parameter2%$", CWordColor:GetRecorder(10).wordcolor)
  elseif data.rank == 4 then
    str = string.gsub(str, "%$parameter2%$", CWordColor:GetRecorder(11).wordcolor)
  elseif data.rank == 5 then
    str = string.gsub(str, "%$parameter2%$", CWordColor:GetRecorder(20).wordcolor)
  end
  self._rateTxt:SetText(str)
  local roleNameList = {}
  local roleConfigRecord, name
  for _, id in ipairs(data.idList) do
    roleConfigRecord = RoleConfigTable:GetRecorder(CRoleItemTable:GetRecorder(id).roleid)
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
  self._nameList:SetText(str)
  local _, textheight = self._nameList:GetPreferredSize()
  local delta = textheight - self._sizeDelta_height
  self._nameList:SetAnchorAndOffset(self._txt_anchorMinX, self._txt_anchorMinY, self._txt_anchorMaxX, self._txt_anchorMaxY, self._txt_offsetMinX, self._txt_offsetMinY - delta, self._txt_offsetMaxX, self._txt_offsetMaxY)
  self:GetRootWindow():SetHeight(self._rootWindow_anchorY, self._rootWindow_offsetY + delta)
end

return GachaRateAllCellCell
