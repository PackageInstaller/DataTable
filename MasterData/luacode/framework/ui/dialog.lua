local UIManager = CS.PixelNeko.UI.UIManager
local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local AutoRender = CS.PixelNeko.UI.AutoRender
local Dialog = class("Dialog")
Dialog.AssetBundleName = ""
Dialog.AssetName = ""
Dialog.ParentDialogName = ""

function Dialog:Ctor(dialogKey, dialogName)
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
  LuaNotificationCenter.AddObserver(self, self.OnDialogWillUnLoad, Common.n_DialogWillUnLoad, nil)
end

function Dialog:Load(parent)
  if not self.___loaded and not self.___closed and not self.___destroyed then
    self.___loaded = true
    self.___closed = false
    self.___destroyed = false
    self._rootWindow = UIManager.CreateLuaWindow(self.AssetBundleName .. ".assetbundle", self.AssetName, parent)
    self._destroyHandler = self._rootWindow:Subscribe_DestroyWindowEvent(self.OnDestroyEvent, self)
    if self._groupName ~= "Modal" then
      self:OnCreate()
    end
  else
    LogError("Dialog", "Load Already Loaded.")
  end
end

function Dialog:LoadByCopy(copyObj, parent)
  if not self.___loaded and not self.___closed and not self.___destroyed then
    self.___loaded = true
    self.___closed = false
    self.___destroyed = false
    self._rootWindow = UIManager.CopyLuaWindow(copyObj, parent)
    self._destroyHandler = self._rootWindow:Subscribe_DestroyWindowEvent(self.OnDestroyEvent, self)
    if self._groupName ~= "Modal" then
      self:OnCreate()
    end
  else
    LogError("Dialog", "Load Already Loaded.")
  end
end

function Dialog:ReplaceNode(childDialog, parentNode)
  table.insert(self._childDialogs, childDialog)
  childDialog._rootWindow = UIManager.ReplaceLuaParentWindow(childDialog._rootWindow._uiObject, parentNode._uiObject)
end

function Dialog:GetRootWindow()
  return self._rootWindow
end

function Dialog:OnDestroyEvent()
  if not self.___closed then
    self:Destroy()
  end
  if not self.___destroyed then
    self.___destroyed = true
    for i, v in ipairs(self._childDialogs) do
      v:Destroy()
    end
    LuaNotificationCenter.PostNotification(Common.n_RootWindowWillDestroy, Dialog, self)
    self:OnRemoveIndex()
    LuaNotificationCenter.RemoveObserver(self)
    self._rootWindow = nil
  end
end

function Dialog:Destroy()
  if not self.___closed then
    if not self.___loaded then
      LogError("Dialog", "Destroy Dialog not Load.")
      return
    end
    self.___closed = true
    LuaNotificationCenter.PostNotification(Common.n_DialogWillDestroy, Dialog, self)
    if self.__isChild then
      LuaNotificationCenter.PostNotification(Common.n_DialogWillUnLoad, Dialog, self)
    end
    self:OnDestroy()
    self:OnDestroyChildDialog()
  else
    LogWarning("Dialog", "Destroy Already Closed.")
  end
end

function Dialog:RootWindowDestroy()
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
        self._rootWindow:Unsubscribe_DestroyWindowEvent(self._destroyHandler)
        self._destroyHandler = 0
      end
      LuaNotificationCenter.PostNotification(Common.n_RootWindowWillDestroy, Dialog, self)
      self:OnRemoveIndex()
      UIManager.Destroy(self._rootWindow._uiObject)
      LuaNotificationCenter.RemoveObserver(self)
    end
  end
end

