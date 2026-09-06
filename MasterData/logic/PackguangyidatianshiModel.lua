-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/model/PackguangyidatianshiModel.lua

module("logic.extensions.hdsummerlotteryrecommend.view.PackguangyidatianshiModel", package.seeall)

local PackguangyidatianshiModel = class("PackguangyidatianshiModel", BaseModel)
local Dot1_KEY = "PackguangyidatianshiModelDot1"

function PackguangyidatianshiModel:ctor()
	return
end

function PackguangyidatianshiModel:onInit()
	self:onReset()
end

function PackguangyidatianshiModel:onReset()
	return
end

function PackguangyidatianshiModel:checkRedDot()
	local str = GameUtil.getUserData(Dot1_KEY)

	if string.nilorempty(str) then
		return true
	end

	return false
end

function PackguangyidatianshiModel:clearClickDot()
	GameUtil.saveUserData(Dot1_KEY, "finish")
end

PackguangyidatianshiModel.instance = PackguangyidatianshiModel.New()

return PackguangyidatianshiModel
