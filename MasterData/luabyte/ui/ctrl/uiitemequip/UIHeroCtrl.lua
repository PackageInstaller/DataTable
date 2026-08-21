--baoruichang
local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIHeroCtrl = BaseClass("UIHeroCtrl",CircularScrollViewItem)
local M = UIHeroCtrl

function M:UpdateItem(data)
    self._view.HeroHeadItem:SetHeroId(data,0,1)
end

return UIHeroCtrl
