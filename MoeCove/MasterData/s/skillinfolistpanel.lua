---@class SkillInfoListPanel : SkillInfoListPanel_Generate
---##################### 【SkillInfoListPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【SkillInfoListPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local SkillInfoListPanel = require "SkillInfoListPanel_Generate"

function SkillInfoListPanel:InitLogic(data)

end

--function SkillInfoListPanel:StartCreating(time)
--
--end

--function SkillInfoListPanel:StartEnter(time)
--
--end

--function SkillInfoListPanel:StartRemoving(time)
--
--end

--function SkillInfoListPanel:StartExit(time)
--
--end

function SkillInfoListPanel:OnOpen(data, initiative)
    local skillCfg = Config.GetSkillInfo(data.skillId)
    if not skillCfg or not skillCfg.effectInfo then
        self.main.gameObject:SetActive(false)
        return
    end
    local targetRectTrans = data.target.transform:GetComponent("RectTransform")

    local UICamera = UIMgr.uiCamera
    local screenPos = UICamera:WorldToScreenPoint(data.target.transform.position)
    local localPos = UICommonUtils.ScreenToUILocalPos(self.mask.transform, UICamera, screenPos)
    localPos.x = localPos.x - targetRectTrans.sizeDelta.x + 50
    localPos.y = localPos.y + targetRectTrans.sizeDelta.y / 2 - 100
    self.main.transform.localPosition = localPos

    local skillInfo = skillCfg.effectInfo
    
    local height = -50
    for i = 1, 4 do
        local skill = self["skill" .. i]
        if skillInfo[i] then
            local effectInfo = Config.GetEffectInfoInfo(skillInfo[i])
            if effectInfo then
                skill.desc.text.text = effectInfo.effectDesKey
                skill.skillName.text.text = effectInfo.effectNameKey
                skill.rectTransform.sizeDelta = Vector2(500, skill.desc.text.preferredHeight + 110)
                if i ~= 1 then
                    height = height - self["skill" .. (i - 1)].rectTransform.sizeDelta.y / 2
                    height = height - skill.rectTransform.sizeDelta.y / 2
                end
                skill.rectTransform.anchoredPosition = Vector2(0, height)
            end
        else
            skill.gameObject:SetActive(false)
        end
    end
end

--function SkillInfoListPanel:OnClose(initiative)
--
--end

--function SkillInfoListPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function SkillInfoListPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function SkillInfoListPanel:mask_Button_onClick(mask)
    UIMgr:closeSpecificUI(self)
end

return SkillInfoListPanel
