-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/reviveelizabeth/controller/ReviveElizabethController.lua

module("logic.extensions.reviveelizabeth.controller.ReviveElizabethController", package.seeall)

local ReviveElizabethController = class("ReviveElizabethController", BaseController)

ReviveElizabethController.FlowerIconFolderUrl = "ui/icon/items"
ReviveElizabethController.BgFloderUrl = "ui/bigbg/story/story_bg"
ReviveElizabethController.SeedEffectUrl = "20230825/yonghengguodu/fx_yonghengnongchang_jiasu_1.prefab"
ReviveElizabethController.WaterEffectUrl = "20231222/hudiegu/fx_ui_hudiegu_jiaoshui.prefab"
ReviveElizabethController.WeedEffectUrl = "20230825/yonghengguodu/fx_ui_yonghengguodu_jiandao.prefab"
ReviveElizabethController.DataKey = "ReviveElizabeth_"
ReviveElizabethController.DanMuDuration = 13
ReviveElizabethController.DanMuInterval = 3.5

function ReviveElizabethController:ctor()
	return
end

function ReviveElizabethController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._resetRedPoint, self)
	self:onReset()
end

function ReviveElizabethController:onReset()
	self.flowerCfg = {}
end

function ReviveElizabethController:_resetRedPoint()
	local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.ReviveElizabeth)

	if activityId <= 0 then
		return
	end

	local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.ReviveElizabeth, activityId)

	if GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
		local isAllFieldPass = GameUtil.getUserData(ReviveElizabethController.DataKey .. "AllFieldPass")

		if not isAllFieldPass then
			RedPointController.instance:regUserDayRedPoint("c35")
		end
	end
end

function ReviveElizabethController:setSliderValue(progBar, progText, cfg, progress)
	local curProgStep = 1
	local curValue = 0

	progress = checknumber(progress) and progress or 0

	if progText then
		progText.text = "<color=#F8D200FF>" .. tostring(progress) .. "</color>"
	end

	if progBar then
		local perValue = 1 / #cfg
		local isTooBigger = progress > 0

		for i = 1, #cfg do
			if i - 1 > 0 then
				if not cfg[i - 1].progress then
					local preStep = 0
					local nextStep = cfg[i].progress

					if preStep < progress and progress <= nextStep then
						local baseValue = perValue * (i - 1)

						curValue = baseValue + (progress - preStep) / (nextStep - preStep) * perValue
						curProgStep = i
						isTooBigger = false

						break
					end
				end
			end
		end

		curValue = isTooBigger and 1 or curValue
		curProgStep = isTooBigger and #cfg or curProgStep
		progBar.value = curValue
	end

	return curProgStep
end

function ReviveElizabethController:setSpriteToImage(icon, folderUrl, imgName)
	local isNeedSetimg = icon and not string.nilorempty(imgName)

	local function localFunc()
		local image = icon:GetComponent(goutil.Type_UIImage)

		if image then
			image:SetNativeSize()
		end
	end

	if isNeedSetimg then
		local url = string.format("%s/%s.png", folderUrl, imgName)

		uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, url, localFunc)
	end
end

ReviveElizabethController.instance = ReviveElizabethController.New()

return ReviveElizabethController
