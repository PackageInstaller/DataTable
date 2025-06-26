---@class ToolTipGetItemView : UIBaseModel
---@field model ToolTipGetItemModel
---@field ctrl ToolTipGetItemCtrl
local ToolTipGetItemView = BaseClass("ToolTipGetItemView",UIBaseView)
local base = UIBaseView
local this = ToolTipGetItemView


local function OnClickConfirmButton(self)
    self.ctrl.CloseSelf()
    if self.model.data.callBack ~= nil then
        self.model.data.callBack()
    end
end

local function OnClickCancelButton(self)
    self.ctrl.CloseSelf()
    if self.model.data.cancelCallBack ~= nil then
        self.model.data.cancelCallBack()
    end
end

function this:OnCreate()
    base.OnCreate(self)

    self.cancel_btn = self.rc:GetObject("Cancel")
    self.confirm_btn = self.rc:GetObject("ConfirmButton")
    UIUtil.AddBtnEvent(self.cancel_btn,function() OnClickCancelButton(self) end)
    UIUtil.AddBtnEvent(self.confirm_btn,function()OnClickConfirmButton(self) end)
    UIUtil.AddBtnEvent(self.rc:GetObject("EventBg"), function()
        self.ctrl.CloseSelf()
    end)
    self.itemIconImage = self.rc:GetObject("ItemIconImage"):GetComponent("Image")
    self.itemIconImage1 = self.rc:GetObject("ItemIconImage1"):GetComponent("Image")
    -- self.itemBgImage = self.rc:GetObject("ItemBgImage"):GetComponent("RectTransform")
    self.bottomTextLayout = self.rc:GetObject("BottomTextLayout").transform

    self.ItemBg = self.rc:GetObject("ItemBg")
    self.ItemBg1 = self.rc:GetObject("ItemBg1")
end

function this:OnLangCreate()
    LangUtil.GetSpriteLang(507, function(Sprite) self.cancel_btn.transform:Find("CancelText"):GetComponent("Image").sprite = Sprite  end) -- 取消
    LangUtil.GetSpriteLang(426, function(Sprite) self.confirm_btn.transform:Find("ConfirmText"):GetComponent("Image").sprite = Sprite  end) -- 取消
    self.title_text = LangUtil.BindText(self.rc:GetObject("TitleText"))
    self.topText = LangUtil.BindText(self.rc:GetObject("TopText"))
    self.bottomText = LangUtil.BindText(self.rc:GetObject("BottomText"))
    self.itemText = LangUtil.BindText(self.rc:GetObject("ItemText"))
    self.itemCountText = LangUtil.BindText(self.rc:GetObject("ItemCountText"))
    self.itemCountText1 = LangUtil.BindText(self.rc:GetObject("ItemCountText1"))

    self.bottomTexts = {}
    for i = 0, self.bottomTextLayout.childCount - 1 do
        self.bottomTexts[i+1] = LangUtil.BindText(self.bottomTextLayout:GetChild(i))
    end
end

function this.OnEnable(self)
    base.OnEnable(self)
    self:OnRefresh()
end

---@param self ToolTipGetItemView
function this.OnRefresh(self)
    self.cancel_btn:SetActive(not self.model.data.hideBackBtn)
    self.confirm_btn:SetActive(not self.model.data.hideConfirmBtn)

    self.title_text.text = self.model.data.title or LangUtil.GetSysLang(9)--"提示"
    self.topText.text = self.model.data.topText or ""
    self.itemText.text = self.model.data.itemText or ""

    if self.model.data.items == nil then
        self.itemIconImage.gameObject:SetActive(false)
        self.itemCountText.gameObject:SetActive(false)
        self.itemIconImage1.gameObject:SetActive(false)
        self.itemCountText1.gameObject:SetActive(false)
    else
        self.itemCountText.gameObject:SetActive(true)
        self.itemIconImage.gameObject:SetActive(true)
        local item1 = self.model.data.items[1]
        self.ItemBg:SetActive(item1 ~= nil)
        if item1.count ~= nil and item1.count ~= 0 then
            self.itemCountText.text = "x" .. item1.count
        else
            self.itemCountText.text =  ""
        end
        UIUtil.SetSprite(self.itemIconImage, AtlasConfig.Item, GetItemIcon(Z_Item[item1.id]))

        local item2 = self.model.data.items[2]
        self.ItemBg1:SetActive(item2 ~= nil)
        if item2 == nil then
            self.itemCountText1.gameObject:SetActive(false)
            self.itemIconImage1.gameObject:SetActive(false)
            -- self.itemBgImage.sizeDelta.x = 640
        else
            self.itemCountText1.gameObject:SetActive(true)
            self.itemIconImage1.gameObject:SetActive(true)
            -- self.itemBgImage.sizeDelta.x = 740

            if item2.count ~= nil and item2.count ~= 0 then
                self.itemCountText1.text = "x" .. item2.count
            else
                self.itemCountText1.text =  ""
            end
            UIUtil.SetSprite(self.itemIconImage1, AtlasConfig.Item, GetItemIcon(Z_Item[item2.id]))
        end
    end

    if type(self.model.data.bottomText) ~= "table" then
        self.bottomText.text = self.model.data.bottomText or ""
        self.bottomTextLayout.gameObject:SetActive(false)
        self.bottomText.gameObject:SetActive(true)
    else
        self.bottomTextLayout.gameObject:SetActive(true)
        self.bottomText.gameObject:SetActive(false)

        for index, text in ipairs(self.bottomTexts) do
            if not string.IsNullOrEmpty(self.model.data.bottomText[index]) then
                text.text = self.model.data.bottomText[index]
                text.gameObject:SetActive(true)
            else
                text.text = ""
                text.gameObject:SetActive(false)
            end
        end
    end
end

function this.OnAddListener(self)
    base.OnAddListener(self)
end

function this.OnRemoveListener(self)
    base.OnRemoveListener(self)
end

function this.OnDisable(self)
    base.OnDisable(self)
end

function this.OnDestroy(self)
    self.cancel_btn = nil
    self.confirm_btn = nil
    self.title_text = nil
    base.OnDestroy(self)
end

return this

