-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/autobattlecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local AutoBattleCell = class("AutoBattleCell", Dialog)
AutoBattleCell.AssetBundleName = "ui/layouts.setting"
AutoBattleCell.AssetName = "SettingSystemAutoBattle"
AutoBattleCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AutoBattleCell
  ((AutoBattleCell.super).Ctor)(self, ...)
  self._autoBattleToggleList = {}
end

AutoBattleCell.OnCreate = function(self)
  -- function num : 0_1
  for i = 1, 2 do
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (self._autoBattleToggleList)[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
      ;
      ((self._autoBattleToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
end

AutoBattleCell.OnDestroy = function(self)
  -- function num : 0_2
end

AutoBattleCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, SysConfigEnum
  local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
  for i,v in ipairs(self._autoBattleToggleList) do
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

AutoBattleCell.OnValueChanged = function(self, index)
  -- function num : 0_4 , upvalues : _ENV, SysConfigEnum
  if ((self._autoBattleToggleList)[index]):GetIsOnType() then
    local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.autoBattleMode] + 1 then
      map.typeKey = SysConfigEnum.autoBattleMode
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

return AutoBattleCell

