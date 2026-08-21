local YisongyingBedAction = BaseClass("YisongyingBedAction")
local M = YisongyingBedAction

function M:__init(csfurnitureDatas)
    self:ConvertData(csfurnitureDatas)
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.bedData = self:GetBedData()
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
        return self.curFurnitureId == self.bedData.Id
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

function M:GetBedData()
    return MapUtil.Find(self.furnitureDatas, function(v)
        local cfg = ConfigHelper.GetCfgByLua("houseFurniture", v.TemplateId)
        return cfg.type == DormConst.FurnitureType.Bed
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
            self.dormAction:EnterInteract()
            if handler.rolePointType == DormConst.RoleActionType.Player1 then
                local actionName = 'Common_Move_Bed_Player1_Stay'
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                DormHelper.PlayAction(self.curFuritureData, actionName)
            end

            if handler.rolePointType == DormConst.RolePointType.Player3 then
                local actionName = 'Common_Move_Bed_Player3_Exit'
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                DormHelper.PlayAction(self.curFuritureData, actionName)
            end
            return
        end

        if self.dormAction.state == DormConst.RoleState.Interact then
            if handler.actionName == "Common_Move_Bed_Player1_Stay" or handler.actionName == "" or handler.actionName == "Common_Sit_Player1_Idle_Stay" then
                DormHelper.SetRandomShow(false)
                self.curFuritureData = DormHelper.GetCurrentFurnitureData()
                self.dormAction:PlayRandomClick(DormConst.FurnitureType.Bed, 0, self.curFuritureData)
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

return YisongyingBedAction
