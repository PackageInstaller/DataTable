local NpcChat = class("NpcChat")
NpcChat.E_Narratage = 0
NpcChat.E_Left = 1
NpcChat.E_Right = 2
NpcChat.E_Choice = 3

function NpcChat:Ctor(id, isBaseCharChat)
  self._chatId = id
  self._dialogCfg = BeanManager.GetTableByName("dialog.cdialogconfig")
  if isBaseCharChat then
    self._dialogCfg = BeanManager.GetTableByName("dialog.chomechatlist")
  end
  self._chatRecord = self._dialogCfg:GetRecorder(self._chatId)
end

function NpcChat:GetNpcName1()
  local name = self._chatRecord.NPC_Name[1] or ""
  name = string.gsub(name, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username)
  return name
end

function NpcChat:GetNpcName2()
  local name = self._chatRecord.NPC_Name[2] or ""
  name = string.gsub(name, "%$heroine%$", NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().username)
  return name
end

function NpcChat:GetChatType()
  return self._chatRecord.type
end

function NpcChat:GetNpcChatRecord()
  return self._chatRecord
end

function NpcChat:GetNpc1ShapeId()
  if self._chatRecord.NPC_id[1] then
    return self._chatRecord.NPC_id[1]
  end
  return 0
end

function NpcChat:GetNpc2ShapeId()
  if self._chatRecord.NPC_id[2] then
    return self._chatRecord.NPC_id[2]
  end
  return 0
end

function NpcChat:GetTime()
  return tonumber(self._chatRecord.time)
end

function NpcChat:GetCurrentChatTable()
  local nextDialogID = self._chatRecord.Dialog_id
  local nextChatTable = {}
  local diaIndex = 0
  for k, v in pairs(self._dialogCfg:GetAllIds()) do
    local rcd = self._dialogCfg:GetRecorder(v)
    if rcd.Dialog_id == nextDialogID then
      diaIndex = rcd.Dialog_id
      nextChatTable[rcd.index] = rcd
    end
  end
  return nextChatTable
end

function NpcChat:GetIdFromDialogID(dialogid)
  for k, v in pairs(self._dialogCfg:GetAllIds()) do
    local rcd = self._dialogCfg:GetRecorder(v)
    if rcd.Dialog_id == dialogid then
      return rcd
    end
  end
  return nil
end

function NpcChat:GetCurrentChatEndID()
  for k, v in pairs(self._dialogCfg:GetAllIds()) do
    local rcd = self._dialogCfg:GetRecorder(v)
    if rcd.Dialog_id == self._chatRecord.Dialog_id and rcd.Next_id ~= 0 then
      return rcd
    end
  end
  return nil
end

function NpcChat:GetVoiceId()
  return self._chatRecord.Voice_id
end

function NpcChat:GetSkipDestination()
  local current_group = self._chatRecord.Dialog_id
  local current_index = self._chatRecord.index
  local dest
  for _, i in ipairs(self._dialogCfg:GetAllIds()) do
    local record = self._dialogCfg:GetRecorder(i)
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

function NpcChat:GetJumpID()
  return self._chatRecord.jump_value
end

function NpcChat:ShouldShowBackground()
  return self._chatRecord.Background == 1
end

local function split_var_config(id)
  local value = BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(id).Value
  local scale = value:split(",")
  for i, v in pairs(scale) do
    scale[i] = tonumber(v)
  end
  return table.unpack(scale)
end

function NpcChat.GetLive2DGrayConfig()
  local a, r, g, b, x, y, z = split_var_config(2)
  return {
    a = a,
    r = r,
    g = g,
    b = b,
    x = x,
    y = y,
    z = z
  }
end

function NpcChat.GetImageGrayConfig()
  local a, r, g, b, x, y, z = split_var_config(3)
  return {
    a = a,
    r = r,
    g = g,
    b = b,
    x = x,
    y = y,
    z = z
  }
end

return NpcChat
