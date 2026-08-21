local FavorStoryCtrl = BaseClass("FavorStoryCtrl", BaseUICtrl)
local M = FavorStoryCtrl

function M:Init()
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.curFuritureData = DormHelper.GetCurrentFurnitureData()
    self.powerItems = {}

    for i = 1, 3 do
        local itemCtrl = require("UI.Ctrl.Dorm.PowerItemCtrl").New(self._view["PowerItem" .. i])
        self.powerItems[i] = itemCtrl
    end

    self.giftCtrl = require("UI.Ctrl.Dorm.DormStoryGiftCtrl").New(self._view.Gift)
    self.nextStepId = 0
    self.curStepId = 0
    self.speaker = 0
    self._view.Raycast.transform:onClick(Bind(self, self._OnClickNext))
    self._view.BtnSkip.transform:onClick(Bind(self, self._OnClickSkip)) 
    self.roomStorySelectCallback = EventMgr:AddListener(UIMessageNames.FAVOR_SELECT_ROOM_STORY,
        Bind(self, self._OnSelectRoomStory))
    self.isLockStory = false
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.context = self:GetContext()
end

function M:OnEnter(heroId, type, groupId, items, roomStoryLevel, action, closeCallback)
    self.dormAction.state = DormConst.RoleState.Story
    self.stroyList = OtakuHelper.GetFavorStoryByGroupId(groupId)
    self.heroId = heroId
    self.type = type
    self.roomStoryId = groupId
    self.items = items
    self.roomStoryLevel = roomStoryLevel
    self.closeCallback = closeCallback

    if self.stroyList then
        if self.type == DormConst.StoryType.TheatTaskStory or self.type == DormConst.StoryType.ActivityStory then
            self.isItemTask = self:CheckItemTask()
            self.isGiving = nil
        end
        self:SetStroy(self.stroyList[1])
    end
    if action then
        action()
    end
end

