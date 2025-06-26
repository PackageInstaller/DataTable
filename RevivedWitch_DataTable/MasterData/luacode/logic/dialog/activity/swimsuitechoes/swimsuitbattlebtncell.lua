-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/swimsuitbattlebtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {Unlock = 1, PreconditionsNotMet = 2, Lock = 3}
local SwimSuitBattleBtnCell = class("SwimSuitBattleBtnCell", Dialog)
SwimSuitBattleBtnCell.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitBattleBtnCell.AssetName = "ActivitySumme2battlebtn"
SwimSuitBattleBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitBattleBtnCell
  ((SwimSuitBattleBtnCell.super).Ctor)(self, ...)
end

SwimSuitBattleBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("_Text")
  self._num = self:GetChild("Num")
  self._image = self:GetChild("Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

SwimSuitBattleBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

SwimSuitBattleBtnCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : State
  (self._num):SetText(data.index)
  ;
  (self._image):SetActive(data.state == State.Lock)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

SwimSuitBattleBtnCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):OnButtonGroupClick((self._cellData).index)
end

SwimSuitBattleBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if (self._cellData).index ~= arg then
    (self:GetRootWindow()):SetSelected(eventName ~= "ChangedSelected")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return SwimSuitBattleBtnCell

