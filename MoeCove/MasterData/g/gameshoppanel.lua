---@class GameShopPanel : GameShopPanel_Generate
---##################### 【GameShopPanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【GameShopPanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local GameShopPanel = require "GameShopPanel_Generate"

local ScrollItemView = require "GameShopPanel_ScrollItemView"

---@class GameShopPanel_MenuObj:UIObj
---@field ui GameShopPanel
local MenuObj = class("GameShopPanel_MenuObj", UIObj)
function MenuObj:Initialize()
    UIObj.Initialize(self)
    self.tagText = self:GetChildCompon("tagText", TypeInfo.TextMeshProUGUI)
    self.iconImg = self:GetChildCompon("iconImg", TypeInfo.Image)

    self.toggle = self.transform:GetComponent(TypeInfo.Toggle)
    self.toggle.onValueChanged:AddListener(BindCallback(self, self.OnTogglValueChange))
end

function MenuObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= 0)
    if data == 0 then
        return
    end
    local cfg = Config.GetShopListInfo(data)
    if cfg == nil then
        return
    end

	local iconPath = string.format(Config.SpritePath.GameShopTypeIcon, data)	

    self.ui:LoadSpriteAsync(iconPath, self.iconImg)
    self.tagText.text = cfg.shopName
end
function MenuObj:Select()
    self.breakEvent = true
    self.toggle.isOn = true
    self.breakEvent = nil
end

function MenuObj:OnTogglValueChange(isOn)
   
    if not isOn then
        return    
    end
    if self.breakEvent == true then
       return 
    end
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    self.ui:SelectMenu(self.data)
end

---@class RecommendItemObj:UIObj
---@field ui GameShopPanel
---@field data ShopRecommendTable
local RecommendItemObj = class("GameShopPanel_RecommendItemObj", UIObj)
function RecommendItemObj:Initialize()
    UIObj.Initialize(self)
    self.image = self.transform:GetComponent(TypeInfo.Image)
    self.valText = self.transform:Find("valText"):GetComponent(TypeInfo.TextMeshProUGUI)

    local el = EventTriggerListener.Get(self.gameObject)
    el.onClick = BindCallback(self, self.OnClick)
end

function RecommendItemObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= nil)
    if data == nil then
        return
    end

    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.GameShopRecommendIcon, self.data.id), self.image)
    self.valText.text = ""
end

function RecommendItemObj:OnClick(obj)
    local sv = self.ui.scrollItemView
    if sv.isDraging or sv.isMoveing then
        return
    end
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local trunToId = self.data.turnTo
    UICommonUtils.CommonTurnTo(trunToId, self.ui)
end

---@class GameShopPanel_GoodsObj:UIObj
---@field ui GameShopPanel
---@field data integer
local GoodsObj = class("GameShopPanel_GoodsObj", UIObj)
function GoodsObj:Initialize()

    UIObj.Initialize(self)
    ---@type GameShopPanel_Generate_shopItemPrefab
    local peer = self
    peer.content.scaleButton.onClick:AddListener(function()
        self:OnClick()
    end)
    peer.buyBtn.scaleButton.onClick:AddListener(function()
        self:OnClick()
    end)
end

