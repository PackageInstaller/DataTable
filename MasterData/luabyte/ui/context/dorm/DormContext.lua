local DormContext = BaseClass("DormContext", BaseContext)
local M = DormContext

function M:__init()
end

function M:_Destory()
    M.super._Destory(self)
end

function M:Open(roomData)
    self._roomData = roomData
    --小剧场任务完成未提交直接开启宿舍剧情
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    if self.module.roomTask == 0 then
        self.module.roomTask = DormHelper.GetDormTask(self.module.roleStudio.HeroId)
    end
    if self.module.activityTask == 0 then
        self.module.activityTask = DormPuzzleActivityDataMgr:GetInstance():GetActivityTask()
    end  
    if self.module.roomTask ~= 0 then
        self.taskData = TaskDataMgr:GetTaskData(TaskConst.TaskType.Theater, self.module.roomTask)
        
        if self.taskData then
            if self.taskData.state == TaskConst.TaskState.MissionComplete or self.taskData.state == TaskConst.TaskState.TaskComplete then
                self.taskStory = self.taskData.roomStoryId
                local stroyList = OtakuHelper.GetFavorStoryByGroupId(self.taskStory)
                self.taskStoryType = stroyList[1].type
                if self.taskStoryType == DormConst.StoryType.TheatRewardWithoutStory then
                    --任务已完成未提交
                    if self.taskData.state == TaskConst.TaskState.MissionComplete then
                        TaskDataMgr:RequestCompleteTask(self.module.roomTask, Bind(self, self.CompleteTaskCallback))
                        return
                    end

                    if self.taskData.state == TaskConst.TaskState.TaskComplete then
                        DormDataMgr:HeroEventStoryCommit(self.module.roleStudio.HeroId, Bind(self, self.HeroEventStoryCommitCallBack))
                        return
                    end 
                end
                UIContextMgr:GetInstance():Show("BeforeFavorStory", self.module.roleStudio.HeroId, self.taskStoryType, self.taskStory)
                return
            end
        end
    end

    if self.module.activityTask ~= 0 then
        self.activityTaskData = TaskDataMgr:GetTaskData(TaskConst.TaskType.Theater, self.module.activityTask)
        
        if self.activityTaskData then
            if self.activityTaskData.state == TaskConst.TaskState.MissionComplete or self.activityTaskData.state == TaskConst.TaskState.TaskComplete then
                self.activityTaskStory = self.activityTaskData.roomStoryId
                local stroyList = OtakuHelper.GetFavorStoryByGroupId(self.activityTaskStory)
                self.activityTaskStoryType = stroyList[1].type
                if self.activityTaskStoryType == DormConst.StoryType.ActivityRewardWithoutStory then
                    --任务已完成未提交
                    if self.activityTaskData.state == TaskConst.TaskState.MissionComplete then
                        TaskDataMgr:RequestCompleteTask(self.module.activityTask, Bind(self, self.CompleteActivityTaskCallback))
                        return
                    end

                    if self.activityTaskData.state == TaskConst.TaskState.TaskComplete then
                        DormPuzzleActivityDataMgr:GetInstance():FlipCardStoryCommit(Bind(self, self.HeroEventStoryCommitCallBack))
                        return
                    end 
                end
                UIContextMgr:GetInstance():Show("BeforeFavorStory", self.module.roleStudio.HeroId, self.activityTaskStoryType, self.activityTaskStory)
                return
            end
        end
    end
    self:_Show(self._roomData)
end

function M:CompleteTaskCallback(msg)
    DormDataMgr:HeroEventStoryCommit(self.module.roleStudio.HeroId, Bind(self, self.HeroEventStoryCommitCallBack))
end

function M:CompleteActivityTaskCallback(msg)
    DormPuzzleActivityDataMgr:GetInstance():FlipCardStoryCommit(Bind(self, self.ActivityEventStoryCommitCallBack))
end

--英雄小剧场领奖回调
function M:HeroEventStoryCommitCallBack(msg)
    --清空任务
    self.module.roomEventType = 0
    self.module.roomEvent = 0
    self.module.roomTask = 0
    self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.module.roleStudio.HeroId)
    if not IsNull(self.rshd) then
        self.rshd:UpdateEventNode(0)
        self.rshd:UpdateEventNodeType(0)
        self.rshd:UpdateEventLevel(msg.EventLevel)
    end
    self:_Show(self._roomData)
    if self.taskStory == 1014 then
        IGuideMgr:ManualTriggerGuideSystem()
    end
end

--活动小剧场领奖回调
function M:ActivityEventStoryCommitCallBack(msg)
    --清空任务
    self.module.activityEventType = 0
    self.module.activityEvent = 0
    self.module.activityTask = 0
    self:_Show(self._roomData)
end


return DormContext
