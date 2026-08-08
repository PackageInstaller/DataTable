---@class GameShopPanel_CardMenu : GameShopPanel_CardMenu_Generate
---##################### 【GameShopPanel_CardMenu Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【GameShopPanel_CardMenu Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local GameShopPanel_CardMenu = require "GameShopPanel_CardMenu_Generate"

---@class GameShopPanel_CardMenu_ItemObj:UIObj
local ItemObj = class("GameShopPanel_CardMenu_ItemObj", UIObj)

function ItemObj:Initialize()
    UIObj.Initialize(self)
    ---@type GameShopPanel_CardMenu_Generate_monthCardMenu_rewardPrefab
    local peer = self
    peer.scaleButton.onClick:AddListener(BindCallback_NoParams(self, self.OnClick))
end

---@param data integer[]
function ItemObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= nil)
    if data == nil then
        return
    end
    local id = data[2]
    local num = data[3]
    local cfg = Config.GetItemInfo(id)
    if cfg == nil then
       return 
    end

    ---@type GameShopPanel_CardMenu_Generate_monthCardMenu_rewardPrefab
    local peer = self
    peer.numText.text.text = tostring(num)

    local iconPath = string.format(Config.SpritePath.ItemIconPath, cfg.icon)
    self.ui:LoadSpriteAsync(iconPath, peer.iconImg.image)
end

function ItemObj:OnClick()
    local id = self.data[2]
    local type = self.data[1]
    Me:ShowItemTips({id = id, type = type})
end

local monthGiftId = 3001        ---月卡gift ID
local weekCardGoodId = 3003002  ---周卡商品id
local monthCardId = 1001        ---月卡id
local weekCardId = 1002         ---周卡id

function GameShopPanel_CardMenu:Init()
    local addItem = function (itemTab, itemId, count)
        local itemInfo = nil
        for i = 1, #itemTab do
            if itemTab[i].itemId == itemId then
                itemInfo = itemTab[i]
                break 
            end
        end
        if itemInfo == nil then
            itemInfo = {
                itemId = itemId,
                count = 0 
            }
            table.insert(itemTab, itemInfo)
        end
        itemInfo.count = itemInfo.count + count
    end
    ---初始化月卡
    local tab = {}
    local monthCardCfg = Config.GetMonthCardInfo(monthCardId)
    for i = 1, #monthCardCfg.purchaseAward do
        local data = monthCardCfg.purchaseAward[i]
        local obj = EngineUtil.Instantiate(self.rewardPrefab.gameObject, self.monthCardMenu.rewardGroup1.rectTransform)
        local itemObj = ItemObj:Create(obj, self, self.rewardPrefab)
        itemObj:SetData(data)

        local itemId = data[2]
        local count = data[3]
        addItem(tab, itemId, count)
    end

    for i = 1, #monthCardCfg.exAward do
        local data = monthCardCfg.exAward[i]
        local obj = EngineUtil.Instantiate(self.rewardPrefab.gameObject, self.monthCardMenu.rewardGroup2.rectTransform)
        local itemObj = ItemObj:Create(obj, self, self.rewardPrefab)
        itemObj:SetData(data)

        local itemId = data[2]
        local count = data[3] * monthCardCfg.lastTime
        addItem(tab, itemId, count)
    end
    self.monthCardMenu.privilegeText.text.text = monthCardCfg.exPrivilegeDesc

    local rewardStr = ""
    for i = 1, #tab do
        local itemCfg = Config.GetItemInfo(tab[i].itemId)
        rewardStr = rewardStr .. itemCfg.itemName .. "x" .. tab[i].count
        if i < #tab then
            rewardStr = rewardStr .. "," 
        end
    end
    rewardStr = string.format(LocalStrEnum.GameShop_CardRewardStr, rewardStr)
    self.monthCardMenu.cardActiveRewardText.text.text = rewardStr

    self.monthCardMenu.buyBtn.scaleButton.onClick:AddListener(BindCallback_NoParams(self, self.OnMonthBuyBtnClick))

    ---初始化周卡
    local tab = {}
    local weekCfg = Config.GetMonthCardInfo(weekCardId)
    for i = 1, #weekCfg.purchaseAward do
        local data = weekCfg.purchaseAward[i]
        local obj = EngineUtil.Instantiate(self.rewardPrefab.gameObject, self.weekCardMenu.rewardGroup1.rectTransform)
        local itemObj = ItemObj:Create(obj, self, self.rewardPrefab)
        itemObj:SetData(data)

        local itemId = data[2]
        local count = data[3]
        addItem(tab, itemId, count)
    end

    for i = 1, #weekCfg.exAward do
        local data = weekCfg.exAward[i]
        local obj = EngineUtil.Instantiate(self.rewardPrefab.gameObject, self.weekCardMenu.rewardGroup2.rectTransform)
        local itemObj = ItemObj:Create(obj, self, self.rewardPrefab)
        itemObj:SetData(data)

        local itemId = data[2]
        local count = data[3] * weekCfg.lastTime
        addItem(tab, itemId, count)
    end
    self.weekCardMenu.privilegeText.text.text = weekCfg.exPrivilegeDesc

    local rewardStr = ""
    for i = 1, #tab do
        local itemCfg = Config.GetItemInfo(tab[i].itemId)
        rewardStr = rewardStr .. itemCfg.itemName .. "x" .. tab[i].count
        if i < #tab then
            rewardStr = rewardStr .. "," 
        end
    end
    rewardStr = string.format(LocalStrEnum.GameShop_CardRewardStr, rewardStr)
    self.weekCardMenu.cardActiveRewardText.text.text = rewardStr

    local picId, picNum, picRate = Me:GetShopItemPic(weekCardGoodId)
    local picItemCfg = Config.GetItemInfo(picId)

    self:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, picItemCfg.icon), self.weekCardPicIcon.image)
    self.weekCardPicText.text.text = tostring(picNum) .. "签订"

    self.weekCardMenu.buyBtn.scaleButton.onClick:AddListener(BindCallback_NoParams(self, self.OnWeekBuyBtnClick))

    self.monthToggle.toggle.onValueChanged:AddListener(BindCallback(self, self.OnTagToggleValueChange, monthCardId))

    self.weekToggle.toggle.onValueChanged:AddListener(BindCallback(self, self.OnTagToggleValueChange, weekCardId))