---设置数据
---@param data integer
function GoodsObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= 0)
    if data == 0 then
        return
    end

    local cfg = Config.GetShopMerchandiseInfo(data)
    if cfg == nil then    
        return
    end

    ---@type GameShopPanel_Generate_shopItemPrefab
    local peer = self
    local name, desc, icon, quality = Me:GetGoodsItemDisplayInifo(data)

    self.ui:LoadSpriteAsync(icon, peer.iconImg.image)

    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.GameShopQualityIcon, quality), peer.quaityImg.image)
    peer.nameText.text.text = name

    local isGift = #cfg.content > 1
    if not isGift then
        peer.numText.text.text = "x" .. tostring(cfg.content[1][3])
    else
        peer.numText.text.text = ""
    end

    --判断是否限购
    local curBuyCount,  maxBuyCount, limitType = Me:GetGoodLimitCount(self.data)
    peer.discountInfo:SetActive(maxBuyCount ~= 0)
    peer.limitInfo:SetActive(limitType ~= GE.ShopLimitType.None)
    peer.refreshInfo:SetActive(limitType ~= GE.ShopLimitType.None)

    self.sellout = false
    if limitType ~= GE.ShopLimitType.None then
        local s = LocalStrEnum.Shop_LimitCount
        peer.limitText.text.text = string.format("%s：%d/%d", s, curBuyCount, maxBuyCount)
        peer.selloutView:SetActive(curBuyCount <= 0)
        local str =  LocalStrEnum["Shop_RefreshType_" .. limitType]
        if not string.isNullOrEmpty(str) then
            peer.refreshText.text.text = str .. LocalStrEnum.Shop_RefreshString
        else
            peer.refreshInfo:SetActive(false)
        end
        self.sellout = curBuyCount <= 0
    else
        peer.selloutView:SetActive(false)
    end
    --限购
    local isunlock = Me:CheckGoodsUnlock(data)
    peer.lockView:SetActive(not isunlock)
    if not isunlock then
        peer.lockText.text.text = cfg.limitConDesc
    end
  
    local picId, picNum, picRate = Me:GetShopItemPic(data)
    local picItemCfg = Config.GetItemInfo(picId)

    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, picItemCfg.icon), peer.picIcon.image)
    peer.picText.text.text = tostring(picNum)

    peer.discountInfo:SetActive(picRate ~= 0)
    if picRate ~= 0 then
        local r = tostring(picRate)
        --写入超值折扣
        local result = ""
        for i = 1, #r do
            local char = r:sub(i, i)
            local spriteIndex = tonumber(char)
            -- 只处理已映射的字符
            if spriteIndex then
                result = result .. string.format("<sprite=%d>", char)
            end
        end
        peer.discountText.text.text = result
    end

    --写入限时
    self.limitTimeInfo:SetActive(cfg.merchandiseClose ~= 0)

    local lastTime = 0
    local nowTime = Me:GetServerTime()
    if cfg.merchandiseClose ~= 0 then
        lastTime = cfg.merchandiseClose - nowTime
    end

    if lastTime > 0 then
        local c = lastTime
        local ds = 24 * 60 * 60
        local hs = 60 * 60
        if c > ds then
            local day = math.floor(c / ds)
            local h = math.floor((c % ds) / hs)
            peer.limitTimeText.text.text = string.format(LocalStrEnum.merchandiseRemainTime_Day, day, h)
        elseif c > 60 then
            local h = math.floor(c / hs)
            local m = math.floor((c % hs) / 60)
            peer.limitTimeText.text.text = string.format(LocalStrEnum.merchandiseRemainTime_Hour, h, m)
        else 
            peer.limitTimeText.text = LocalStrEnum.merchandiseRemainTime_Min
        end
    end
end

function GoodsObj:OnClick()
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    local isUnLock, type = Me:CheckGoodsUnlock(self.data)
    if not isUnLock then
        if type == 2 then
            local cfg = Config.GetShopMerchandiseInfo(self.data)
            UICommonUtils.PopToast(cfg.limitConDesc)
        elseif type == 1 then
            self.ui:SelectMenu(self.ui.curShopType)
        end
        return 
    end

    if self.sellout then
        UICommonUtils.PopToast(LocalStrEnum.merchandiseBuyTip_2)
        return
    end
    self.ui:OnClickGoodItem(self.data)
end

---播放動畫
---@param sortIndex integer 播放順序
function GoodsObj:PlayAnima(sortIndex)
    ---@type GameShopPanel_Generate_shopItemPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    rTrs.anchoredPosition = Vector2.New(0, -40)
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
    rTrs:DOKill()
    canvasGroup:DOKill()
    rTrs:DOAnchorPosY(0, 0.2):SetDelay((sortIndex-1)*0.05)
    canvasGroup:DOFade(1, 0.2):SetDelay((sortIndex-1)*0.05)
end

---播放動畫
function GoodsObj:KillAnima()
    ---@type GameShopPanel_Generate_shopItemPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    local canvasGroup = peer.content.canvasGroup
    rTrs:DOKill()
    canvasGroup:DOKill()
end

function GoodsObj:HideAnima()
  ---@type GameShopPanel_Generate_shopItemPrefab
    local peer = self
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
end

