local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local RockerCell = class("RockerCell", Dialog)
RockerCell.AssetBundleName = "ui/layouts.setting"
RockerCell.AssetName = "SettingSystemRocker"

function RockerCell:Ctor(...)
  RockerCell.super.Ctor(self, ...)
  self._rockerTypeToggleList = {}
end

function RockerCell:OnCreate()
  for i = 1, 2 do
    self._rockerTypeToggleList[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
    self._rockerTypeToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  self._rockerTypeToggleList[1]:SetIsOnType(sysConfig[SysConfigEnum.rockerType] == 1)
  self._rockerTypeToggleList[2]:SetIsOnType(sysConfig[SysConfigEnum.rockerType] == 0)
end

function RockerCell:OnDestroy()
end

function RockerCell:RefreshCell()
end

function RockerCell:OnValueChanged(index)
  local key = SysConfigEnum.rockerType
  local value
  if index == 1 then
    if self._rockerTypeToggleList[index]:GetIsOnType() then
      value = 1
    end
  elseif index == 2 and self._rockerTypeToggleList[index]:GetIsOnType() then
    value = 0
  end
  NekoData.DataManager.DM_Game:SetSystemConfig({
    [key] = value
  })
  LuaNotificationCenter.PostNotification(Common.n_RockerTypeChange, self, value)
  local cchangesysconfig = LuaNetManager.CreateProtocol("protocol.user.cchangesysconfig")
  if cchangesysconfig and value then
    cchangesysconfig.configs[key] = value
    cchangesysconfig:Send()
  end
end

return RockerCell
