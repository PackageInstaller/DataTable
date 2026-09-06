local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local OfflineType = dataclass("OfflineType")
OfflineType.LINK_OUTPUT_BUFFER_OVERFLOW = 94
OfflineType.XIO_CLOSE = 95
OfflineType.QUEUE_FULL = 96
OfflineType.SERVER_BUSY = 97
OfflineType.SERVER_FULL = 98
OfflineType.SERVER_REST = 99
OfflineType.LOG_OFF = 1
OfflineType.MULTI_PLAYER = 2
OfflineType.KICK = 3
OfflineType.GAME_PROTOCOL_DECODE_ERROR = 4
OfflineType.NO_SERVER_FOUND = 5
OfflineType.PROTOCOL_EXCEED = 6
OfflineType.HEART_OVERTIME = 7
OfflineType.SEND_PROTOCOL_FAILED = 8
OfflineType.ACTIVE_OVERTIME = 9
OfflineType.LINK_PROTOCOL_DECODE_ERROR = 10
OfflineType.PROTOCOL_CRC_ERROR = 11
OfflineType.GM = 12
OfflineType.ACTIVE_TRY_TIMES = 13
OfflineType.LOSE_CONNECTION_WHILE_DISPATCH_PROTOCOL = 14
OfflineType.NO_SERVER_TO_DISPATCH_PROTOCOL = 15
OfflineType.NO_SERVER_TO_LOGIN = 16
OfflineType.EXCEPTION_CLOSE = 17
OfflineType.PLAY_TIMEOUT = 18
OfflineType.LIMIT_PERIOD = 19
OfflineType.CUSTOMER_KICK = 20
OfflineType.FORBID_LOGIN = 21
OfflineType.FREQUENT_ENTER = 22
OfflineType.BREAK_WHEN_ENTER = 23
OfflineType.MOVE_ROLE = 24
OfflineType.NO_TICKET = 25
OfflineType.AU_SERVICE_NOT_FOUND = 26
OfflineType.LINK_LOGIN_AU_FAILED = 27
OfflineType.REGISTER_FULL = 28
OfflineType.RECEIVING_DATA = 29
OfflineType.ANTI_BLACK = 31
OfflineType.TIME_SPEED = 32

function OfflineType:Ctor()
end

function OfflineType:Marshal(buffer)
  return true
end

function OfflineType:Unmarshal(buffer)
  local ret = true
  return ret
end

return OfflineType