function GoodsObj:Destroy()
    ---@type GameShopPanel_Generate_shopItemPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    local canvasGroup = peer.content.canvasGroup
    rTrs:DOKill()
    canvasGroup:DOKill()
end

---@class GameShopPanel_RechargeItemObj:UIObj
---@field ui GameShopPanel
---@field data GiftTable
local RechargeItemObj = class("GameShopPanel_RechargeItemObj", UIObj)

function RechargeItemObj:Initialize()
    UIObj.Initialize(self)
    ---@type GameShopPanel_Generate_rechargeItemPrefab
    local peer = self
    peer.content.scaleButton.onClick:AddListener(function()
        self:OnClick()
    end)

end
---设置数据
---@param data GiftTable
function RechargeItemObj:SetData(data)
    UIObj.SetData(self, data)
    self.gameObject:SetActive(data ~= nil)
    if data == nil then
        return
    end
    local bgName = "1"
    if data.Cost >= 648 then
        bgName = "2"
    end
    
    ---@type GameShopPanel_Generate_rechargeItemPrefab
    local peer = self
    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.GameShopRechargeBgIcon, bgName), peer.bgImage.image)

    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.shopItem, data.Icon), peer.iconImg.image)
    local itemId = data.Items_get[1][2]
    local itemCount = data.Items_get[1][3]
    local itemCfg = Config.GetItemInfo(itemId)

    self.ui:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, itemCfg.icon), peer.itemIcon.image)
    peer.itemNum.text.text = "x" .. tostring(itemCount)

    local serverInfo = Me:GetRechargeItemInfo(data.id)
    local isFirst =  (serverInfo == nil) or serverInfo.buyTimes <= 0
    
    peer.firstTimeInfo:SetActive(isFirst)
    if isFirst then
        local itemId = data.First_Award[1][2]
        local itemCount = data.First_Award[1][3]
        local itemCfg = Config.GetItemInfo(itemId)  

        self.ui:LoadSpriteAsync(string.format(Config.SpritePath.ItemIconPathSmall, itemCfg.icon), peer.firstItemIconImg.image)
        peer.firsItemNumText.text.text = "x" .. tostring(itemCount)
    end
    local cost = UICommonUtils.GetGiftPriceById(data.id)
    peer.picText.text.text = string.format("￥%s", cost)
end
function RechargeItemObj:OnClick()
    UICommonUtils.PlayClickSound(GE.ClickSoundType.Click)
    UICommonUtils.Pay(self.data.id, function()
        self:SetData(self.data)
    end)
end

---播放動畫
---@param sortIndex integer 播放順序
function RechargeItemObj:PlayAnima(sortIndex)
    ---@type GameShopPanel_Generate_rechargeItemPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    rTrs.anchoredPosition = Vector2.New(40, 0)
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
    rTrs:DOKill()
    canvasGroup:DOKill()
    rTrs:DOAnchorPosX(0, 0.2):SetDelay((sortIndex-1)*0.05)
    canvasGroup:DOFade(1, 0.2):SetDelay((sortIndex-1)*0.05)
end

---播放動畫
function RechargeItemObj:KillAnima()
    ---@type GameShopPanel_Generate_rechargeItemPrefab
    local peer = self
    local rTrs = peer.content.rectTransform
    rTrs.anchoredPosition = Vector2.New(40, 0)
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
    rTrs:DOKill()
    canvasGroup:DOKill()
end

---播放動畫
function RechargeItemObj:HideAnima()
    ---@type GameShopPanel_Generate_rechargeItemPrefab
    local peer = self
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
end

function RechargeItemObj:Destroy()
    ---@type GameShopPanel_Generate_rechargeItemPrefab
    local peer = self
    local canvasGroup = peer.content.canvasGroup
    canvasGroup.alpha = 0
end

