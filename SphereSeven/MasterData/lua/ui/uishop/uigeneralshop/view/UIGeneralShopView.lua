---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/12 21:12
---

local UIGeneralShopView = BaseClass("UIGeneralShopView",UIBaseView)
local base = UIBaseView
local this = UIGeneralShopView
local pfbName = "GeneralShopItem"
local pfbExchange ="ExchangePrefab"
local pfbBtnItem = PathUtil.Path_UIPrefabsItems .. "GenShopBtnItem.prefab"

local QuotaPeriodStrs = {464,463,465,461}
local PlayerCurrencyNames = {"PaidStarStone","FreeStarStone","StarSand","MagicCrystal","EmperorStarPoint"}

local color1 = Color.New(0,220/255,119/255)
local color2 = Color.New(242/255,24/255,55/255)
local minNum = 1

local SummonShop = { [1] = {}, 
                     [2] = {}, [3] = {}, [4] = {}, [5] = {},
                     [6] = {Id = 5001, summonType = 1001, SpriteLang = 270},
                    --  [7] = {Id = 5002, summonType = 1005, SpriteLang = 272},
                    --  [8] = {Id = 5003, summonType = 1006, SpriteLang = 274},
                    --  [9] = {Id = 5004, summonType = 1008, SpriteLang = 283},
                    --  [10] = {Id = 5005, summonType = 1009, SpriteLang = 285},
                   }

local StoreSort = {
    StoreType.Commmon, --普通商店
    StoreType.StarStone, --星砂商店
    StoreType.Arena, --星皇（竞技场）商店
    StoreType.Shard, --魔晶商店
    StoreType.Ticket, --黄绿票商店
    StoreType.StarDust, --星尘商店
}

local function PlayerCurrency(self,TypeId)
    local itemcount = UIPublic.GetItemAmount(TypeId)
    return itemcount
end

local function GetZItemInfo(self,kind,templateId)
    local name,iconName,atlasConfig,amount,desc,zcard
    local player = Game.Scene.Player
    print("<color=green>GoodsId:</color>:" .. templateId .. ",kind:" .. kind)
    if kind == RewardType.RewardTypeItem then --道具
        local zItem = Z_Item[templateId]
        name = zItem.Name
        iconName = GetItemIcon(zItem)
        atlasConfig = AtlasConfig.Item
        desc = zItem.Desc
        -- if zItem.UseType == 3 then
        --     amount = -1--不显示数量
        -- else
            amount = UIPublic.GetItemAmount(templateId)
        -- end
    elseif kind == RewardType.RewardTypeEquipment then --装备
        local zEquip = Z_Equip[templateId]
        name = zEquip.Name
        iconName = zEquip.EquipIcon
        atlasConfig = AtlasConfig.Equip
        local equips = player:GetComponent("EquipComponent").Equips
        amount = table.count(table.choose(equips,function (k,v) return v.TemplateId == templateId end))
        desc = (string.IsNullOrEmpty(zEquip.ExclusiveEfx) and {zEquip.AdditionEfx} or {zEquip.ExclusiveEfx})[1]
    elseif kind == RewardType.RewardTypeCharacter then --角色
        local zCard = Z_Card[templateId]
        zcard = zCard
        name = zCard.Name
        iconName = zCard.Id..".png"
        atlasConfig = AtlasConfig.CardLittle
        local cards = player:GetComponent("CardComponent").Cards
        amount = table.count(table.choose(cards,function (k,v) return v.TemplateId == templateId end))
        local str = LangUtil.GetSysLang(913)
        local rare = {"R","SR","SSR","UR"}
        
        desc =  string.gsub(str,"xx",rare[zCard.Rare])--zCard.Title
        desc = string.gsub(desc,"yy",zCard.Name)
    elseif kind == RewardType.RewardTypeFightSoul then --战魂
        local zFightSoul = Z_FightSoul[templateId]
        name = zFightSoul.Name
        iconName = zFightSoul.Id..".png"
        atlasConfig = AtlasConfig.FightSoul
        local fightSoulCount = player:GetComponent("FightSoulComponent"):GetSameFightSoulList(templateId)
        amount = #fightSoulCount
        desc = zFightSoul.Desc
    end

    return {name = name,iconName = iconName,atlasConfig = atlasConfig,amount = amount,desc = desc,zcard = zcard}
end

local function InitSummonShop(self)
    for i, v in table.pairsByKeys(SummonShop) do
        if v.Id and v.Id ~= 5001 then
                if not self.btnList[i] then
                    self.btnList[i] = {}
                end
                self.btnList[i].isActive = false
                if not IsNull(self.btnList[i].btn) then
                    self.btnList[i].btn.gameObject:SetActive(false)
                end
        end
    end

    local num = 0
    for _, v in pairs(self.btnList) do
        if v.isActive then
            num = num + 1
        end
    end
    if num <= 7 then
        self.BtnScrollRect.movementType = 2
    else
        self.BtnScrollRect.movementType = 1
    end
