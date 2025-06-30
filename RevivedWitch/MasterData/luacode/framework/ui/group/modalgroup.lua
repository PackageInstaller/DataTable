-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/group/modalgroup.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local DialogGroup = require("framework.ui.group.dialoggroup")
local ModalGroup = class("ModalGroup", DialogGroup)
ModalGroup.Ctor = function(self, name, sortinginitorder)
  -- function num : 0_0 , upvalues : ModalGroup
  ((ModalGroup.super).Ctor)(self, name, sortinginitorder)
end

ModalGroup.AddDialog = function(self, dialog)
  -- function num : 0_1 , upvalues : CanvasStaticFunctions, _ENV
  dialog:Load(self._root)
  ;
  ((CanvasStaticFunctions.AddCanvasWithGraphicRaycaster)((dialog._rootWindow)._uiObject)).overrideSorting = true
  local fastMenuMainDialog = (DialogManager.GetDialog)("fastmenu.fastmenumaindialog")
  if fastMenuMainDialog then
    if not dialog._fastMenuBtnStatus then
      (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(false)
    else
      ;
      (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(true)
    end
    if not dialog._fastMenuDialogStatus then
      (fastMenuMainDialog._rootWindow):SetActive(false)
    else
      ;
      (fastMenuMainDialog._rootWindow):SetActive(true)
    end
  end
  ;
  (table.insert)(self._dialogs, dialog)
  for i = 1, #self._dialogs - 1 do
    if ((self._dialogs)[i]).AddNewModal then
      ((self._dialogs)[i]):AddNewModal(dialog)
    else
      ;
      (((self._dialogs)[i])._rootWindow):SetActive(false)
    end
  end
  dialog:OnCreate()
end

ModalGroup.OnBackPointerClick = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local num = #self._dialogs
  local isResponse, isReturn = false, false
  if num > 0 then
    isResponse = ((self._dialogs)[num]):OnBackPressed()
    num = #self._dialogs
  end
  while num > 1 and isResponse and not isReturn do
    num = num - 1
    -- DECOMPILER ERROR at PC25: Overwrote pending register: R3 in 'AssignReg'

    isResponse = ((self._dialogs)[num]):OnBackPressed()
    if not isResponse or isReturn then
      num = num - 1
    end
  end
  if #self._dialogs == 0 or isResponse and not isReturn then
    do
      if #self._dialogs ~= 0 and num > 0 then
        local fastMenuMainDialog = (DialogManager.GetDialog)("fastmenu.fastmenumaindialog")
        if fastMenuMainDialog then
          if not ((self._dialogs)[num])._fastMenuBtnStatus then
            (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(false)
          else
            ;
            (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(true)
          end
          if not ((self._dialogs)[num])._fastMenuDialogStatus then
            (fastMenuMainDialog._rootWindow):SetActive(false)
          else
            ;
            (fastMenuMainDialog._rootWindow):SetActive(true)
          end
        end
        ;
        (((self._dialogs)[num])._rootWindow):SetActive(true)
      end
      do return false end
      if num > 0 then
        (((self._dialogs)[num])._rootWindow):SetActive(true)
        return true
      end
    end
  end
end

ModalGroup.ReturnModalDialog = function(self, returnDialog)
  -- function num : 0_3
  while 1 do
    while 1 do
      if (self._dialogs)[#self._dialogs] then
        local dialog = (self._dialogs)[#self._dialogs]
        if returnDialog and dialog._dialogName == returnDialog._dialogName then
          dialog:RemoveChildDialogs()
          -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    dialog:Destroy()
  end
end

ModalGroup.RemoveDialog = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    (table.remove)(self._dialogs, index)
    dialog:RootWindowDestroy()
    if #self._dialogs > 0 then
      if ((self._dialogs)[#self._dialogs]).DestroyModal then
        ((self._dialogs)[#self._dialogs]):DestroyModal(dialog)
      end
      local fastMenuMainDialog = (DialogManager.GetDialog)("fastmenu.fastmenumaindialog")
      if fastMenuMainDialog then
        if not ((self._dialogs)[#self._dialogs])._fastMenuBtnStatus then
          (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(false)
        else
          ;
          (fastMenuMainDialog:GetChild("MenuBtn")):SetInteractable(true)
        end
        if not ((self._dialogs)[#self._dialogs])._fastMenuDialogStatus then
          (fastMenuMainDialog._rootWindow):SetActive(false)
        else
          ;
          (fastMenuMainDialog._rootWindow):SetActive(true)
        end
      end
    end
  end
  do
    if #self._dialogs > 0 then
      (((self._dialogs)[#self._dialogs])._rootWindow):SetActive(true)
    end
  end
end

ModalGroup.RemoveIndex = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local dialog = notification.userInfo
  local index = self:IndexOf(dialog._dialogKey)
  if index then
    (table.remove)(self._dialogs, index)
  end
  if #self._dialogs > 0 then
    (((self._dialogs)[#self._dialogs])._rootWindow):SetActive(true)
  end
end

ModalGroup.IndexOf = function(self, dialogKey)
  -- function num : 0_6 , upvalues : _ENV
  for i,dialog in ipairs(self._dialogs) do
    if dialog._dialogKey == dialogKey then
      return i
    end
  end
end

return ModalGroup

