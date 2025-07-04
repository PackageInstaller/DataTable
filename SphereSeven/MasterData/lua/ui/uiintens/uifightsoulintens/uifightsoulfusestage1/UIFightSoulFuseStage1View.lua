---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/5/24 16:58
---

local UIFightSoulFuseStage1View = BaseClass("UIFightSoulFuseStage1View",UIBaseView);
local base = UIBaseView
local this = UIFightSoulFuseStage1View


local function OnSkip(self)
    UIManager:GetInstance():OpenWindow(UIWindowNames.UIFightSoulFuseStage2,{fightSoul = self.fightSoul})
    coroutine.start(function()
        coroutine.waitforseconds(0.5)
        UIManager:GetInstance():CloseWindow(UIWindowNames.UIFightSoulFuseStage1)
    end)
end

function this.OnCreate(self)
    base.OnCreate(self);
    self.audio = self.gameObject:GetComponent("AudioSource")
    self.effect = self.rc:GetObject("Effect")
    self.effect:SetActive(false)
end

function this.OnLangCreate(self)
    LangUtil.GetSpriteLang(250, function(sprite) self.rc:GetObject("Stage"):GetComponent("Image").sprite = sprite end)
end

function this.OnEnable(self)
    base.OnEnable(self)
    self.audio.volume = ClientData:GetInstance():GetVolume("SoundVolume")
    local info  =self.model.info
    self.fightSoul = info.fightSoul
    self:OnRefresh()
end



function this.OnRefresh(self)
    self.effect:SetActive(false)
    coroutine.waitforseconds(1)
    self.effect:SetActive(true)
    UIPublic.PlayEffect(self.effect)
    self.audio:Play()
    coroutine.waitforseconds(2)
    UIUtil.OpenSkipHint(function() OnSkip(self) end)
end


function this.OnAddListener(self)
    base.OnAddListener(self)
  
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
  
end

function this.OnDisable(self)
    base.OnDisable(self);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this;

