local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local AutoBattleCell = class("AutoBattleCell", Dialog)
AutoBattleCell.AssetBundleName = "ui/layouts.setting"
AutoBattleCell.AssetName = "SettingSystemAutoBattle"

function AutoBattleCell:Ctor(...)
  AutoBattleCell.super.Ctor(self, ...)
  self._autoBattleToggleList = {}
end

function AutoBattleCell:OnCreate()
  for i = 1, 2 do
    self._autoBattleToggleList[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
    self._autoBattleToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
end

function AutoBattleCell:OnDestroy()
end

function AutoBattleCell:RefreshCell()
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  for i, v in ipairs(self._autoBattleToggleList) do
    if not sysConfig[SysConfigEnum.autoBattleMode] then
      sysConfig[SysConfigEnum.autoBattleMode] = 0
    end
    if i == sysConfig[SysConfigEnum.autoBattleMode] + 1 then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

function AutoBattleCell:OnValueChanged(index)
  if self._autoBattleToggleList[index]:GetIsOnType() then
    local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.autoBattleMode] + 1 then
      map.typeKey = SysConfigEnum.autoBattleMode
      map.typeValue = index - 1
    end
    if map.typeKey and map.typeValue then
      NekoData.DataManager.DM_Game:SetSystemConfig({
        [map.typeKey] = map.typeValue
      })
      local cchangesysconfig = LuaNetManager.CreateProtocol("protocol.user.cchangesysconfig")
      if cchangesysconfig then
        cchangesysconfig.configs[map.typeKey] = map.typeValue
        cchangesysconfig:Send()
      end
    end
  end
end

return AutoBattleCell
