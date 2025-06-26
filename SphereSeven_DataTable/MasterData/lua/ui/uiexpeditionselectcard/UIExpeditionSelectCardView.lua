local UIExpeditionSelectCardView = BaseClass("UIExpeditionSelectCardView",UIBaseView);
local base = UIBaseView
local this = UIExpeditionSelectCardView
local prefabName = "CardItemExpedition"

local SortType = {["Rare"] = 1,["Lv"] = 2,["Opinion"] = 3}

local function OnSetExpeditationCardInfo(self)
    local tab = self.expeditionComponent:GetSelectCardData()
    self.expeditionComponent:SetExpeditationCardInfo(tab)
end

local function OnClickItemButton(self,cardInfo,go)
    local currData = {}
    currData.TemplateId = cardInfo.TemplateId
    currData.Star = cardInfo.Star
    currData.Level = cardInfo.Level
    currData.Id = cardInfo.Id
    currData.CloseDegree = cardInfo.CloseDegree
    local key = self.expeditionComponent:GetSelectItem()
    local currKeyData = self.expeditionComponent:GetSelectCardData(key)
    local alreadlySelectCount = #currKeyData + #self.model.currNewData
    if alreadlySelectCount >= 4 then
        UIUtil.ToolTipFourth("坑位已满bro,开干吧！")
        return
    else
        LangUtil.BindText(self.textSelectNum).text = string.format(LangUtil.GetSysLang(4124),alreadlySelectCount + 1)
        table.insert(self.model.currNewData,currData)
        if go then
            local selectMask = go.transform:Find("CardInfo/SelectMask").gameObject
            selectMask:SetActive(true)
            go.transform:GetComponent("Button").enabled = false
        end
    end
end

function this.InitCardListData(self)
    self.list = {}
    -- 战队卡牌 移除
    for k,v in table.pairsByKeys(self.cards) do
        if UIData.GetCardTeamNo(v.Id) == nil  then
            table.insert(self.list,v)
        end
    end
    -- 当前item，已选定不清除
    local key = self.expeditionComponent:GetSelectItem()
    local alreadlySelectCards = this.GetAllSelectCards(self)
    local currKeyData = self.expeditionComponent:GetSelectCardData(key)
    if #currKeyData > 0 and #alreadlySelectCards > 0 then
        for key, value in pairs(currKeyData) do
            for i = #alreadlySelectCards, 1, -1 do
                if alreadlySelectCards[i].Id == value.Id then
                    table.remove(alreadlySelectCards,i)
                end
            end
        end
    end
    -- 非当前item 有已经选定的移除
    if #alreadlySelectCards > 0 then
        for key, value in pairs(alreadlySelectCards) do
            for i = #self.list, 1, -1 do
                if self.list[i].Id == value.Id then
                    table.remove(self.list,i)
                end
            end
        end
    end
    this.OnSortCardByType(self,self.model.sortType)
end

function this.GetAllSelectCards(self)
    local allCards = {}
    local cardClientData = self.expeditionComponent:GetExpeditationCardInfo()
    for key, value_1 in pairs(cardClientData) do
        for pos, cardInfo in pairs(value_1) do
            table.insert(allCards,cardInfo)
        end
    end
    return allCards
end

