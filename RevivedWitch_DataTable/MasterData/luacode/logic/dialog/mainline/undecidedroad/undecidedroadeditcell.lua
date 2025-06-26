-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/undecidedroad/undecidedroadeditcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CentryConfig = (BeanManager.GetTableByName)("dungeonselect.centryconfig")
local UndecidedRoadEditCell = class("UndecidedRoadEditCell", Dialog)
UndecidedRoadEditCell.AssetBundleName = "ui/layouts.activityroad"
UndecidedRoadEditCell.AssetName = "ActivityRoadEditCell"
UndecidedRoadEditCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UndecidedRoadEditCell
  ((UndecidedRoadEditCell.super).Ctor)(self, ...)
end

UndecidedRoadEditCell.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("Btn")
  self._txt1 = self:GetChild("Btn/Txt1")
  self._txt2 = self:GetChild("Btn/Txt2")
  self._noBtn = self:GetChild("Btn/No")
  self._yesBtn = self:GetChild("Btn/Yes")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

UndecidedRoadEditCell.OnDestroy = function(self)
  -- function num : 0_2
end

UndecidedRoadEditCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._btn):SetSelected(data.state == 1)
  ;
  (self._yesBtn):SetActive(data.state == 1)
  ;
  (self._noBtn):SetActive(data.state == 2)
  ;
  (self._txt1):SetText((TextManager.GetText)(data.textID))
  ;
  (self._txt2):SetText(data.bonusPoints)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

UndecidedRoadEditCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):OnVerticalCellClicked((self._cellData).id)
end

UndecidedRoadEditCell.OnEvent = function(self, eventName, args)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC10: Unhandled construct in 'MakeBoolean' P1

  if eventName == "CancelSelection" and args.entrytype == (self._cellData).entrytype then
    (self._btn):SetSelected(false)
    ;
    (self._yesBtn):SetActive(false)
    ;
    (self._noBtn):SetActive(false)
  end
  if eventName == "Selection" and args.entrytype == (self._cellData).entrytype then
    if tonumber(args.id) == tonumber((self._cellData).entryId) then
      (self._btn):SetSelected(true)
      ;
      (self._yesBtn):SetActive(true)
      ;
      (self._noBtn):SetActive(false)
    else
      ;
      (self._btn):SetSelected(false)
      ;
      (self._yesBtn):SetActive(false)
      ;
      (self._noBtn):SetActive(true)
    end
  end
end

return UndecidedRoadEditCell

