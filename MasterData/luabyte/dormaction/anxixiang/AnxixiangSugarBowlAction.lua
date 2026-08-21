local AnxixiangSugarBowlAction = BaseClass("AnxixiangSugarBowlAction")
local M = AnxixiangSugarBowlAction
local tInsert = table.insert
function M:__init(furnitureId, parentAction)
    self.furnitureId = furnitureId
    self.parentAction = parentAction
    self.heroId = self.parentAction:HeroId()
    self.OnClickEventHandle = Bind(self, self.DormClickFurnitureSlotEventHandle)
    self.furniture = self.parentAction.dormAction.module:GetFurniture(self.furnitureId)
    IGameEventMgr:RegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnClickEventHandle)
end

function M:DormClickFurnitureSlotEventHandle(handler)
    --布置家具时忽略点击
    if self.parentAction.dormAction.state == DormConst.RoleState.Command or self.parentAction.dormAction.state == DormConst.RoleState.Interact then
        if handler.slotAssetData and handler.slotAssetData.Id == self.furnitureId then
            self:OnClickAction()
        end
    end
end

function M:OnClickAction()
    if self.furniture then
        self.furniture:PlayClickAnimation()
    end
end

function M:OpenSugarBowl()
    UIContextMgr:GetInstance():Show("GeneralBook", 215002)
end

function M:ChangeState(level)
    local animations = {}
    local timelineCount = PlayerPrefTools.GetPlayerPrefsInt("SugarBow", 0)
    
    if timelineCount == 0 then
        tInsert(animations, { index = 3, rate = 100 })
        --点击糖罐 30% 抖动 ， 70% 喂糖
    elseif level >= 0 and level <= 9 then
        tInsert(animations, { index = 1, rate = 30 })
        tInsert(animations, { index = 3, rate = 70 })
        --20% 抖动 ,  60% 喂糖 ， 20% 询问吃糖
    elseif level >= 10 and level <= 12 then
        tInsert(animations, { index = 1, rate = 20 })
        tInsert(animations, { index = 3, rate = 60 })
        tInsert(animations, { index = 2, rate = 20 })
    elseif level > 12 then
        -- body
        tInsert(animations, { index = 1, rate = 10 })
        tInsert(animations, { index = 3, rate = 60 })
        tInsert(animations, { index = 2, rate = 30 })
    end
    
    self:PlayAnimation(animations)
end

function M:PlayAnimation(animations)
    if #animations <= 0 then
        return 
    end
    
    local rate = math.random(1, 100)
    local totalRate = 0
    local index = 0
    
    for i, v in ipairs(animations) do
        totalRate = totalRate + v.rate
        
        if index == 0 and rate <= totalRate then
            index = v.index
        end
    end
    
    --抖动弹出糖罐ui
    if index == 1 then
        self:OnClickAction()
    elseif index == 2 then
        --询问吃糖
        local actioncfg = DormHelper.GetAction(self.parentAction.dormAction.heroId, DormConst.ActionType.SofaSugarAction, DormConst.FurnitureType.MainSofa, 215002)
        
        if actioncfg then
            self.curFuritureData = DormHelper.GetCurrentFurnitureData()
            
            if not IsNull(self.curFuritureData) then
                DormHelper.PlayAction(self.curFuritureData, actioncfg.name)
            end
        end
    elseif index == 3 then
        --喂糖
        if self.parentAction.dormAction:CheckMoodweight() then
            DormHelper.PlayTimeline(300104, self.furniture.gameObj, function(...)
                DormHelper.SetGuideVirtualCamera(false)
                self.parentAction:SofaAction()
                local timelineCount = PlayerPrefTools.GetPlayerPrefsInt("SugarBow", 0)
                PlayerPrefTools.SetPlayerPrefs("SugarBow", 1 + timelineCount)
            end)
        else
            DormHelper.RoleAfk(true)
        end
    end
end

function M:Dispose()
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnClickEventHandle)
end


return AnxixiangSugarBowlAction
