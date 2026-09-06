-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/slackoffgame/controller/SlackOffGameController.lua

module("logic.extensions.slackoffgame.controller.SlackOffGameController", package.seeall)

local SlackOffGameController = class("SlackOffGameController", BaseController)

SlackOffGameController.TeacherComeIn = "SlackOffGame_TeacherComeIn"
SlackOffGameController.TeacherLeave = "SlackOffGame_TeacherLeave"

function SlackOffGameController:onInit()
	self:onReset()
end

function SlackOffGameController:onReset()
	return
end

function SlackOffGameController:sendGameStartReq(activityId)
	self._clientKey = self._clientKey or {}
	self._clientKey[activityId] = math.random(ServerTime.now())

	SlackOffGameAgent.instance:sendPM_SlackOffGameStartReq(activityId, self._clientKey[activityId])
end

function SlackOffGameController:sendGameEndReq(activityId, isPass, studenInfos)
	if self._clientKey then
		if not self._clientKey[activityId] then
			local clientKey = 0
			local serverKey = SlackOffGameModel.instance:getServerKey(activityId)

			if clientKey == 0 or serverKey == 0 then
				printError("[YuTestPrint] =====>\t clientKey or serverKey is 0, can't send game end req")

				return
			end

			isPass = isPass or false

			local passStudents = {}

			for i, info in pairs(studenInfos) do
				if info.isPass and info.curProg < info.maxProg then
					table.insert(passStudents, info.studentId)
				end
			end

			local encryptedKey = GameUtil.getClientEncryptedKey(clientKey, serverKey, {
				isPass and 1 or 0
			})

			SlackOffGameAgent.instance:sendPM_SlackOffGameEndReq(activityId, isPass, passStudents, encryptedKey)
		end
	end
end

function SlackOffGameController:setSpriteToImage(icon, folderUrl, imgName)
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

function SlackOffGameController:setSliderValue(progBar, progText, cfg, progress)
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

SlackOffGameController.instance = SlackOffGameController.New()

return SlackOffGameController
