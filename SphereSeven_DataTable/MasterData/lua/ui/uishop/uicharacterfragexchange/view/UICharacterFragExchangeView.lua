--
-- <代码文件解释说明>
--

---@class UICharacterFragExchangeView : UIBaseView
---@field model UICharacterFragExchangeModel
---@field ctrl UICharacterFragExchangeCtrl
local UICharacterFragExchangeView = BaseClass("UICharacterFragExchangeView",UIBaseView)
local base = UIBaseView
local this = UICharacterFragExchangeView

local CHARACTERFRAG_EXCHANGE_ID = Z_Misc["CHARACTERFRAG_EXCHANGE_ID"].Value -- 角色碎片转换的道具id
local CHARACTERFRAG_EXCHANGE_COUNT = Z_Misc["CHARACTERFRAG_EXCHANGE_COUNT"].Value -- 角色碎片转换的道具数量


function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    LangUtil.BindText(self.rc:GetObject("NoteText")).text = LangUtil.GetSysLang(1448)
    LangUtil.BindText(self.rc:GetObject("TitleText")).text = LangUtil.GetSysLang(1445) -- 魂芽转换
    LangUtil.BindText(self.confirmButton.transform:Find("Text")).text = LangUtil.GetSysLang(1446) -- 转换
end

function this:OnCreate()
    base.OnCreate(self)
    UIUtil.AddBtnEvent(self.rc:GetObject("Mask"), function()
        self.ctrl.CloseSelf()
    end)
    
    self.confirmButton = self.rc:GetObject("ConfirmButton")
    UIUtil.AddBtnEvent(self.confirmButton, function()
        ---@param response protocol.CharacterPackFragExchangeResp
        PublicRequest.SendRequest(
            PROTOCOL.CharacterPackFragExchangeReq,
            {},
            function(response, errorCode)
                if errorCode == 0 or errorCode == nil then
                    local rewardResults = {}
                    if response.exchange_detail ~= nil then
                        for _, exchange_detail in ipairs(response.exchange_detail) do
                            if exchange_detail.reward_result ~= nil then
                                for _, reward_result in ipairs(exchange_detail.reward_result) do
                                    table.insert(rewardResults, reward_result)
                                end
                            end
                        end
                    end
                    if table.count(rewardResults) > 0 then
                        UIPublic.OpenRewardUI(rewardResults)
                    end
                    self.ctrl.CloseSelf()

                end
            end
        )
    end)
    
    self.scroll = VerticalScroll.New()
    self.scrollView = self.rc:GetObject("Scroll View")
    self.scroll:Clear()
    self.scroll:ScrollInit({}, self.scrollView, "ItemPrefab", function (arg)
        ---@type Item
        local item = arg.data
        local object = arg.go
        local index = arg.index

        UIPublic.InitRewardItem({
            itemPrefab = object,
            type = RewardType.RewardTypeItem,
            id = item.TemplateId,
            count = item.Amount,
            isShowCount = true,
            isShowThingsDetail = true,
        })
    end)
    
    ---@type UnityEngine.Transform
    local itemLayout = self.rc:GetObject("ItemLayout").transform
    self.itemList = {}
    for i = 0, itemLayout.childCount - 1 do
        local child = itemLayout:GetChild(i)
        local index = i + 1
        self.itemList[index] = {
            itemPrefab = child.gameObject,
        }
    end

    ---@type UnityEngine.Transform
    local rewardTextLayout = self.rc:GetObject("RewardTextLayout").transform
    self.rewardTextList = {}
    for rarity = 1, 3 do
        local child = rewardTextLayout:GetChild(rarity - 1)
        self.rewardTextList[rarity] = {
            root = child.gameObject,
            text1 = LangUtil.BindText(child:Find("Text1")),
            text2 = LangUtil.BindText(child:Find("Text2")),
        }
    end
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    self.scroll:RefreshData(self.model.items)
    self.scroll:MoveTop()
    UIPublic.InitButton(self.confirmButton, table.count(self.model.items) > 0)
    
    local rewardItems = {}
    local rewardIdMap = {}
    
    for rarity = 1, 3 do
        if self.model.rareItemCounts[rarity] == nil or self.model.rareItemCounts[rarity] == 0 then
            -- 不存在当前稀有度的角色碎片
            self.rewardTextList[rarity].root:SetActive(false)
        else
            self.rewardTextList[rarity].root:SetActive(true)
            local itemCount = tonumber(CHARACTERFRAG_EXCHANGE_COUNT[rarity]) * self.model.rareItemCounts[rarity]
            local itemId = tonumber(CHARACTERFRAG_EXCHANGE_ID[rarity])
            if rewardIdMap[itemId] == nil then
                table.insert(rewardItems, {
                    id = itemId,
                    count = itemCount,
                })
                rewardIdMap[itemId] = table.count(rewardItems)
            else
                rewardItems[rewardIdMap[itemId]].count = rewardItems[rewardIdMap[itemId]].count + itemCount
            end

            self.rewardTextList[rarity].text1.text = RarityName[rarity] .. LangUtil.GetSysLang(1447)
            self.rewardTextList[rarity].text2.text = Z_Item[itemId].Name .. "x" .. itemCount
        end
    end
    
    for i, v in ipairs(self.itemList) do
        local itemPrefab = v.itemPrefab
        if rewardItems[i] == nil then
            itemPrefab:SetActive(false)
        else
            itemPrefab:SetActive(true)
            UIPublic.InitRewardItem({
                itemPrefab = itemPrefab,
                type = RewardType.RewardTypeItem,
                id = rewardItems[i].id,
                count = rewardItems[i].count,
                isShowCount = true,
                isShowThingsDetail = true,
            })
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
    self.scroll:Dispose()
end

return this
