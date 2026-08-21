local DormCtrl = BaseClass("DormCtrl", BaseUICtrl)
local M = DormCtrl

function M:Init()
    self._view.BtnCloth.transform:onClick(Bind(self, self.OnClickCloth))
    self._view.BtnBook.transform:onClick(Bind(self, self.OnClickBook))
    self._view.BtnAdd.transform:onClick(Bind(self, self.OnClickAdd))
    self._view.BtnValentine.transform:onClick(Bind(self, self.OnClickValentine))
    self._view.BtnCamera.transform:onClick(Bind(self, self.OnClickCamera))
    self._view.BtnCall.transform:onClick(Bind(self, self.OnClickCall))
    self._view.BtnGift.transform:onClick(Bind(self, self.OnClickGift))
    self._view.BtnFurniture.transform:onClick(Bind(self, self.OnClickFurniture))
    self._view.FavorBtn.transform:onClick(Bind(self, self.OnClickFavor))
    self._view.TheatBtn.transform:onClick(Bind(self, self.OnClickTheat))
    self._view.ActivityBtn.transform:onClick(Bind(self, self.OnClickActivity))
    self._view.node_personal.transform:onClick(Bind(self, self.OnClickButtonPersonal))
    self.favorPanelCtrl = require("UI.Ctrl.Dorm.FavorPanelCtrl").New(self._view.FavorPanel)
    self.dormTaskCtrl = require("UI.Ctrl.Dorm.DormTaskCtrl").New(self._view.DormTask)
    self.dormAtmosphereCtrl = require("UI.Ctrl.Dorm.DormAtmosphereItemCtrl").New(self._view.Atmosphere)
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.concealDorm = EventMgr:AddListener(UIMessageNames.DORM_CONCEAL_DORM, Bind(self, self.Enable))
    self.tabFaverItemCtrl = { [1] = self._view.FaverItemCtrl }
    self.UpdateFavorHandle = EventMgr:AddListener(UIMessageNames.DORM_UPDATE_FAVOR, Bind(self, self.InitFavor))
    self.systemId = ConfigHelper.GetSystemParam(358)
    self.dressupOpencondition = ConfigHelper.GetSystemParam(360)
    self.addOpen = false
end

function M:OnEnter(roleStudio)
    if roleStudio then
        self.roleStudio = roleStudio
    else
        self.roleStudio = self.module.roleStudio
    end

    --心流体验
    if self.module.isGuide then
        self._view.Panel.gameObject:SetActive(false)
        self._view.TouchBg.gameObject:SetActive(true)
        return
    end

    self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.roleStudio.HeroId)
    self.module:GetDormTheater(Bind(self, self.InitPanel))
end

function M:InitPanel()
    self:InitFavor()
    self:InitDormTask()
    self.dormAtmosphereCtrl:Update(self.roleStudio.HeroId)
    local isOpen = GameHelper.CheckLockByOpenConditionId(self.dressupOpencondition)
    if isOpen == true then
        self._view.FurnitureRedpoint:SetParam(0, 1)
        self._view.FurnitureRedpoint:Check()
        self._view.BtnFurnitureState:SetState(1)
        local installedNum = 0
        local totalNum = 0
        for key, value in pairs(DormConst.DormArea) do
            local SlotNum = DormHelper.GetSlotNum(value.areaName)
            installedNum = installedNum + SlotNum.InstalledNum
            totalNum = totalNum + SlotNum.TotalNum
            self._view.FurnitureText:SetText(installedNum.."/"..totalNum)
        end
    else
        self._view.BtnFurnitureState:SetState(2)
    end
    local activityOpen = DormPuzzleActivityDataMgr:GetInstance():CheckActivityOpen()
    if activityOpen then
        local activityId = DormPuzzleActivityDataMgr:GetInstance().activityId
        self._view.BtnValentine.gameObject:SetActive(true)
        self._view.ValentineRedpoint:SetParam(0, activityId)
        self._view.ValentineRedpoint:Check()
        self.module:CheckActivityStory(Bind(self, self.InitActivityTask))
    else
        self._view.BtnValentine.gameObject:SetActive(false)
    end 
end

