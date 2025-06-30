-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/christmas/christmasbattlebtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {Unlock = 1, PreconditionsNotMet = 2, Lock = 3}
local ChristmasBattleBtnCell = class("ChristmasBattleBtnCell", Dialog)
ChristmasBattleBtnCell.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasBattleBtnCell.AssetName = "ActivityChristmasbattlebtn"
ChristmasBattleBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChristmasBattleBtnCell
  ((ChristmasBattleBtnCell.super).Ctor)(self, ...)
end

ChristmasBattleBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._text = self:GetChild("_Text")
  self._num = self:GetChild("Num")
  self._image = self:GetChild("Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ChristmasBattleBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

ChristmasBattleBtnCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : State
  (self._num):SetText(data.index)
  ;
  (self._image):SetActive(data.state == State.Lock)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ChristmasBattleBtnCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):OnButtonGroupClick((self._cellData).index)
end

ChristmasBattleBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if (self._cellData).index ~= arg then
    (self:GetRootWindow()):SetSelected(eventName ~= "ChangedSelected")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return ChristmasBattleBtnCell

