--
-- <代码文件解释说明>
--

---@class UIHandBookPropertyView : UIBaseView
---@field model UIHandBookPropertyModel
---@field ctrl UIHandBookPropertyCtrl
local UIHandBookPropertyView = BaseClass("UIHandBookPropertyView",UIBaseView)
local base = UIBaseView
local this = UIHandBookPropertyView

local showPropertySort = {
    [1] = NumericType.Hp,
    [2] = NumericType.Atk,
    [3] = NumericType.Def,
    [4] = NumericType.MagicDef,
    [5] = NumericType.Speed,
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
        self.rc:GetObject("Property5").transform,
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
        UIUtil.SetSprite(image, AtlasConfig.Property, Z_Property[showPropertySort[index]].Icon ..".png")
        LangUtil.BindText(value:Find("PropertyRoot/Text")).text = LangUtil.GetSysLang(Z_Property[showPropertySort[index]].SysLangKey)
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
    for key = 1, 4 do
        local recordType = RecordTypeIndex[key]
        -- key 对应第几列数据
        local propertys = Game.Scene.Player:GetComponent("RecordComponent"):GetProperty(recordType)

        for propertyIndex, value in ipairs(self.propertyInfo) do
            local propertyType = showPropertySort[propertyIndex]
            local propertyValue = propertys[propertyType]
            if propertyValue == nil then
                value.texts[key].text = 0
            else
                value.texts[key].text = "+" .. propertyValue / 100 .. "%"
            end
        end
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
