-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darknessspring/controller/DarknessSpringController.lua

module("logic.extensions.darknessspring.controller.DarknessSpringController", package.seeall)

local DarknessSpringController = class("DarknessSpringController", BaseController)

DarknessSpringController.BgFloderUrl = "ui/bigbg/views/darknessspring"

function DarknessSpringController:ctor()
	return
end

function DarknessSpringController:onInit()
	return
end

function DarknessSpringController:onReset()
	return
end

function DarknessSpringController:playStageOneGame()
	local model = FirePowerContestModel.instance

	if model:isInMatchCD() then
		FloatWordMgr.instance:show(langPara("FirePowerContestMainView__4", model:getMatchCDSec()))
	else
		FirePowerContestController.instance:reqStartGame()
	end
end

function DarknessSpringController:setSliderValue(progBar, progText, cfg, progress)
	local curProgStep = 1
	local curValue = 0

	progress = checknumber(progress) and progress or 0

	if progText then
		progText.text = progress
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

function DarknessSpringController:setSpriteToImage(icon, folderUrl, imgName)
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

DarknessSpringController.instance = DarknessSpringController.New()

return DarknessSpringController