function GameShopPanel:InitLogic(data)

   self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.RefresShopDataMsg, self.RefresShopDataMsg},
        {GameMsgType.Shop_BuyGoodsMsg, self.RecvBuyGoodsMsg},
        {GameMsgType.Shop_CycleCardActivityUpdate, self.RecvCycleCardActivity},
    }

    self.autoRoot.autoAdjustCanvasRoot:ResetPadding()
    self.menuListToggle:SetActive(false)

    ---菜单列表
    ---@type GameShopPanel_MenuObj[]
    self.menuListObjs = {}
    ---当前选中页签id
    self.curShopMenuId = 0
    self.cardMenu.gameShopPanel_CardMenu:SetParentUI(self)
    self.heroSkinMenu.gameShopPanel_HeroSkinMenu:SetParentUI(self)
    self.menuMap = {
        [20001] = self.recommendMenu,
        [20003] = self.rechargeMenu,
        [20005] = self.cardMenu.gameObject,
        [20006] = self.heroSkinMenu.gameObject,
    }
end

function GameShopPanel:OnOpen(data, initiative)
    if self.spineObject == nil then
        local resPath = Config.PrefabPath.RoleSpine
        local spineName = "Role_10000"
        local prefabPath = string.format(resPath, spineName, spineName)

        self:LoadGameObjectAsync(prefabPath, function (obj)
            local spineObject = obj
            spineObject:SetParent(self.spineRoot.rectTransform)
            self.spineObject = spineObject

            --动作轨道配置可能会修改动画播放速度
            local objSpine = spineObject:GetComponent("SkeletonGraphic")
        
            --剧情关闭spine物理效果
            objSpine.PhysicsPositionInheritanceFactor = Vector2.zero
            --获取动画状态
            local objSpineAnim = spineObject:GetComponent("SkeletonAnimation")
            local animationState = objSpineAnim.AnimationState
            animationState:SetAnimation(GE.RoleSpineActionType.Action, "idle_action", true)

            self:PlayRecommendSpineAnima()
        end)
    end

    --导航栏
    self.customBackPanel.customBackPanel:Bind(GE.NavigationType.GameShopPanel)
    ---接管返回方法

    local shopGroupType = GE.ShopGroupType.type2
    ---初始化页签
    local menuList = Me:GetShopMenuList(shopGroupType)
    for i = 1, #menuList do
        local menuObj = self.menuListObjs[i]
        if menuObj == nil then
            local obj = EngineUtil.Instantiate(self.menuListToggle)
            ---@type GameShopPanel_MenuObj
            menuObj = MenuObj:Create(obj, self)
            table.insert(self.menuListObjs, menuObj)
        end
        menuObj:SetData(menuList[i])
    end

    local shopType = 0
    local childParam = nil
    if data ~= nil then
        if type(data) == "number" then
            shopType = data
        else
            shopType = data[1]
            childParam = data[2]
        end
        local index = tablex.indexof(menuList,shopType)
        if index < 0 then
            shopType = 0
        end
    end
    self.curShopMenuId = 0
    if shopType == 0 then
        shopType = menuList[1]
    end
    
    for i = 1, #self.menuListObjs do
        local listObj = self.menuListObjs[i]
        if listObj.data == shopType then
            listObj:Select()
            break
        end
    end
    self:SelectMenu(shopType, childParam)
    if initiative then
        CoveManager.instance():SetHomelandActive(false)  
    end

end

local lastUpdateTime = 0
function GameShopPanel:Update()
    if self.curShopMenuId == 20001 then     --推荐页
        if Time.time - lastUpdateTime >= 5  then
            if self.scrollItemView.isMoveing or self.scrollItemView.isDraging then
            else
                self.scrollItemView:MoveToNext()
            end
            lastUpdateTime = Time.time
        end
    end

end

function GameShopPanel:OnClose(initiative)
    if initiative then
        self.curShopMenuId = 0
        self.heroSkinMenu.gameShopPanel_HeroSkinMenu:Close()
    end

    if initiative then
        CoveManager.instance():SetHomelandActive(false)
    end

end

--function GameShopPanel:OnRefresh(data)
--
--end

function GameShopPanel:OnScrollGoodsItemClick(index)
    
end

