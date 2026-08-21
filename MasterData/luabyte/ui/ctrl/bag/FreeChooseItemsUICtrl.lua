local M = BaseClass("FreeChooseItemsUICtrl", BaseUICtrl)

function M:Init()
    self._itemId = 0
    self._itemNum = 0
    self._packageId = 0
    self._looplist = self._view.scrollview
    self._view.mask:onClick(Bind(self, self.Close))
    self._view.ok:onClick(Bind(self, self.OnClickOk))
    self._view.clean:onClick(Bind(self, self.OnClean))
    self._onItemChange = Bind(self, self.OnCheckItemChange)
    self._looplist:SetCreateItemCallback(Bind(self, self.OnItemCreate))
    self._looplist:Init(require("UI.Ctrl.Bag.FreeChooseItemCtrl"), require("UI.View.Bag.FreeChooseItemView"))
end

function M:OnEnter(itemId, packageId, itemNum)
    self._itemId = itemId
    self._itemNum = itemNum
    self._packageId = packageId
    self._view.curNum:SetText(self._itemNum .. "/" .. self._itemNum)
    self._looplist:SetDataList(ItemHelper.GetFreeItemsByItemId(itemId))
end

function M:OnDispose()
    self._looplist:Dispose()
    self._onItemChange = nil
    self._looplist = nil
    self._packageId = nil
    self._itemNum = nil
    self._itemId = nil
    M.super.OnDispose(self)
end

--单个ITEM创建时，设置点击回调
function M:OnItemCreate(item)
    item:SetClickCallback(self._onItemChange)
end

--单个Item数据改变时回调，用于更新当前道具数量
function M:OnCheckItemChange(isAdd)
    local num, list = 0, self._looplist:GetDataList()
    for _, v in ipairs(list) do
        num = num + v.selectedCount
    end
    num = isAdd and (num + 1) or (num - 1)
    if num < 0 then
        return false
    elseif num > self._itemNum then
        return false
    end
    self._view.curNum:SetText((self._itemNum - num) .. "/" .. self._itemNum)
    return true
end

--点击清除时更新
function M:OnClean(go)
    local list = self._looplist:GetDataList()
    for _, v in ipairs(list) do v.selectedCount = 0 end
    self._view.curNum:SetText(self._itemNum .. "/" .. self._itemNum)
    self._looplist:UpdateList()
end

--点击OK时发送事件到 BagUIContext中去统一处理
function M:OnClickOk(go)
    local list = self._looplist:GetDataList()
    local num = 0
    local indexArr = {}
    for i, v in ipairs(list) do
        num = num + v.selectedCount
        if v.selectedCount > 0 then
            for j = 1, v.selectedCount do
                table.insert(indexArr, i)
            end
        end
    end
    if num == 0 then
        GameHelper.TipsById(4111)
        return
    end

    local isLimitItem, packageId = false, self._packageId
    local itemCfg = ConfigHelper.GetCfgByLua("item", self._itemId)
    if itemCfg then isLimitItem = itemCfg.type == BagConst.ItemType.EIT_EnergyItem end
    self:Close()
    EventMgr:Broadcast(UIMessageNames.BAG_FREE_USE_ITEM, packageId, num, indexArr, isLimitItem)
end

return M
