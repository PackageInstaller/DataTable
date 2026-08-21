local DormModule = BaseClass("DormModule", require("Framework.Module.BaseGameModule"))
local M = DormModule
local SpecialEventCount = "SpecialEventCount"
local SpecialEventTime = "SpecialEventTime"
local tInsert = table.insert
local furnitureAgent = "Home/Home01/Home01_FurnitureAgent"

function M.MissionSort(data1, data2)
    return data1.id < data2.id
end

function M:__init()
    self.heroId = 0
    self.roomEvent = 0
    self.roomEventType = 0
    self.roomTask = 0
    self.activityEventType = 0
    self.activityEvent = 0
    self.activityTask = 0
    self.specialEventStoryIndex = 0
    self.timelineSystem = GameHelper.GetParamters(245)
    self.changeFurnitureData = {}
    self.originalFurnitureData = {}
    self.furnitureServerData = {}
    self.systemId = ConfigHelper.GetSystemParam(358)
end

function M:OnEnter(heroId)
    self.heroId = heroId
    self.roleStudio = {}
    self.roleStudio.HeroId = heroId
    self.roleRoomCfg = ConfigHelper.GetCfgsByLua("roleRoom",{heroId = self.roleStudio.HeroId})[1]
    self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.roleStudio.HeroId)
    --安息香判断宿舍引导
    if DormHelper.CheckGift(self.heroId, self.systemId) == false and self.heroId == 110003 then
        self.isGuide = true
    else
        self.isGuide = false
    end 
    M.super.OnEnter(self)
    --进入宿舍埋点
    GameHelper.DoPlayerAction(PlayerAction.OpenRoom)
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Dormitory_enter)
    local puzzluActivityId = DormHelper.GetPuzzleActivityId(self.heroId)
    if puzzluActivityId > 0 then
        --获取宿舍活动
        DormPuzzleActivityDataMgr:GetInstance():GetActivityData(puzzluActivityId, Bind(self, self.GetActivityDataCallback))
    else
        --清除宿舍活动数据
        DormPuzzleActivityDataMgr:GetInstance():ClearData()
        self:GetActivityDataCallback()
    end
end

function M:GetActivityDataCallback(activeData)
    --获取任务数据
    TaskDataMgr:RequestLoadTaskByType(TaskConst.TaskType.Theater, Bind(self, self.LoadTaskCallback))
end

function M:LoadSceneComplete(view, ctrl)
    ctrl:ChangeDisplay("Home")
    self._view = ctrl:GetHolder("Home")
    self.Home01_Root = self._view.Home01_Root
    self.Machine = self._view.MachineActivity
    ResourceManager:GetInstance():InstanceGameObject(furnitureAgent, function(go)
        if not IsNull(go) then
            local trans = go.transform
            trans:SetParent(self.Home01_Root)
            trans.localPosition = Vector3.zero
            trans.localScale = Vector3.one
            self.FurnitureAgent = trans:GetComponent(typeof(CS.GameX.Home.HomeFurnitureAgent))
            self:LoadFurnitureAgentCallback()
        end
    end)
end

function M:LoadFurnitureAgentCallback()
    self.furnitureData = {}
    self.furnitures = {}
    if #self.furnitureServerData > 0 then
        self:OnUpdateDorm()
        self:OpenDormPanel()
        DormHelper.SetGlassActive(false)
    else
        self.hasError = true
        return
    end
    JumpMgr:GetInstance():ResetJumpBack()
end

function M:GetFurnitures()
    OtakuFurniturDataMgr:GetFurnituresByPage(-1, Bind(self, self.GetFurnitureDataCallBack))
end

