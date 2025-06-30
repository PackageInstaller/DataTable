--
-- <代码文件解释说明>
--

---@class UISummonFormulaView : UIBaseView
---@field model UISummonFormulaModel
---@field ctrl UISummonFormulaCtrl
local UISummonFormulaView = BaseClass("UISummonFormulaView",UIBaseView)
local base = UIBaseView
local this = UISummonFormulaView

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
end

function this:OnCreate()
    base.OnCreate(self)

    UIUtil.AddBtnEvent(self.rc:GetObject("eventBg"), function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UISummonFormula)
    end)

    LangUtil.BindText(self.rc:GetObject("TitleText")).text = LangUtil.GetSysLang(1363)
    self.text1 = LangUtil.BindText(self.rc:GetObject("Text1"))
    LangUtil.BindText(self.rc:GetObject("Text2")).text = LangUtil.GetSysLang(1365)


    self.cardProbability = self.rc:GetObject("CardProbability").transform
    self.fightSoulProbability = self.rc:GetObject("FightSoulProbability").transform
    LangUtil.BindText(self.rc:GetObject("CardProbabilityText")).text = LangUtil.GetSysLang(1366)
    LangUtil.BindText(self.rc:GetObject("FightSoulProbabilityText")).text = LangUtil.GetSysLang(1367)

    self.cards = self.rc:GetObject("Cards").transform
    self.fightSouls = self.rc:GetObject("FightSouls").transform
    LangUtil.BindText(self.rc:GetObject("CardsTitle")).text = LangUtil.GetSysLang(1368)
    LangUtil.BindText(self.rc:GetObject("FightSoulsTitle")).text = LangUtil.GetSysLang(1369)
    self.itemTemplate = self.rc:GetObject("ItemTemplate").gameObject
    self.itemTemplate:SetActive(false)
    self.cardItemList = {
        [1] = {},
        [2] = {},
        [3] = {},
    }
    self.fightSoulItemList = {
        [1] = {},
        [2] = {},
        [3] = {},
    }
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    --排序: 同稀有度 按 概率 从大到小, 同概率 按照id排序 从小到大
    local zRecruit = Z_Recruit[self.model.poolId]
    local zRecruitReward = Z_RecruitReward[zRecruit.PoolConfig]

    -- 所有card, 以及每个card的概率
    -- id = id,
    -- probability = probability,
    -- name = zCharacter.Name,
    local cardMap = {}
    local cards = {
        [1] = {},
        [2] = {},
        [3] = {},
    }
    local fightMap = {}
    local fightSouls = {
        [1] = {},
        [2] = {},
        [3] = {},
    }

    -- 各稀有度的概率
    local cardProbability = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
    }
    local fightSoulProbability = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
    }

    -- 实际概率为 对应数值/allProbabilityCount
    local allProbabilityCount = 0 
    for index, value in ipairs(zRecruit.Distribution) do -- 记录分组概率 key:组数, value:这一组的总数
        allProbabilityCount = allProbabilityCount + value
    end

    local distributionCount = {} -- 每一组里面有多少个数
    for index, value in ipairs(zRecruitReward) do
        if distributionCount[value.Distribution] == nil then
            distributionCount[value.Distribution] = 1
        else
            distributionCount[value.Distribution] = distributionCount[value.Distribution] + 1
        end
    end
    
    -- 每一个值的概率 为 分组概率数 / 组里面的个数 / allProbabilityCount
    for index, value in ipairs(zRecruitReward) do
        if value.RewardType == RewardType.RewardTypeCharacter then
            local id = value.RewardId
            local zCharacter = Z_Character[id]
            local rarity = zCharacter.Rarity
            local probability = zRecruit.Distribution[value.Distribution] / distributionCount[value.Distribution] / allProbabilityCount
            if cardMap[id] == nil then
                table.insert(cards[rarity], {
                    id = id,
                    probability = probability,
                    name = Z_Card[id].Name,
                })
                cardMap[id] = probability
            else
                table.first(cards[rarity], function(v) return v.id == id end).probability = table.first(cards[rarity], function(v) return v.id == id end).probability + probability
                cardMap[id] = cardMap[id] + probability
            end
            cardProbability[rarity] = cardProbability[rarity] + probability
        else
            local id = value.RewardId
            local zFightSoul = Z_FightSoul[id]
            local rarity = zFightSoul.Rare
            local probability = zRecruit.Distribution[value.Distribution] / distributionCount[value.Distribution] / allProbabilityCount
            if fightMap[id] == nil then
                table.insert(fightSouls[rarity], {
                    id = id,
                    probability = probability,
                    name = zFightSoul.Name,
                })
                fightMap[id] = probability
            else
                table.first(fightSouls[rarity], function(v) return v.id == id end).probability = table.first(fightSouls[rarity], function(v) return v.id == id end).probability + probability
                fightMap[id] = fightMap[id] + probability
            end
            fightSoulProbability[rarity] = fightSoulProbability[rarity] + probability
        end
    end
    for rarity, value in ipairs(cards) do
        table.sort(value, function(a, b)
            if a.probability == b.probability then
                return a.id < b.id
            else
                return a.probability > b.probability
            end
        end)
    end
    for rarity, value in ipairs(fightSouls) do
        table.sort(value, function(a, b)
            if a.probability == b.probability then
                return a.id < b.id
            else
                return a.probability > b.probability
            end
        end)
    end

    local allCardProbability = 0
    local allFightSoulProbability = 0
    for index, value in ipairs(cards) do
        for index2, value2 in ipairs(value) do
            allCardProbability = allCardProbability + value2.probability
        end
    end
    for index, value in ipairs(fightSouls) do
        for index2, value2 in ipairs(value) do
            allFightSoulProbability = allFightSoulProbability + value2.probability
        end
    end
    if allCardProbability == 0 or allFightSoulProbability == 0 then
        self.text1.gameObject:SetActive(false)
    else
        self.text1.gameObject:SetActive(true)
        local text = string.gsub(LangUtil.GetSysLang(1364), "XX", string.format("%.2f", allCardProbability * 100))
        self.text1.text = string.gsub(text, "YY", string.format("%.2f", allFightSoulProbability * 100))
    end

    if allCardProbability == 0 then
        self.cardProbability.gameObject:SetActive(false)
    else
        self.cardProbability.gameObject:SetActive(true)
        local layout = self.cardProbability:Find("Layout")
        for i = 0, layout.childCount - 1 do
            local rarity = 3 - i
            local child = layout:GetChild(i)
            if cardProbability[rarity] > 0 then
                child.gameObject:SetActive(true)
                LangUtil.BindText(child:Find("Text")).text = string.format("%.2f", cardProbability[rarity] * 100) .. "%"
            else
                child.gameObject:SetActive(false)
            end
        end
    end

    if allFightSoulProbability == 0 then
        self.fightSoulProbability.gameObject:SetActive(false)
    else
        self.fightSoulProbability.gameObject:SetActive(true)
        local layout = self.fightSoulProbability:Find("Layout")
        for i = 0, layout.childCount - 1 do
            local rarity = 3 - i
            local child = layout:GetChild(i)
            if fightSoulProbability[rarity] > 0 then
                child.gameObject:SetActive(true)
                LangUtil.BindText(child:Find("Text")).text = string.format("%.2f", fightSoulProbability[rarity] * 100) .. "%"
            else
                child.gameObject:SetActive(false)
            end
        end
    end

    if allCardProbability == 0 then
        self.cards.gameObject:SetActive(false)
    else
        self.cards.gameObject:SetActive(true)
        for i = 1, 3 do -- 稀有度
            local child = self.cards:Find("Layout" .. i)
            child.gameObject:SetActive(cardProbability[i] > 0)
            if cardProbability[i] > 0 then
                -- 存在对应稀有度的角色
                LangUtil.BindText(child:Find("RarityCount")).text = table.count(cards[i]) .. LangUtil.GetSysLang(1370)
                for index, value in ipairs(cards[i]) do
                    local item = self.cardItemList[i][index]
                    if item == nil then
                        item = GameObject.Instantiate(self.itemTemplate, child)
                        item:SetActive(true)
                        self.cardItemList[i][index] = item
                    end
                    item:SetActive(true)
                    LangUtil.BindText(item.transform:Find("NameText")).text = value.name
                    LangUtil.BindText(item.transform:Find("PropText")).text = string.format("%.2f", value.probability * 100) .. "%"
                end
                for j = table.count(cards[i]) + 1, #self.cardItemList[i] do
                    self.cardItemList[i][j]:SetActive(false)
                end
            end
        end
    end

    if allFightSoulProbability == 0 then
        self.fightSouls.gameObject:SetActive(false)
    else
        self.fightSouls.gameObject:SetActive(true)
        for i = 1, 3 do -- 稀有度
            local child = self.fightSouls:Find("Layout" .. i)
            child.gameObject:SetActive(fightSoulProbability[i] > 0)
            if fightSoulProbability[i] > 0 then
                -- 存在对应稀有度的角色
                LangUtil.BindText(child:Find("RarityCount")).text = table.count(fightSouls[i]) .. LangUtil.GetSysLang(1370)
                for index, value in ipairs(fightSouls[i]) do
                    local item = self.fightSoulItemList[i][index]
                    if item == nil then
                        item = GameObject.Instantiate(self.itemTemplate, child)
                        item:SetActive(true)
                        self.fightSoulItemList[i][index] = item
                    end
                    item:SetActive(true)
                    LangUtil.BindText(item.transform:Find("NameText")).text = value.name
                    LangUtil.BindText(item.transform:Find("PropText")).text = string.format("%.2f", value.probability * 100) .. "%"
                end
                for j = table.count(fightSouls[i]) + 1, #self.fightSoulItemList[i] do
                    self.fightSoulItemList[i][j]:SetActive(false)
                end
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
