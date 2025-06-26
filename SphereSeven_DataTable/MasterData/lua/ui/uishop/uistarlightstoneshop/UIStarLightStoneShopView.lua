local UIStarLightStoneShopView = BaseClass("UIStarLightStoneShopView",UIBaseView);
local base = UIBaseView
local this = UIStarLightStoneShopView
local pfbName = "StarLightStoneShopItem"
local pfbName2 = "StarLightGiftItem"

local function GetFullPath(zStarLightStoneShop)
    return "UI/Shop/StarLightStoneShop/"..zStarLightStoneShop.Icon
end

RewardTypeComm =
{
    [1]="Item",
    [2] = "Card",
    [3] = "FightSoul",
    [4] = "StarStone",
    [5] = "GoldCoin",
    [6] = "MagicCrystal",
    [7] = "Equip",
    [8] = "StarSand",
    [9] = "EmperorStarPoint",
    [10] = "DemonPoint",
    [12] = "StarLight",
    [50] = "Skin",
}

local function CloseToolTip(self)
    self.toolTip:SetActive(false)
    for i, v in pairs(self.ContentList) do
        v.gameObject:SetActive(false)
    end
end

local function ShowToolTip(self,dataInfo)
    self.TipContent.transform:DOLocalMoveY(0,0)
    local purCount = Game.Scene.Player:GetComponent("StarLightRebateComponent"):GetPurchaseCount(dataInfo.Id)
    local num = purCount == 0 and 3 or 1
    
    local rewardTable
    if dataInfo.Type == 1 and purCount == 0 then
        rewardTable = Z_Reward[dataInfo.FirstRewards]
    else
        rewardTable = Z_Reward[dataInfo.Rewards]
    end
    for i = 1, #rewardTable do
        local transform = self.ContentList[i].transform
        local avatar = transform:Find("Item/Value"):GetComponent("Image")
        local bg = transform:Find("Item/Bg"):GetComponent("Image")
        local name = transform:Find("NameTextRoot/NameTxt"):GetComponent("Text")
        local holdTxt = transform:Find("Item/Num"):GetComponent("Text")

        local zReward = rewardTable[i]
        local reward = UIPublic.GetRewardDataNew(zReward.Type, zReward.ObjId, zReward.Count)
        holdTxt.text = reward.count
    
        UIPublic.InitItemIconNew(avatar,bg, reward.type, reward.id)

        name.text = reward.name
        --holdTxt.text = UIUtil.ScientificCount(dataInfo.CurrencyAmount[i], 5)
        transform.gameObject:SetActive(true)
    end
    
    if dataInfo.Type == 1 then
        self.titleText.text = dataInfo.Name.."<color=#fff2aa>".."x"..dataInfo.Num[1]*num.."</color>"
    else
        self.titleText.text = dataInfo.Name.."<color=#fff2aa>".."</color>"
    end
    
    local money = ""
    local currencyType = ChannelManager:GetInstance():GetCurrencyType()
    if currencyType == ChannelCurrency.JA then
        money = "￥"..dataInfo.Price
    elseif currencyType == ChannelCurrency.US then
        money = "$"..dataInfo.Dollar
    end
    
    self.BuyText.text = money
    
    self.toolTip:SetActive(true)
    local str
    if dataInfo.Type == 1 then
        if purCount == 0 then
            str = string.gsub(LangUtil.GetSysLang(2057),"X",dataInfo.Num[1])
            str = string.gsub(str,"Y",dataInfo.Num[1]*2)
            str = string.gsub(str,"Z",money)
        else
            str = string.gsub(LangUtil.GetSysLang(2064),"X",dataInfo.Num[1])
            str = string.gsub(str,"Z",money)
        end
    else
        str = string.gsub(LangUtil.GetSysLang(1089),"XX", money)
        str = string.gsub(str,"Y",dataInfo.Name)
        str = string.gsub(str,"Z",1)
    end 
    local data = {}
    data.Event = function()
        local player = Game.Scene.Player
        local quotaCount = player:GetComponent("StarLightRebateComponent"):GetQuotaCount(dataInfo.Id)
        if dataInfo.QuotaNum > 0 and quotaCount >= dataInfo.QuotaNum then
            UIUtil.ToolTipFourth(LangUtil.GetSysLang(1064))
            return
        end

        self.ctrl:SendStarLightRequest(dataInfo)
        -- 测试服测试购买用

        if ChannelManager:GetInstance():IsChannel(ChannelType.Test) then
            local productId = ChannelManager:GetInstance():GetFullId(dataInfo.Id)
            local platform = ChannelManager:GetInstance():GetPlatform()
            local tab = {}
            tab.ProductId = productId
            tab.Token = productId
            tab.Platform = platform
            ChannelManager:GetInstance():PurchaseVerify(cjson.encode(tab))
            return
        end
        if dataInfo.Price <= 0 then -- 这个是免费领取
            ChannelManager:GetInstance():CommonCallback(GameEvent.DailyFree)
            local productId = ChannelManager:GetInstance():GetFullId(dataInfo.Id)
            local platform = ChannelManager:GetInstance():GetPlatform()
            local tab = {}
            tab.ProductId = productId
            tab.Token = productId
            tab.Platform = platform
            ChannelManager:GetInstance():PurchaseVerify(cjson.encode(tab))
        else
            ChannelManager:GetInstance():Purchase(dataInfo.Id)
        end
    end
    UIUtil.AddBtnEvent(self.BuyBtn,function()
        CloseToolTip(self)
        data.Event()
    end)
