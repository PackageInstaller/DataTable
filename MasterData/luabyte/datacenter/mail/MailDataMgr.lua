local MailDataMgr = BaseClass("MailDataMgr")
local M = MailDataMgr
local MessageId = Proto.MessageId
local tInsert = table.insert
local MS_NEW = 0
local MS_OPEN = 1
local MS_EXTRACT = 2
local MS_DELETE = 3

function M:__init(obj)
    self._responseLoadMails = NetPack:RegistResponse(MessageId.ResponseLoadMails, Bind(self, self.OnResponseLoadMail))
    self._notifyNewMail = NetPack:RegistResponse(MessageId.NotifyNewMail, Bind(self, self.OnResponseLoadMail))
    self._notifyRoleMail = NetPack:RegistResponse(MessageId.NotifyRoleMail, Bind(self, self.OnResponseLoadMail))
    self._responseOpenMails = NetPack:RegistResponse(MessageId.ResponseOpenMails, Bind(self, self.OnResponseOpenMail))
    self._responseOpenMail = NetPack:RegistResponse(MessageId.ResponseOpenMail, Bind(self, self.OnResponseOpenMail))
    self._responseDelMail = NetPack:RegistResponse(MessageId.ResponseDelMail, Bind(self, self.OnResponseDelMail))
    self._responseDelMails = NetPack:RegistResponse(MessageId.ResponseDelMails, Bind(self, self.OnResponseDelMail))
    
    self.m_mailDatas = nil
    self.m_getMailCallback = nil
end

function M:Cleanup()
    self.m_mailDatas = nil
    self.m_getMailCallback = nil
end

function M:Dispose()
    NetPack:UnRegistResponse(MessageId.ResponseLoadMails, self._responseLoadMails)
    NetPack:UnRegistResponse(MessageId.NotifyNewMail, self._notifyNewMail)
    NetPack:UnRegistResponse(MessageId.NotifyRoleMail, self._notifyRoleMail)
    NetPack:UnRegistResponse(MessageId.ResponseOpenMails, self._responseOpenMails)
    NetPack:UnRegistResponse(MessageId.ResponseOpenMail, self._responseOpenMail)
    NetPack:UnRegistResponse(MessageId.ResponseDelMail, self._responseDelMail)
    NetPack:UnRegistResponse(MessageId.ResponseDelMails, self._responseDelMails)
end

--获取自己本地的邮件数据
function M:GetMails(callback)
    if self.m_mailDatas == nil then
        self.m_getMailCallback = callback
        self:GetMail()
    else
        callback(self.m_mailDatas)
    end
end

--判断是否拉取过数据
function M:HasMailsData()
    return self.m_mailDatas ~= nil 
end

--请求打开邮件
function M:OpenMails(mailIds, extract)
    if mailIds == nil or #mailIds == 0 then
        return 
    end
    
    local request = {}
    
    if #mailIds == 1 then
    --打开单封邮件
        request.MailId = mailIds[1]
        request.Extract = extract
        NetPack:SendMessage(MessageId.RequestOpenMail, request)
    else
        request.MailIds = mailIds
        request.Extract = extract
        NetPack:SendMessage(MessageId.RequestOpenMails, request)
    end
end

--请求删除邮件
function M:DelMails(mailIds)
    if mailIds == nil or #mailIds == 0 then
        return 
    end
    
    local request = {}
    
    if #mailIds == 1 then
    --删除单封邮件
        request.MailId = mailIds[1]
        NetPack:SendMessage(MessageId.RequestDelMail, request)
    else
        request.MailIds = mailIds
        NetPack:SendMessage(MessageId.RequestDelMails, request)
    end
end

--请求拉取邮件数据
function M:GetMail(page)
    if page == nil or page == 0 then 
        page = 1 
    end
    if page == 1 then
        self.m_mailDatas = {}
    end
    
    local req = {}
    req.Page = page
    NetPack:SendMessage(MessageId.RequestLoadMails, req)
end

--更新邮件信息
function M:OnResponseLoadMail(messageId, result, msg)
    if result ~= 0 then 
        return
    end
    if messageId == MessageId.ResponseLoadMails then
    --加载所有邮件
        self.m_mailDatas = self.m_mailDatas or {}
        
        for key, value in pairs(msg.Mails) do
            if value.State ~= "MS_DELETE" then
                if value.MailId > 0 then
                --模板邮件
                    self:UpdateMailDataByTemplate(value)
                else
                    self:UpdateMailDataByNet(value)
                end
            end
        end
        local totalPage = math.ceil(msg.Total / msg.Count)
        if msg.Page < totalPage then 
            self:GetMail(msg.Page+1)
            return
        end
        if self.m_getMailCallback ~= nil then
            self.m_getMailCallback(self.m_mailDatas)
        end
        
        self.m_getMailCallback = nil
    else
        --OnNotifyNewMail / OnNotifyRoleMail
        if self.m_mailDatas == nil then
            return 
        end
        
        if messageId == MessageId.NotifyRoleMail then
            self:UpdateMailDataByNet(msg.Data)
        elseif messageId == MessageId.NotifyNewMail then
            self:UpdateMailDataByNet(msg.Mail)
        end
        
        local mailIds = {}
        tInsert(mailIds, msg.Mail.Id)
        EventMgr:Broadcast(UIMessageNames.SYSTEM_UPDATEMAILS, mailIds)

        --IRedPointMgr:ForceCheck(RedPointConst.MailRedChecker)
    end
