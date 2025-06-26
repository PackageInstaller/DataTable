
--
-- <代码文件解释说明>
--

---@class UIThingsDetailCardModel : UIBaseModel
---@field cardId number
---@field cardStar number
---@field cardLevel number
local UIThingsDetailCardModel = BaseClass("UIThingsDetailCardModel",UIBaseModel)
local base = UIBaseModel
local this = UIThingsDetailCardModel

local CHARACTER_LEVEL_LIMIT = tonumber(Z_Misc["CHARACTER_LEVEL_LIMIT"].Value[1])
local CHARACTER_STAR_LIMIT = tonumber(Z_Misc["CHARACTER_STAR_LIMIT"].Value[1])

function this:OnCreate()
    base.OnCreate(self)
end

function this:OnEnable(data)
    base.OnEnable(self)
    self.cardId = data.tempId
    self.isMax = false
    self.cardStar = 1
    self.cardLevel = 1
    self:OnRefresh()
end

function this:OnRefresh()

end

function this:OnAddListener()
    base.OnAddListener(self)
    -- self:AddDataListener(DataMessageNames.xxx,func)
end

function this:OnRemoveListener()
    base.OnRemoveListener(self)
    -- self:RemoveDataListener(DataMessageNames.xxx)
end

return this
