-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/voicecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local SoundLevelTable = (BeanManager.GetTableByName)("setting.csoundlevel")
local VoiceCell = class("VoiceCell", Dialog)
VoiceCell.AssetBundleName = "ui/layouts.setting"
VoiceCell.AssetName = "SettingSystemVoice"
VoiceCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : VoiceCell
  ((VoiceCell.super).Ctor)(self, ...)
  self._voiceToggleList = {}
end

VoiceCell.OnCreate = function(self)
  -- function num : 0_1
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (self._voiceToggleList)[i] = self:GetChild("ToggleGroup/Toggle" .. i)
      ;
      ((self._voiceToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
end

VoiceCell.OnDestroy = function(self)
  -- function num : 0_2
end

VoiceCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, SysConfigEnum
  local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
  for i,v in ipairs(self._voiceToggleList) do
    if i == sysConfig[SysConfigEnum.dubbingNum] then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

VoiceCell.OnValueChanged = function(self, index)
  -- function num : 0_4 , upvalues : _ENV, SysConfigEnum, SoundLevelTable
  if ((self._voiceToggleList)[index]):GetIsOnType() then
    local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.dubbingNum] then
      map.typeKey = SysConfigEnum.dubbingNum
      map.typeValue = index
      local record = SoundLevelTable:GetRecorder(3)
      local num = tonumber((record.soundLevel)[index])
      if not num or num < tonumber((record.soundLevel)[1]) or (table.nums)(record.soundLevel) < num then
        num = (table.nums)(record.soundLevel)
      end
      ;
      (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber(num))
    end
    do
      if map.typeKey and map.typeValue then
        ((NekoData.DataManager).DM_Game):SetSystemConfig({[map.typeKey] = map.typeValue})
        local cchangesysconfig = (LuaNetManager.CreateProtocol)("protocol.user.cchangesysconfig")
        -- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

        if cchangesysconfig then
          (cchangesysconfig.configs)[map.typeKey] = map.typeValue
          cchangesysconfig:Send()
        end
      end
    end
  end
end

return VoiceCell

