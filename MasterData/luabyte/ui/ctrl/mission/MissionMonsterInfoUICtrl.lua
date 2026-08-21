local M = BaseClass("MissionMonsterInfoUICtrl", BaseUICtrl)

function M:Init()
    self.m_itemDic = {}
    self.m_selectIcon = nil
    self.m_levelList = {
        "D", "D+", "C", "C+", "B", "B+", "A", "A+", "S", "SS", "SSS"
    }
    self._view.backBtn:onClick(Bind(self, self.Close))
    self._view.btn_day:onClick(Bind(self, self.OnClickDayMonster))
    self._view.btn_night:onClick(Bind(self, self.OnClickNightMonster))
end

function M:OnEnter(stage)
    local mRound = stage.monsterRound
    for i = 0, mRound.Length - 1 do
        local groupId = mRound[i]
        local mg = ConfigHelper.GetCfgByLua("monsterGroup", groupId)
        if mg then
            self:_CreateListItem(i, mg.monsterId)
        else
            Logger.LogError("monsterGroup is 空, please @四叶, id = " .. tostring(groupId))
        end
    end
    self._view.monItem:SetActive(false)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    for _, item in pairs(self.m_itemDic) do item:Destory() end
    self.m_selectIcon = nil
    self.m_itemDic = nil
    -- 没有ctrl，手动释放
    self._view.monItem:OnDispose()
    M.super.OnDispose(self)
end

function M:OnClickDayMonster(go)
    if not self.m_dayMonster then return end
    self:_RefreshMonsterDetails(self.m_dayMonster)
end

function M:OnClickNightMonster(go)
    if not self.m_nightMonster then return end
    self:_RefreshMonsterDetails(self.m_nightMonster)
end

function M:_CreateListItem(i, id)
    if not self.m_itemDic[id] then
        local item = self._view.monItem:Instantiate()
        local monCfg = ConfigHelper.GetCfgByLua("monster", id)
        if monCfg then
            local icon = item.iconImg
            item.toggle:OnToggleClick(function(isOn)
                if isOn then
                    self.m_selectIcon = icon
                    self:_RefreshMonsterDetails(monCfg)
                else
                    icon:SetIcon(monCfg:ResCfg())
                end
            end)
            item.lv:SetText(tostring(monCfg.monsterLevel))
            item.boss:SetActive(monCfg.monsterType == 3)
            icon:SetIcon(monCfg:ResCfg())
            item.toggle:SetIsOn(i == 0)
            item:SetActive(true)
            self.m_itemDic[id] = item
        else
            Logger.LogError("monster is 空, please @四叶, id = " .. tostring(id))
        end
    end
end

function M:_RefreshMonsterDetails(cfg)
    self:_RefreshMonsterState(cfg)
    self._view.monName:SetText(cfg.name)
    self._view.monDesc:SetText(cfg.desc)
    self._view.skillDesc:SetText(cfg.skilldesc)
    self._view.attackDesc:SetText(cfg.attackDes)
    self._view.bossTag:SetActive(cfg.monsterType == 3)
    self._view.lvMdf:SetText(self.m_levelList[cfg.mdfLevel])
    self._view.lvDef:SetText(self.m_levelList[cfg.defLevel])
    self._view.lvHp:SetText(self.m_levelList[cfg.bloodLevel])
    self._view.lvAtk:SetText(self.m_levelList[cfg.attackLevel])
    self._view.sliderAtk:SetValue(cfg.attackLevel)
    self._view.sliderDef:SetValue(cfg.defLevel)
    self._view.sliderHp:SetValue(cfg.bloodLevel)
    self._view.sliderMdf:SetValue(cfg.mdfLevel)

    local reCfg = cfg:ResCfg()
    if reCfg then
        if not string.isNullOrEmpty(reCfg.drawing) then
            self._view.monImg:SetPic(reCfg.drawing)
        else
            Logger.LogError("drawing is 空, please @四叶, id = " .. tostring(cfg.id))
        end
        if self.m_selectIcon then self.m_selectIcon:SetIcon(reCfg) end
    else
        Logger.LogError("resource is 空, please @四叶, id = " .. cfg.id)
    end
end

function M:_RefreshMonsterState(cfg)
    local sptype = cfg.sptype
    if (sptype == 1) or (sptype == 2) then
        self._view.dayState:SetActive(true)
        self._view.dayState:SetState(sptype)
        local id = cfg.targetId
        if sptype == 1 then -- 白天怪
            self.m_dayMonster = cfg
            self.m_nightMonster = self:_GetMonster(self.m_nightMonster, id)
        else
            self.m_nightMonster = cfg
            self.m_dayMonster = self:_GetMonster(self.m_dayMonster, id)
        end
    else
        self.m_dayMonster = nil
        self.m_nightMonster = nil
        self._view.dayState:SetActive(false)
    end
end

function M:_GetMonster(cfg, id)
    if not cfg or (cfg.id ~= id) then
        local monster = ConfigHelper.GetCfgByLua("monster", id)
        if not monster then
            Logger.LogError("monster is 空, please @四叶, id = " .. tostring(id))
        end
        return monster
    end
    return cfg
end

return M
