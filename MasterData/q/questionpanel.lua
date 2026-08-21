---@class QuestionPanel : QuestionPanel_Generate
---##################### 【QuestionPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【QuestionPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local QuestionPanel = require "QuestionPanel_Generate"

function QuestionPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.QnaireMapDataUpdate, self.RefreshQnaireMapDataUpdate},
    }
     self.toggleQuestList = {}
end

--function QuestionPanel:StartCreating(time)
--
--end

--function QuestionPanel:StartEnter(time)
--
--end

--function QuestionPanel:StartRemoving(time)
--
--end

--function QuestionPanel:StartExit(time)
--
--end

function QuestionPanel:OnOpen(data, initiative)

    MyPrefs:SetInt(GE.LocalCustomDataKey.QuestionPanelCustomDataKey.."QuestionPanel", DLuaUtil.GetLocalTime())
    RedPointMgr:Refresh("QuestionRedJudge")
    Me:getFunctionDataReq({GE.PushData.qnaireMap},function()
		self.m_qnaireServerMap = Me:getQnaireData()
        if initiative then

            self.toggleQuestList = {}
            self.questionnaireIdList = UICommonUtils.QuestionOpenList()
    
            self:FillTemplateContent(self.typeBtn, self.togglePanel, #self.questionnaireIdList, function(index, typeBtn)
                typeBtn:SetActive(true)
                typeBtn.isSelect:SetActive(false)
                typeBtn.typeTxt.text.text = "调查问卷"
                typeBtn.isSelect.typeTxt.text.text = "调查问卷"

                local questionnaireTableId = self.questionnaireIdList[index]
    
                local questionnaireTable = Config.GetQuestionnaireInfo(questionnaireTableId)
                
                local  qaireServerData = self:GetQnaireServerData(questionnaireTableId)
                local isRed = false
                local CodeidredState = MyPrefs:GetInt(GE.LocalCustomDataKey.QuestionPanelCustomDataKey..tostring(questionnaireTable.Codeid))
                if CodeidredState == 0 then
                    isRed = true
                end

                typeBtn.red:SetActive(isRed)
                typeBtn.scaleButton.onClick:RemoveAllListeners()
                typeBtn.scaleButton.onClick:AddListener(function()
                    self.m_selectQuestionIndex = index
                    self:RefreshSelectQuestionnaireView()
                end)
                table.insert(self.toggleQuestList,typeBtn)
                if index == #self.questionnaireIdList then
                    self:RefreshSelectQuestionnaireView()
                end
            end)
    
        end
    
        self.m_selectQuestionIndex = 1
        self:RefreshQnaireMapDataUpdate()
    end)
    
    

end

-- //调查问卷
-- message QnaireInfo {
--     int32 qnaireId = 1;   // 问卷id
--     bool isCompleted = 2;   // 是否已完成
--     bool isRewarded = 3;    // 是否已领奖
-- }
function QuestionPanel:RefreshSelectQuestionnaireView()

    for i, v in ipairs(self.toggleQuestList) do
        v.isSelect:SetActive(false)
    end
    if self.m_selectQuestionIndex > #self.toggleQuestList then
        self.m_selectQuestionIndex = 1
    end
    local selectTypeBtn = self.toggleQuestList[self.m_selectQuestionIndex]
    if not selectTypeBtn then
        return
    end
    
    selectTypeBtn.isSelect:SetActive(true)

    local questionnaireTableId = self.questionnaireIdList[self.m_selectQuestionIndex]
    
    local questionnaireTable = Config.GetQuestionnaireInfo(questionnaireTableId)

    local  qaireServerData = self:GetQnaireServerData(questionnaireTableId)

    local startTimeStamp = 0
    for i, value in ipairs(questionnaireTable.unlock) do
        if value[1] == 4 then
            startTimeStamp = value[2]
        end
    end
    local endTimeStamp = 0
    for i, value in ipairs(questionnaireTable.endCondition) do
        if value[1] == 4 then
            endTimeStamp = value[2]
        end
    end

    local startDateStr = os.date("%Y.%m.%d", startTimeStamp)
    local endDateStr = os.date("%Y.%m.%d", endTimeStamp)
    self.activeTimeText.text.text = "活动时间："..startDateStr.."-"..endDateStr

    self:RefreshRwd(questionnaireTable.Reward)

    self.getRewardBtn:SetActive(false)
    self.goWebBtn:SetActive(false)
    self.rewardedBtn:SetActive(false)

    if qaireServerData == nil then
        self.goWebBtn:SetActive(true)
    else
        if qaireServerData.isCompleted == false then
            self.goWebBtn:SetActive(true)
        else
            if qaireServerData.isRewarded == true then
                self.rewardedBtn:SetActive(true)

            else
                self.getRewardBtn:SetActive(true)
            end
        end
    end
    MyPrefs:SetInt(GE.LocalCustomDataKey.QuestionPanelCustomDataKey..tostring(questionnaireTable.Codeid), 1)
    if selectTypeBtn and selectTypeBtn.red then
        selectTypeBtn.red:SetActive(false)
    end
