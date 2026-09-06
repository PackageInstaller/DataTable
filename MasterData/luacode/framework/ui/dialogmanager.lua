local UIEventTriggerHelper = CS.PixelNeko.UI.EventTriggerHelper
local UIManager = CS.PixelNeko.UI.UIManager
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

function DialogManager.Clear()
  for _, group in pairs(_groups) do
    group:CloseAllDialog()
  end
end

function DialogManager.CreateFrameDialog(dialogName, parent)
  _count = _count + 1
  local dialogDefine = require("framework.ui." .. dialogName)
  local instance = dialogDefine.Create(_count, dialogName)
  instance:Load(parent)
  return instance
end

function DialogManager.CreateDialog(dialogName, parent)
  _count = _count + 1
  local dialogDefine = require("logic.dialog." .. dialogName)
  local instance = dialogDefine.Create(_count, dialogName)
  instance:Load(parent)
  return instance
end

function DialogManager.CopyDialog(dialogName, copyObj, parent)
  _count = _count + 1
  local dialogDefine = require("logic.dialog." .. dialogName)
  local instance = dialogDefine.Create(_count, dialogName)
  instance:LoadByCopy(copyObj, parent)
  return instance
end

function DialogManager.ReplaceParentNode(dialogName, parentDialogName, parentNode)
  local dialogDefine = require("logic.dialog." .. dialogName)
  if parentDialogName and parentDialogName ~= "" then
    DialogManager.CreateSingletonDialog(parentDialogName)
    if not _singletonDialogs[parentDialogName] then
      return
    end
  end
  local dialog = _singletonDialogs[dialogName]
  if dialog then
    if parentNode == nil or parentNode:IsChildOf(dialog) or not parentNode:IsChildOf(_singletonDialogs[parentDialogName]) then
      if parentNode == nil then
        error("DialogManager.ReplaceParentNode: parentNode is nil.")
      elseif parentNode:IsChildOf(dialog) then
        error("DialogManager.ReplaceParentNode: parentNode is child of dialog.")
      elseif parentNode:IsChildOf(_singletonDialogs[parentDialogName]) then
        error("DialogManager.ReplaceParentNode: parentNode is not child of parentDialog.")
      end
    end
    if dialog._groupName and dialog._groupName ~= "" then
      LogInfo("Invalid groupName, dialog is a SingletonDialog.")
    end
    LuaNotificationCenter.PostNotification(Common.n_DialogWillUnLoad, DialogManager, dialog)
    _singletonDialogs[parentDialogName]:ReplaceNode(dialog, parentNode)
  else
    _count = _count + 1
    dialog = dialogDefine.Create(_count, dialogName)
    _singletonDialogs[dialogName] = dialog
    _singletonDialogKeys[dialogName] = _count
    if parentDialogName and parentDialogName ~= "" then
      _singletonDialogs[parentDialogName]:CreateChildDialog(dialog, parentNode)
    else
      LogError("DialogManager", "parentDialogName Error")
    end
  end
end

function DialogManager.CreateSingletonChildDialog(dialogName, parentDialogName, parentNode)
  local dialogDefine = require("logic.dialog." .. dialogName)
  if parentDialogName and parentDialogName ~= "" then
    DialogManager.CreateSingletonDialog(parentDialogName)
    if not _singletonDialogs[parentDialogName] then
      return
    end
  end
  local dialog = _singletonDialogs[dialogName]
  if dialog then
    return _singletonDialogs[dialogName]
  end
  _count = _count + 1
  dialog = dialogDefine.Create(_count, dialogName)
  _singletonDialogs[dialogName] = dialog
  _singletonDialogKeys[dialogName] = _count
  if parentDialogName and parentDialogName ~= "" then
    _singletonDialogs[parentDialogName]:CreateChildDialog(dialog, parentNode)
  else
    LogError("DialogManager", "parentDialogName Error")
  end
  return dialog
end

function DialogManager.CreateSingletonDialog(dialogName)
  local dialogDefine = require("logic.dialog." .. dialogName)
  if dialogDefine.ParentDialogName ~= "" then
    DialogManager.CreateSingletonDialog(dialogDefine.ParentDialogName)
    if not _singletonDialogs[dialogDefine.ParentDialogName] then
      return
    end
  end
  local dialog = _singletonDialogs[dialogName]
  if dialog then
    return _singletonDialogs[dialogName]
  end
  _count = _count + 1
  dialog = dialogDefine.Create(_count, dialogName)
  _singletonDialogs[dialogName] = dialog
  _singletonDialogKeys[dialogName] = _count
  if dialogDefine.ParentDialogName ~= "" then
    _singletonDialogs[dialogDefine.ParentDialogName]:AddDialog(dialog)
  elseif dialog._groupName then
    local group = _groups[dialog._groupName]
    if group then
      if dialog._groupName == "Modal" then
        LuaNotificationCenter.PostNotification(Common.n_ModalDialogOpen, DialogManager, nil)
      end
      group:AddDialog(dialog)
    else
      LogErrorFormat("DialogManager", "error group name : %s", dialog._groupName)
    end
  else
    LogError("DialogManager", "no group name")
  end
  return dialog
