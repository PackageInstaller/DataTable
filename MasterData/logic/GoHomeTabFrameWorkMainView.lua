-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/gohome/GoHomeTabFrameWorkMainView.lua

module("logic.extensions.playerreturn.view.gohome.GoHomeTabFrameWorkMainView", package.seeall)

local GoHomeTabFrameWorkMainView = class("GoHomeTabFrameWorkMainView", TabFrameWorkMainView)

function GoHomeTabFrameWorkMainView:_updateHeadTabCell(mainGo, headTabIndex)
	GoHomeTabFrameWorkMainView.super._updateHeadTabCell(self, mainGo, headTabIndex)

	local info = self:_getHeadTabViewInfo(headTabIndex)
	local isUnlock = info.isUnlock
	local rec = goutil.findChild(mainGo, "rec")
	local txtRec = goutil.findChildTextComponent(mainGo, "rec/txt")
	local recStr = info.data.exTabParams
	local isNeedRec = isUnlock and not string.nilorempty(recStr)

	GameUtil.SetActive(rec, isNeedRec)

	if isNeedRec then
		txtRec.text = recStr

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rec:GetComponent(goutil.Type_RectTransform))
	end
end

function GoHomeTabFrameWorkMainView:_updateSecTabCell(mainGo, headTabIndex, secTabIndex)
	GoHomeTabFrameWorkMainView.super._updateSecTabCell(self, mainGo, headTabIndex, secTabIndex)

	local info = self:_getSecTabViewInfo(headTabIndex, secTabIndex)
	local isUnlock = info.isUnlock
	local rec = goutil.findChild(mainGo, "rec")
	local txtRec = goutil.findChildTextComponent(mainGo, "rec/txt")
	local recStr = info.data.exTabParams
	local isNeedRec = isUnlock and not string.nilorempty(recStr)

	GameUtil.SetActive(rec, isNeedRec)

	if isNeedRec then
		txtRec.text = recStr

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(rec:GetComponent(goutil.Type_RectTransform))
	end
end

return GoHomeTabFrameWorkMainView
