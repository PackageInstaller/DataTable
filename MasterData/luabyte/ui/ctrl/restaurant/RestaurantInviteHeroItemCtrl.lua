--右上方英雄列表
local RestaurantInviteHeroItemCtrl = BaseClass("RestaurantInviteHeroItemCtrl")
local M = RestaurantInviteHeroItemCtrl

function M:__init(view)
    self._view = view
    self._selectPosCallback = EventMgr:AddListener(UIMessageNames.Restaurant_Select_Pos, Bind(self, self.OnSelectPos))
    self._view.gameObject:onClick(Bind(self, self.SelectRole))
end

function M:OnSelectPos(selectRolePos)
    self.selectRolePos = selectRolePos

    if self.data then
        self._view.tfSelect.gameObject:SetActive(self.selectRolePos == self.data.Position)
    else
        self._view.tfSelect.gameObject:SetActive(falses)
    end
end

function M:UpdateItem(data)
    self.data = data
    local heroId = data.HeroId
    local heroCfg = ConfigHelper.GetCfgByLua("hero", heroId)
    self._view.name:SetText(heroCfg.name)
    -- self._view.name:SetText(tostring(data.Position))
    self._view.HeadIcon:SetHeroId(heroId)
    local eater = self:GetNowHeroEat(heroId)
    local maxEater = self:GetMaxHeroEat(heroId)
    self._view.SliderrLabel:SetText(eater .. "/" .. maxEater)
    self._view.Slider:SetValue(eater / maxEater)
    --换对象
end

--获取英雄最大饱食度
function M:GetMaxHeroEat(heroId)
    return ConfigHelper.GetCfgPropByLua("hero", heroId, "eater")
end

function M:GetNowHeroEat(heroId)
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(heroId)

    if not rshd then
        Logger.LogError("获取英雄当前饱食度，未找到该英雄")
        return 0
    end
    return rshd:GetEater()
end

function M:SelectRole()
    -- 移动camera
    local curSit = self.data.Position
    EventMgr:Broadcast(UIMessageNames.Restaurant_Select_Pos, curSit)
    local timeLineIndex = 13011 + curSit
    GameHelper.PlayTimlineById(timeLineIndex)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.Restaurant_Select_Pos, self._selectPosCallback)
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return RestaurantInviteHeroItemCtrl
