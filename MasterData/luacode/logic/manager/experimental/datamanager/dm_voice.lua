local DM_Voice = class("DM_Voice")

function DM_Voice:Ctor()
  self._data = NekoData.Data.voice
end

function DM_Voice:Clear()
end

return DM_Voice
