-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/systemsetting/musiccell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local SoundLevelTable = (BeanManager.GetTableByName)("setting.csoundlevel")
local MusicCell = class("MusicCell", Dialog)
MusicCell.AssetBundleName = "ui/layouts.setting"
MusicCell.AssetName = "SettingSystemMusic"
MusicCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MusicCell
  ((MusicCell.super).Ctor)(self, ...)
  self._musicToggleList = {}
end

MusicCell.OnCreate = function(self)
  -- function num : 0_1
  for i = 1, 4 do
    do
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R5 in 'UnsetPending'

      (self._musicToggleList)[i] = self:GetChild("ToggleGroup/Toggle" .. i)
      ;
      ((self._musicToggleList)[i]):Subscribe_ValueChangedEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnValueChanged(i)
  end
)
    end
  end
end

MusicCell.OnDestroy = function(self)
  -- function num : 0_2
end

MusicCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV, SysConfigEnum
  local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
  for i,v in ipairs(self._musicToggleList) do
    if i == sysConfig[SysConfigEnum.musicNum] then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

MusicCell.OnValueChanged = function(self, index)
  -- function num : 0_4 , upvalues : _ENV, SysConfigEnum, SoundLevelTable
  if ((self._musicToggleList)[index]):GetIsOnType() then
    local sysConfig = (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.musicNum] then
      map.typeKey = SysConfigEnum.musicNum
      map.typeValue = index
      local record = SoundLevelTable:GetRecorder(1)
      local num = tonumber((record.soundLevel)[index])
      if not num or (table.nums)(record.soundLevel) < num then
        num = (table.nums)(record.soundLevel)
      end
      ;
      (LuaAudioManager.SetCategoryVolume)(tonumber(record.categoryID), tonumber(num))
    end
    do
      if map.typeKey and map.typeValue then
        ((NekoData.DataManager).DM_Game):SetSystemConfig({[map.typeKey] = map.typeValue})
        local cchangesysconfig = (LuaNetManager.CreateProtocol)("protocol.user.cchangesysconfig")
        -- DECOMPILER ERROR at PC76: Confused about usage of register: R5 in 'UnsetPending'

        if cchangesysconfig then
          (cchangesysconfig.configs)[map.typeKey] = map.typeValue
          cchangesysconfig:Send()
        end
      end
    end
  end
end

return MusicCell

