local SSevenDaysOpenDef = LuaNetManager.GetProtocolDef("protocol.activity.ssevendaysopen")
local BM_SevenGrow = class("BM_SevenGrow")

function BM_SevenGrow:Ctor()
  self._sevengrow = NekoData.Data.sevengrow
end

function BM_SevenGrow:GetInitialRemainTime()
  return self._sevengrow.initialRemainTime
end

function BM_SevenGrow:GetStartTime()
  return self._sevengrow.startTime
end

function BM_SevenGrow:GetRemainTime()
  return self:GetInitialRemainTime() - (ServerGameTimer.GetServerTimeForecast() - self:GetStartTime())
end

function BM_SevenGrow:GetSevenDaysIsOpen()
  return self._sevengrow.sevenDaysIsOpen
end

function BM_SevenGrow:GetVersion()
  return self._sevengrow.version
end

function BM_SevenGrow:GetVersionIsNew()
  return self._sevengrow.version == SSevenDaysOpenDef.NEW_VERSION
end

return BM_SevenGrow
