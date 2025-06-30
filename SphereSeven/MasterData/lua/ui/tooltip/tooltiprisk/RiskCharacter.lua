local this= require "UI.ToolTip.ToolTipRisk.RiskEnterView"
local prefabName = "RiskCardItem"

local recordOrder = {order = 1,kind = 1}  --是否正序  顺序类型
local screenTypes = {rare = 0,abiliType = 0,mainProp = 0,subProp = 0,atkType = 0}
local mao = {
    [1] = {Id = 1,Name=1137},
    [2] = {Id = 2,Name=1138,}
}

function this.OnChaCreate(self)
    self.chaRc =  self.cha_root.transform:GetComponent("ReferenceCollector")
    self.ChaChange_but = self.chaRc:GetObject("confirmChange_but")
    self.mode1_btn = self.chaRc:GetObject("mode1_btn")
    self.mode2_btn = self.chaRc:GetObject("mode2_btn")
    self.SortButton = self.chaRc:GetObject("SortButton")
    self.ScreenButton = self.chaRc:GetObject("ScreenButton")
    self.ChaChangeTitle = self.chaRc:GetObject("ChangeTitle")
    self.chaClose_but =  self.chaRc:GetObject("chaClose_but")
    self.cardIcon =  self.chaRc:GetObject("cardIcon"):GetComponent("Image")
    self.screenTypes = screenTypes
    self.recordOrder = recordOrder

    UIUtil.AddBtnEvent(self.cha_back_btn, function ()
        self.risk_component:ShowScene()
        self:OnCloseCharacter()
    end)
    
    UIUtil.AddBtnEvent(self.ChaChange_but, function () self:OnChangePlayer() end)
    UIUtil.AddBtnEvent(self.chaClose_but, function () self:OnCloseCharacter() end)
    UIUtil.AddBtnEvent(self.mode1_btn, function () self:OnSkinBtn(1) end)
    UIUtil.AddBtnEvent(self.mode2_btn, function () self:OnSkinBtn(2) end)
    UIUtil.AddBtnEvent(self.ScreenButton, function () self:OnOpenSort() end)
    UIUtil.AddBtnEvent(self.SortButton, function () self:OnClickOrderButton() end)

    self.chaList = {}
    self.scrollCha = VerticalScroll.New()
    self.scrollCha:SetUpdateCount(2)
    self.scrollViewCha = self.chaRc:GetObject("Scroll View"):GetComponent("ScrollRect")

    self:ChaInitScroll()
end

function this.OnChaLang(self)
    self.skin =LangUtil.BindText(self.chaRc:GetObject("skin"))
    self.cardName =LangUtil.BindText(self.chaRc:GetObject("Name"))
    LangUtil.BindText(self.chaRc:GetObject("ChangeTitle")).text = LangUtil.GetSysLang(1120)
    LangUtil.BindText(self.mode1_btn.transform:Find("Text")).text = LangUtil.GetSysLang(1122)
    LangUtil.BindText(self.mode1_btn.transform:Find("bg/Text")).text = LangUtil.GetSysLang(1121)
    LangUtil.BindText(self.mode2_btn.transform:Find("Text")).text = LangUtil.GetSysLang(1121)
    LangUtil.BindText(self.mode2_btn.transform:Find("bg/Text")).text = LangUtil.GetSysLang(1122)
    LangUtil.BindText(self.ChaChange_but.transform:Find("Text")).text = LangUtil.GetSysLang(145)
    self.sortTxt = LangUtil.BindText(self.SortButton.transform:Find("Text"))
    self.sortTxt.text = LangUtil.GetSysLang(154)
    LangUtil.BindText(self.ScreenButton.transform:Find("Text")).text = LangUtil.GetSysLang(155)
    UIUtil.ScrollText(self.cardName)
end

function this.OnOpenCharacter(self)
    self.selectPlayerId = self.data.playerId
    self.selectSkinId = 0
    --self.chaList ={}
    self:SkinShow(self.data.playerId,self.data.skin)
    self.chaList = table.choose( Z_Card,function (k,v)  return v.IsMonster ~= 1 and v.NotOpen ~= 1 end)
    --self.scrollCha:RefreshData(self.chaList)
    self:InitCardListData()
    self.cha_root:SetActive(true)
    self.Sort.gameObject:SetActive(false)
end

function this.SkinShow(self,PlayerId,SkinId)
    if PlayerId ~= 0 then
        self.cardName.text = (Z_Card[PlayerId] ~= nil and{Z_Card[PlayerId].Name} or {LangUtil.GetSysLang(mao[PlayerId].Name)}) [1]
        local CardIcon  = 0
        self.selectSkinId = SkinId
        if  Z_Skin[PlayerId * 100 +4] ~= nil then 
            self.skin.text = Z_Skin[PlayerId * 100 +4].Name
            local path =  (SkinId == 0 and {"_1.png"} or {"_4.png"})[1]
            CardIcon = PlayerId .. path
            self.mode1_btn.gameObject:SetActive(SkinId == 0 )
            self.mode2_btn.gameObject:SetActive(SkinId ~= 0)
        else
            self.skin.text = LangUtil.GetSysLang(1123)
            CardIcon = PlayerId .. "_1.png"
            self.mode1_btn.gameObject:SetActive(false)
            self.mode2_btn.gameObject:SetActive(false)
        end
        self:changeSkin(CardIcon)
    else
        self.cardName.text = ''
        self.skin.text = ''
        self.cardIcon.sprite = DeActiveSprite
        self.mode1_btn.gameObject:SetActive(false)
        self.mode2_btn.gameObject:SetActive(false)
    end
