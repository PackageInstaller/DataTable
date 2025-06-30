-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/clickeffect/clickeffectdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local clickEffectCell = {AssetBundleName = "ui/layouts", AssetName = "ClickCell"}
local MaxCellNum = 10
local ClickEffectDialog = class("ClickEffectDialog", Dialog)
ClickEffectDialog.AssetBundleName = "ui/layouts"
ClickEffectDialog.AssetName = "ClickEffectPoint"
local audioId = 232
ClickEffectDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ClickEffectDialog
  ((ClickEffectDialog.super).Ctor)(self, ...)
  self._groupName = "ClickEffect"
  self._cellList = {}
  self._key = 1
  self._count = 0
  self._tag = nil
  self._lastClickTime = nil
end

ClickEffectDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, UIManager, clickEffectCell, MaxCellNum
  self._quitTxt = self:GetChild("OfflineTxt")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnNoTargetClick, Common.n_NoTargetWindowClick, nil)
  self._baseCell = (UIManager.CreateLuaWindow)(clickEffectCell.AssetBundleName .. ".assetbundle", clickEffectCell.AssetName, (self._rootWindow)._uiObject)
  for i = 1, MaxCellNum do
    (table.insert)(self._cellList, (DialogManager.CopyDialog)("clickeffect.clickeffectcell", (self._baseCell)._uiObject, (self._rootWindow)._uiObject))
  end
  local _, height = (self:GetRootWindow()):GetRectSize()
  self._gmScreenHeight = height * 3 / 4 - height / 2
  ;
  ((NekoData.BehaviorManager).BM_Game):SetGMHideUIByDialog((DataCommon.GMHideUI).MainCity, self)
end

ClickEffectDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV, UIManager
  (LuaNotificationCenter.RemoveObserver)(self)
  do
    while (self._cellList)[#self._cellList] do
      local cell = (self._cellList)[#self._cellList]
      cell:Destroy()
      cell:RootWindowDestroy()
      ;
      (table.remove)(self._cellList, #self._cellList)
    end
    ;
    (UIManager.Destroy)((self._baseCell)._uiObject)
  end
end

ClickEffectDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_3 , upvalues : UIManager, _ENV, MaxCellNum
  local x, y = (UIManager.ScreenPointToLocalPointInRectangle)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y)
  if x > 750 and y < -400 then
    if self._tag ~= "debug" then
      self._count = 0
      self._tag = "debug"
    end
    self:Debug()
  else
    if x < -750 and y < -400 then
      if self._tag ~= "breakline" then
        self._count = 0
        self._tag = "breakline"
      end
      if self._count < 2 then
        self:Debug()
      end
    else
      if x > 750 and y > -100 and y < 100 and self._tag == "breakline" and self._count == 2 then
        self:Debug()
      else
        if self._gmScreenHeight < y and not (DialogManager.GetDialog)("clickeffect.gmhideuidialog") and (not self._lastClickTime or (os.time)() - self._lastClickTime <= 1) then
          if self._tag ~= "GMHide" then
            self._count = 0
            self._tag = "GMHide"
          end
          self._lastClickTime = (os.time)()
          self:Debug()
        else
          self._count = 0
          self._tag = nil
          self._lastClickTime = nil
        end
      end
    end
  end
  local dialog = (DialogManager.GetDialog)("dungeon.rockerdialog")
  if dialog and dialog:GetRootWindow() == (args.userInfo).luaWindow then
    return 
  end
  dialog = (DialogManager.GetDialog)("newbattle.battlenewmaindialog")
  if dialog and (args.userInfo).luaWindow and ((args.userInfo).luaWindow):IsChildOf(dialog:GetRootWindow()) then
    return 
  end
  local cell = (self._cellList)[self._key]
  if cell then
    (cell:GetRootWindow()):SetAnchoredPosition(x, y)
    cell:PlayEffect()
    self._key = self._key % MaxCellNum + 1
  end
end

ClickEffectDialog.OnNoTargetClick = function(self, args)
  -- function num : 0_4 , upvalues : UIManager, _ENV, MaxCellNum
  local x, y = (UIManager.ScreenPointToLocalPointInRectangle)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y)
  if x > 750 and y < -400 then
    if self._tag ~= "debug" then
      self._count = 0
      self._tag = "debug"
    end
    self:Debug()
  else
    if x < -750 and y < -400 then
      if self._tag ~= "breakline" then
        self._count = 0
        self._tag = "breakline"
      end
      if self._count < 2 then
        self:Debug()
      end
    else
      if x > 750 and y > -100 and y < 100 and self._tag == "breakline" and self._count == 2 then
        self:Debug()
      else
        if self._gmScreenHeight < y and not (DialogManager.GetDialog)("clickeffect.gmhideuidialog") and (not self._lastClickTime or (os.time)() - self._lastClickTime <= 1) then
          if self._tag ~= "GMHide" then
            self._count = 0
            self._tag = "GMHide"
          end
          self._lastClickTime = (os.time)()
          self:Debug()
        else
          self._count = 0
          self._tag = nil
          self._lastClickTime = nil
        end
      end
    end
  end
  local cell = (self._cellList)[self._key]
  if cell then
    (cell:GetRootWindow()):SetAnchoredPosition(x, y)
    cell:PlayEffect()
    self._key = self._key % MaxCellNum + 1
  end
end

ClickEffectDialog.Debug = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Game):IsGM() and self._tag == "GMHide" then
    if self._count < 6 then
      self._count = self._count + 1
    else
      self._lastClickTime = nil
      self._count = 0
      ;
      (DialogManager.CreateSingletonDialog)("clickeffect.gmhideuidialog")
    end
    return 
  else
    if not global_var_debug and self._count < 2 then
      self._count = self._count + 1
    end
  end
  if global_var_debug then
    if self._count < 2 then
      self._count = self._count + 1
    else
    end
  end
  if self._tag ~= "debug" or self._tag == "breakline" then
    self._count = 0
    local client = (LuaNetManager.GetMainConnect)()
    if client then
      client:SetSHeartTime(0)
    end
  end
end

ClickEffectDialog.OnBackBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return ClickEffectDialog

