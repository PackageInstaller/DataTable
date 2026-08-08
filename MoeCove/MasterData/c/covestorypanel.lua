---@class CoveStoryPanel : CoveStoryPanel_Generate
---##################### 【CoveStoryPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【CoveStoryPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local CoveStoryPanel = require "CoveStoryPanel_Generate"
local DOGetter = DG.Tweening.Core.DOGetter_int
local DOSetter = DG.Tweening.Core.DOSetter_int
function CoveStoryPanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.MissionRefresh, self.MissionRefresh},
    }
end

--function CoveStoryPanel:StartCreating(time)
--
--end

--function CoveStoryPanel:StartEnter(time)
--
--end

--function CoveStoryPanel:StartRemoving(time)
--
--end

--function CoveStoryPanel:StartExit(time)
--
--end

-- {
--     roleId = int,
--     talkId = int         --对话id
--     exitCB = function    退出回调
-- }
function CoveStoryPanel:OnOpen(data, initiative)
    -- if initiative then
        self.exitCB = data.exitCB
        self.wordsText.text.uneditedText = ""
        self.nameText.text.uneditedText = ""
        --对话角色姓名
        self._roleId = data.roleId
        local roleInfo = Config.GetCharacterInfo(self._roleId)
        self.nameText.text.uneditedText = roleInfo.name
        self.sentenceList = {}
        self.length = 0
        local index = 0

        local talkList = {}
        if data.type == nil or data.type == 1 then
            local talkCfg = Config.GetHomeTouchWordsInfoByPassageId(data.talkId)
            table.sort(talkCfg, function(a, b)
                return a.id < b.id
            end)
            for k, v in pairs(talkCfg) do
                table.insert(talkList, v.wordsName)
            end
            Me:ReportHomelandCoveHeroInteractionReq(data.roleId, data.talkId)

            self:MissionRefresh()

        elseif data.type == 2 then
            local cfg = Config.GetHomeTouchReplyInfo(data.talkId)
            if cfg == nil then
               return 
            end
            talkList = {cfg.word}
        end

        local temp = ""
        for i = 1, #talkList do
            temp = temp .. talkList[i]
            self.wordsText.text.uneditedText = temp
            local count = self.wordsText.text:GetCharacterCount()
            self.sentenceList[i] = count
        end

        self.step = 1
        self.isOver = false
        self.maxStep = tablex.size(self.sentenceList)
        self:continueTalk()
    -- end
end


--点击下一句
function CoveStoryPanel:continueTalk()
    if self.tweener then
        self.tweener:Kill(true)
        self.tweener = nil
    end
    if self.isOver then
       return
    end

    local sv = 0
    local ev = self.sentenceList[self.step]
    if self.step - 1 > 0 then
       sv = self.sentenceList[self.step -1]
    end

    local duration = (ev - sv) * 0.05
    local tmp = self.wordsText.text
    self.tweener = DOTween.To(DOGetter(function()
        return sv
    end), DOSetter(function(x)
        sv = x
        tmp.maxVisibleCharacters = x
    end), ev, duration)
    self.tweener:SetEase(DG.Tweening.Ease.Linear)
    self.tweener:OnComplete(function()
        self.tweener = nil
        self.step = self.step + 1
        if self.step > self.maxStep then
            self.isOver = true
        end
    end)
end

function CoveStoryPanel:OnClose(initiative)
    if self.tweener then
        self.tweener:Kill()
        self.tweener = nil
    end
    if self.exitCB then
        self.exitCB()
        self.exitCB = nil
    end
end

function CoveStoryPanel:Exit()
    UIMgr:closeUI(self)
    if self.exitCB then
        self.exitCB()
        self.exitCB = nil
    end

    if self.showRewardList ~= nil then
        local data = self.showRewardList
        Me:ReceiveReward(data)
        self.showRewardList = nil
    end
end

--function CoveStoryPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function CoveStoryPanel:OnRefresh(data)
--
--end

--[[ 点击继续
/StoryScreen/StoryUIGroup/StoryWords/nextBtn onClick 
--]]
function CoveStoryPanel:nextBtn_Button_onClick(nextBtn)
    if self.isOver then
        self:Exit()
    else
        self:continueTalk()
    end
end

--[[
/Mask onClick  背景遮罩
--]]
function CoveStoryPanel:mask_Button_onClick(mask)
    if self.isOver then
        self:Exit()
    end
end

function CoveStoryPanel:MissionRefresh()

	local taskIds = {}
	local taskList = Me:getMissionList()
	for k, v in pairs(taskList) do
		local taskId = v.id
		local cfg = Config.GetTaskTableInfo(taskId)
		if cfg ~= nil and cfg.taskType == GE.MissionType.HomeLandEvent and v.state == GE.MissionState.Unclaimed then
            table.insert(taskIds, taskId)
		end
	end
    if #taskIds == 0 then
       return
    end

    DLuaTimer:DoAfter(0.1, function()
        Me:GetMissionRewardReq(taskIds, function(data)
            ---@type SubmitClaimMissionRewardResp
            local data = data
            if data.rewardList and next(data.rewardList) then
                self.showRewardList = data.rewardList
            end
        end, true)
    end)

end

return CoveStoryPanel
