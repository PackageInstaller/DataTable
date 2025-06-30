-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_mail.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_Mail = class("BM_Mail")
BM_Mail.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._mail = (NekoData.Data).mail
  self._dm = (NekoData.DataManager).DM_Mail
end

BM_Mail.GetMail = function(self)
  -- function num : 0_1
  return self._mail
end

BM_Mail.ChangeStatus = function(self, uniqueid)
  -- function num : 0_2 , upvalues : _ENV, BM_Mail
  local mail = (self._dm):ChangeStatus(uniqueid)
  if mail then
    (LuaNotificationCenter.PostNotification)(Common.n_MailInfoChange, BM_Mail, mail)
  end
end

return BM_Mail

