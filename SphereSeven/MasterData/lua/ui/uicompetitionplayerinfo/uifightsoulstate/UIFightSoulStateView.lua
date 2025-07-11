---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UIFightSoulStateView = BaseClass("UIFightSoulStateView",UIBaseView);
local base = UIBaseView
local this = UIFightSoulStateView


local function InitEquipInfo(self)
    local fightSoulName = self.fightSoulInfo:Find("Title/FightSoulName"):GetComponent("Text")
    local prop = self.fightSoulInfo:Find("PropImg/PropTxt"):GetComponent("Text")
    local desc = self.fightSoulInfo:Find("TextScroll/Viewport/Content/EffTxt"):GetComponent("Text")
    local holderAvatar = self.fightSoulInfo:Find("Holder/Avatar"):GetComponent("Image")
 
    local fightSoul = self.fightSoul
    local zFightSoul = Z_FightSoul[fightSoul.TemplateId]
    fightSoulName.text = Z_Card[zFightSoul.CardId].Name
    UIPublic.InitFightSoulProp(prop,fightSoul)
    UIPublic.InitFightSoulEff(desc,zFightSoul)
    coroutine.start(function()
        UIPublic.InitVsFightSoulItem(fightSoul, self.fightSoulItem)
        UIPublic.InitItemIcon(holderAvatar, nil, 2, self.card.TemplateId, {iconId = self.card.SkinId})
    end)
end

function this.OnLangCreate(self)
    LangUtil.BindText(self.fightSoulInfo:Find("Title/FightSoulName"))
    LangUtil.BindText(self.fightSoulInfo:Find("PropImg/PropTxt"))
    LangUtil.BindText(self.fightSoulInfo:Find("TextScroll/Viewport/Content/EffTxt"))

    LangUtil.BindText(self.ButtonState.transform:Find("Text")).text = LangUtil.GetSysLang(3020)
end

function this.OnCreate(self)
    base.OnCreate(self)
    self.fightSoulInfo = self.rc:GetObject("FightSoulInfo").transform
    local eventBg = self.rc:GetObject("EventBg")
    self.fightSoulItem = self.fightSoulInfo:Find("FightVisitItem")

    self.ButtonState= self.rc:GetObject("ButtonState")
    
    local func = function()UIManager:GetInstance():CloseWindow(UIWindowNames.UIFightSoulState) end
    EventTriggerListener.Get(eventBg).onLuaClick = func
    UIUtil.AddBtnEvent(self.ButtonState, function() UIManager:GetInstance():OpenWindow(UIWindowNames.UIBuffDetails) end)
end

function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh();
end

function this.OnRefresh(self)
    local info = self.model.info
    self.card = info.card 
    self.fightSoul = info.fightSoul
    InitEquipInfo(self)
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDisable(self)
    base.OnDisable(self);
    self.fightSoulItem:Find("Mask/Avatar"):GetComponent("Image").sprite = DeActiveSprite
    self.fightSoulItem:Find("Frame"):GetComponent("Image").sprite = DeActiveSprite
    self.fightSoulItem:Find("Sub"):GetComponent("Image").sprite = DeActiveSprite
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;

