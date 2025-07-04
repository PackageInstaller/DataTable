---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/7/2 10:20
---

local SkillLogic = {};
local this = SkillLogic;

local labConfig = {LangUtil.GetSysLang(140),LangUtil.GetSysLang(141),LangUtil.GetSysLang(142),LangUtil.GetSysLang(143),LangUtil.GetSysLang(144)}
local stageConfig = {}

local function InitSkillChild(self,transform,skillId,labId)
    local zSkill = Z_Skill[skillId]
    local iconImg = transform:Find("SkillItem/ImageBg/Icon"):GetComponent("Image")

    local name = transform:Find("SkillText"):GetComponent("Text")
    local desc = transform:Find("SkillDescriptionText"):GetComponent("Text")
    local cd = transform:Find("CDText"):GetComponent("Text")

    UIUtil.SetSprite(iconImg,AtlasConfig.SkillIcon,zSkill.SkillIcon)
    name.text = zSkill.Name
    cd.text = zSkill.CooldownTurn

    local descInfo = zSkill.SkillDesc

    for index, value in ipairs(zSkill.Params) do
        descInfo = string.gsub(descInfo, "XX" .. index, value)
    end

    desc.text = string.sub(descInfo, 2, -2) 
end

function this.OnEnable(self)
    self.skillPanel.transform.localPosition = self.oldPos
end

function this.Init(self)
    -- Todo 临时处理
    local zCard = Z_CharacterEvolution[self.zCard.Id] 
    local skillIdList = {
        zCard[1].Attack,
        zCard[1].Skill,
        zCard[1].Ultimate,
        zCard[2].PassiveSkill
    }
    for i = 0,self.skillContent.childCount - 1 do
        local skillChild = self.skillContent:GetChild(i)
        InitSkillChild(self,skillChild,skillIdList[i+1],i+1)
    end
    self.skillPanel:SetActive(false)
    self.skillPanel.transform.localPosition = Vector3.New(-9999, -9999, -9999)
    coroutine.waitforframes(1)
    self.skillPanel:SetActive(true)
    coroutine.waitforframes(1)
    self.skillPanel:SetActive(false)
    coroutine.waitforframes(1)
    self.skillPanel:SetActive(true)
    for i = 0,self.skillContent.childCount - 1 do
        local skillChild = self.skillContent:GetChild(i)
        LayoutRebuilder.ForceRebuildLayoutImmediate(skillChild:GetComponent("RectTransform"))
    end
    LayoutRebuilder.ForceRebuildLayoutImmediate(self.skillContent:GetComponent("RectTransform"))

    self.skillContent.transform:DOLocalMoveY(0,0)
end

function this.OnLangCreate(self,panel)
    local langRc = panel.transform:Find("LangControl"):GetComponent("ReferenceCollector")
    stageConfig = {LangUtil.GetSysLang(150),LangUtil.GetSysLang(151),LangUtil.GetSysLang(152)}
    labConfig = {LangUtil.GetSysLang(140),LangUtil.GetSysLang(141),LangUtil.GetSysLang(142),
                 LangUtil.GetSysLang(143),LangUtil.GetSysLang(144),}
    
    local root = langRc:GetObject("Content").transform
    table.csenuObject(root,function(v)
        local txt= v:GetComponent("Text")
        if not IsNull(txt) then
            LangUtil.BindText(txt.transform)
        end
    end)
end


function this.OnCreate(self,panel)
    self.skillPanel = panel
    self.oldPos = self.skillPanel.transform.localPosition
    local rc = panel:GetComponent("ReferenceCollector")
    self.skillContent = rc:GetObject("Content").transform
end


return SkillLogic;