--
-- <代码文件解释说明>
--

---@class UIThingsDetailCardView : UIBaseView
---@field model UIThingsDetailCardModel
---@field ctrl UIThingsDetailCardCtrl
local UIThingsDetailCardView = BaseClass("UIThingsDetailCardView",UIBaseView)
local base = UIBaseView
local this = UIThingsDetailCardView
local enhanceType = "EnhanceAttack"
local showPropertySort = {
    [1] = {
        property = NumericType.Hp,
        subName = "Hp",
    },
    [2] = {
        property = NumericType.Atk,
        subName = "Atk",
    },
    [3] = {
        property = NumericType.Def,
        subName = "Def",
    },
    [4] = {
        property = NumericType.MagicDef,
        subName = "MagicDef",
    },
    [5] = {
        property = NumericType.Speed,
        subName = "Speed",
    },
}


local CHARACTER_LEVEL_LIMIT = tonumber(Z_Misc["CHARACTER_LEVEL_LIMIT"].Value[1])
local CHARACTER_STAR_LIMIT = tonumber(Z_Misc["CHARACTER_STAR_LIMIT"].Value[1])

local function InitSkillChild(self, transform, skillId, skillType)

    if skillType == SkillType.Attack then
        enhanceType = "EnhanceAttack"
    elseif skillType == SkillType.PassiveSkill then
        enhanceType = "EnhancePassiveSkill"
    elseif skillType == SkillType.Skill then
        enhanceType = "EnhanceSkill"
    elseif skillType == SkillType.Ultimate then
        enhanceType = "EnhanceUltimate"
    end

    local zSkill = Z_Skill[skillId]
    local iconImg = transform:Find("SkillItem/ImageBg/Icon"):GetComponent("Image")

    local name = transform:Find("Name/SkillText"):GetComponent("Text")
    local desc = transform:Find("SkillDescriptionText"):GetComponent("Text")
    local cd = transform:Find("CD/CDText"):GetComponent("Text")

    UIUtil.SetSprite(iconImg,AtlasConfig.SkillIcon,zSkill.SkillIcon)
    name.text = zSkill.Name
    cd.text = zSkill.CooldownTurn

    local descInfo =  zSkill.SkillDesc

    local evoInfo = Z_CharacterEvolution[self.model.cardId]
    local skillparams = {}
    for _, value in ipairs(zSkill.Params) do
        table.insert(skillparams, value)
    end

    if evoInfo == nil then
        return
    end
    for i = 1, self.model.cardStar do
        if evoInfo[i] ~= nil then
            for index, value in ipairs(evoInfo[i][enhanceType]) do
                skillparams[index] = value + skillparams[index]
            end
        end
    end

    for index, value in ipairs(skillparams) do
        descInfo = string.gsub(descInfo, "XX" .. index, value)
    end

    desc.text = string.sub(descInfo, 2, -2)----descInfo
end

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    LangUtil.BindText(self.rc:GetObject"TitleText").text = LangUtil.GetSysLang(229)
    self.statusText = LangUtil.BindText(self.rc:GetObject"StatusText")
    self.descText = LangUtil.BindText(self.rc:GetObject("DescText"))
    LangUtil.BindText(self.minButton.transform:Find("Text")).text = LangUtil.GetSysLang(1439)
    LangUtil.BindText(self.maxButton.transform:Find("Text")).text = "MAX"
end

