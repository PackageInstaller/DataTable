--
-- <代码文件解释说明>
--

---@class UIUseOptionalItemView : UIBaseView
---@field model UIUseOptionalItemModel
---@field ctrl UIUseOptionalItemCtrl
local UIUseOptionalItemView = BaseClass("UIUseOptionalItemView",UIBaseView)
local base = UIBaseView
local this = UIUseOptionalItemView

local MaxNumber = 0
local currentIndex = 0
local currentSelectCount = 0
local currentPower = 0
local pfbName = "ItemPrefab"

function this:PlusButton()

    if currentSelectCount +1 <= MaxNumber then
        currentSelectCount = currentSelectCount + 1
    else
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(2020))
    end

    self.currentNumberText.text = currentSelectCount .. "/" .. self.model.item.Amount
end

function this:MinusButton()
    if currentSelectCount -1 >= 0 then
        currentSelectCount = currentSelectCount - 1
    else
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(1065))
    end

    self.currentNumberText.text = currentSelectCount .. "/" .. self.model.item.Amount
end

function this:MaxButton()
    currentSelectCount = MaxNumber
    self.currentNumberText.text = currentSelectCount .. "/" .. self.model.item.Amount
end

function this:MinButton()
    currentSelectCount =0
    self.currentNumberText.text = currentSelectCount .. "/" .. self.model.item.Amount
end

function this:OnLangCreate()
    LangUtil.GetSpriteLang(426, function(Sprite) self.confirmButton.transform:Find("GameObject"):GetComponent("Image").sprite = Sprite  end) -- 确认
    self.descriptionText = LangUtil.BindText(self.descriptionText)
    self.currentNumberText = LangUtil.BindText(self.currentNumberText)
    LangUtil.BindText(self.rc:GetObject("TitleText")).text = LangUtil.GetSysLang(229)
    self.countText = LangUtil.BindText(self.rc:GetObject("CountText"))
    self.countValue = LangUtil.BindText(self.rc:GetObject("CountValue"))
    self.nameText = LangUtil.BindText(self.rc:GetObject("NameText"))

end

function this:OnCreate()
    base.OnCreate(self)
    self.back_btn = self.rc:GetObject("Mask")
    self.currentNumberText = self.rc:GetObject("NumberText")
    self.descriptionText = self.rc:GetObject("DescriptionText")
    self.plusButton = self.rc:GetObject("PlusButton")
    self.minusButton = self.rc:GetObject("MinusButton")
    self.maxButton = self.rc:GetObject("MaxButton")
    self.minButton = self.rc:GetObject("MinButton")
    self.confirmButton = self.rc:GetObject("ConfirmButton")
    self.itemBg = self.rc:GetObject("ItemBg"):GetComponent("Image")
    self.avatar = self.rc:GetObject("Icon"):GetComponent("Image")

    self.itemData = {}
    local rc = self.rc:GetObject("ItemPrefab"):GetComponent("ReferenceCollector")
    self.itemData.icon = rc:GetObject("Icon"):GetComponent("Image")
    self.itemData.itemBg = rc:GetObject("ItemBg"):GetComponent("Image")
    self.itemData.frame = rc:GetObject("Frame"):GetComponent("Image")
    self.itemData.countText = rc:GetObject("Num"):GetComponent("Text")
    self.itemData.infoImage = self.rc:GetObject("InfoImage")
    UIUtil.AddBtnEventNoBug(self.rc:GetObject("ItemPrefab"), function()
        if self.showType == nil then
            return
        end

        UIUtil.OpenThingsDetailWindow({
            showType = self.showType,
            tempId = self.showTempId,
        })
    end)
    UIUtil.AddBtnEvent(self.plusButton,function()this.PlusButton(self)end)
    UIUtil.AddBtnEvent(self.minusButton,function()this.MinusButton(self)end)
    UIUtil.AddBtnEvent(self.maxButton,function()this.MaxButton(self)end)
    UIUtil.AddBtnEvent(self.minButton,function()this.MinButton(self)end)

    UIUtil.AddBtnEvent(self.back_btn,function()self.ctrl.CloseSelf()end,"Back")
    UIUtil.AddBtnEvent(self.confirmButton,function()
        if currentSelectCount <= 0 then
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(1065))
            return
        end

        if self.zOptionalRewardPack[currentIndex].RewardType == RewardType.RewardTypeFightSoul then
            if UIPublic.CheckOutOfLimit(RewardType.RewardTypeFightSoul, currentSelectCount) then
                UIUtil.ToolTipFourth(LangUtil.GetSysLang(1375))
                return
            end
        elseif self.zOptionalRewardPack[currentIndex].RewardType == RewardType.RewardTypeEquipment then
            if UIPublic.CheckOutOfLimit(RewardType.RewardTypeEquipment, currentSelectCount) then
                UIUtil.ToolTipFourth(LangUtil.GetSysLang(1376))
                return
            end
        end

        PublicRequest.SendRequest(
            PROTOCOL.UseItemReq,
            {
                items = {
                    {
                        uid = self.model.item.Id,
                        count = currentSelectCount,
                        args = {
                            currentIndex
                        }
                    }
                }
            },
            function(response)
                UIPublic.OpenRewardUI(response.reward_result)
            end
        )

        self.ctrl.CloseSelf()
    end)

    self.content = self.rc:GetObject("Content").transform

    self.zOptionalRewardPack = {}

    self.itemList = {}

    self.rawItemPrefab = self.rc:GetObject("RawItemPrefab")
    self.rawItemPrefab:SetActive(false)

