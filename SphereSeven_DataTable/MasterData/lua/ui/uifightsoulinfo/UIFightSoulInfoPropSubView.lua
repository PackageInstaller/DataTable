---@class UIFightSoulInfoPropSubView
local PropSubView = {}
local this = PropSubView

local ShowPropertyIndex = {
    [1] = NumericType.Hp,
    [2] = NumericType.Atk,
    [3] = NumericType.Def,
    [4] = NumericType.MagicDef,
}

-- 初始化
---@param self UIFightSoulInfoView
function this.Init(self, gameObject)

    ---@type ReferenceCollector
    local rc = gameObject:GetComponent("ReferenceCollector")
    LangUtil.GetSpriteLang(478, function(sprite) rc:GetObject("PropertyTitle"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(470, function(sprite) rc:GetObject("StatusImage"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(472, function(sprite) rc:GetObject("EquipEffectTitle"):GetComponent("Image").sprite = sprite end)

    local class = rc:GetObject("Class").transform
    this.class = class:Find("Value"):GetComponent("Image")
    LangUtil.BindText(class:Find("Text")).text = LangUtil.GetSysLang(166)

    local rare = rc:GetObject("Rare").transform
    this.rare = rare:Find("Value"):GetComponent("Image")
    LangUtil.BindText(rare:Find("Text")).text = LangUtil.GetSysLang(1182)    

    local numerical = rc:GetObject("Numerical").transform
    this.propertyList = {}
    for i = 0, numerical.childCount - 1 do
        local child = numerical.transform:GetChild(i)
        local property = ShowPropertyIndex[i + 1]
        this.propertyList[property] = LangUtil.BindText(child:Find("Value"))
        child:Find("Text"):GetComponent("Text").text = LangUtil.GetSysLang(Z_Property[property].SysLangKey)
        UIUtil.SetSprite(child:Find("Image"):GetComponent("Image"), AtlasConfig.Property, Z_Property[property].Icon ..".png")
    end

    this.desc = LangUtil.BindText(rc:GetObject("Desc"))

    this.expBar = rc:GetObject("ExpBar"):GetComponent("Slider")
    this.curLevelText = LangUtil.BindText(rc:GetObject("CurLevelText"), FontType.All_Number)
    this.maxtLevelText = LangUtil.BindText(rc:GetObject("MaxtLevelText"), FontType.All_Number)
    this.expProgressText = LangUtil.BindText(rc:GetObject("ExpProgressText"), FontType.All_Number)
end

---@param self UIFightSoulInfoView
function this.OnLangCreate(self, gameObject)
end

---@param self UIFightSoulInfoView
function this.OnEnable(self)
end

---@param self UIFightSoulInfoView
function this.OnRefresh(self)
    local fightSoul = self.model.fightSoul
    for property, text in pairs(this.propertyList) do
        text.text = fightSoul:GetProperty(property)
    end
    local zFightSoul = Z_FightSoul[self.model.fightSoul.TemplateId]
    local class = UIPublic.GetFightSoulClass(zFightSoul.ClassLimit)
    UIUtil.SetSprite(this.rare, AtlasConfig.Class, class.. "_" .. zFightSoul.Rare ..  ".png")
    this.class.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Common/Raility/"..UIPublic.RareNames[zFightSoul.Rare]..".png")
    this.desc.text = UIPublic.GetFightSoulEffectText(self.model.fightSoul.TemplateId, self.model.fightSoul.Star)

    local maxExp = Z_FightSoulLevelUpExp[self.model.fightSoul.level][RarityName[self.model.fightSoul.config.Rare]]
    local expPer = self.model.fightSoul.exp / maxExp
    if expPer > 1 then
        expPer = 1
    end
    this.expBar.value = expPer
    this.expProgressText.text = math.modf(expPer * 100) .. "%"

    this.curLevelText.text = self.model.fightSoul.level
    this.maxtLevelText.text = self.model.fightSoul.maxLevel
end

---@param self UIFightSoulInfoView
function this.OnDisable(self)
end

---@param self UIFightSoulInfoView
function this.ClearChoose(self)
end

---@param self UIFightSoulInfoView
function this.OnDestroy(self)
end

---@param self UIFightSoulInfoView
function this.OnFightSoulUpdate(self)
end

return this