end

local function InitContent(self, tab1)
    local starLightComponent = Game.Scene.Player:GetComponent("StarLightRebateComponent")
    -- tab1商店
    local func1 = function()
        ListChildPool:GetInstance():ClearContent(self.content)
        local index = 0
        for k, v in table.pairsByKeys(Z_StarLightStoneShop) do
            local quotaCount = starLightComponent:GetQuotaCount(v.Id)
            local timeSlot = table.first(starLightComponent.TimeSlots, function (val) return val.Key == v.Id end)
            -- 1.只有购买次数限制的商品   买完就不显示了   2.时间限制型商品   超时就不显示了
            local isShow = true
            if v.QuotaPeriod == 4 then
                isShow = v.QuotaNum > 0 and quotaCount < v.QuotaNum
            elseif v.QuotaPeriod == 5 then
                isShow = timeSlot ~= nil and TimeUtil.OSTime() < timeSlot.End
            end
            if isShow and (v.Type == 1 or v.Type == 2) then
                ListChildPool:GetInstance():GetChild(pfbName, self.content, function(gameObject)
                    if self.active == false then ListChildPool:GetInstance():Remove(gameObject) return end
                    local transform = gameObject.transform
                    self.ShopList[v.Id] = gameObject
                    self:Item(v, transform, quotaCount)
                    local buyBtn =  transform:Find("Buy").gameObject
                    UIUtil.AddBtnEvent(buyBtn,function() ShowToolTip(self,v) end)

                    local hint = transform:Find("Hint").gameObject
                end)
                index = index + 1
                if math.fmod(index, 3) == 0 then
                    coroutine.waitforframes(1)
                end
            end
        end
    end
    -- tab2商店
    local func2 = function()
        ListChildPool:GetInstance():ClearContent(self.giftContent)
        local index = 0
        for k, v in table.pairsByKeys(Z_StarLightStoneShop) do
            local quotaCount = starLightComponent:GetQuotaCount(v.Id)
            local timeSlot = table.first(starLightComponent.TimeSlots, function (val) return val.Key == v.Id end)
            -- 1.只有购买次数限制的商品   买完就不显示了   2.时间限制型商品   超时就不显示了
            local isShow = true
            if v.QuotaPeriod == 4 then
                isShow = v.QuotaNum > 0 and quotaCount < v.QuotaNum
            elseif v.QuotaPeriod == 5 then
                isShow = timeSlot ~= nil and TimeUtil.OSTime() < timeSlot.End
            end
            if isShow and v.Type == 3 then
                ListChildPool:GetInstance():GetChild(pfbName2, self.giftContent, function(gameObject)
                    if self.active == false then ListChildPool:GetInstance():Remove(gameObject) return end
                    local transform = gameObject.transform
                    self.ShopList[v.Id] = gameObject
                    self:GiftItem(v, transform, quotaCount)
                    local buyBtn =  transform:Find("Buy").gameObject
                    UIUtil.AddBtnEvent(buyBtn,function() ShowToolTip(self, v) end)

                    local hint = transform:Find("Hint").gameObject
                end)
                index = index + 1
                if math.fmod(index, 3) == 0 then
                    coroutine.waitforframes(1)
                end
            end
        end
    end

    coroutine.start(function ()
        if tab1 then
            func1()
            coroutine.waitforframes(3)
            func2()
        else
            func2()
            coroutine.waitforframes(3)
            func1()
        end
    end)
