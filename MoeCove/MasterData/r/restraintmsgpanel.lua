---@class RestraintMsgPanel : RestraintMsgPanel_Generate
---##################### 【RestraintMsgPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【RestraintMsgPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local RestraintMsgPanel = require "RestraintMsgPanel_Generate"

function RestraintMsgPanel:InitLogic(data)
    self.roleConfig = {}
end

--function RestraintMsgPanel:StartCreating(time)
--
--end

--function RestraintMsgPanel:StartEnter(time)
--
--end

--function RestraintMsgPanel:StartRemoving(time)
--
--end

--function RestraintMsgPanel:StartExit(time)
--
--end

function RestraintMsgPanel:OnOpen(data, initiative)
    self.roleConfig = data
    LuaLogger.ds("self.roleConfig",tablex.dump(self.roleConfig))
    local attributeConfig = Config.GetCharacterRestraintInfo(self.roleConfig.attribute)
    self.nameTxt.text.text = attributeConfig.des
    local RoleTypeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, self.roleConfig.attribute)
    self.iconImg:SetActive(true)
    self:LoadSpriteAsync(RoleTypeIconPath, self.iconImg.image)
    self.rangeTxt.text.text = self.roleConfig.range
    self.moveTxt.text.text = self.roleConfig.movePowr

    local function setupSkill(skillField, skillId)
        if skillId and skillId ~= 0 then
            skillField.isOn:SetActive(true)
            local skillConfig = Config.GetSkillInfo(skillId)
            skillField.skillIcon:SetActive(true)
            self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), skillField.skillIcon.image)
        end
    end

    setupSkill(self.normalSkill, self.roleConfig.normalSkill)
    setupSkill(self.normalSkill2, self.roleConfig.normalSkill2)
    self.desTxt.text.text = attributeConfig.restraintDes
end

--界面关闭
function RestraintMsgPanel:playCloseAnim()
    self.animator.enabled = true
    self.animator:SetTrigger("Out")
    self.mask.button.interactable = false
    self.animOverCallBack:SetCallBack(function()
        self.mask.button.interactable = true
        UIMgr:closeSpecificUI(self)
    end)
end

--function RestraintMsgPanel:OnClose(initiative)
--
--end

--function RestraintMsgPanel:OnDestroy()
--	self.super:OnDestroy(self)
--end

--function RestraintMsgPanel:OnRefresh(data)
--
--end

--[[
/Mask onClick 
--]]
function RestraintMsgPanel:mask_Button_onClick(mask)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

--[[
/View/TitleBg/EnemyCloseBtn onClick 
--]]
function RestraintMsgPanel:enemyCloseBtn_ScaleButton_onClick(enemyCloseBtn)
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Back)
    self:playCloseAnim()
end

return RestraintMsgPanel
