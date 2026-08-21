local WU, DB = require("Common/WindowUtil")()
local CO = require("Common/Coroutine")
local S = require("Common/Singleton")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local m_configDataManager = S:Get("ConfigDataManager")
local PB = require("Common/PbHelper")
local m_cachedMails = {}
local MU = {}
CO.coroutine_call(function()
  local delay = CS.UnityEngine.WaitForSeconds(60)
  while true do
    local serverUtc = CS.GameTime.serverUtc
    for i = #m_cachedMails, 1, -1 do
      local mail = m_cachedMails[i]
      if MailTimeCheck(mail, serverUtc) then
        if MailExpireCheck(mail, serverUtc) then
          DBH.MailChange(mail)
        end
        table.remove(m_cachedMails, i)
      end
    end
    CO.yield_return(delay)
  end
end)()

function MU.SingleMail(result)
  local serverUtc = CS.GameTime.serverUtc
  if MailVersionCheck(result) and MailExpireCheck(result, serverUtc) then
    if MailTimeCheck(result, serverUtc) then
      DBH.MailChange(result)
    else
      table.insert(m_cachedMails, result)
    end
  end
end

function MailVersionCheck(mail)
  local versions = U.SplitStr(m_configDataManager.FullVersion(), ".")
  local mailVersions = U.SplitStr(mail.version, ".")
  local larger = true
  local len = math.max(#versions, 4)
  for i = 1, len do
    if tonumber(versions[i]) < tonumber(mailVersions[i] or 0) then
      larger = false
    end
  end
  return mail.version == nil or U.trim(mail.version) == "" or mail.version == "0" or larger
end

function MailTimeCheck(mail, serverUtc)
  return mail.startTime == nil or mail.startTime == 0 or serverUtc - mail.startTime >= 0
end

function MailExpireCheck(mail, serverUtc)
  return mail.expireTime - serverUtc > 1
end

function MU.OnMails(message)
  if message.clearAll then
    local mails = DB:GetData("fci/mail/") or {}
    for i = 1, #mails do
      DB:SetData("fci/mail/" .. mails[i].id, nil)
    end
    DB:SetData("fci/mail/", {})
  end
  if message.delMails then
    MU.RemoveFromDelayMails(message.delMails)
    DBH.MailRemoveBatch(message.delMails)
  end
  if message.mails then
    local serverUtc = CS.GameTime.serverUtc
    for _, mail in pairs(message.mails) do
      if MailVersionCheck(mail) and MailExpireCheck(mail, serverUtc) then
        if MailTimeCheck(mail, serverUtc) then
          DBH.MailChange(mail)
        else
          table.insert(m_cachedMails, mail)
        end
      end
    end
  end
end

function MU.RemoveFromDelayMails(delMails)
  for i = #m_cachedMails, 1, -1 do
    local mail = m_cachedMails[i]
    local f = table.find(delMails, function(_, v)
      return v == mail.id
    end)
    if f then
      table.remove(m_cachedMails, i)
    end
  end
end

function MU.MailCanReceive(showHint)
  local needLevel = PB.all("Misc"):first().mailAttachmentLevelLimit
  if needLevel > DB:GetData("fci/baseinfo/").level then
    if showHint then
      WU.ShowHintText(WU.GetString("WindowMail_NeedLevel", needLevel))
    end
    return false
  end
  return true
end

return MU