end

local function InitNumCtrl(self)
    --if self.kind ~= 5 then
    if true then
        self.needList[1]:SetActive(true)
        self.needList[2]:SetActive(false)
        local root = self.needList[1].transform
        local img = root:Find("NeedNumber/Icon"):GetComponent("Image")
        local numTxt = root:Find("NeedNumber"):GetComponent("Text")
        UIUtil.SetSprite(img, AtlasConfig.Item, GetItemIcon(Z_Item[self.zStore.PriceType]), true)

        local totalPrice = self.zStore.TotalPrice * self.goodsAmount
        numTxt.text = totalPrice
        numTxt.color = (PlayerCurrency(self,self.zStore.PriceType) >= totalPrice and {color1} or {color2})[1]
    end
end

-- 选中商品的详细信息
local function InitItemInfo(self)
    local zItemInfo
    zItemInfo= GetZItemInfo(self,self.zStore.GoodsType,self.zStore.GoodsId)
    local active = false
    if SummonShop[self.kind].Id then
        active = true
    end
    self.timeImg.gameObject:SetActive(false)

    self.goodsAmount = minNum
    self.itemCount.text = self.zStore.Amount
    self.itemName.text = zItemInfo.name
    if zItemInfo.amount < 0 then
        self.itemAmount.text = ""
    else
        self.itemAmount.text = LangUtil.GetSysLang(462)..":".. zItemInfo.amount
    end
    self.itemDesc.text = zItemInfo.desc
   
    --self.DHBtn.gameObject:SetActive(self.kind == 5)
    self.DHBtn.gameObject:SetActive(false)
    InitNumCtrl(self)
    self.numTxt.text = self.goodsAmount

    if zItemInfo.atlasConfig == AtlasConfig.CardLittle then
        UIUtil.SetCardSprite(self.itemIcon,zItemInfo.zcard.Id,1,CardPictureType.Little,true)
    else
        UIUtil.SetSprite(self.itemIcon,zItemInfo.atlasConfig,zItemInfo.iconName,true)
    end
    
    if self.zStore.GoodsType == RewardType.RewardTypeEquipment then
        UIPublic.InitEquipBg(Z_Equip[self.zStore.GoodsId],self.itemBg,true)
        UIUtil.SetSprite(self.frame,AtlasConfig.CardLittleFrame,"0.png",true)
    elseif self.zStore.GoodsType == RewardType.RewardTypeCharacter then
        local zCard = Z_Card[zItemInfo.zcard.Id]
        UIUtil.SetSprite(self.itemBg,AtlasConfig.ItemBg,"default"..".png",true)
        UIUtil.SetSprite(self.frame,AtlasConfig.CardLittleFrame, UIPublic.RareNames[zCard.Rare]..".png",true)
    elseif self.zStore.GoodsType == RewardType.RewardTypeFightSoul then
        UIUtil.SetFightSoulSprite(self.itemIcon, self.zStore.GoodsId, FightSoulPictureType.Middle,true)
    else
        local zItem = Z_Item[ self.zStore.GoodsId or self.zStore.ItemId ]
        UIUtil.SetSprite(self.itemBg,AtlasConfig.ItemBg,zItem.IconBg..".png",true)
        UIUtil.SetSprite(self.frame,AtlasConfig.CardLittleFrame,"0.png",true)
    end
end

-- 选中商品
local function OnItem(self, zStore)
    self.zStore = zStore
    self.vs_scroll:All(function (arg)
        arg.go.transform:Find("Active").gameObject:SetActive(arg.data ~= nil and arg.data.Id == zStore.Id)
        local btn = arg.go.transform:GetComponent("Button") -- 并不是所有go都初始化了
        if not IsNull(btn) then
            btn.enabled = (not (arg.data ~= nil and arg.data.Id == zStore.Id))
        end
    end)
    InitItemInfo(self)
end