function M:GetFurnitureDataCallBack(data)
    for key, value in pairs(data) do
        if value.HeroId == self.heroId then
            if self.isGuide == true then
                OtakuFurniturDataMgr:SetCach(value.FurnitureId)
            end
            table.insert(self.furnitureServerData, value)
        end
    end
    Logger.Log("初始家具数量" .. #self.furnitureServerData)
    if self:GetCurSceneName() ~= "Home02" then
        self:LoadScene("Home02", Bind(self, self.LoadSceneComplete))
    else
        self:LoadSceneComplete(self:GetViewAndCtrl("Home02"))
    end
end

function M:LoadTaskCallback()
    --获取家具数据
    self:GetFurnitures()
end

function M:OnUpdateDorm()
    DormActionMgr:GetInstance():CreateDormAction(self.roleStudio.HeroId)
    self:UpdateFurniture()
    self:UpdateRole(self.roleStudio.HeroId)
end

function M:OnUpdateSweepMachine(isEnterDressup)
    if self.sweepMachine then
        if isEnterDressup then
            self.sweepMachine:EnableActivityRegion(false)
            self.sweepMachine:EnableMachine(true)
            self.sweepMachine:SetTimer(true)
        else
            self.sweepMachine:EnableActivityRegion(true)
            self.sweepMachine:EnableMachine(false)
            self.sweepMachine:SetTimer(false)
        end
    end
end

function M:UpdateFurniture()
    -- 优先创建非附属家具
    for k, v in pairs(self.furnitureServerData) do
        if v.ParentId == 0 then
            self:CreateFurniture(v.TemplateId, v.FurnitureId, v.ParentId, v.PosIndex)
        end
    end

    for k, v in pairs(self.furnitureServerData) do
        if v.ParentId ~= 0 then
            self:CreateAccessoryFurniture(v.TemplateId, v.FurnitureId, v.ParentId, v.PosIndex)
        end
    end
    self:SetSweepMachine()
end

function M:SetSweepMachine()
    for key, value in pairs(self.furnitureData) do
        if value.cfg.subType == 908 then
            if value.gameObj and self.sweepMachine == nil then
                self.sweepMachine = require('UI.Ctrl.Dorm.SweepMachineCtrl').New(self.Machine)
                self.sweepMachine:SetMachineObj(value.gameObj)
                self.sweepMachine:EnableActivityRegion(true)
                self.sweepMachine:EnableMachine(false)
            end
        end
    end
end

function M:GetFurniture(furnitureId)
    for k, v in pairs(self.furnitureData) do
        if v.id == furnitureId then
            return v
        end
    end
end

function M:GetSlotFurnituresById(furnitureId)
    local datas = {}

    for k, v in pairs(self.furnitureData) do
        if v.parentId == furnitureId then
            tInsert(datas, v)
        end
    end
    return datas
end

function M:GetFurnitureByType(type)
    for k, v in pairs(self.furnitureData) do
        if v.type == type then
            return v
        end
    end
end

-- 创建家具
function M:CreateFurniture(TemplateId, furnitureId, parentId, posIndex)
    local cfg = ConfigHelper.GetCfgByLua("houseFurniture", TemplateId)
    if cfg then
        local furniture = nil
        local homeFurniturePoint = cfg.homeFurniturePoint
        if cfg.type == DormConst.FurnitureType.DefaultStandPoint then
            self.FurnitureAgent:InitFurniture(homeFurniturePoint, nil, furnitureId, TemplateId, cfg.type)
        else
            furniture = ResourceManager:GetInstance():InstanceGameObject(cfg.resources)
            self.FurnitureAgent:InitFurniture(homeFurniturePoint, furniture.transform, furnitureId, TemplateId, cfg.type)
            -- 设置家具是否可见
            if cfg.show == 0 then
                furniture.transform.gameObject:SetActive(false)
            end
        end
        local furnitureData = require("DataCenter.Otaku.SingleFurnitureData").New(furnitureId, cfg.type, cfg, furniture,
            parentId, homeFurniturePoint, posIndex, TemplateId)
        tInsert(self.furnitureData, furnitureData)
    else
        Logger.Log("创建家具失败" .. TemplateId)
    end

end

-- 创建附属家具
function M:CreateAccessoryFurniture(TemplateId, furnitureId, parentId, posIndex)
    local parentData = self:GetFurniture(parentId)

    if parentData then
        local cfg = ConfigHelper.GetCfgByLua("houseFurniture", TemplateId)
        if cfg then
            local resources = nil
            local furniture = nil
            local furnitureData = nil
            resources = cfg.resources

            --照片处理
            if cfg.subType == 902 then
                furniture = nil
                self.FurnitureAgent:InitFurnitureSlot(furnitureId, nil, TemplateId, parentData.homeFurniturePoint,
                    posIndex,
                    cfg.offset, cfg.type, cfg.picture)
            else
                furniture = ResourceManager:GetInstance():InstanceGameObject(resources)
                self.FurnitureAgent:InitFurnitureSlot(furnitureId, furniture.transform, TemplateId,
                    parentData.homeFurniturePoint, posIndex, cfg.offset, cfg.type)
                -- 设置家具是否可见
                if cfg.show == 0 then
                    furniture.transform.gameObject:SetActive(false)
                end
            end
            furnitureData = require("DataCenter.Otaku.SingleFurnitureData").New(furnitureId, cfg.type, cfg, furniture,
                parentId, cfg.homeFurniturePoint, posIndex, TemplateId)
            tInsert(self.furnitureData, furnitureData)
        end
    else
        Logger.Log("创建家具失败" .. TemplateId)
    end

end

-- 修改普通家具
function M:ChangeFurniture(furnitureType, newFurnitureId, newTemplateId)
    local oldFurnitureId = nil
    local oldTemplateId = nil
    -- 寻找旧家具
    for k, v in pairs(self.furnitureData) do
        if v.parentId == 0 and v.posIndex == furnitureType then
            oldFurnitureId = v.id
            oldTemplateId = v.TemplateId
            break
        end
    end
    -- 先卸载旧家具
    if oldFurnitureId then
        local oldFurnitureData = {}
        oldFurnitureData.FurnitureId = oldFurnitureId
        oldFurnitureData.HeroId = 0
        oldFurnitureData.PosIndex = 0
        oldFurnitureData.ParentId = 0
        oldFurnitureData.TemplateId = oldTemplateId
        EventMgr:Broadcast(UIMessageNames.DORM_DRESSUP_UPDATE_AREAFURNITURE, oldFurnitureData, false)
        self:UpdateChangeFurnitureData(oldFurnitureData)
        self:DestroyFurniture(oldFurnitureId)
        if newFurnitureId and newTemplateId then
            local newFurnitureData = {}
            newFurnitureData.FurnitureId = newFurnitureId
            newFurnitureData.HeroId = self.heroId
            newFurnitureData.PosIndex = furnitureType
            newFurnitureData.ParentId = 0
            newFurnitureData.TemplateId = newTemplateId
            self:UpdateChangeFurnitureData(newFurnitureData)
            self:CreateFurniture(newTemplateId, newFurnitureId, 0, furnitureType)
            EventMgr:Broadcast(UIMessageNames.DORM_DRESSUP_UPDATE_AREAFURNITURE, newFurnitureData, true)
            for k, v in pairs(self.furnitureData) do
                if v.parentId == oldFurnitureId then
                    v.parentId = newFurnitureId
                    local newSlotFurnitureData = {}
                    newSlotFurnitureData.FurnitureId = v.id
                    newSlotFurnitureData.HeroId = self.heroId
                    newSlotFurnitureData.PosIndex = v.posIndex
                    newSlotFurnitureData.ParentId = newFurnitureId
                    self:UpdateChangeFurnitureData(newSlotFurnitureData)
                end
            end
        else
            
        end
    else
        local newFurnitureData = {}
        newFurnitureData.FurnitureId = newFurnitureId
        newFurnitureData.HeroId = self.heroId
        newFurnitureData.PosIndex = furnitureType
        newFurnitureData.ParentId = 0
        newFurnitureData.TemplateId = newTemplateId
        self:UpdateChangeFurnitureData(newFurnitureData)
        self:CreateFurniture(newTemplateId, newFurnitureId, 0, furnitureType)
        EventMgr:Broadcast(UIMessageNames.DORM_DRESSUP_UPDATE_AREAFURNITURE, newFurnitureData, true)
    end
end

-- 修改附属家具
function M:ChangeAccessoryFurniture(parentFurnitureId, slot, newFurnitureId, newTemplateId)
    local oldFurnitureId = nil
    local oldTemplateId = nil
    local isDressUp = false --家具是否布置
    local oldParentFurnitureId = nil
    local oldSlotId = nil
    -- 寻找旧家具
    for k, v in pairs(self.furnitureData) do
        if v.parentId == parentFurnitureId and v.posIndex == slot then
            oldFurnitureId = v.id
            oldTemplateId = v.TemplateId
        end

        if v.id == newFurnitureId then
            isDressUp = true
            oldParentFurnitureId = v.parentId
            oldSlotId = v.posIndex
        end
    end

    --相同家具不进行替换
    if newFurnitureId == oldFurnitureId then
        return
    end

    --先拆除要布置的家具
    if isDressUp and oldParentFurnitureId and oldSlotId then
        local selfFurnitureData = {}
        selfFurnitureData.FurnitureId = newFurnitureId
        selfFurnitureData.HeroId = 0
        selfFurnitureData.PosIndex = 0
        selfFurnitureData.ParentId = 0
        selfFurnitureData.TemplateId = newTemplateId
        EventMgr:Broadcast(UIMessageNames.DORM_DRESSUP_UPDATE_AREAFURNITURE, selfFurnitureData, false)
        self:UpdateChangeFurnitureData(selfFurnitureData)
        self:DestroyAccessoryFurniture(newFurnitureId, oldParentFurnitureId, oldSlotId)
    end

    -- 先卸载旧家具
    if oldFurnitureId then
        local oldFurnitureData = {}
        oldFurnitureData.FurnitureId = oldFurnitureId
        oldFurnitureData.HeroId = 0
        oldFurnitureData.PosIndex = 0
        oldFurnitureData.ParentId = 0
        oldFurnitureData.TemplateId = oldTemplateId
        EventMgr:Broadcast(UIMessageNames.DORM_DRESSUP_UPDATE_AREAFURNITURE, oldFurnitureData, false)
        self:UpdateChangeFurnitureData(oldFurnitureData)
        self:DestroyAccessoryFurniture(oldFurnitureId, parentFurnitureId, slot)
    end

    if newFurnitureId and newTemplateId then
        -- 装载新家具
        local newSlotFurnitureData = {}
        newSlotFurnitureData.FurnitureId = newFurnitureId
        newSlotFurnitureData.HeroId = self.heroId
        newSlotFurnitureData.PosIndex = slot
        newSlotFurnitureData.ParentId = parentFurnitureId
        newSlotFurnitureData.TemplateId = newTemplateId
        EventMgr:Broadcast(UIMessageNames.DORM_DRESSUP_UPDATE_AREAFURNITURE, newSlotFurnitureData, true)
        self:UpdateChangeFurnitureData(newSlotFurnitureData)
        self:CreateAccessoryFurniture(newTemplateId, newFurnitureId, parentFurnitureId, slot)
    end
end

-- 删除家具
function M:DestroyFurniture(id)
    for k, v in pairs(self.furnitureData) do
        if v.id == id then
            self.FurnitureAgent:UninstallFurniture(v.homeFurniturePoint)
            if v.cfg.type ~= DormConst.FurnitureType.DefaultStandPoint then
                GameUtil.DestroyGo(v.gameObj)
            end
            table.removebyvalue(self.furnitureData, v)
            break
        end
    end
end

-- 删除附属家具
function M:DestroyAccessoryFurniture(id, parentId, slotId)
    local parentData = self:GetFurniture(parentId)

    for k, v in pairs(self.furnitureData) do
        if v.id == id then
            self.FurnitureAgent:UninstallFurnitureSlot(id, parentData.homeFurniturePoint, slotId)
            if v.cfg.subType ~= 902 then
                GameUtil.DestroyGo(v.gameObj)
                if v.cfg.subType == 908 then
                    if self.sweepMachine then
                        self.sweepMachine:OnDispose()
                        self.sweepMachine = nil
                    end
                end
            end
            table.removebyvalue(self.furnitureData, v)
            break
        end
    end
end

--更新更换家具数据
function M:UpdateChangeFurnitureData(furnitureData)
    local isExist = false
    for key, value in pairs(self.changeFurnitureData) do
        if value.FurnitureId == furnitureData.FurnitureId then
            isExist = true
            value.HeroId = furnitureData.HeroId
            value.ParentId = furnitureData.ParentId
            value.PosIndex = furnitureData.PosIndex
            break
        end
    end
    if isExist == false then
        tInsert(self.changeFurnitureData, furnitureData)
    end
    self.context = UIContextMgr:GetInstance():GetContext("DormitoryDressupUI")
    if self.context then
        self.context:UpdateAllFurniture(furnitureData)
    end
end

--批量设置家具
function M:SetFurnitures(callback)
    if #self.changeFurnitureData > 0 then
        OtakuFurniturDataMgr:RequestSetFurnitures(self.changeFurnitureData, Bind(self, self.SetFurnituresCallback))
        self.SetFurniturescallBack = callback
    end
end

--批量设置家具回调
function M:SetFurnituresCallback(furnitures)
    self:ClearChangeFurnitureData()
    if self.SetFurniturescallBack then
        self.SetFurniturescallBack()
        self.SetFurniturescallBack = nil
    else
        self.context = UIContextMgr:GetInstance():GetContext("DormitoryDressupUI")
        if self.context then
            local furnitureDatas = DormHelper.GetFurnitureDatasByAreaName(self.context.areaType.areaName)
            self.context:ResetParams()
            self.context:EnterFitmentCallback(furnitureDatas)
        end
    end
    self:SetSweepMachine()
end

--重置家具
function M:ResetFurniture(oldFurnitureDatas, newFurnitureDatas)
    --删除旧家具
    for k, v in pairs(oldFurnitureDatas) do
        if v.parentId ~= 0 then
            self:DestroyAccessoryFurniture(v.id, v.parentId, v.posIndex)
        end
    end

    for k, v in pairs(oldFurnitureDatas) do
        if v.parentId == 0 then
            self:DestroyFurniture(v.id)
        end
    end
    --重新设置家具
    -- 优先创建非附属家具
    for k, v in pairs(newFurnitureDatas) do
        if v.parentId == 0 then
            self:CreateFurniture(v.TemplateId, v.id, v.parentId, v.posIndex)
        end
    end

    for k, v in pairs(newFurnitureDatas) do
        if v.parentId ~= 0 then
            self:CreateAccessoryFurniture(v.TemplateId, v.id, v.parentId, v.posIndex)
        end
    end
    self:SetSweepMachine()
    self:ClearChangeFurnitureData()
end

--清空更换家具数据
function M:ClearChangeFurnitureData()
    self.changeFurnitureData = {}
end

function M:UpdateRole(heroId)
    self.heroId = heroId
    self:CreateRole(heroId)
end

function M:CreateRole(heroId)
    local roomSkinCfg = DormHelper.GetRoomSkin(heroId, self.rshd.Fashion)
    self.heroModel = GameHelper.CreateDormRole(roomSkinCfg.homePrefab)
    self.heroModel.transform:SetParent(self.Home01_Root)

    self.heroModel.transform.localPosition = Vector3.New(0, 0, 0)
    self.heroModel.transform.localEulerAngles = Vector3.zero
    self.heroModel.transform.localScale = Vector3.one
    self:CheckEvent()
end

--初始化角色
function M:InitGril(position)
    DormHelper.InitGril(position)
    local dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    if dormAction then
        dormAction:DressUpCallBack(DormConst.FurnitureType.DefaultStandPoint)
    end
end

--判断宿舍事件
function M:CheckEvent()
    if self.isGuide == true then
        self:InitGril("")
        DormHelper.SetFreeLookCamera(false)
    else
        self:CheckSpecialEvent()
    end
end

-- 判断特殊事件
function M:CheckSpecialEvent()
    if self.rshd.RepresentId == 0 and PresentReturnDataMgr:GetRepresentFixedStoryByHeroId(self.heroId) == nil  then
        self.specialEventId = DormHelper.GetSpecialEvent(self.heroId)
        if self.specialEventId then
            self.specialEventcfg = ConfigHelper.GetCfgByLua("roleEvent", self.specialEventId)
            --判断触发次数是否满足
            if self.specialEventcfg.count > 0 then
                local countKey = SpecialEventCount .. self.heroId .. self.specialEventcfg.id
                local timeKey = SpecialEventTime .. self.heroId .. self.specialEventcfg.id
                local time = PlayerPrefTools.GetPlayerPrefsInt(timeKey)
                local count = PlayerPrefTools.GetPlayerPrefsInt(countKey)
                if not TimeUtil.IsToday(time) or time == 0 then
                    if DormHelper.CheckPlaySpecialEvent(self.specialEventcfg) then
                        self:InitGril(self.specialEventcfg.position)
                    else
                        self:InitGril("")
                        self.specialEventId = nil
                        self.specialEventcfg = nil
                    end
                else
                    if count < self.specialEventcfg.count then
                        if DormHelper.CheckPlaySpecialEvent(self.specialEventcfg) then
                            self:InitGril(self.specialEventcfg.position)
                        else
                            self:InitGril("")
                            self.specialEventId = nil
                            self.specialEventcfg = nil
                        end
                    else
                        self:InitGril("")
                        self.specialEventId = nil
                        self.specialEventcfg = nil
                    end
                end
            else
                if DormHelper.CheckPlaySpecialEvent(self.specialEventcfg) then
                    self:InitGril(self.specialEventcfg.position)
                else
                    self:InitGril("")
                    self.specialEventId = nil
                    self.specialEventcfg = nil
                end
            end
        else
            self:InitGril("")
        end
    else
        self:InitGril("")
    end
end

--第一段黑屏
function M:FirstStoryCallBack()
    local timelineCfg = ConfigHelper.GetCfgByLua("timeline", 3010103)
    local furnitures = {}
    if #timelineCfg.furnitureId > 0 then
        for key, value in pairs(timelineCfg.furnitureId) do
            local furniture = self:GetFurniture(value)
            if furniture then
                tInsert(furnitures, furniture.gameObj)
            end
        end
    end
    --播放timeline
    DormHelper.PlayTimeline(3010103, furnitures, function(...)
        StoryDataMgr:GetInstance():TriggerStoryByGroup(1110000002, Bind(self, self.SecondStoryCallBack))
        if #timelineCfg.dormParams > 0 then
            self.timelineParms = MapUtil.Find(DormConst.TimelineParms, function(c)
                return c.type == timelineCfg.dormParams[1]
            end)
            self.actionParms = timelineCfg.dormParams[2]
            if self.timelineParms then
                DormHelper.SetRoleAndCamera(self.timelineParms.furniture, self.timelineParms.watchPoint,
                    Bind(self, self.PlayFirstTimelineCallBack))
            end
        end
        
    end)
end

--播放第一段timeline回调
function M:PlayFirstTimelineCallBack()
    DormHelper.RoleAfk(false)
end

--第二段黑屏
function M:SecondStoryCallBack()
    UIContextMgr:GetInstance():Show("Dorm", self.roleStudio)
end

--触发特殊事件
function M:PlaySpecialEvent()
    --播放特殊事件
    if self.specialEventcfg then
        if self.specialEventcfg.type == DormConst.SpecialEventExpressiveType.Story then
            DormHelper.RoleAfk(false)
            if self.specialEventcfg.triggerType == DormConst.SpecialEventTriggerType.EnterDorm then
                self.specialEventStoryIndex = self.specialEventStoryIndex + 1
                local cfg = ConfigHelper.GetCfgByLua("roleEvent", self.specialEventId)
                if cfg.roomStory[self.specialEventStoryIndex] then
                    UIContextMgr:GetInstance():Show("SpecialEventStory", self.heroId, DormConst.StoryType.SpecialEventStory,
                        cfg.roomStory[self.specialEventStoryIndex], Bind(self, self.SpecialEventEndCallBack))
                end
            else
                UIContextMgr:GetInstance():Show("Dorm", self.roleStudio)
            end
            return
        end

        if self.specialEventcfg.type == DormConst.SpecialEventExpressiveType.Timeline then
            if self.specialEventcfg.triggerType == DormConst.SpecialEventTriggerType.EnterDorm then
                local timelineId = DormHelper.GetTimelineId(self.heroId, self.specialEventcfg.timeline)
                DormHelper.PlayTimeline(timelineId, nil, Bind(self, self.SpecialEventEndCallBack))
            else
                UIContextMgr:GetInstance():Show("Dorm", self.roleStudio)
            end
            return
        end

        if self.specialEventcfg.type == DormConst.SpecialEventExpressiveType.Action then
            local furnituredata = DormHelper.GetCurrentFurnitureData()
            DormHelper.PlayActionById(furnituredata, self.specialEventcfg.actionEvents, nil)
            UIContextMgr:GetInstance():Show("Dorm", self.roleStudio)
            DormHelper.RoleAfk(true)
                --设置触发次数
            if self.specialEventcfg.count > 0 then
                local countKey = SpecialEventCount .. self.heroId .. self.specialEventcfg.id
                local timeKey = SpecialEventTime .. self.heroId .. self.specialEventcfg.id
                local count = PlayerPrefTools.GetPlayerPrefsInt(countKey)
                PlayerPrefTools.SetPlayerPrefs(countKey, count + 1)
                PlayerPrefTools.SetPlayerPrefs(timeKey, TimeUtil.GetNowTimeStamp())
            end
            self.specialEventId = nil
            self.specialEventcfg = nil
            self.specialEventStoryIndex = 0
        end
    end
end

--点击触发特殊事件
function M:ClickPlaySpecialEvent()
    if self.specialEventcfg then
        UIContextMgr:GetInstance():Close("Dorm")
        if self.specialEventcfg.type == DormConst.SpecialEventExpressiveType.Story then
            DormHelper.RoleAfk(false)
            if self.specialEventcfg.triggerType == DormConst.SpecialEventTriggerType.Click then
                self.specialEventStoryIndex = self.specialEventStoryIndex + 1
                local cfg = ConfigHelper.GetCfgByLua("roleEvent", self.specialEventId)
                if cfg.roomStory[self.specialEventStoryIndex] then
                    UIContextMgr:GetInstance():Show("SpecialEventStory", self.heroId, DormConst.StoryType.SpecialEventStory,
                        cfg.roomStory[self.specialEventStoryIndex], Bind(self, self.SpecialEventEndCallBack))
                end
            end
            return
        end

        if self.specialEventcfg.type == DormConst.SpecialEventExpressiveType.Timeline then
            if self.specialEventcfg.triggerType == DormConst.SpecialEventTriggerType.Click then
                local timelineId = DormHelper.GetTimelineId(self.heroId, self.specialEventcfg.timeline)
                DormHelper.PlayTimeline(timelineId, nil, Bind(self, self.SpecialEventEndCallBack))
            end
            return
        end
    end
end

--数据处理完毕打开宿舍界面
function M:OpenDormPanel()
    --宿舍心流体验
    if self.isGuide == true then
        StoryDataMgr:GetInstance():TriggerStoryByGroup(1110000001, Bind(self, self.FirstStoryCallBack))
        self:Ready()
        return
    end

    --判断是否特殊事件
    if self.specialEventId then
        self:PlaySpecialEvent()
        self:Ready()
    else
        self.representFixedInfo = PresentReturnDataMgr:GetRepresentFixedStoryByHeroId(self.heroId)
        if self.representFixedInfo then
            UIContextMgr:GetInstance():Show("FavorStory", self.heroId, DormConst.StoryType.PresentFixedStory,
                self.representFixedInfo.Story)
        else
            --判断是否有回礼事件
            if self.rshd.RepresentId > 0 then
                local cfg = ConfigHelper.GetCfgByLua("represent", self.rshd.RepresentId)
                if cfg then
                    UIContextMgr:GetInstance():Show("FavorStory", self.heroId, DormConst.StoryType.PresentReturnStory,
                        cfg.storyID)
                else
                    UIContextMgr:GetInstance():Show("Dorm", self.roleStudio)
                end
            else
                UIContextMgr:GetInstance():Show("Dorm", self.roleStudio)
            end
        end
        self:Ready()
    end
end

--特殊事件结束回调
function M:SpecialEventEndCallBack()
    self.specialEventId = nil
    if self.specialEventcfg.type == DormConst.SpecialEventExpressiveType.Story then
        self.specialEventStoryIndex = self.specialEventStoryIndex + 1
        if self.specialEventcfg.roomStory[self.specialEventStoryIndex] then
            UIContextMgr:GetInstance():Show("SpecialEventStory", self.heroId, DormConst.StoryType.SpecialEventStory,
                self.specialEventcfg.roomStory[self.specialEventStoryIndex],
                Bind(self, self.SpecialEventStoryEndCallBack))
        else
            self:OpenDormPanel()
            DormHelper.RoleAfk(true)
        end
    end

    if self.specialEventcfg.type == DormConst.SpecialEventExpressiveType.Timeline then
        self:OpenDormPanel()
        DormHelper.RoleAfk(true)
    end

    --设置触发次数
    if self.specialEventcfg.count > 0 then
        local countKey = SpecialEventCount .. self.heroId .. self.specialEventcfg.id
        local timeKey = SpecialEventTime .. self.heroId .. self.specialEventcfg.id
        local count = PlayerPrefTools.GetPlayerPrefsInt(countKey)
        PlayerPrefTools.SetPlayerPrefs(countKey, count + 1)
        PlayerPrefTools.SetPlayerPrefs(timeKey, TimeUtil.GetNowTimeStamp())
    end
    self.specialEventcfg = nil
    self.specialEventStoryIndex = 0
end

--特殊事件故事结束回调
function M:SpecialEventStoryEndCallBack(...)
    self:OpenDormPanel()
    DormHelper.RoleAfk(true)
end

--生成小剧场任务
function M:GetDormTheater(callback)
    self.randomDormTheaterCallback = callback
    self.roomTask = DormHelper.GetDormTask(self.heroId)
    if self.rshd.EventNode ~= 0 then
        self.roomEvent = self.rshd.EventNode
        self.roomEventType = self.rshd.EventNodeType
    else
        local nextEventLevel = self.rshd:GetNextEventLevel()
        local favorLevel = self.rshd:GetFavorLevel()
        --获取下一个等级事件
        local cfg = ConfigHelper.GetCfgsByLua("heroFeeling",
            { hero = self.heroId, feelingLevel = self.rshd:GetNextEventLevel() })[1]
        --好感度等级剧场
        if self.rshd.EventLevel < nextEventLevel and favorLevel >= nextEventLevel then
            self.roomEvent = cfg.roomEvent
            self.roomEventType = DormConst.EventType.LevelDo
        end

        if self.roomEventType ~= 0 then
            DormDataMgr:HeroEventStoryTrigger(self.heroId, self.roomEventType, self.roomEvent,
                Bind(self, self.HeroEventStoryTriggerCallBack))
            return
        end
    end
    if self.randomDormTheaterCallback then
        self.randomDormTheaterCallback()
    end
    self.randomDormTheaterCallback = nil
end

function M:CheckActivityStory(callBack)
    self.checkActivityStoryCallback = callBack
    self.activityTask = DormPuzzleActivityDataMgr:GetInstance():GetActivityTask()
    self.activityData = DormPuzzleActivityDataMgr:GetInstance().activityData
    if self.activityData:GetEventNode() ~= 0 then
        self.activityEvent = self.activityData:GetEventNode()
        self.activityEventType = self.activityData:GetEventNodeType()
    else
        local activityRoomFlipCfg = DormPuzzleActivityDataMgr:GetInstance().activityRoomFlipCfg
        local historyEvent = self.activityData:GetHistoryEventNode()
        
        local missionCfgs = MissionDataMgr:GetInstance():GetMissionDatasByChapterId(activityRoomFlipCfg.chapterId)
        table.sort(missionCfgs,self.MissionSort)
        --没有历史剧情
        if historyEvent == 0 then
            local openConditions = table.csToLuaTable(missionCfgs[1].openCondition)
            local isOpen = GameHelper.CheckLockByOpenConditionIds(openConditions)
            if isOpen then
                self.activityEvent = activityRoomFlipCfg.roomStory[1]
                self.activityEventType = DormConst.EventType.LevelDo
            end
        else
            local length = #activityRoomFlipCfg.roomStory
            local idx = table.indexof(activityRoomFlipCfg.roomStory, historyEvent)
            if idx <= length -1 then
                local openConditions = table.csToLuaTable(missionCfgs[idx + 1].openCondition)
                local isOpen = GameHelper.CheckLockByOpenConditionIds(openConditions)
                if isOpen then
                    self.activityEvent = activityRoomFlipCfg.roomStory[idx + 1]
                    self.activityEventType = DormConst.EventType.LevelDo
                end
            end 
        end
        if self.activityEventType ~= 0 then
            DormPuzzleActivityDataMgr:GetInstance():FlipCardStoryTrigger(self.activityEventType,
                Bind(self, self.FlipCardEventStoryTriggerCallBack))
            return
        end
    end
    if self.checkActivityStoryCallback then
        self.checkActivityStoryCallback()
    end
    self.checkActivityStoryCallback = nil
end

--英雄触发小剧场任务回调(未接取任务)
function M:HeroEventStoryTriggerCallBack(msg)
    self.rshd:UpdateEventNode(msg.EventId)
    self.rshd:UpdateEventNodeType(msg.EventType)
    self.roomEvent = msg.EventId
    self.roomEventType = msg.EventType
    if self.randomDormTheaterCallback then
        self.randomDormTheaterCallback()
    end
    self.randomDormTheaterCallback = nil
end

--活动触发小剧场任务回调(未接取任务)
function M:FlipCardEventStoryTriggerCallBack(msg)
    self.activityEvent = msg.EventId
    self.activityEventType = msg.EventType
    if self.checkActivityStoryCallback then
        self.checkActivityStoryCallback()
    end
    self.checkActivityStoryCallback = nil
end

function M:EnableMachine(value)
    if self.sweepMachine then
        self.sweepMachine:EnableActivityRegion(value)
        self.sweepMachine:EnableMachine(not value)
    end
end

function M:ResetSpecialEvent()
    self.specialEventId = nil
    self.specialEventcfg = nil
    self.specialEventStoryIndex = 0
end

function M:CheckActivityStoryRedpoint()
    if self.activityEvent > 0 and self.activityEventType == DormConst.EventType.LevelDoing then
        return true
    end
    return false
end

function M:DestroyLoad()
    DormHelper.RemoveTouchEvent()
    DormHelper.RoleAfk(false)
    GameUtil.DestroyGo(self.heroModel.gameObject)
    GameUtil.DestroyGo(self.FurnitureAgent.gameObject)
    DormHelper.ChangeCameraType(0)
end

function M:OnExit()
    --离开宿舍埋点
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Dormitory_out)
    UIContextMgr:GetInstance():Close("Dorm")
    self:DisposeCameraDirector()
    self.heroId = 0
    self:ResetSpecialEvent()
    self._view = nil
    self.heroModel = nil
    self.FurnitureAgent = nil
    DormActionMgr:GetInstance():Cleanup()
    if self.sweepMachine then
        self.sweepMachine:OnDispose()
    end
    self.sweepMachine = nil
    self.furnitureServerData = {}

    M.super.OnExit(self)
end

return DormModule
