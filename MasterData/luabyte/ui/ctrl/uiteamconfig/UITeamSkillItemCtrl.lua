local UITeamSkillItemCtrl = BaseClass("UITeamSkillItemCtrl")
local M = UITeamSkillItemCtrl

function M:__init(view)
    self._view = view
    self._view.btn:SetOnClick(self, self._OnBtnClick)
end

function M:UpdateData(data)
    self._data = data
    local haveSkill = data.commanderSkillId and data.commanderSkillId > 0 
    self._view.tfAddSkill.gameObject:SetActive(not haveSkill)
    self._view.tfNodeLevel.gameObject:SetActive(haveSkill)
    self._view.imgIcon.gameObject:SetActive(haveSkill)
    
    if not haveSkill then
        return 
    end
    
    local commanderSkill = ConfigHelper.GetCfgByLua("commanderSkill", data.commanderSkillId)
    local iconPath = commanderSkill.icon
    self._view.imgIcon:SetPic(iconPath)
    local addLevel = 0
    local lv = 1
    if data.heroId then
        lv = data.heroId.Level
        addLevel = self:_GetAddLevel(commanderSkill.cmdID, data.heroId.HeroId)
    end

    if addLevel > 0 then
        lv = lv + addLevel
        self._view.labLv:SetText("<color=#4D7FFF>Lv." .. lv .. "</color>")
    else
        self._view.labLv:SetText("<color=#FFFFFF>Lv." .. lv .. "</color>")
    end
end

function M:_OnBtnClick()
  
    if self._data.isTeach then
        return 
    end
    
    EventMgr:Broadcast(UIMessageNames.CLICKSKILL)
end

function M:_GetCommanderAddLevel(cmdId)
    local commanderAddLevel = ConfigHelper.GetCfgs("commanderAddLevel")
    
    for index, value in ipairs(commanderAddLevel) do
        if value.cmdID == cmdId then
            return value
        end
    end
end

function M:_GetAddLevel(cmdId, heroId)
    local commanderAddLevel = self:_GetCommanderAddLevel(cmdId)
    
    if not commanderAddLevel then
        return 0
    end
    
    for i = 1, #commanderAddLevel.hero do
        if commanderAddLevel.hero[i] == heroId then
            return commanderAddLevel.addValue[i] or 0
        end
    end
    return 0
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return UITeamSkillItemCtrl
