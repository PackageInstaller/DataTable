local UISkinGuideView = BaseClass("UISkinGuideView",UIBaseView);
local base = UIBaseView
local this = UISkinGuideView

function this.OnCreate(self)
    base.OnCreate(self)
    self.panel = self.rc:GetObject("Panel")
    self.bgCard = self.rc:GetObject("UIBgCard")
    self.bgImg = nil
    self.cardImg = self.rc:GetObject("CardImg"):GetComponent("Image")
    self.tipImg = self.rc:GetObject("TipImg"):GetComponent("Image")
    self.titleImg = self.rc:GetObject("TitleImg"):GetComponent("Image")
    self.cardTypeImg = self.rc:GetObject("CardTypeImg"):GetComponent("Image")
    self.skinName = self.rc:GetObject("SkinName")
    self.closeBtn = self.rc:GetObject("CloseBtn")
    self.shopBtn = self.rc:GetObject("ShopBtn")
    UIUtil.AddBtnEvent(self.closeBtn, function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UISkinGuide)
    end)
    UIUtil.AddBtnEvent(self.shopBtn, function()
        UIManager:GetInstance():CloseWindowByLayer(UILayers.NormalLayer)
        --UIManager:GetInstance():CloseWindowByLayer(UILayers.InfoLayer)
        UIManager:GetInstance():OpenWindow(UIWindowNames.UISkinShop, {skinId = self.skinId})
    end)
end

function this.OnLangCreate(self)
    self.skinId = self.model.info
    LangUtil.BindText(self.skinName).text = Z_Skin[self.skinId].Name
    LangUtil.BindText(self.shopBtn.transform:Find("Text")).text = LangUtil.GetSysLang(3123)
    LangUtil.GetSpriteLang(351, function (sprite)
        self.tipImg.sprite = sprite
    end)
    LangUtil.GetSpriteLang(352, function (sprite)
        self.titleImg.sprite = sprite
    end)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self.skinId = self.model.info
    self.panel:SetActive(false)
    local cardId = Z_Skin[self.skinId].BelongCard
    local typeR = { "R", "SR", "SSR", "UR" }
    UIUtil.SetSprite(self.cardTypeImg, AtlasConfig.SummonRare, typeR[Z_Card[cardId].Rare] ..".png")
    coroutine.start(function ()
        coroutine.waitforframes(1)
        local zSkin = Z_Skin[self.skinId]

        self.bgImg = self.bgCard.transform:Find(cardId.."_"..zSkin.Stage):GetComponent("Image")
        self.bgImg.gameObject:SetActive(true)
        self.bgImg.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/CardBgOriginal/"..cardId.."_"..zSkin.BgStage..".png")
        self.bgImg:SetNativeSize()

        local cardName = cardId.."_"..zSkin.Stage
        if not string.IsNullOrEmpty(zSkin.AssistImage) then
            cardName = cardId.."_"..zSkin.AssistImage
        end
        local path = "UI/CardPaint/"..cardName..".png"
        -- 和谐
        local skin = table.first(Z_Skin, function (v) return v.BelongCard == cardId and v.Stage == zSkin.Stage end)
        if skin ~= nil then
            path = "UI/CardPaint"..skin.CardPaint.."/"..cardName..".png"
        end
        self.cardImg.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path)
        self.cardImg:SetNativeSize()
        self.cardImg.transform.position = self.bgImg.transform:Find("Card").position

        self.oldPosition = self.panel.transform.position
        self.panel.transform.position = Vector3.New(9999, 9999, 9999)
        self.panel:SetActive(true)
        coroutine.waitforframes(1)
        self.panel:SetActive(false)
        coroutine.waitforframes(1)
        self.panel:SetActive(true)
        self.panel.transform.position = self.oldPosition
    end)
end

function this.OnDisable(self)
    base.OnDisable(self)
    self.bgImg.sprite = nil
    self.bgImg.gameObject:SetActive(false)
end

return this

