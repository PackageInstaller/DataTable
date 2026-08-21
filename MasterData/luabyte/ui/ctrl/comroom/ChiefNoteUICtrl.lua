local M = BaseClass("ChiefNoteUICtrl", BaseUICtrl)
local eventId = UIMessageNames.CHIEFNOTE_SELECT_UPDATE

function M:Init()
    self._selectUpdateEvent = EventMgr:AddListener(eventId, Bind(self, self.OnSelectUpdate))
    self._view.rectBack:onClick(Bind(self, self.Close))
    self._subject = nil
end

function M:OnDispose()
    EventMgr:RemoveListener(eventId, self._selectUpdateEvent)
    ChiefNoteDataMgr:GetInstance():CheckOffRedPoint()
    IRedPointMgr:ForceCheck(RedPointConst.ChiefNoteMainTypeRedPointChecker)
    self._view.scrollNote:Dispose()
    self._selectUpdateEvent = nil
    self._subject = nil
    M.super.OnDispose(self)
end

function M:OnEnter()
    self:_InitNotes()
    self:_InitTabs()
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:_InitNotes()
    local ctrl = require("UI.Ctrl.ComRoom.ChiefNoteItemCtrl")
    local view = require("UI.View.ComRoom.ChiefNoteItemView")
    self._view.scrollNote:Init(ctrl, view)
    ChiefNoteDataMgr:GetInstance():InitSelectData()
    self._subject = ChiefNoteConst.Subject.FACTIONS
    local data = ChiefNoteDataMgr:GetInstance():GetDataBySubject(self._subject)
    self._view.scrollNote:SetDataList(data)
    self._view.scrollNote:MovePanelToItemIndex(0)
end

function M:_InitTabs()
    local names = self:_GetTabNames()
    -- local enNames = self:_GetTabEnNames()
    -- local icons = ChiefNoteConst.TabIcons
    self._view.scrollTab:InitItems(0, names, Bind(self, self.OnTabSelect), nil)
    for i, _ in ipairs(names) do
        local idx = i - 1
        self._view.scrollTab:SetRedPointParma(idx, 0, i)
        self._view.scrollTab:SetRedPointCheck(idx)
    end
end

function M:_GetTabNames()
    local list = {}
    for i = 1, #ChiefNoteConst.TabNames do
        local name = ConfigHelper.GetLocalString(ChiefNoteConst.TabNames[i])
        table.insert(list, name)
    end
    return list
end

function M:OnTabSelect(index)
    index = index + 1
    if index == self._subject then return end
    self._subject = index
    ChiefNoteDataMgr:GetInstance():UpdateSelectDataBySubject(self._subject)
    self:OnSelectUpdate()
    self._view.scrollNote:MovePanelToItemIndex(0)
end

function M:OnSelectUpdate()
    local data = ChiefNoteDataMgr:GetInstance():GetDataBySubject(self._subject)
    self._view.scrollNote:UpdateList(data)
end

return M
