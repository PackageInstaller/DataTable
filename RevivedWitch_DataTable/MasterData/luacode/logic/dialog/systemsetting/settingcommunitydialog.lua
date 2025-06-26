-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/settingcommunitydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SettingCommunityDialog = class("SettingCommunityDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local CSApplication = (CS.UnityEngine).Application
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CCommunityCfg = (BeanManager.GetTableByName)("setting.ccommunitycfg")
SettingCommunityDialog.AssetBundleName = "ui/layouts.setting"
SettingCommunityDialog.AssetName = "SettingCommunity"
SettingCommunityDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SettingCommunityDialog
  ((SettingCommunityDialog.super).Ctor)(self, ...)
end

SettingCommunityDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._framePanel = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._framePanel, self, true, true, true)
  self._cells = {}
  self._scrollbar = self:GetChild("Scrollbar")
  local supportCommunityCfg = ((NekoData.BehaviorManager).BM_Game):GetSupportCommunityCfg()
  if (((CS.PixelNeko).LuaManager).IsUnityEditor)() then
    for i = 1, 6 do
      if i ~= 2 and i ~= 1 then
        (table.insert)(self._cells, "systemsetting.settingcommunitycell" .. i)
      end
    end
  else
    do
      if (SdkManager.GetChannel)() == "leit" then
        for _,value in ipairs(supportCommunityCfg) do
          if value ~= 2 and value ~= 1 then
            (table.insert)(self._cells, "systemsetting.settingcommunitycell" .. value)
          end
        end
      end
      do
        self:RefreshTabCell()
      end
    end
  end
end

SettingCommunityDialog.OnDestroy = function(self, ...)
  -- function num : 0_2
  (self._frame):Destroy()
end

SettingCommunityDialog.RefreshTabCell = function(self)
  -- function num : 0_3
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

SettingCommunityDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._cells
end

SettingCommunityDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return (self._cells)[index]
end

SettingCommunityDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
end

SettingCommunityDialog.OnCell1BtnClick = function(self)
  -- function num : 0_7 , upvalues : _ENV
  ((SdkManager.GetAgent)()):ShowCustomerService("")
end

SettingCommunityDialog.OnCell2BtnClick = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (SdkManager.OpenAccountCenter)()
end

SettingCommunityDialog.OnCell3BtnClick = function(self)
  -- function num : 0_9 , upvalues : _ENV, CCommunityCfg
  ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)((CCommunityCfg:GetRecorder(3)).url)
end

SettingCommunityDialog.OnCell4BtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("systemsetting.settingcommunitywechatdialog")
end

SettingCommunityDialog.OnCell5BtnClick = function(self)
  -- function num : 0_11 , upvalues : _ENV, CVarConfig
  local plat = (((CS.PixelNeko).LuaManager).GetSystemType)()
  local systemType = require("protocols.bean.protocol.common.systemtype")
  if plat == systemType.IOS then
    ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)((CVarConfig:GetRecorder(20)).Value)
  else
    if plat == systemType.ANDROID then
      ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)((CVarConfig:GetRecorder(19)).Value)
    end
  end
end

SettingCommunityDialog.OnCell6BtnClick = function(self)
  -- function num : 0_12 , upvalues : _ENV, CCommunityCfg
  ((((CS.PixelNeko).Tools).ShareHelper).OpenURL)((CCommunityCfg:GetRecorder(6)).url)
end

SettingCommunityDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_13
  local width, height = (self._framePanel):GetRectSize()
  local total = (self._frame):GetTotalLength()
  if height < total then
    (self._scrollbar):SetScrollSize(height / total)
    ;
    (self._scrollbar):SetScrollValue(1 - proportion)
  else
    ;
    (self._scrollbar):SetScrollSize(1)
    ;
    (self._scrollbar):SetScrollValue(proportion)
  end
end

return SettingCommunityDialog

