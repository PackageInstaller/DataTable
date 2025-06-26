--
-- <代码文件解释说明>
--

---@class UIGameEventLevelRateUpView : UIBaseView
---@field model UIGameEventLevelRateUpModel
---@field ctrl UIGameEventLevelRateUpCtrl
local UIGameEventLevelRateUpView = BaseClass("UIGameEventLevelRateUpView",UIBaseView)
local base = UIBaseView
local this = UIGameEventLevelRateUpView

local pfbName = "GameEventLevelRateUpItem"

function this:OnLangCreate()
    self.titleText = LangUtil.BindText(self.langRc:GetObject("Text"))
end

function this:InitItemData(arg)
    local data = arg.data
    local object = arg.go
    local transform = object.transform
    ---@type ReferenceCollector
    local rc = transform:GetComponent("ReferenceCollector")

    local cardItem = rc:GetObject("CardItemLittle")
    LangUtil.BindText(rc:GetObject("NameText")).text = Z_Card[data.id].Name
    LangUtil.BindText(rc:GetObject("RateText")).text = "+" .. data.rate .. "%"

    -- local card = Game.Scene.Player:GetComponent("CardComponent"):Get(data.id)
    -- if card == nil then
    local    card = {
            Id = data.id,
            Star = nil,
            Level = nil,
        }
    -- end
    UIPublic.InitCardItemLittle(card, cardItem)

    local mask = rc:GetObject("Mask")
    mask:SetActive(not data.isOn)
    LangUtil.BindText(rc:GetObject("MaskText")).text = LangUtil.GetSysLang(1426)
end

function this:OnCreate()
    base.OnCreate(self)

    UIUtil.AddBtnEvent(self.rc:GetObject("EventBg"), function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIGameEventLevelRateUp)
    end)

    self.scrollView = self.rc:GetObject("Scroll View")
    self.scroll = VerticalScroll.New()
    self.scroll:SetUpdateCount(4)
    
    self.scroll:Clear()
    self.scroll:ScrollInit({}, self.scrollView, pfbName, function (arg)
        self:InitItemData(arg)
    end) 

    self.imageRoot = self.rc:GetObject("ImageRoot").transform
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()

    local itemsName = ""
    if self.model.entryModule.config.ModuleParams ~= nil then
        for k, id in pairs(self.model.entryModule.config.ModuleParams) do
            if k > 1 then
                itemsName = itemsName .. ","
            end
            local zItem = Z_Item[id]
            itemsName = itemsName .. zItem.Name
        end
    end
    self.titleText.text = string.gsub(LangUtil.GetSysLang(1425), "XXX", itemsName)

    for i = 0, self.imageRoot.childCount-1 do
        local child = self.imageRoot:GetChild(i).gameObject
        child:SetActive(i == self.model.imageIndex)
    end
    self.scroll:RefreshData(self.model.LevelDropBoostList)
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
