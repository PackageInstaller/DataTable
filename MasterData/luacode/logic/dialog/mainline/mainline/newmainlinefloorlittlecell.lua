-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/newmainlinefloorlittlecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewMainlineFloorLittleCell = class("NewMainlineFloorLittleCell", Dialog)
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
NewMainlineFloorLittleCell.AssetBundleName = "ui/layouts.mainline"
NewMainlineFloorLittleCell.AssetName = "DungeonSelectCellSmall"
NewMainlineFloorLittleCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewMainlineFloorLittleCell, _ENV, CVarconfig
  ((NewMainlineFloorLittleCell.super).Ctor)(self, ...)
  self._trueAlpha = 1
  self._alpha = tonumber((CVarconfig:GetRecorder(61)).Value)
  self._fadeSpeed = tonumber((CVarconfig:GetRecorder(86)).Value)
end

NewMainlineFloorLittleCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._finishNo = self:GetChild("FinishNo")
  self._finishNoSelect = self:GetChild("FinishNoSelect")
  ;
  (self._finishNoSelect):SetActive(false)
  self._finish = self:GetChild("Finish")
  self._finishSelect = self:GetChild("FinishSelect")
  ;
  (self._finishSelect):SetActive(false)
  self._canvasGroup = ((self:GetRootWindow()):GetUIObject()):GetComponent("CanvasGroup")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

NewMainlineFloorLittleCell.OnDestroy = function(self)
  -- function num : 0_2
end

local SetStatusActive = function(self, f1, f2, f3, f4)
  -- function num : 0_3
  (self._finish):SetActive(f1)
  ;
  (self._finishNo):SetActive(f2)
  ;
  (self._finishSelect):SetActive(f3)
  ;
  (self._finishNoSelect):SetActive(f4)
end

NewMainlineFloorLittleCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : SetStatusActive, _ENV
  self._data = data
  local finish = false
  local box = false
  if data.isPass == 1 then
    finish = true
  end
  if data.openedBoxes == data.totalBoxes then
    box = true
  end
  if finish then
    SetStatusActive(self, true, false, false, false)
    self._assetName = (EffectUtil.GetAssetBundleNameAndAssetName)(1021)
  else
    SetStatusActive(self, false, true, false, false)
    self._assetName = (EffectUtil.GetAssetBundleNameAndAssetName)(1020)
  end
end

NewMainlineFloorLittleCell.OnEvent = function(self, eventName, args, fatherKind, fadeIn, lastFloorID)
  -- function num : 0_5 , upvalues : SetStatusActive
  if eventName == "SetSelected" then
    if args == (self._data).bigParentId then
      local finish = false
      if (self._data).isPass == 1 then
        finish = true
      end
      if finish then
        SetStatusActive(self, false, false, true, false)
      else
        SetStatusActive(self, false, false, false, true)
      end
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

      if fatherKind then
        (self._canvasGroup).alpha = 1
        self._trueAlpha = 1
      end
    else
      do
        do
          local finish = false
          if (self._data).isPass == 1 then
            finish = true
          end
          if finish then
            SetStatusActive(self, true, false, false, false)
          else
            SetStatusActive(self, false, true, false, false)
          end
          -- DECOMPILER ERROR at PC62: Confused about usage of register: R7 in 'UnsetPending'

          if fatherKind then
            (self._canvasGroup).alpha = self._alpha
            self._trueAlpha = self._alpha
          end
          -- DECOMPILER ERROR at PC72: Confused about usage of register: R6 in 'UnsetPending'

          if fadeIn == true then
            if lastFloorID == (self._data).bigParentId then
              (self._canvasGroup).alpha = 0
              self._fadeIn = true
              self._widthHelper = self._widthHelperOri
              self._trueAlpha = 1
            else
              self._fadeIn = false
              -- DECOMPILER ERROR at PC81: Confused about usage of register: R6 in 'UnsetPending'

              ;
              (self._canvasGroup).alpha = self._trueAlpha
            end
          end
        end
      end
    end
  end
end

NewMainlineFloorLittleCell.OnUpdate = function(self)
  -- function num : 0_6
  if self._fadeIn then
    if self._widthHelper == nil then
      self._widthHelper = 0
    end
    if self._widthHelper < 0 then
      self._widthHelper = self._widthHelper + self._fadeSpeed
    else
      self._widthHelper = 0
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (self._canvasGroup).alpha = self._trueAlpha
      self._fadeIn = false
    end
  end
end

NewMainlineFloorLittleCell.SetPosition = function(self, ax, x, ay, y)
  -- function num : 0_7
  (self:GetRootWindow()):SetPosition(ax, x, ay, y)
end

NewMainlineFloorLittleCell.SetWidthOri = function(self, widthHelper)
  -- function num : 0_8
  self._widthHelperOri = widthHelper
end

return NewMainlineFloorLittleCell

