---@class MailPanel : MailPanel_Generate
---##################### 【MailPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【MailPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local MailPanel = require "MailPanel_Generate"

function MailPanel:InitLogic(data)
    self.msgEventHandler = {
		{GameMsgType.MailListChange, self.refreshMailList},
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
	}
    self._mailOnIndex = 1   --当前打开的邮件序号
    self._favorOnIndex = 1  --当前打开的收藏序号

    self.m_maxMail = 300
    if Config.GetConfigInfo("MailMax") ~= nil then
        self.m_maxMail = Config.GetConfigInfo("MailMax")
    end
    --self.m_maxMail = 3
    self._mailList = {}
    self._favorList = {}
    self._mailBoxList = {}
    self._favorBoxList = {}
    self.isFavorMode = false
end

function MailPanel:refreshMailList(newMail)
    --self._mailList = {}
    --self._favorList = {}
    local mailsData = ClientData:GetMailList() or {}
    --处理收藏夹
    self._favorList = ClientData:getMailCollectCosData()
    if not self._favorList then
        self._favorList = {}
    end
    --LuaLogger.ds("^^^^^_favorList^^^^^", tablex.dump(self._favorList))
    for _, mailData in pairs(mailsData) do
        mailData.isFavor = false
        for _, favorData in pairs(self._favorList) do
            if mailData.id == favorData.id then
                mailData.isFavor = true
                break
            end
        end
    end

    ---邮件列表
    if newMail then
        self._mailList = tablex.toarray(mailsData)

        --按时间戳排序 然后批量删除上限删除邮件
        table.sort(self._mailList, function (a, b)
            return a.stamp > b.stamp
        end)
        while #self._mailList > self.m_maxMail do
            table.remove(self._mailList,1)                
        end
        self:sortMailsFunc()
    else
        if next(self._mailList) then
            for i = #self._mailList, 1, -1 do
                local isFind = false
                local newData = mailsData[self._mailList[i].id]
                if newData and next(newData) then
                    self._mailList[i] = newData
                    isFind = true
                end
                if not isFind then
                    table.remove(self._mailList, i)
                end
            end
        else
            self._mailList = tablex.toarray(mailsData)
        end
    end
    self:creatMailBox()
end

function MailPanel:sortMailsFunc()
    table.sort(self._mailList, function (a, b)
        local aHasReward = a.reward and true or false
        local bHasReward = b.reward and true or false
        
        -- 第一优先级：有奖励的排在没奖励的前面
        if aHasReward ~= bHasReward then
            return aHasReward
        end
        
        -- 第二优先级：状态数值小的排前面 (比如未读排在已读前)
        if a.state ~= b.state then
            return a.state < b.state
        end
        
        -- 第三优先级：时间戳大的排前面 (即越新的排越前)
        return a.stamp > b.stamp
    end)
end

function MailPanel:creatMailBox()
    self._mailBoxList = {}
    self._favorBoxList = {}
    self.mailsCount = #self._mailList
    -- self.noMail:SetActive(self.mailsCount == 0)

    self:FillTemplateContent(self.mailBox, self.inboxMailPanel.mailContent, self.mailsCount, function (index, mailBox)
        local mailData = self._mailList[index]
        self:refreshMailBox(mailData, index, mailBox, false)
        table.insert(self._mailBoxList, mailBox)
    end)

    table.sort(self._favorList, function (a, b)
        return a.stamp > b.stamp
    end)
    --收藏邮件上限
    while #self._favorList > self.m_maxMail do
        table.remove(self._favorList,1)                
    end

    ---收藏列表
    table.sort(self._favorList, function (a, b)
        if a.state < b.state then
            return true
        elseif a.state == b.state then
            return a.stamp > b.stamp
        end
        return false
    end)
    

    self.favorCount = #self._favorList
    self:FillTemplateContent(self.mailBox, self.favorMailPanel.mailContent, self.favorCount, function (index, mailBox)
        local mailData = self._favorList[index]
        self:refreshMailBox(mailData, index, mailBox, true)
        table.insert(self._favorBoxList, mailBox)
    end)

    if (self.isFavorMode) then
        self:favorToggle_Toggle_onValueChanged(self.favorToggle,true)
        --self:refreshMailDetail(self._favorList[self._favorOnIndex],true)
    else
        self:inboxToggle_Toggle_onValueChanged(self.inboxToggle,true)
        --self:refreshMailDetail(self._mailList[self._mailOnIndex],false)
    end
end

