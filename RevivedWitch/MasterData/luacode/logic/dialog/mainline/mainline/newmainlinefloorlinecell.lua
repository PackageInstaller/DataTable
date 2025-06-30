-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/newmainlinefloorlinecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewMainlineFloorLineCell = class("NewMainlineFloorLineCell", Dialog)
local CVarconfig = (BeanManager.GetTableByName)("var.cvarconfig")
NewMainlineFloorLineCell.AssetBundleName = "ui/layouts.mainline"
NewMainlineFloorLineCell.AssetName = "DungeonSelectCellLine"
NewMainlineFloorLineCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewMainlineFloorLineCell, _ENV, CVarconfig
  ((NewMainlineFloorLineCell.super).Ctor)(self, ...)
  self._alpha = tonumber((CVarconfig:GetRecorder(61)).Value)
  self._fadeSpeed = tonumber((CVarconfig:GetRecorder(86)).Value)
end

NewMainlineFloorLineCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._select = self:GetChild("Select")
  self._img = self:GetChild("Line")
  self._canvasGroup = ((self:GetRootWindow()):GetUIObject()):GetComponent("CanvasGroup")
  local x, y = (self._img):GetRectSize()
  ;
  (self._img):SetAnchorAndOffset(0, 0.5, 1, 0.5, 0, -y / 2, 0, -y / 2)
  ;
  (self._img):SetHeight(0.5, y)
  ;
  (self:GetRootWindow()):SetHeight(0, 0)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

NewMainlineFloorLineCell.OnDestroy = function(self)
  -- function num : 0_2
end

NewMainlineFloorLineCell.RefreshCell = function(self, data)
  -- function num : 0_3
  self._data = data
  ;
  (self._select):SetActive(false)
end

NewMainlineFloorLineCell.OnEvent = function(self, eventName, args, fatherKind, fadeIn, lastFloorID)
  -- function num : 0_4
  if eventName == "SetSelected" then
    if ((self._data).bigParentId and args == (self._data).bigParentId) or args == (self._data).parentId then
      (self._select):SetActive(true)
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

      if fatherKind then
        (self._canvasGroup).alpha = 1
      end
    else
      ;
      (self._select):SetActive(false)
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

      if fatherKind then
        (self._canvasGroup).alpha = self._alpha
      end
    end
    if fadeIn == true then
      if ((self._data).bigParentId and lastFloorID == (self._data).bigParentId) or lastFloorID == (self._data).parentId then
        self._fadeIn = true
        self._widthHelper = self._widthHelperOri
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (self._canvasGroup).alpha = 1
      else
        self._fadeIn = false
        ;
        (self:GetRootWindow()):SetWidth(0, self._width)
      end
    end
  end
end

NewMainlineFloorLineCell.OnUpdate = function(self)
  -- function num : 0_5
  if self._fadeIn then
    if self._widthHelper < self._width then
      self._widthHelper = self._widthHelper + self._fadeSpeed
    else
      self._widthHelper = self._width
      ;
      (self:GetRootWindow()):SetWidth(0, self._widthHelper)
      self._fadeIn = false
    end
    if self._widthHelper > 0 then
      (self:GetRootWindow()):SetWidth(0, self._widthHelper)
    else
      ;
      (self:GetRootWindow()):SetWidth(0, 0)
    end
  end
end

NewMainlineFloorLineCell.SetPosition = function(self, ax, x, ay, y)
  -- function num : 0_6
  (self:GetRootWindow()):SetPosition(ax, x, ay, y)
end

NewMainlineFloorLineCell.SetZRotation = function(self, bx, by, ex, ey)
  -- function num : 0_7
  (self:GetRootWindow()):SetZRotation(bx, by, ex, ey)
end

NewMainlineFloorLineCell.SetWidth = function(self, width, widthHelper)
  -- function num : 0_8
  self._width = width
  self._widthHelperOri = widthHelper
  ;
  (self:GetRootWindow()):SetWidth(0, width)
end

return NewMainlineFloorLineCell

