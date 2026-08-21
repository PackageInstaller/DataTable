local NormalSlotFurnitureAction = BaseClass("NormalSlotFurnitureAction")
local M = NormalSlotFurnitureAction

function M:__init(furnitureId, parentAction)
    self.furnitureId = furnitureId
    self.curFurnitureId = DormHelper.GetCurrentFurnitureId()
    self.curFuritureData = DormHelper.GetCurrentFurnitureData()
    self.parentAction = parentAction
    self.OnDormClickFurnitureEventHandle = Bind(self, self.DormClickFurnitureSlotEventHandle)
    IGameEventMgr:RegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnDormClickFurnitureEventHandle)
end

-- 点击附属家具回调
function M:DormClickFurnitureSlotEventHandle(handler, callback)
    -- 布置家具时忽略点击
    if self.parentAction.dormAction.state == DormConst.RoleState.Command or self.parentAction.dormAction.state == DormConst.RoleState.Interact then
    -- 点击抖动
        if handler.slotAssetData and handler.slotAssetData.Id == self.furnitureId then
            local furniture = self.parentAction.dormAction.module:GetFurniture(self.furnitureId)
            if furniture then
                furniture:PlayClickAnimation(callback)
            end
        end
    end
    
    if not handler.slotAssetData then 
        return 
    end
    local templateId = handler.slotAssetData.TemplateId
    local houseFurniture = ConfigHelper.GetCfg("houseFurniture", templateId)
end

function M:Dispose()
    IGameEventMgr:UnRegisterEventHandleByTypeName("DormClickFurnitureSlotEvent", self.OnDormClickFurnitureEventHandle)
end

return NormalSlotFurnitureAction
