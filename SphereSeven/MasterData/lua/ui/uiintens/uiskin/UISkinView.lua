---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/17 21:26
---

---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/17 21:27
---
local UISkinView = BaseClass("UISkinView",UIBaseView);
local this = UISkinView;
local base = UIBaseView;

local skin_item_path = "SkinItem";
local show_image_path = "ShowImage";
local confirm_btn_path = "CofirmButton";
local cancel_btn_path = "CancleButton";
local content_path = "Content";

local function OnClickConfirmButton(gameObject)
    local self = gameObject:GetComponent("BindData"):Get("self");
    if self.skin == nil then
        print("--未选择皮肤");
        return;
    end
    
    local send_data = {};
    send_data.CardId = self.model.card.Id;
    send_data.SkinId = self.skin.Id;
    
    self.ctrl:SendChangeSkinRequest(send_data);
end

local function OnClickSkinButton(gameObject)
    local self = gameObject:GetComponent("BindData"):Get("self");
    local skin = gameObject:GetComponent("BindData"):Get("skin");
    self.skin = skin;
end


local function InitItemData(self,v,object)
    local transform = object.transform;
    local icon = transform:Find("Icon"):GetComponent("Image");
    local name_text = transform:Find("Name"):GetComponent("Text");
    local des_text = transform:Find("Desc"):GetComponent("Text");
    local select = transform:Find("Select").gameObject;
    select:SetActive(self.model.card.SkinId == v.Id);
    local z_skin = Z_Skin[v.TemplateId];
    UIUtil.SetSprite(icon,AtlasConfig.Skin,z_skin.SkinDraw);
    name_text.text = z_skin.Name;
    des_text.text= z_skin.Desc;
    local bindData = UIUtil.GetButtonDataComponent(object);
    bindData:Add("self",self);
    bindData:Add("skin",v);
    ButtonListener.Get(object).OnClickHandler = OnClickSkinButton;
end

local function InitContent(self)
    UIUtil.RemoveNilData(self.object_list);
    coroutine.start(function()
        for k,v in pairs(self.model.skin_list) do
            if self.object_list[k] == nil then
                ListChildPool:GetInstance():GetChild("SkinItemNew",self.content,function(object)
                    self.object_list[k] = object;
                    InitItemData(self,v,object)
                end);
            else
                InitItemData(self,v,self.object_list[k])
            end
        end
    end)
end


function this.OnCreate(self)
    base.OnCreate(self);
    self.object_list = {};
    self.skin_item = self.rc:GetObject(skin_item_path);
    self.show_image = self.rc:GetObject(show_image_path );
    self.confirm_btn = self.rc:GetObject(confirm_btn_path);
    self.cancel_btn = self.rc:GetObject(cancel_btn_path);
    self.content = self.rc:GetObject(content_path);
    
    ButtonListener.Get(self.cancel_btn).OnClickHandler = self.ctrl.CloseSelf;
    UIUtil.GetButtonDataComponent(self.confirm_btn):Add("self",self);
    ButtonListener.Get(self.confirm_btn).OnClickHandler = OnClickConfirmButton;
end

function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh();
end


function this.OnRefresh(self)
    self.skin = nil;
    InitContent(self);
end


function this.OnAddListener(self)
    base.OnAddListener(self);
    self:AddUIListener(UIMessageNames.ON_SKIN_INFO_CHG,self.OnRefresh);
end


function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
    self:RemoveUIListener(UIMessageNames.ON_SKIN_INFO_CHG);
end

function this.OnDisable(self)
    base.OnDisable(self);
    self.object_list = {};
    ListChildPool:GetInstance():ClearContent(self.content);
end

function this.OnDestroy(self)
    base.OnDestroy(self);
end

return this

