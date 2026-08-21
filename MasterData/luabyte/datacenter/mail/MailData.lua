local MailData = BaseClass("MailData")
local M = MailData
local tInsert = table.insert


function M:__init()
    self.m_mailInfo = nil
    self.m_mailCfg = nil
    self.m_items = nil --模板邮件才有的item
end

--邮件模板数据
function M:GetmailCfg()
    if self.m_mailInfo.MailId == 0 then
        return nil
    else
        if self.m_mailCfg == nil then
            self.m_mailCfg = ConfigHelper.GetCfg("mail",self.m_mailInfo.MailId)
        end
        return self.m_mailCfg
    end
end

--获取邮件类型 0：系统邮件 1：常规邮件
function M:GetmailType()
    if self.m_mailInfo.MailId == 0 then
        return 0
    else
        return 1
    end
end

function M:GetItem()
    if self.m_mailInfo.MailId > 0 then --模板邮件
        return self.m_items
    else
        return self.m_mailInfo.Items
    end
end

function M:GetTitle()
    return self.m_mailInfo.Title
end

function M:GetContent()
    return self.m_mailInfo.Content
end

function M:GetTime()
    return GameHelper.TimeStampToString(self.m_mailInfo.CreateTime,"yyyy/MM/dd HH:mm:ss")
end

function M:GetTimeStr()
    return TimeUtil.TimeStampToStringFormat(self.m_mailInfo.CreateTime,3)
end

function M:GetHasDay()
    return GameHelper.TimeStampToString(TimeUtil.GetNowTimeStamp()-self.m_mailInfo.CreateTime,"dd")
end

function M:GetTimeTick()
    return self.m_mailInfo.CreateTime
end

function M:GetShelfLife()
    local hasTime = self:GetHasDay()
    local lifeTime = 180 - tonumber(hasTime)
    return lifeTime
end

function M:GetSenderId()
    return self.m_mailInfo.SendId
end

function M:GetSenderName()
    return self.m_mailInfo.Nick
end

function M:GetTargetId()
    return self.m_mailInfo.TargetId
end

function M:Getstate()
    return self.m_mailInfo.State
end

function M:GetId()
    return self.m_mailInfo.Id
end

function M:SetInfo(info)
    self.m_mailInfo = info
    self.m_mailInfo.State = self:TranslateState(self.m_mailInfo.State)
    local temContent = ""
    if self.m_mailInfo.MailId == 0 then
        local Content = CS.System.Convert.FromBase64String(self.m_mailInfo.Content)
        self.m_mailInfo.Content = Content
        
        --把金币和钻搞到道具里面
        if self.m_mailInfo.Gold ~= nil and self.m_mailInfo.Gold ~= 0 then
            local goldItem = {Id =protocol.ECurrencyType.Gold,Cnt = self.m_mailInfo.Gold }
            tInsert(self.m_mailInfo.Items,goldItem)
        end

        if self.m_mailInfo.Coin ~= nil and self.m_mailInfo.Coin ~= 0 then
            local CoinItem = {Id =protocol.ECurrencyType.Coin,Cnt = self.m_mailInfo.Coin }
            tInsert(self.m_mailInfo.Items,CoinItem)
        end
    end
end

--设置模板邮件info
function M:SetInfoByTemplate(info)
    self:SetInfo(info)
    local infoContent = {}
    if info.Content ~= nil then
        infoContent = string.split(info.Content,",",0,false)
    end

    if self.m_mailCfg == nil then
        self.m_mailCfg = ConfigHelper.GetCfg("mail",info.MailId)
    end

    if self.m_mailCfg == nil then
        return nil
    end

    self.m_items = self.m_mailInfo.Items
    --模板道具不取表里的道具 取服务器给过来的数据
    -- self.m_items = {}

    -- local items = ConfigHelper.GetCfg("itemGroup",self.m_mailCfg.reward)
    -- if items ~= nil and items.FixedItems == nil then
    --     items.FixedItems = {}
    --     if items.items ~= nil and items.cnts ~= nil and items.weight ~= nil then
    --        for i = 1, #items.items do
    --         local temItem ={}
    --         temItem.ItemId = items.items[i]
    --         temItem.ItemCnt = items.cnts[i]
    --         tInsert(items.FixedItems,temItem)
    --        end
    --     end
    -- end



    -- local gold = 0
    -- local coin = 0 
    -- local itemLength = 0
    -- if items ~= nil and items.FixedItems ~= nil and table.count(items.FixedItems) > 0 then

    -- --     for index, value in ipairs(items.FixedItems) do
    -- --         --if value.ItemId ~= 1 and value.ItemId ~=5 then --金币和钻石单独记录 先都当道具给 看起来没啥问题
    -- --             if self.m_items[value.ItemId] == nil then
    -- --                 self.m_items[value.ItemId] = value.ItemCnt
    -- --             else
    -- --                 self.m_items[value.ItemId] =  self.m_items[value.ItemId] + value.ItemCnt
    -- --             end
    -- --     end
    -- -- end


    --     for i = 1, table.count(items.FixedItems) do
    --         local has = false
    --         for _, itemValue in pairs(self.m_items) do
    --             if itemValue.Id == items.FixedItems[i].ItemId then
    --                 itemValue.Cnt = itemValue.Cnt + items.FixedItems[i].ItemCnt
    --                 has = true
    --                 break
    --             end
    --         end
    --         if not has then
    --             local item = {Id = items.FixedItems[i].ItemId,Cnt = items.FixedItems[i].ItemCnt }
    --             tInsert(self.m_items,item)
    --         end
    --     end
    -- end

    local formatStr = nil 
    if self.m_mailInfo.MailId == 0 or self.m_mailCfg.type == 6  or self.m_mailCfg.type == 9 then  --非模板邮件或者道具提示邮件
        formatStr = CS.System.Convert.FromBase64String(infoContent[1])
    else
        formatStr = infoContent[1]
    end

    if self.m_mailCfg.type == 6 or self.m_mailCfg.type == 9 then--道具超过上限的提示 内容只有道具ID 需要读取item表替换、
        local item = ConfigHelper.GetCfg("item",tonumber(formatStr))
        if item then
            formatStr = ConfigHelper.GetLocalString(item.name)
        end
    end

    local contentText = ConfigHelper.GetLocalString(self.m_mailCfg.words)
    self.m_mailInfo.Content = string.format(contentText,formatStr)

    local titleText = ConfigHelper.GetLocalString(self.m_mailCfg.title)
    self.m_mailInfo.Title = titleText

    local nickName = ConfigHelper.GetLocalString(self.m_mailCfg.sendName)
    self.m_mailInfo.Nick = nickName

end

function M:GethasItem()
    return self.m_mailInfo ~= nil and self:GetItem() ~= nil and #self:GetItem()>0
end

function M:UpdateState(ms)
    self.m_mailInfo.State = ms
end

function M:TranslateState(state)
    if state == "MS_NEW" then
        return protocol.MailState.MS_NEW
    elseif state == "MS_OPEN" then
        return protocol.MailState.MS_OPEN
    elseif state == "MS_EXTRACT" then
        return protocol.MailState.MS_EXTRACT
    elseif state == "MS_DELETE" then
        return protocol.MailState.MS_DELETE
    else
        return state
    end
end


return MailData