function GameShopPanel:SelectMenu(shopMenuId, param)
    --导航栏
    --是否可以刷新
    if self.curShopMenuId == shopMenuId then
       return 
    end
    local shopCfg = Config.GetShopListInfo(shopMenuId)
    if shopCfg == nil then
        return
    end

    self.customBackPanel.customBackPanel:OverrideSpecificRes(shopCfg.costType)
    local hasMatch = false
    for id, menu in pairs(self.menuMap) do
        local isShow = (shopMenuId == id)
        menu:SetActive(isShow)
        if isShow then 
            hasMatch = true 
        end
    end
    self.goodsMenu:SetActive(not hasMatch)

    local lastMenuId = self.curShopMenuId
    if lastMenuId == 20006 and shopMenuId ~= 20006 then
        self.heroSkinMenu.gameShopPanel_HeroSkinMenu:Close()
    end

    self.curShopMenuId = shopMenuId
    if shopMenuId == 20001 then
        self:ShowRecommendMenu()
    elseif shopMenuId == 20003 then
        self:ShowRechargeMenu()
    elseif shopMenuId == 20005 then
        self.cardMenu.gameShopPanel_CardMenu:Show(param)
    elseif shopMenuId == 20006 then
        self.heroSkinMenu.gameShopPanel_HeroSkinMenu:ShowItem()
    else
        self:ShowGoodsMenuMenu(shopMenuId)
    end
end

