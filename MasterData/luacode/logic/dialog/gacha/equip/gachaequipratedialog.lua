-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/equip/gachaequipratedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipCardPool = (BeanManager.GetTableByName)("item.cequipcardpool")
local CardPool = (BeanManager.GetTableByName)("item.ccardpool")
local Type = {Normal = 1, Baodi = 2}
local GachaEquipRateDialog = class("GachaEquipRateDialog", Dialog)
GachaEquipRateDialog.AssetBundleName = "ui/layouts.baseshop"
GachaEquipRateDialog.AssetName = "TowerLegendDetail"
GachaEquipRateDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaEquipRateDialog, _ENV, CardPool
  ((GachaEquipRateDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._poolTable = {}
  for _,id in ipairs(CardPool:GetAllIds()) do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

    (self._poolTable)[id] = CardPool:GetRecorder(id)
  end
  self._data = {}
end

GachaEquipRateDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._panel = self:GetChild("Announcement/Frame")
  self._backBtn = self:GetChild("Announcement/CloseBtn")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

GachaEquipRateDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GachaEquipRateDialog.SetData = function(self, cardPoolId)
  -- function num : 0_3 , upvalues : _ENV, CEquipCardPool, Type
  while (self._data)[#self._data] do
    (table.remove)(self._data, #self._data)
  end
  local recorder = CEquipCardPool:GetRecorder(cardPoolId)
  if not recorder then
    LogErrorFormat("GachaEquipRateDialog", "carPool with id %s is not exist in cequipcardpool", cardPoolId)
    return 
  end
  for i,v in ipairs(recorder.EquipShow) do
    (table.insert)(self._data, {data = v, type = Type.Normal})
  end
  local baodiTitle = ((self._poolTable)[cardPoolId]).describetitleTextID
  local baodiDes = ((self._poolTable)[cardPoolId]).detaileddescribeTextID
  for i,v in ipairs(baodiTitle) do
    local temp = {}
    temp.title = v
    temp.describe = (TextManager.GetText)(baodiDes[i])
    ;
    (table.insert)(self._data, {data = temp, type = Type.Baodi})
  end
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

GachaEquipRateDialog.OnBackBtnClicked = function(self, args)
  -- function num : 0_4
  self:Destroy()
end

GachaEquipRateDialog.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._data
end

GachaEquipRateDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_6 , upvalues : Type
  if ((self._data)[index]).type == Type.Normal then
    return "gacha.equip.gachaequipratecell"
  else
    return "gacha.gacharatebaodicell"
  end
end

GachaEquipRateDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return ((self._data)[index]).data
end

GachaEquipRateDialog.ShouldLengthChange = function(self)
  -- function num : 0_8
  return true
end

return GachaEquipRateDialog

