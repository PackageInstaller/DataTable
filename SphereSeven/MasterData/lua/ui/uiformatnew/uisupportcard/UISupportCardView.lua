--
-- <代码文件解释说明>
--

---@class UISupportCardView : UIBaseView
---@field model UISupportCardModel
---@field ctrl UISupportCardCtrl
local UISupportCardView = BaseClass("UISupportCardView",UIBaseView)
local base = UIBaseView
local this = UISupportCardView

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    LangUtil.BindText(self.rc:GetObject("TitleText")).text = LangUtil.GetSysLang(229) -- 详情

    self.atk = LangUtil.BindText(self.rc:GetObject("ATK"))
    self.hp = LangUtil.BindText(self.rc:GetObject("HP"))
    self.def = LangUtil.BindText(self.rc:GetObject("DEF"))
    self.magicDef = LangUtil.BindText(self.rc:GetObject("MAGICDEF"))
    self.speed = LangUtil.BindText(self.rc:GetObject("SPEED"))
end

function this:OnCreate()
    base.OnCreate(self)
    UIUtil.AddBtnEvent(self.rc:GetObject("eventBg"), function()
        self.ctrl:CloseSelf()
    end)
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()


    self.cardItem = self.rc:GetObject("CardInfo")
    UIPublic.InitCardItemDataNew(
        self.model.battleUnit.cardData,
        self.cardItem
    )

    self.fightSoulItem = self.rc:GetObject("FightVisitItemMid")
    if self.model.battleUnit.fightSoulEntity ~= nil then
        UIPublic.InitVsFightSoulItemMId(
            self.model.battleUnit.fightSoulEntity,
            self.fightSoulItem,
            nil,
            true
        )
        self.fightSoulItem:SetActive(true)
    else
        self.fightSoulItem:SetActive(false)
    end

    -- 装备
    local EquipLayout = self.rc:GetObject("EquipLayout").transform
    for i = 0, EquipLayout.childCount-1 do
        local item = EquipLayout:GetChild(i)
        local equip = table.first(self.model.battleUnit.cardData.equips, function(v)
            return v.slot == i + 1
        end)
        local bg = item:Find("StarBg")
        local avatar = item:Find("Avatar")
        if equip == nil or equip.id == 0 or Z_Equip[equip.id] == nil then
            bg.gameObject:SetActive(false)
            avatar.gameObject:SetActive(false)
        else
            bg.gameObject:SetActive(true)
            avatar.gameObject:SetActive(true)
            UIPublic.InitEquipImage(equip.id,item)
        end
    end


    self.skillLayout = self.rc:GetObject("SkillLayout").transform

    local skillIdList = {
        self.model.battleUnit.cardData.Skills.attack,
        self.model.battleUnit.cardData.Skills.skill,
        self.model.battleUnit.cardData.Skills.ultimate,
        self.model.battleUnit.cardData.Skills.passive_skill
    }
    for i = 0,self.skillLayout.transform.childCount - 1 do
        local skillChild = self.skillLayout.transform:GetChild(i)
        UIPublic.InitSkillChild(skillChild.transform, skillIdList[i+1], i)
    end

    -- 数据结构在 BattleUnit.lua 中 
    -- self.atk.text = "atk"
    -- self.hp.text = "hp"
    -- self.def.text = "def"
    -- self.magicDef.text = "magicDef"
    -- self.speed.text = "speed"

    self.propertyLayout = self.rc:GetObject("PropertyLayout")

    UIPublic.InitNumerical(self.propertyLayout, self.model.battleUnit:GetBattleCharacter()) --面板属性
end

-- function this:GetProperty()
--     -- 装备


--     local zCharacterGrowth = Z_CharacterGrowth[self.__entity.TemplateId][self.__entity.Level]
--     local hp = zCharacterGrowth.Hp










--     self.numeric_component:Set(NumericType.MaxHpBase, zCharacterGrowth.Hp)
--     self.numeric_component:Set(NumericType.AtkBase, zCharacterGrowth.Atk)
--     self.numeric_component:Set(NumericType.DefBase, zCharacterGrowth.Def)
--     self.numeric_component:Set(NumericType.MagicDefBase, zCharacterGrowth.MagicDef)
--     self.numeric_component:Set(NumericType.SpeedBase, zCharacterGrowth.Speed)
-- end

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
