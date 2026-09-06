-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/controller/JiuGongController.lua

module("logic.extensions.challenge.controller.JiuGongController", package.seeall)

local JiuGongController = class("JiuGongController", BaseController)

function JiuGongController:loadXiuLianInfo()
	JiuGongFairyStrengthAgent.instance:sendPM_JiuGongFairyStrengthReq(function(msg)
		local prizeinfo = msg.prizeInfo

		JiuGongModel.instance:setPrizeInfos(prizeinfo, true)
		self:localNotify("XiuLianInfoGot")
	end)
end

function JiuGongController:startXiuLian()
	return
end

function JiuGongController:getNow(prizeIndex, callBack)
	JiuGongFairyStrengthAgent.instance:sendPM_JiuGongFairyOneKeyClearCdReq(prizeIndex, function(msg)
		JiuGongModel.instance:updateTime(msg.prizeIndex + 1, 0)
		JiuGongModel.instance:updateFinishFlag(msg.prizeIndex + 1, false)
		self:localNotify("XiuLianInfoGot")
		GameUtil.callBack(callBack)
	end)
end

function JiuGongController:getPrize(prizeIndex, petId, equipStarGod)
	return
end

function JiuGongController:goChallenge(index, callBack)
	JiuGongFairyStrengthAgent.instance:sendPM_JiuGongFairyStrengthChallengeReq(index, function(msg)
		GameUtil.callBack(callBack)
	end)
end

JiuGongController.instance = JiuGongController.New()

return JiuGongController
