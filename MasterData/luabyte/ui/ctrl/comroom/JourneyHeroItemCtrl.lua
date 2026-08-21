local M = BaseClass("JourneyHeroItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self._view.gameObject:onClick(Bind(self, self.OnClickItem))
end

function M:UpdateItem(data)
    if data == nil then return end
    self._data = data
    self._view.onGoing:SetActive(data.IsWork)
    local heroId = self._data.HeroID
    if heroId > 0 then
        self._view.heroAdd:SetActive(false)
        self._view.HeroHeadItem:SetActive(true)
        local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
        self._view.HeroHeadItem:SetHeroId(heroId, heroData:GetLevel())
    else
        self._view.heroAdd:SetActive(true)
        self._view.HeroHeadItem:SetActive(false)
    end
end

function M:OnClickItem(go)
    if self._clickCallback then
        self._clickCallback(self._data)
    end
end

function M:ClickCallback(callback)
    self._clickCallback = callback
end

function M:OnDispose()
    self._clickCallback = nil
    M.super.OnDispose(self)
end

return M
