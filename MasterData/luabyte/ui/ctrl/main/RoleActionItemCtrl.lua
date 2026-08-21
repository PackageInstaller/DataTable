local RoleActionItemCtrl = BaseClass("RoleActionItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))
local M = RoleActionItemCtrl

function M:Init()
    self._heroItemData = {}
    self._heroItemData.clickFunc = Bind(self,self._OnClick)
    self._view.HeroItem:UpdateItem()
    self._ClickCallback = nil 
end

function M:_OnClick(go)
    if self._ClickCallback then 
        self._ClickCallback(self._heroId)
    end
    self:RefreshList()
end

function M:UpdateItem(data,idx)
    local isSelect =  data.isSelect 
    local heroData = data.hero
    self._ClickCallback = data.onSelect  
    self._heroId = heroData:GetHeroId()
    self._view.imgProfession:SetProfessional(self._heroId)
    local state = 0 
    if isSelect then 
        state = 2
    else
        state = 1
    end
    self._view.UIState:SetState(state)
    self._heroItemData.heroId = self._heroId
    self._view.HeroItem:UpdateItem(self._heroItemData)
    self._view.levelTf:SetText(tostring(heroData:GetLevel()))
end

function M:OnDispose()
    self._ClickCallback = nil 
    M.super.OnDispose(self)
end

return M 