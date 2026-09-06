local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local DialogGroup = require("framework.ui.group.dialoggroup")
local ModalGroup = class("ModalGroup", DialogGroup)

function ModalGroup:Ctor(name, sortinginitorder)
  ModalGroup.super.Ctor(self, name, sortinginitorder)
end

function ModalGroup:AddDialog(dialog)
  dialog:Load(self._root)
  CanvasStaticFunctions.AddCanvasWithGraphicRaycaster(dialog._rootWindow._uiObject).overrideSorting = true
  local fastMenuMainDialog = DialogManager.GetDialog("fastmenu.fastmenumaindialog")
  if fastMenuMainDialog then
    if not dialog._fastMenuBtnStatus then
      fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(false)
    else
      fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(true)
    end
    if not dialog._fastMenuDialogStatus then
      fastMenuMainDialog._rootWindow:SetActive(false)
    else
      fastMenuMainDialog._rootWindow:SetActive(true)
    end
  end
  table.insert(self._dialogs, dialog)
  for i = 1, #self._dialogs - 1 do
    if self._dialogs[i].AddNewModal then
      self._dialogs[i]:AddNewModal(dialog)
    else
      self._dialogs[i]._rootWindow:SetActive(false)
    end
  end
  dialog:OnCreate()
end

function ModalGroup:OnBackPointerClick()
  local num = #self._dialogs
  local isResponse, isReturn = false, false
  if 0 < num then
    isResponse, isReturn = self._dialogs[num]:OnBackPressed()
    num = #self._dialogs
  end
  while 1 < num and isResponse and not isReturn do
    num = num - 1
    isResponse, isReturn = self._dialogs[num]:OnBackPressed()
    if isResponse and isReturn then
      num = num - 1
    end
  end
  if #self._dialogs == 0 or isResponse and not isReturn then
    if #self._dialogs ~= 0 and 0 < num then
      local fastMenuMainDialog = DialogManager.GetDialog("fastmenu.fastmenumaindialog")
      if fastMenuMainDialog then
        if not self._dialogs[num]._fastMenuBtnStatus then
          fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(false)
        else
          fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(true)
        end
        if not self._dialogs[num]._fastMenuDialogStatus then
          fastMenuMainDialog._rootWindow:SetActive(false)
        else
          fastMenuMainDialog._rootWindow:SetActive(true)
        end
      end
      self._dialogs[num]._rootWindow:SetActive(true)
    end
    return false
  elseif 0 < num then
    self._dialogs[num]._rootWindow:SetActive(true)
    return true
  end
end

function ModalGroup:ReturnModalDialog(returnDialog)
  while self._dialogs[#self._dialogs] do
    local dialog = self._dialogs[#self._dialogs]
    if returnDialog and dialog._dialogName == returnDialog._dialogName then
      dialog:RemoveChildDialogs()
      break
    else
      dialog:Destroy()
    end
  end
end

function ModalGroup:RemoveDialog(notification)
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    table.remove(self._dialogs, index)
    dialog:RootWindowDestroy()
    if #self._dialogs > 0 then
      if self._dialogs[#self._dialogs].DestroyModal then
        self._dialogs[#self._dialogs]:DestroyModal(dialog)
      end
      local fastMenuMainDialog = DialogManager.GetDialog("fastmenu.fastmenumaindialog")
      if fastMenuMainDialog then
        if not self._dialogs[#self._dialogs]._fastMenuBtnStatus then
          fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(false)
        else
          fastMenuMainDialog:GetChild("MenuBtn"):SetInteractable(true)
        end
        if not self._dialogs[#self._dialogs]._fastMenuDialogStatus then
          fastMenuMainDialog._rootWindow:SetActive(false)
        else
          fastMenuMainDialog._rootWindow:SetActive(true)
        end
      end
    end
  end
  if #self._dialogs > 0 then
    self._dialogs[#self._dialogs]._rootWindow:SetActive(true)
  end
end

function ModalGroup:RemoveIndex(notification)
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    table.remove(self._dialogs, index)
  end
  if #self._dialogs > 0 then
    self._dialogs[#self._dialogs]._rootWindow:SetActive(true)
  end
end

function ModalGroup:IndexOf(dialogKey)
  for i, dialog in ipairs(self._dialogs) do
    if dialog._dialogKey == dialogKey then
      return i
    end
  end
end

return ModalGroup
