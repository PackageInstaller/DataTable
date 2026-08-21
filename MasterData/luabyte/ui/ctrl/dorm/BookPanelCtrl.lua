local BookPanelCtrl = BaseClass("BookPanelCtrl")
local M = BookPanelCtrl

function M:__init(view)
    self._view = view
end

function M:SetData(data)
    if data == nil then
        self._view.Textbg.gameObject:SetActive(false)
        self._view.Lock.gameObject:SetActive(false)
        return
    end

    self.data = data
    --判断当前日记是否解锁
    if data.curFavorLevel >= data.favorLevel then
        self._view.TitleText:SetText(4119)
        self._view.ContentText:SetText(data.des)
        local str = ConfigHelper.GetLocalString(4120)
        self._view.PageNumber:SetText(string.format(str, data.favorLevel)) --("第" .. data.favorLevel .. "页")
        self._view.Lock.gameObject:SetActive(false)
    else
        --未解锁
        self._view.Lock.gameObject:SetActive(true)
        local str = ConfigHelper.GetLocalString(4121)
        self._view.LockText:SetText(string.format(str, data.favorLevel)) --("好感度" .. data.favorLevel .. "级解锁")
    end
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return BookPanelCtrl