end

function DialogManager.DestroySingletonDialog(dialogName)
  local dialog = _singletonDialogs[dialogName]
  if dialog then
    dialog:Destroy()
    if _singletonDialogs[dialog._dialogName] and dialog._dialogKey == _singletonDialogKeys[dialog._dialogName] then
      _singletonDialogs[dialogName] = nil
      _singletonDialogKeys[dialogName] = nil
      LuaNotificationCenter.PostNotification(Common.n_SingletonDialogDestroy, DialogManager, dialog)
    end
  end
end

function DialogManager.ModifyDialogAsset(dialogName, AssetBundleName, AssetName)
  LogInfoFormat("DialogManager", "dialogName = %s, AssetBundleName = %s, AssetName = %s", dialogName, AssetBundleName, AssetName)
  local dialogDefine = require("logic.dialog." .. dialogName)
  if dialogDefine then
    dialogDefine.AssetBundleName = AssetBundleName
    dialogDefine.AssetName = AssetName
  else
    LogErrorFormat("DialogManager", "Dialog(: %s) not found", dialogName)
  end
end

function DialogManager.GetDialog(dialogName)
  return _singletonDialogs[dialogName]
end

function DialogManager.GetGroup(name)
  return _groups[name]
end

function DialogManager.OnLateUpdate(deltaTime, unscaledDeltaTime)
  for _, group in pairs(_groups) do
    group:ReSort()
  end
end

function DialogManager:OnDialogDestroy(noitification)
  local dialog = noitification.userInfo
  if _singletonDialogs[dialog._dialogName] and dialog._dialogKey == _singletonDialogKeys[dialog._dialogName] then
    if dialog._groupName == "Modal" then
      LuaNotificationCenter.PostNotification(Common.n_ModalDialogClose, nil, nil)
    end
    _singletonDialogs[dialog._dialogName] = nil
    _singletonDialogKeys[dialog._dialogName] = nil
    LuaNotificationCenter.PostNotification(Common.n_SingletonDialogDestroy, DialogManager, dialog)
  end
end

function DialogManager:OnPointerWillDown(eventData, luaWindow)
  LuaNotificationCenter.PostNotification(Common.n_GlobalPointerWillDown, DialogManager, {eventData = eventData, luaWindow = luaWindow})
end

function DialogManager:OnNoTargetWindowClick(eventData)
  LuaNotificationCenter.PostNotification(Common.n_NoTargetWindowClick, DialogManager, {eventData = eventData})
end

function DialogManager:OnPointerDidClick(eventData, luaWindow)
  LuaNotificationCenter.PostNotification(Common.n_GlobalPointerDidClick, DialogManager, {eventData = eventData, luaWindow = luaWindow})
end

function DialogManager:OnModalDialogOpen()
  _modalDialogCount = _modalDialogCount + 1
  _groups.Default:SetObjectActive(false)
end

function DialogManager:OnModalDialogDestroy()
  _modalDialogCount = _modalDialogCount - 1
  if _modalDialogCount < 0 then
    LogError("DialogManager", "_modalDialogCount Error")
  elseif _modalDialogCount == 0 then
    _groups.Default:SetObjectActive(true)
    LuaNotificationCenter.PostNotification(Common.n_AllModalDialogClose, DialogManager, nil)
  end
end