function this.InitContent(self)  --刷新角色
    self.scroll:Clear()
    self.scroll:ScrollInit(self.list, self.scrollView, prefabName, function (arg)
        arg.go:SetActive(true)
        local transform = arg.go.transform
        local cardInfo = transform:Find("CardInfo").gameObject
        local isRoom = transform:Find("CardInfo/other/IsRoom").gameObject
        local isHome = transform:Find("CardInfo/other/IsHome").gameObject
        local isSupport = transform:Find("CardInfo/other/IsSupport").gameObject
        local TextBg = transform:Find("CardInfo/Text_bg").gameObject
        local selectMask = transform:Find("CardInfo/SelectMask").gameObject
        arg.go.transform:Find("CardInfo/TxtId").transform:GetComponent("Text").text = arg.data.Id
        cardInfo:SetActive(true)
        selectMask:SetActive(false)
        UIPublic.InitCardItemDataNew(arg.data, cardInfo)
        isRoom:SetActive(self.player.BedroomCardId == arg.data.Id)
        isHome:SetActive(self.player.MainUICardId == arg.data.Id)
        isSupport:SetActive(self.player.AidId == arg.data.Id)
        local teamNo = UIData.GetCardTeamNo(arg.data.Id)
        if teamNo ~= nil then
            LangUtil.BindText(TextBg.transform:Find("Text")).text = LangUtil.GetSysLang(831) .. teamNo
            TextBg:SetActive(true)
        else
            TextBg:SetActive(false)
        end
        if self.model.cardInit ~= nil then
            self.model.cardInit(arg.data, cardInfo.transform)
        end
        arg.go.transform:SetSiblingIndex(arg.index - 1)
        UIUtil.AddBtnEvent(arg.go,function(go)
            self.model.isAllChoicesButton = false
            self.model.isAllRemoveButton = false
            OnClickItemButton(self,arg.data,arg.go)
        end)
        local allSelectTab =  this.GetAllSelectCards(self)
        for key, value in pairs(allSelectTab) do
            if value.Id == arg.data.Id then
                selectMask:SetActive(true)
                arg.go.transform:GetComponent("Button").enabled = false
            end
        end
        local selectMaskTxt = selectMask.transform:Find("Text").gameObject
        LangUtil.BindText(selectMaskTxt)
    end)
end

function this.OnSortCardByType(self,type)
    if type == SortType.Rare then
        table.sort(self.list, function(a, b)
            a.rare = Z_Card[a.TemplateId].Rare
            b.rare = Z_Card[b.TemplateId].Rare
            if a.rare > b.rare then
                return a.rare > b.rare
            elseif a.rare == b.rare  then
                if a.Level > b.Level then
                    return a.Level > b.Level
                elseif a.Level == b.Level  then
                    return a.Id > b.Id
                end
            end
        end)
    elseif type == SortType.Lv then
        table.sort(self.list, function(a, b)
            if a.Level > b.Level then
                return a.Level > b.Level
            elseif a.Level == b.Level  then
                if a.rare > b.rare then
                    return a.rare > b.rare
                elseif a.rare == b.rare  then
                    return a.Id > b.Id
                end
            end
        end)
    elseif type == SortType.Opinion then
        table.sort(self.list, function(a, b)
            if a.CloseDegree > b.CloseDegree then
                return a.CloseDegree > b.CloseDegree
            elseif a.CloseDegree == b.CloseDegree  then
                if a.rare > b.rare then
                    return a.rare > b.rare
                elseif a.rare == b.rare  then
                    return a.Id > b.Id
                end
            end
        end)
    end
    self:InitContent()
end

function this.RemoveCardSelect(self)
    local itemContent = self.rc:GetObject("Content").transform
    for i = 0,itemContent.childCount - 1 do
        local mask = itemContent:GetChild(i).transform:Find("CardInfo/SelectMask").gameObject
        if mask.activeSelf then
            itemContent:GetChild(i).transform:Find("CardInfo/SelectMask").gameObject:SetActive(false)
            itemContent:GetChild(i).transform:GetComponent("Button").enabled = true
        end
    end
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.rc:GetObject("SortTypeButton").transform:Find("Text")).text =  LangUtil.GetSysLang(self.model.sortType + 4117)
    LangUtil.BindText(self.rc:GetObject("BackButton").transform:Find("Text")).text = LangUtil.GetSysLang(4117)
    LangUtil.BindText(self.rc:GetObject("AllChoicesButton").transform:Find("Text")).text =  LangUtil.GetSysLang(4121)
    LangUtil.BindText(self.rc:GetObject("AllRemoveButton").transform:Find("Text")).text =  LangUtil.GetSysLang(4122)
    LangUtil.BindText(self.rc:GetObject("RareButton").transform:Find("Text")).text =  LangUtil.GetSysLang(4118)
    LangUtil.BindText(self.rc:GetObject("LvButton").transform:Find("Text")).text =  LangUtil.GetSysLang(4119)
    LangUtil.BindText(self.rc:GetObject("OpinionButton").transform:Find("Text")).text =  LangUtil.GetSysLang(4120)
    LangUtil.BindText(self.rc:GetObject("DecideButton").transform:Find("Text")).text =  LangUtil.GetSysLang(4123)
    LangUtil.BindText(self.rc:GetObject("CancelButton").transform:Find("Text")).text =  LangUtil.GetSysLang(146)
