local TaskAwardItemCtrl = BaseClass("TaskAwardItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))
local M = TaskAwardItemCtrl

function M:Init()
    self:EnablePopItem(true)
    self:SetItemNameActive(true)
end

function M:UpdateItem(data)
    if data == nil then
        return
    end
    self._view.item:SetZeroRotation()
    self:SetInfo(data.Id, ItemNumberType.TOTLE, data.Num)
    self:SetFinish(data.state == TaskConst.TaskState.TaskComplete)
    self._data = data
end

function M:SetItem(itemId, itemCount)
    if self._itemId ~= itemId then
        self._view.icon:SetItemIcon(itemId)
        if self._view.quality then
            self._view.quality:SetItemQuality(itemId)
        end
    end
    if self._itemCount ~= itemCount and self._view.numberTf then
        if itemCount > 10000 then
            self._view.numberTf:SetText(tostring(itemCount * 0.001) .. "k")
        else
            self._view.numberTf:SetText(tostring(itemCount))
        end
    end
    self._itemId = itemId
    self._itemCount = itemCount
end

return TaskAwardItemCtrl
