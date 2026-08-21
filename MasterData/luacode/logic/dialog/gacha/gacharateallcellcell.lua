-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gacharateallcellcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CRoleRarityCfgTable = (BeanManager.GetTableByName)("role.croleraritycfg")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local cImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local Role = require("logic.manager.experimental.types.role")
local GachaRateAllCellCell = class("GachaRateAllCellCell", Dialog)
GachaRateAllCellCell.AssetBundleName = "ui/layouts.gacha"
GachaRateAllCellCell.AssetName = "GachaRateAllCell"
GachaRateAllCellCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaRateAllCellCell
  ((GachaRateAllCellCell.super).Ctor)(self, ...)
end

GachaRateAllCellCell.OnCreate = function(self)
  -- function num : 0_1
  self._rank = self:GetChild("Image")
  self._nameList = self:GetChild("NameList")
  self._rateTxt = self:GetChild("TotalRate")
  self._rootWindow_anchorY = (self:GetRootWindow()):GetHeight()
  self._sizeDelta_width = (self._nameList):GetRectSize()
  self._txt_anchorMinX = (self._nameList):GetAnchorAndOffset()
end

GachaRateAllCellCell.OnDestroy = function(self)
  -- function num : 0_2
end

GachaRateAllCellCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CRoleRarityCfgTable, cImagePathTable, _ENV, CStringRes, CWordColor, RoleConfigTable, CRoleItemTable
  local id = (CRoleRarityCfgTable:GetRecorder(data.rank)).drawinfo
  if not cImagePathTable:GetRecorder(id) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._rank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = (TextManager.GetText)((CStringRes:GetRecorder(1113)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", tostring(data.rate))
  if data.rank == 3 then
    str = (string.gsub)(str, "%$parameter2%$", (CWordColor:GetRecorder(8)).wordcolor)
  else
    if data.rank == 2 then
      str = (string.gsub)(str, "%$parameter2%$", (CWordColor:GetRecorder(9)).wordcolor)
    else
      if data.rank == 1 then
        str = (string.gsub)(str, "%$parameter2%$", (CWordColor:GetRecorder(10)).wordcolor)
      else
        if data.rank == 4 then
          str = (string.gsub)(str, "%$parameter2%$", (CWordColor:GetRecorder(11)).wordcolor)
        else
          if data.rank == 5 then
            str = (string.gsub)(str, "%$parameter2%$", (CWordColor:GetRecorder(20)).wordcolor)
          end
        end
      end
    end
  end
  ;
  (self._rateTxt):SetText(str)
  local roleNameList = {}
  local roleConfigRecord, name = nil, nil
  for _,id in ipairs(data.idList) do
    roleConfigRecord = RoleConfigTable:GetRecorder((CRoleItemTable:GetRecorder(id)).roleid)
    if roleConfigRecord then
      name = (TextManager.GetText)(roleConfigRecord.nameTextID)
      ;
      (table.insert)(roleNameList, name)
    end
  end
  str = ""
  local notLast = ""
  for _,name in ipairs(roleNameList) do
    str = notLast .. name
    notLast = notLast .. name .. " / "
  end
  ;
  (self._nameList):SetText(str)
  local _, textheight = (self._nameList):GetPreferredSize()
  local delta = textheight - self._sizeDelta_height
  ;
  (self._nameList):SetAnchorAndOffset(self._txt_anchorMinX, self._txt_anchorMinY, self._txt_anchorMaxX, self._txt_anchorMaxY, self._txt_offsetMinX, self._txt_offsetMinY - delta, self._txt_offsetMaxX, self._txt_offsetMaxY)
  ;
  (self:GetRootWindow()):SetHeight(self._rootWindow_anchorY, self._rootWindow_offsetY + delta)
end

return GachaRateAllCellCell

