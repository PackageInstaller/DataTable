local M = BaseClass('BattleExpSliderCtrl')

function M:OnDispose()
    self.m_isShow = nil
    if self.m_co then
        coroutine.stopwaiting(self.m_co)
        self.m_co = nil
    end
    if self.view then
        for i = 1, 4 do self.view["headItem" .. i]:OnDispose() end
        self.view:OnDispose()
        self.view = nil
    end
    self.m_curCfg = nil
    self.m_maxLevel = nil
end

function M:Refresh(mission, playerExp)
    self.m_isShow = true
    self:_SetPlayerInfo(playerExp)
    self:_SetHeroUp(mission)
end

function M:_UpdateLevelExp(sumExp)
    local levelCfg = self:_GetPlayerLevelCfg(sumExp)
    if levelCfg then
        local exp = levelCfg.exp
        local expSum = levelCfg.expSum
        local slider = (exp - math.max(0, expSum - sumExp)) / exp
        self.view.lv:SetText(tostring(levelCfg.id))
        self.view.lvSlider:SetFillAmount(slider)
        self.view.expSlider:SetValue(slider)
    else
        Logger.LogError("homepageLevel is nil, id = ??")
    end
end

function M:_SetPlayerInfo(playerExp)
    self.view.expText:SetText("0")
    local oldSumExp = IPlayerData.enterBattle_EXP
    local battleExp = math.max(0, playerExp - oldSumExp)
    self:_UpdateLevelExp(oldSumExp)
    if battleExp > 0 then
        local second = 1 / battleExp
        self.m_co = coroutine.start(function()
            local step = math.max(1, math.floor(battleExp / 45))
            for i = battleExp % step, battleExp, step do
                if not self.m_isShow then break end
                self:_UpdateLevelExp(oldSumExp + i)
                self.view.expText:SetText(tostring(i))
                coroutine.waitforseconds(second)
            end
            self.m_co = nil
        end)
    end
end

function M:_SetHeroUp(mission)
    local isSystem = mission.teamType == EnumConst.ETeamType.ETT_System
    local isRes = mission.Chapter.type == ChapterConst.EChapterType.ECT_Resource

    if (isSystem or isRes) then
        self.view.lvUpGroup:SetActive(false)
        return
    end

    local roles = IHeroDataMgr:GetActiveTeamHeros()
    local favorValue = GameHelper.GetParamter(179)
    local count = roles.Length

    for i = 1, 4 do
        local index = i - 1
        local name = string.format("headItem%d", i)

        if index >= count then
            self.view[name]:SetActive(false)
        else
            local rshd = roles[index]:GetRoleStudioHeroData()
            local favor, curLevel = rshd.Favor, rshd:GetFavorLevel()
            local level = rshd:GetFavorLevel(favor - favorValue)
            self.view[name]:SetHeroId(rshd.heroId)
            self.view[name]:SetActive(curLevel > level)
        end
    end

    --self.view.lvUpGroup:SetActive(true)
end

function M:_GetPlayerLevelCfg(sumExp)
    if self.m_curCfg then
        if sumExp < self.m_curCfg.expSum then return self.m_curCfg end
        for i = self.m_curCfg.id + 1, self.m_maxLevel do
            local cfg = ConfigHelper.GetCfg("homepageLevel", i)
            if cfg and (sumExp < cfg.expSum) then
                self.m_curCfg = cfg
                break
            end
        end
        return self.m_curCfg
    end

    local maxLevel, curCfg = 0, nil
    local levelCfgs = ConfigHelper.GetCfgsByLua("homepageLevel")
    local len = levelCfgs and levelCfgs.Length or 0
    for i = 0, len - 1, 1 do
        local lvCfg = levelCfgs[i]
        if lvCfg.id > maxLevel then maxLevel = lvCfg.id end
        local expSum = lvCfg.expSum
        if expSum > sumExp then
            if not curCfg or (curCfg.expSum > expSum) then
                curCfg = lvCfg
            end
        end
    end

    self.m_maxLevel = maxLevel
    self.m_curCfg = curCfg or ConfigHelper.GetCfg("homepageLevel", maxLevel)
    return self.m_curCfg
end

return M
