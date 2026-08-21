local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local CU = require("Common/ChatUtil")
local m_dungeonUid

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonCancel, function()
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonShareToWorld, function()
    ShareToChat(PB.enum.EChatChannel.World)
  end)
  WU.BindButtonEvent(REF.ButtonShareToGuild, function()
    ShareToChat(PB.enum.EChatChannel.Guild)
  end)
  WU.BindButtonEvent(REF.ButtonShareToPrivate, function()
    ShareToChat(PB.enum.EChatChannel.Private)
  end)
end

function SetDungeonUid(dungeonUid)
  m_dungeonUid = dungeonUid
end

function ShareToChat(channel)
  if m_dungeonUid ~= nil then
    CU.OnAsyncPvpVideoShare(channel, m_dungeonUid)
  end
end
