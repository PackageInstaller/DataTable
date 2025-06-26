--
-- <代码文件解释说明>
--

---@class UIFormationChooseFightSoulPropertyView : UIBaseView
---@field model UIFormationChooseFightSoulPropertyModel
---@field ctrl UIFormationChooseFightSoulPropertyCtrl
local UIFormationChooseFightSoulPropertyView = BaseClass("UIFormationChooseFightSoulPropertyView",UIBaseView)
local base = UIBaseView
local this = UIFormationChooseFightSoulPropertyView

local showPropertySort = {
    [1] = {
        Property = NumericType.Hp,
        ValueProperty = NumericType.MaxHpBase,
    },
    [2] = {
        Property = NumericType.Atk,
        ValueProperty = NumericType.AtkBase,
    },
    [3] = {
        Property = NumericType.Def,
        ValueProperty = NumericType.DefBase,
    },
    [4] = {
        Property = NumericType.MagicDef,
        ValueProperty = NumericType.MagicDefBase,
    }
}

local RecordTypeIndex = {
    [1] = nil,
    [2] = RecordType.Character,
    [3] = RecordType.FightSoul,
    [4] = RecordType.Equip,
}

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    LangUtil.GetSpriteLang(477, function(sprite) self.rc:GetObject("TitleImage"):GetComponent("Image").sprite = sprite end)
    local titleSysLangKeys = {
        1281, 1186, 90, 259, 253 -- 属性信息, 总加成, 超越者, 战魂, 装备
    }

    self.title = self.rc:GetObject("Title").transform

    local propertys = {
        self.rc:GetObject("Property1").transform,
        self.rc:GetObject("Property2").transform,
        self.rc:GetObject("Property3").transform,
        self.rc:GetObject("Property4").transform,
    }

    for i = 0, self.title.childCount - 1 do
        local child = self.title:GetChild(i)
        LangUtil.BindText(child).text = LangUtil.GetSysLang(titleSysLangKeys[i + 1])
    end

    self.propertyInfo = {}
    for index, value in ipairs(propertys) do
        self.propertyInfo[index] = {}
        self.propertyInfo[index].texts = {} -- 对应这一行的多个text
        for i = 1, value.childCount - 2 do
            local child = value:GetChild(i)
            self.propertyInfo[index].texts[i + 1] = LangUtil.BindText(child,FontType.All_Number)
        end
        self.propertyInfo[index].texts[1] = LangUtil.BindText(value:Find("PropertyRoot/Value"),FontType.All_Number)
        local image = value:Find("PropertyRoot/Image"):GetComponent("Image")
        UIUtil.SetSprite(image, AtlasConfig.Property, Z_Property[showPropertySort[index].Property].Icon ..".png")
        LangUtil.BindText(value:Find("PropertyRoot/Text")).text = LangUtil.GetSysLang(Z_Property[showPropertySort[index].Property].SysLangKey)
        -- local name = value:Find("PropertyRoot/Name"):GetComponent("Image")
        -- name.text = 
    end
end

function this:OnCreate()
    base.OnCreate(self)

    self.eventBg = self.rc:GetObject("EventBg")
    
    UIUtil.AddBtnEvent(self.eventBg, function(v) self.ctrl.CloseSelf() end)
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    ---@type Card
    local character = Game.Scene.Player:GetComponent("CardComponent"):Get(self.model.characterId)
    local fightSoul
    if self.model.fightSoulId ~= nil then
        ---@type FightSoul
        fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(self.model.fightSoulId)
    end

    for propertyIndex, value in ipairs(self.propertyInfo) do
        local propertyType = showPropertySort[propertyIndex].Property
        local numeric_component = character:GetComponent("NumericComponent")

        local cardValue = numeric_component:Get(showPropertySort[propertyIndex].ValueProperty)
        value.texts[2].text = cardValue
        local fightSoulValue = 0
        if self.model.fightSoulId ~= nil then
            fightSoulValue = fightSoul:GetProperty(propertyType)
        end
        
        value.texts[3].text = fightSoulValue
        value.texts[1].text = cardValue + fightSoulValue

        -- local propertyValue = propertys[propertyType]
        -- if propertyValue == nil then
        --     value.texts[key].text = 0
        -- else
        --     value.texts[key].text = "+" .. propertyValue / 100 .. "%"
        -- end
    end

    for key = 1, 3 do
        local recordType = RecordTypeIndex[key]
        -- key 对应第几列数据
        local propertys = Game.Scene.Player:GetComponent("RecordComponent"):GetProperty(recordType)

        
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
