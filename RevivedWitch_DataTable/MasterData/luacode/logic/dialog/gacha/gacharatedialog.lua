-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gacharatedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CardPool = (BeanManager.GetTableByName)("item.ccardpool")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GachaRateDialog = class("GachaRateDialog", Dialog)
GachaRateDialog.AssetBundleName = "ui/layouts.gacha"
GachaRateDialog.AssetName = "GachaRate"
local Type = {Up = 1, All = 2, Baodi = 3}
local Rarity = {UR = 4, SSR = 3, SR = 2, R = 1}
GachaRateDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaRateDialog
  ((GachaRateDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

GachaRateDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV, CardPool
  self._closeBtn = self:GetChild("Announcement/CloseBtn")
  self._field = self:GetChild("Announcement/Frame")
  self._frame = (TableFrame.Create)(self._field, self, true, true, true)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._poolTable = {}
  for _,id in ipairs(CardPool:GetAllIds()) do
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

    (self._poolTable)[id] = CardPool:GetRecorder(id)
  end
end

GachaRateDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GachaRateDialog.Init = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Type, Rarity
  local detail = (data.value).drawCardDetails
  local temp = {}
  self._data = {}
  self._rateUpData = {}
  for id,v in pairs(detail.upRoles) do
    temp = {}
    temp.roleId = id
    temp.rate = v
    ;
    (table.insert)(self._rateUpData, temp)
  end
  if #self._rateUpData > 0 then
    (table.insert)(self._data, {data = self._rateUpData, type = Type.Up})
  end
  self._rateAllData = {}
  if #(detail.ur).ids > 0 then
    temp = {rank = Rarity.UR, rate = (detail.ur).rate, idList = (detail.ur).ids}
    ;
    (table.insert)(self._rateAllData, temp)
  end
  if #(detail.ssr).ids > 0 then
    temp = {rank = Rarity.SSR, rate = (detail.ssr).rate, idList = (detail.ssr).ids}
    ;
    (table.insert)(self._rateAllData, temp)
  end
  if #(detail.sr).ids > 0 then
    temp = {rank = Rarity.SR, rate = (detail.sr).rate, idList = (detail.sr).ids}
    ;
    (table.insert)(self._rateAllData, temp)
  end
  if #(detail.r).ids > 0 then
    temp = {rank = Rarity.R, rate = (detail.r).rate, idList = (detail.r).ids}
    ;
    (table.insert)(self._rateAllData, temp)
  end
  if #self._rateAllData > 0 then
    (table.insert)(self._data, {data = self._rateAllData, type = Type.All})
  end
  local baodiTitle = ((self._poolTable)[data.id]).describetitleTextID
  local baodiDes = ((self._poolTable)[data.id]).detaileddescribeTextID
  for i,v in ipairs(baodiTitle) do
    temp = {}
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

GachaRateDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

GachaRateDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5 , upvalues : Type
  if ((self._data)[index]).type == Type.Up then
    return "gacha.gacharateupcell"
  else
    if ((self._data)[index]).type == Type.All then
      return "gacha.gacharateallcell"
    else
      if ((self._data)[index]).type == Type.Baodi then
        return "gacha.gacharatebaodicell"
      end
    end
  end
end

GachaRateDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return ((self._data)[index]).data
end

GachaRateDialog.ShouldLengthChange = function(self)
  -- function num : 0_7
  return true
end

GachaRateDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

return GachaRateDialog

