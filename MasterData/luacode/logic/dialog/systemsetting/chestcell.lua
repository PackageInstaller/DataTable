local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local ChestCell = class("ChestCell", Dialog)
ChestCell.AssetBundleName = "ui/layouts.setting"
ChestCell.AssetName = "SettingSystemChest"

function ChestCell:Ctor(...)
  ChestCell.super.Ctor(self, ...)
  self._chestToggleList = {}
end

function ChestCell:OnCreate()
  for i = 1, 2 do
    self._chestToggleList[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
    self._chestToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
end

function ChestCell:OnDestroy()
end

function ChestCell:RefreshCell()
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  self._chestToggleList[1]:SetIsOnType(sysConfig[SysConfigEnum.boxOpen] == 0)
  self._chestToggleList[2]:SetIsOnType(sysConfig[SysConfigEnum.boxOpen] == 1)
end

function ChestCell:OnValueChanged(index)
  local key = SysConfigEnum.boxOpen
  local value = 1
  if self._chestToggleList[1]:GetIsOnType() then
    value = 0
  end
  NekoData.DataManager.DM_Game:SetSystemConfig({
    [key] = value
  })
  local cchangesysconfig = LuaNetManager.CreateProtocol("protocol.user.cchangesysconfig")
  if cchangesysconfig then
    cchangesysconfig.configs[key] = value
    cchangesysconfig:Send()
  end
end

return ChestCell
