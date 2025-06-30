-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/dialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local AutoRender = ((CS.PixelNeko).UI).AutoRender
local Dialog = class("Dialog")
Dialog.AssetBundleName = ""
Dialog.AssetName = ""
Dialog.ParentDialogName = ""
Dialog.Ctor = function(self, dialogKey, dialogName)
  -- function num : 0_0 , upvalues : _ENV
  if not dialogKey then
    LogError("Dialog", "dialogKey is nil")
  end
  if not dialogName then
    LogError("Dialog", "dialogName is nil")
  end
  self._dialogKey = dialogKey
  self._dialogName = dialogName
  self._fastMenuBtnStatus = true
  self._fastMenuDialogStatus = true
  self._groupName = "Default"
  self._rootWindow = nil
  self._destroyHandler = 0
  self.___loaded = false
  self.___closed = false
  self.___destroyed = false
  self._canvas = nil
  self._childDialogs = {}
  self.__isChild = false
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogWillUnLoad, Common.n_DialogWillUnLoad, nil)
end

Dialog.Load = function(self, parent)
  -- function num : 0_1 , upvalues : UIManager, _ENV
  if not self.___loaded and not self.___closed and not self.___destroyed then
    self.___loaded = true
    self.___closed = false
    self.___destroyed = false
    self._rootWindow = (UIManager.CreateLuaWindow)(self.AssetBundleName .. ".assetbundle", self.AssetName, parent)
    self._destroyHandler = (self._rootWindow):Subscribe_DestroyWindowEvent(self.OnDestroyEvent, self)
    if self._groupName ~= "Modal" then
      self:OnCreate()
    end
  else
    LogError("Dialog", "Load Already Loaded.")
  end
end

Dialog.LoadByCopy = function(self, copyObj, parent)
  -- function num : 0_2 , upvalues : UIManager, _ENV
  if not self.___loaded and not self.___closed and not self.___destroyed then
    self.___loaded = true
    self.___closed = false
    self.___destroyed = false
    self._rootWindow = (UIManager.CopyLuaWindow)(copyObj, parent)
    self._destroyHandler = (self._rootWindow):Subscribe_DestroyWindowEvent(self.OnDestroyEvent, self)
    if self._groupName ~= "Modal" then
      self:OnCreate()
    end
  else
    LogError("Dialog", "Load Already Loaded.")
  end
end

Dialog.ReplaceNode = function(self, childDialog, parentNode)
  -- function num : 0_3 , upvalues : _ENV, UIManager
  (table.insert)(self._childDialogs, childDialog)
  childDialog._rootWindow = (UIManager.ReplaceLuaParentWindow)((childDialog._rootWindow)._uiObject, parentNode._uiObject)
end

Dialog.GetRootWindow = function(self)
  -- function num : 0_4
  return self._rootWindow
end

Dialog.OnDestroyEvent = function(self)
  -- function num : 0_5 , upvalues : _ENV, Dialog
  if not self.___closed then
    self:Destroy()
  end
  if not self.___destroyed then
    self.___destroyed = true
    for i,v in ipairs(self._childDialogs) do
      v:Destroy()
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_RootWindowWillDestroy, Dialog, self)
    self:OnRemoveIndex()
    ;
    (LuaNotificationCenter.RemoveObserver)(self)
    self._rootWindow = nil
  end
end

Dialog.Destroy = function(self)
  -- function num : 0_6 , upvalues : _ENV, Dialog
  if not self.___closed then
    if not self.___loaded then
      LogError("Dialog", "Destroy Dialog not Load.")
      return 
    end
    self.___closed = true
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_DialogWillDestroy, Dialog, self)
    if self.__isChild then
      (LuaNotificationCenter.PostNotification)(Common.n_DialogWillUnLoad, Dialog, self)
    end
    self:OnDestroy()
    self:OnDestroyChildDialog()
  else
    LogWarning("Dialog", "Destroy Already Closed.")
  end
end

Dialog.RootWindowDestroy = function(self)
  -- function num : 0_7 , upvalues : _ENV, Dialog, UIManager
  if not self.___destroyed then
    if not self.___loaded then
      LogError("Dialog", "RootWindowDestroy Dialog not Loaded.")
      return 
    end
    if not self.___closed then
      self:Destroy()
      self:RootWindowDestroy()
      return 
    end
    if not self.___destroyed then
      self.___destroyed = true
      if self._destroyHandler > 0 then
        (self._rootWindow):Unsubscribe_DestroyWindowEvent(self._destroyHandler)
        self._destroyHandler = 0
      end
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_RootWindowWillDestroy, Dialog, self)
      self:OnRemoveIndex()
      ;
      (UIManager.Destroy)((self._rootWindow)._uiObject)
      ;
      (LuaNotificationCenter.RemoveObserver)(self)
    end
  end
end