end


 function this.changeSkin(self,CardIcon)
     coroutine.start(function ()
         local path="UI/Risk/CardQ/"..CardIcon
         self.cardIcon.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
     end)
 end

function this.OnSkinBtn(self,id)
    local getSkins = Game.Scene.Player:GetComponent("CardComponent"):GetZCardSkins(self.selectPlayerId)
    local skinid = table.first(getSkins,function(a) return a == 4 end)
    if skinid == nil then
        UIUtil.ToolTipFourth(LangUtil.GetSysLang(149))
        return
    end
    if id == 1 then
        self.selectSkinId = 1
        self:changeSkin(self.selectPlayerId .. "_4.png")
    else
        self.selectSkinId = 0
        self:changeSkin(self.selectPlayerId .. "_1.png")
    end
    self.mode1_btn.gameObject:SetActive(id ~= 1 )
    self.mode2_btn.gameObject:SetActive(id == 1 )
end

function this.ChaInitScroll(self)
    self.scrollCha:Clear()

    self.scrollCha:ScrollInit(self.chaList, self.scrollViewCha , prefabName, function(arg)
        local tf = arg.go.transform
        local data = arg.data
        local cardBg = tf:GetComponent("Image")
        local cardIcon = tf:Find("mask/cardIcon"):GetComponent("Image")
        local new = tf:Find("New").gameObject
        local select =  tf:Find("select").gameObject
        local bgPath = ''
        
        UIUtil.AddBtnEvent(tf.gameObject, function()
            local selectSkinId = 0
            if data.Id == self.data.playerId then
                selectSkinId = self.data.skin
            else
                selectSkinId = 0
            end
            self.selectPlayerId = data.Id
            self:SkinShow(self.selectPlayerId,selectSkinId)
            --hintNode:GetChild(data.Id):AddCount(-1)
            self.scrollCha:RefreshData(self.chaList)
        end)
        if  data.Id < 1001 then ---  在角色列表插入两只猫（醉了）
            cardIcon.color = Color.New(1, 1, 1, 1)
            cardIcon.material = nil
            tf:GetComponent("Button").enabled = true
            bgPath = "role_panel"
            new.gameObject:SetActive(false)
            coroutine.start(function()
                local path = "UI/Risk/Other/" .. bgPath ..".png"
                cardBg.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
                cardIcon.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Risk/CardQ/" .. data.Id .. "_1.png");
            end)
            select:SetActive(data.Id == self.selectPlayerId )
        else
            -- if not table.any(recordComponent.CardTypeList, function(t)
            --     return t == data.Id
            -- end) then
            --     cardIcon.color = Color.New(0, 0, 0, 0.25)
            --     cardIcon.material = ResourcesManager:GetInstance():CoLoadAsync("UI/Materials/UI-GreyDefault.mat", typeof(Material))
            --     tf:GetComponent("Button").enabled = false
            --     bgPath = "role_default_panel"
            -- else
                cardIcon.color = Color.New(1, 1, 1, 1)
                cardIcon.material = nil
                tf:GetComponent("Button").enabled = true
                bgPath = "role_panel"
            -- end
            coroutine.start(function()
                local path = "UI/Risk/Other/" .. bgPath ..".png"
                cardBg.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
                cardIcon.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Risk/CardQ/" .. data.Id .. "_1.png");
            end)
            select:SetActive(data.Id == self.selectPlayerId )
            -- local hintNode = Game.Scene:GetComponent("HintComponent").Handbook:GetChild("Card"):GetChild(data.Sphere)
            -- hintNode:GetChild(data.Id):AddObject(new, "CardHandBookView")
        end
    end)
end

function this.OnClickOrderButton(self)
    self.recordOrder.order = (self.recordOrder.order == 1 and {2} or {1} )[1]
    self.sortTxt.text = (self.recordOrder.order == 1 and {LangUtil.GetSysLang(154)} or {LangUtil.GetSysLang(153)})[1]
    self:InitCardListData()
    --self:RefreshContent()
end

function this.InitCardListData(self)
    
    self.chaListRoot = table.choose( Z_Card,function (k,v)  return v.IsMonster ~= 1 and v.NotOpen ~= 1 end)
    
    self.chaList = {}
    for k,v in table.pairsByKeys(self.chaListRoot) do
        table.insert(self.chaList,v)
    end

    self.chaList = UIPublic.RiskScreenFunc(self.chaList, self.screenTypes)
    table.sort(self.chaList, function(a,b) return UIPublic.RiskSortFunc(a,b,self.recordOrder)end )

    if self.recordOrder.order ~= 1 then
        self.chaList = table.reverseTable(self.chaList)
    end
    table.insert(self.chaList,1,mao[2])
    table.insert(self.chaList,1,mao[1])
    self.scrollCha:RefreshData(self.chaList)
end

function this.OnCloseCharacter(self)
    self.cha_root:SetActive(false)
    UIManager:GetInstance():CloseWindow(UIWindowNames.RiskEnter)
end

function this.OnChangePlayer(self)
    coroutine.start(function ()
        self.risk_component:ChangePlayer(self.selectPlayerId, self.selectSkinId, function()
            --self.risk_component:ShowScene()
            self:OnCloseCharacter()
        end)
    end)
end

function this.OnChaDisable(self)

end

function this.OnChaDestroy(self)
    self.scrollCha:Dispose()
end

return this