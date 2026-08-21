-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/dialogmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIEventTriggerHelper = ((CS.PixelNeko).UI).EventTriggerHelper
local UIManager = ((CS.PixelNeko).UI).UIManager
local DialogGroup = require("framework.ui.group.dialoggroup")
local ModalGroup = require("framework.ui.group.modalgroup")
local SecondConfirmGroup = require("framework.ui.group.secondconfirmgroup")
local TipsGroup = require("framework.ui.group.tipsgroup")
local DialogManager = {}
local _singletonDialogs = {}
local _singletonDialogKeys = {}
local _groups = {}
local _sortGroups = {}
local _count = 0
local _modalDialogCount = 0
DialogManager.Clear = function()
  -- function num : 0_0 , upvalues : _ENV, _groups
  for _,group in pairs(_groups) do
    group:CloseAllDialog()
  end
end

DialogManager.CreateFrameDialog = function(dialogName, parent)
  -- function num : 0_1 , upvalues : _count, _ENV
  _count = _count + 1
  local dialogDefine = require("framework.ui." .. dialogName)
  local instance = (dialogDefine.Create)(_count, dialogName)
  instance:Load(parent)
  return instance
end

DialogManager.CreateDialog = function(dialogName, parent)
  -- function num : 0_2 , upvalues : _count, _ENV
  _count = _count + 1
  local dialogDefine = require("logic.dialog." .. dialogName)
  local instance = (dialogDefine.Create)(_count, dialogName)
  instance:Load(parent)
  return instance
end

DialogManager.CopyDialog = function(dialogName, copyObj, parent)
  -- function num : 0_3 , upvalues : _count, _ENV
  _count = _count + 1
  local dialogDefine = require("logic.dialog." .. dialogName)
  local instance = (dialogDefine.Create)(_count, dialogName)
  instance:LoadByCopy(copyObj, parent)
  return instance
end

DialogManager.ReplaceParentNode = function(dialogName, parentDialogName, parentNode)
  -- function num : 0_4 , upvalues : _ENV, DialogManager, _singletonDialogs, _count, _singletonDialogKeys
  local dialogDefine = require("logic.dialog." .. dialogName)
  if parentDialogName and parentDialogName ~= "" then
    (DialogManager.CreateSingletonDialog)(parentDialogName)
    if not _singletonDialogs[parentDialogName] then
      return 
    end
  end
  local dialog = _singletonDialogs[dialogName]
  if dialog then
    if parentNode == nil or parentNode:IsChildOf(dialog) or not parentNode:IsChildOf(_singletonDialogs[parentDialogName]) then
      if parentNode == nil then
        error("DialogManager.ReplaceParentNode: parentNode is nil.")
      else
        if parentNode:IsChildOf(dialog) then
          error("DialogManager.ReplaceParentNode: parentNode is child of dialog.")
        else
          if parentNode:IsChildOf(_singletonDialogs[parentDialogName]) then
            error("DialogManager.ReplaceParentNode: parentNode is not child of parentDialog.")
          end
        end
      end
    end
    if dialog._groupName and dialog._groupName ~= "" then
      LogInfo("Invalid groupName, dialog is a SingletonDialog.")
    end
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_DialogWillUnLoad, DialogManager, dialog)
    ;
    (_singletonDialogs[parentDialogName]):ReplaceNode(dialog, parentNode)
  else
    _count = _count + 1
    dialog = (dialogDefine.Create)(_count, dialogName)
    _singletonDialogs[dialogName] = dialog
    _singletonDialogKeys[dialogName] = _count
    if parentDialogName and parentDialogName ~= "" then
      (_singletonDialogs[parentDialogName]):CreateChildDialog(dialog, parentNode)
    else
      LogError("DialogManager", "parentDialogName Error")
    end
  end
end

