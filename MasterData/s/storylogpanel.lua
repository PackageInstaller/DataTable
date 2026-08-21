---@class StoryLogPanel : StoryLogPanel_Generate
---##################### 【StoryLogPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【StoryLogPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local StoryLogPanel = require "StoryLogPanel_Generate"

function StoryLogPanel:InitLogic(data)
    --关闭界面需要执行的回调
    self.closeCallbackFunc = nil
    --内容列表
    self.dialogueLogList = {}
end

function StoryLogPanel:InitPanel()
    self:setLogData()
    self:initCloseAnimation()
end

--function StoryLogPanel:StartCreating(time)
--
--end

--function StoryLogPanel:StartEnter(time)
--
--end

--function StoryLogPanel:StartRemoving(time)
--
--end

--function StoryLogPanel:StartExit(time)
--
--end

---@class StoryLogOpenData
---@field closeCallback fun() 回调函数
---@field dialogueLog StoryLogData[] 事件触发次数

---@param data StoryLogOpenData 传入参数
---@param initiative boolean 首次打开界面
function StoryLogPanel:OnOpen(data, initiative)
    if initiative then
        self.closeCallbackFunc = data and data.closeCallback
        self.dialogueLogList = data and data.dialogueLog
        self:InitPanel()
    end
end

function StoryLogPanel:setLogData()
    self:FillTemplateContent(self.logBox, self.conent, #self.dialogueLogList, function(index, logBox)
        local dialogueData = self.dialogueLogList[index]
        logBox.selectNow:SetActive(index == #self.dialogueLogList and dialogueData.title ~= "")
        if index == #self.dialogueLogList then
            logBox.nameText.text.color = Color.NewFromStr("3EB5F7")
        else
            logBox.nameText.text.color = Color.NewFromStr("99B6C8")
        end
        logBox.nameText.text.text = self:setStoryRichText(logBox.nameText, dialogueData.title)
        logBox.worsText.text.text = self:setStoryRichText(logBox.worsText, dialogueData.content)
        logBox.voiceBtn:SetActive(dialogueData.voice and true or false)
        logBox.voiceBtn.scaleButton.onClick:RemoveAllListeners()
        logBox.voiceBtn.scaleButton.onClick:AddListener(function()
            self:playLogVoice(dialogueData.voice)
        end)
    end, function()
        --设置显示位置
        DLuaTimer:DoAfter(0.01, function()
            self.conent.rectTransform.anchoredPosition = Vector2.New(0,
            self.conent.rectTransform.sizeDelta.y - self.logPanel.rectTransform.sizeDelta.y)
        end)
    end)
end

---播放日志语音，支持多条语音同时播放，voice 格式为单个 id 或 "id1-id2-id3"
---@param voice any 语音 id 或以 "-" 分隔的多个 id 字符串
function StoryLogPanel:playLogVoice(voice)
    if not voice then return end
    for idStr in string.gmatch(tostring(voice), "[^-]+") do
        local voiceId = tonumber(idStr)
        if voiceId then
            local nowLineConfig = Config.GetScriptLinesInfo(voiceId)
            if nowLineConfig and nowLineConfig.resource then
                UICommonUtils.Play2DVoiceByLanguage(nowLineConfig.CharacterID, nowLineConfig.resource, nil, self.gameObject)
            end
        end
    end
end

--处理富文本
function StoryLogPanel:setStoryRichText(showObj, dialogue)
    if not dialogue then
        return "", false
    end
    --转译RubyText
    local isRuby = string.find(dialogue, "</ruby>")
    showObj.text.uneditedText = dialogue
    dialogue = showObj.text.text
    showObj.text.uneditedText = ""
    --替换玩家姓名
    dialogue = string.gsub(dialogue, "{PlayerName}", Me and Me.name or "{PlayerName}")
    for _, value in pairs(GE.StoryTextRegex) do
        dialogue = string.gsub(dialogue, value, "")
    end

    return dialogue, isRuby
end

--初始化关闭动画
function StoryLogPanel:initCloseAnimation()
    self.animOverCallBack:SetCallBack(function()
        if self.closeCallbackFunc then
            self.closeCallbackFunc()
        end
        UIMgr:closeSpecificUI(self)
    end)
end

--function StoryLogPanel:OnClose(initiative)
--
--end

--function StoryLogPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function StoryLogPanel:OnRefresh(data)
--
--end

--[[
/Bg onClick 
--]]
function StoryLogPanel:bg_Button_onClick(bg)
    if self.canvasGroup.interactable then
        self.animator.enabled = true
        self.animator:SetTrigger("Out")
        self.canvasGroup.interactable = false
    end
end

--[[
/Bg/CloseBtn onClick 
--]]
function StoryLogPanel:closeBtn_ScaleButton_onClick(closeBtn)
    if self.canvasGroup.interactable then
        self.animator.enabled = true
        self.animator:SetTrigger("Out")
        self.canvasGroup.interactable = false
    end
end

return StoryLogPanel
