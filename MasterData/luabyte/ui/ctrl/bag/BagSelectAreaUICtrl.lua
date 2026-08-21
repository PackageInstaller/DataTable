local BagSelectAreaUICtrl = BaseClass("BagSelectAreaUICtrl")
local M = BagSelectAreaUICtrl

function M:__init(view)
    self._view = view
    self.m_callback = nil
    self._curItemData = nil
    self._numberBar = self._view.numberBar
    self._view.okBtn:onClick(Bind(self, self.OnClickConfirm))
    self._view.cancelBtn:onClick(Bind(self, self.OnClickCancle))
    self._updateItems = Bind(self, self._UpdateItems)
    self._useItemSucCallback = EventMgr:AddListener(UIMessageNames.BAG_USE_ITEM_SUC, Bind(self, self._OnUserSuc))
    self._items = {}
    for i = 1, 2 do
        table.insert(self._items, self._view["item" .. i])
    end
end

function M:OnDispose()
    self._numberBar:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.BAG_USE_ITEM_SUC, self._useItemSucCallback)
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:OnClickCancle(go)
    if self.m_callback then
        self.m_callback()
    end
end

function M:OnClickConfirm(go)
    if self._curItemData == nil then
        GameHelper.TipsById(4112)
        return
    end
    local selectNum = self._numberBar:GetSelectNumber()
    if selectNum == 0 then
        GameHelper.TipsById(4113)
        return
    end
    local packageId = self._curItemData.PackageId
    local isLimitItem = self._curItemData:IsLimitItem()
    EventMgr:Broadcast(UIMessageNames.BAG_USE_ITEM, packageId, selectNum, nil, isLimitItem)
end

function M:Enable(itemData)
    self._curItemData = nil
    local isEnable = itemData ~= nil
    self._view:SetActive(isEnable)
    self:_SetSelectData(itemData)
end

function M:_SetSelectData(itemData)
    if not self._view:GetActive() then return end

    self._curItemData = itemData
    if self._curItemData then
        local itemCfg = self._curItemData:GetItemCfg()
        local decompose = itemCfg.decompose == 1
        self._view.node_decompTip:SetActive(not decompose)
        self._view.node_decomp:SetActive(decompose)
        self._view.okBtn:SetActive(decompose)
        self._numberBar:SetNumberInfo(1, self._curItemData.Num, self._updateItems)
    else
        for _, item in ipairs(self._items) do
            item:SetActive(false)
        end
        self._view.node_decomp:SetActive(false)
        self._view.okBtn:SetActive(false)
    end
end

function M:_OnUserSuc()
    if not self._view:GetActive() then return end
    if self._curItemData.Num > 0 then
        self:_SetSelectData(self._curItemData)
    else
        self:OnClickCancle(nil)
    end
end

function M:_UpdateItems(number)
    if not self._curItemData then return end

    local cfg = self._curItemData:GetItemCfg()
    local itemIds = cfg.decomposeItem
    local itemNumbers = cfg.decomposeNum
    for i = 1, #self._items do
        local item = self._items[i]
        local csIdx = i - 1
        if csIdx < itemIds.Length then
            item:SetInfo(itemIds[csIdx], ItemNumberType.TOTLE, itemNumbers[csIdx] * number)
            item:SetActive(true)
        else
            item:SetActive(false)
        end
    end
end

-- 关闭当前面板回调
function M:SetDisableCallback(action)
    self.m_callback = action
end

function M:SetActive(value)
    self._view:SetActive(value)
end

return BagSelectAreaUICtrl
