local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local BuffShowCell = class("BuffShowCell", Dialog)
BuffShowCell.AssetBundleName = "ui/layouts.setting"
BuffShowCell.AssetName = "SettingSystemBuffShow"

function BuffShowCell:Ctor(...)
  BuffShowCell.super.Ctor(self, ...)
  self._buffShowToggleList = {}
end

function BuffShowCell:OnCreate()
  for i = 1, 2 do
    self._buffShowToggleList[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
    self._buffShowToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
end

function BuffShowCell:OnDestroy()
end

function BuffShowCell:RefreshCell()
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  for i, v in ipairs(self._buffShowToggleList) do
    if i == sysConfig[SysConfigEnum.showBuff] + 1 then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

function BuffShowCell:OnValueChanged(index)
  if self._buffShowToggleList[index]:GetIsOnType() then
    local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.showBuff] + 1 then
      map.typeKey = SysConfigEnum.showBuff
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

return BuffShowCell
