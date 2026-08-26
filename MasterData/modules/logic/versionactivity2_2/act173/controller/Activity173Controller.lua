-- chunkname: @modules/logic/versionactivity2_2/act173/controller/Activity173Controller.lua

module("modules.logic.versionactivity2_2.act173.controller.Activity173Controller", package.seeall)

local Activity173Controller = class("Activity173Controller", BaseController)

function Activity173Controller:onInit()
	return
end

function Activity173Controller:reInit()
	return
end

function Activity173Controller:onInitFinish()
	return
end

function Activity173Controller:addConstEvents()
	return
end

function Activity173Controller:openActivity173FullView()
	ViewMgr.instance:openView(ViewName.Activity173FullView)
end

function Activity173Controller.numberDisplay(number)
	local num = tonumber(number)

	if num <= 9999 then
		return num
	else
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity173panelview_tenThousand"), math.floor(num / 10000))
	end
end

Activity173Controller.instance = Activity173Controller.New()

return Activity173Controller