local function InitItem(self,zStore,kind)
    local gameObject = self.objectList[kind][zStore.Id]
    local transform = gameObject.transform
    local active = transform:Find("Active").gameObject
    local icon = transform:Find("Icon/Value"):GetComponent("Image")
    local iconHold = transform:Find("Icon/Holder").gameObject
    local frame = transform:Find("Icon"):GetComponent("Image")
    local countTxt = transform:Find("Icon/Count"):GetComponent("Text")
    local xg = transform:Find("Xg").gameObject
    local xgTxt = transform:Find("Xg/Value"):GetComponent("Text")
    local nameTxt = transform:Find("Size/Name"):GetComponent("Text")
    local p1 = transform:Find("Price/1").gameObject
    local p2 = transform:Find("Price/2").gameObject
    local starBg = transform:Find("Icon/StarBg"):GetComponent("Image")
    local IsGet = transform:Find("IsGet").gameObject
    local timeText = transform:Find("TimeText").gameObject
    local hint = transform:Find("Hint").gameObject
    LangUtil.BindText(countTxt,"Number")
    LangUtil.BindText(xgTxt)
    LangUtil.BindText(nameTxt)
    LangUtil.BindText(p1.transform:Find("Value"),"Number")

    iconHold:SetActive(false)
    active:SetActive(kind == self.kind and zStore.Id == self.zStore.Id)
    -- p1:SetActive(kind ~= 5)
    -- p2:SetActive(kind == 5)
    p1:SetActive(true)
    p2:SetActive(false)
    local timeActive = false
    if SummonShop[kind].Id then
        timeActive = true
    end
    timeText:SetActive(timeActive)
    
    local itemInfo
    --if kind ~= 5 then
        itemInfo = GetZItemInfo(self,zStore.GoodsType,zStore.GoodsId)
        if zStore.QuotaPeriod ~= 0 then
            xg:SetActive(true)
            local count =  zStore.QuotaNum
            if self.shopComponent.PurchasesDetailList[kind][zStore.Id] ~= nil then
                count = zStore.QuotaNum - self.shopComponent.PurchasesDetailList[kind][zStore.Id].buy_times
            end
            if count < 0 then
                count = 0
            end
            --self.shopComponent:GetDetailVal(zStore.Id，kind)
            xgTxt.text =  LangUtil.GetSysLang(QuotaPeriodStrs[zStore.QuotaPeriod]) ..count.. "/" .. zStore.QuotaNum .. ""
            if count <= 0 then
                IsGet:SetActive(true)
            else
                IsGet:SetActive(false)
            end
        else
            xg:SetActive(false)
            IsGet:SetActive(false)
        end
        local mIcon = p1.transform:Find("Icon"):GetComponent("Image")
        local mPriceTxt = p1.transform:Find("Value"):GetComponent("Text")
        mPriceTxt.text = zStore.TotalPrice
        UIUtil.SetSprite(mIcon, AtlasConfig.Item, GetItemIcon(Z_Item[zStore.PriceType]), true)

        local w= mPriceTxt.preferredWidth + 26
        local x = p1:GetComponent(typeof(RectTransform)).rect.x
        local y = p1:GetComponent(typeof(RectTransform)).rect.y
        p1:GetComponent(typeof(RectTransform)).anchoredPosition = Vector3.New(x-(w/2),y) 


    countTxt.text = zStore.Amount
    nameTxt.text = itemInfo.name 
    UIUtil.ScrollText(nameTxt)
    UIUtil.AddBtnEvent(gameObject,function() OnItem(self,zStore,kind) end)
    if itemInfo.atlasConfig == AtlasConfig.CardLittle then
        UIUtil.SetCardSprite(icon,itemInfo.zcard.Id,1,CardPictureType.Little,true)
    else
        UIUtil.SetSprite(icon,itemInfo.atlasConfig,itemInfo.iconName,true)
    end

    if zStore.GoodsType == RewardType.RewardTypeEquipment then
        UIPublic.InitEquipBg(Z_Equip[zStore.GoodsId],starBg,true)
        UIUtil.SetSprite(frame,AtlasConfig.CardLittleFrame,"0.png",true)
        if Z_Equip[zStore.GoodsId].Exclusive ~= 0 then
            local avatar = iconHold.transform:Find("Avatar"):GetComponent("Image")
            UIUtil.SetCardSprite(avatar, Z_Equip[zStore.GoodsId].Exclusive, 1, CardPictureType.Little, true)
            iconHold:SetActive(true)
        end
    elseif zStore.GoodsType == RewardType.RewardTypeCharacter then
        local zCard = Z_Card[itemInfo.zcard.Id]
        UIUtil.SetSprite(starBg,AtlasConfig.ItemBg,"default"..".png",true)
        UIUtil.SetSprite(frame,AtlasConfig.CardLittleFrame, UIPublic.RareNames[zCard.Rare]..".png",true)
    elseif zStore.GoodsType == RewardType.RewardTypeFightSoul then
        UIUtil.SetFightSoulSprite(starBg, zStore.GoodsId, FightSoulPictureType.Middle,true)
    else
        local zItem = Z_Item[ zStore.GoodsId or zStore.ItemId ]
        UIUtil.SetSprite(starBg,AtlasConfig.ItemBg,zItem.IconBg..".png",true)
        UIUtil.SetSprite(frame,AtlasConfig.CardLittleFrame,"0.png",true)
    end
end