end

function M:OnResponseOpenMail(messageId, result, msg)
    local results = nil
    local mailIds = {}
    local items = nil
    local error = false
    
    if messageId == MessageId.ResponseOpenMail then
        if  result ~= 0 then 
            return    
        end
    --单封
        if result ~= 0 then
            error = true
        else
            tInsert(mailIds, msg.MailId)
            
            if msg.Extract then
                self:GetMailDataById(msg.MailId):UpdateState(protocol.MailState.MS_EXTRACT)
            else
                self:GetMailDataById(msg.MailId):UpdateState(protocol.MailState.MS_OPEN)
            end
            
            items = msg.Data
        end
    elseif messageId == MessageId.ResponseOpenMails then
        if  result ~= 0 then 
            return    
        end

        --多封
        for _, value in pairs(msg.Results) do
            if value ~= 0 and value ~= 1 then
                error = true
                return 
            end
        end
        
        for _, value in pairs(msg.MailId) do
            tInsert(mailIds, value)
            
            if msg.Extract then
                self:GetMailDataById(value):UpdateState(protocol.MailState.MS_EXTRACT)
            else
                self:GetMailDataById(value):UpdateState(protocol.MailState.MS_OPEN)
            end
        end
        
        items = msg.Data
    end
    
    if error then
        return 
    end
    
    GameHelper.ShowGetItemsByItems(items,nil,false)
    EventMgr:Broadcast(UIMessageNames.SYSTEM_UPDATEMAILS, mailIds)
end

function M:OnResponseDelMail(messageId, result, msg)
    if  result ~= 0 then 
        return    
    end
    local mailIds = {}
    
    if messageId == MessageId.ResponseDelMail then
    --单封
        tInsert(mailIds, msg.MailId)
    elseif messageId == MessageId.ResponseDelMails then
        --多封
        mailIds = msg.MailIds
    end
    
    self:DelMailDataByNet(mailIds)
    EventMgr:Broadcast(UIMessageNames.SYSTEM_UPDATEMAILS, mailIds)
end

--更新邮件数据
function M:UpdateMailDatasByNet(mailInfos)
    for _, info in pairs(mailInfos) do
        if info.State ~= protocol.MailState.MS_EXTRACT then
            if info.MailId > 0 then
            --系统模板邮件
                self:UpdateMailDataByTemplate(info)
            else
                --正经邮件
                self:UpdateMailDataByNet(info)
            end
        end
    end
end

--依赖模板数据更新邮件数据
function M:UpdateMailDataByTemplate(mailinfo)
    local data = self:GetMailDataById(mailinfo.Id)
    
    if data == nil then
        data = require("DataCenter.Mail.MailData").New()
        self.m_mailDatas[mailinfo.Id] = data
        -- tInsert(self.m_mailDatas,mailinfo.Id,data)
    end
    
    data:SetInfoByTemplate(mailinfo)
end

--依赖网络协议更新邮件数据
function M:UpdateMailDataByNet(mailInfo)
    local data = self.m_mailDatas[mailInfo.Id]
    
    if data == nil then
        data = require("DataCenter.Mail.MailData").New()
    end
    
    if mailInfo.MailId > 0 then
    --系统模板邮件
        data:SetInfoByTemplate(mailInfo)
    else
        data:SetInfo(mailInfo)
    end
    
    self.m_mailDatas[mailInfo.Id] = data
end

--网络回调删除邮件
function M:DelMailDataByNet(ids)
    for _, id in pairs(ids) do
        local data = self.m_mailDatas[id]
        
        if data ~= nil then
            self.m_mailDatas[id] = nil
        end
    end
end

--获取本地邮件信息的某封邮件
function M:GetMailDataById(id)
    return self.m_mailDatas[id]
end

--IDataGetter start 
--用于在登录的时候初始化相关数据
function M:LoadData()
    self._isloading = true
    self._dataLoaded = false
    self._errorCode = 0
    self:GetMail()
    self._dataLoaded = true
    self._isloading = false
end

function M:IsLoading()
    return self._isloading
end

function M:IsReady()
    return self._dataLoaded
end

function M:ErrorCode()
    return self._isloading
end

--IDataGetter end 

return MailDataMgr