DialogManager.CreateSingletonChildDialog = function(dialogName, parentDialogName, parentNode)
  -- function num : 0_5 , upvalues : _ENV, DialogManager, _singletonDialogs, _count, _singletonDialogKeys
  local dialogDefine = require("logic.dialog." .. dialogName)
  if parentDialogName and parentDialogName ~= "" then
    (DialogManager.CreateSingletonDialog)(parentDialogName)
    if not _singletonDialogs[parentDialogName] then
      return 
    end
  end
  local dialog = _singletonDialogs[dialogName]
  if dialog then
    return _singletonDialogs[dialogName]
  end
  _count = _count + 1
  dialog = (dialogDefine.Create)(_count, dialogName)
  _singletonDialogs[dialogName] = dialog
  _singletonDialogKeys[dialogName] = _count
  if parentDialogName and parentDialogName ~= "" then
    (_singletonDialogs[parentDialogName]):CreateChildDialog(dialog, parentNode)
  else
    LogError("DialogManager", "parentDialogName Error")
  end
  return dialog
end

DialogManager.CreateSingletonDialog = function(dialogName)
  -- function num : 0_6 , upvalues : _ENV, DialogManager, _singletonDialogs, _count, _singletonDialogKeys, _groups
  local dialogDefine = require("logic.dialog." .. dialogName)
  if dialogDefine.ParentDialogName ~= "" then
    (DialogManager.CreateSingletonDialog)(dialogDefine.ParentDialogName)
    if not _singletonDialogs[dialogDefine.ParentDialogName] then
      return 
    end
  end
  local dialog = _singletonDialogs[dialogName]
  if dialog then
    return _singletonDialogs[dialogName]
  end
  _count = _count + 1
  dialog = (dialogDefine.Create)(_count, dialogName)
  _singletonDialogs[dialogName] = dialog
  _singletonDialogKeys[dialogName] = _count
  if dialogDefine.ParentDialogName ~= "" then
    (_singletonDialogs[dialogDefine.ParentDialogName]):AddDialog(dialog)
  else
    if dialog._groupName then
      local group = _groups[dialog._groupName]
      if group then
        if dialog._groupName == "Modal" then
          (LuaNotificationCenter.PostNotification)(Common.n_ModalDialogOpen, DialogManager, nil)
        end
        group:AddDialog(dialog)
      else
        LogErrorFormat("DialogManager", "error group name : %s", dialog._groupName)
      end
    else
      do
        LogError("DialogManager", "no group name")
        return dialog
      end
    end
  end
end

DialogManager.DestroySingletonDialog = function(dialogName)
  -- function num : 0_7 , upvalues : _singletonDialogs, _singletonDialogKeys, _ENV, DialogManager
  local dialog = _singletonDialogs[dialogName]
  if dialog then
    dialog:Destroy()
    if _singletonDialogs[dialog._dialogName] and dialog._dialogKey == _singletonDialogKeys[dialog._dialogName] then
      _singletonDialogs[dialogName] = nil
      _singletonDialogKeys[dialogName] = nil
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_SingletonDialogDestroy, DialogManager, dialog)
    end
  end
end

DialogManager.ModifyDialogAsset = function(dialogName, AssetBundleName, AssetName)
  -- function num : 0_8 , upvalues : _ENV
  LogInfoFormat("DialogManager", "dialogName = %s, AssetBundleName = %s, AssetName = %s", dialogName, AssetBundleName, AssetName)
  local dialogDefine = require("logic.dialog." .. dialogName)
  if dialogDefine then
    dialogDefine.AssetBundleName = AssetBundleName
    dialogDefine.AssetName = AssetName
  else
    LogErrorFormat("DialogManager", "Dialog(: %s) not found", dialogName)
  end
end

DialogManager.GetDialog = function(dialogName)
  -- function num : 0_9 , upvalues : _singletonDialogs
  return _singletonDialogs[dialogName]
end

DialogManager.GetGroup = function(name)
  -- function num : 0_10 , upvalues : _groups
  return _groups[name]
end

DialogManager.OnLateUpdate = function(deltaTime, unscaledDeltaTime)
  -- function num : 0_11 , upvalues : _ENV, _groups
  for _,group in pairs(_groups) do
    group:ReSort()
  end
end

