--
-- <代码文件解释说明>
--

---@class UIBossraidSweepView : UIBaseView
---@field model UIBossraidSweepModel
---@field ctrl UIBossraidSweepCtrl
local UIBossraidSweepView = BaseClass("UIBossraidSweepView",UIBaseView)
local base = UIBaseView
local this = UIBossraidSweepView

function this:OnLangCreate()
    -- LangUtil.BindText(self.langRc:GetObject("Text"))
end

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable()
    base.OnEnable(self)
    self:OnRefresh()
end

function this:OnRefresh()

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
