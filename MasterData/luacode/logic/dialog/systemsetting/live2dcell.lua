local Live2DCell = class("Live2DCell", Dialog)
Live2DCell.AssetBundleName = "ui/layouts.setting"
Live2DCell.AssetName = "SettingSystemLive2D"
local LIVE2D_RES_NAME = "live2d"

function Live2DCell:Ctor(...)
  Live2DCell.super.Ctor(self, ...)
  self._uiShowToggleList = {}
end

function Live2DCell:OnCreate()
  for i = 1, 2 do
    self._uiShowToggleList[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
    self._uiShowToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
  self._tips = self:GetChild("Tips")
  self._tips:SetActive(false)
  self._redDot = self:GetChild("RedDot")
end

function Live2DCell:OnDestroy()
end

function Live2DCell:RefreshCell()
  local is_downloaded = Live2DManager.IsDownloaded()
  if is_downloaded then
    self._tips:SetActive(false)
    self._redDot:SetActive(false)
  else
    self._tips:SetActive(true)
    self._redDot:SetActive(true)
  end
  if Live2DManager.GetLive2dState() then
    self._uiShowToggleList[1]:SetIsOnType(false)
    self._uiShowToggleList[2]:SetIsOnType(true)
  else
    self._uiShowToggleList[1]:SetIsOnType(true)
    self._uiShowToggleList[2]:SetIsOnType(false)
  end
end

function Live2DCell:OnValueChanged(index)
  if index == 2 and self._uiShowToggleList[index]:GetIsOnType() then
    local is_downloaded = Live2DManager.IsDownloaded()
    if is_downloaded then
      Live2DManager.SaveLocalSelected(1)
    else
      local c, t = CS.PixelNeko.FileSystem.Update.UpdateManagerGame.GetDownloadPatchesProgress(LIVE2D_RES_NAME)
      NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(72, {
        string.format("%.2f", (t - c) / 1024 / 1024)
      }, function()
        self:ConfirmDownLoadLive2D(LIVE2D_RES_NAME)
      end, {}, function()
        self:CancleDownLoadLive2D()
      end, {})
    end
    return
  elseif index == 1 and self._uiShowToggleList[index]:GetIsOnType() then
    Live2DManager.SaveLocalSelected(2)
  end
end

function Live2DCell:ConfirmDownLoadLive2D(resName)
  if CS.PixelNeko.FileSystem.Update.UpdateManagerGame.CreateUpdateFSMGame(resName) then
    DialogManager.CreateSingletonDialog("resupdatedialog"):SetResName(resName)
  else
    LogErrorFormat("SystemSettingDialog", "CreateUpdateFSMGame fail, resName = %s", resName)
  end
end

function Live2DCell:CancleDownLoadLive2D()
  self:RefreshCell()
end

return Live2DCell
