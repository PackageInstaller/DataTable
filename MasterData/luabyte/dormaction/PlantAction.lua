local PlantAction = BaseClass("PlantAction")
local M = PlantAction

function M:__init(furnitureId, parentAction)
    self.isHere = false
    self.furnitureId = furnitureId
    self.parentAction = parentAction
    self.pot = nil
    self.shovel = nil
    self.furnitureData = self.parentAction.dormAction.module:GetFurniture(self.furnitureId)
    self.potParent = self.furnitureData.gameObj.transform:FindChildren("Pot")
    self.shovelParent = self.furnitureData.gameObj.transform:FindChildren("Shovel")
    
    self.OnClickEventHandle = Bind(self, self._RoleClickEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnClickEventHandle)
    self.stateEvent = EventMgr:AddListener(UIMessageNames.DORM_PLANT_HANDLE, Bind(self, self.StateHandle))
end

function M:_RoleClickEventHandle(handler)
    --布置家具时忽略点击
    if self.parentAction.dormAction.state == DormConst.RoleState.Command then
        
    end
end

function M:StateHandle(furnitureId, index)
    if furnitureId ~= self.furnitureId then
        return 
    end
    
    if index == 1 then
        self:PlayPlantWaterAni()
        return 
    end
    
    self:PlayPlantPestsFall()
end

function M:PlayPlantWaterAni()
    self.pot = ResourceManager:GetInstance():InstanceGameObject("Furniture/common_smallFurniture_pot_2")
    self.pot.transform:SetParent(self.potParent)
    self.pot.transform:SetLocalPos(0, 0, 0)
    self.furnitureData:PlayClickAnimation(Bind(self, self.OnPlayPlantWaterCallBack))
end

function M:OnPlayPlantWaterCallBack()
    DormDataMgr:DoRqWaterThePlant(self.furnitureId)
    
    if self.pot then
        GameUtil.DestroyGo(self.pot)
        self.pot = nil
    end
end

function M:PlayPlantPestsFall()
    self.shovel = ResourceManager:GetInstance():InstanceGameObject("Furniture/common_smallFurniture_shovel_1")
    self.shovel.transform:SetParent(self.shovelParent)
    self.shovel.transform:SetLocalPos(0, 0, 0)
    self.furnitureData:PlayClickAnimation(Bind(self, self.OnPlayPlantPestsCallBack))
end

function M:OnPlayPlantPestsCallBack()
    DormDataMgr:DoRqKillBug(self.furnitureId)
    
    if self.shovel then
        GameUtil.DestroyGo(self.shovel)
        self.shovel = nil
    end
end

function M:Dispose()
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormClickFurnitureSlotEvent",self.OnClickEventHandle)
    EventMgr:RemoveListener(UIMessageNames.DORM_PLANT_HANDLE, self.stateEvent)
end



return PlantAction
