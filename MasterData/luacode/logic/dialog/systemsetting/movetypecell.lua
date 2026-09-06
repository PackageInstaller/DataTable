local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local MoveTypeCell = class("MoveTypeCell", Dialog)
MoveTypeCell.AssetBundleName = "ui/layouts.setting"
MoveTypeCell.AssetName = "SettingSystemMove"

function MoveTypeCell:Ctor(...)
  MoveTypeCell.super.Ctor(self, ...)
  self._moveTypeToggleList = {}
end

function MoveTypeCell:OnCreate()
  for i = 1, 2 do
    self._moveTypeToggleList[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
    self._moveTypeToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  self._moveTypeToggleList[1]:SetIsOnType(sysConfig[SysConfigEnum.moveType] == 1)
  self._moveTypeToggleList[2]:SetIsOnType(sysConfig[SysConfigEnum.moveType] == 0)
end

function MoveTypeCell:OnDestroy()
end

function MoveTypeCell:RefreshCell()
end

function MoveTypeCell:OnValueChanged(index)
  local key = SysConfigEnum.moveType
  local value
  if index == 1 then
    if self._moveTypeToggleList[index]:GetIsOnType() then
      value = 1
    end
  elseif index == 2 and self._moveTypeToggleList[index]:GetIsOnType() then
    value = 0
  end
  NekoData.DataManager.DM_Game:SetSystemConfig({
    [key] = value
  })
  LuaNotificationCenter.PostNotification(Common.n_MoveTypeChange, self, value)
  local cchangesysconfig = LuaNetManager.CreateProtocol("protocol.user.cchangesysconfig")
  if cchangesysconfig and value then
    cchangesysconfig.configs[key] = value
    cchangesysconfig:Send()
  end
end

return MoveTypeCell