--设置剧情
function M:SetStroy(data)
    self.nextStepId = data.nextStepId[1]
    self.curStedpId = data.stepId
    self.curData = data
    if data.displayHero == 1 then
        DormHelper.EnableRenderers(true)
    else
        DormHelper.EnableRenderers(false)
    end
    if data.skipWords == 1 then
        self._view.BtnSkip:SetActive(true)
    else
        self._view.BtnSkip:SetActive(false)
    end 
    --提交道具任务
    if #self.curData.itemTask > 0 and (self.type == DormConst.StoryType.TheatTaskStory or self.type == DormConst.StoryType.ActivityStory)then
        self:SetItemTask(self.curData.itemTask)
        local itemDatas = self.context:GetItemDatas(self.itemTask)
        self.giftCtrl:OnEnter(self.type, itemDatas, self.itemTask, Bind(self, self.GivingCallback))
        self._view.Story:SetActive(false)
        self.isGiving = false
        self.isLockStory = true
    else
        --npc说话
        if data.speaker == 0 then
            --接入少女动作接口
            DormHelper.PlayActionById(self.curFuritureData, data.action)
            self._speaker = data.speaker
            self._view.txt_name:SetAvatarName(data.heroId, RoleType.ERT_Hero)
            local dialog = ConfigHelper.GetLocalStringByPlayerName(data.words[1])
            self._view.txt_dialog:SetDoTweenText(dialog)
            if self.type == DormConst.StoryType.roomStory and (#self.curData.favor > 0 or #self.curData.reward > 0) then
                self.rewardStepId = self.curStedpId
                self.selectIndex = 0
            end
        end
        --玩家说话
        if data.speaker == 1 then
            --玩家选项
            if #data.words > 1 then
                self.speaker = data.speaker
                self._view.CommandPanel:SetActive(true)
                for i = 1, 3 do
                    if data.words[i] then
                        self.powerItems[i]:Enable(true)
                        self.powerItems[i]:UpdateItem(data.words[i], data.nextStepId[i], i, self.type, nil)
                    else
                        self.powerItems[i]:Enable(false)
                    end

                end
            else
                local txt = ConfigHelper.GetLocalString(5159)
                self._view.txt_name:SetText(txt)
                self.speaker = data.speaker
                local dialog = ConfigHelper.GetLocalStringByPlayerName(data.words[1])
                self._view.txt_dialog:SetDoTweenText(dialog)
            end
        end

        --旁白说话
        if data.speaker == 2 then
            local txt = ConfigHelper.GetLocalString(1317)
            self._view.txt_name:SetText(txt)
            self.speaker = data.speaker
            local dialog = ConfigHelper.GetLocalStringByPlayerName(data.words[1])
            self._view.txt_dialog:SetDoTweenText(dialog)
        end
    end
end

--点击切换下一段对话
function M:_OnClickNext(go)
    if self._view.txt_dialog.textDoFinish == false then
        self._view.txt_dialog:ClickNext2()
    else
        self:NextStep()
    end
end

--点击跳过
function M:_OnClickSkip(go)
    --获取剩余剧情列表
    local remainStory = {}
    for key, value in pairs(self.stroyList) do
        if key > self.curStedpId then
            table.insert(remainStory, value)
        end
    end
    table.sort(remainStory, function(a,b) return a.stepId < b.stepId end)
    self.nextStepId = 0
    for i = 1, #remainStory do
        if remainStory[i].skipWords == 2 then
            self.nextStepId = remainStory[i].stepId
        end
    end
    self:NextStep()
end

function M:StoryCommit()
    self.isLockStory = true
    self.taskdata = TaskDataMgr:GetTaskData(TaskConst.TaskType.Theater, self.module.roomTask)
    if self.taskdata then
        --任务已完成未提交
        if self.taskdata.state == TaskConst.TaskState.MissionComplete then
            TaskDataMgr:RequestCompleteTask(self.module.roomTask, Bind(self, self.CompleteTaskCallback))
        end

        if self.taskdata.state == TaskConst.TaskState.TaskComplete then
            DormDataMgr:HeroEventStoryCommit(self.heroId, Bind(self, self.HeroEventStoryCommitCallBack))
        end
    end
end

function M:ActivityStoryCommit()
    self.isLockStory = true
    self.activityTaskData = TaskDataMgr:GetTaskData(TaskConst.TaskType.Theater, self.module.activityTask)
    if self.activityTaskData then
        --任务已完成未提交
        if self.activityTaskData.state == TaskConst.TaskState.MissionComplete then
            TaskDataMgr:RequestCompleteTask(self.module.activityTask, Bind(self, self.CompleteActivityTaskCallback))
        end

        if self.activityTaskData.state == TaskConst.TaskState.TaskComplete then
            DormPuzzleActivityDataMgr:GetInstance():FlipCardStoryCommit(Bind(self, self.ActivityEventStoryCommitCallBack))
        end 
    end
end

function M:CompleteTaskCallback(msg)
    DormDataMgr:HeroEventStoryCommit(self.heroId, Bind(self, self.HeroEventStoryCommitCallBack))
end

function M:CompleteActivityTaskCallback(msg)
    DormPuzzleActivityDataMgr:GetInstance():FlipCardStoryCommit(Bind(self, self.ActivityEventStoryCommitCallBack))
end

function M:_LookRoomStoryBack(msg)
    GameHelper.ShowGetItemsByItems(msg.Awards, Bind(self, self.CloseStory))
end

function M:_LookStageStoryBack(msg)
    self:CloseStory()
end

function M:ActivityEventStoryCallBack(msg)
    --英雄触发小剧场任务回调(接取任务)
    self.module.activityEvent = msg.EventId
    self.module.activityEventType = msg.EventType
    self.module.activityTask = DormPuzzleActivityDataMgr:GetInstance():GetActivityTask()
    self:CloseStory()
end

--英雄触发小剧场任务回调(接取任务)
function M:HeroEventStoryCallBack(msg)
    --更新数据
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.heroId)
    if not IsNull(rshd) then
        rshd:UpdateEventNode(msg.EventId)
        rshd:UpdateEventNodeType(msg.EventType)
        self.module.roomEvent = msg.EventId
        self.module.roomEventType = msg.EventType
        self.module.roomTask = DormHelper.GetDormTask(self.heroId)
    end
    UIContextMgr:GetInstance():Show("DormitoryTheaterPopup", self.module.roomTask, Bind(self, self.CloseStory))
end

--英雄小剧场领奖回调
function M:HeroEventStoryCommitCallBack(msg)
    --清空任务
    self.module.roomEventType = 0
    self.module.roomEvent = 0
    self.module.roomTask = 0
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.heroId)
    if not IsNull(rshd) then
        rshd:UpdateEventNode(0)
        rshd:UpdateEventNodeType(0)
        rshd:UpdateEventLevel(msg.EventLevel)
    end
    GameHelper.ShowGetItemsByItems(msg.Awards, Bind(self, self.CloseStory))
end

--活动小剧场领奖回调
function M:ActivityEventStoryCommitCallBack(msg)
    --清空任务
    self.module.activityEventType = 0
    self.module.activityEvent = 0
    self.module.activityTask = 0
    GameHelper.ShowGetItemsByItems(msg.Awards, Bind(self, self.CloseStory))
end

--回礼剧情领奖回调
function M:GetRepresentAwardCallBack(msg)
    GameHelper.ShowGetItemsByItems(msg.Awards, Bind(self, self.CloseStory))
end

--固定时段触发剧情领奖回调
function M:GetRepresentFixedAwardCallback(msg)
    GameHelper.ShowGetItemsByItems(msg.Awards, Bind(self, self.CloseStory))
end

function M:CloseStoryEnterGift(...)
    UIContextMgr:GetInstance():Show("DormGift", self.heroId, function()
        UIContextMgr:GetInstance():Show("Dorm", self.module.roleStudio)
        DormHelper.RoleAfk(true)
    end)
    self:Close()
