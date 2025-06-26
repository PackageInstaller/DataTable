local LevelUpSubView = {}
local this = LevelUpSubView

local ITEM_ID = {
    20004, 20005, 20006
}
---@type {config:table, id:number, count:number, chooseCount:number, active:UnityEngine.GameObject, reduce:UnityEngine.GameObject, countText:UnityEngine.UI.Text, uiItem:UIItemClass} []
local items
local propertyList
local showPropertySort = {
    [1] = NumericType.Hp,
    [2] = NumericType.Atk,
    [3] = NumericType.Def,
    [4] = NumericType.MagicDef,
}
local GOLD_ID = tonumber(Z_Misc["GOLD_ID"].Value[1])
local expBar
local expProgressText
local curLevelText
local nextImg
local nextLevelText
local nextNumerical
local arrows
local numerical
local costTextImage
local chgItemCtrl
local levelUpButton
local skip
local skipText
local isSkip
local glodImage
local costCountText
local addExpText
local maxButton

local isSkipAnimation = true

local FIGHT_SOUL_EXP_GOLD_COST_RATE = tonumber(Z_Misc["FIGHT_SOUL_EXP_GOLD_COST_RATE"].Value[1])

---@param self UIFightSoulInfoView
local function OnLevelUp(self)
        -- UIUtil.ToolTipFourth(LangUtil.GetSysLang(568)) -- 没有选择物品
    
    local materials = {}
    for index, value in ipairs(items) do
        if value.chooseCount > 0 then
            table.insert(materials, {
                uid = value.id,
                count = value.chooseCount
            })
        end
    end
    if table.count(materials) > 0 then
        PublicRequest.SendRequest(
            PROTOCOL.FightSoulExpStrengthenReq,
            {
                uid = self.model.fightSoul.Id,
                materials = materials
            },
            function()
                for index, value in ipairs(items) do
                    value.chooseCount = 0
                end
                this.RefreshExp(self)
            end
        )
    else
        -- UIUtil.ToolTipFourth(LangUtil.GetSysLang(568)) -- 没有选择物品
    end

    -- FightSoulExpStrengthenReq
end

---@param self UIFightSoulInfoView
local function RefreshProperty(self, nextLevel)
    if nextLevel == nil then
        nextLevel = self.model.fightSoul.level
    end
    -- 如果等级不变, 右边就是当前数据, 变化后, 就是最新数据
    -- 中间绿字为左右两侧数据之差, 如果为0就不显示
    for k, v in pairs(propertyList) do
        local finalValue = UIPublic.GetFightSoulProperty(self.model.fightSoul.TemplateId, nextLevel, v.property)
        v.finalValue.text = finalValue
        local addValue = finalValue - tonumber(v.value.text)
        if addValue == 0 then
            v.addValue.text = ""
        elseif addValue > 0 then
            v.addValue.text = "+" .. addValue
        else
            v.addValue.text = addValue
        end
        v.arrow:SetActive(addValue ~= 0)
    end
end

---@param self UIFightSoulInfoView
local function RefreshLevelText(self, nextLevel)
    if nextLevel == nil then
        nextLevel = self.model.fightSoul.level
    end

    nextLevelText.text = nextLevel
end

