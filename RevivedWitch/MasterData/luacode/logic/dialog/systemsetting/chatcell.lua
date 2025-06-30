-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/chatcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local ChatCell = class("ChatCell", Dialog)
ChatCell.AssetBundleName = "ui/layouts.setting"
ChatCell.AssetName = "SettingSystemChat"
ChatCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChatCell
  ((ChatCell.super).Ctor)(self, ...)
  self._chatToggleList = {}
end

ChatCell.OnCreate = function(self)
  -- function num : 0_1
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (self._chatToggleList)[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
      ;
      ((self._chatToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
end

ChatCell.OnDestroy = function(self)
  -- function num : 0_2
end

ChatCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, SysConfigEnum
  local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
  ;
  ((self._chatToggleList)[1]):SetIsOnType(sysConfig[SysConfigEnum.sysChat] == 1)
  ;
  ((self._chatToggleList)[2]):SetIsOnType(sysConfig[SysConfigEnum.worldChat] == 1)
  ;
  ((self._chatToggleList)[3]):SetIsOnType(sysConfig[SysConfigEnum.guideChat] == 1)
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

ChatCell.OnValueChanged = function(self, index)
  -- function num : 0_4 , upvalues : SysConfigEnum, _ENV
  local key = SysConfigEnum.sysChat
  if index == 2 then
    key = SysConfigEnum.worldChat
  else
    if index == 3 then
      key = SysConfigEnum.guideChat
    end
  end
  local value = 0
  if ((self._chatToggleList)[index]):GetIsOnType() then
    value = 1
  end
  ;
  ((NekoData.DataManager).DM_Game):SetSystemConfig({[key] = value})
  local cchangesysconfig = (LuaNetManager.CreateProtocol)("protocol.user.cchangesysconfig")
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

  if cchangesysconfig then
    (cchangesysconfig.configs)[key] = value
    cchangesysconfig:Send()
  end
end

return ChatCell

