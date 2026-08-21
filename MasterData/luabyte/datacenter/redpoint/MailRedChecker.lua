local MailRedChecker = BaseClass("MailRedChecker",require("DataCenter.RedPoint.BaseRedPointChecker"))
local M = MailRedChecker

function M:__init()
    --self.dataCenterId = {EGetterID.Mail}    
    self.gameModel = protocol.EGameModel.ERoleGameMail
end

function M:Check(param)
    if not self:OnChanged(param) then
        return
    end
    --拉取过数据了
    if MailDataMgr:HasMailsData() then
        MailDataMgr:GetMails(Bind(self, self.CallBack))
    end
end

function M:CallBack(data)
    if GameHelper.bMailLock() then --未解锁
        self.checkResult = 0
        return
    end

    if data == nil then
        self.checkResult = 0
        return
    end

    local mailNum = 0;
    for k,v in pairs(data) do
        if (v:Getstate() == protocol.MailState.MS_NEW or (v:Getstate() ~= protocol.MailState.MS_EXTRACT and v:GethasItem())) then
            mailNum = mailNum + 1;
        end
    end
    self:SynchronizeServerRedPoint(mailNum)
    self.checkResult = mailNum
end

return MailRedChecker