local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local ChatCell = class("ChatCell", Dialog)
ChatCell.AssetBundleName = "ui/layouts.setting"
ChatCell.AssetName = "SettingSystemChat"

function ChatCell:Ctor(...)
  ChatCell.super.Ctor(self, ...)
  self._chatToggleList = {}
end

function ChatCell:OnCreate()
  for i = 1, 3 do
    self._chatToggleList[i] = self:GetChild("ToggleGroup/_Toggle_" .. i - 1)
    self._chatToggleList[i]:Subscribe_ValueChangedEvent(function()
      self:OnValueChanged(i)
    end)
  end
end

function ChatCell:OnDestroy()
end

function ChatCell:RefreshCell()
  local sysConfig = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().sysConfig
  self._chatToggleList[1]:SetIsOnType(sysConfig[SysConfigEnum.sysChat] == 1)
  self._chatToggleList[2]:SetIsOnType(sysConfig[SysConfigEnum.worldChat] == 1)
  self._chatToggleList[3]:SetIsOnType(sysConfig[SysConfigEnum.guideChat] == 1)
end

function ChatCell:OnValueChanged(index)
  local key = SysConfigEnum.sysChat
  if index == 2 then
    key = SysConfigEnum.worldChat
  elseif index == 3 then
    key = SysConfigEnum.guideChat
  end
  local value = 0
  if self._chatToggleList[index]:GetIsOnType() then
    value = 1
  end
  NekoData.DataManager.DM_Game:SetSystemConfig({
    [key] = value
  })
  local cchangesysconfig = LuaNetManager.CreateProtocol("protocol.user.cchangesysconfig")
  if cchangesysconfig then
    cchangesysconfig.configs[key] = value
    cchangesysconfig:Send()
  end
end

return ChatCell