end

function M:CloseStory()
    UIContextMgr:GetInstance():Show("Dorm", self.module.roleStudio)
    self:Close()
end

function M:_OnSelectRoomStory(nextStepId, skip, index)
    --关闭选择界面
    self._view.CommandPanel.gameObject:SetActive(false)
    self.nextStepId = nextStepId
    if self.type == DormConst.StoryType.roomStory and (#self.curData.favor > 0 or #self.curData.reward > 0) then
        self.rewardStepId = self.curStedpId
        self.selectIndex = index - 1
    end
    self:NextStep()
end

function M:NextStep()
    --没有下一步关闭界面
    if self.nextStepId == 0 then
        --升级剧情结束领取奖励
        if self.type == DormConst.StoryType.roomStory and self.isLockStory == false then
            self.isLockStory = true
            DormDataMgr:LookHeroFeelingLevelStory(self.heroId, self.roomStoryLevel, self.rewardStepId, self.selectIndex,
                Bind(self, self._LookRoomStoryBack))
            return
        end

        if self.type == DormConst.StoryType.TheatTaskStory and self.isLockStory == false then
            if self.isItemTask == true then
                if self.isGiving == true then
                    UIContextMgr:GetInstance():Show("DormitoryTheaterPopup", self.module.roomTask,
                        Bind(self, self.CloseStory))
                    return
                end
            else
                self.isLockStory = true
                DormDataMgr:HeroEventStoryTrigger(self.heroId, self.module.roomEventType + 1, self.module.roomEvent,
                    Bind(self, self.HeroEventStoryCallBack))
                return
            end
        end

        if self.type == DormConst.StoryType.TheatRewardStory and self.isLockStory == false then
            self:StoryCommit()
            return
        end

        --回礼剧情
        if self.type == DormConst.StoryType.PresentReturnStory and self.isLockStory == false then
            self.isLockStory = true
            PresentReturnDataMgr:RequestGetRepresentAward(self.heroId, Bind(self, self.GetRepresentAwardCallBack))
            return
        end

        --固定时段触发剧情
        if self.type == DormConst.StoryType.PresentFixedStory and self.isLockStory == false then
            self.isLockStory = true
            PresentReturnDataMgr:RequestRepresentFixedReward(self.module.representFixedInfo.EventId, Bind(self, self.GetRepresentFixedAwardCallback))
            return
        end

        --宿舍活动剧情
        if self.type == DormConst.StoryType.ActivityStory and self.isLockStory == false then
            if self.isItemTask == true then
                if self.isGiving == true then
                    self:CloseStory()
                    return
                end
            else
                self.isLockStory = true
                DormPuzzleActivityDataMgr:GetInstance():FlipCardStoryTrigger(self.module.activityEventType + 1, Bind(self, self.ActivityEventStoryCallBack))
                return
            end
        end

        if self.type == DormConst.StoryType.ActivityRewardStory and self.isLockStory == false then
            self:ActivityStoryCommit()
            return
        end
        

        UIContextMgr:GetInstance():Show("Dorm", self.module.roleStudio)
        self:Close()
    else
        --切换下一句对话
        self:SetStroy(self.stroyList[self.nextStepId])
    end
end

--设置交付道具
function M:SetItemTask(itemTask)
    self.itemTask = {}
    for i = 0, #itemTask do
        if i % 2 == 1 then
            local data = {}
            data.item = itemTask[i]
            data.num = itemTask[i + 1]
            data.curNum = 0
            table.insert(self.itemTask, data)
        end
    end
end

--判断是否有交付任务
function M:CheckItemTask()
    for key, value in pairs(self.stroyList) do
        if #value.itemTask > 0 then
            return true
        end
    end
    return false
end

--提交道具回调
function M:GivingCallback(value)
    self.isGiving = value
    self.giftCtrl:Enable(false)
    self._view.Story:SetActive(true)
    self.isLockStory = false
    if self.isGiving == true then
        self.nextStepId = self.curData.nextStepId[1]
    else
        self.nextStepId = self.curData.nextStepId[2]
    end
    self:NextStep()
end

function M:OnClose()
    DormHelper.EnableRenderers(true)
    self.dormAction.state = DormConst.RoleState.Command
    DormHelper.PlayAction(self.curFuritureData, "Action_AFK_Stay")
    self.dormAction:CommanderMoveToFurniture("Main")
    if self.closeCallback then
        self.closeCallback()
    end
    self.closeCallback = nil
end

function M:OnDispose()
    self.isLockStory = false
    if self.roomStorySelectCallback then
        EventMgr:RemoveListener(UIMessageNames.FAVOR_SELECT_ROOM_STORY, self.roomStorySelectCallback)
    end
    self.roomStorySelectCallback = nil
    for i = 1, 3 do
        self.powerItems[i]:OnDispose()
    end
    self.giftCtrl:OnDispose()
    self.powerItems = nil
    M.super.OnDispose(self)
end

return FavorStoryCtrl
