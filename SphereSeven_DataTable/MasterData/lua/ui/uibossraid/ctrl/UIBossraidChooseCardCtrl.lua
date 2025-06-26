
---@class UIBossraidChooseCardCtrl : UIBaseCtrl
---@field model UIBossraidChooseCardModel
local UIBossraidChooseCardCtrl = BaseClass("UIBossraidChooseCardCtrl",UIBaseCtrl);
local base = UIBaseCtrl
local this = UIBossraidChooseCardCtrl

local selectObjectList = {}

function this:CloseSelf()
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIBossraidChooseCard)
end

function this.GetUIName()
    return UIWindowNames.UIBossraidChooseCard
end

function this.GetItemPrefabName()
    return "CardItemNew_Bossraid"
end

function this:GetCardList()
    return self.model.showCards
end

--- 是否显示确认按钮
function this:ShowConfirmButton()
    return true
end

function this:OnConfirmButton()
    if self.model.confirmCallBack ~= nil then
        self.model.confirmCallBack(self.model.currentCard)
    end
    self:CloseSelf()
end

--- 每次生成(刷新)card时是否初始化(进行特殊处理)
function this:IsCardInit()
    return true
end

---@param card Card
function this:CardInit(card, gameObject)
    local transform = gameObject.transform
    local select = transform:Find("Select").gameObject
    transform:Find("MaskImage/MaskText"):GetComponent("Text").text = LangUtil.GetSysLang(1495)

    selectObjectList[card.Id] = select
    -- LangUtil.GetSpriteLang(140,function(sprite) select:GetComponent("Image").sprite = sprite end)

    local isSelected = self.model.currentCard ~= nil and card.Id == self.model.currentCard.Id
    select:SetActive(isSelected)
    transform.parent:GetComponent("Button").enabled = (not isSelected)

    if table.contains(self.model.usedRole, card.Id) then
        transform:Find("MaskImage").gameObject:SetActive(true)
        transform.parent:GetComponent("Button").enabled = false
    else
        transform:Find("MaskImage").gameObject:SetActive(false)
    end

    gameObject = gameObject.transform.parent.gameObject
    if IsNull(gameObject:GetComponent(typeof(CS.GDragEventDispatcher))) then
        gameObject:AddComponent(typeof(CS.GDragEventDispatcher))
    end
end

function this:OnClickCardButton( cardData, gameObject)
    if table.contains(self.model.usedRole, cardData.Id) then
    end
    -- if self.model.currentCard ~= nil and self.model.currentCard.Id ~= nil then
    if self.model.currentCard ~= nil then
        if selectObjectList[self.model.currentCard.Id] ~= nil then
            selectObjectList[self.model.currentCard.Id]:SetActive(false)
        end
    end
    if self.model.currentCard == cardData then
        self.model.currentCard = nil
    else
        self.model.currentCard = cardData
        selectObjectList[self.model.currentCard.Id]:SetActive(true)
    end
end

--- 点击card时 是否重置筛选条件
function this:ClickCardToResetScreenTypes()
    return true
end

--- 点击card时 是否重置筛选条件
function this:OnEnableResetScreenTypes()
    return true
end

function this:isAddHint()
    return false
end

return this