--- 修改道具(数量或种类)时, 刷新经验条跟金币 -> 刷新等级跟属性
---@param self UIFightSoulInfoView
function this.RefreshExp(self)
    local addExp = 0
    for key, value in pairs(items) do
        value.countText.text = value.chooseCount
        value.active:SetActive(value.chooseCount > 0)
        value.reduce:SetActive(value.chooseCount > 0)
        addExp = addExp + tonumber(value.config.UseParams[1]) * value.chooseCount
    end

    local nextLevel = nil

    if addExp > 0 then
        nextLevel = self.model.fightSoul.level
        local lastExp = addExp + self.model.fightSoul.exp
        for i = self.model.fightSoul.level, self.model.fightSoul.maxLevel - 1 do
            local needExp = Z_FightSoulLevelUpExp[i][RarityName[self.model.fightSoul.config.Rare]]
            if lastExp >= needExp then
                lastExp = lastExp - needExp
                nextLevel = i + 1
            else
                break
            end
        end
        expBar.value = lastExp / Z_FightSoulLevelUpExp[nextLevel][RarityName[self.model.fightSoul.config.Rare]]
        expProgressText.text = lastExp .. "/" .. Z_FightSoulLevelUpExp[nextLevel][RarityName[self.model.fightSoul.config.Rare]]
    else
        expBar.value = self.model.fightSoul.exp / Z_FightSoulLevelUpExp[self.model.fightSoul.level][RarityName[self.model.fightSoul.config.Rare]]
        expProgressText.text = self.model.fightSoul.exp .. "/" .. Z_FightSoulLevelUpExp[self.model.fightSoul.level][RarityName[self.model.fightSoul.config.Rare]]
    end
    addExpText.text = addExp
    addExpText.gameObject:SetActive(addExp > 0)
    costCountText.text = addExp // FIGHT_SOUL_EXP_GOLD_COST_RATE

    local gold = Game.Scene.Player:GetComponent("ItemComponent"):GetItem(GOLD_ID)
    if gold == nil or gold.Amount < addExp // FIGHT_SOUL_EXP_GOLD_COST_RATE then
        costCountText.text = "<color=#FF0000>" .. costCountText.text .. "</color>"
    end
    RefreshLevelText(self, nextLevel)
    RefreshProperty(self, nextLevel)
end

---@param self UIFightSoulInfoView
local function ChangeItem(self, index, offset)
    if items[index].chooseCount + offset < 0 then
        return
    end
    if items[index].chooseCount + offset > items[index].count then
        return
    end
    items[index].chooseCount = items[index].chooseCount + offset
    this.RefreshExp(self)
end

---@param self UIFightSoulInfoView
local function OnMax(self)
    local targetExp = 0
    for i = self.model.fightSoul.level, self.model.fightSoul.maxLevel - 1 do
        targetExp = targetExp + Z_FightSoulLevelUpExp[i][RarityName[self.model.fightSoul.config.Rare]]
    end

    local bookTable = {}
    bookTable.bigBookExp = items[3].config.UseParams[1]
    bookTable.mediumBookExp = items[2].config.UseParams[1]
    bookTable.smallBookExp = items[1].config.UseParams[1]
    bookTable.bigBookCount = items[3].count
    bookTable.mediumBookCount = items[2].count
    bookTable.smallBookCount = items[1].count

    local usedCounts = UIPublic.UseMaxExpBooks(
        self.model.fightSoul.exp,
        targetExp,
        bookTable
    )

    items[1].chooseCount = usedCounts.small
    items[2].chooseCount = usedCounts.medium
    items[3].chooseCount = usedCounts.big

    this.RefreshExp(self)
end