function M:InitFavor()
    self.favorLevel = 0
    local curFavor = 0
    local nextFavor = 0
    local favorProgress = 0
    local stage = 0
    self._roomStory = 0
    self._roomStoryLevel = 0
    local favor = 0

    if not IsNull(self.rshd) then
        favor = self.rshd:GetFavor()
    end

    self.favorLevel, curFavor, nextFavor, favorProgress, stage, self._roomStory, self._roomStoryLevel =
        OtakuHelper.GetHeroFeeling(self.roleStudio.HeroId, favor)

    if self._roomStory ~= 0 then
        self._view.FavorBtn.transform:SetActive(true)
    else
        self._view.FavorBtn.transform:SetActive(false)
    end

    self.favorPanelCtrl:Enable(true)
    self.favorPanelCtrl:UpdateData(self.roleStudio.HeroId, self.favorLevel, curFavor, nextFavor, stage)
end

function M:InitDormTask()
    self._view.TheatBtn.transform:SetActive(false)
    --尚未接取小剧场任务
    if self.module.roomEvent ~= 0 and self.module.roomTask == 0 then
        self._view.TheatBtn.transform:SetActive(true)
        self.taskStory = self.module.roomEvent
        self.taskStoryType = DormConst.StoryType.TheatTaskStory
        local cfgs = ConfigHelper.GetCfgsByLua("roomStory", { groupId = self.taskStory })

        if cfgs[1].type == DormConst.StoryType.TheatTaskWithoutStory then
            self.taskStoryType = DormConst.StoryType.TheatTaskWithoutStory
        end
    end
    self.dormTaskCtrl:UpdateData(self.module.roomTask)
    --小剧场任务完成未提交
    if self.module.roomTask ~= 0 then
        self.taskData = TaskDataMgr:GetTaskData(TaskConst.TaskType.Theater, self.module.roomTask)

        if self.taskData then
            if self.taskData.state == TaskConst.TaskState.TaskComplete then
                self.taskStory = self.taskData.roomStoryId
                local stroyList = OtakuHelper.GetFavorStoryByGroupId(self.taskStory)
                self.taskStoryType = stroyList[1].type
                self:OnClickTheat()
            end
        end
    end
end

function M:InitActivityTask()
    self._view.ActivityBtn.transform:SetActive(false)
    --尚未接取小剧场任务
    if self.module.activityEvent ~= 0 and self.module.activityEventType == DormConst.EventType.LevelDo then
        self._view.ActivityBtn.transform:SetActive(true)
        self.activityTaskStory = self.module.activityEvent
        self.activityTaskStoryType = DormConst.StoryType.ActivityStory
    end
    self._view.ActivityStoryRedpoint:SetParam(0, 1)
    self._view.ActivityStoryRedpoint:Check()
end

function M:OnClickFavor()
    if self._roomStory ~= 0 then
        UIContextMgr:GetInstance():Show("FavorStory", self.roleStudio.HeroId, DormConst.StoryType.roomStory,
            self._roomStory, nil, self._roomStoryLevel)
    end

    UIContextMgr:GetInstance():Close("Dorm")
end

function M:OnClickTheat()
    if self.taskStoryType == DormConst.StoryType.TheatTaskWithoutStory then
        DormDataMgr:HeroEventStoryTrigger(self.roleStudio.HeroId, self.module.roomEventType + 1, self.module.roomEvent,
            Bind(self, self.HeroEventStoryCallBack))
        return
    end

    if self.taskStoryType == DormConst.StoryType.TheatRewardWithoutStory then
        if self.taskData.state == TaskConst.TaskState.TaskComplete then
            DormDataMgr:HeroEventStoryCommit(self.roleStudio.HeroId, Bind(self, self.HeroEventStoryCommitCallBack))
        end
        return
    end

    UIContextMgr:GetInstance():Show("FavorStory", self.roleStudio.HeroId, self.taskStoryType, self.taskStory, nil, nil,
        function()
            UIContextMgr:GetInstance():Close("Dorm")
        end, nil)
end

function M:OnClickActivity()
    UIContextMgr:GetInstance():Show("FavorStory", self.roleStudio.HeroId, self.activityTaskStoryType, self.activityTaskStory, nil, nil,
    function()
        UIContextMgr:GetInstance():Close("Dorm")
    end, nil)
end

