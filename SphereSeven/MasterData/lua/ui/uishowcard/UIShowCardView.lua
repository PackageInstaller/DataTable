---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/16 19:10
---
local UIShowCardView = BaseClass("UIShowCardView",UIBaseView);
local base = UIBaseView;
local this = UIShowCardView;

local cardPfbName = "CardResolveItem"


local function OnCardItem(self,id)
    if self.cardId == id then
        self.cardId = nil
        self.objectList[id].transform:Find("Active").gameObject:SetActive(false)
    else
        self.cardId = id
        for k,v in pairs(self.objectList) do
            v.transform:Find("Active").gameObject:SetActive(k == id)
        end
    end
end

local function InitCardItem(self,cardId)
    local card = self.cards[cardId]
    local gameObject = self.objectList[cardId]
    local zCard = Z_Card[card.TemplateId]
    local transform = gameObject.transform
    local avatar = transform:Find("Mask/Avatar"):GetComponent("Image")
    local levelTxt = LangUtil.BindText(transform:Find("Level"),FontType.All_Number)
    local active = transform:Find("Active").gameObject
    local starRoot = transform:Find("Star")
    local rareFrame = transform:Find("RareFrame"):GetComponent("Image")
    levelTxt.text = "Lv."..card.Level
    LangUtil.GetSpriteLang(52,function(sprite)
        active:GetComponent("Image").sprite = sprite
    end)
    if self.model.data.matterCard ~= nil and self.model.data.matterCard.Id == cardId  then
        active:SetActive(true)
        self.cardId=self.model.data.matterCard.Id
    else
        active:SetActive(false)
    end
    UIUtil.SetSprite(rareFrame ,AtlasConfig.RareFrame,UIPublic.RareNames[zCard.Rare].."_2.png" )
    UIUtil.SetCardSprite(avatar,zCard.Id,card.SkinId,CardPictureType.Middle)
    UIPublic.InitStar(starRoot,card)
    UIUtil.AddBtnEvent(gameObject,function() OnCardItem(self,cardId)  end)

end

local function InitContent(self)
    ListChildPool:GetInstance():ClearContent(self.content);
    local data = self.model.data.card_list
    self.objectList = {}
    coroutine.start(function()
        for k,v in table.pairsByKeys( data) do
            ListChildPool:GetInstance():GetChild(cardPfbName,self.content,function(object)
                self.objectList[v.Id] = object
                InitCardItem(self,v.Id)
            end)
            
        end
    end)
end

local function OnConfirm(self)
    if self.cardId == nil then
        --UIUtil.ToolTipFourth(LangUtil.GetSysLang(1072))--未选择任何素材
        --return
        self.model.data.callBack(nil)
        self.ctrl:CloseSelf()
    else
        self.model.data.callBack(self.cards[self.cardId])
        self.ctrl:CloseSelf()
    end
   
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.rc:GetObject("Text")).text = LangUtil.GetSysLang(228)
    LangUtil.BindText(self.cancelBtn.transform:Find("Text")).text = LangUtil.GetSysLang(146)
    LangUtil.BindText(self.confirmBtn.transform:Find("Text")).text = LangUtil.GetSysLang(145)
end

function this.OnCreate(self)
    base.OnCreate(self);
    self.content = self.rc:GetObject("Content");
    self.back_btn = self.rc:GetObject("Button");
    self.cancelBtn = self.rc:GetObject("CancelButton")
    self.confirmBtn = self.rc:GetObject("ConfirmButton")
    
    ButtonListener.Get(self.back_btn).OnClickHandler = self.ctrl.CloseSelf;
    UIUtil.AddBtnSound(self.back_btn);
    
    UIUtil.AddBtnEvent(self.cancelBtn,function ()
        if self.model.data.cancelCallBack ~= nil then
            self.model.data.cancelCallBack()
        end
        self.ctrl:CloseSelf() 
    end)
    UIUtil.AddBtnEvent(self.confirmBtn,function () OnConfirm(self) end)
end

function this.OnEnable(self)
    base.OnEnable(self);
    self.cards = Game.Scene.Player:GetComponent("CardComponent").Cards
    self.cardId = nil
    self:OnRefresh();
end

function this.OnRefresh(self)
    InitContent(self);
end

function this.OnAddListener(self)
    base.OnAddListener(self);
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self);
    ListChildPool:GetInstance():ClearContent(self.content);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;


