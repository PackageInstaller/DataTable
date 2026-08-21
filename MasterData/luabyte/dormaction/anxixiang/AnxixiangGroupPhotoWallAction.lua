local AnxixiangGroupPhotoWallAction = BaseClass("AnxixiangGroupPhotoWallAction")
local M = AnxixiangGroupPhotoWallAction

function M:__init(csfurnitureDatas)
    self:ConvertData(csfurnitureDatas)
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.groupPhotoWallData = self:GetGroupPhotoWallData()
    self.OnRoleClickEventHandle = Bind(self, self.RoleClickEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormRoleClickEvent", self.OnRoleClickEventHandle)
    self.dormAction.state = DormConst.RoleState.Command
    self:RootFuriture()
end

function M:CheckRoleIn()
    if DormHelper.CheckIsMoving() then
        return false
    else
        self.curFurnitureId = DormHelper.GetCurrentFurnitureId()
        return self.curFurnitureId == self.groupPhotoWallData.Id
    end
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
            if assetData ~= nil then
                table.insert(self.furnitureDatas, assetData)
            end
        end
    end
end

function M:GetGroupPhotoWallData()
    return MapUtil.Find(self.furnitureDatas, function(v)
        local cfg = ConfigHelper.GetCfgByLua("houseFurniture", v.TemplateId)
        return cfg.type == DormConst.FurnitureType.GroupPhotoWall
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
            table.insert(self.soltFurniture, require(config.dormaction).New(v.id, self))
        end
    end
end

--角色点击事件
function M:RoleClickEventHandle(handler)
    if  self.dormAction.module.specialEventId then
        return
    end

    if self.dormAction.isCalling then
        return
    end

    if self:CheckRoleIn() then
        if self.dormAction.state == DormConst.RoleState.Command then
            if handler.rolePointType == DormConst.RolePointType.Player1 and handler.actionType == DormConst.RoleActionType.Enter then
                return
            end
            --进入交互状态
            self.dormAction:EnterInteract()
            if handler.rolePointType == DormConst.RolePointType.Player2 or
                handler.rolePointType == DormConst.RolePointType.NavMesh1 then
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                local actionName = 'Common_Stand_Player2_TurnRightToPlayer1_Show'
                DormHelper.PlayAction(self.curFuritureData, actionName)
            end

            if handler.rolePointType == DormConst.RolePointType.Player1 then
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                local actionName = 'Common_Stand_Player1_Idle_Stay'
                DormHelper.PlayAction(self.curFuritureData, actionName)
            end
            return
        end

        if self.dormAction.state == DormConst.RoleState.Interact then
            if handler.actionName == "Common_Stand_Player1_Idle_Stay" or handler.actionName == "Common_Move_Player1_Idle_Stay" or handler.actionName == "" then
                DormHelper.SetRandomShow(false)
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                self.dormAction:PlayRandomClick(DormConst.FurnitureType.GroupPhotoWall, 0, self.curFuritureData)
            end
        end
    end
end

function M:ExitInteract()

end

function M:Dispose()
    if self.soltFurniture then
        for k, v in pairs(self.soltFurniture) do
            v:Dispose()
        end
        
        self.soltFurniture = nil
    end
    
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormRoleClickEvent", self.OnRoleClickEventHandle)
end

return AnxixiangGroupPhotoWallAction
