---@class MissionMsgPanel : MissionMsgPanel_Generate
---##################### 【MissionMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【MissionMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local MissionMsgPanel = require "MissionMsgPanel_Generate"

function MissionMsgPanel:InitLogic(data)
    self.missionId = 0      --任务id
    self.nowMissionType = 0 --任务类型
    self.nowBox = nil       --当前显示的box
end

--function MissionMsgPanel:StartCreating(time)
--
--end

function MissionMsgPanel:StartRemoving(time)
    self:HideAnimationByType()
end

function MissionMsgPanel:StartShowing(time)
    self:ShowAnimationByType()
end

---@class MissionMsgData
---@field id number 任务id

---@param data MissionMsgData
---@param initiative boolean 是否主动调用
function MissionMsgPanel:OnOpen(data, initiative)
    if initiative then
        self.missionId = data.id
        self:ShowBoxByType()
    end
end

--根据任务类型显示不同样式
function MissionMsgPanel:ShowBoxByType()
    local missionData = Config.GetTaskTableInfo(self.missionId)
    if not missionData then
        return
    end
    self.nowMissionType = missionData.taskType
    if self.nowMissionType == GE.MissionType.Achieve then
        self.nowBox = self.achievementBox
    else
        self.nowBox = self.normalBox
    end
    local taskSynopsis = missionData.TaskSynopsis
    if taskSynopsis then
        self.nowBox.finishTxt.text.text = taskSynopsis
        self.nowBox.finishTxt.text.color = Color.NewFromStr(GE.MissionMsgContentColor[self.nowMissionType])
        self.nowBox.tittleTxt.text.text = LocalStrEnum[GE.MissionMsgTitleStr[self.nowMissionType]]
    end
end

--根据任务类型播放不同弹出动画
function MissionMsgPanel:ShowAnimationByType()
    --根据系统类型判断   --来了看这里————————————————————————————————————
    local taskData = Me:getMissionListById(self.missionId)
    if taskData then
        if taskData.type == GE.MissionSystemType.task then
            if self.nowMissionType == GE.MissionType.Achieve then
                local showTime = 0.2
                self.mask.canvasGroup:DOFade(1, showTime)
                self.nowBox.rectTransform.anchoredPosition = Vector2.New(-800, 0)
                self.nowBox.rectTransform:DOAnchorPos(Vector2.New(0, 0), showTime)
                self.nowBox.canvasGroup:DOFade(1, showTime)
            else
                local showTime = 0.3
                if UICommonUtils.Checkobj(self.nowBox["typeBg"..self.nowMissionType]) then
                    self.nowBox["typeBg"..self.nowMissionType].canvasGroup.alpha = 1
                else
                    self.nowBox.typeBg1.canvasGroup.alpha = 1
                end
                self.nowBox.rectTransform.anchoredPosition = Vector2.New(0, 0)
                self.nowBox.rectTransform:DOAnchorPos(Vector2.New(0, -155), showTime)
                self.nowBox.canvasGroup:DOFade(1, showTime)
            end
        end
    end
end

--根据任务类型播放不同消失动画
function MissionMsgPanel:HideAnimationByType()
    if self.nowBox ~= nil then
        if self.nowMissionType == GE.MissionType.Achieve then
            local hideTime = 0.2
            self.nowBox.rectTransform:DOAnchorPos(Vector2.New(800, 0), hideTime)
            self.nowBox.canvasGroup:DOFade(0, hideTime)
            self.mask.canvasGroup:DOFade(0, hideTime)
        else
            local hideTime = 0.2
            self.nowBox.canvasGroup:DOFade(0, hideTime):OnComplete(function()
                if UICommonUtils.Checkobj(self.nowBox["typeBg"..self.nowMissionType]) then
                    self.nowBox["typeBg"..self.nowMissionType].canvasGroup.alpha = 0
                else
                    self.nowBox.typeBg1.canvasGroup.alpha = 0
                end
                self.nowBox.rectTransform.anchoredPosition = Vector2.New(0, -155)
            end)
        end
    end
end

--function MissionMsgPanel:OnClose(initiative)
--
--end

--function MissionMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function MissionMsgPanel:OnRefresh(data)
--
--end

return MissionMsgPanel
