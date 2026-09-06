local UIManager = CS.PixelNeko.UI.UIManager
local TableFrame = require("framework.ui.frame.table.tableframe")
local SystemSettingCharCell = class("SystemSettingCharCell", Dialog)
SystemSettingCharCell.AssetBundleName = "ui/layouts.setting"
SystemSettingCharCell.AssetName = "SettingSystemChar"

function SystemSettingCharCell:Ctor(...)
  SystemSettingCharCell.super.Ctor(self, ...)
  self._characterDisplayData = {}
end

function SystemSettingCharCell:OnCreate()
  self._characterDisplayBack = self:GetChild("Back")
  self._characterDisplayOpenIcon = self:GetChild("Btn")
  self._characterDisplayHideIcon = self:GetChild("BtnDown")
  self._characterDisplayOpenName = self:GetChild("Btn/Txt")
  self._characterDisplayHideName = self:GetChild("BtnDown/Txt")
  self._characterDisplayFrameBack = self:GetChild("CharList")
  self._characterDisplayFramePanel = self:GetChild("CharList/Frame")
  self._characterDisplayFrame = TableFrame.Create(self._characterDisplayFramePanel, self, true, false, true)
  self._characterDisplayBack:Subscribe_PointerClickEvent(self.OpenOrHideCharDisplayFrame, self)
  self._characterDisplayOpenIcon:Subscribe_PointerClickEvent(self.OpenCharDisplayFrame, self)
  self._characterDisplayHideIcon:Subscribe_PointerClickEvent(self.HideCharDisplayFrame, self)
  LuaNotificationCenter.AddObserver(self, self.OnNewOverlayFSMounted, Common.n_NewOverlayFSMounted, nil)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function SystemSettingCharCell:OnDestroy()
  self._characterDisplayFrame:Destroy()
end

function SystemSettingCharCell:RefreshCell()
  self:InitCharacterInfo()
end

function SystemSettingCharCell:ChangeCharacterDisplay(displayData)
  if displayData.type == 1 then
    Live2DManager.SaveLocalSelected(1)
  else
    Live2DManager.SaveLocalSelected(2)
  end
  self:InitCharacterInfo()
end

function SystemSettingCharCell:OnSelectCharacterDisplay(displayData)
  LogInfoFormat("SystemSettingCharCell ", " OnSelectCharacterDisplay character display Name:%s resName:%s ", displayData.name, displayData.resName)
  self:HideCharDisplayFrame()
  if displayData.state == 2 then
    return
  end
  if LuaUpdateManager.UseEditorRes() then
    self:ChangeCharacterDisplay(displayData)
  elseif displayData.state == 0 then
    local c, t = CS.PixelNeko.FileSystem.Update.UpdateManagerGame.GetDownloadPatchesProgress(displayData.resName)
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(114, {
      string.format("%.2f", (t - c) / 1024 / 1024)
    }, function()
      self:ConfirmDownLoadCharacterDispay(displayData.resName)
    end, {}, nil, {})
  elseif displayData.state == 1 then
    self:ChangeCharacterDisplay(displayData)
  elseif displayData.state == 3 then
    DialogManager.CreateSingletonDialog("resupdatedialog"):SetResName(displayData.resName)
  end
end

function SystemSettingCharCell:InitCharacterInfo()
  self._characterDisplayData = {}
  local live2DName = TextManager.GetText(701070)
  local imageName = TextManager.GetText(701069)
  local isLive2DSelected = Live2DManager.IsLive2DSelected()
  local live2DData = {}
  live2DData.name = live2DName
  live2DData.resName = Live2DManager.GetResName()
  live2DData.type = 1
  if LuaUpdateManager.HasInGameUpdateFSM(live2DData.resName) then
    live2DData.state = 3
  elseif isLive2DSelected then
    live2DData.state = 2
  elseif Live2DManager.IsDownloaded() then
    live2DData.state = 1
  else
    live2DData.state = 0
  end
  local imageData = {}
  imageData.name = imageName
  imageData.resName = ""
  imageData.type = 2
  if isLive2DSelected then
    imageData.state = 1
  else
    imageData.state = 2
  end
  table.insert(self._characterDisplayData, live2DData)
  table.insert(self._characterDisplayData, imageData)
  if isLive2DSelected then
    self._characterDisplayOpenName:SetText(live2DName)
    self._characterDisplayHideName:SetText(live2DName)
  else
    self._characterDisplayOpenName:SetText(imageName)
    self._characterDisplayHideName:SetText(imageName)
  end
  self._characterDisplayFrame:ReloadAllCell()
end

function SystemSettingCharCell:OpenCharDisplayFrame()
  self._showCharacterDisplayFrame = true
  self:SetCharacterDisplayUIShowState()
end

function SystemSettingCharCell:HideCharDisplayFrame()
  self._showCharacterDisplayFrame = false
  self:SetCharacterDisplayUIShowState()
end

function SystemSettingCharCell:OpenOrHideCharDisplayFrame()
  self._showCharacterDisplayFrame = not self._showCharacterDisplayFrame
  self:SetAudioUIShowStSetCharacterDisplayUIShowStateate()
end

function SystemSettingCharCell:SetCharacterDisplayUIShowState()
  self._characterDisplayFrameBack:SetActive(self._showCharacterDisplayFrame)
  self._characterDisplayOpenIcon:SetActive(not self._showCharacterDisplayFrame)
  self._characterDisplayHideIcon:SetActive(self._showCharacterDisplayFrame)
end

function SystemSettingCharCell:NumberOfCell(helper)
  return #self._characterDisplayData
end

function SystemSettingCharCell:CellAtIndex(helper, index)
  return "systemsetting.selectcharacterdisplaycell"
end

function SystemSettingCharCell:DataAtIndex(helper, index)
  self._characterDisplayData[index].index = index
  return self._characterDisplayData[index]
end

function SystemSettingCharCell:OnNewOverlayFSMounted(args)
  if args.userInfo == Live2DManager.GetResName() then
    self:InitCharacterInfo()
    return
  end
end

function SystemSettingCharCell:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._characterDisplayFramePanel._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:HideCharDisplayFrame()
  end
end

return SystemSettingCharCell
