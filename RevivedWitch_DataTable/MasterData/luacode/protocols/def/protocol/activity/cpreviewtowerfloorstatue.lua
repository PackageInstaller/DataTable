-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/protocols/def/protocol/activity/cpreviewtowerfloorstatue.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ProtocolBufferStaticFunctions = ((CS.PixelNeko).Net).ProtocolBufferStaticFunctions
local CPreviewTowerFloorStatue = dataclass("CPreviewTowerFloorStatue", require("framework.net.protocol"))
CPreviewTowerFloorStatue.ProtocolType = 2434
CPreviewTowerFloorStatue.MaxSize = 65535
CPreviewTowerFloorStatue.Ctor = function(self, client)
  -- function num : 0_0 , upvalues : CPreviewTowerFloorStatue
  ((CPreviewTowerFloorStatue.super).Ctor)(self, client)
end

CPreviewTowerFloorStatue.Marshal = function(self, buffer)
  -- function num : 0_1
  return true
end

CPreviewTowerFloorStatue.Unmarshal = function(self, buffer)
  -- function num : 0_2
  local ret = true
  return ret
end

return CPreviewTowerFloorStatue

