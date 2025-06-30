--
-- <代码文件解释说明>
--

---@class ToolTipFirstChooseCountView : UIBaseView
---@field model ToolTipFirstChooseCountModel
---@field ctrl ToolTipFirstChooseCountCtrl
local ToolTipFirstChooseCountView = BaseClass("ToolTipFirstChooseCountView",UIBaseView)
local base = UIBaseView
local this = ToolTipFirstChooseCountView

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
    self.titleText = LangUtil.BindText(self.rc:GetObject("TitleText"))
    self.message = LangUtil.BindText(self.rc:GetObject("Msg"))
    self.countText = LangUtil.BindText(self.rc:GetObject("NumberText"))
end

function this:OnCreate()
    base.OnCreate(self)
    self.chooseCount = 1
    UIUtil.AddBtnEvent(self.rc:GetObject("EventBg"), function()
        self.ctrl.CloseSelf()
    end)
    UIUtil.AddBtnEvent(self.rc:GetObject("ConfirmButton"), function()
        local uid = self.model.tempId
        if self.model.item ~= nil then
            uid = self.model.item.Id
        end
        if self.model.callBack ~= nil then
             self.model.callBack(uid, self.chooseCount, self.model.tempId)
        end
        self.ctrl.CloseSelf()
    end)
    
    self.plusButton = self.rc:GetObject("PlusButton")
    self.minusButton = self.rc:GetObject("MinusButton")
    self.maxButton = self.rc:GetObject("MaxButton")
    self.minButton = self.rc:GetObject("MinButton")
    UIUtil.AddBtnEvent(self.plusButton,function() self:PlusButton() end)
    UIUtil.AddBtnEvent(self.minusButton,function() self:MinusButton() end)
    UIUtil.AddBtnEvent(self.maxButton,function() self:MaxButton() end)
    UIUtil.AddBtnEvent(self.minButton,function() self:MinButton() end)
end

function this:PlusButton()
    if self.chooseCount < self.model.maxCount then
        self.chooseCount = self.chooseCount + 1
    end
    self:RefreshCount()
end

function this:MinusButton()
    if self.chooseCount > 1 then
        self.chooseCount = self.chooseCount - 1
    end
    self:RefreshCount()
end

function this:MaxButton()
    self.chooseCount = self.model.maxCount
    self:RefreshCount()
end

function this:MinButton()
    self.chooseCount = 1
    self:RefreshCount()
end


function this:RefreshCount()
    self.countText.text = self.chooseCount
    if self.model.isShowCurrentCount then
        self.message.text = string.gsub(self.messageText, "XX", self.chooseCount .. "/" .. self.model.maxCount)
    end
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()
    if self.model.title ~= nil then
        self.titleText.text = self.model.title
    else
        self.titleText.text = LangUtil.GetSysLang(3007) -- 提示
    end
    self.messageText = ""
    if self.model.message ~= nil then
        self.messageText = self.model.message
    else
        self.messageText = ""
    end
    if self.chooseCount < 0 then
        self.chooseCount = 1
    end
    if self.chooseCount > self.model.maxCount then
        self.chooseCount = self.model.maxCount
    end
    
    -- 初始刷新一下数量显示
    self:RefreshCount()
end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddUIListener(UIMessageNames.xxx, func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveUIListener(UIMessageNames.xxx)
end


function this:OnDisable()
    base.OnDisable(self)
end

function this:OnDestroy()
    base.OnDestroy(self)
end

return this
