---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/4/12 17:40
---
local ToolTipSecondView = BaseClass("ToolTipSecondView",UIBaseView)
local base = UIBaseView
local this = ToolTipSecondView

local back_btn_path = "CloseButton"
local msg_text_path = "MsgText"
local title_text_path  = "TitleText"

local function OnClickConfirmButton(gameObject)
    local self = gameObject:GetComponent("BindData"):Get("self");
    self.ctrl:CloseSelf();
    if self.model.data.callBack ~= nil then
        self.model.data.callBack();
    end
end

function this.OnCreate(self)
    base.OnCreate(self);

    self.back_btn = self.rc:GetObject(back_btn_path);
    self.msg_text = self.rc:GetObject(msg_text_path):GetComponent("Text");
    self.title_text = self.rc:GetObject(title_text_path):GetComponent("Text");

    UIUtil.GetButtonDataComponent(self.back_btn):Add("self",self);
    ButtonListener.Get(self.back_btn).OnClickHandler = OnClickConfirmButton;
    UIUtil.AddBtnSound(self.back_btn)
end

function this.OnEnable(self)
    base.OnEnable(self);
    self:OnRefresh();
end

function this.OnRefresh(self)
    self.msg_text.text = self.model.data.message;
    self.title_text.text = self.model.data.title;
end

function this.OnAddListener(self)
    base.OnAddListener(self);
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self);
end

function this.OnDestroy(self)
    self.back_btn = nil;
    self.confirm_btn = nil;
    self.msg_text = nil;
    self.title_text = nil;
    base.OnDestroy(self);
end

return this

