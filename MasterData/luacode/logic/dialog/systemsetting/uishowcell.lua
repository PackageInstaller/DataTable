local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local UiShowCell = class("UiShowCell", Dialog)
UiShowCell.AssetBundleName = "ui/layouts.setting"
UiShowCell.AssetName = "SettingSystemUIShow"

function UiShowCell:Ctor(...)
  UiShowCell.super.Ctor(self, ...)
  self._uiShowToggleList = {}
end

function UiShowCell:OnCreate()
  for i = 1, 2 do
    self._uiShowToggleList[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
    self._uiShowToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
end

function UiShowCell:OnDestroy()
end

function UiShowCell:RefreshCell()
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  for i, v in ipairs(self._uiShowToggleList) do
    if i == sysConfig[SysConfigEnum.UIDisplay] + 1 then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

function UiShowCell:OnValueChanged(index)
  if self._uiShowToggleList[index]:GetIsOnType() then
    local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.UIDisplay] + 1 then
      map.typeKey = SysConfigEnum.UIDisplay
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

return UiShowCell
