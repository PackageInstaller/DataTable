local ProtocolBufferStaticFunctions = CS.PixelNeko.Net.ProtocolBufferStaticFunctions
local HandbookType = dataclass("HandbookType")
HandbookType.EQUIP = 1
HandbookType.MONSTER = 2
HandbookType.ROLE = 3
HandbookType.NPC = 4
HandbookType.WORLD = 5
HandbookType.FORCE = 6
HandbookType.ACTIVITY = 7

function HandbookType:Ctor()
end

function HandbookType:Marshal(buffer)
  return true
end

function HandbookType:Unmarshal(buffer)
  local ret = true
  return ret
end

return HandbookType