function Dialog:RemoveChildDialogs()
  while self._childDialogs[#self._childDialogs] do
    self._childDialogs[#self._childDialogs]:Destroy()
  end
end

function Dialog:GetChild(path)
  return UIManager.GetChildLuaWindow(self._rootWindow._uiObject, path)
end

function Dialog:SetActive(isActive)
  self:GetRootWindow():SetActive(isActive)
end

function Dialog:isActive()
  return self:GetRootWindow():IsActive()
end

function Dialog:OnCreate()
end

function Dialog:OnDestroy()
end

function Dialog:OnBackPressed()
  return false, false
end

function Dialog:OnBackPointerClick()
  local num = #self._childDialogs
  if 0 < num then
    local isResponse, isReturn = self._childDialogs[num]:OnBackPressed()
    while 1 < num and isResponse and not isReturn do
      num = num - 1
      isResponse, isReturn = self._childDialogs[num]:OnBackPressed()
      if isResponse and isReturn then
        num = num - 1
      end
    end
    if #self._childDialogs == 0 or isResponse and not isReturn then
      if #self._childDialogs ~= 0 and 0 < num then
        local fastMenuMainDialog = DialogManager.GetDialog("fastmenu.fastmenumaindialog")
        if fastMenuMainDialog then
          if not self._childDialogs[num]._fastMenuBtnStatus then
            fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(false)
          else
            fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(true)
          end
          if not self._childDialogs[num]._fastMenuDialogStatus then
            fastMenuMainDialog._rootWindow:SetActive(false)
          else
            fastMenuMainDialog._rootWindow:SetActive(true)
          end
        end
      end
      if isResponse and not isReturn then
        return false
      else
        return true
      end
    else
      return true
    end
  else
    return false
  end
end

function Dialog:CreateChildDialog(childDialog, parentNode)
  childDialog.__isChild = true
  table.insert(self._childDialogs, childDialog)
  childDialog:Load(parentNode._uiObject)
  local fastMenuMainDialog = DialogManager.GetDialog("fastmenu.fastmenumaindialog")
  if fastMenuMainDialog then
    if not childDialog._fastMenuBtnStatus then
      fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(false)
    else
      fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(true)
    end
    if not childDialog._fastMenuDialogStatus then
      fastMenuMainDialog._rootWindow:SetActive(false)
    else
      fastMenuMainDialog._rootWindow:SetActive(true)
    end
  end
  childDialog._canvas = CanvasStaticFunctions.AddCanvasWithGraphicRaycaster(childDialog:GetRootWindow()._uiObject)
  childDialog._canvas.overrideSorting = true
end

function Dialog:OnDestroyChildDialog()
  while self._childDialogs[#self._childDialogs] do
    table.remove(self._childDialogs, #self._childDialogs)
  end
  self:RootWindowDestroy()
  if #self._childDialogs == 0 then
    local fastMenuMainDialog = DialogManager.GetDialog("fastmenu.fastmenumaindialog")
    if fastMenuMainDialog then
      if not self._fastMenuBtnStatus then
        fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(false)
      else
        fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(true)
      end
      if not self._fastMenuDialogStatus then
        fastMenuMainDialog._rootWindow:SetActive(false)
      else
        fastMenuMainDialog._rootWindow:SetActive(true)
      end
    end
  end
end

local function IndexOf(self, dialogKey)
  for i, dialog in ipairs(self._childDialogs) do
    if dialog._dialogKey == dialogKey then
      return i
    end
  end
end

function Dialog:OnRemoveIndex()
  local index = IndexOf(self, self._dialogKey)
  if index then
    table.remove(self._childDialogs, index)
  end
end

function Dialog:OnDialogWillUnLoad(notification)
  local dialog = notification.userInfo
  local index = IndexOf(self, dialog._dialogKey)
  if index then
    table.remove(self._childDialogs, index)
  end
end

function Dialog:PlayEffect(path, effectId)
  local effectControl = self:GetChild(path)
  local handler = effectControl:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(effectId))
  return handler
end

function Dialog:RemoveEffect(path, handler)
  local effectControl = self:GetChild(path)
  effectControl:ReleaseEffect(handler)
end

function Dialog:OnBackBtnClicked()
  return DataCommon.BackPressed_NotResponse
end

return Dialog
