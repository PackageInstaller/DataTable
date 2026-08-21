local M = BaseClass("OtakuSettleHeroCtrl")

function M:__init(view)
    self._view = view
    self.m_roomData = nil
    self.m_changedCallback = nil
    local itemCtrl = require("UI.Ctrl.Otaku.OtakuSettleHeroItemCtrl")
    local itemView = require("UI.View.Otaku.OtakuSettleHeroItemView")
    self._view.scrollSettle:Init(itemCtrl, itemView)
    local updateHandler = Bind(self, self.OnSettleUpdateEvent)
    local selectHandler = Bind(self, self.OnSettleSelectEvent)
    self.m_onSettleUpdate = EventMgr:AddListener(UIMessageNames.OTAKU_SETTLE_UPDATE, updateHandler)
    self.m_onSettleSelect = EventMgr:AddListener(UIMessageNames.OTAKU_SETTLE_SELECT_UPDATE, selectHandler)
end

function M:OnDispose()
    self.m_roomData = nil
    self.m_changedCallback = nil
    EventMgr:RemoveListener(UIMessageNames.OTAKU_SETTLE_UPDATE, self.m_onSettleUpdate)
    EventMgr:RemoveListener(UIMessageNames.OTAKU_SETTLE_SELECT_UPDATE, self.m_onSettleSelect)
    if self._view then self._view:OnDispose() end
    self._view = nil
end

function M:OnSettleUpdateEvent(roomId)
    if self.m_roomData:RoomId() == roomId then
        self:UpdateSettle()
        if self.m_changedCallback then
            self.m_changedCallback()
        end
    end
end

function M:OnSettleSelectEvent(roomId)
    if self.m_roomData:RoomId() == roomId then
        self:_UpdateSettleItems()
    end
end

function M:_SetSettleNum()
    local curNmu = self.m_roomData:CurRoleLiveNum()
    local maxDeployNum = self.m_roomData:RoleDeployMaxNum()
    self._view.txtSettleNum:SetText(tostring(curNmu))
    self._view.txtSettleMaxNum:SetText(tostring(maxDeployNum))
end

function M:_UpdateSettleItems()
    local data = self.m_roomData:LiveSpace()

    for i,v in ipairs(data) do
        v.curSettleType = self.m_roomData:SettleType()
    end

    self._view.scrollSettle:SetDataList(data)
end

function M:Init(roomData)
    self.m_roomData = roomData
    self:UpdateSettle()
end

function M:UpdateSettle()
    self:_SetSettleNum()
    self:_UpdateSettleItems()
end

function M:SetChangedCallback(callback)
    self.m_changedCallback = callback
end

return M
