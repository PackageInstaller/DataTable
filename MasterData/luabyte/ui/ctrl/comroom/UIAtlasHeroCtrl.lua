local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIAtlasHeroCtrl = BaseClass("UIAtlasHeroCtrl", CircularScrollViewItem)
local M = UIAtlasHeroCtrl

function M:Init()
end

function M:UpdateItem(data)
    local heroId = data.heroId
    self._view.labName:SetAvatarName(heroId, RoleType.ERT_Hero)
    self._view.imgHead:SetAvatarIcon(heroId, RoleType.ERT_Hero, 1)
    self._view.uiState:SetState(data.state and 1 or 2)
end

return UIAtlasHeroCtrl
