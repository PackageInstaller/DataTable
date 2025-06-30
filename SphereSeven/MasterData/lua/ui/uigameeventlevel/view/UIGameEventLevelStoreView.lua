--
-- <代码文件解释说明>
--

---@class UIGameEventLevelStoreView : UIBaseView
---@field model UIGameEventLevelStoreModel
---@field ctrl UIGameEventLevelStoreCtrl
local UIGameEventLevelStoreView = BaseClass("UIGameEventLevelStoreView",UIBaseView)
local base = UIBaseView
local this = UIGameEventLevelStoreView

local pfbName = "GameEventLevelStoreItem"

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    self.timeText = LangUtil.BindText(self.rc:GetObject("TimeText"))
end

function this:InitItemData(arg)
    local data = arg.data
    local object = arg.go
    local transform = object.transform
    ---@type ReferenceCollector
    local rc = transform:GetComponent("ReferenceCollector")

    local imageRoot = rc:GetObject("ImageRoot").transform
    for i = 0, imageRoot.childCount-1 do
        local child = imageRoot:GetChild(i).gameObject
        child:SetActive(i == self.model.imageIndex)
    end

    local maskImageRoot = rc:GetObject("MaskImageRoot").transform
    for i = 0, maskImageRoot.childCount-1 do
        local child = maskImageRoot:GetChild(i).gameObject
        child:SetActive(i == self.model.imageIndex)
    end

    local zStore = data.config
    if zStore.QuotaNum == 0 then
        LangUtil.BindText(rc:GetObject("CountText")).text = "" -- 无限购买
    else
        LangUtil.BindText(rc:GetObject("CountText")).text = LangUtil.GetSysLang(461) .. data.buy_times .. "/" .. zStore.QuotaNum
    end
    local nameTxt = LangUtil.BindText(rc:GetObject("NameText"))
    nameTxt.text = zStore.Name
    UIUtil.ScrollText(nameTxt.transform)
    UIUtil.SetSprite(rc:GetObject("PriceImage"):GetComponent("Image"),AtlasConfig.Item,GetItemIcon(Z_Item[zStore.PriceType]),true)
    LangUtil.BindText(rc:GetObject("PriceText")).text = zStore.TotalPrice

    UIPublic.InitRewardItem({
        rewardId = zStore.RewardId,
        itemPrefab = rc:GetObject("ItemPrefab"),
        isShowCount = true,
        isShowThingsDetail = true,
        isShowCount = true,
    })

    local mask = rc:GetObject("Mask")
    mask:SetActive(data.is_sell_out)
    LangUtil.BindText(rc:GetObject("MaskText")).text = LangUtil.GetSysLang(1479)
    zStore.alreadyBuyCount = data.buy_times
    zStore.type = UseItemType.Shop
    UIUtil.AddBtnEvent(object, function()
        if data.is_sell_out then
            return
        end
        local itemCount = UIPublic.GetItemAmount(zStore.PriceType)
        if itemCount < zStore.TotalPrice then
            local str = string.gsub(LangUtil.GetSysLang(2092), "XX", Z_Item[zStore.PriceType].Name)
            UIUtil.ToolTipFourth(str)
            return
        end
        UIManager:GetInstance():OpenWindow(UIWindowNames.UIUseItem, zStore)
    end)
end

function this:OnCreate()
    base.OnCreate(self)

    UIPublic.SetBackButton(
        self.rc:GetObject("ReturnButton"),
        UIWindowNames.UIGameEventLevelStore
    )
    self.face = UILandlady.New(self.rc:GetObject("Paint"), 1011, self.rc:GetObject("Lines"))

    self.npcIcon = self.rc:GetObject("NpcIcon")
    self.lines = self.rc:GetObject("Lines")
    self.scroll = VerticalScroll.New()
    self.scrollView = self.rc:GetObject("Scroll View")
    self.scroll:Clear()
    self.scroll:ScrollInit({}, self.scrollView, pfbName, function (arg)
        self:InitItemData(arg)
    end)

    self.imageRoot = self.rc:GetObject("ImageRoot").transform
end

function this:PlayAnim()
    self.face:CoPlay(self.model.UILandladyId)
end

function this:OnEnable()
    base.OnEnable(self)
    self:PlayAnim()
    self:OnRefresh()
end

function this:OnRefresh()
    for i = 0, self.imageRoot.childCount-1 do
        local child = self.imageRoot:GetChild(i).gameObject
        child:SetActive(i == self.model.imageIndex)
    end

    local lastTimeText = ""
    local time1 = TimeUtil.ConvertTimeForm(self.model.module.endTime - TimeUtil.GetServerTime())
    if time1.day > 0 then
        lastTimeText = lastTimeText .. time1.day .. LangUtil.GetSysLang(2006) -- 天
    end
    if time1.hour > 0 then
        lastTimeText = lastTimeText .. time1.hour .. LangUtil.GetSysLang(2007) -- 小时
    end
    if time1.day == 0 then
        lastTimeText = lastTimeText .. time1.minute .. LangUtil.GetSysLang(1478) -- 分
    end
    self.timeText.text = LangUtil.GetSysLang(1422) .. lastTimeText
    self.scroll:RefreshData(self.model.goods)
end

local function ON_ITEM_INFO_CHG(self)
    self.scroll:RefreshData(self.model.goods)
end

function this:OnAddListener()
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_ITEM_INFO_CHG, ON_ITEM_INFO_CHG)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_ITEM_INFO_CHG)
end

function this.OnViewTop(self)
    base.OnViewTop(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)   
    self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    -- self.comTopView:InitComTop(self, self:GetName())

    local ids = {}
    local idMap = {}
    for k, v in pairs(self.model.goods) do
        local itemId = v.config.PriceType
        if idMap[itemId] == nil then
            idMap[itemId] = true
            table.insert(ids, {
                ObjId = itemId
            })
        end
    end

    self.comTopView:CustomizeComTop( ids )
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

function this:OnDisable()
    base.OnDisable(self)
    self.face:Disable()
end

function this:OnDestroy()
    base.OnDestroy(self)
    self.scroll:Dispose()
end

return this
