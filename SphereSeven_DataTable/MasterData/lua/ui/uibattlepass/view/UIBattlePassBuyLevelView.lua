--
-- <代码文件解释说明>
--

---@class UIBattlePassBuyLevelView : UIBaseView
---@field model UIBattlePassBuyLevelModel
---@field ctrl UIBattlePassBuyLevelCtrl
---@field changeLevel number
local UIBattlePassBuyLevelView = BaseClass("UIBattlePassBuyLevelView",UIBaseView)
local base = UIBaseView
local this = UIBattlePassBuyLevelView

function this:OnLangCreate()
    self.numberText = LangUtil.BindText(self.rc:GetObject("NumberText"))
    self.levelText = LangUtil.BindText(self.rc:GetObject("LevelText"))
    LangUtil.BindText(self.rc:GetObject("CostText")).text = LangUtil.GetSysLang(1394)
    LangUtil.BindText(self.rc:GetObject("Text1")).text = LangUtil.GetSysLang(1395)
    self.costCountText = LangUtil.BindText(self.rc:GetObject("CostCountText"))
end

function this:OnCreate()
    base.OnCreate(self)
    self.back_btn = self.rc:GetObject("Mask")
    UIUtil.AddBtnEvent(self.back_btn,function()self.ctrl.CloseSelf()end,"Back")
    self.plusButton = self.rc:GetObject("PlusButton")
    UIUtil.AddBtnEvent(self.plusButton,function() self:OnPlusButton() end)
    self.minusButton = self.rc:GetObject("MinusButton")
    UIUtil.AddBtnEvent(self.minusButton,function() self:OnMinusButton() end)
    self.maxButton = self.rc:GetObject("MaxButton")
    UIUtil.AddBtnEvent(self.maxButton,function() self:OnMaxButton() end)
    self.minButton = self.rc:GetObject("MinButton")
    UIUtil.AddBtnEvent(self.minButton,function() self:OnMinButton() end)
    self.confirmButton = self.rc:GetObject("ConfirmButton")
    UIUtil.AddBtnEvent(self.confirmButton,function() self:ConfirmButtonClick() end)
    self.cancelButton = self.rc:GetObject("CancelButton")
    UIUtil.AddBtnEvent(self.cancelButton,function()self.ctrl.CloseSelf()end,"Back")
    self.costItemImage = self.rc:GetObject("CostItemImage"):GetComponent("Image")
    self.itemPrefabList = {}
    self.rawItemPrefab = self.rc:GetObject("RawItemPrefab")
    self.rawItemPrefab:SetActive(false)
end

function this:OnEnable()
    base.OnEnable(self)
    self.changeLevel = 1
    self:OnRefresh()
end


function this:OnPlusButton()
    if self.changeLevel + self.model.pass.level >= self.model.pass.config.MaxBuyLevelLimit then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(2091))
        return
    end

    local count = UIPublic.GetItemAmount(self.model.itemId)
    if count >= self.model.itemCount * (self.changeLevel + 1) then
        self.changeLevel = self.changeLevel + 1
    else
        UIUtil.ToolTipFourth( string.gsub(LangUtil.GetSysLang(1066),"XXX", Z_Item[self.model.itemId].Name )  )
        return
    end
    self:OnRefresh()
end

function this:OnMinusButton()
    if self.changeLevel - 1 >= 1 then
        self.changeLevel = self.changeLevel - 1
    else
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1065))
    end
    self:OnRefresh()
end

function this:OnMaxButton()
    local count = UIPublic.GetItemAmount(self.model.itemId)
    self.changeLevel = math.floor(count / self.model.itemCount)
    if self.changeLevel == 0 then
        self.changeLevel = 1
    end
    if self.changeLevel + self.model.pass.level > self.model.pass.config.MaxBuyLevelLimit then
        self.changeLevel = self.model.pass.config.MaxBuyLevelLimit - self.model.pass.level
    end
    self:OnRefresh()
end

function this:OnMinButton()
    self.changeLevel = 1
    self:OnRefresh()
end

function this:ConfirmButtonClick()
    local count = UIPublic.GetItemAmount(self.model.itemId)
    if count < self.model.itemCount * self.changeLevel then
        UIUtil.ToolTipFourth( string.gsub(LangUtil.GetSysLang(1066),"XXX", Z_Item[self.model.itemId].Name )  )
    end
    local currentLevel = self.model.pass.level
    PublicRequest.SendRequest(
        PROTOCOL.BuyGoodsReq,
        {
            shop_id = StoreType.Pass,
            goods = {
                {
                    goods_id = self.model.pass.config.ExpStoreId,
                    count = self.changeLevel * self.model.countPreLevel
                }
            }
        },
        function(info, errorCode)
            if errorCode == 202 then
                UIUtil.ToolTipFourth(LangUtil.GetSysLang(1086))
                return
            end

            if errorCode == 0 then 
                self.ctrl.CloseSelf()
                UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattlePassLevelUp, {
                    level = currentLevel + self.changeLevel,
                    passId = self.model.pass.id,
                })    
            end
        end
    )
end

function this:RefreshRewardItem(index, rewardType, rewardId, count)
    local go = self.itemPrefabList[index]
    if go == nil then
        go = GameObject.Instantiate(self.rawItemPrefab)
        go.transform:SetParent(self.rawItemPrefab.transform.parent, false)
        go:SetActive(true)
        go.transform:SetParent(self.rawItemPrefab.transform.parent)
        go.transform.localPosition = Vector3.New(0,0,0)
        go.transform.localScale = Vector3.New(1,1,1)
        self.itemPrefabList[index] = go
    end
    go:SetActive(true)

    local rc = go:GetComponent("ReferenceCollector")
    local icon = rc:GetObject("Icon"):GetComponent("Image")
    local itemBg = rc:GetObject("ItemBg"):GetComponent("Image")
    local frame = rc:GetObject("Frame"):GetComponent("Image")
    UIPublic.InitItemIconNew(icon, itemBg, rewardType, rewardId, count, true, false, frame)
    rc:GetObject("Num"):GetComponent("Text").text = count
end

function this:OnRefresh()
    self.numberText.text = self.changeLevel
    self.levelText.text = string.gsub(LangUtil.GetSysLang(1393),"XX", self.model.pass.level + self.changeLevel )
    self.costCountText.text = "x" .. self.changeLevel * self.model.itemCount
    UIUtil.SetSprite(self.costItemImage,AtlasConfig.Item,GetItemIcon(Z_Item[self.model.itemId]))

    local zPassReward = Z_PassReward[self.model.pass.id]
    local rewardIndex = 0
    for i = 1, self.changeLevel do
        local level = self.model.pass.level + i
        local passReward = zPassReward[level]
        if passReward == nil then
            passReward = zPassReward[table.count(zPassReward)]
        end
        local rewardId1 = passReward.NormalRewards
        for index, value in ipairs(Z_Reward[rewardId1]) do
            rewardIndex = rewardIndex + 1
            self:RefreshRewardItem(rewardIndex, value.Type, value.ObjId, value.Count)
        end
        local isUnlock = self.model.pass.membership == PassMembership.PassMembershipSpecial or self.model.pass.membership == PassMembership.PassMembershipPremium
        if isUnlock then
            local rewardId2 = passReward.SpecialRewards
            for index, value in ipairs(Z_Reward[rewardId2]) do
                rewardIndex = rewardIndex + 1
                self:RefreshRewardItem(rewardIndex, value.Type, value.ObjId, value.Count)
            end
        end
    end

    for i = rewardIndex + 1, table.count(self.itemPrefabList) do
        self.itemPrefabList[i]:SetActive(false)
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
