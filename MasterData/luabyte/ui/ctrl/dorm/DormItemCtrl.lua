local DormItemCtrl = BaseClass("DormItemCtrl")
local M = DormItemCtrl

function M:__init(view)
    self._view = view
    self._module = ModuleMgr:GetInstance():GetCurrentModule()
    self._view.transform:onClick(Bind(self, self._ClickItem))
    self.isComplete = false
    self.isOpen = true
end

function M:_ClickItem(go)
    if self.isOpen == false then
        return
    end
    --任务完成进入
    if self.isComplete then
        DormDataMgr:EnterDormitoryStudio(self.heroId)
    else
        --打开宿舍活动界面
        UIContextMgr:GetInstance():Show("DormitoryActivityUI", self.data.activityId,self.heroId)
    end
end

function M:UpdateItem(data)
    self.data = data
    self.heroId = data.heroId
    if self.data.activityId > 0 then
        self.activityData = ActivityDataMgr:GetInstance():GetActivityData(self.data.activityId)
        if self.activityData then
            if self.activityData:IsOpen() then
                if self.activityData:CheckDormActive() then
                    self._view.UIState:SetState(1)
                    self:CheckIconGroup()
                    self.isComplete = true
                    local puzzluActivityId = DormHelper.GetPuzzleActivityId(self.heroId)
                    self._view.RedPoint.enabled = true
                    self._view.RedPoint:SetParam(0, -1)
                    self._view.RedPoint:SetParam(1, puzzluActivityId)
                    self._view.RedPoint:Check()
                else
                    self._view.UIState:SetState(2)
                    self._view.RedPoint.enabled = true
                    self._view.RedPoint:SetParam(0, self.data.activityId)
                    self._view.RedPoint:SetParam(1, -1)
                    self._view.RedPoint:Check()
                end 
                self._view.BG:SetPic(self.data.image[2])
                self._view.Open:SetPic(self.data.image[2])
            else
                self.isOpen = false
                self._view.UIState:SetState(3)
                self._view.BG:SetPic(self.data.image[1])
            end
        else
            self.isOpen = false
            self._view.UIState:SetState(3)
            self._view.BG:SetPic(self.data.image[1])
        end
    else
        --敬请期待
        self.isOpen = false
        self._view.UIState:SetState(3)
        self._view.BG:SetPic(self.data.image[1])
    end
end

function M:CheckIconGroup(...)
    self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.heroId)
    local favor = self.rshd:GetFavor()
    local favorLevel = 0
    local curFavor = 0
    local nextFavor = 0
    local favorProgress = 0
    local stage = 0
    local roomStory = 0
    local roomStoryLevel = 0
    favorLevel, curFavor, nextFavor, favorProgress, stage, roomStory, roomStoryLevel = OtakuHelper.GetHeroFeeling(self.heroId, favor)
    
    local favornum = self.rshd:GetFavorLevel()
    self._view.FavorNum:SetText(tostring(favornum))

    if roomStory ~= 0 then
        self._view.InstanceIcon.transform:SetActive(true)
    end

    if PresentReturnDataMgr:GetRepresentFixedStoryByHeroId(self.heroId) then
        self._view.InstanceIcon.transform:SetActive(true)
    end

    if self.rshd.EventNode ~= 0 then
        if self.rshd.EventNodeType == DormConst.EventType.LevelDo  then
            self._view.TheatIcon.transform:SetActive(true)
        end

        if self.rshd.EventNodeType == DormConst.EventType.LevelDoing then
            --获得英雄相关的宿舍任务ID
            self.roomTask = DormHelper.GetDormTask(self.heroId)
            if self.roomTask > 0 then
                self.taskData = TaskDataMgr:GetTaskData(TaskConst.TaskType.Theater, self.roomTask)
                if self.taskData then
                    if self.taskData.state == TaskConst.TaskState.MissionComplete then
                        self._view.TheatIcon.transform:SetActive(true)
                    end
                end 
            end
        end
    end
end

function M:OnDispose()
    self._module = nil
    self.isComplete = false
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormItemCtrl
