local AnxixiangPhotoWallAction = BaseClass("AnxixiangPhotoWallAction")
local M = AnxixiangPhotoWallAction
local tInsert = table.insert

function M:__init(furnitureDatas, dormAction)
    self:ConvertData(furnitureDatas)
    self.dormAction = dormAction
    
    self.curFurnitureId = DormHelper.GetCurrentFurnitureId()
    self.curFuritureData = DormHelper.GetCurrentFurnitureData()
    self.photoWallData = self:GetPhotoWallData()
    self.OnRoleClickEventHandle = Bind(self, self.RoleClickEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormRoleClickEvent", self.OnRoleClickEventHandle)
    self.dormAction.state = DormConst.RoleState.Command
    self:RootFuriture()
    self.isMood = false
end

function M:CheckRoleIn()
    self.curFurnitureId = DormHelper.GetCurrentFurnitureId()
    return self.curFurnitureId == self.photoWallData.Id
end

function M:HeroId()
    return self.dormAction.module.heroId
end

function M:ConvertData(data)
    local len = data.Length
    self.furnitureDatas = {}
    
    for i = 0, len - 1 do
        local item = data[i]
        
        if item.FurnitureName then
            local assetData = DormHelper.GetFurnitureAssetDataByName(item.FurnitureName)
            if assetData~=nil then
                local cfg = ConfigHelper.GetCfgByLua("houseFurniture", assetData.TemplateId)
            
                if cfg.type == DormConst.FurnitureType.PhotoWall then
                    tInsert(self.furnitureDatas, assetData)
                end
            end

        end
    end
end

function M:GetPhotoWallData()
    return MapUtil.Find(self.furnitureDatas, function(v)
        local cfg = ConfigHelper.GetCfgByLua("houseFurniture", v.TemplateId)
        return cfg.type == DormConst.FurnitureType.PhotoWall
    end)
end

function M:RootFuriture()
    if self.soltFurniture then
        for k, v in pairs(self.soltFurniture) do
            v:Dispose()
        end
    end
    
    self.soltFurniture = {}
    
    for k, v in pairs(self.furnitureDatas) do
        self:BranchFuriture(v.Id)
    end
end

function M:BranchFuriture(dormId)
    local parents = self.dormAction.module:GetSlotFurnituresById(dormId)
    
    for k, v in pairs(parents) do
        local config = MapUtil.Find(SlotFurnitureActionConfig, function(c)
            return c.templateId == v.TemplateId and (c.heroId == self.dormAction.heroId or c.heroId == 0)
        end)
        
        if config then
            tInsert(self.soltFurniture, require(config.dormaction).New(v.id, self))
        end
    end
end

function M:RoleClickEventHandle(handler)
    if self:CheckRoleIn() then
        if self._photoWallTimer then
            self._photoWallTimer:Stop()
        end
        
        if self.dormAction.state == DormConst.RoleState.Command then
            --进入交互状态
            self.dormAction:EnterInteract()
            local actionName = 'Common_Photowall_Idle_1_Stay'
            self.curFuritureData = DormHelper.GetCurrentFurnitureData()
            DormHelper.PlayAction(self.curFuritureData, actionName, function()

            end)
        end
    end
end

--照片墙心情演出
function M:PhotoWallMoodAction()
    local actioncfg = DormHelper.GetAction(self.dormAction.heroId, DormConst.ActionType.PhotoWallMoodAction, DormConst.FurnitureType.PhotoWall, nil)
    
    if actioncfg then
        DormHelper.PlayAction(self.curFuritureData, actioncfg.name, function()
            self:PhotoWallAction(true)
        end)
    end
end

function M:PhotoWallAction(isMood)
    local actionName = "Common_Photowall_Idle_1_Stay"
    DormHelper.PlayAction(self.curFuritureData, actionName)
    self.isMood = isMood
    
    if self._photoWallTimer then
        self._photoWallTimer:Stop()
    end
    
    self.photoWallTime = 0
    self._photoWallTimer = TimerManager:GetInstance():GetTimer(1, Bind(self, self.PhotoWallTick), self)
    self._photoWallTimer:Start()
end

function M:PhotoWallTick()
    self.photoWallTime = self.photoWallTime + 1
    
    if self.photoWallTime >= 10 then
        self._photoWallTimer:Stop()
        
        if self.isMood then
            DormHelper.PlayAction(self.curFuritureData, "Common_photowall_think_Stay")
        else
            self:PhotoWallMoodAction()
        end
    end
end

function M:InviteGirlCallBack()
    self.curFuritureData = DormHelper.GetCurrentFurnitureData()
    self:PhotoWallAction(false)
end

function M:Dispose()
    if self._photoWallTimer then
        self._photoWallTimer:Stop()
    end
    
    if self.soltFurniture then
        for k, v in pairs(self.soltFurniture) do
            v:Dispose()
        end
        
        self.soltFurniture = nil
    end
    
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormRoleClickEvent", self.OnRoleClickEventHandle)
end

return AnxixiangPhotoWallAction