function this:OnCreate()
    base.OnCreate(self)
    self.back_btn = self.rc:GetObject("EventBg")
    self.cardInfo = self.rc:GetObject("CardInfo").transform
    self.nameText = self.rc:GetObject("NameText"):GetComponent("Text")
    self.CVText = self.rc:GetObject("CVText"):GetComponent("Text")
    self.IllustText = self.rc:GetObject("IllustText"):GetComponent("Text")
    self.skillContent = self.rc:GetObject("SkillLayout").transform
    ---@type UnityEngine.Transform
    self.numericalRoot = self.rc:GetObject("Numerical").transform
    for i = 0, self.numericalRoot.childCount - 1 do
        local index = i + 1
        local child = self.numericalRoot:GetChild(i)
        local property = showPropertySort[index].property
        LangUtil.BindText(child:Find("Text")).text = LangUtil.GetSysLang(Z_Property[property].SysLangKey)
        UIUtil.SetSprite(child:Find("Image"):GetComponent("Image"), AtlasConfig.Property, Z_Property[property].Icon ..".png")
    end
    UIUtil.AddBtnEventNoBug(self.back_btn,function()self.ctrl:CloseSelf()end,"Back")
    self.minButton = self.rc:GetObject("MinButton")
    self.minMask = self.minButton.transform:Find("Mask").gameObject
    self.maxButton = self.rc:GetObject("MaxButton")
    self.maxMask = self.maxButton.transform:Find("Mask").gameObject
    UIUtil.AddBtnEventNoBug(self.minButton,function()
        self.model.cardStar = 1
        self.model.cardLevel = 1
        self.model.isMax = false
        self:OnRefresh()
    end)
    UIUtil.AddBtnEventNoBug(self.maxButton,function()
        self.model.cardStar = CHARACTER_STAR_LIMIT
        self.model.cardLevel = CHARACTER_LEVEL_LIMIT
        self.model.isMax = true
        self:OnRefresh()
    end)
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    self.minMask:SetActive(self.model.isMax)
    self.maxMask:SetActive(not self.model.isMax)

    -- 卡片
    local transform = self.cardInfo.transform
    local card = {TemplateId = self.model.cardId,Star = self.model.cardStar}
    local zCard = Z_Card[self.model.cardId]
    local star = transform:Find("Star")
    local name = transform:Find("Name/Value"):GetComponent("Text")
    local level = transform:Find("LevelText"):GetComponent("Text")
    local mainProp = transform:Find("MainProp")
    local subProp = transform:Find("SubProp"):GetComponent("Image")
    local cardFrom = transform:Find("CardFrom"):GetComponent("Image")
    local rareFrame = transform:Find("RareFrame"):GetComponent("Image")
    local dividingLine = transform:Find("DividingLine"):GetComponent("Image")
    local raility = transform:Find("Raility"):GetComponent("Image")
    local cardFaceValue = transform:Find("CardFace/CardFaceValue"):GetComponent("Image")
    name.text = zCard.Name
    level.text = "Lv." .. self.model.cardLevel
    local cardInfo = Z_Character[self.model.cardId]

    local skinId = nil
    if self.model.isMax then
        skinId = zCard.Id * 100 + 3
    else
        skinId = nil
    end

    coroutine.start(function ()
        UIPublic.NewInitStar(star:GetComponent("Image"),card.Star) --星级
        UIUtil.SetSprite(mainProp:GetComponent("Image"), AtlasConfig.Class,
                cardInfo.Class .. "_" .. cardInfo.Rarity ..".png")
        UIUtil.SetSprite(cardFrom,AtlasConfig.CardFrom,zCard.Sphere..".png")
        UIUtil.NewSetCardSprite(cardFaceValue:GetComponent("Image"),zCard.Id, skinId,CardPictureType.Big)
        rareFrame.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/RareFrame/"..UIPublic.RareNames[cardInfo.Rarity]..".png")
        dividingLine.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Common/CardInfo/"..UIPublic.RareNames[cardInfo.Rarity].."_Line.png")
        raility.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Common/Raility/"..UIPublic.RareNames[cardInfo.Rarity]..".png")
        UIPublic.InitSubProp(subProp, cardInfo.Prop)
    end)

    -- 详情
    self.nameText.text = Z_Card[self.model.cardId].Title .. " " .. Z_Card[self.model.cardId].Name
    self.CVText.text = Z_Card[self.model.cardId].VoicerName
    self.IllustText.text = Z_Card[self.model.cardId].PainterName

    local statusText = string.gsub(LangUtil.GetSysLang(1438), "XXX", self.model.cardLevel)
    statusText = string.gsub(statusText, "YYY", self.model.cardStar)
    self.statusText.text = statusText
    self.descText.text = zCard.Archive
    -- 属性
    local zCharacterGrowth = Z_CharacterGrowth[self.model.cardId]
    for i = 0, self.numericalRoot.childCount - 1 do
        local index = i + 1
        local child = self.numericalRoot:GetChild(i)
        local property = showPropertySort[index].property
        LangUtil.BindText(child:Find("Value")).text = zCharacterGrowth[self.model.cardLevel][showPropertySort[index].subName]
        
    end

    -- 技能
    local skillInfo = Z_CharacterEvolution[self.model.cardId] 
    local skillIdList = {
        skillInfo[1].Attack,
        skillInfo[1].Skill,
        skillInfo[1].Ultimate,
        skillInfo[2].PassiveSkill
    }
    local cardData = {
        Id = self.model.cardId,
        Bead = 0,
        Constellation = 0,
        Star = self.model.cardStar,
    }
    for i = 0,self.skillContent.childCount - 1 do
        local skillChild = self.skillContent:GetChild(i)
        UIPublic.InitSkillChild(skillChild, skillIdList[i+1], i + 1, cardData, true)
        
        --InitSkillChild(self,skillChild, skillIdList[i+1], i+1, true)
    end
    
end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddUIListener(UIMessageNames.xxx, func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveUIListener(UIMessageNames.xxx)
end


function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this