end

function this.OnCreate(self)
    base.OnCreate(self);
    self.scroll = VerticalScroll.New()
    self.scroll:SetUpdateCount(5)
    self.vertical = self.rc:GetObject("Scrollbar Vertical")
    self.scrollView = self.rc:GetObject("Scroll View"):GetComponent("ScrollRect")
    self.handle = self.vertical.transform:Find("Sliding Area/Handle")
    local backBtn = self.rc:GetObject("BackButton");
    local allChoicesButton =  self.rc:GetObject("AllChoicesButton")
    local allRemoveButton =  self.rc:GetObject("AllRemoveButton")
    local sortTypeButton =  self.rc:GetObject("SortTypeButton")
    local sortTypeContent =  self.rc:GetObject("SortTypeContent")
    sortTypeContent.gameObject:SetActive(false)
    local rareButton =  self.rc:GetObject("RareButton")
    local lvButton =  self.rc:GetObject("LvButton")
    local opinionButton =  self.rc:GetObject("OpinionButton")
    local decideButton =  self.rc:GetObject("DecideButton")
    local cancelButton =  self.rc:GetObject("CancelButton")
    self.textSelectNum =  self.rc:GetObject("TextSelectNum")
    UIUtil.AddBtnEvent(backBtn,function(v)
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIExpeditionSelectCard)
    end)

    UIUtil.AddBtnEvent(allChoicesButton,function(v)
        self.model.isAllChoicesButton = true
        self.model.isAllRemoveButton = false
        self.model.currNewData = {}
        this.RemoveCardSelect(self)
        local keyItem = self.expeditionComponent:GetSelectItem()
        self.expeditionComponent:RemoveSelectCardData(keyItem)
        local itemContent = self.rc:GetObject("Content").transform
        local function func(self,value,itemContent)
            OnClickItemButton(self,value)
            for i = 0,itemContent.childCount - 1 do
                local item = itemContent:GetChild(i).gameObject
                local txtId = itemContent:GetChild(i).transform:Find("CardInfo/TxtId").transform:GetComponent("Text").text
                if tonumber(txtId) == value.Id then
                    local mask = item.transform:Find("CardInfo/SelectMask").gameObject
                    mask:SetActive(true)
                    item.transform:GetComponent("Button").enabled = false
                end
            end
        end
        for key, value in pairs(self.list) do
            if #self.list >= 4 then
                if key <= 4 then
                    func(self,value,itemContent)
                end
            else
                func(self,value,itemContent)
            end
        end
    end)
    UIUtil.AddBtnEvent(allRemoveButton,function(v)
        self.model.isAllChoicesButton = false
        self.model.isAllRemoveButton = true
        self.model.currNewData = {}
        LangUtil.BindText(self.textSelectNum).text = string.format(LangUtil.GetSysLang(4124),0)
        this.RemoveCardSelect(self)
        local keyItem = self.expeditionComponent:GetSelectItem()
        self.expeditionComponent:RemoveSelectCardData(keyItem)
    end)
    UIUtil.AddBtnEvent(sortTypeButton,function(v)
        self.model.isAllChoicesButton = false
        self.model.isAllRemoveButton = false
        local isActive = not sortTypeContent.gameObject.activeSelf
        sortTypeContent.gameObject:SetActive(isActive)
    end)
    UIUtil.AddBtnEvent(rareButton,function(v)
        self.model.isAllChoicesButton = false
        self.model.isAllRemoveButton = false
        self.model.sortType = SortType.Rare
        LangUtil.BindText(self.rc:GetObject("SortTypeButton").transform:Find("Text")).text =  LangUtil.GetSysLang(4118)
        sortTypeContent.gameObject:SetActive(false)
        this.OnSortCardByType(self,SortType.Rare)
    end)
    UIUtil.AddBtnEvent(lvButton,function(v)
        self.model.isAllChoicesButton = false
        self.model.isAllRemoveButton = false
        self.model.sortType = SortType.Lv
        LangUtil.BindText(self.rc:GetObject("SortTypeButton").transform:Find("Text")).text =  LangUtil.GetSysLang(4119)
        sortTypeContent.gameObject:SetActive(false)
        this.OnSortCardByType(self,SortType.Lv)
    end)
    UIUtil.AddBtnEvent(opinionButton,function(v)
        self.model.isAllChoicesButton = false
        self.model.isAllRemoveButton = false
        self.model.sortType = SortType.Opinion
        LangUtil.BindText(self.rc:GetObject("SortTypeButton").transform:Find("Text")).text =  LangUtil.GetSysLang(4120)
        sortTypeContent.gameObject:SetActive(false)
        this.OnSortCardByType(self,SortType.Opinion)
    end)
    UIUtil.AddBtnEvent(decideButton,function(v)
        if self.model.isAllRemoveButton then
            local key = self.expeditionComponent:GetSelectItem()
            self.expeditionComponent:RemoveSelectCardData(key)
            OnSetExpeditationCardInfo(self)
        end
        self.model.isAllChoicesButton = false
        self.model.isAllRemoveButton = false
        if #self.model.currNewData > 0 then
            local keyItem = self.expeditionComponent:GetSelectItem()
            for key, value in pairs(self.model.currNewData) do
                self.expeditionComponent:SetSelectCardData(keyItem,value)
                OnSetExpeditationCardInfo(self)
            end
        end
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_EXP_SELECTCARD)
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIExpeditionSelectCard)
    end)
    UIUtil.AddBtnEvent(cancelButton,function(v)
        self.model.isAllChoicesButton = false
        self.model.isAllRemoveButton = false
        self.model.currNewData = {}
        this.RemoveCardSelect(self)
        local key = self.expeditionComponent:GetSelectItem()
        self.expeditionComponent:RemoveSelectCardData(key)
        OnSetExpeditationCardInfo(self)
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_EXP_SELECTCARD)
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIExpeditionSelectCard)
    end)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self.cards = Game.Scene.Player:GetComponent("CardComponent").Cards
    self.expeditionComponent = Game.Scene.Player:GetComponent("ExpeditionComponent")

    self.player = Game.Scene.Player
    self.model.isAllChoicesButton = false
    self.model.isAllRemoveButton = false
    self.model.currNewData = {}
    local key = self.expeditionComponent:GetSelectItem()
    local currKeyData = self.expeditionComponent:GetSelectCardData(key)
    LangUtil.BindText(self.textSelectNum).text = string.format(LangUtil.GetSysLang(4124),#currKeyData)
    self:InitCardListData()
    self:InitContent()
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddUIListener(UIMessageNames.ON_CARD_INFO_CHG, self.InitContent)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveUIListener(UIMessageNames.ON_CARD_INFO_CHG)
end

function this.OnDisable(self)
    base.OnDisable(self)
    coroutine.start(function () 
        coroutine.waitforframes(1)
        local name = UIManager:GetInstance():GetLastBgWindowName()
        if name == UIWindowNames.UIHome or name == UIWindowNames.UIMainIntens then
            self.scroll:ClearRecord()
        else
            self.scroll:RecordPosition()
        end
        self.scroll:Dispose()
    end)
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;

