local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local QualityCell = class("QualityCell", Dialog)
QualityCell.AssetBundleName = "ui/layouts.setting"
QualityCell.AssetName = "SettingSystemQuality"

function QualityCell:Ctor(...)
  QualityCell.super.Ctor(self, ...)
  self._qualityToggleList = {}
end

function QualityCell:OnCreate()
  for i = 1, 3 do
    self._qualityToggleList[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
    self._qualityToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
end

function QualityCell:OnDestroy()
end

function QualityCell:RefreshCell()
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  for i, v in ipairs(self._qualityToggleList) do
    if i == sysConfig[SysConfigEnum.quality] then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

function QualityCell:OnValueChanged(index)
  if self._qualityToggleList[index]:GetIsOnType() then
    local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.quality] then
      map.typeKey = SysConfigEnum.quality
      map.typeValue = index
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

return QualityCell