function MailPanel:openMail(mailData)
    local mailState = mailData.state
    if mailState == MailState.NotRead then
        local data = {
            id = mailData.id,
            action = MailState.Read
        }
        Me:mailActionReq(data)
    else
        self:refreshMailList()
    end 
end

function MailPanel:refreshMailBox(mailData, index, mailBox, isFavorBox)
    --LuaLogger.ds("^^^^^mailData^^^^^", tablex.dump(mailData))
    local onIndex = 0
    if (isFavorBox) then
        onIndex = self._favorOnIndex
    else
        onIndex = self._mailOnIndex
    end
    mailBox.mailTitleText.text.text = DLuaUtil.SetOverLengthStrToEllipsis(mailData.title, 18)
    mailBox.senderText.text.text = DLuaUtil.SetOverLengthStrToEllipsis(mailData.extra and mailData.extra.sender or "", 16)
    mailBox.scaleButton.onClick:RemoveAllListeners()
    mailBox.scaleButton.onClick:AddListener(function ()
        if (isFavorBox) then
            if self._favorOnIndex == index then
                return
            end
            self._favorOnIndex = index
        else
            if self._mailOnIndex == index then
                return
            end
            self._mailOnIndex = index
        end
        UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
        self:openMail(mailData)
    end)

    --根据状态设置显示
    mailBox.isOn:SetActive(index == onIndex)
    mailBox.isOff:SetActive(index ~= onIndex)
    local mailState = mailData.state
    mailBox.mailTitleText.text.color = index == onIndex and Color.NewFromStr("494949") or Color.NewFromStr("FFFFFF")
    mailBox.senderText.text.color = index == onIndex and Color.NewFromStr("858585") or Color.NewFromStr("BFBFBF")
    mailBox.deadlineText.text.color = index == onIndex and Color.NewFromStr("858585") or Color.NewFromStr("BFBFBF")
    mailBox.alphaGroup.canvasGroup.alpha = (index ~= onIndex and mailState ~= MailState.NotRead) and 0.5 or 1
    mailBox.alphaGroup.canvasGroup.alpha = (mailData.reward and mailState ~= MailState.Received) and 1 or mailBox.alphaGroup.canvasGroup.alpha
    -- mailBox.unRead:SetActive(mailState == MailState.NotRead)
    -- mailBox.isRead:SetActive(mailState == MailState.Read or mailState == MailState.Received)
    -- mailBox.receive:SetActive(mailData.reward and mailState ~= MailState.Received)
    -- mailBox.isGot:SetActive(mailData.reward and mailState == MailState.Received)

    local redPointState = mailState == MailState.NotRead or (mailData.reward and next(mailData.reward) and mailState ~= MailState.Received)
    if isFavorBox then
        redPointState = false
    end

    mailBox.redPoint:SetActive(redPointState)

    mailBox.isFavor:SetActive(mailData.isFavor)
    local typeIconPath

    if (mailData.reward) and next(mailData.reward) then
        if (mailState == MailState.Received) then
            typeIconPath = Config.SpritePath.MailTypePath.Rewarded
        else
            typeIconPath = Config.SpritePath.MailTypePath.Reward
        end

        if isFavorBox then
            typeIconPath = Config.SpritePath.MailTypePath.Rewarded
        end

    elseif (mailState == MailState.NotRead) then
        typeIconPath = Config.SpritePath.MailTypePath.NotRead
    else
        typeIconPath = Config.SpritePath.MailTypePath.Read
    end

    self:LoadSpriteAsync(typeIconPath, mailBox.typeIcon.image)

    if (isFavorBox) then
        mailBox.deadlineText.text.text = ""
    else
        --显示邮件时间
        local nowTime = math.modf(EngineUtil.ServerTime_Seconds())
        local dValue = (mailData.stamp + 2592000) - nowTime
        local oneDayToSecond = 24 * 60 * 60
        local oneHourToSecond = 3600
        if dValue > oneDayToSecond then
            local day = math.modf(dValue / (24 * 60 * 60))
            mailBox.deadlineText.text.text = day.."天后过期"
        elseif dValue < oneHourToSecond then
            local hour, min = DLuaUtil.SecondsToHourMinute(dValue, true)
            mailBox.deadlineText.text.text = min.."分钟后过期"
        else
            local hour, min = DLuaUtil.SecondsToHourMinute(dValue, true)
            mailBox.deadlineText.text.text = hour.."小时后过期"
        end
    end
    mailBox.transform.localPosition = Vector3.New(mailBox.transform.localPosition.x, mailBox.transform.localPosition.y, 0)