Dialog.RemoveChildDialogs = function(self)
  -- function num : 0_8
  while (self._childDialogs)[#self._childDialogs] do
    ((self._childDialogs)[#self._childDialogs]):Destroy()
  end
end

Dialog.GetChild = function(self, path)
  -- function num : 0_9 , upvalues : UIManager
  return (UIManager.GetChildLuaWindow)((self._rootWindow)._uiObject, path)
end

Dialog.SetActive = function(self, isActive)
  -- function num : 0_10
  (self:GetRootWindow()):SetActive(isActive)
end

Dialog.isActive = function(self)
  -- function num : 0_11
  return (self:GetRootWindow()):IsActive()
end

Dialog.OnCreate = function(self)
  -- function num : 0_12
end

Dialog.OnDestroy = function(self)
  -- function num : 0_13
end

Dialog.OnBackPressed = function(self)
  -- function num : 0_14
  return false, false
end

Dialog.OnBackPointerClick = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local num = #self._childDialogs
  if num > 0 then
    local isResponse, isReturn = ((self._childDialogs)[num]):OnBackPressed()
    while num > 1 and isResponse and not isReturn do
      num = num - 1
      isResponse = ((self._childDialogs)[num]):OnBackPressed()
      if not isResponse or isReturn then
        num = num - 1
      end
    end
    if #self._childDialogs == 0 or isResponse and not isReturn then
      do
        do
          if #self._childDialogs ~= 0 and num > 0 then
            local fastMenuMainDialog = (DialogManager.GetDialog)("fastmenu.fastmenumaindialog")
            if fastMenuMainDialog then
              if not ((self._childDialogs)[num])._fastMenuBtnStatus then
                (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(false)
              else
                ;
                (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(true)
              end
              if not ((self._childDialogs)[num])._fastMenuDialogStatus then
                (fastMenuMainDialog._rootWindow):SetActive(false)
              else
                ;
                (fastMenuMainDialog._rootWindow):SetActive(true)
              end
            end
          end
          if isResponse and not isReturn then
            return false
          else
            return true
          end
          do return true end
          do return false end
        end
      end
    end
  end
end

Dialog.CreateChildDialog = function(self, childDialog, parentNode)
  -- function num : 0_16 , upvalues : _ENV, CanvasStaticFunctions
  childDialog.__isChild = true
  ;
  (table.insert)(self._childDialogs, childDialog)
  childDialog:Load(parentNode._uiObject)
  local fastMenuMainDialog = (DialogManager.GetDialog)("fastmenu.fastmenumaindialog")
  if fastMenuMainDialog then
    if not childDialog._fastMenuBtnStatus then
      (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(false)
    else
      ;
      (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(true)
    end
    if not childDialog._fastMenuDialogStatus then
      (fastMenuMainDialog._rootWindow):SetActive(false)
    else
      ;
      (fastMenuMainDialog._rootWindow):SetActive(true)
    end
  end
  childDialog._canvas = (CanvasStaticFunctions.AddCanvasWithGraphicRaycaster)((childDialog:GetRootWindow())._uiObject)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (childDialog._canvas).overrideSorting = true
end

Dialog.OnDestroyChildDialog = function(self)
  -- function num : 0_17 , upvalues : _ENV
  while (self._childDialogs)[#self._childDialogs] do
    (table.remove)(self._childDialogs, #self._childDialogs)
  end
  self:RootWindowDestroy()
  if #self._childDialogs == 0 then
    local fastMenuMainDialog = (DialogManager.GetDialog)("fastmenu.fastmenumaindialog")
    if fastMenuMainDialog then
      if not self._fastMenuBtnStatus then
        (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(false)
      else
        ;
        (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(true)
      end
      if not self._fastMenuDialogStatus then
        (fastMenuMainDialog._rootWindow):SetActive(false)
      else
        ;
        (fastMenuMainDialog._rootWindow):SetActive(true)
      end
    end
  end
end

local IndexOf = function(self, dialogKey)
  -- function num : 0_18 , upvalues : _ENV
  for i,dialog in ipairs(self._childDialogs) do
    if dialog._dialogKey == dialogKey then
      return i
    end
  end
end

Dialog.OnRemoveIndex = function(self)
  -- function num : 0_19 , upvalues : IndexOf, _ENV
  local index = IndexOf(self, self._dialogKey)
  if index then
    (table.remove)(self._childDialogs, index)
  end
end

Dialog.OnDialogWillUnLoad = function(self, notification)
  -- function num : 0_20 , upvalues : IndexOf, _ENV
  local dialog = notification.userInfo
  local index = IndexOf(self, dialog._dialogKey)
  if index then
    (table.remove)(self._childDialogs, index)
  end
end

Dialog.PlayEffect = function(self, path, effectId)
  -- function num : 0_21 , upvalues : _ENV
  local effectControl = self:GetChild(path)
  local handler = effectControl:AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(effectId))
  return handler
end

Dialog.RemoveEffect = function(self, path, handler)
  -- function num : 0_22
  local effectControl = self:GetChild(path)
  effectControl:ReleaseEffect(handler)
end

Dialog.OnBackBtnClicked = function(self)
  -- function num : 0_23 , upvalues : _ENV
  return DataCommon.BackPressed_NotResponse
end

return Dialog