end

function this.Item(self, v, transform, quotaCount)
    -- 1.时间限制型商品过期
    local starLightComponent = Game.Scene.Player:GetComponent("StarLightRebateComponent")
    local timeSlot = table.first(starLightComponent.TimeSlots, function (val) return val.Key == v.Id end)
    if v.QuotaPeriod == 5 then
        if timeSlot == nil then
            Logger.LogError("timeSlot is nil")
            transform.gameObject:SetActive(false)
            return
        elseif TimeUtil.OSTime() > timeSlot.End then
            transform.gameObject:SetActive(false)
            return
        end
    end
    
    local icon = transform:Find("Icon"):GetComponent("Image")
    local IsGet = transform:Find("IsGet").gameObject
    local price = transform:Find("Price/PriceText"):GetComponent("Text")
    local LimitNum= transform:Find("Limit/LimitNum")
    local name = transform:Find("Name/Value"):GetComponent("Text")
    local giver = transform:Find("Giver").gameObject

    -- 2.限购型商品，是否达到次数
    local isGet = v.QuotaNum > 0 and quotaCount >= v.QuotaNum
    local mtrl = isGet and self.UIGreyMat or nil
    
    transform:GetComponent("Image").material = mtrl
    
    -- 3.首次加倍标签
    giver:SetActive(v.FirstMultiple > 0 and starLightComponent:GetPurchaseCount(v.Id) == 0)
    if giver.activeSelf then
        LangUtil.BindText(transform:Find("Giver/GiverText"), FontType.All_Number).text = LangUtil.GetSysLang(2067)
    end
    
    -- 4.标签图片和文字
    local limitImg = transform:Find("Limit"):GetComponent("Image")
    limitImg.gameObject:SetActive(v.TagType ~= 0)
    if v.TagType ~= 0 then
        AtlasManager:GetInstance():LoadImageAsync(nil, "UI/Atlas/Tag/"..v.TagType..".png", function (sprite) limitImg.sprite = sprite end)
        --limitImg.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Atlas/Tag/"..v.TagType..".png")
        limitImg.material = mtrl
        limitImg:DOFade(isGet and 0.3 or 1, 0)
        LangUtil.BindText(transform:Find("Limit/LimitText"), FontType.All_Number).text = v.TagText
    end
    
    -- 5.限购次数
    LimitNum.gameObject:SetActive(v.QuotaNum > 0)
    if v.QuotaNum > 0 then
        LangUtil.BindText(LimitNum).text = (v.QuotaNum - quotaCount).."/"..v.QuotaNum
    end
    
    -- 6.图标 名字 价格
    AtlasManager:GetInstance():LoadImageAsync(nil, GetFullPath(v), function (sprite) icon.sprite = sprite end)
    --icon.sprite = AtlasManager:GetInstance():CoLoadImageAsync(GetFullPath(v))
    icon.material = mtrl
    LangUtil.BindText(name).text = v.Type == 1 and v.Name.."x"..v.Num[1] or v.Name

    local money = ""
    local currencyType = ChannelManager:GetInstance():GetCurrencyType()
    if currencyType == ChannelCurrency.JA then
        money = "￥"..v.Price
    elseif currencyType == ChannelCurrency.US then
        money = "$"..v.Dollar
    end
    
    LangUtil.BindText(price, FontType.All_Number).text = isGet and "<color=#ffffff>"..money.."</color>" or "<color=#FFF2AA>"..money.."</color>"
    IsGet:SetActive(isGet)
end

