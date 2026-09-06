-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/model/HdsummerlotteryrecommendModel.lua

module("logic.extensions.hdsummerlotteryrecommend.view.HdsummerlotteryrecommendModel", package.seeall)

local HdsummerlotteryrecommendModel = class("HdsummerlotteryrecommendModel", BaseModel)
local Dot1_KEY = "HdsummerlotteryrecommendDot1"

function HdsummerlotteryrecommendModel:ctor()
	return
end

function HdsummerlotteryrecommendModel:onInit()
	self:onReset()
end

function HdsummerlotteryrecommendModel:onReset()
	return
end

function HdsummerlotteryrecommendModel:checkRedDot()
	local str = GameUtil.getUserData(Dot1_KEY)

	if string.nilorempty(str) then
		return true
	end

	return false
end

function HdsummerlotteryrecommendModel:clearClickDot()
	GameUtil.saveUserData(Dot1_KEY, "finish")
end

HdsummerlotteryrecommendModel.instance = HdsummerlotteryrecommendModel.New()

return HdsummerlotteryrecommendModel
