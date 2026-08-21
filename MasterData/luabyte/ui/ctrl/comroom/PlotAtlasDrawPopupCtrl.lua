local M = BaseClass("PlotAtlasDrawPopupCtrl", BaseUICtrl)

local itemCtrl = require("UI.Ctrl.ComRoom.PlotAtlasDrawItemCtrl")
local itemView = require("UI.View.ComRoom.PlotAtlasDrawItemView")

-- 百科图鉴详情
function M:Init()
    self._data = nil
    self._index = 0
    self._view.btn_back:onClick(Bind(self, self.OnClickBack))
    self._view.btn_left:onClick(Bind(self, self.OnClickLeft))
    self._view.btn_right:onClick(Bind(self, self.OnClickRight))
end

function M:OnEnter(data, index)
    self._data = data
    self._index = index
    local width = self._view.transform.rect.width
    local height = self._view.transform.rect.height
    self._view.drawItem:SetRectSizeDelta(width, height)
    self._view.node_list:SetHeightAndWidth(width, height)
    self._view.node_list:Init(itemCtrl, itemView)
    self._view.node_list:SetDataList(self._data)
    self._view.node_list:SetDragState(true)
    self._view.node_list:SetHorizontalNormalizedByIndex(self._index)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true 
end

function M:OnClose()
    self._index = 0
    self._data = nil
end

-- 返回按钮
function M:OnClickBack(go)
    self:Close()
end

function M:OnClickLeft(go)
    self._view.node_list:MoveLastPosition()
    self._view.node_list:UpdateList()
end

function M:OnClickRight(go)
    self._view.node_list:MoveNextPosition()
    self._view.node_list:UpdateList()
end

return M
