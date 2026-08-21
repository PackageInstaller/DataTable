local FurnitureItemCtrl = BaseClass("FurnitureItemCtrl")
local M = FurnitureItemCtrl
local seconds = 157680000
function M:__init(view)
    self._view = view
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.context = UIContextMgr:GetInstance():GetContext("DormitoryDressupUI")
    self._view.transform:onClick(Bind(self, self.ClickItem))
    self._view.BtnTips.transform:onClick(Bind(self, self.ClickTips))
end

function M:ClickItem(go)
    if self.data.isSelect then
        return
    end

    OtakuFurniturDataMgr:SetCach(self.data.FurnitureId)
    self:CheckRedPoint()
    EventMgr:Broadcast(UIMessageNames.DORM_FURNITURE_REDPOINT)
    --筛选可布置的槽位
    if self.context.operationType == DormConst.DressUpOperationType.None then
        if self.data.type == DormConst.DressupTableType.AccessoryFurniture then
            self.context:SetOperationType(DormConst.DressUpOperationType.SelectAccessoryFurniture)
            self:FindSlots()
            return
        end

        if self.data.type == DormConst.DressupTableType.ParentFurniture then
            self:FindParentSlots()
            return
        end
    end

    --重新筛序父家具可布置槽位
    if self.context.operationType == DormConst.DressUpOperationType.SelectParentFurniture then
        self:FindParentSlots()
        return
    end

    --重新筛选可布置槽位
    if self.context.operationType == DormConst.DressUpOperationType.SelectAccessoryFurniture then
        self:FindSlots()
        return
    end

    --替换父家具
    if self.context.operationType == DormConst.DressUpOperationType.SelectParentSlot then
        if self.data.type == DormConst.DressupTableType.ParentFurniture then
            self.module:ChangeFurniture(self.context.furnitureData.MainAssetType, self.data.FurnitureId, self.data.TemplateId)
            EventMgr:Broadcast(UIMessageNames.DORM_SELECT_FURNITURE, self.data.FurnitureId)
            return
        end
    end

    --替换附属家具
    if self.context.operationType == DormConst.DressUpOperationType.SelectSlot then
        if self.data.type == DormConst.DressupTableType.AccessoryFurniture then
            self.module:ChangeAccessoryFurniture(self.context.assetData.Id, self.context.homeFurnitureSlot.SlotID,
                self.data.FurnitureId, self.data.TemplateId)
            EventMgr:Broadcast(UIMessageNames.DORM_SELECT_FURNITURE, self.data.FurnitureId)
            return
        end
    end
end

function M:FindParentSlots()
    self.context:SetBeforeOperationData(DormConst.DressupTableType.ParentFurniture, self.data.cfg.type)
    self.context:SetOperationType(DormConst.DressUpOperationType.SelectParentFurniture)
    self.context:SetSelectedFurnitureData(self.data)
    self.context:SelectParentSlot()
    EventMgr:Broadcast(UIMessageNames.DORM_SELECT_FURNITURE, self.data.FurnitureId)
end

function M:FindSlots()
    self.context:SetSelectedFurnitureData(self.data)
    for key, value in pairs(self.data.cfg.positionId) do
        DormHelper.AreaSlotWaitSelect(true, value)
    end
    EventMgr:Broadcast(UIMessageNames.DORM_SELECT_FURNITURE, self.data.FurnitureId)
end

function M:ClickTips(go)
    GameHelper.PopItem(self.data.TemplateId, 0, self._view)
end

function M:UpdateItem(data)
    if data == nil then
        return
    end

    self.data = data
    if data.type == DormConst.DressupTableType.ParentFurniture or
        data.type == DormConst.DressupTableType.AccessoryFurniture then
        self._view.UIState:SetState(3)
        local itemCfg = ConfigHelper.GetCfgByLua("item", data.TemplateId)
        self._view.Name:SetText(itemCfg.name)
        self._view.Icon:SetItemIcon(data.TemplateId)
        self._view.Quality:SetPic("UI/SpritePics/dormitory/ui_dormitory_furniture_bg0" .. itemCfg.quality)
        self._view.AtmosphereNum:SetText(tostring(data.cfg.atmosphere))
        self:SetSelect()
        self:CheckRedPoint()
    end
    self._view.transform:SetLocalRotation(0, 0, 0)
end

function M:CheckRedPoint()
    local id = self.data.FurnitureId % seconds
    self._view.Redpoint:SetParam(0, id)
    self._view.Redpoint:Check()
end

function M:SetSelect()
    self._view.On.gameObject:SetActive(self.data.isSelect)
end

function M:OnDispose()
    self.module = nil
    self.context = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return FurnitureItemCtrl
