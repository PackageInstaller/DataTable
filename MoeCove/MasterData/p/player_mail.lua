-- Desc: 社交数据处理
---@class Player
local Player = require "Player"
local GameGlobal, DataLogMgr
if GV.IsServer then
    GameGlobal = require "GameGlobal"
    DataLogMgr = require "DataLogMgr"
end


-- 获得邮件列表
---@return ActionFailReason 错误码
---@return table 邮件列表
---@return number 邮件时间戳
function Player:getMailList()
    --本地模式退出
    if not GameGlobal then
        return ActionFailReason.None, {}, 0
    end

    if self.mailLastStamp == 0 then
        self.mailLastStamp = -1
    end

    if not self.mailLastStamp then
        self.mailLastStamp = -1
    end

    --获取邮件列表
    local mails = GameGlobal.GetMailList(self.uid, self.mailLastStamp, true) or {}
    return ActionFailReason.None, mails, self.mailLastStamp
end

--创建新邮件
---@param mail MailInfo 邮件信息
-- {
--     title = "邮件标题",
--     content = "邮件内容",
--     reward = "邮件奖励",
--     sender = "发件人",
-- }
function Player:createNewMail(mail)
    --本地模式退出
    if not GameGlobal then
        return
    end

    mail.touid = self.uid

    --附加信息
    mail.mailExtra = mail.mailExtra or {}
    if mail.sender then
        mail.mailExtra.sender = mail.sender
    end

    local rewards = {}
	for i,v in ipairs(mail.reward or {}) do
		table.insert(rewards, {type = v[1], id = v[2], num = v[3]})
	end

    mail.reward = rewards

    local ret, err = GameGlobal.CreateNewMail(mail)
    if not ret then
        LuaLogger.es("CreateNewMail failed", err)
    end
end

--邮件操作
function Player:mailAction(action, mailId, userinfo)
    --本地模式退出
    if not GameGlobal then
        return ActionFailReason.Failed
    end

    --入参检测
    if not action or not mailId and not (action == MailState.ReceiveAll or action == MailState.DeleteAll or action == MailState.ReadAll) then
        return ActionFailReason.ParameterInvalid
    end

    --不可置为未读状态
    if action == MailState.NotRead then
        return ActionFailReason.ParameterInvalid
    end

    --邮件功能开启判断
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.Mailbox)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end

    local ret, reason, mail_ids = GameGlobal.MailAction(self.uid, mailId, action)
    local rewards

    if istable(ret) then -- 说明是奖励
        --奖励结构转换
        local award = self:rewardFormatConversion(ret)
        rewards = self:addRewardList(award, userinfo, GE.EventItemType.Mail, mailId)
    end

    if reason == ActionFailReason.None then
        if action == MailState.ReceiveAll then
            action = MailState.Received
        elseif action == MailState.DeleteAll then
            action = MailState.Deleted
        elseif action == MailState.ReadAll then
            action = MailState.Read
        end

        local mailList = {}
        for k, v in pairs(mail_ids) do
            local mail = 
            {
                id = v.id,
                state = action,
            }
            table.insert(mailList, mail)

            --日志
            if DataLogMgr then
                DataLogMgr.LogMailRecord({touid = self.uid, id = v.id, sysid = v.sysid, state = action},self)
            end
        end

        self:notifyDirect({"user.MailNtf", { mails = mailList }})
    end

    return reason, rewards
end

--------------------------------------------------------------------------------
--获得收藏邮件数据
---@return table<integer, MailCollectInfo>
function Player:getMailCollectData()
    return self.mailCollect
end

--获得某个收藏邮件的信息
---@param mailId integer 邮件ID
---@return MailCollectInfo 邮件列表
function Player:getMailCollectInfo(mailId)
    local mailCollect = self:getMailCollectData()

    if not mailCollect[mailId] then
        mailCollect[mailId] = {
            mailId = mailId,
            state = false,
            pathKey = "",
        }
    end

    return mailCollect[mailId]
end

--收藏邮件，此功能邮件数据隔离
---@param mailId integer 邮件ID
---@param proto UserInfo 玩家信息差量更新结构
---@return ActionFailReason 错误码
function Player:mailCollect1(mailId, proto)
    --本地模式退出
    if not GameGlobal then
        return ActionFailReason.Failed
    end

    if not mailId then
        return ActionFailReason.ParameterInvalid
    end

    --邮件功能开启判断
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.Mailbox)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end

    local mailInfo = GameGlobal.GetMailInfo(self.uid, mailId)
    if not mailInfo then
        return ActionFailReason.NoMail
    end

    --如果邮件已收藏，则改为未收藏
    local isCollect = false
    local mailCollectInfo = self:getMailCollectInfo(mailId)
    if not mailCollectInfo.state then
        isCollect = true
    end

    --收藏
    if isCollect then
        if mailCollectInfo.pathKey == "" then
            --上报存储桶
            self:putMailCollect(mailInfo, mailCollectInfo)
        else
            mailCollectInfo.state = true
        end
    --取消收藏
    else
        mailCollectInfo.state = false
    end

    --邮件收藏数据只在登录时推送一次
    -- if proto then
    --     if not proto.mailCollect then
    --         proto.mailCollect = {}
    --     end
    --     if isCollect then
    --         proto.mailCollect[mailId] = mailCollectInfo.pathKey
    --     else
    --         proto.mailCollect[mailId] = ""
    --     end
    -- end

    if DataLogMgr then
        DataLogMgr.LogMailRecord({touid = self.uid, id = mailId, sysid = mailInfo.sysid, collect = isCollect and 1 or 0},self)
    end

    return ActionFailReason.None

end


---刷新邮件数据(前端使用)
---@param data table 收藏key列表
function Player:updateMailCollectData(data)
    for id, key in pairs(data) do
        if not self.mailCollect then
            self.mailCollect = {}
        end
        if key == "" then
            self.mailCollect[id] = nil
        else
            self.mailCollect[id] = key
        end
    end
end

return Player