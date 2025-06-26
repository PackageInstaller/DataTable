-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/mail/sreceivemails.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Mail):OnSReceiveMails(protocol)
  local userInfo = {}
  userInfo.info = protocol.uniqueIds
  userInfo.tag = "sreceivemails"
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_MailInfoChange, DM_Mail, userInfo)
  if #protocol.role > 0 then
    local dialog = (DialogManager.CreateSingletonDialog)("gacha.gachamoviedialog")
    if dialog then
      dialog:DisplaySpecialCard(protocol.role, protocol.items)
    end
  else
    do
      if #protocol.items > 0 then
        ((NekoData.DataManager).DM_ItemAccountShow):AddShowDialogData({tag = (DataCommon.ShowDialogType).ItemAccount, data = protocol})
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

