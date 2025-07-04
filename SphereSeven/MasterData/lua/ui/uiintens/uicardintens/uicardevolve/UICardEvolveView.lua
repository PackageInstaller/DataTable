---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UICardEvolveView = BaseClass("UICardEvolveView",UIBaseView);
local base = UIBaseView
local this = UICardEvolveView



local function InitCardFace(self,isClear)
    local card = self.card
    local zCard = Z_Character[card.TemplateId]
    local star = self.model.info.originalStar
    local transform = self.cardFace.transform
    local frame = transform:Find("Frame"):GetComponent("SpriteRenderer")
    local cardImg = transform:Find("Card"):GetComponent("SpriteRenderer")
    local mainProp = transform:Find("MainProp"):GetComponent("SpriteRenderer")
    local subProp = transform:Find("SubProp"):GetComponent("SpriteRenderer")
    local cardFrom = transform:Find("CardFrom"):GetComponent("SpriteRenderer")
    local starImage = transform:Find("Star"):GetComponent("SpriteRenderer")
    local cardType = transform:Find("CardType"):GetComponent("SpriteRenderer")

    local skinId = card.SkinId

    if isClear == true then
        frame.sprite = nil
        cardImg .sprite = nil
        mainProp.sprite = nil
        subProp .sprite = nil
        cardFrom.sprite = nil
        cardType.sprite = nil
    else
        UIPublic.NewInitStar(starImage,star)

        -- UIUtil.SetSprite(mainProp, AtlasConfig.Class, 
        --      Z_Character[card.Id].Class .. "_" .. zCard.Rarity ..".png")
        mainProp.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Common/Class/".. Z_Character[card.Id].Class .. "_" .. zCard.Rarity .. ".png")
        cardImg .sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/CardBig/".. Z_FigureAsset[skinId].ListHalfBody ..".png")
        subProp .sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Atlas/Prop/"..UIPublic.SubPropConfig[zCard.Prop])
        frame.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/RareFrame/".. UIPublic.RareNames[zCard.Rarity]..".png")
        cardFrom.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Common/CardInfo/".. UIPublic.RareNames[zCard.Rarity].."_Line.png")
        cardType.sprite = AtlasManager:GetInstance():CoLoadImageAsync("UI/Common/Raility/".. UIPublic.RareNames[zCard.Rarity]..".png")
    end
end

local function OnSkip(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UICardEvolveStage1,{
        card = self.card,
        originalStar = self.model.info.originalStar
    })
    coroutine.start(function()
        coroutine.waitforseconds(0.5)
        UIManager:GetInstance():DestroyWindow(UIWindowNames.UICardEvolve)
    end)
end

function this.OnCreate(self)
    base.OnCreate(self);
    self.eventBg = self.rc:GetObject("EventBg")
    self.effect = self.rc:GetObject("Effect")
    self.cardFace = self.rc:GetObject("CardFace")
    self.audio = self.gameObject:GetComponent("AudioSource")
    self.mask = self.rc:GetObject("Mask")
    self.nameText = self.rc:GetObject("NameText")
    self.cardEffect = self.rc:GetObject("Card1")
    self.cardEffectImg = self.rc:GetObject("CardEffectImage"):GetComponent("RawImage")
    self.cardEffect.transform:GetComponent("Renderer").material.mainTexture = self.cardEffectImg.texture
end

function this.OnEnable(self)
    base.OnEnable(self);
    local Guide = UIManager:GetInstance():GetWindow(UIWindowNames.UINoviceGuide)
    if Guide ~= nil  then
        local View = Guide.View
        View.mask_ho.gameObject:SetActive(false)
    end
    self:OnRefresh();
end

function this.OnRefresh(self)
    self.nameText.gameObject:SetActive(false)
    local info = self.model.info
    self.card = info.card
    local zCard = Z_Card[self.card.TemplateId]
    self.audio.volume = ClientData:GetInstance():GetVolume("SoundVolume")
    self.mask:SetActive(true)

    coroutine.start(
        function()
            coroutine.waitforframes(10)
            InitCardFace(self)
        end
    )
    -- InitCardFace(self) --加载图片资源
    self.mask:SetActive(false)
    coroutine.waitforseconds(0.3)
    self.audio:Play()
    coroutine.waitforseconds(0.6)
    LangUtil.BindText(self.nameText).text = zCard.Name
    self.nameText.gameObject:SetActive(true)
    UIPublic.PlayEffect(self.effect)
    coroutine.waitforseconds(4)
    self.transform:DOShakePosition(0.6,40,80,90);
    print("--播放震动动画")
    UIUtil.OpenSkipHint(function()OnSkip(self)  end)
    if info.callback ~= nil then
        info.callback()
    end
end


function this.OnAddListener(self)
    base.OnAddListener(self)
  
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
  
end

function this.OnDisable(self)
    base.OnDisable(self);
    self.audio:Stop()
  
    InitCardFace(self,true)
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;

