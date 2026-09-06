local BM_Mail = class("BM_Mail")

function BM_Mail:Ctor()
  self._mail = NekoData.Data.mail
  self._dm = NekoData.DataManager.DM_Mail
end

function BM_Mail:GetMail()
  return self._mail
end

function BM_Mail:ChangeStatus(uniqueid)
  local mail = self._dm:ChangeStatus(uniqueid)
  if mail then
    LuaNotificationCenter.PostNotification(Common.n_MailInfoChange, BM_Mail, mail)
  end
end

return BM_Mail
