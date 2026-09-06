local DM_Mail = class("DM_Mail")

function DM_Mail:Ctor()
  self._mail = NekoData.Data.mail
  self._mail.list = {}
  self._mail.maxNum = nil
  self._mail.currentNum = nil
end

function DM_Mail:Clear()
  for k, v in pairs(self._mail.list) do
    self._mail.list[k] = nil
  end
  self._mail.maxNum = nil
  self._mail.currentNum = nil
end

function DM_Mail:OnSSendMailList(protocol)
  self:Clear()
  self._mail.maxNum = protocol.maxNum
  self._mail.currentNum = #protocol.mails
  for index, mail in pairs(protocol.mails) do
    local newMail = {}
    newMail.uniqueId = mail.uniqueId
    newMail.id = mail.id
    newMail.title = mail.title:gsub("%$.-%$", mail.titleParameter)
    newMail.appellation = mail.appellation
    newMail.content = mail.content:gsub("%$.-%$", mail.contentParameter)
    newMail.signature = mail.signature
    newMail.mailType = mail.mailType
    newMail.receiveTime = mail.receiveTime
    newMail.deleteTime = mail.deleteTime
    newMail.status = mail.status
    newMail.questId = mail.questId
    newMail.attachmentList = {}
    for i, v in ipairs(mail.attachment.items) do
      table.insert(newMail.attachmentList, v)
    end
    if not self._mail.list[newMail.mailType] then
      self._mail.list[newMail.mailType] = {}
    end
    table.insert(self._mail.list[newMail.mailType], newMail)
  end
end

function DM_Mail:OnSSendNewMail(protocol)
  for index, mail in pairs(protocol.mails) do
    local newMail = {}
    newMail.uniqueId = mail.uniqueId
    newMail.id = mail.id
    newMail.title = mail.title:gsub("%$.-%$", mail.titleParameter)
    newMail.appellation = mail.appellation
    newMail.content = mail.content:gsub("%$.-%$", mail.contentParameter)
    newMail.signature = mail.signature
    newMail.mailType = mail.mailType
    newMail.receiveTime = mail.receiveTime
    newMail.deleteTime = mail.deleteTime
    newMail.status = mail.status
    newMail.questId = mail.questId
    newMail.attachmentList = {}
    for i, v in ipairs(mail.attachment.items) do
      table.insert(newMail.attachmentList, v)
    end
    if not self._mail.list[newMail.mailType] then
      self._mail.list[newMail.mailType] = {}
    end
    table.insert(self._mail.list[newMail.mailType], newMail)
    if not self._mail.currentNum then
      self._mail.currentNum = 0
    end
    self._mail.currentNum = self._mail.currentNum + 1
  end
end

function DM_Mail:OnSDeleteMails(protocol)
  local indexList = {}
  local num = 0
  for i, v in ipairs(protocol.uniqueIds) do
    for type, mailList in pairs(self._mail.list) do
      if not indexList[type] then
        indexList[type] = {}
      end
      for index, mail in ipairs(mailList) do
        if mail.uniqueId == v.uniqueId and v.result == 1 then
          indexList[type][index] = true
          num = num + 1
        end
      end
    end
  end
  local list = {}
  for type, mailList in pairs(self._mail.list) do
    if not list[type] then
      list[type] = {}
    end
    for index, mail in ipairs(mailList) do
      if not indexList[type][index] then
        table.insert(list[type], mail)
      end
    end
  end
  for type, mailList in pairs(self._mail.list) do
    while mailList[#mailList] do
      table.remove(mailList, #mailList)
    end
  end
  for type, mailList in pairs(list) do
    for index, mail in ipairs(mailList) do
      table.insert(self._mail.list[mail.mailType], mail)
    end
  end
  self._mail.currentNum = self._mail.currentNum - num
end

function DM_Mail:OnSReceiveMails(protocol)
  for i, v in ipairs(protocol.uniqueIds) do
    for type, mailList in pairs(self._mail.list) do
      for index, mail in ipairs(mailList) do
        if mail.uniqueId == v.uniqueId and v.result == 1 then
          if #mail.attachmentList == 0 then
            mail.status = 1
          else
            mail.status = 2
            mail.attachment = {}
          end
          if mail.id == 2456 or mail.id == DataCommon.ReturnBattlePass_MailId then
            mail.status = 3
          end
        end
      end
    end
  end
end

function DM_Mail:ChangeStatus(uniqueid)
  for type, mailList in pairs(self._mail.list) do
    for index, mail in ipairs(mailList) do
      if mail.uniqueId == uniqueid and mail.status == 0 then
        mail.status = 1
        return mail
      end
    end
  end
end

function DM_Mail:OnRefreshMailExpiryDate()
  for type, mailList in pairs(self._mail.list) do
    for index, mail in ipairs(mailList) do
      if mail.deleteTime ~= 0 then
        local expiryDate = mail.deleteTime - ServerGameTimer.GetServerTime()
        if 0 >= expiryDate - 1000 then
          local cdeleteOverdue = LuaNetManager.CreateProtocol("protocol.mail.cdeleteoverdue")
          if cdeleteOverdue then
            cdeleteOverdue:Send()
          end
        end
      end
    end
  end
end

return DM_Mail
