local M = BaseClass("TeamChangeSkillItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))
local fmtStr = "<color=#5182FE>LV.%d</color>"

function M:Init()
    self._costIcons = { self._view.costIcon }
    self._maxUpLv = GameHelper.GetParamter(182)
    self._view.normalBtn:onClick(Bind(self, self.OnClickItem))
end

function M:UpdateItem(data)
    if not data then return end

    self._data = data
    self:_SetHero()
    self:_SetSkill()
    self:_CheckSkillUp()
    self._view.select:SetActive(self._data.IsChoose)
end

function M:OnDispose()
    for _, go in ipairs(self._costIcons) do go:OnDispose() end
    self._costIcons = nil
    self._selectCallback = nil
    M.super.OnDispose(self)
end

function M:SetSelectCallback(callback)
    self._selectCallback = callback
end

function M:OnClickItem(go)
    self._data.IsChoose = not self._data.IsChoose
    if self._selectCallback then self._selectCallback(self._data) end
end

function M:_SetHero()
    if self._data.HeroId > 0 then
        self._view.heroHead:SetActive(true)
        self._view.heroIcon:SetAvatarIcon(self._data.HeroId, RoleType.ERT_Hero)
    else
        self._view.heroHead:SetActive(false)
    end
end

function M:_SetSkill()
    local cfg = self._data.Config
    local addLv = CmderSkillMgr:GetAddValue(cfg.cmdID, self._data.HeroId)
    local topCfg = CmderSkillMgr:GetSkillConfig(cfg.cmdID, cfg.level + addLv)
    self._view.skillLevel:SetText(string.format(addLv > 0 and fmtStr or "LV.%d", topCfg.level))
    self._view.castTime:SetText(math.floor(topCfg.cd / 1000) .. "s")
    self._view.skillDesc:SetText(topCfg.cmddesc)
    self._view.skillName:SetText(topCfg.name)
    self._view.skillIcon:SetPic(topCfg.icon)
    self._view.lockIcon:SetActive(false)
    self:_SetCostNum(topCfg.cost)
end

function M:_SetCostNum(num)
    self._view.skillCost:SetActive(num > 0)
    for i = 1, num do
        local go = self._costIcons[i]
        if not go then
            go = self._view.costIcon:Instantiate()
            table.insert(self._costIcons, go)
        end
        go:SetActive(true)
    end
    for i = #self._costIcons, num + 1, -1 do
        self._costIcons[i]:SetActive(false)
    end
end

function M:_CheckSkillUp()
    local cfg = self._data.Config
    if cfg.level >= self._maxUpLv then
        self._view.skillUp:SetActive(false)
    else
        local isEnough = self:_CheckItems(cfg.costItem, cfg.costNum)
        self._view.skillUp:SetActive(isEnough and self._data.IsUnlock)
    end
end

function M:_CheckItems(itemArr, numArr)
    if (#itemArr <= 0) or (#numArr <= 0) then return false end

    for i = 1, #itemArr, 1 do
        if not GameHelper.CheckItem(itemArr[i], numArr[i]) then return false end
    end
    return true
end

return M
