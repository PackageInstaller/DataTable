-- chunkname: @IQIGame\\UI\\Home\\UIActorController\\UIHomeLandDispTaskBtnController.lua

local UIButtonActorController = require("IQIGame/UI/Home/UIActorController/UIButtonActorController")
local Controller = Clone(UIButtonActorController)

function Controller:__OnInit()
	self:__OnButtonActor_OnInit()
	self:SetButtonData(Constant.UIControllerName.HomeLandMissionUI, nil, nil)
	self:InitRedDot(Constant.E_RedDotPath.HomeLand_Task)
end

return Controller