function this.GiftItem(self, v, transform, quotaCount)
    -- 1.时间限制型商品过期
    local starLightComponent = Game.Scene.Player:GetComponent("StarLightRebateComponent")
    local timeSlot = table.first(starLightComponent.TimeSlots, function (val) return val.Key == v.Id end)
    if v.QuotaPeriod == 5 then
        if timeSlot == nil then
            Logger.LogError("timeSlot is nil")
            transform.gameObject:SetActive(false)
            return
        elseif TimeUtil.OSTime() > timeSlot.End then
            transform.gameObject:SetActive(false)
            return
        end
    end
    
    -- 2.限购型商品，是否达到次数
    local isGet = v.QuotaNum > 0 and quotaCount >= v.QuotaNum
    local mtrl = isGet and self.UIGreyMat or nil
    
    transform:GetComponent("Image").material = mtrl
    
    -- 3.标签图片和文字
    local limitImg = transform:Find("Limit"):GetComponent("Image")
    limitImg.gameObject:SetActive(v.TagType ~= 0)
    if v.TagType ~= 0 then
        AtlasManager:GetInstance():LoadImageAsync(nil, "UI/Atlas/Tag/"..v.TagType..".png", function (sprite) limitImg.sprite = sprite end)
        --limitImg.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Atlas/Tag/"..v.TagType..".png")
        limitImg.material = mtrl
        limitImg:DOFade(isGet and 0.3 or 1, 0)
        LangUtil.BindText(transform:Find("Limit/LimitText"), FontType.All_Number).text = v.TagText
    end
    
    -- 4.商品图标 名字 描述
    local icon = transform:Find("Icon"):GetComponent("Image")
    AtlasManager:GetInstance():LoadImageAsync(nil, GetFullPath(v), function (sprite) icon.sprite = sprite end)
    --icon.sprite = AtlasManager:GetInstance():CoLoadImageAsync(GetFullPath(v))
    icon.material = mtrl
    LangUtil.BindText(transform:Find("NameTxt")).text = v.Name
    LangUtil.BindText(transform:Find("Desc/DescTxt")).text = v.Desc
    
    -- 5.奖励物品图标和数量
    local count = 0
    local rewardTable = Z_Reward[v.Rewards]
    for i = 1, table.count(rewardTable) do
        --local val = v.CurrencyType[i]
        --if Z_Currency[val] ~= nil then
            count = count + 1
            if count <= 3 then
                local bg = transform:Find("RewardIcon/"..count):GetComponent("Image")
                local frame = transform:Find("RewardIcon/"..count.."/Frame"):GetComponent("Image")
                local img = transform:Find("RewardIcon/"..count.."/Image"):GetComponent("Image")
                local text = LangUtil.BindText(transform:Find("RewardIcon/"..count.."/Num"), FontType.All_Number)

                local zReward = rewardTable[i]
                text.text = zReward.Count
                local reward = UIPublic.GetRewardDataNew(zReward.Type, zReward.ObjId, zReward.Count)
                UIPublic.InitItemIconNew(img, bg, reward.type, reward.id)

                bg.material = mtrl
                frame.material = mtrl
                img.material = mtrl
                --LangUtil.BindText(transform:Find("RewardIcon/"..count.."/Num"), FontType.All_Number).text = UIUtil.ScientificCount(v.CurrencyAmount[i], 5)
            end
        --end
    end
    
    -- local count = 0
    -- for i = 1, table.count(v.RewardType) do
    --     --local val = v.CurrencyType[i]
    --     --if Z_Currency[val] ~= nil then
    --         count = count + 1
    --         if count <= 3 then
    --             local bg = transform:Find("RewardIcon/"..count):GetComponent("Image")
    --             local frame = transform:Find("RewardIcon/"..count.."/Frame"):GetComponent("Image")
    --             local img = transform:Find("RewardIcon/"..count.."/Image"):GetComponent("Image")
    --             local text = LangUtil.BindText(transform:Find("RewardIcon/"..count.."/Num"), FontType.All_Number)
    --             local rewardInfo = {}
    --             rewardInfo.TemplateId = v.TemplateId[i]
    --             rewardInfo.RewardTypeInfo = RewardTypeComm[v.RewardType[i]]
    --             rewardInfo.Num = v.Num[i]
    --             UIUtil.SetRewardInfo(rewardInfo,img,{IconBg=bg,numText = text})
    --             bg.material = mtrl
    --             frame.material = mtrl
    --             img.material = mtrl
    --             --LangUtil.BindText(transform:Find("RewardIcon/"..count.."/Num"), FontType.All_Number).text = UIUtil.ScientificCount(v.CurrencyAmount[i], 5)
    --         end
    --     --end
    -- end


    for i = 1, 3 do
        transform:Find("RewardIcon/"..i).gameObject:SetActive(i <= count)
    end
    transform:Find("RewardIcon/More").gameObject:SetActive(count > 3)
    transform:Find("RewardIcon/More"):GetComponent("Image").material = mtrl
    
    -- 6.倒计时
    local timeText = transform:Find("TimeText")
    if v.QuotaPeriod == 4 or v.QuotaPeriod == 6 then
        timeText.gameObject:SetActive(false)
    else
        timeText.gameObject:SetActive(true)
        local color = isGet and "<color=#ffffff>" or "<color=#fff2aa>"
        local timeTxt = LangUtil.BindText(transform:Find("TimeText"))
        if v.QuotaPeriod == 1 then -- 按天刷新
            local endTime = TimeUtil.NextZeroTime()
            local countDownData = {type = TimeType.One, text = timeTxt, endTime = endTime, callback = function ()
                timeTxt.text = color..timeTxt.text.."</color>"
            end}
            timeTxt.text = color..TimeUtil.BindTime(self.countDownId, v.Id, countDownData).."</color>"
        elseif v.QuotaPeriod == 5 then
            local countDownData = {type = TimeType.One, text = timeTxt, endTime = timeSlot.End, callback = function ()
                timeTxt.text = color..timeTxt.text.."</color>"
            end}
            timeTxt.text = color..TimeUtil.BindTime(self.countDownId, v.Id, countDownData).."</color>"
        elseif v.QuotaPeriod == 2 then
            -- TODO:按周、按月刷新
        elseif v.QuotaPeriod == 3 then
            
        end
    end
    
    -- 7.限购次数
    local limitNumTnf = transform:Find("LimitNum")
    limitNumTnf.gameObject:SetActive(v.QuotaNum > 0)
    if v.QuotaNum > 0 then
        local limitNum = LangUtil.GetSysLang(461)..":"..(v.QuotaNum - quotaCount).."/"..v.QuotaNum..LangUtil.GetSysLang(3112)
        LangUtil.BindText(transform:Find("LimitNum")).text = isGet and "<color=#ffffff>"..limitNum.."</color>" or "<color=#676F7E>"..limitNum.."</color>"
    end
    
    -- 价格  购买  Get
    local money = ""
    local currencyType = ChannelManager:GetInstance():GetCurrencyType()
    if currencyType == ChannelCurrency.JA then
        money = "￥"..v.Price
    elseif currencyType == ChannelCurrency.US then
        money = "$"..v.Dollar
    end
    LangUtil.BindText(transform:Find("PriceText"), FontType.All_Number).text = isGet and "<color=#ffffff>"..money.."</color>" or "<color=#FFF2AA>"..money.."</color>"
    transform:Find("IsGet").gameObject:SetActive(isGet)
