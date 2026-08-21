local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local M = BaseClass("HeroAtlasItemCtrl", CircularScrollViewItem)

function M:__init(view)
    self._view = view
    self._view:onClick(Bind(self, self._OnClickItem))
end

function M:UpdateItem(data)
    if data == nil then
        return
    end
    self.heroId = data.heroId
    self._view.imgHero:SetImageHalf(data.heroId, RoleType.ERT_Hero, 1)
    self._view.txtHero:SetAvatarName(data.heroId, RoleType.ERT_Hero, 1)
    self._view.imgProfession:SetProfessional(data.heroId)
    self._view.stateRare:SetState(data.rare)
    self._view.stateFaction:SetState(data.faction)
    self._view.stateLock:SetState(data.isCollect)
    self._view.tfState:SetState(data.id % 2 == 0 and 2 or 1)

    -- self._view.redPoint:SetParam(0, self.heroId)
    -- self._view.redPoint:Check()
end

function M:_OnClickItem()
    if self.heroId and self.heroId > 0 then
        UIContextMgr:GetInstance():Show("RoleInformationUI", { [0] = self.heroId, Length = 1 }, 0, 2, true)
        -- PlayerPrefTools.SetPlayerPrefs("HeroBookNewGet" .. tostring(self.heroId), 1)
        -- IRedPointMgr:ForceCheck(RedPointConst.HeroGetTypeRedPointChecker)
        -- self._view.redPoint:Check()
    end
end

return M
