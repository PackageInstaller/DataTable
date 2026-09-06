local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local SoundLevelTable = BeanManager.GetTableByName("setting.csoundlevel")
local VoiceCell = class("VoiceCell", Dialog)
VoiceCell.AssetBundleName = "ui/layouts.setting"
VoiceCell.AssetName = "SettingSystemVoice"

function VoiceCell:Ctor(...)
  VoiceCell.super.Ctor(self, ...)
  self._voiceToggleList = {}
end

function VoiceCell:OnCreate()
  for i = 1, 4 do
    self._voiceToggleList[i] = self:GetChild("ToggleGroup/Toggle" .. i)
    self._voiceToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
end

function VoiceCell:OnDestroy()
end

function VoiceCell:RefreshCell()
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  for i, v in ipairs(self._voiceToggleList) do
    if i == sysConfig[SysConfigEnum.dubbingNum] then
      v:SetIsOnType(true)
    else
      v:SetIsOnType(false)
    end
  end
end

function VoiceCell:OnValueChanged(index)
  if self._voiceToggleList[index]:GetIsOnType() then
    local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
    local map = {typeKey = nil, typeValue = nil}
    if index ~= sysConfig[SysConfigEnum.dubbingNum] then
      map.typeKey = SysConfigEnum.dubbingNum
      map.typeValue = index
      local record = SoundLevelTable:GetRecorder(3)
      local num = tonumber(record.soundLevel[index])
      if not num or num < tonumber(record.soundLevel[1]) or num > table.nums(record.soundLevel) then
        num = table.nums(record.soundLevel)
      end
      LuaAudioManager.SetCategoryVolume(tonumber(record.categoryID), tonumber(num))
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

return VoiceCell
