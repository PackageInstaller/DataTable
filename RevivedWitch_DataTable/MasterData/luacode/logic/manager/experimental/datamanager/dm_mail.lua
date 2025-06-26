-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/datamanager/dm_mail.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DM_Mail = class("DM_Mail")
DM_Mail.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._mail = (NekoData.Data).mail
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._mail).list = {}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._mail).maxNum = nil
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._mail).currentNum = nil
end

DM_Mail.Clear = function(self)
  -- function num : 0_1 , upvalues : _ENV
  for k,v in pairs((self._mail).list) do
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R6 in 'UnsetPending'

    ((self._mail).list)[k] = nil
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._mail).maxNum = nil
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._mail).currentNum = nil
end

DM_Mail.OnSSendMailList = function(self, protocol)
  -- function num : 0_2 , upvalues : _ENV
  self:Clear()
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._mail).maxNum = protocol.maxNum
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (self._mail).currentNum = #protocol.mails
  for index,mail in pairs(protocol.mails) do
    local newMail = {}
    newMail.uniqueId = mail.uniqueId
    newMail.id = mail.id
    newMail.title = (mail.title):gsub("%$.-%$", mail.titleParameter)
    newMail.appellation = mail.appellation
    newMail.content = (mail.content):gsub("%$.-%$", mail.contentParameter)
    newMail.signature = mail.signature
    newMail.mailType = mail.mailType
    newMail.receiveTime = mail.receiveTime
    newMail.deleteTime = mail.deleteTime
    newMail.status = mail.status
    newMail.questId = mail.questId
    newMail.attachmentList = {}
    for i,v in ipairs((mail.attachment).items) do
      (table.insert)(newMail.attachmentList, v)
    end
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R8 in 'UnsetPending'

    if not ((self._mail).list)[newMail.mailType] then
      ((self._mail).list)[newMail.mailType] = {}
    end
    ;
    (table.insert)(((self._mail).list)[newMail.mailType], newMail)
  end
end

DM_Mail.OnSSendNewMail = function(self, protocol)
  -- function num : 0_3 , upvalues : _ENV
  for index,mail in pairs(protocol.mails) do
    local newMail = {}
    newMail.uniqueId = mail.uniqueId
    newMail.id = mail.id
    newMail.title = (mail.title):gsub("%$.-%$", mail.titleParameter)
    newMail.appellation = mail.appellation
    newMail.content = (mail.content):gsub("%$.-%$", mail.contentParameter)
    newMail.signature = mail.signature
    newMail.mailType = mail.mailType
    newMail.receiveTime = mail.receiveTime
    newMail.deleteTime = mail.deleteTime
    newMail.status = mail.status
    newMail.questId = mail.questId
    newMail.attachmentList = {}
    for i,v in ipairs((mail.attachment).items) do
      (table.insert)(newMail.attachmentList, v)
    end
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R8 in 'UnsetPending'

    if not ((self._mail).list)[newMail.mailType] then
      ((self._mail).list)[newMail.mailType] = {}
    end
    ;
    (table.insert)(((self._mail).list)[newMail.mailType], newMail)
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R8 in 'UnsetPending'

    if not (self._mail).currentNum then
      (self._mail).currentNum = 0
    end
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (self._mail).currentNum = (self._mail).currentNum + 1
  end
end

DM_Mail.OnSDeleteMails = function(self, protocol)
  -- function num : 0_4 , upvalues : _ENV
  local indexList = {}
  local num = 0
  for i,v in ipairs(protocol.uniqueIds) do
    for type,mailList in pairs((self._mail).list) do
      if not indexList[type] then
        indexList[type] = {}
      end
      for index,mail in ipairs(mailList) do
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R19 in 'UnsetPending'

        if mail.uniqueId == v.uniqueId and v.result == 1 then
          (indexList[type])[index] = true
          num = num + 1
        end
      end
    end
  end
  local list = {}
  for type,mailList in pairs((self._mail).list) do
    if not list[type] then
      list[type] = {}
    end
    for index,mail in ipairs(mailList) do
      if not (indexList[type])[index] then
        (table.insert)(list[type], mail)
      end
    end
  end
  for type,mailList in pairs((self._mail).list) do
    while mailList[#mailList] do
      (table.remove)(mailList, #mailList)
    end
  end
  for type,mailList in pairs(list) do
    for index,mail in ipairs(mailList) do
      (table.insert)(((self._mail).list)[mail.mailType], mail)
    end
  end
  -- DECOMPILER ERROR at PC105: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._mail).currentNum = (self._mail).currentNum - (num)
end

DM_Mail.OnSReceiveMails = function(self, protocol)
  -- function num : 0_5 , upvalues : _ENV
  for i,v in ipairs(protocol.uniqueIds) do
    for type,mailList in pairs((self._mail).list) do
      for index,mail in ipairs(mailList) do
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

DM_Mail.ChangeStatus = function(self, uniqueid)
  -- function num : 0_6 , upvalues : _ENV
  for type,mailList in pairs((self._mail).list) do
    for index,mail in ipairs(mailList) do
      if mail.uniqueId == uniqueid and mail.status == 0 then
        mail.status = 1
        return mail
      end
    end
  end
end

DM_Mail.OnRefreshMailExpiryDate = function(self)
  -- function num : 0_7 , upvalues : _ENV
  for type,mailList in pairs((self._mail).list) do
    for index,mail in ipairs(mailList) do
      if mail.deleteTime ~= 0 then
        local expiryDate = mail.deleteTime - (ServerGameTimer.GetServerTime)()
        if expiryDate - 1000 <= 0 then
          local cdeleteOverdue = (LuaNetManager.CreateProtocol)("protocol.mail.cdeleteoverdue")
          if cdeleteOverdue then
            cdeleteOverdue:Send()
          end
        end
      end
    end
  end
end

return DM_Mail

