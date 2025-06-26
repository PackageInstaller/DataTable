-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/movetypecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local MoveTypeCell = class("MoveTypeCell", Dialog)
MoveTypeCell.AssetBundleName = "ui/layouts.setting"
MoveTypeCell.AssetName = "SettingSystemMove"
MoveTypeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MoveTypeCell
  ((MoveTypeCell.super).Ctor)(self, ...)
  self._moveTypeToggleList = {}
end

MoveTypeCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, SysConfigEnum
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (self._moveTypeToggleList)[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
      ;
      ((self._moveTypeToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
  local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
  ;
  ((self._moveTypeToggleList)[1]):SetIsOnType(sysConfig[SysConfigEnum.moveType] == 1)
  ;
  ((self._moveTypeToggleList)[2]):SetIsOnType(sysConfig[SysConfigEnum.moveType] == 0)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MoveTypeCell.OnDestroy = function(self)
  -- function num : 0_2
end

MoveTypeCell.RefreshCell = function(self)
  -- function num : 0_3
end

MoveTypeCell.OnValueChanged = function(self, index)
  -- function num : 0_4 , upvalues : SysConfigEnum, _ENV
  local key = SysConfigEnum.moveType
  local value = nil
  if index == 1 and ((self._moveTypeToggleList)[index]):GetIsOnType() then
    value = 1
  end
  if index == 2 and ((self._moveTypeToggleList)[index]):GetIsOnType() then
    value = 0
  end
  ;
  ((NekoData.DataManager).DM_Game):SetSystemConfig({[key] = value})
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_MoveTypeChange, self, value)
  local cchangesysconfig = (LuaNetManager.CreateProtocol)("protocol.user.cchangesysconfig")
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

  if cchangesysconfig and value then
    (cchangesysconfig.configs)[key] = value
    cchangesysconfig:Send()
  end
end

return MoveTypeCell

