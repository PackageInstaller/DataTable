-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/uishowcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local UiShowCell = class("UiShowCell", Dialog)
UiShowCell.AssetBundleName = "ui/layouts.setting"
UiShowCell.AssetName = "SettingSystemUIShow"
UiShowCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UiShowCell
  ((UiShowCell.super).Ctor)(self, ...)
  self._uiShowToggleList = {}
end

UiShowCell.OnCreate = function(self)
  -- function num : 0_1
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (self._uiShowToggleList)[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
      ;
      ((self._uiShowToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
end

UiShowCell.OnDestroy = function(self)
  -- function num : 0_2
end

UiShowCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, SysConfigEnum
  local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
  for i,v in ipairs(self._uiShowToggleList) do
    if i == sysConfig[SysConfigEnum.UIDisplay] + 1 then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

UiShowCell.OnValueChanged = function(self, index)
  -- function num : 0_4 , upvalues : _ENV, SysConfigEnum
  if ((self._uiShowToggleList)[index]):GetIsOnType() then
    local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.UIDisplay] + 1 then
      map.typeKey = SysConfigEnum.UIDisplay
      map.typeValue = index - 1
    end
    if map.typeKey and map.typeValue then
      ((NekoData.DataManager).DM_Game):SetSystemConfig({[map.typeKey] = map.typeValue})
      local cchangesysconfig = (LuaNetManager.CreateProtocol)("protocol.user.cchangesysconfig")
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

      if cchangesysconfig then
        (cchangesysconfig.configs)[map.typeKey] = map.typeValue
        cchangesysconfig:Send()
      end
    end
  end
end

return UiShowCell

