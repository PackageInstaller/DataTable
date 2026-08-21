--
-- <代码文件解释说明>
--

---@class UIBattlePassBuyPassView : UIBaseView
---@field model UIBattlePassBuyPassModel
---@field ctrl UIBattlePassBuyPassCtrl
local UIBattlePassBuyPassView = BaseClass("UIBattlePassBuyPassView",UIBaseView)
local base = UIBaseView
local this = UIBattlePassBuyPassView

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    LangUtil.BindText(self.rc:GetObject("Text1")).text = LangUtil.GetSysLang(1396)
    LangUtil.BindText(self.rc:GetObject("Text2")).text = LangUtil.GetSysLang(1397)
    LangUtil.BindText(self.rc:GetObject("RewardTitleText")).text = LangUtil.GetSysLang(1405)
    self.rewardText1 = LangUtil.BindText(self.rc:GetObject("RewardText1"))
    self.rewardText2 = LangUtil.BindText(self.rc:GetObject("RewardText2"))
    self.rewardText3 = LangUtil.BindText(self.rc:GetObject("RewardText3"))
    LangUtil.BindText(self.rc:GetObject("NoteText")).text = LangUtil.GetSysLang(1400)
    self.priceText = LangUtil.BindText(self.rc:GetObject("PriceText"))
    local confirmImage = self.rc:GetObject("ConfirmImage"):GetComponent("Image")
    LangUtil.GetSpriteLang(578, function(sprite) 
        confirmImage.sprite = sprite 
        confirmImage:SetNativeSize()
    end)
end

function this:OnCreate()
    base.OnCreate(self)
    local mask = self.rc:GetObject("Mask")
    UIUtil.AddBtnEvent(mask,function()self.ctrl.CloseSelf()end,"Back")

    local confirmButton = self.rc:GetObject("ConfirmButton")
    UIUtil.AddBtnEvent(confirmButton,function()self:ConfirmButtonClick()end)

    self.reward1 = self.rc:GetObject("Reward1")
    self.reward2 = self.rc:GetObject("Reward2")
    self.reward3 = self.rc:GetObject("Reward3")

    self.itemPrefabList = {}
    self.rawItemPrefab = self.rc:GetObject("RawItemPrefab")
    self.rawItemPrefab:SetActive(false)

    self.rewardScrollView = self.rc:GetObject("Scroll View")
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
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
    self.priceText.text = "$" .. self.model.price / 100

    self.reward1:SetActive(false)
    self.reward2:SetActive(false)
    self.reward3:SetActive(false)

    self.upLevel = 0
    local zReward = Z_Reward[self.model.rewardId]
    for index, value in ipairs(zReward) do
        if value.Type == RewardType.RewardTypeItem then
            self.reward1:SetActive(true)
            self.rewardText1.text = Z_Item[value.ObjId].Name .. "x<color=red>" .. value.Count .. "</color>"
        elseif value.Type == RewardType.RewardTypePassProgress or value.Type == RewardType.RewardTypePassProgressWithAddition then
            self.upLevel = value.Count // self.model.pass.config.ProgressPerStage
            self.reward2:SetActive(true)
            self.rewardText2.text = string.gsub(LangUtil.GetSysLang(1398), "XX", self.upLevel)
        elseif value.Type == RewardType.RewardTypePassMembership then
            
            local text = ""
            local upExp = 0
            if value.Count == PassMembership.PassMembershipSpecial then
                upExp = self.model.pass.config.SpecialAccessProgressBoost
            elseif value.Count == PassMembership.PassMembershipPremium then
                upExp = self.model.pass.config.PremiumAccessProgressBoost
            end
            if upExp > 0 then
                self.reward3:SetActive(true)
                text = tostring(upExp)
                self.rewardText3.text = string.gsub(LangUtil.GetSysLang(1399), "XX", text)
            else
                self.reward3:SetActive(false)
                self.rewardText3.text = ""
            end
        end
    end
    local zPassReward = Z_PassReward[self.model.pass.id]
    local rewardIndex = 0
    for level = 1, self.model.pass.level + self.upLevel do
        local passReward = zPassReward[level]
        if passReward == nil then
            passReward = zPassReward[table.count(zPassReward)]
        end
        local rewardId2 = passReward.SpecialRewards
        for index, value in ipairs(Z_Reward[rewardId2]) do
            rewardIndex = rewardIndex + 1
            self:RefreshRewardItem(rewardIndex, value.Type, value.ObjId, value.Count)
        end
    end
    for i = rewardIndex + 1, table.count(self.itemPrefabList) do
        self.itemPrefabList[i]:SetActive(false)
    end
    self.rewardScrollView:SetActive(rewardIndex > 0)
end

local channel = 2
function this:ConfirmButtonClick()
    local currentLevel = self.model.pass.level

    PublicRequest.SendRequest(
        PROTOCOL.CreatePaymentOrderReq,
        {
            goods_id = self.model.pass.config.SpecialStoreId
        },
    function(response, error)
            if error == 0 then
                local goodsInfo = Z_StarLightStoneShop[self.model.pass.config.SpecialStoreId]
                local channelGoodsId = Z_PaymentChannel[goodsInfo.ChannelInfo][channel].ChannelGoodsId

                ChannelManager:GetInstance():Purchase(channelGoodsId, response.order_id, true, function(rewardResults)
                    local rewards = {}
                    for index, value in ipairs(rewardResults) do
                        if value.type ~= RewardType.RewardTypePassMembership 
                            and value.type ~= RewardType.RewardTypePassProgress
                                and value.type ~= RewardType.RewardTypePassProgressWithAddition
                            then
                            table.insert(rewards, value)
                        end
                    end
                    self.ctrl.CloseSelf()
                    UIPublic.OpenRewardUI(rewards, nil, nil, function()
                        if self.upLevel ~= 0 then
                            UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattlePassLevelUp, {
                                level = currentLevel + self.upLevel,
                                passId = self.model.pass.id
                            })    
                        end
                    end)
                end)
                --ChannelManager:GetInstance():Purchase("com.feimo.sevensphere.goods.6", response.order_id)
            elseif error == 12013 then
                UIUtil.ToolTipFourth(LangUtil.GetSysLang(2097))
            elseif error == 12009 then
                UIUtil.ToolTipFourth(LangUtil.GetSysLang(2097))
            end
        end
    )
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
