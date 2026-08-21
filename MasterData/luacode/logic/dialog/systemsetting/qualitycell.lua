-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/qualitycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local QualityCell = class("QualityCell", Dialog)
QualityCell.AssetBundleName = "ui/layouts.setting"
QualityCell.AssetName = "SettingSystemQuality"
QualityCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : QualityCell
  ((QualityCell.super).Ctor)(self, ...)
  self._qualityToggleList = {}
end

QualityCell.OnCreate = function(self)
  -- function num : 0_1
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (self._qualityToggleList)[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
      ;
      ((self._qualityToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
end

QualityCell.OnDestroy = function(self)
  -- function num : 0_2
end

QualityCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, SysConfigEnum
  local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
  for i,v in ipairs(self._qualityToggleList) do
    if i == sysConfig[SysConfigEnum.quality] then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

QualityCell.OnValueChanged = function(self, index)
  -- function num : 0_4 , upvalues : _ENV, SysConfigEnum
  if ((self._qualityToggleList)[index]):GetIsOnType() then
    local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.quality] then
      map.typeKey = SysConfigEnum.quality
      map.typeValue = index
    end
    if map.typeKey and map.typeValue then
      ((NekoData.DataManager).DM_Game):SetSystemConfig({[map.typeKey] = map.typeValue})
      local cchangesysconfig = (LuaNetManager.CreateProtocol)("protocol.user.cchangesysconfig")
      -- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

      if cchangesysconfig then
        (cchangesysconfig.configs)[map.typeKey] = map.typeValue
        cchangesysconfig:Send()
      end
    end
  end
end

return QualityCell

