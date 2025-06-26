-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/login/cupdateuisorttype.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CUpdateUISortType = dataclass("CUpdateUISortType", require("framework.net.protocol"))
CUpdateUISortType.ProtocolType = 1085
CUpdateUISortType.MaxSize = 65535
CUpdateUISortType.key = 0
CUpdateUISortType.Showtype = 0
CUpdateUISortType.ALL_ROLES = 1
CUpdateUISortType.EQUIPMENT_LIST = 2
CUpdateUISortType.SUPPORT_ROLE = 3
CUpdateUISortType.ROLE4SHOW = 4
CUpdateUISortType.QUICKSET_LINEUP = 5
CUpdateUISortType.ROLES_HANDBOOK = 6
CUpdateUISortType.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CUpdateUISortType
  ((CUpdateUISortType.super).Ctor)(self, client)
end

CUpdateUISortType.Marshal = function(self, buffer)
  -- function num : 0_1 , upvalues : ProtocolBufferStaticFunctions
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.key) then
    return false
  end
  if not (ProtocolBufferStaticFunctions.WriteInt32)(buffer, self.Showtype) then
    return false
  end
  return true
end

CUpdateUISortType.Unmarshal = function(self, buffer)
  -- function num : 0_2 , upvalues : ProtocolBufferStaticFunctions
  local ret = true
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  ret = (ProtocolBufferStaticFunctions.ReadInt32)(buffer)
  if not ret then
    return ret
  end
  return ret
end

return CUpdateUISortType

