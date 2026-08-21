local UIRechargePopUpView = BaseClass("UIRechargePopUpView",UIBaseView)
local base = UIBaseView
local this = UIRechargePopUpView

function this.InitContent(self)

end

function this.OnCreate(self)
    base.OnCreate(self)

    self.player = Game.Scene.Player

    self.skinImage = self.rc:GetObject("SkinImage")

    UIUtil.AddBtnEventNoBug(self.skinImage.gameObject, function()
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIShowSkin)
    end, "Back")

    self.paintRoot = self.rc:GetObject("PicRoot").transform
    self.homeCard = self.rc:GetObject("Pic"):GetComponent("Image")
    self.spinePic = self.rc:GetObject("SpinePic")
    self.cardBg = self.skinImage:GetComponent("Image")
    self.defBgSprite =  self.cardBg:GetComponent("Image").sprite
    self.EffectImage = self.rc:GetObject("EffectImage")

    self.uiDrawing = UIDrawing.New(self.paintRoot, self.homeCard, self.spinePic, SoundType.Main, UIWindowNames.UIHome, self.lines)
    
end

function this.OnEnable(self)
    base.OnEnable(self)
    self:OnRefresh()
end

function this.OnRefresh(self)   
    coroutine.start(function()
        coroutine.waitforseconds(0.1)
        local skinId = self.model.shop_data
        local skin = Z_FigureAsset[skinId]
        
        local path = "UI/SkinShopBg/".. skin.CardWithBG ..".png"
        self.skinImage:GetComponent("Image").sprite =  AtlasManager:GetInstance():CoLoadImageAsync(path)
    end)

    coroutine.start(function()
        --self.uiDrawing:BackgroundSetting(self.cardBg, self.EffectImage, self.defBgSprite)
        local skinId = self.model.shop_data
        local skin = Z_FigureAsset[skinId]
        self.uiDrawing:CoPlayImage(skin.SsUnitId, skinId)
        if self.uiDrawing.showMode == 2 then
            self.uiDrawing:ChangeMode(skin.SsUnitId, skinId)
        end
        local offsetInfo = Z_SkinOriginalOffset[skinId]
        -- self.paintRoot:DOLocalMove(Vector2.New(offsetInfo.ShopOffset[1],offsetInfo.ShopOffset[2]),0)
        -- self.paintRoot:DOScale(Vector2.New(offsetInfo.ShopScale[1],offsetInfo.ShopScale[2]),0)

        -- coroutine.waitforframes(2)
        -- local path = "UI/SkinShopBg/".. skin.CardWithBG ..".png"
        -- self.skinImage:GetComponent("Image").sprite =  AtlasManager:GetInstance():CoLoadImageAsync(path)
    end)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
end

function this.OnDisable(self)
    base.OnDisable(self)
    self.uiDrawing:Disable()
end

function this.OnDestroy(self)
    base.OnDestroy(self)
end

return this
