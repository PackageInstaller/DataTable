
---@class UIThingsDetailFightSoulView
---@field model UIThingsDetailFightSoulModel
local UIThingsDetailFightSoulView = BaseClass("UIThingsDetailFightSoulView",UIBaseView)
local base = UIBaseView
local this = UIThingsDetailFightSoulView

local stageConfig = {}
local labConfig = {}

local ShowPropertyIndex = {
    [1] = NumericType.Hp,
    [2] = NumericType.Atk,
    [3] = NumericType.Def,
    [4] = NumericType.MagicDef,
}

local FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE = Z_Misc["FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE"].Value

---@param self UIThingsDetailFightSoulView
local function OnLangCreate(self)
    LangUtil.BindText(self.langRc:GetObject("TitleText")).text = LangUtil.GetSysLang(229) -- 详情
    self.nameText = LangUtil.BindText(self.langRc:GetObject("NameText"))
    
    LangUtil.BindText(self.langRc:GetObject("ClassText")).text = LangUtil.GetSysLang(1182) -- 职业
    self.classValue = LangUtil.BindText(self.langRc:GetObject("ClassValue"))
    LangUtil.BindText(self.langRc:GetObject("RarityText")).text = LangUtil.GetSysLang(166) -- 稀有度
    self.rarityValue = LangUtil.BindText(self.langRc:GetObject("RarityValue"))

    self.desc = LangUtil.BindText(self.langRc:GetObject("Desc"))

    LangUtil.BindText(self.langRc:GetObject("CountText")).text = LangUtil.GetSysLang(723) -- 持有数
    self.countValue = LangUtil.BindText(self.langRc:GetObject("CountValue"))

    LangUtil.BindText(self.minButton.transform:Find("Text")).text = LangUtil.GetSysLang(1439)
    LangUtil.BindText(self.maxButton.transform:Find("Text")).text = "MAX"

    self.statusText = LangUtil.BindText(self.langRc:GetObject"StatusText")
    self.levelText = LangUtil.BindText(self.langRc:GetObject"LevelText")
end

---@param self UIThingsDetailFightSoulView
local function OnCreate(self)
    base.OnCreate(self)
    EventTriggerListener.Get(self.rc:GetObject("EventBg")).onLuaClick = self.ctrl.CloseSelf
    self.fightSoulCardInfo = self.rc:GetObject("UIFightSoulCardInfo").transform
    
    local maxStar = table.count(FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE)
    local maxLevel = tonumber(FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE[maxStar])

    self.minButton = self.rc:GetObject("MinButton")
    self.minMask = self.minButton.transform:Find("Mask").gameObject
    self.maxButton = self.rc:GetObject("MaxButton")
    self.maxMask = self.maxButton.transform:Find("Mask").gameObject
    UIUtil.AddBtnEventNoBug(self.minButton,function()
        self.model.star = 1
        self.model.level = 1
        self.model.isMax = false
        self:OnRefresh()
    end)
    UIUtil.AddBtnEventNoBug(self.maxButton,function()
        self.model.star = maxStar
        self.model.level = maxLevel
        self.model.isMax = true
        self:OnRefresh()
    end)

    local numerical = self.rc:GetObject("Numerical").transform
    self.propertyList = {}
    for i = 0, numerical.childCount - 1 do
        local child = numerical.transform:GetChild(i)
        local property = ShowPropertyIndex[i + 1]
        self.propertyList[property] = LangUtil.BindText(child:Find("Value"))
        LangUtil.BindText(child:Find("Text")).text = LangUtil.GetSysLang(Z_Property[property].SysLangKey)
        UIUtil.SetSprite(child:Find("Image"):GetComponent("Image"), AtlasConfig.Property, Z_Property[property].Icon ..".png")
    end
    
end

---@param self UIThingsDetailFightSoulView
local function OnEnable(self)
    base.OnEnable(self)
    coroutine.start(function()
        self.gameObject:SetActive(false)
        self:OnRefresh()
        self.gameObject:SetActive(true)
    end)
end

local propertyKey = {
    [NumericType.Hp] = "Hp",
    [NumericType.Atk] = "Atk",
    [NumericType.Def] = "Def",
    [NumericType.MagicDef] = "MDef",
}

---@param self UIThingsDetailFightSoulView
local function OnRefresh(self)
    self.minMask:SetActive(self.model.isMax)
    self.maxMask:SetActive(not self.model.isMax)
    local statusText = string.gsub(LangUtil.GetSysLang(1440), "XXX", self.model.level)
    statusText = string.gsub(statusText, "YYY", self.model.star)
    self.statusText.text = statusText
    self.levelText.text = "Lv." .. self.model.level
    local fightSoulData = {
        TemplateId = self.model.fightSoulId,
        isEquip = false,
        level = self.model.level,
        Lock = nil,
        Star = self.model.star,
        config = Z_FightSoul[self.model.fightSoulId]
    }
    UIPublic.InitFightSoulFace(fightSoulData, self.fightSoulCardInfo)

    local fightSoul = self.model.fightSoul
    local zFightSoulLevelGrowth = Z_FightSoulLevelGrowth[self.model.fightSoulId]
    for property, text in pairs(self.propertyList) do
        text.text = zFightSoulLevelGrowth[self.model.level][propertyKey[property]]
    end
    
    local zFightSoul = Z_FightSoul[self.model.fightSoulId]
    self.nameText.text = zFightSoul.Name

    ---@type FightSoulComponent
    local FightSoulComponent = Game.Scene.Player:GetComponent("FightSoulComponent")

    local count = table.count(FightSoulComponent:GetSameFightSoulList(self.model.fightSoulId))
    self.countValue.text = count

    self.rarityValue.text = RarityName[zFightSoul.Rare]
    local class = UIPublic.GetFightSoulClass(zFightSoul.ClassLimit)
    self.classValue.text = LangUtil.GetSysLang(SysLangKeys.ClassName[class])
    self.desc.text =  UIPublic.GetFightSoulEffectText(self.model.fightSoulId, self.model.star)
end

local function OnAddListener(self)
    base.OnAddListener(self)
end

local function OnRemoveListener(self)
    base.OnRemoveListener(self)
end

---@param self UIThingsDetailFightSoulView
local function OnDisable(self)
end

local function OnDestroy(self)
    base.OnDestroy(self)
end



UIThingsDetailFightSoulView.OnCreate = OnCreate
UIThingsDetailFightSoulView.OnEnable = OnEnable
UIThingsDetailFightSoulView.OnRefresh = OnRefresh
UIThingsDetailFightSoulView.OnAddListener = OnAddListener
UIThingsDetailFightSoulView.OnRemoveListener = OnRemoveListener
UIThingsDetailFightSoulView.OnDisable= OnDisable
UIThingsDetailFightSoulView.OnDestroy = OnDestroy
UIThingsDetailFightSoulView.OnLangCreate = OnLangCreate

return UIThingsDetailFightSoulView