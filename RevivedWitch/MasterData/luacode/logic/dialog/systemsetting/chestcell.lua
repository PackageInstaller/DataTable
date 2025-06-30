-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/chestcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local ChestCell = class("ChestCell", Dialog)
ChestCell.AssetBundleName = "ui/layouts.setting"
ChestCell.AssetName = "SettingSystemChest"
ChestCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChestCell
  ((ChestCell.super).Ctor)(self, ...)
  self._chestToggleList = {}
end

ChestCell.OnCreate = function(self)
  -- function num : 0_1
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (self._chestToggleList)[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
      ;
      ((self._chestToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
end

ChestCell.OnDestroy = function(self)
  -- function num : 0_2
end

ChestCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, SysConfigEnum
  local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
  ;
  ((self._chestToggleList)[1]):SetIsOnType(sysConfig[SysConfigEnum.boxOpen] == 0)
  ;
  ((self._chestToggleList)[2]):SetIsOnType(sysConfig[SysConfigEnum.boxOpen] == 1)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ChestCell.OnValueChanged = function(self, index)
  -- function num : 0_4 , upvalues : SysConfigEnum, _ENV
  local key = SysConfigEnum.boxOpen
  local value = 1
  if ((self._chestToggleList)[1]):GetIsOnType() then
    value = 0
  end
  ;
  ((NekoData.DataManager).DM_Game):SetSystemConfig({[key] = value})
  local cchangesysconfig = (LuaNetManager.CreateProtocol)("protocol.user.cchangesysconfig")
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

  if cchangesysconfig then
    (cchangesysconfig.configs)[key] = value
    cchangesysconfig:Send()
  end
end

return ChestCell