end

function QuestionPanel:GetQnaireServerData(questionnaireTableId)
    local questionnaireTable = Config.GetQuestionnaireInfo(questionnaireTableId)
    for k, value in pairs(self.m_qnaireServerMap) do
        if value.qnaireId == questionnaireTable.Codeid then
            return value
        end
    end
end
--function QuestionPanel:OnClose(initiative)
--
--end

--function QuestionPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function QuestionPanel:OnRefresh(data)
--
--end

--[[
/maskImg onClick 
--]]
function QuestionPanel:mask_Button_onClick(maskImg)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self:playCloseAnim()
end

--[[
/root/questingBtnGroup/getRewardBtn onClick 
--]]
function QuestionPanel:getRewardBtn_ScaleButton_onClick(getRewardBtn)
    local questionnaireTableId = self.questionnaireIdList[self.m_selectQuestionIndex]
    local questionnaireTable = Config.GetQuestionnaireInfo(questionnaireTableId)
    local  qaireServerData = self:GetQnaireServerData(questionnaireTableId)
    if qaireServerData.isCompleted == true and qaireServerData.isRewarded == false then
        
        Me:GetQnaireRewardReq({qnaireId = questionnaireTable.Codeid}, function(data)
            self:RefreshQnaireMapDataUpdate()
        end)
    end
end

--[[
/root/questingBtnGroup/goWebBtn onClick 
--]]
function QuestionPanel:goWebBtn_ScaleButton_onClick(goWebBtn)

    local questionnaireTableId = self.questionnaireIdList[self.m_selectQuestionIndex]
    local questionnaireTable = Config.GetQuestionnaireInfo(questionnaireTableId)
    local webUrl = questionnaireTable.WebUrl

    --questionnaireTable.id
    --webUrl = string.format(webUrl, 1, Me.uid)
    -- 判断 URL 是否已有参数，如果有则用 & 连接，否则用 ? 连接
    if string.find(webUrl, "?") then
        webUrl = webUrl.."&uid="..Me.uid
    else
        webUrl = webUrl.."?uid="..Me.uid
    end
    if GV.IsEditor then
        Application.OpenURL(webUrl)
    else
        UIMgr:popUICover("QuestionWebViewPanel", {url = webUrl})
    end

end

--[[
/root/questingBtnGroup/rewardedBtn onClick 
--]]
function QuestionPanel:rewardedBtn_ScaleButton_onClick(rewardedBtn)
    
end

--[[
/Custom/TypeBtn onClick 
--]]
function QuestionPanel:typeBtn_ScaleButton_onClick(typeBtn)

end

function QuestionPanel:RefreshRwd(rewardList)

    if rewardList and next(rewardList) then
        self:FillTemplateContent(self.rewardRt, self.itemRoot, tablex.size(rewardList), function(index, itemObj)
            local customBox = itemObj.reward.customBox
            --[[local data = {
                id = rewardList[index][2],
                itemType = GE.ItemTypeIndex.item,
                itemNum = rewardList[index][3],
				navType = GE.NavigationType.QuestionPanel,
            }]]
            customBox:setMono(self)
            customBox:SetUIData(rewardList[index], {navType = GE.NavigationType.QuestionPanel, tipsPassEventState = false})
        end)
    end
end

function QuestionPanel:RefreshQnaireMapDataUpdate()
    Me:getFunctionDataReq({GE.PushData.qnaireMap},function()
        self.m_qnaireServerMap = Me:getQnaireData()

        self:RefreshSelectQuestionnaireView()
    end)
end


function QuestionPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.animOverCallBack:SetCallBack(function()
        UIMgr:closeSpecificUI(self)
    end)
end

return QuestionPanel