-- 交换跳转
local function InitExchange(self)
    ListChildPool:GetInstance():ClearContent(self.exchangeContent)
    self.exchangeList={}
    local items = table.choose(Z_Item,function(k,v) return v.Type == 2 or v.Type == 3 or v.Type == 4  end) 
    for k,v in table.pairsByKeys(items) do
        ListChildPool:GetInstance():GetChild(pfbExchange,self.exchangeContent,function(go)
            local bg =  go.transform:Find("BG"):GetComponent("Image")
            local sprite =  go.transform:Find("BG/icon"):GetComponent("Image")
            local value = go.transform:Find("BG/value").gameObject
            local button =  go.transform:Find("BG/Button").gameObject
            local exchangeItem = {Id = v.Id ,text = value}
            table.insert(self.exchangeList,exchangeItem)
            if v.Id ==1026 then
                UIUtil.SetSprite(bg,AtlasConfig.ItemBg,"组2.png") -- ignoreCN
                button:SetActive(false)
            else
                UIUtil.SetSprite(bg,AtlasConfig.ItemBg,"组1.png") -- ignoreCN
                UIUtil.AddBtnEvent(button,function()
                    local tipData = {}
                    tipData.title = LangUtil.GetSysLang(9)--"提示"
                    tipData.message = LangUtil.GetSysLang(739)--"前往七星?"
                    tipData.callBack = function()
                        UIManager:GetInstance():OpenWindow(UIWindowNames.UISevenStar)
                    end
                    UIUtil.ToolTipFirst(tipData)
                end)
            end
            UIUtil.SetSprite(sprite,AtlasConfig.Item,GetItemIcon(v),true)
        end)
    end
end

-- 界面跳转部分
function this.ShowHint(self,titleText,Value, spriteName, WindowName, windowType)
    self.itemHint.gameObject:SetActive(true)
    local img = self.itemHint.transform:Find("Image").gameObject
    local eventBg = self.itemHint.transform:Find("EventBg").gameObject
    local titleImage = self.itemHint.transform:Find("Image/titleImage"):GetComponent("Image")
    local Exchange = self.itemHint.transform:Find("Exchange").gameObject
    img:SetActive(false)
    eventBg:SetActive(false)
    Exchange:SetActive(false)
    if titleText ~= nil then
        self.titleText.text = titleText
        self.Value.text = Value
        AtlasManager:GetInstance():LoadImageAsync(nil, "UI/Shop/GeneralShop/"..spriteName, function (sprite) titleImage.sprite = sprite end)
        --titleImage.sprite =  AtlasManager:GetInstance():CoLoadImageAsync("UI/Shop/GeneralShop/"..spriteName)
        UIUtil.AddBtnEvent(self.itemHint.transform:Find("Image/goText"),function()
            img:SetActive(false)
            eventBg:SetActive(false)
            UIManager:GetInstance():OpenWindow(WindowName, {typeName = windowType})
        end)
        UIUtil.AddBtnEvent(self.itemHint, function ()
            img:SetActive(true)
            Exchange:SetActive(false)
            eventBg:SetActive(true)
        end)
    else
        self.Value.text = Value
        UIUtil.AddBtnEvent(self.itemHint, function ()
            coroutine.start(function () InitExchange(self) end)
            local itmes = Game.Scene.Player:GetComponent("ItemComponent").Items
            for i, v in pairs(self.exchangeList) do
                local item = table.first(itmes,function(k) return k.TemplateId ==v.Id  end)
                if item ~= nil then
                    LangUtil.BindText(v.text,"Number").text = UIUtil.ScientificCount(item.Amount)
                else
                    LangUtil.BindText(v.text,"Number").text = 0
                end
            end
            img:SetActive(false)
            Exchange:SetActive(true)
            eventBg:SetActive(true)
        end)
    end
    UIUtil.AddBtnEvent(eventBg, function ()
        img:SetActive(false)
        Exchange:SetActive(false)
        eventBg:SetActive(false)
    end)
end

-- 货币的显示
function this.Currency(self)
    self.itemHint.gameObject:SetActive(false)

    self.gold:SetActive(false)
    self.starSand:SetActive(false)
    self.starLightStone:SetActive(false)
    self.ShopCom:SetActive(false)
    self.starStone:SetActive(false)

    if self.kind == 1 then
        self.gold:SetActive(true)
        self.starSand:SetActive(true)
        self.starLightStone:SetActive(true)
        self.SetCurrencyDetail(self.gold, true, Z_Misc["GOLD_ID"])
        self.SetCurrencyDetail(self.starSand, true, Z_Misc["DIAMOND_ID"])
        self.SetCurrencyDetail(self.starLightStone, true, Z_Misc["FREE_DIAMOND_ID"])
    elseif self.kind == 2 then
        self.gold:SetActive(true)
        self.SetCurrencyDetail(self.gold, true, Z_Misc["STAR_SAND_ID"])
    elseif self.kind == 3 then
        self.gold:SetActive(true)
        self.SetCurrencyDetail(self.gold, true, Z_Misc["MILITARY_ORDER_ID"])
    elseif self.kind == 4 then
        self.gold:SetActive(true)
        self.SetCurrencyDetail(self.gold, true, Z_Misc["MAGIC_CRYSTAL_ID"])
    elseif self.kind == 5 then
        self.gold:SetActive(true)
        self.starSand:SetActive(true)
        self.SetCurrencyDetail(self.gold, true, Z_Misc["YELLOW_TICKET_ID"])
        self.SetCurrencyDetail(self.starSand, true, Z_Misc["GREEN_TICKET_ID"])
    elseif self.kind == 6 then
        self.gold:SetActive(true)
        self.SetCurrencyDetail(self.gold, true, Z_Misc["STAR_STONE_ID"])
    end