end

function MailPanel:refreshMailDetail(mailData,isFavorBox)
    if not mailData then
        self.mailDetail:SetActive(false)
        self.noMails:SetActive(true)
        return
    end
    -- self.mailDetail = ClientData:GetMailList()[self.mailID]
    self.mailDetail.mailTitleText.text.text = mailData.title
    self.mailDetail.senderText.text.text = mailData.extra and mailData.extra.sender
    self.mailDetail.desText.text.text = self:analysisMailContentTxt(mailData.content)
    -- self.mailDetail.desText.textLink:SetCallback(mailData.desText.text, function(linkID, linkData)
    --     if linkID == "Questionnaire" then
    --         Application.OpenURL("https://wj.qq.com/s2/13940019/1bcf/")
    --     end
    -- end)
    self.mailDetail.sendTimeText.text.text = DLuaUtil.TimeStampToTimeStr(mailData.stamp, false, 1)
    --奖励格子
    local attachmentsCount = mailData.reward and #mailData.reward or 0
    self:FillTemplateContent(self.customBox, self.mailDetail.attachments.attachmentContent, attachmentsCount, function (index, itemObj)
        local customBox = itemObj.customBox
        local rewardData = mailData.reward[index]

        customBox:setMono(self)
        customBox:SetUIData(rewardData, {isGet = mailData.state == MailState.Received})
    end)

    self.mailDetail.favorBtn:SetActive(not mailData.isFavor)
    self.mailDetail.isFavor:SetActive(mailData.isFavor)
    self.mailDetail.attachments:SetActive(attachmentsCount > 0)
    self.mailDetail.claimBtn:SetActive(attachmentsCount > 0 and mailData.state ~= MailState.Received)
    self.mailDetail.isGotBtn:SetActive(attachmentsCount > 0 and mailData.state == MailState.Received)

    --领取按钮设置
    -- self.getBtn:SetActive(self.mailDetail.reward and self.mailDetail.state ~= MailState.Received)
    -- self.isGotBtn:SetActive(self.mailDetail.reward and self.mailDetail.state == MailState.Received)

    self.mailDetail:SetActive(true)
    self.noMails:SetActive(false)
end

--邮件内容解析方法
function MailPanel:analysisMailContentTxt(content)
    -- 将所有的 <br> 替换成换行符 \n
    local newcontent = string.gsub(content or "", "<br>", "\n")
    return newcontent
end

---@param data CustomMsgData
function MailPanel:OpenCustomMsgPanel(data)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

--function MailPanel:StartCreating(time)
--
--end

--function MailPanel:StartEnter(time)
--
--end

--function MailPanel:StartRemoving(time)
--
--end

--function MailPanel:StartExit(time)
--
--end

function MailPanel:OnOpen(data, initiative)
    --导航栏
    RedPointMgr:SetRedDotState("NewMailRed", false)
    RedPointMgr:Refresh("MailBtnRedJudge")
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.MailPanel, self)
    self.customBackPanel.customBackPanel:OverrideBackFunc(function()
        self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
        self.animator:SetTrigger("Out")
        self.animOverCallBack:SetCallBack(function()
            UIMgr:closeUI(self)
            self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
        end)
        --清空返回方法
        self.customBackPanel.customBackPanel:ClearBackFunc()
    end)

    local mailsData = ClientData:GetMailList() or {}
    self._mailList = tablex.toarray(mailsData)
    self:sortMailsFunc()
    local mailData = self._mailList[1]
    if mailData then
        self:openMail(mailData)
    else
        self:creatMailBox()
    end
    --LuaLogger.ds("^^^^^mailCollect^^^^^", tablex.dump(Me.mailCollect))
end

--function MailPanel:OnClose(initiative)
--
--end

--function MailPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

-- function MailPanel:OnRefresh(data)

-- end

--[[
/BoxBg/MailBox onClick 
--]]
function MailPanel:mailBox_ScaleButton_onClick(mailBox)

end

