local M = BaseClass("LimitBreakLimitSkillItemCtrl",UIBaseComponent)
local LimitQualityPath = {"UI/SpritePics/common/ui_common_head_hero_quality_01","UI/SpritePics/common/ui_common_head_hero_quality_02",
"UI/SpritePics/common/ui_common_head_hero_quality_03","UI/SpritePics/common/ui_common_head_hero_quality_04"}
function M:__init(view)
    self._view = view
    self._view.btn_award:onClick(Bind(self,self._OnClickSelect))
    self._isSelected = false
    self._selectCallback = nil
    self._skillId = 0 
end

function M:SetSkillInfo(skillId,selectCallback)
    self._selectCallback = selectCallback
    self._skillId = skillId
    local cfg = ConfigHelper.GetCfg("extremeMissionCondition",skillId)
    local wordCfg = ConfigHelper.GetCfg("mapCondition",cfg.mapConditionId)
    if wordCfg == nil then 
        Logger.LogError("mapCondition id = " .. tostring(cfg.mapConditionId) .. " error,extremeMissionCondition id = " .. skillId)
    end
    self._view.img_head:SetPic(cfg.image)
    self._view.txt_name:SetText(cfg.name)
    self._view.txt_desc:SetText(wordCfg.name)
    self._view.img_quality:SetPic(LimitQualityPath[cfg.quality])
end

function M:SetSelect(isSelect)
    self._view.uiState:SetState( isSelect and 3 or 2 )
    self._isSelected = isSelect
end

function M:GetSelect()
    return self._isSelected
end

function M:GetSelectId()
    return self._skillId
end

function M:_OnClickSelect(go)
    if self._selectCallback then 
        self._selectCallback(self._skillId)
    end
end

return M