end

function this.SetCurrencyDetail(item, state, itemId)
    item:SetActive(state)
    if state then
        local img = item.transform:Find("Image"):GetComponent("Image")
        UIUtil.SetSprite(img, AtlasConfig.Item, GetItemIcon(Z_Item[tonumber(itemId.Value[1])]))
        local txt = item.transform:Find("Text"):GetComponent("Text")
        txt.text = UIPublic.GetItemAmount(itemId.Value[1])

        UIUtil.AddBtnEvent(item.transform,function(go) 
            local showData = {}
            showData.showType = ShowType.Item
            showData.tempId = tonumber(itemId.Value[1])
            UIUtil.OpenThingsDetailWindow(showData)
        end)
    end
end

-- 子商店切换
local function OnPanelButton(self, id)
    if not self.btnList[id] or not self.btnList[id].isActive then
        id = 1
    end

    for k,v in pairs(self.btnList) do
        if v.isActive then
            v.activeImage.gameObject:SetActive(id == k)
            v.btn:GetComponent("Button").enabled  = (not (id == k))
        end
    end
    self.kind = id
    self:Currency()
    local list = self.zStoreList[id]

    local moveY = 0

    self.scrollView.transform:DOLocalMoveY(moveY, 0)
    self.vs_scroll:RefreshData(list)

    self.itemIcon.sprite = DeActiveSprite
    self.frame.sprite = DeActiveSprite
    self.itemBg.sprite= DeActiveSprite
    
    local data
    if self.itemData == nil or self.itemData.StoreType ~= self.kind then
        data = table.first(list)
    else
        data = self.itemData
        self.itemData = nil
    end
    OnItem(self, data, id)
    self.vs_scroll:MoveToItem(data.Id, 3) --3为每行显示个数
end

function this.GenShopBtnItem(self, kind)
    if not self.btnList[kind] then
        self.btnList[kind] = {}
    end
    if IsNull(self.btnList[kind].btn) then
        local item = {}
        local obj = GameObjectPool:GetInstance():CoGetGameObjectAsync(pfbBtnItem)
        item.btn = obj.transform
        item.btn.transform:SetParent(self.btnCtrl, false)
        item.btn.gameObject:SetActive(true)
        item.activeImage = item.btn:GetChild(0):GetComponent("Image")
        item.btn.gameObject:SetActive(true)

        local StoreType = StoreSort[kind]
        local hint = obj.transform:Find("Hint").gameObject

        UIUtil.AddBtnEventNoBug(item.btn, function() OnPanelButton(self, kind) end)
        self.btnList[kind] = item
        self.btnList[kind].isActive = true
        if SummonShop[kind].SpriteLang then
            coroutine.start(function()
                LangUtil.GetSpriteLang(SummonShop[kind].SpriteLang, function(sprite) item.btn:GetComponent("Image").sprite = sprite end)
                LangUtil.GetSpriteLang(SummonShop[kind].SpriteLang + 1, function(sprite) item.activeImage.sprite = sprite end)
            end)
        end
    end
end

local function OnAdd(self)
    local quotaNum = self.zStore.QuotaNum
    if quotaNum == nil then quotaNum = 0 end

    local count =  self.zStore.QuotaNum
    if self.shopComponent.PurchasesDetailList[self.kind][self.zStore.Id] ~= nil then
        count = self.zStore.QuotaNum - self.shopComponent.PurchasesDetailList[self.kind][self.zStore.Id].buy_times
    end
    
    if self.goodsAmount >= count and self.zStore.QuotaPeriod ~= 0  then UIUtil.ToolTipFourth(LangUtil.GetSysLang(1064))  return end --"超过限购数量"
    self.goodsAmount = self.goodsAmount + 1
    self.numTxt.text = self.goodsAmount
    InitNumCtrl(self)
end

local function OnReduce(self)
    if self.goodsAmount <= minNum then UIUtil.ToolTipFourth(LangUtil.GetSysLang(565))  return end --"购买数量最小为1"
    self.goodsAmount = self.goodsAmount - 1
    self.numTxt.text = self.goodsAmount
    InitNumCtrl(self)
end

