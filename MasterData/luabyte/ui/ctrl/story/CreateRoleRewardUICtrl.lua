local M = BaseClass("CreateRoleRewardUICtrl", BaseUICtrl)

function M:Init()
    self.m_params = ConfigHelper.GetSystemParams(102)
    local itemView = require("UI.View.Common.ItemPfbView")
    local itemCtrl = require("UI.Ctrl.Common.CommonItemCtrl")
    self._view.btn_confirm:onClick(Bind(self, self.OnClickClose))
    self._view.looplist:Init(itemCtrl, itemView)
end

function M:OnEnter(onClose)
    self.m_onClose = onClose
    local list, nType = {}, ItemNumberType.TOTLE
    for i = 0, self.m_params.Length - 1, 2 do
        local id, num = self.m_params[i], self.m_params[i + 1]
        if (id > 0) and (num > 0) then
            table.insert(list, { itemId = id, numType = nType, itemNum = num, isPopItem = false })
        end
    end
    self._view.looplist:SetDataList(list)
end

function M:OnDispose()
    M.super.OnDispose(self)
    if self.m_onClose then
        self.m_onClose()
    end
    self.m_onClose = nil
end

function M:OnClickClose()
    local ids, cnts = {}, {}
    for i = 0, self.m_params.Length - 1, 2 do
        local id, num = self.m_params[i], self.m_params[i + 1]
        if (id > 0) and (num > 0) then
            table.insert(ids, id)
            table.insert(cnts, num)
        end
    end
    GameHelper.ShowCreateRoleRewards(ids, cnts)
    self:Close()
end

return M
