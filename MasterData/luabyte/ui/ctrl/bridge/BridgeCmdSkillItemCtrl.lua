local M = BaseClass("BridgeCmdSkillItemCtrl")

-- 指挥官技能Item
function M:__init(view)
    self._view = view
    self._data = nil
    self.m_maxUpLv = GameHelper.GetParamter(182)
    self._view.lockMask:onClick(Bind(self, self._OnClickMask))
    self._view.skillTog:OnToggleClick(Bind(self, self._ClickToggle))
end

function M:_ClickToggle(isOn)
    self._data.IsSelect = isOn

    if isOn and self._toggleCallback then
        self._toggleCallback(self._data)
    end

    self:_UpdateUIState()
end

function M:UpdateItem(data)
    if data == nil then return end

    self._data = data

    self:_CheckBindHero()
    self:_UpdateUIState()
    self:_CheckSkillUp()
end

function M:ClickToggleCallback(callback)
    self._toggleCallback = callback
end

function M:_OnClickMask(go)
    local lockId = self._data.Config.unlock
    local openCondCfg = ConfigHelper.GetCfgByLua("openCondition", lockId)
    if openCondCfg then
        GameHelper.TipsById(openCondCfg.tips)
    else
        Logger.LogError("openCondition is nil, id = " .. lockId)
    end
end

function M:_CheckBindHero()
    local cmdID = self._data.Config.cmdID
    local addLevel = CmderSkillMgr:GetAddValue(cmdID, self._data.HeroId)
    local totalLevel = self._data.Config.level + addLevel
    local showSkill = CmderSkillMgr:GetSkillConfig(cmdID, totalLevel)

    if self._data.HeroId > 0 then
        local lvFmtStr = string.format("<color=#5183FF>Lv.%d</color>", showSkill.level)
        self._view.heroIcon:SetAvatarIcon(self._data.HeroId, RoleType.ERT_Hero)
        self._view.skillLevel:SetText(lvFmtStr)
        self._view.heroHead:SetActive(true)
    else
        self._view.heroHead:SetActive(false)
        self._view.skillLevel:SetText("Lv." .. showSkill.level)
    end

    self._view.skillIcon:SetPic(showSkill.icon)
    self._view.skillName:SetText(showSkill.name)
    self._view.skillDesc:SetText(showSkill.cmddesc)
end

function M:_CheckSkillUp()
    local skill = self._data.Config
    if skill.level >= self.m_maxUpLv then
        self._view.skillUp:SetActive(false)
    else
        -- DuSir : 需要检查道具数量
        local isEnough = GameHelper.CheckItemsByLua(skill.costItem, skill.costNum)
        local isUnlock = GameHelper.CheckLockByOpenConditionId(skill.unlock)
        if isEnough and isUnlock and self._data.IsUnlock then
            self._view.skillUp:SetActive(true)
        else
            self._view.skillUp:SetActive(false)
        end
    end
end

function M:_UpdateUIState()
    if self._data.IsSelect then
        -- 已解锁，已选中
        self._view.itemState:SetState(2)
    else
        if self._data.IsUnlock then
            -- 已解锁，未选中
            self._view.itemState:SetState(1)
        else
            -- 未解锁，未选中
            self._view.itemState:SetState(3)
        end
    end
end

function M:OnDispose()
    self._data = nil
    self._toggleCallback = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