local function OnBuy(self)
    --if self.kind ~= 5 then -- 非兑换商店
    if true then
        local totalNum = self.zStore.TotalPrice * self.goodsAmount
        local currencyName = Z_Item[self.zStore.PriceType].Name
        -- if SummonShop[self.kind].Id then -- 星尘商店
        --     currencyName = Z_Item[self.zStore.PriceType].Name
        -- else
        --     currencyName = Z_Currency[self.zStore.PriceType + 1].Name
        -- end
        if PlayerCurrency(self,self.zStore.PriceType) < totalNum then
            UIUtil.ToolTipFourth(string.gsub(LangUtil.GetSysLang(1066),"XXX", currencyName, 1)) --.."不足"
            return
        end
        if self.goodsAmount < minNum then
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(1065))--"物品数量不足"
            return
        else
            --local count = self.zStore.QuotaNum - --self.shopComponent:GetDetailVal(self.zStore.Id)
            local count = self.zStore.QuotaNum
            if self.shopComponent.PurchasesDetailList[self.kind][self.zStore.Id] ~= nil then
                count = self.zStore.QuotaNum - self.shopComponent.PurchasesDetailList[self.kind][self.zStore.Id].buy_times
            end
            if count < self.goodsAmount and self.zStore.QuotaPeriod ~= 0 then
                UIUtil.ToolTipFourth(LangUtil.GetSysLang(1064))
                return
            end
        end
        
        local tipData = {}
        tipData.title = LangUtil.GetSysLang(9)--"提示"
        local ItemName = ""
        if self.zStore.GoodsType == RewardType.RewardTypeItem then
            ItemName = Z_Item[self.zStore.GoodsId].Name
        elseif self.zStore.GoodsType == RewardType.RewardTypeEquipment then
            ItemName = Z_Equip[self.zStore.GoodsId].Name
        elseif self.zStore.GoodsType == RewardType.RewardTypeCharacter  then
            ItemName = Z_Card[self.zStore.GoodsId].Name
        end
        if SummonShop[self.zStore.StoreType].Id then
            tipData.message = LangUtil.GetSysLang(1136)
        else
            if self.zStore.Amount > 1 then
                tipData.message = LangUtil.GetSysLang(1099)
            else
                tipData.message = LangUtil.GetSysLang(1089)
            end
        end
        
        
        if self.zStore.PriceType == 2 then
            if self.player[PlayerCurrencyNames[2]] - totalNum >= 0  then
                tipData.message = string.gsub(tipData.message,"XX",totalNum ..currencyName)
            else
                local P_num = totalNum - self.player[PlayerCurrencyNames[2]]
                
                tipData.message = string.gsub(tipData.message,"XX",(self.player[PlayerCurrencyNames[2]] > 0 and {self.player[PlayerCurrencyNames[2]]..currencyName.."、"} or {""})[1]
                        .. P_num .. Z_Currency[2].Name)--""
            end
        else
            tipData.message = string.gsub(tipData.message,"XX",totalNum ..currencyName)
        end
        
        tipData.message = string.gsub(tipData.message,"Y",ItemName)
        tipData.message = string.gsub(tipData.message,"Z",self.goodsAmount)
        tipData.callBack = function()
            self.ctrl:SendBuyRequest(self.zStore,self.goodsAmount, self.kind) 
        end
        UIUtil.ToolTipFirst(tipData)
    else 
    end
end

function this.OnCreate(self)
    base.OnCreate(self)
    ---@type HintComponent

    self.btnList = {}
    self.needList = {}
    self.exchangeList = {}
    self.backBtn = self.rc:GetObject("BackButton")
   
    self.scrollView = self.rc:GetObject("ViewRoot").transform
    self.btnCtrl = self.rc:GetObject("BtnCtrl").transform
    self.BtnScrollRect = self.rc:GetObject("Scroll View"):GetComponent("ScrollRect")
    self.itemPanel = self.rc:GetObject("ItemInfo").transform
    UIUtil.AddBtnEvent(self.backBtn,function() UIManager:GetInstance():CloseWindow(UIWindowNames.UIGeneralShop) end,"Back")

    self.itemIcon = self.itemPanel:Find("Icon/Value"):GetComponent("Image")
    self.frame = self.itemPanel:Find("Icon"):GetComponent("Image")
    self.itemCount = self.itemPanel:Find("Icon/Count"):GetComponent("Text")
    self.itemBg = self.itemPanel:Find("Icon/Image"):GetComponent("Image")
    self.itemName = self.itemPanel:Find("Name"):GetComponent("Text")
    self.itemAmount = self.itemPanel:Find("HoldNum"):GetComponent("Text")
    self.itemDesc = self.itemPanel:Find("Desc"):GetComponent("Text")
    self.itemHint = self.itemPanel:Find("Hint").gameObject
    self.needCtrl = self.itemPanel:Find("Need")
    self.timeImg = self.itemPanel:Find("TimeImg")
    self.panelTime = self.timeImg:Find("PanelTime"):GetComponent("Text")
    
    self.buyBtn = self.itemPanel:Find("Buy").gameObject
    self.DHBtn = self.itemPanel:Find("DH").gameObject
    UIUtil.AddBtnEvent(self.buyBtn,function() OnBuy(self) end)
    UIUtil.AddBtnEvent(self.DHBtn,function() OnBuy(self) end)
    self.numTxt = self.itemPanel:Find("NumCtrl/ShowNum/ShowNumText"):GetComponent("Text")
    self.addBtn = self.itemPanel:Find("NumCtrl/AddButton").gameObject
    self.reduceBtn = self.itemPanel:Find("NumCtrl/ReduceButton").gameObject
    
    self.exchangeContent = self.rc:GetObject("ExchangeContent")
    
    UIUtil.AddBtnEvent(self.addBtn,function() OnAdd(self) end)
    UIUtil.AddBtnEvent(self.reduceBtn,function() OnReduce(self) end)

    for i = 0,self.needCtrl.childCount - 1 do
        local child = self.needCtrl:GetChild(i)
        self.needList[i+1] = child.gameObject
    end

    self.vs_scroll = VerticalScroll.New()
    self.vs_scroll:SetUpdateCount(3)
    self.RecruitComponent = Game.Scene.Player:GetComponent("RecruitComponent")
    
    for i = 1, 6, 1 do
        self:GenShopBtnItem(i)
    end