end

local function OnTabBtnClick(self, tab1)
    self.tabBtn1.transform:Find("Image").gameObject:SetActive(tab1)
    self.scroll1:SetActive(tab1)
    self.tabBtn2.transform:Find("Image").gameObject:SetActive(not tab1)
    self.scroll2:SetActive(not tab1)
end

function this.OnCreate(self)
    base.OnCreate(self);

    local backBtn = self.rc:GetObject("BackButton")
    self.content = self.rc:GetObject("Content").transform
    self.giftContent = self.rc:GetObject("GiftContent").transform
    local npIcon = self.rc:GetObject("NpcIcon"):GetComponent("Image")
    self.toolTip = self.rc:GetObject("toolTip")
    self.toolTip:SetActive(false)
    self.Eventbut = self.rc:GetObject("Eventbut")
    self.CloseButton = self.rc:GetObject("CloseButton")
    self.TipContent = self.rc:GetObject("TipContent")
    self.BuyBtn=self.rc:GetObject("BuyBtn")
    self.tabBtn1 = self.rc:GetObject("TabBtn1")
    self.tabBtn2 = self.rc:GetObject("TabBtn2")
    self.scroll1 = self.rc:GetObject("Scroll View1")
    self.scroll2 = self.rc:GetObject("Scroll View2")
    self.ShopList={}
    self.ContentList={}
    for i = 0, self.TipContent.transform.childCount -1 do
        self.ContentList[i+1]=self.TipContent.transform:GetChild(i)
    end
    self.scroll1:SetActive(false)
    self.scroll2:SetActive(false)

    UIUtil.AddBtnEvent(self.tabBtn1, function() OnTabBtnClick(self,true) end)
    UIUtil.AddBtnEvent(self.tabBtn2, function() OnTabBtnClick(self,false) end)
    
    UIUtil.AddBtnEvent(self.Eventbut, function() CloseToolTip(self) end)
    UIUtil.AddBtnEvent(self.CloseButton, function() CloseToolTip(self) end)
    
    self.face = UILandlady.New(npIcon, 1001, self.rc:GetObject("Lines"))
    UIUtil.AddBtnEvent(backBtn,function() UIManager:GetInstance():CloseWindow(UIWindowNames.UIStarLightStoneShop)  end,"Back")
    self.UIGreyMat = ResourcesManager:GetInstance():CoLoadAsync("UI/Materials/UI-GreyDefault.mat", typeof(Material))

    -- local node = Game.Scene:GetComponent("HintComponent").Shop:GetChild("GiftShop")
    -- node:AddObject(self.rc:GetObject("Tab2Hint"), "UIStarLight")
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.rc:GetObject("Text")).text = LangUtil.GetSysLang(750)
    self.titleText = LangUtil.BindText(self.rc:GetObject("titleText"))
    self.BuyText = LangUtil.BindText(self.rc:GetObject("BuyBtnText"))
    LangUtil.BindText(self.tabBtn1.transform:Find("Text")).text = LangUtil.GetSysLang(3110)
    LangUtil.BindText(self.tabBtn2.transform:Find("Text")).text = LangUtil.GetSysLang(3111)
    for i = 1, #self.ContentList do
        LangUtil.BindText(self.ContentList[i].transform:Find("Item/Num"))
        LangUtil.BindText(self.ContentList[i].transform:Find("NameTextRoot/NameTxt"))
    end
