---@class ActivitySignPanel : ActivitySignPanel_Generate
---##################### 【ActivitySignPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【ActivitySignPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local ActivitySignPanel = require "ActivitySignPanel_Generate"

function ActivitySignPanel:InitLogic(data)

    self.msgEventHandler = {
        {GameMsgType.ActivityPanelUpdate, self.refreshPanel},
    }
    self.timer2 = {}--定时器2
end

--function ActivitySignPanel:StartCreating(time)
--
--end

--function ActivitySignPanel:StartEnter(time)
--
--end

--function ActivitySignPanel:StartRemoving(time)
--
--end

--function ActivitySignPanel:StartExit(time)
--
--end

function ActivitySignPanel:OnOpen(data, initiative)
    self:refreshPanel(data, initiative)
end

function ActivitySignPanel:refreshPanel(data, initiative)
    self.activityCfg = data.cfg
    self:initData()
    self:refreshUI(initiative)

    if self.recoverDownTimer then
        DLuaTimer:RemoveTimer(self.recoverDownTimer)
    end
    self:UpdateTime()
    self.recoverDownTimer =  DLuaTimer:DoRepeatForeverIfValid(self.gameObject, 60, function()
        self:UpdateTime()
    end)
end

function ActivitySignPanel:initData()
    local signId = self.activityCfg.activityPara[1]
    local signData = Me:getSignDataById(signId)
    if not signData then
        LuaLogger.e("not signData signId:".. signId)
        return
    end
    self.curSignIndex = signData.signIndex
    self.activitySignMarkList = {0,0,0,0,0,0,0,0,0,0} --签到标记列表
    for _, valueIndex in ipairs(signData.alreadyAwards) do
        self.activitySignMarkList[valueIndex] = 1
    end
    local signCfg = Config.GetsignInInfo(signId)
    if not signCfg then
        LuaLogger.e("not signCfg")
        return
    end
    self.awardList = Config.GetSignAwardInfoByGroup(signCfg.awardGroud)
    if not self.awardList then
        LuaLogger.e("not awardList, id:".. signCfg.awardGroud)
        return
    end
end

function ActivitySignPanel:refreshUI(isInit)
    if not self.awardList then
        LuaLogger.e("not awardList")
        return
    end
    self:FillTemplateContent(self.signNode, self.content, tablex.size(self.awardList), function(index, signNode)
        signNode.index.text.text = "0"..index
        signNode.getMask:SetActive(self.activitySignMarkList[index] == 1)
        signNode.mark:SetActive(index <= self.curSignIndex and self.activitySignMarkList[index] == 0)
        signNode.tip:SetActive(index == self.curSignIndex + 1)
        signNode.sel:SetActive(index == self.curSignIndex)
        local awardInfo = self.awardList[index]
        if index == self.curSignIndex then
           signNode.index.text.color = Color.white
           signNode.dayText.text.color = Color.white
        else
            signNode.index.text.color = Color.black
            signNode.dayText.text.color = Color.black
        end
        --LuaLogger.e(tablex.dump(awardInfo))
        if awardInfo then
            for i = 1, 2 do
                local customBoxObj = signNode["customBox"..i]
                local rewardInfo = awardInfo.award[i]
                if rewardInfo then
                    customBoxObj:SetActive(true)
                    --[[local data = {
                        id = rewardInfo[2],
                        itemNum = rewardInfo[3],
                        itemType = GE.ItemTypeIndex.item,
						navType = GE.NavigationType.TaskPanel,
                    }]]
                    customBoxObj.customBox:setMono(self)
                    customBoxObj.customBox:SetUIData(rewardInfo, {navType = GE.NavigationType.TaskPanel})
                else
                    customBoxObj:SetActive(false)
                end
            end
        end
        signNode.scaleButton.onClick:RemoveAllListeners()
        signNode.scaleButton.onClick:AddListener(function()
            self:play2DSound(string.format(Config.AudioPath.SE, Config.GetInterfaceSoundInfo(10000).soundResource))
            if index <= self.curSignIndex and self.activitySignMarkList[index] == 0 then
                --请求签到
                Me:getSignRewardReq({signIndex = index, signId = self.activityCfg.activityPara[1]}, function(resp)
                    if resp.ret == 0 then
                        resp.list = resp.list or {}
                        Me:ReceiveReward(resp.list)
                        self:initData()
                        self:refreshUI()
                        GameMsgMgr:sendEvent(GameMsgType.RedPointRefresh, self.activityCfg.id)
                    end
                end)
            end
        end)
        --初始化格子单独动画
        if isInit then
            signNode.canvasGroup.alpha = 0
            local timer = DLuaTimer:DoAfter(0.05 * index, function()
                if signNode and signNode.canvasGroup then
                    signNode.canvasGroup.alpha = 0
                    signNode.canvasGroup:DOFade(1, 0.2)
                end
            end)
            table.insert(self.timer2, timer)
        end
    end)
    --排序动画
    if self.timers ~= nil then
        for k, v in pairs(self.timers) do
            DLuaTimer:RemoveTimer(v)
        end
    end
    self.timers = {}
    local timer = DLuaTimer:DoAfter(0.1, function()
        ---@type UnityEngine.UI.HorizontalLayoutGroup
        local hor = self.content.gameObject:GetComponent(TypeInfo.HorizontalLayoutGroup)

        local contentViewWidth = self.contentView.rectTransform.rect.width
        local contentWidth = self.content.rectTransform.sizeDelta.x

        if contentViewWidth > contentWidth then
            local c = contentViewWidth - contentWidth
            --hor.padding.left = hor.padding.left + c
            contentWidth = contentViewWidth
            UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.content.rectTransform)
        end
    end)
    table.insert(self.timers, timer)
    timer = nil
    if isInit and self.curSignIndex > 3 then
        timer = DLuaTimer:DoAfter(0.2, function()
            local width = self.content.rectTransform.sizeDelta.x
            local viewWidth = self.contentView.rectTransform.rect.width
            local w = width - viewWidth
            w = math.max(0, w)
            self.content.rectTransform.anchoredPosition = Vector2.New(-w , 0)
            self.content.rectTransform:DOAnchorPosX(-w, 0.5):SetEase(DG.Tweening.Ease.Linear)
        end)
        table.insert(self.timers, timer)
    end
end

function ActivitySignPanel:UpdateTime()
    local timeDiff = self.activityCfg.EndTime - Me.servertime
   
    local days = math.floor(timeDiff / 86400)
    local hours = math.floor((timeDiff % 86400) / 3600)
    local minutes = math.floor((timeDiff % 3600) / 60)
    if timeDiff < 86400 then
        self.time.text.text = hours.."时"..minutes.."分"
    else
        self.time.text.text = days.."天"..hours.."时"
    end
end

--function ActivitySignPanel:OnClose(initiative)
--
--end

function ActivitySignPanel:OnDestroy()
    if self.timers ~= nil then
        for k, v in pairs(self.timers) do
            DLuaTimer:RemoveTimer(v)
        end
    end
    self.timers = {}
    if self.timer2 ~= nil then
        for k, v in pairs(self.timer2) do
            DLuaTimer:RemoveTimer(v)
        end
    end
    self.timer2 = {}
    self.super:OnDestroy(self)
end

--function ActivitySignPanel:OnRefresh(data)
--
--end

--[[
/Bg/Scroll View/Viewport/Content/SignNode onClick 
--]]
function ActivitySignPanel:signNode_ScaleButton_onClick(signNode)

end

return ActivitySignPanel
