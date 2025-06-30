--
-- <代码文件解释说明>
--

---@class UIBossraidTeamInfoView : UIBaseView
---@field model UIBossraidTeamInfoModel
---@field ctrl UIBossraidTeamInfoCtrl
local UIBossraidTeamInfoView = BaseClass("UIBossraidTeamInfoView",UIBaseView)
local base = UIBaseView
local this = UIBossraidTeamInfoView

local pfbName = "BossraidTeamItem"

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    LangUtil.BindText(self.langRc:GetObject("Text")).text = LangUtil.GetSysLang(1494)
end

local numberKeys = {
    1496,
    1497,
    1498,
    1499,
    1500,
    1501,
    1502,
    1503,
    1504,
    1505,
}

local function numberToChinese(num)
    if num < 1 or num > 99 then
        return num
    end

    if num <= 10 then
        return LangUtil.GetSysLang(numberKeys[num])
    end

    local tens = math.floor(num / 10)
    local units = num % 10

    if tens == 1 then
        if units == 0 then
            return LangUtil.GetSysLang(numberKeys[10])
        else
            return LangUtil.GetSysLang(numberKeys[10]) .. LangUtil.GetSysLang(numberKeys[units])
        end
    else
        if units == 0 then
            return LangUtil.GetSysLang(numberKeys[tens]) .. LangUtil.GetSysLang(numberKeys[10])
        else
            return LangUtil.GetSysLang(numberKeys[tens]) .. LangUtil.GetSysLang(numberKeys[10]) .. LangUtil.GetSysLang(numberKeys[units])
        end
    end
end


function this:InitItem(arg)
    ---@type BattleFormation
    local data = arg.data
    local object = arg.go
    local index = arg.index

    ---@type ReferenceCollector
    local rc = object:GetComponent("ReferenceCollector")
    LangUtil.BindText(rc:GetObject("Text")).text = LangUtil.GetSysLang(649) .. numberToChinese(index)
    local cardLayout = rc:GetObject("CardLayout").transform
    local fightLayout = rc:GetObject("FightSoulLayout").transform
    for i = 1, 6 do
        ---@type BattleUnit
        ---@param v BattleUnit
        local unit = table.first(data.trueUnits, function(v) return v.formationPostion == i end)
        local cardChild = cardLayout:GetChild(i -1)
        local cardItem = cardChild:GetChild(0)
        if unit == nil or unit.cardData == nil then
            cardItem.gameObject:SetActive(false)
        else
            cardItem.gameObject:SetActive(true)
            UIPublic.InitCardItemLittle(unit.cardData, cardItem.gameObject)
        end

        local fightChild = fightLayout:GetChild(i -1)
        local fightItem = fightChild:GetChild(0)
        if unit == nil or unit.fightSoulEntity == nil then
            fightItem.gameObject:SetActive(false)
        else
            fightItem.gameObject:SetActive(true)
            UIPublic.InitVsFightSoulItemMId(unit.fightSoulEntity, fightItem.gameObject)
        end
    end
end

function this:OnCreate()
    base.OnCreate(self)

    UIUtil.AddBtnEvent(self.rc:GetObject("EventBg"), function()
        self.ctrl:CloseSelf()
    end)

    self.vs_list = {}
    self.scroll = VerticalScroll.New()
    self.scrollView = self.rc:GetObject("ScrollView"):GetComponent("ScrollRect")

    self.scroll:Clear()
    self.scroll:ScrollInit({}, self.scrollView, pfbName, function (arg)
        self:InitItem(arg)
    end)
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    self.scroll:RefreshData(self.model.data.record.formations)
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
    self.scroll:Dispose()
end

return this
