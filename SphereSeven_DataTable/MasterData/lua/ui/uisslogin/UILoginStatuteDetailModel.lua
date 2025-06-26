local UILoginStatuteDetailModel = BaseClass("UILoginStatuteDetailModel", UIBaseModel)
local base = UIBaseModel

local function OnCreate(self)
    base.OnCreate(self)
end

-- 打开
local function OnEnable(self, data)
    base.OnEnable(self)
    self.title = data.Title
    self.content = data.Content
end

UILoginStatuteDetailModel.OnCreate = OnCreate
UILoginStatuteDetailModel.OnEnable = OnEnable

return UILoginStatuteDetailModel