function DialogManager:HandleBackPressed()
  for _, group in ipairs(_sortGroups) do
    local len = #group._dialogs
    for i = len, 1, -1 do
      local dialog = group._dialogs[i]
      local childDialogsNum = #dialog._childDialogs
      if 0 < childDialogsNum then
        for j = childDialogsNum, 1, -1 do
          local dialog = dialog._childDialogs[j]
          local BackPressedType = dialog:OnBackBtnClicked()
          if BackPressedType == DataCommon.BackPressed_NotResponse then
            LogInfoFormat("DialogManager", "NotResponse: dialogName is %s", dialog._dialogName)
            return
          elseif BackPressedType == DataCommon.BackPressed_SkipResponse then
            LogInfoFormat("DialogManager", "SkipResponse: dialogName is %s", dialog._dialogName)
          else
            LogInfoFormat("DialogManager", "Response: dialogName is %s", dialog._dialogName)
            return
          end
        end
        local BackPressedType = dialog:OnBackBtnClicked()
        if BackPressedType == DataCommon.BackPressed_NotResponse then
          LogInfoFormat("DialogManager", "NotResponse: dialogName is %s", dialog._dialogName)
          return
        elseif BackPressedType == DataCommon.BackPressed_SkipResponse then
          LogInfoFormat("DialogManager", "SkipResponse: dialogName is %s", dialog._dialogName)
        else
          LogInfoFormat("DialogManager", "Response: dialogName is %s", dialog._dialogName)
          return
        end
      else
        local BackPressedType = dialog:OnBackBtnClicked()
        if BackPressedType == DataCommon.BackPressed_NotResponse then
          LogInfoFormat("DialogManager", "NotResponse: dialogName is %s", dialog._dialogName)
          if dialog._dialogName == "base.basemainmenudialog" then
            return true
          end
          return
        elseif BackPressedType == DataCommon.BackPressed_SkipResponse then
          LogInfoFormat("DialogManager", "SkipResponse: dialogName is %s", dialog._dialogName)
        else
          LogInfoFormat("DialogManager", "Response: dialogName is %s", dialog._dialogName)
          return
        end
      end
    end
  end
end

function DialogManager:GetTopmostDialog()
  for _, group in ipairs(_sortGroups) do
    if group._name ~= "UI_ClickEffect" and group._name ~= "UI_Message" and group._name ~= "UI_Guide" then
      local len = #group._dialogs
      for i = len, 1, -1 do
        local dialog = group._dialogs[i]
        local childDialogsNum = #dialog._childDialogs
        if 0 < childDialogsNum then
          return dialog._childDialogs[childDialogsNum]
        else
          return dialog
        end
      end
    end
  end
end

LuaNotificationCenter.AddObserver(DialogManager, DialogManager.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
LuaNotificationCenter.AddObserver(DialogManager, DialogManager.OnModalDialogDestroy, Common.n_ModalDialogClose, nil)
LuaNotificationCenter.AddObserver(DialogManager, DialogManager.OnModalDialogOpen, Common.n_ModalDialogOpen, nil)
UIEventTriggerHelper.AddGlobalPointerWillDownListener(DialogManager.OnPointerWillDown, DialogManager)
UIEventTriggerHelper.AddGlobalPointerDidClickListener(DialogManager.OnPointerDidClick, DialogManager)
UIManager.AddNoTargetWindowGlobalClickListener(DialogManager.OnNoTargetWindowClick, DialogManager)
_groups.Operation = DialogGroup.Create("UI_Operation", 1000)
_groups.Default = DialogGroup.Create("UI_Default", 2000)
_groups.Battle = DialogGroup.Create("UI_Battle", 3000)
_groups.ScreenEffect = DialogGroup.Create("UI_ScreenEffect", 4000)
_groups.Chat = DialogGroup.Create("UI_Chat", 5000)
_groups.Modal = ModalGroup.Create("UI_Modal", 6000)
_groups.ModalFrame = DialogGroup.Create("UI_ModalFrame", 7000)
_groups.SecondConfirm = SecondConfirmGroup.Create("UI_SecondConfirm", 8000)
_groups.Tip = TipsGroup.Create("UI_Tip", 9000)
_groups.Guide = DialogGroup.Create("UI_Guide", 10000)
_groups.Loading = DialogGroup.Create("UI_Loading", 11000)
_groups.Message = DialogGroup.Create("UI_Message", 12000)
_groups.BrokenLine = DialogGroup.Create("UI_BrokenLine", 13000)
_groups.ClickEffect = DialogGroup.Create("UI_ClickEffect", 14000)
table.insert(_sortGroups, _groups.ClickEffect)
table.insert(_sortGroups, _groups.BrokenLine)
table.insert(_sortGroups, _groups.Message)
table.insert(_sortGroups, _groups.Loading)
table.insert(_sortGroups, _groups.Guide)
table.insert(_sortGroups, _groups.Tip)
table.insert(_sortGroups, _groups.SecondConfirm)
table.insert(_sortGroups, _groups.ModalFrame)
table.insert(_sortGroups, _groups.Modal)
table.insert(_sortGroups, _groups.Chat)
table.insert(_sortGroups, _groups.ScreenEffect)
table.insert(_sortGroups, _groups.Battle)
table.insert(_sortGroups, _groups.Default)
table.insert(_sortGroups, _groups.Operation)
return DialogManager
