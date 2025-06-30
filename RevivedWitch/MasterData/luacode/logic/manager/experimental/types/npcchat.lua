-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/types/npcchat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NpcChat = class("NpcChat")
NpcChat.E_Narratage = 0
NpcChat.E_Left = 1
NpcChat.E_Right = 2
NpcChat.E_Choice = 3
NpcChat.Ctor = function(self, id, isBaseCharChat)
  -- function num : 0_0 , upvalues : _ENV
  self._chatId = id
  self._dialogCfg = (BeanManager.GetTableByName)("dialog.cdialogconfig")
  if isBaseCharChat then
    self._dialogCfg = (BeanManager.GetTableByName)("dialog.chomechatlist")
  end
  self._chatRecord = (self._dialogCfg):GetRecorder(self._chatId)
end

NpcChat.GetNpcName1 = function(self)
  -- function num : 0_1 , upvalues : _ENV
  local name = ((self._chatRecord).NPC_Name)[1] or ""
  name = (string.gsub)(name, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username)
  return name
end

NpcChat.GetNpcName2 = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local name = ((self._chatRecord).NPC_Name)[2] or ""
  name = (string.gsub)(name, "%$heroine%$", (((NekoData.BehaviorManager).BM_Game):GetMyRoleInfo()).username)
  return name
end

NpcChat.GetChatType = function(self)
  -- function num : 0_3
  return (self._chatRecord).type
end

NpcChat.GetNpcChatRecord = function(self)
  -- function num : 0_4
  return self._chatRecord
end

NpcChat.GetNpc1ShapeId = function(self)
  -- function num : 0_5
  if ((self._chatRecord).NPC_id)[1] then
    return ((self._chatRecord).NPC_id)[1]
  end
  return 0
end

NpcChat.GetNpc2ShapeId = function(self)
  -- function num : 0_6
  if ((self._chatRecord).NPC_id)[2] then
    return ((self._chatRecord).NPC_id)[2]
  end
  return 0
end

NpcChat.GetTime = function(self)
  -- function num : 0_7 , upvalues : _ENV
  return tonumber((self._chatRecord).time)
end

NpcChat.GetCurrentChatTable = function(self)
  -- function num : 0_8 , upvalues : _ENV
  local nextDialogID = (self._chatRecord).Dialog_id
  local nextChatTable = {}
  local diaIndex = 0
  for k,v in pairs((self._dialogCfg):GetAllIds()) do
    local rcd = (self._dialogCfg):GetRecorder(v)
    if rcd.Dialog_id == nextDialogID then
      diaIndex = rcd.Dialog_id
      nextChatTable[rcd.index] = rcd
    end
  end
  return nextChatTable
end

NpcChat.GetIdFromDialogID = function(self, dialogid)
  -- function num : 0_9 , upvalues : _ENV
  for k,v in pairs((self._dialogCfg):GetAllIds()) do
    local rcd = (self._dialogCfg):GetRecorder(v)
    if rcd.Dialog_id == dialogid then
      return rcd
    end
  end
  return nil
end

NpcChat.GetCurrentChatEndID = function(self)
  -- function num : 0_10 , upvalues : _ENV
  for k,v in pairs((self._dialogCfg):GetAllIds()) do
    local rcd = (self._dialogCfg):GetRecorder(v)
    if rcd.Dialog_id == (self._chatRecord).Dialog_id and rcd.Next_id ~= 0 then
      return rcd
    end
  end
  return nil
end

NpcChat.GetVoiceId = function(self)
  -- function num : 0_11
  return (self._chatRecord).Voice_id
end

NpcChat.GetSkipDestination = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local current_group = (self._chatRecord).Dialog_id
  local current_index = (self._chatRecord).index
  local dest = nil
  for _,i in ipairs((self._dialogCfg):GetAllIds()) do
    local record = (self._dialogCfg):GetRecorder(i)
    if record.Dialog_id == current_group and current_index <= record.index then
      if record.skip == 0 then
        return i, false
      end
      if record.Next_id ~= 0 then
        current_group = record.Next_id
        current_index = 0
      else
        current_index = record.index
      end
      dest = i
    end
  end
  return dest, true
end

NpcChat.GetJumpID = function(self)
  -- function num : 0_13
  return (self._chatRecord).jump_value
end

NpcChat.ShouldShowBackground = function(self)
  -- function num : 0_14
  do return (self._chatRecord).Background == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local split_var_config = function(id)
  -- function num : 0_15 , upvalues : _ENV
  local value = (((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(id)).Value
  local scale = value:split(",")
  for i,v in pairs(scale) do
    scale[i] = tonumber(v)
  end
  return (table.unpack)(scale)
end

NpcChat.GetLive2DGrayConfig = function()
  -- function num : 0_16 , upvalues : split_var_config
  local a, r, g, b, x, y, z = split_var_config(2)
  return {a = a, r = r, g = g, b = b, x = x, y = y, z = z}
end

NpcChat.GetImageGrayConfig = function()
  -- function num : 0_17 , upvalues : split_var_config
  local a, r, g, b, x, y, z = split_var_config(3)
  return {a = a, r = r, g = g, b = b, x = x, y = y, z = z}
end

return NpcChat

