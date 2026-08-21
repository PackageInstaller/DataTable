local DormitoryDressupSuitPopupCtrl = BaseClass("DormitoryDressupSuitPopupCtrl", BaseUICtrl)
local M = DormitoryDressupSuitPopupCtrl

function M:Init()
    self._view.Mask:onClick(Bind(self, self.OnClickMask))
    self._view.BtnGet:onClick(Bind(self, self.OnClickGet))
    self._view.BtnEquip:onClick(Bind(self, self.OnClickEquip))
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.dormAction = DormActionMgr:GetInstance():GetCurrentDormAction()
    self.context = UIContextMgr:GetInstance():GetContext("DormitoryDressupUI")
    self.itemCtrlList = {}
    for i = 1, 6 do
        table.insert(self.itemCtrlList,self._view["SuitItem" .. i])
    end
end

function M:OnEnter(suitData)
    self.suitData = suitData
    self:InitSuit()
end

function M:InitSuit()
    if  self.suitData.isHave then
        self._view.UIState:SetState(1)
    else
        self._view.UIState:SetState(2)
    end
    for i = 1, #self.itemCtrlList do
        if self.suitData.suitFurnitures[i] then
            self.itemCtrlList[i]:Enable(true)
            self.itemCtrlList[i]:UpdateData(self.suitData.suitFurnitures[i])
        else
            self.itemCtrlList[i]:Enable(false)
        end
    end
end

function M:OnClickMask(go)
    self:Close()
end

function M:OnClickGet(go)
    GameHelper.Jump(4)
end

function M:OnClickEquip(go)
    for key, value in pairs(self.suitData.suitFurnitures) do
        if value.isDressUp == false then
            local furnitureData = self:FindDressupFurniture(value)
            if value.type == DormConst.DressupTableType.ParentFurniture then
                self.module:ChangeFurniture(value.cfg.type, furnitureData.FurnitureId, furnitureData.TemplateId)
            end

            if value.type == DormConst.DressupTableType.AccessoryFurniture then
                local parentFurnitureData = self.module:GetFurnitureByType(value.furniturePosition)
                self.module:ChangeAccessoryFurniture(parentFurnitureData.id, value.position, furnitureData.FurnitureId, furnitureData.TemplateId)
            end
        end
    end
    EventMgr:Broadcast(UIMessageNames.DORM_DRESSUP_SUIT_BACK)
    self:Close()
end

function M:FindDressupFurniture(furnitureData)
    local furnitures = furnitureData.furnitures
    local type = furnitureData.type
    local data = furnitures[1]
    for i = 1, #furnitures do
        if furnitures[i].HeroId == 0 then
            data = furnitures[i]
            break
        end
    end
    --套装家具在其他宿舍布置时为其他宿舍替换默认家具
    if type == DormConst.DressupTableType.ParentFurniture and data.HeroId ~= 0 then
        local defaultFurnitureData = self.context:GetDefaultFurnitureByType(data.cfg.type)
        if defaultFurnitureData then
            self.module:UpdateChangeFurnitureData(defaultFurnitureData)
        end
    end
    return data
end

function M:OnDispose()
    for key, value in pairs(self.itemCtrlList) do
        value:OnDispose()
    end
    self.itemCtrlList = nil
    M.super.OnDispose(self)
end

return DormitoryDressupSuitPopupCtrl
