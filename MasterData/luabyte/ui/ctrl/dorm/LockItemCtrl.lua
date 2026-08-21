local LockItemCtrl = BaseClass("LockItemCtrl")
local M = LockItemCtrl

function M:__init(view)
    self._view = view
    self._view.Btn.transform:onClick(Bind(self, self._ClickLink))
end

--跳转
function M:_ClickLink(go)
    if self._data.linkTo == 5 then
        UIContextMgr:GetInstance():Show("FavorStory", self._data.heroId, DormConst.StoryType.roomStory, self._data.roomStory, nil, nil, nil, nil)
        UIContextMgr:GetInstance():Close("FavorContentPanel")
    end
end

function M:UpdateItem(data)
    if data == nil then
        return 
    end
    
    self._data = data
    self._view.DesText:SetText(self._data.unlockWords)
    if self._data.linkTo == 5 and self._data.unlock then
        self._view.Btn.gameObject:SetActive(true)
    else
        self._view.Btn.gameObject:SetActive(false)
    end

    if self._view.uiState then
        self._view.uiState:SetState(self._data.unlock and 1 or 2)
    end
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
    end
    
    self._view = nil
end

return LockItemCtrl
