---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/17 21:27
---
local UISkinModel = BaseClass("UISkinModel",UIBaseModel);
local this = UISkinModel;
local base = UIBaseModel;

function this.OnCreate(self)
    base.OnCreate(self);
end

function this.OnEnable(self,card)
    base.OnEnable(self);
    self:OnRefresh(card);
end


function this.OnRefresh(self,card)
    self.card = card
    self.skin_list = {};
    for k,v in pairs(Game.Scene.Player:GetComponent("SkinComponent").Skins) do
        local z_skin = Z_Skin[v.TemplateId];
        if z_skin.BelongCard == self.card.TemplateId then
            table.insert(self.skin_list,v);
        end
    end
end

local function OnSkinInfoChg(self)
    self:OnRefresh();
    self:UIBroadcast(UIMessageNames.ON_SKIN_INFO_CHG)
end

function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddDataListener(DataMessageNames.ON_SKIN_INFO_CHG,OnSkinInfoChg);
end


function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveDataListener(DataMessageNames.ON_SKIN_INFO_CHG);
end


function this.OnDisable(self)
    base.OnDisable(self);
end


function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this