end

---@param ui UIBase
function GameShopPanel_CardMenu:SetParentUI(ui)
    self.parentUI = ui
    self.LoadSpriteAsync = function(self, path, callBack)
        self.parentUI:LoadSpriteAsync(path, callBack)
    end
    self.LoadGameObjectAsync = function(self, path, callBack)
        self.parentUI:LoadGameObjectAsync(path, callBack)
    end
end

---@param cardId int? 需要跳转的id
function GameShopPanel_CardMenu:Show(cardId)
    if not self.init then
        self:Init()
        self.init = true
    end
    local lastDay = Me:GetCardLastDayTime(monthCardId)
    if lastDay <= 0 then
        self.monthCardMenu.stateText.text.text = LocalStrEnum.GameShop_CardNoActivity
    else
        self.monthCardMenu.stateText.text.text = string.format(LocalStrEnum.GameShop_CardLastTime, lastDay)
    end

    local lastDay = Me:GetCardLastDayTime(weekCardId)
    if lastDay <= 0 then
        self.weekCardMenu.stateText.text.text = LocalStrEnum.GameShop_CardNoActivity
    else
        self.weekCardMenu.stateText.text.text = string.format(LocalStrEnum.GameShop_CardLastTime, lastDay)
    end
    if cardId ~= nil then
        local toggle = nil
        if cardId == monthCardId then
            toggle = self.monthToggle.toggle
        elseif cardId == weekCardId then
            toggle = self.weekToggle.toggle
        end
        if toggle ~= nil then
            toggle.isOn = true
        end
    end
    self:PlayAnima()
end

function GameShopPanel_CardMenu:PlayAnima()
    local rTrss = {
        self.monthCardMenu.gameObject.transform,
        self.weekCardMenu.gameObject.transform,
    }
    for i = 1, #rTrss do
        local rTrs = rTrss[i]
        rTrs.anchoredPosition = Vector2.New(40, -15)
        rTrs:DOKill()
        rTrs:DOLocalMoveX(0, 0.2)
    end
end

function GameShopPanel_CardMenu:OnTagToggleValueChange(cardId)
    self:PlayAnima()
end

function GameShopPanel_CardMenu:OnMonthBuyBtnClick()

    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local lastDay = Me:GetCardLastDayTime(monthCardId)
    local cfg = Config.GetMonthCardInfo(monthCardId)
    if cfg == nil then
        return
    end
    if lastDay >= cfg.limitDays then
        UICommonUtils.PopToast(string.format(LocalStrEnum.MouthCardLimitTips, cfg.cardName))
        return
    end

    UICommonUtils.Pay(monthGiftId, function()
        UIMgr:popUICover("ActivateCardPanel", 1)
    end)
end

function GameShopPanel_CardMenu:OnWeekBuyBtnClick()
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)

    local lastDay = Me:GetCardLastDayTime(weekCardId)
    local cfg = Config.GetMonthCardInfo(weekCardId)
    if cfg == nil then
        return
    end
    if lastDay >= cfg.limitDays then
        UICommonUtils.PopToast(string.format(LocalStrEnum.MouthCardLimitTips, cfg.cardName))
        return
    end

    Me:BuyItem(weekCardGoodId, 1, nil, function()
        UIMgr:popUICover("ActivateCardPanel", 2)
    end)
end

function GameShopPanel_CardMenu:InitLogic(data)

end

function GameShopPanel_CardMenu:RefreshItem(goodsId)

    if goodsId == monthCardId then
        local lastDay = Me:GetCardLastDayTime(monthCardId)
        if lastDay <= 0 then
            self.monthCardMenu.stateText.text.text = LocalStrEnum.GameShop_CardNoActivity
        else
            self.monthCardMenu.stateText.text.text = string.format(LocalStrEnum.GameShop_CardLastTime, lastDay)
        end
    elseif goodsId == weekCardId then
        local lastDay = Me:GetCardLastDayTime(weekCardId)
        if lastDay <= 0 then
            self.weekCardMenu.stateText.text.text = LocalStrEnum.GameShop_CardNoActivity
        else
            self.weekCardMenu.stateText.text.text = string.format(LocalStrEnum.GameShop_CardLastTime, lastDay)
        end
    end

end

--function GameShopPanel_CardMenu:OnDestroy()
--	self.super:OnDestroy(self)
--end

--[[
/cardTypeToggleGroup/monthToggle onValueChanged 
--]]
function GameShopPanel_CardMenu:monthToggle_Toggle_onValueChanged(monthToggle,isOn)

end

--[[
/cardTypeToggleGroup/weekToggle onValueChanged 
--]]
function GameShopPanel_CardMenu:weekToggle_Toggle_onValueChanged(weekToggle,isOn)

end

return GameShopPanel_CardMenu
