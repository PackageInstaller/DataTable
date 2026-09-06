local SettingCommunityDialog = class("SettingCommunityDialog", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local CSApplication = CS.UnityEngine.Application
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local CCommunityCfg = BeanManager.GetTableByName("setting.ccommunitycfg")
SettingCommunityDialog.AssetBundleName = "ui/layouts.setting"
SettingCommunityDialog.AssetName = "SettingCommunity"

function SettingCommunityDialog:Ctor(...)
  SettingCommunityDialog.super.Ctor(self, ...)
end

function SettingCommunityDialog:OnCreate()
  self._framePanel = self:GetChild("Frame")
  self._frame = TableFrame.Create(self._framePanel, self, true, true, true)
  self._cells = {}
  self._scrollbar = self:GetChild("Scrollbar")
  local supportCommunityCfg = NekoData.BehaviorManager.BM_Game:GetSupportCommunityCfg()
  if CS.PixelNeko.LuaManager.IsUnityEditor() then
    for i = 1, 6 do
      if i ~= 2 and i ~= 1 then
        table.insert(self._cells, "systemsetting.settingcommunitycell" .. i)
      end
    end
  elseif SdkManager.GetChannel() == "leit" then
    for _, value in ipairs(supportCommunityCfg) do
      if value ~= 2 and value ~= 1 then
        table.insert(self._cells, "systemsetting.settingcommunitycell" .. value)
      end
    end
  end
  self:RefreshTabCell()
end

function SettingCommunityDialog:OnDestroy(...)
  self._frame:Destroy()
end

function SettingCommunityDialog:RefreshTabCell()
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function SettingCommunityDialog:NumberOfCell(frame)
  return #self._cells
end

function SettingCommunityDialog:CellAtIndex(frame, index)
  return self._cells[index]
end

function SettingCommunityDialog:DataAtIndex(frame, index)
end

function SettingCommunityDialog:OnCell1BtnClick()
  SdkManager.GetAgent():ShowCustomerService("")
end

function SettingCommunityDialog:OnCell2BtnClick()
  SdkManager.OpenAccountCenter()
end

function SettingCommunityDialog:OnCell3BtnClick()
  CS.PixelNeko.Tools.ShareHelper.OpenURL(CCommunityCfg:GetRecorder(3).url)
end

function SettingCommunityDialog:OnCell4BtnClick()
  DialogManager.CreateSingletonDialog("systemsetting.settingcommunitywechatdialog")
end

function SettingCommunityDialog:OnCell5BtnClick()
  local plat = CS.PixelNeko.LuaManager.GetSystemType()
  local systemType = require("protocols.bean.protocol.common.systemtype")
  if plat == systemType.IOS then
    CS.PixelNeko.Tools.ShareHelper.OpenURL(CVarConfig:GetRecorder(20).Value)
  elseif plat == systemType.ANDROID then
    CS.PixelNeko.Tools.ShareHelper.OpenURL(CVarConfig:GetRecorder(19).Value)
  end
end

function SettingCommunityDialog:OnCell6BtnClick()
  CS.PixelNeko.Tools.ShareHelper.OpenURL(CCommunityCfg:GetRecorder(6).url)
end

function SettingCommunityDialog:OnCurPosChange(frame, proportion)
  local width, height = self._framePanel:GetRectSize()
  local total = self._frame:GetTotalLength()
  if height < total then
    self._scrollbar:SetScrollSize(height / total)
    self._scrollbar:SetScrollValue(1 - proportion)
  else
    self._scrollbar:SetScrollSize(1)
    self._scrollbar:SetScrollValue(proportion)
  end
end

return SettingCommunityDialog