--活动小剧场领奖回调
function M:ActivityEventStoryCommitCallBack(msg)
    --清空任务
    self.module.activityEventType = 0
    self.module.activityEvent = 0
    self.module.activityTask = 0
    self:InitActivityTask()
end

--英雄小剧场领奖回调
function M:HeroEventStoryCommitCallBack(msg)
    --清空任务
    self.module.roomEventType = 0
    self.module.roomEvent = 0
    self.module.roomTask = 0
    if not IsNull(self.rshd) then
        self.rshd:UpdateEventNode(0)
        self.rshd:UpdateEventNodeType(0)
        self.rshd:UpdateEventLevel(msg.EventLevel)
    end
    self:InitDormTask()
end

--英雄触发小剧场任务回调(接取任务)
function M:HeroEventStoryCallBack(msg)
    --更新数据
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.roleStudio.HeroId)

    if not IsNull(rshd) then
        rshd:UpdateEventNode(msg.EventId)
        rshd:UpdateEventNodeType(msg.EventType)
        self.module.roomEvent = msg.EventId
        self.module.roomEventType = msg.EventType
        self.module.roomTask = DormHelper.GetDormTask(self.roleStudio.HeroId)
    end

    UIContextMgr:GetInstance():Show("DormitoryTheaterPopup", self.module.roomTask, Bind(self, self.InitDormTask))
end


function M:ResetFurnitureInteractionHandler()
    self._isZoomIn = false
    self._view.objPanel.gameObject:SetActive(true)
end

function M:OnTips()
    UIContextMgr:GetInstance():Show("DormHelpPopup")
end

function M:OnBack()
    if self.taskStoryType == DormConst.StoryType.TheatRewardStory then
        return false
    end

    JumpMgr:GetInstance():Execute(1)
    return false
end

function M:OnClickCloth(go)
    self.module:DestroyLoad()
    ModuleMgr:GetInstance():ChangeModule(ModuleConfig.DormRoleFashionModule.id, self.roleStudio.HeroId)
end

function M:OnClickBook(go)
    UIContextMgr:GetInstance():Show("BenzoinBook", self.roleStudio.HeroId, self.favorLevel)
end

function M:OnClickAdd(go)
    if self.addOpen == false then
        self.addOpen = true
        self._view.BtnAddAnimation:Play("BtnAddOpen")
    else
        self.addOpen = false
        self._view.BtnAddAnimation:Play("BtnAddClose")
    end 
    
end 

function M:OnClickValentine(go)
    UIContextMgr:GetInstance():Show("DormPuzzle")
    UIContextMgr:GetInstance():Close("Dorm")
end

function M:OnClickCamera(go)
    self.dormAction:RoleCommand(DormConst.DormRouletteType.Main)
end

function M:OnClickCall(go)
    self.dormAction:RoleCommand(DormConst.DormRouletteType.Greet)
end

function M:OnClickGift(go)
    self.dormAction:RoleCommand(DormConst.DormRouletteType.Gift)
end

function M:OnClickFurniture(go)
    local isOpen = GameHelper.CheckLockByOpenConditionId(self.dressupOpencondition)
    if isOpen == false then
        GameHelper.TipsById(3183)
        return
    end
    self.dormAction:RoleCommand(DormConst.DormRouletteType.DressUp)
end

-- 个人副本入口
function M:OnClickButtonPersonal(go)
    local list = DormDataMgr:GetPersonalPassRecord(self.roleStudio.HeroId)
    if #list > 0 then
        UIContextMgr:GetInstance():Show("DormPersonalEventMainUI", self.roleStudio.HeroId, list)
        UIContextMgr:GetInstance():Close("Dorm")
    else
        -- 暂无个人副本
        GameHelper.TipsById(5205)
    end
end

function M:OnClose(...)
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    if self._timer then
        self._timer:Stop()
    end
    EventMgr:RemoveListener(UIMessageNames.DORM_UPDATE_FAVOR, self.UpdateFavorHandle)
    EventMgr:RemoveListener(UIMessageNames.DORM_CONCEAL_DORM, self.concealDorm)
    self.roleStudio = nil
    self.favorPanelCtrl:OnDispose()
    self.dormTaskCtrl:OnDispose()
    self.dormAtmosphereCtrl:OnDispose()
    for k, value in ipairs(self.tabFaverItemCtrl) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end

    M.super.OnDispose(self)
end

return DormCtrl