DialogManager.OnDialogDestroy = function(self, noitification)
  -- function num : 0_12 , upvalues : _singletonDialogs, _singletonDialogKeys, _ENV, DialogManager
  local dialog = noitification.userInfo
  if _singletonDialogs[dialog._dialogName] and dialog._dialogKey == _singletonDialogKeys[dialog._dialogName] then
    if dialog._groupName == "Modal" then
      (LuaNotificationCenter.PostNotification)(Common.n_ModalDialogClose, nil, nil)
    end
    _singletonDialogs[dialog._dialogName] = nil
    _singletonDialogKeys[dialog._dialogName] = nil
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_SingletonDialogDestroy, DialogManager, dialog)
  end
end

DialogManager.OnPointerWillDown = function(self, eventData, luaWindow)
  -- function num : 0_13 , upvalues : _ENV, DialogManager
  (LuaNotificationCenter.PostNotification)(Common.n_GlobalPointerWillDown, DialogManager, {eventData = eventData, luaWindow = luaWindow})
end

DialogManager.OnNoTargetWindowClick = function(self, eventData)
  -- function num : 0_14 , upvalues : _ENV, DialogManager
  (LuaNotificationCenter.PostNotification)(Common.n_NoTargetWindowClick, DialogManager, {eventData = eventData})
end

DialogManager.OnPointerDidClick = function(self, eventData, luaWindow)
  -- function num : 0_15 , upvalues : _ENV, DialogManager
  (LuaNotificationCenter.PostNotification)(Common.n_GlobalPointerDidClick, DialogManager, {eventData = eventData, luaWindow = luaWindow})
end

DialogManager.OnModalDialogOpen = function(self)
  -- function num : 0_16 , upvalues : _modalDialogCount, _groups
  _modalDialogCount = _modalDialogCount + 1
  ;
  (_groups.Default):SetObjectActive(false)
end

DialogManager.OnModalDialogDestroy = function(self)
  -- function num : 0_17 , upvalues : _modalDialogCount, _ENV, _groups, DialogManager
  _modalDialogCount = _modalDialogCount - 1
  if _modalDialogCount < 0 then
    LogError("DialogManager", "_modalDialogCount Error")
  else
    if _modalDialogCount == 0 then
      (_groups.Default):SetObjectActive(true)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_AllModalDialogClose, DialogManager, nil)
    end
  end
end

DialogManager.HandleBackPressed = function(self)
  -- function num : 0_18 , upvalues : _ENV, _sortGroups
  for _,group in ipairs(_sortGroups) do
    local len = #group._dialogs
    for i = len, 1, -1 do
      local dialog = (group._dialogs)[i]
      local childDialogsNum = #dialog._childDialogs
      if childDialogsNum > 0 then
        for j = childDialogsNum, 1, -1 do
          local dialog = (dialog._childDialogs)[j]
          local BackPressedType = dialog:OnBackBtnClicked()
          if BackPressedType == DataCommon.BackPressed_NotResponse then
            LogInfoFormat("DialogManager", "NotResponse: dialogName is %s", dialog._dialogName)
            return 
          else
            if BackPressedType == DataCommon.BackPressed_SkipResponse then
              LogInfoFormat("DialogManager", "SkipResponse: dialogName is %s", dialog._dialogName)
            else
              LogInfoFormat("DialogManager", "Response: dialogName is %s", dialog._dialogName)
              return 
            end
          end
        end
        local BackPressedType = dialog:OnBackBtnClicked()
        if BackPressedType == DataCommon.BackPressed_NotResponse then
          LogInfoFormat("DialogManager", "NotResponse: dialogName is %s", dialog._dialogName)
          return 
        else
          if BackPressedType == DataCommon.BackPressed_SkipResponse then
            LogInfoFormat("DialogManager", "SkipResponse: dialogName is %s", dialog._dialogName)
          else
            LogInfoFormat("DialogManager", "Response: dialogName is %s", dialog._dialogName)
            return 
          end
        end
      else
        do
          do
            local BackPressedType = dialog:OnBackBtnClicked()
            if BackPressedType == DataCommon.BackPressed_NotResponse then
              LogInfoFormat("DialogManager", "NotResponse: dialogName is %s", dialog._dialogName)
              if dialog._dialogName == "base.basemainmenudialog" then
                return true
              end
              return 
            else
              if BackPressedType == DataCommon.BackPressed_SkipResponse then
                LogInfoFormat("DialogManager", "SkipResponse: dialogName is %s", dialog._dialogName)
              else
                LogInfoFormat("DialogManager", "Response: dialogName is %s", dialog._dialogName)
                return 
              end
            end
            -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC116: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

