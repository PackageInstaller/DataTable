-- chunkname: @IQIGame\\UI\\Home\\UIActorController\\UIHomeLandUpGradeBtnController.lua

local UIButtonActorController = require("IQIGame/UI/Home/UIActorController/UIButtonActorController")
local Controller = Clone(UIButtonActorController)

function Controller:__OnInit()
	self:__OnButtonActor_OnInit()
	self:SetButtonData(Constant.UIControllerName.HomeLandUpgradeUI, nil, nil)
end

return Controller