end

function this.OnLangCreate (self)
    LangUtil.BindText(self.backBtn.transform:Find("Text")).text=LangUtil.GetSysLang(3113)
    LangUtil.BindText(self.needCtrl.transform:Find("1/NeedNumber"))
    LangUtil.BindText(self.needCtrl.transform:Find("2/1"))
    LangUtil.BindText(self.needCtrl.transform:Find("2/2"))
    LangUtil.BindText(self.needCtrl.transform:Find("2/3"))
    LangUtil.BindText(self.needCtrl.transform:Find("2/4"))
    LangUtil.BindText(self.needCtrl.transform:Find("2/5"))
    self.titleText=LangUtil.BindText(self.itemHint.transform:Find("Image/titleText"))
    LangUtil.BindText(self.itemHint.transform:Find("Image/goText"))
    self.Value=LangUtil.BindText(self.itemHint.transform:Find("Value"))

    LangUtil.BindText(self.itemCount,"Number")
    LangUtil.BindText(self.itemName)
    LangUtil.BindText(self.itemAmount)
    LangUtil.BindText(self.itemDesc)
    LangUtil.BindText(self.buyBtn.transform:Find("Text")).text=LangUtil.GetSysLang(223)
    LangUtil.BindText(self.DHBtn.transform:Find("Text")).text=LangUtil.GetSysLang(414)
    LangUtil.BindText(self.numTxt,"Number").text = "1"

    self.timeImgText = LangUtil.BindText(self.timeImg.transform:Find("Text"))
    self.timeImgText.text = ""
    LangUtil.BindText(self.panelTime)

    local itmes = Game.Scene.Player:GetComponent("ItemComponent").Items
    for i, v in pairs(self.exchangeList) do
        local item = table.first(itmes,function(k) return k.TemplateId ==v.Id  end)
        if item ~= nil then
            LangUtil.BindText(v.text,"Number").text = UIUtil.ScientificCount(item.Amount)
        else
            LangUtil.BindText(v.text,"Number").text = 0
        end
    end

    for k, v in pairs(self.btnList) do
        if not (SummonShop[k].Id and SummonShop[k].Id ~= 5001) then
            LangUtil.GetSpriteLang(258 + k * 2, function(sprite) v.btn:GetComponent("Image").sprite = sprite end)
            LangUtil.GetSpriteLang(259 + k * 2, function(sprite) v.activeImage.sprite = sprite end)
        end
    end
end

function this.OnEnable(self)
    base.OnEnable(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
    self.comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    self.gold = self.comTopView.gold
    self.starSand = self.comTopView.starSand
    self.starStone = self.comTopView.starStone
    self.starLightStone = self.comTopView.starLightStone
    self.ShopComImg  = self.comTopView.ShopComImg
    self.ShopCom = self.comTopView.ShopCom
    self.ShopCom_text = self.comTopView.ShopCom_text
    self.gold:SetActive(false)
    self.countDownId = TimeUtil.GetCountDownId()

    self.gold:SetActive(false)
    self.starSand:SetActive(false)
    self.starLightStone:SetActive(false)
    self.ShopCom:SetActive(false)
    self.starStone:SetActive(false)
    self:OnRefresh()

    ---- 从其他界面跳转过来需要播放
    --if self.model.modeType ~= 1 then
    --    coroutine.start(function()
    --        coroutine.waitforframes(3)
    --        Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI,"Store")
    --    end)
    --end
end

function this.OnDisable(self)
    base.OnDisable(self)
    TimeUtil.RemoveCountDown(self.countDownId)
    self.objectList = nil
    -- self.starSand:SetActive(true)
    -- self.gold:SetActive(true)
    -- self.ShopCom:SetActive(false)
    self.vs_scroll:Dispose()
end

local function InitContent(self, kind)
    self.kind = kind
    self.vs_scroll:Clear()
    --{self.zStoreList[self.kind]}
    self.vs_scroll:ScrollInit({}, self.scrollView, pfbName, function (arg)
        if self.objectList[self.kind] == nil then
            self.objectList[self.kind] = {}
        end
        self.objectList[self.kind][arg.data.Id] = arg.go
        InitItem(self, arg.data, self.kind)
    end)
    
    -- 当前选中的item
    OnPanelButton(self, self.kind)

    -- 货币显示
    --self:Currency()
