local M = BaseClass("DormStoryGivingItemCtrl", require("UI.Ctrl.Common.CommonItemCtrl"))

function M:Init()
    self.m_data = nil
    self:SetClickCallback(Bind(self, self.ClickItem))
    self.selectItemCallback = EventMgr:AddListener(UIMessageNames.DORM_STORY_SELECT_GIVING_ITEM,
        Bind(self, self.UpdateItem))
    self._view.BtnTips.transform:onClick(Bind(self, self.OnClickTips))
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.DORM_STORY_SELECT_GIVING_ITEM, self.selectItemCallback)
    self.m_data = nil
    M.super.OnDispose(self)
end

function M:OnClickTips(go)
    GameHelper.PopItem(self.m_data.item, 0, self._view)
end

function M:ClickItem(go)
    if self.m_data.curNum < 0 then
        GameHelper.PopItem(self.m_data.item, 0, self._view)
    end
end

function M:UpdateItem(data)
    if self.m_data and self.m_data.item ~= data.item then
        return
    end
    self.m_data = data

    if data.curNum > 0 then
        self._view.node_alpha:SetAlpha(1)
    else
        self._view.node_alpha:SetAlpha(0.6)
    end
    self:SetInfo(data.item, ItemNumberType.FRACTION, data.num, data.curNum)
end

return M