-- 初始化
---@param self UIFightSoulInfoView
function this.Init(self, gameObject)
    ---@type ReferenceCollector
    local rc = gameObject:GetComponent("ReferenceCollector")

    items = {}
    for index, value in ipairs(ITEM_ID) do
        items[index] = {}
        items[index].config = Z_Item[value]
        items[index].cid = value
        items[index].chooseCount = 0
    end

    expBar = rc:GetObject("ExpBar"):GetComponent("Slider")
    expProgressText = LangUtil.BindText(rc:GetObject("ExpProgressText"))
    curLevelText = LangUtil.BindText(rc:GetObject("CurLevelText"))
    nextImg = rc:GetObject("NextImg")
    nextLevelText = LangUtil.BindText(rc:GetObject("NextLevelText"))
    nextNumerical = rc:GetObject("NextNumerical").transform
    arrows = rc:GetObject("Arrows")
    numerical = rc:GetObject("Numerical").transform
    costTextImage = rc:GetObject("CostTextImage")
    chgItemCtrl = rc:GetObject("ChgItemCtrl").transform
    levelUpButton = rc:GetObject("LevelUpButton")
    skip = rc:GetObject("Skip")
    skipText = LangUtil.BindText(rc:GetObject("SkipText"))
    isSkip = rc:GetObject("IsSkip")
    glodImage = rc:GetObject("GlodImage")
    UIUtil.SetSprite(glodImage:GetComponent("Image"),AtlasConfig.Item,GetItemIcon(Z_Item[GOLD_ID]),true)

    costCountText = LangUtil.BindText(rc:GetObject("CostCountText"), FontType.All_Number)
    addExpText = LangUtil.BindText(rc:GetObject("AddExpText"), FontType.All_Number)
    LangUtil.BindText(rc:GetObject("CostText")).text = LangUtil.GetSysLang(73) -- 消耗

    maxButton = rc:GetObject("MaxButton")
    UIUtil.AddBtnEvent(levelUpButton, function()
        OnLevelUp(self)
    end)

    UIUtil.AddBtnEvent(maxButton, function()
        OnMax(self)
    end)

    propertyList = {}
    for index, property in ipairs(showPropertySort) do
        propertyList[index] = {}
        propertyList[index].property = property
        propertyList[index].value = LangUtil.BindText(numerical:GetChild(index - 1):Find("Value"))
        propertyList[index].arrow = arrows.transform:GetChild(index - 1).gameObject
        propertyList[index].finalValue = LangUtil.BindText(nextNumerical:GetChild(index - 1):Find("FinalText"))
        propertyList[index].addValue = LangUtil.BindText(nextNumerical:GetChild(index - 1):Find("AddText"))

        numerical:GetChild(index - 1):Find("Text"):GetComponent("Text").text = LangUtil.GetSysLang(Z_Property[property].SysLangKey)
    end

    for i = 0, 2 do
        local index = i + 1
        local child = chgItemCtrl:GetChild(i)
        local itemPrefab = child:Find("ItemPrefab")
        -- UIUtil.AddBtnEvent(itemPrefab, function()
        --     ChangeItem(self, index, 1)
        -- end)

        items[index].uiItem = UIItemClass(nil, itemPrefab.gameObject)
        items[index].uiItem.hideName()
        items[index].uiItem.SetClickCallback(function()
            ChangeItem(self, index, 1)
        end)
        local reduceButton = child:Find("ReduceButton")
        UIUtil.AddBtnEvent(reduceButton, function()
            ChangeItem(self, index, -1)
        end)
        items[index].reduce = reduceButton.gameObject

        items[index].active = child:Find("Active").gameObject
        items[index].countText = LangUtil.BindText(child:Find("CurrentAmount"), FontType.All_Number)
        LangUtil.BindText(child:Find("NameTextRoot/Text")).text = items[index].config.Name
    end

end

---@param self UIFightSoulInfoView
function this.OnLangCreate(self, gameObject)
end

---@param self UIFightSoulInfoView
function this.OnEnable(self)
    for index, value in ipairs(items) do
        value.chooseCount = 0
    end
end

---@param self UIFightSoulInfoView
function this.OnRefresh(self)
    curLevelText.text = self.model.fightSoul.level
    for key, cid in pairs(ITEM_ID) do
        items[key].count = UIPublic.GetItemAmount(cid)
        local item = Game.Scene.Player:GetComponent("ItemComponent"):GetItem(cid)
        if item ~= nil then
            items[key].id = item.Id
        end
        items[key].uiItem.SetData(items[key].cid, items[key].count)
    end

    for key, value in pairs(propertyList) do
        value.value.text = UIPublic.GetFightSoulProperty(self.model.fightSoul.TemplateId, self.model.fightSoul.level, value.property)
    end
    this.RefreshExp(self)
end

---@param self UIFightSoulInfoView
function this.OnDisable(self)
end

---@param self UIFightSoulInfoView
function this.OnDestroy(self)
end

---@param self UIFightSoulInfoView
function this.ClearChoose(self)
    for index, value in ipairs(items) do
        value.chooseCount = 0
    end
end

---@param self UIFightSoulInfoView
function this.OnFightSoulUpdate(self)
end

return this