end

function this.OnRefresh(self)
    self.player = Game.Scene.Player
    self.zStoreList = {{},{},{},{},{},{},{},{}}
    self.objectList = {}
    self.goodsAmount = minNum

    for k,v in table.pairsByKeys(Z_Store) do
        if v.StoreType == StoreType.Commmon then
            self.zStoreList[1][k] = v
        elseif v.StoreType == StoreType.StarStone then
            self.zStoreList[2][k] = v
        elseif v.StoreType == StoreType.Arena then
            self.zStoreList[3][k] = v
        elseif v.StoreType == StoreType.Shard then
            self.zStoreList[4][k] = v
        elseif v.StoreType == StoreType.Ticket then
            self.zStoreList[5][k] = v
        elseif v.StoreType == StoreType.StarDust then
            self.zStoreList[6][k] = v
        end
    end

    InitSummonShop(self)
    
    self.shopComponent = Game.Scene.Player:GetComponent("ShopComponent") 
    self.itemData = nil
    if self.model.data ~= nil and self.model.data.TemplateId ~= nil then
        for k,v in table.pairsByKeys(Z_Store) do
            if v.GoodsId == self.model.data.TemplateId then
                self.itemData = v
                break
            end
        end
    end

    local kind = self.itemData == nil and 1 or self.itemData.StoreType
    if self.model.data ~=nil and self.model.data.kind ~= nil  then
        kind = self.model.data.kind
    end
    InitContent(self, kind)
end

-- 0点更新
function this.UpdateItemData(self)
    self:Currency()
    self.goodsAmount = minNum
    self.numTxt.text = self.goodsAmount
    -- 更新星尘商店物品
    self.summon_component = Game.Scene.Player:GetComponent("RecruitComponent")
    if self.summon_component.StardustId ~= nil and Z_StoreStardust[self.summon_component.StardustId] ~= nil then
        self.zStoreList[6] = {}
        table.walk(Z_StoreStardust[self.summon_component.StardustId].StoreId, function (k, v)
            self.zStoreList[6][v] = Z_Store[v]
        end)
    end

    local isChange = false

    if isChange then
        --InitSummonShop(self)
        OnPanelButton(self, self.kind)
    else
        local data = self.zStoreList[self.kind]
        self.vs_scroll:RefreshData(data)
        InitItemInfo(self)
    end

end

function this.OnAddListener(self)
    base.OnAddListener(self)
    self:AddUIListener(UIMessageNames.ON_PLAYER_INFO_CHG,self.UpdateItemData)
    self:AddUIListener(UIMessageNames.ON_DAY_PURCHASE_INFO_CHG,self.UpdateItemData)
    self:AddUIListener(UIMessageNames.ON_WEEK_PURCHASE_INFO_CHG,self.UpdateItemData)
    self:AddUIListener(UIMessageNames.ON_MONTH_PURCHASE_INFO_CHG,self.UpdateItemData)
    self:AddUIListener(UIMessageNames.ON_ITEM_INFO_CHG,self.UpdateItemData)
    self:AddUIListener(UIMessageNames.ON_EQUIP_INFO_CHG,self.UpdateItemData)
    self:AddUIListener(UIMessageNames.ON_CARD_INFO_CHG,self.UpdateItemData)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
    self:RemoveUIListener(UIMessageNames.ON_PLAYER_INFO_CHG)
    self:RemoveUIListener(UIMessageNames.ON_DAY_PURCHASE_INFO_CHG)
    self:RemoveUIListener(UIMessageNames.ON_WEEK_PURCHASE_INFO_CHG)
    self:RemoveUIListener(UIMessageNames.ON_MONTH_PURCHASE_INFO_CHG)
    self:RemoveUIListener(UIMessageNames.ON_ITEM_INFO_CHG)
    self:RemoveUIListener(UIMessageNames.ON_EQUIP_INFO_CHG)
    self:RemoveUIListener(UIMessageNames.ON_CARD_INFO_CHG)
end

function this.OnViewTop(self)
    -- base.OnViewTop(self)
    -- UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
    -- local comTopView = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    -- self.gold = comTopView.gold
    -- self.starSand = comTopView.starSand
    -- self.starStone = comTopView.starStone
    -- self.starLightStone = comTopView.starLightStone
    -- self.ShopComImg  = comTopView.ShopComImg
    -- self.ShopCom = comTopView.ShopCom
    -- self.ShopCom_text = comTopView.ShopCom_text
    --self.gold:SetActive(false)
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
    if self.model.data ~= nil and  self.model.data.windowNames ~= nil then
        for k,v in pairs(self.model.data.windowNames) do
            UIManager:GetInstance():OpenWindow(v)
        end
    end
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this
