local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UICookHeroItemCtrl = BaseClass("UICookHeroItemCtrl", CircularScrollViewItem)
local M = UICookHeroItemCtrl

function M:Init()
    self._view.HeroHeadItem.transform:onClick(Bind(self, self.OnClickItem))
    self.tempUpdateState = EventMgr:AddListener(UIMessageNames.COOKING_UPDATEHEROITEM, Bind(self,self.UpdateState))
end

function M:UpdateItem(data)
    self.data = data
    self._view.HeroHeadItem:SetHeroId(data.heroId)
    self._view.HeroHeadItem.select = data.select
    self._view.slider.size = data.feedDegree

    self._view.sliderColor:SetColorTo16(self:GetTag3Color(data.feedDegree))
end

function M:GetTag3Color(value)
    if value > 0.8 then
        return "F1AA2E"
    end

    if value > 0.2 then
        return "FF7C4E"
    end

    return "F44E4E"
end

function M:OnClickItem()

    if self.selectCallback then
        self.selectCallback(self.data.heroId, self.data.id)
    end
end

-- function M:SetItemState()

-- end

function M:SetSelectCallback(callback)
    self.selectCallback = callback
end

function M:UpdateState(id)
    if self.data.id ~= id then
        return
    end
    self.data.select = not self.data.select
    self._view.HeroHeadItem.select = self.data.select
end

function M:Dispose()
    M.super.Dispose(self)
    EventMgr:RemoveListener(UIMessageNames.COOKING_UPDATEHEROITEM, self.tempUpdateState)
end

return UICookHeroItemCtrl