function GameShopPanel:ShowRecommendMenu()
    if not self.recommendInit then
        ---@type RecommendItemObj
        self.recommendItem_1Obj = RecommendItemObj:Create(self.recommendItem_1, self)

        ---@type RecommendItemObj
        self.recommendItem_2Obj = RecommendItemObj:Create(self.recommendItem_2, self)

        ---@type RecommendItemObj[]
        self.recommendItemObjs = {}

        ---@type ScrollItemView
        self.scrollItemView = ScrollItemView:new(self.scrollShopView, BindCallback(self, self.OnScrollGoodsItemChange))
        
        self.scrollItemView.onMoveFinish = BindCallback(self, self.onScrollItemMoveFinished)

        self.recommendInit = true
    end

    local allConfig = Config.GetAllConfig("ShopRecommendTable")

    ---@type ShopRecommendTable[]
    local scrollItemData = {}
    for k, v in pairs(allConfig) do
        if v.shopType == 1 then
            table.insert(scrollItemData, v)
        elseif v.shopType == 2 then
            self.recommendItem_1Obj:SetData(v)
        elseif v.shopType == 3 then
            self.recommendItem_2Obj:SetData(v)
        end
    end
    table.sort(scrollItemData, function(a, b)
        if a == nil then
            return false
        end
        if b == nil then
            return true
        end
        return a.order < b.order
    end)
    self.scrollItemData = scrollItemData
    self.scrollItemView:SetDataCount(#scrollItemData)

    lastUpdateTime = Time.time

    --播放推荐界面动画
    self:PlayRecommendSpineAnima()
end

function GameShopPanel:PlayRecommendSpineAnima()
    local spineObject = self.spineObject
    if spineObject == nil then
        return
    end
    if not self.recommendInit then
        return    
    end

    ---@type SkeletonGraphicRenderTexture_Custom
    local myRT = spineObject:GetComponent("SkeletonGraphicRenderTexture_Custom")
    ---@type UnityEngine.RectTransform
    local rTrs = myRT.transform

    rTrs.anchoredPosition = Vector2.New(80, 0)
    myRT.enabled = true
    myRT.color = Color.New(1,1,1,0)

    if self.seq ~= nil then
       self.seq:Kill() 
    end
    local seq = DOTween.Sequence()
    --seq:AppendInterval(1)
    seq:Append(rTrs:DOAnchorPosX(0, 0.2))
    seq:Join(myRT:DOFade(1, 0.2))
    seq:AppendCallback(function()
        myRT.enabled = false
        self.seq = nil
    end)

    local rTrss = {
        self.scrollShopView.transform,
        self.recommendItem_1Obj.transform,
        self.recommendItem_2Obj.transform,
    }
    for i = 1, #rTrss do
        local rTrs = rTrss[i]
        rTrs:DOKill()
        rTrs.localScale = Vector3.one * 0.9
        rTrs:DOScale(1, 0.2):SetDelay((i-1)* 0.05)
    end
    self.seq = seq
end

function GameShopPanel:OnScrollGoodsItemChange(obj, index)
    ---@type RecommendItemObj?
    local itemObj = nil
    for i = 1, #self.recommendItemObjs do
        local gObj = self.recommendItemObjs[i]
        if gObj.gameObject == obj then
            itemObj = gObj
            break
        end
    end
    if itemObj == nil then
        itemObj = RecommendItemObj:Create(obj, self)
        table.insert(self.recommendItemObjs, itemObj)
    end
    local data = self.scrollItemData[index]
    data = data or nil
    itemObj:SetData(data)
end

function GameShopPanel:onScrollItemMoveFinished()
    lastUpdateTime = Time.time
end

function GameShopPanel:ShowRechargeMenu()
    if not self.rechargeInit then
        ---@type GameShopPanel_RechargeItemObj[]
        self.rechargeItemObjs = {}
        self.rechargeItemScrollRect.loopListView2:InitListView(0, BindSelf(self, self.OnRechargeItemValueChange))
        self.rechargeInit = true
    end
    local datas = Me:GetRechargeItemList()
    self.rechargeItemDatas = datas

    for i = 1, #self.rechargeItemObjs do
        local gObj = self.rechargeItemObjs[i]
        gObj:KillAnima()
    end
    self.waitPlayEffect = true
    self.rechargeItemScrollRect.loopListView2:SetListItemCount(0, false)
    self.rechargeItemScrollRect.loopListView2:SetListItemCount(#self.rechargeItemDatas, true)

    TimeMgr:AddWaitTimeExecute(2, function()
        self.waitPlayEffect = false 
        ---播放充值界面動畫
        for i = 1, #self.rechargeItemDatas do
            ---@type GameShopPanel_RechargeItemObj
            local gObj = nil
            for j = 1, #self.rechargeItemObjs do
                local temp = self.rechargeItemObjs[j]
                if temp.data == self.rechargeItemDatas[i] and temp.gameObject.activeSelf then
                    gObj = temp
                    break
                end
            end
            if gObj ~= nil then
                gObj:PlayAnima(i)
            end
        end
    end, self, true)

end

---更新充值滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopListView2
---@param index integer
---@param row integer
---@param col integer
function GameShopPanel:OnRechargeItemValueChange(gridView, index, row, col)

    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("rechargeItemPrefab")
    end
    local obj = loopItem.gameObject

    ---@type GameShopPanel_RechargeItemObj
    local itemObj = nil
    for i = 1, #self.rechargeItemObjs do
        local rObj = self.rechargeItemObjs[i]
        if rObj.gameObject == obj then
            itemObj = rObj
            break
        end
    end
    if itemObj == nil then
        itemObj = RechargeItemObj:Create(obj, self, self.rechargeItemPrefab)
        table.insert(self.rechargeItemObjs, itemObj)
    end
    local data = self.rechargeItemDatas[index + 1]
    data = data or nil
    itemObj:SetData(data)
    if self.waitPlayEffect then
        itemObj:HideAnima()
    end

    return loopItem
end

--------------------------

function GameShopPanel:ShowGoodsMenuMenu(shopMenuId)
    if not self.goodsInit then
        ---@type GameShopPanel_GoodsObj[]
        self.goodsObjs = {}
        self.shopList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.OnItemValueChange))
        UICommonUtils.CalculateColumnCount(self.shopList.loopGridView)
        self.goodsInit = true
    end
    local goodsDatas = Me:GetShopItemList(shopMenuId)
    self.goodsDatas = goodsDatas

    for i = 1, #self.goodsObjs do
        local gObj = self.goodsObjs[i]
        gObj:KillAnima()
    end
    self.waitPlayEffect = true
    self.shopList.loopGridView:SetListItemCount(0, false)
    self.shopList.loopGridView:SetListItemCount(#self.goodsDatas, true)

    TimeMgr:AddWaitTimeExecute(2, function()
        self.waitPlayEffect = false
         ---播放动画
        for i = 1, #self.goodsDatas do
            ---@type HomelandShopPanel_GoodsObj
            local gObj = nil
            for j = 1, #self.goodsObjs do
                local temp = self.goodsObjs[j]
                if temp.data == self.goodsDatas[i] and temp.gameObject.activeSelf then
                    gObj = temp
                    break
                end
            end
            if gObj ~= nil then
                gObj:PlayAnima(i)
            end
        end
    end, self, true)
   
end

---更新滑动列表
---@param index integer 数据索引
---@param gridView SuperScrollView.LoopGridView
---@param index integer
---@param row integer
---@param col integer
function GameShopPanel:OnItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("shopItemPrefab")
    end
    local obj = loopItem.gameObject

    ---@type GameShopPanel_GoodsObj
    local goodsObj = nil
    for i = 1, #self.goodsObjs do
        local gObj = self.goodsObjs[i]
        if gObj.gameObject == obj then
            goodsObj = gObj
            break
        end
    end
    if goodsObj == nil then
        goodsObj = GoodsObj:Create(obj, self, self.shopItemPrefab)
        table.insert(self.goodsObjs, goodsObj)
    end
    local data = self.goodsDatas[index + 1]
    data = data or 0
    goodsObj:SetData(data)
    if self.waitPlayEffect then
        goodsObj:HideAnima()
    end

    return loopItem
end

function GameShopPanel:OnClickGoodItem(goodsId)
    local data = goodsId
    UIMgr:popUICover("GoodsItemPanel", {goodsId = data, specificResList = self.customBackPanel.customBackPanel._specificResList})
end

-----返回消息

---购买商品返回
---@param goodsId integer
---@param buyNum integer
---@param ret integer
function GameShopPanel:RecvBuyGoodsMsg(goodsId, buyNum, ret)

    --if self.goodsMenu
    local shopMenuId = self.curShopMenuId
    if shopMenuId == 20001 then
        local tab = {
            self.recommendItem_1Obj, self.recommendItem_2Obj
        }
        for i = 1, #tab do
            local goodsObj = tab[i]
            if goodsObj ~= nil and goodsObj.data == goodsId then
                goodsObj:SetData(goodsId)
                return
            end
        end
    elseif shopMenuId == 20003 then
        
        for i = 1, #self.rechargeItemObjs do
            local goodsObj = self.rechargeItemObjs[i]
            if goodsObj.data ~= nil and goodsObj.data.id == goodsId then
                goodsObj:SetData(goodsObj.data)
                return
            end
        end
    elseif shopMenuId == 20005 then
        self.cardMenu.gameShopPanel_CardMenu:RefreshItem(goodsId)
    elseif shopMenuId == 20006 then
        self.heroSkinMenu.gameShopPanel_HeroSkinMenu:RefreshItem(goodsId)
    else
        for i = 1, #self.goodsObjs do
            local goodsObj = self.goodsObjs[i]
            if goodsObj.data ~= nil and goodsObj.data == goodsId then
                goodsObj:SetData(goodsId)
                return
            end
        end
    end
end

---购买商品返回
---@param goodsId integer
---@param buyNum integer
---@param ret integer
function GameShopPanel:RecvCycleCardActivity()
    self.cardMenu.gameShopPanel_CardMenu:Show()
end

---刷新商店信息
function GameShopPanel:RefresShopDataMsg()
    --self:SelectMenu(self.curShopMenuId)
end

--[[
/autoRoot/cardMenu/cardTypeToggleGroup/monthToggle onValueChanged 
--]]
function GameShopPanel:monthToggle_Toggle_onValueChanged(monthToggle,isOn)

end

--[[
/autoRoot/cardMenu/cardTypeToggleGroup/weekToggle onValueChanged 
--]]
function GameShopPanel:weekToggle_Toggle_onValueChanged(weekToggle,isOn)

end

--[[
/autoRoot/cardMenu/monthCardMenu/buyBtn onClick 
--]]
function GameShopPanel:buyBtn_ScaleButton_onClick(buyBtn)

end

function GameShopPanel:OnDestroy()
	if self.goodsObjs ~= nil then
        for i = 1, #self.goodsObjs do
            local gObj = self.goodsObjs[i]
            gObj:Destroy()
        end
        self.goodsObjs = nil
    end

    if self.rechargeItemObjs ~= nil then
        for i = 1, #self.rechargeItemObjs do
            local gObj = self.rechargeItemObjs[i]
            gObj:Destroy()
        end
        self.rechargeItemObjs = nil
    end
end

return GameShopPanel