--[[
/BoxBg/InboxMailPanel/BatchClaimBtn onClick 
--]]
function MailPanel:batchClaimBtn_ScaleButton_onClick(batchClaimBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if self.mailsCount == 0 then
        return
    end
    local data = {
        action = MailState.ReceiveAll
    }
    Me:mailActionReq(data)
end

--[[
/BoxBg/InboxMailPanel/MarkAllAsReadBtn onClick 
--]]
function MailPanel:markAllAsReadBtn_ScaleButton_onClick(markAllAsReadBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local data = {
        action = MailState.ReadAll
    }
    Me:mailActionReq(data)
end

--[[
/BoxBg/MailDetail/InboxMailDetail/ClaimBtn onClick 
--]]
function MailPanel:claimBtn_ScaleButton_onClick(claimBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    --领取邮件奖励
    local data = {
        id = self._mailList[self._mailOnIndex].id,
        action = MailState.Received
    }
    Me:mailActionReq(data)
end

--[[
/BoxBg/MailDetail/InboxMailDetail/DeteleMailBtn onClick 
--]]
function MailPanel:deteleMailBtn_ScaleButton_onClick(deteleMailBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUI("MsgBox", { title = "提示", 
        content = "删除的邮件<color=#FF0000>无法复原</color>，确认要删除吗？",
        type = MsgBoxType.OKCancel,
        okCallback = function()
            local data = {
                id = self._mailList[self._mailOnIndex].id,
                action = MailState.Deleted,
            }
            Me:mailActionReq(data)
        end,
    })
end

--[[
/BoxBg/MailDetail/FavorMailDetail/CancelFavorBtn onClick 
--]]
function MailPanel:cancelFavorBtn_ScaleButton_onClick(cancelFavorBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UIMgr:popUI("MsgBox", { title = "提示", 
        content = "取消收藏后邮件会<color=#FF0000>从收藏夹里消失</color>，\n确认要取消收藏吗？",
        type = MsgBoxType.OKCancel,
        okCallback = function()
            Me:mailCollectReq(self._favorList[self._favorOnIndex].id)
        end,
    })
end

--[[
/BoxBg/MailDetail/FavorBtn onClick 
--]]
function MailPanel:favorBtn_ScaleButton_onClick(favorBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    Me:mailCollectReq(self._mailList[self._mailOnIndex].id)
end

--[[
/CustomBackPanel/BackMainBtn onClick 
--]]
function MailPanel:backMainBtn_ScaleButton_onClick(backMainBtn)

end

--[[
/CustomBackPanel/HelpBtn onClick 
--]]
function MailPanel:helpBtn_ScaleButton_onClick(helpBtn)

end

--[[
/MailToggleGroup/InboxToggle onValueChanged 
--]]
function MailPanel:inboxToggle_Toggle_onValueChanged(inboxToggle,isOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if isOn then
        self.inboxMailPanel:SetActive(true)
        self.mailDetail.inboxMailDetail:SetActive(true)
        self.favorMailPanel:SetActive(false)
        self.mailDetail.favorMailDetail:SetActive(false)
        self.isFavorMode = false
        self:refreshMailDetail(self._mailList[self._mailOnIndex],false)
        for k, mailBox in pairs(self._mailBoxList) do
            mailBox.canvasGroup.alpha = 0
            DLuaTimer:DoAfter(0.05 * k, function()
                if UICommonUtils.Checkobj(mailBox) then
                    mailBox.canvasGroup:DOFade(1, 0.2)
                end
			end)
        end

        
        self.topLimitText.text.text = #self._mailBoxList.."/"..self.m_maxMail

    end
    inboxToggle.isOn:SetActive(isOn)
    inboxToggle.isOff:SetActive(not isOn)
end

--[[
/MailToggleGroup/FavorToggle onValueChanged 
--]]
function MailPanel:favorToggle_Toggle_onValueChanged(favorToggle,isOn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    if isOn then
        self.inboxMailPanel:SetActive(false)
        self.mailDetail.inboxMailDetail:SetActive(false)
        self.favorMailPanel:SetActive(true)
        self.mailDetail.favorMailDetail:SetActive(true)
        self.isFavorMode = true
        self:refreshMailDetail(self._favorList[self._favorOnIndex],true)
        for k, mailBox in pairs(self._favorBoxList) do
            mailBox.canvasGroup.alpha = 0
            DLuaTimer:DoAfter(0.05 * k, function()
                if UICommonUtils.Checkobj(mailBox) then
                    mailBox.canvasGroup:DOFade(1, 0.2)
                end
			end)
        end
        --TODO临时展示，目前没有邮件收藏上限
        local maxMail = 300
        if Config.GetConfigInfo("MailMax") ~= nil then
            maxMail = Config.GetConfigInfo("MailMax")
        end
        self.topLimitText.text.text = #self._favorBoxList.."/"..maxMail
    end
    favorToggle.isOn:SetActive(isOn)
    favorToggle.isOff:SetActive(not isOn)
end

return MailPanel
