-- chunkname: @IQIGame\\UI\\Home\\UIActorController\\UINormalBtnController.lua

local UIButtonActorController = require("IQIGame/UI/Home/UIActorController/UIButtonActorController")
local Controller = Clone(UIButtonActorController)

function Controller:__OnInit()
	self:__OnButtonActor_OnInit()

	local partCfg = self.actor:GetPartConfig()

	if LuaUtility.StrIsNullOrEmpty(partCfg.OpenUI) then
		logError("场景UI配件使用了通用按钮类型，未配置OpenUI 字段")

		return
	end

	self:SetButtonData(partCfg.OpenUI, partCfg.FunOpenID, partCfg.UnOpenNoticeID)
	self:InitRedDot(partCfg.RedDotID)
end

return Controller
