-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/snowmancar/controller/SnowManCarController.lua

module("logic.extensions.snowmancar.controller.SnowManCarController", package.seeall)

local SnowManCarController = class("SnowManCarController", BaseController)

SnowManCarController.AfterCarMoveFinish = "SnowManCarLocalNotify_AfterCarMoveFinish"

function SnowManCarController:ctor()
	return
end

function SnowManCarController:onInit()
	self:onReset()
end

function SnowManCarController:onReset()
	return
end

function SnowManCarController:getIconCfg(activityId)
	if checknumber(self._maxIdx) <= 0 then
		local iconCfg = SnowManCarConfig.instance:getCarIconCfg()

		self._maxIdx = #iconCfg
	end

	local leftIdx = math.random(1, self._maxIdx)
	local rightIdx = leftIdx % self._maxIdx + 1

	return leftIdx, rightIdx
end

function SnowManCarController:sendGameStartReq(activityId)
	self._clientKey = self._clientKey or {}
	self._clientKey[activityId] = math.random(ServerTime.now())

	SnowManCarAgent.instance:sendPM_SnowmanCarStartReq(activityId, self._clientKey[activityId])
end

function SnowManCarController:sendGameEndReq(activityId, score)
	if self._clientKey then
		if not self._clientKey[activityId] then
			local clientKey = 0
			local serverKey = SnowManCarModel.instance:getServerKey(activityId)

			if clientKey == 0 or serverKey == 0 then
				Debug.logError("clientKey or serverKey is 0, can't send game end req")

				return
			end

			local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
				score
			})

			SnowManCarAgent.instance:sendPM_SnowmanCarEndReq(activityId, score, encryptedKey)
		end
	end
end

function SnowManCarController:setSpriteToImage(icon, folderUrl, imgName)
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

function SnowManCarController:setSliderValue(progBar, progText, cfg, progress)
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

SnowManCarController.instance = SnowManCarController.New()

return SnowManCarController
