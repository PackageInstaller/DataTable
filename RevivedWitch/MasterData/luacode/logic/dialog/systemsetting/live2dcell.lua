-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/live2dcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Live2DCell = class("Live2DCell", Dialog)
Live2DCell.AssetBundleName = "ui/layouts.setting"
Live2DCell.AssetName = "SettingSystemLive2D"
local LIVE2D_RES_NAME = "live2d"
Live2DCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Live2DCell
  ((Live2DCell.super).Ctor)(self, ...)
  self._uiShowToggleList = {}
end

Live2DCell.OnCreate = function(self)
  -- function num : 0_1
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (self._uiShowToggleList)[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
      ;
      ((self._uiShowToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
  self._tips = self:GetChild("Tips")
  ;
  (self._tips):SetActive(false)
end

Live2DCell.OnDestroy = function(self)
  -- function num : 0_2
end

Live2DCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local is_downloaded = (Live2DManager.IsDownloaded)()
  if is_downloaded then
    (self._tips):SetActive(false)
  else
    ;
    (self._tips):SetActive(true)
  end
  if (Live2DManager.GetLive2dState)() then
    ((self._uiShowToggleList)[1]):SetIsOnType(false)
    ;
    ((self._uiShowToggleList)[2]):SetIsOnType(true)
  else
    ;
    ((self._uiShowToggleList)[1]):SetIsOnType(true)
    ;
    ((self._uiShowToggleList)[2]):SetIsOnType(false)
  end
end

Live2DCell.OnValueChanged = function(self, index)
  -- function num : 0_4 , upvalues : _ENV, LIVE2D_RES_NAME
  if index == 2 and ((self._uiShowToggleList)[index]):GetIsOnType() then
    local is_downloaded = (Live2DManager.IsDownloaded)()
    if is_downloaded then
      (Live2DManager.SaveLocalSelected)(1)
    else
      local c, t = (((((CS.PixelNeko).FileSystem).Update).UpdateManagerGame).GetDownloadPatchesProgress)(LIVE2D_RES_NAME)
      ;
      ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(72, {(string.format)("%.2f", (t - c) / 1024 / 1024)}, function()
    -- function num : 0_4_0 , upvalues : self, LIVE2D_RES_NAME
    self:ConfirmDownLoadLive2D(LIVE2D_RES_NAME)
  end
, {}, function()
    -- function num : 0_4_1 , upvalues : self
    self:CancleDownLoadLive2D()
  end
, {})
    end
    do
      do
        do return  end
        if index == 1 and ((self._uiShowToggleList)[index]):GetIsOnType() then
          (Live2DManager.SaveLocalSelected)(2)
        end
      end
    end
  end
end

Live2DCell.ConfirmDownLoadLive2D = function(self, resName)
  -- function num : 0_5 , upvalues : _ENV
  if (((((CS.PixelNeko).FileSystem).Update).UpdateManagerGame).CreateUpdateFSMGame)(resName) then
    ((DialogManager.CreateSingletonDialog)("resupdatedialog")):SetResName(resName)
  else
    LogErrorFormat("SystemSettingDialog", "CreateUpdateFSMGame fail, resName = %s", resName)
  end
end

Live2DCell.CancleDownLoadLive2D = function(self)
  -- function num : 0_6
  self:RefreshCell()
end

return Live2DCell