DialogManager.GetTopmostDialog = function(self)
  -- function num : 0_19 , upvalues : _ENV, _sortGroups
  for _,group in ipairs(_sortGroups) do
    if group._name ~= "UI_ClickEffect" and group._name ~= "UI_Message" and group._name ~= "UI_Guide" then
      local len = #group._dialogs
      for i = len, 1, -1 do
        local dialog = (group._dialogs)[i]
        local childDialogsNum = #dialog._childDialogs
        if childDialogsNum > 0 then
          return (dialog._childDialogs)[childDialogsNum]
        else
          return dialog
        end
      end
    end
  end
end

;
(LuaNotificationCenter.AddObserver)(DialogManager, DialogManager.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
;
(LuaNotificationCenter.AddObserver)(DialogManager, DialogManager.OnModalDialogDestroy, Common.n_ModalDialogClose, nil)
;
(LuaNotificationCenter.AddObserver)(DialogManager, DialogManager.OnModalDialogOpen, Common.n_ModalDialogOpen, nil)
;
(UIEventTriggerHelper.AddGlobalPointerWillDownListener)(DialogManager.OnPointerWillDown, DialogManager)
;
(UIEventTriggerHelper.AddGlobalPointerDidClickListener)(DialogManager.OnPointerDidClick, DialogManager)
;
(UIManager.AddNoTargetWindowGlobalClickListener)(DialogManager.OnNoTargetWindowClick, DialogManager)
_groups.Operation = (DialogGroup.Create)("UI_Operation", 1000)
_groups.Default = (DialogGroup.Create)("UI_Default", 2000)
_groups.Battle = (DialogGroup.Create)("UI_Battle", 3000)
_groups.ScreenEffect = (DialogGroup.Create)("UI_ScreenEffect", 4000)
_groups.Chat = (DialogGroup.Create)("UI_Chat", 5000)
_groups.Modal = (ModalGroup.Create)("UI_Modal", 6000)
_groups.ModalFrame = (DialogGroup.Create)("UI_ModalFrame", 7000)
_groups.SecondConfirm = (SecondConfirmGroup.Create)("UI_SecondConfirm", 8000)
_groups.Tip = (TipsGroup.Create)("UI_Tip", 9000)
_groups.Guide = (DialogGroup.Create)("UI_Guide", 10000)
_groups.Loading = (DialogGroup.Create)("UI_Loading", 11000)
_groups.Message = (DialogGroup.Create)("UI_Message", 12000)
_groups.BrokenLine = (DialogGroup.Create)("UI_BrokenLine", 13000)
_groups.ClickEffect = (DialogGroup.Create)("UI_ClickEffect", 14000)
;
(table.insert)(_sortGroups, _groups.ClickEffect)
;
(table.insert)(_sortGroups, _groups.BrokenLine)
;
(table.insert)(_sortGroups, _groups.Message)
;
(table.insert)(_sortGroups, _groups.Loading)
;
(table.insert)(_sortGroups, _groups.Guide)
;
(table.insert)(_sortGroups, _groups.Tip)
;
(table.insert)(_sortGroups, _groups.SecondConfirm)
;
(table.insert)(_sortGroups, _groups.ModalFrame)
;
(table.insert)(_sortGroups, _groups.Modal)
;
(table.insert)(_sortGroups, _groups.Chat)
;
(table.insert)(_sortGroups, _groups.ScreenEffect)
;
(table.insert)(_sortGroups, _groups.Battle)
;
(table.insert)(_sortGroups, _groups.Default)
;
(table.insert)(_sortGroups, _groups.Operation)
return DialogManager

