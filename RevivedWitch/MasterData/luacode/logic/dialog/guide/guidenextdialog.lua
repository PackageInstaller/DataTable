-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guide/guidenextdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GuideNextDialog = class("GuideNextDialog", Dialog)
GuideNextDialog.AssetBundleName = "ui/layouts.guide"
GuideNextDialog.AssetName = "GuideNext"
GuideNextDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuideNextDialog
  ((GuideNextDialog.super).Ctor)(self, ...)
  self._groupName = "Guide"
end

GuideNextDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._next = self:GetChild("Next")
  self._nextTxt = self:GetChild("Next/Next")
  self._arrow = {}
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._arrow).Up = self:GetChild("Next/Arrow2")
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._arrow).Down = self:GetChild("Next/Arrow")
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._arrow).Left = self:GetChild("Next/Arrow3")
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._arrow).Right = self:GetChild("Next/Arrow4")
  for k,v in pairs(self._arrow) do
    ((self._arrow)[k]):SetActive(false)
  end
  self._width = (self._next):GetRectSize()
end

GuideNextDialog.OnDestroy = function(self)
  -- function num : 0_2
end

GuideNextDialog.SetGuideId = function(self, guideId)
  -- function num : 0_3
  if guideId == 4 then
    (self._nextTxt):SetActive(false)
    self._equipChangeTxt = self:GetChild("Next/EquipGuide")
    ;
    (self._equipChangeTxt):SetActive(true)
  end
end

GuideNextDialog.SetTextPoint = function(self, width, height, posX, posY, direction)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs(self._arrow) do
    if direction == k then
      ((self._arrow)[k]):SetActive(true)
      if direction == "Up" then
        (self._next):SetAnchoredPosition(posX, posY - height / 2 - self._height / 2)
      else
        if direction == "Down" then
          (self._next):SetAnchoredPosition(posX, posY + height / 2 + self._height / 2)
        else
          if direction == "Left" then
            (self._next):SetAnchoredPosition(posX + width / 2 + self._width / 2, posY)
          else
            if direction == "Right" then
              (self._next):SetAnchoredPosition(posX - width / 2 - self._width / 2, posY)
            end
          end
        end
      end
    else
      ;
      ((self._arrow)[k]):SetActive(false)
    end
  end
end

return GuideNextDialog