end

local function OnStarLightInfoChg(self)
    for i, v in pairs(self.ShopList) do
        local transform = v.transform
        local config = Z_StarLightStoneShop[i]
        local quotaCount = Game.Scene.Player:GetComponent("StarLightRebateComponent"):GetQuotaCount(config.Id)
        if config.Type == 1 or config.Type == 2 then
            self:Item(config, transform, quotaCount)
        elseif config.Type == 3 then
            self:GiftItem(config, transform, quotaCount)
        end
    end
end

function this.OnRefresh(self)
    self.content.transform:DOLocalMoveY(0,0)
    self.giftContent.transform:DOLocalMoveY(0,0)
    local type = 1
    if self.model.typeName ~= nil then
        type = tonumber(self.model.typeName)
    end
    OnTabBtnClick(self,type == 1)
    Game.Scene.Player:GetComponent("StarLightRebateComponent"):ActiveIsOpen()
    InitContent(self, type == 1)
end

function this.OnEnable(self)
    base.OnEnable(self)

    self.countDownId = TimeUtil.GetCountDownId()
    self:OnRefresh()
    
    -- 看板娘
    if self.model.face ~= nil then
        self.face:BindPlay(self.model.face) 
    else
        self.face:CoPlay()
    end

    -- 从其他界面进入
   -- if self.model.modeType ~= 1 then
    --    coroutine.start(function()
    --        Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI, "Store")
    --    end)
   -- end
end

function this.OnDisable(self)
    base.OnDisable(self)
    TimeUtil.RemoveCountDown(self.countDownId)
    if not IsNull(self.plus) then
        self.plus:SetActive(true)
    end
    ListChildPool:GetInstance():ClearContent(self.content)
    ListChildPool:GetInstance():ClearContent(self.giftContent)
    self.ShopList = {}
    self.face:Disable()
    
    -- 回到其他界面
    --if self.model.modeType ~= 1 then
    --    coroutine.start(function()
    --        coroutine.waitforframes(3)
    --        Game.Scene:GetComponent("BgmComponent"):CoPlay(BgmType.UI,"Home")
    --    end)
    --end
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddUIListener(UIMessageNames.ON_STAR_LIGHT_INFO_CHG, OnStarLightInfoChg)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveUIListener(UIMessageNames.ON_STAR_LIGHT_INFO_CHG)
end

function this.OnViewTop(self)
    base.OnViewTop(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIComTop)
    local view = UIManager:GetInstance():GetWindow(UIWindowNames.UIComTop).View
    self.plus = view.plus
    self.plus:SetActive(false)
end

function this.OnDisViewTop(self)
    base.OnDisViewTop(self)
    UIManager:GetInstance():CloseWindow(UIWindowNames.UIComTop)
end

return this