end

function this:RefreshInfo()
    local data = self.zOptionalRewardPack[currentIndex]
    UIPublic.InitItemIconNew(self.itemData.icon, self.itemData.itemBg, data.RewardType, data.RewardId, data.RewardCount, nil, false, self.itemData.frame)
    local rewardData = UIPublic.GetRewardDataNew(data.RewardType, data.RewardId, data.RewardCount)
    self.descriptionText.text = rewardData.desc
    self.nameText.text = rewardData.name
    
    self.itemData.countText.text = ""
    if data.RewardType == RewardType.RewardTypeCharacter then
        if rewardData.hasCount > 0 then
            self.countValue.text = LangUtil.GetSysLang(1318)
        else
            self.countValue.text = LangUtil.GetSysLang(1319)
        end
        self.countText.text = ""
    else
        self.countValue.text = rewardData.hasCount
        self.countText.text = LangUtil.GetSysLang(1317)
    end

    if data.RewardType == RewardType.RewardTypeCharacter then
        self.showType = ShowType.Card
    elseif data.RewardType == RewardType.RewardTypeFightSoul then
        self.showType = ShowType.FightSoul

    elseif data.RewardType == RewardType.RewardTypeEquipment then
        self.showType = ShowType.Equip
    else
        self.showType = nil
    end

    self.itemData.infoImage:SetActive(self.showType ~= nil)
    self.showTempId = data.RewardId
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:RefreshItems()

    for index, data in ipairs(self.zOptionalRewardPack) do

        local gameObject = self.itemList[index]
        if gameObject == nil then
            gameObject = GameObject.Instantiate(self.rawItemPrefab)
            gameObject.transform:SetParent(self.content.transform, false)
            gameObject:SetActive(true)
            gameObject.transform:SetParent(self.content.transform)
            gameObject.transform.localPosition = Vector3.New(0,0,0)
            gameObject.transform.localScale = Vector3.New(1,1,1)
            self.itemList[index] = gameObject
        end
        gameObject:SetActive(true)
    
        ---@type {Id:number, RewardType:number, RewardId:number, RewardCount:number}
        local data = data

        local rc = gameObject:GetComponent("ReferenceCollector")
        local icon = rc:GetObject("Icon"):GetComponent("Image")
        local itemBg = rc:GetObject("ItemBg"):GetComponent("Image")
        local frame = rc:GetObject("Frame"):GetComponent("Image")
        UIPublic.InitItemIconNew(icon, itemBg, data.RewardType, data.RewardId, data.RewardCount, nil, false, frame)
        rc:GetObject("Num"):GetComponent("Text").text = data.RewardCount
        local select = rc:GetObject("Select")

        select:SetActive(index == currentIndex)
        UIUtil.AddBtnEventNoBug(gameObject, function()
            if index == currentIndex then
                return
            end
            currentIndex = index

            for i, go in ipairs(self.itemList) do
                if go ~= gameObject then
                    local rc2 = go:GetComponent("ReferenceCollector")
                    rc2:GetObject("Select"):SetActive(false)
                else
                    select:SetActive(index == currentIndex)
                end
            end
            self:RefreshInfo()
        end)
    end
    for i = table.count(self.zOptionalRewardPack) + 1, table.count(self.itemList) do
        self.itemList[i]:SetActive(false)
    end

    self.content:DOLocalMoveY(0, 0)

end


function this:OnRefresh()
    currentSelectCount = 0

    self.descriptionText.gameObject:SetActive(true)
    MaxNumber = self.model.item.Amount

    currentSelectCount = 1

    self.currentNumberText.text = currentSelectCount .. "/" .. self.model.item.Amount
    

    if self.model.item.config.UseParams ~= nil then
        self.zOptionalRewardPack = Z_OptionalRewardPack[self.model.item.config.UseParams[1]]
        currentIndex = 1
        self:RefreshItems()
    else

    end

    self:RefreshInfo()
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
