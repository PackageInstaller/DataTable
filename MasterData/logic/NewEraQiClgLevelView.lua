-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wuwenchallenge/view/newerachallenge/NewEraQiClgLevelView.lua

module("logic.extensions.wuwenchallenge.view.newerachallenge.NewEraQiClgLevelView", package.seeall)

local NewEraQiClgLevelView = class("NewEraQiClgLevelView", WuWenChallengeLevelView)

function NewEraQiClgLevelView:_updateLevelCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgClick = goutil.findChild(go, "btnClick/bg")
	local bgClickSelect = goutil.findChild(go, "btnClick/bgSelect")
	local btnClick = goutil.findChild(go, "btnClick")
	local changeImage = goutil.findChildComponent(go, "btnClick", "UIImageSpriteChange")
	local imgSelect = goutil.findChild(go, "imgSelect")
	local bubble = goutil.findChild(go, "bubble")
	local txtBubble = goutil.findChildTextComponent(go, "bubble/txt")
	local prizeCon = goutil.findChild(go, "bubble/con")
	local lock = goutil.findChild(go, "lock")
	local txtName = goutil.findChildTextComponent(btnClick, "txt")
	local passLevel = WuWenChallengeModel.instance:getCurLevel(self._activityId)

	txtName.text = data.name

	if changeImage then
		changeImage:SetState(self._curLevel == data.phaseId and 1 or 0)
	end

	if bgClick and bgClickSelect then
		GameUtil.SetActive(bgClick, self._curLevel ~= data.phaseId)
		GameUtil.SetActive(bgClickSelect, self._curLevel == data.phaseId)
	end

	GameUtil.SetActive(imgSelect, self._curLevel == data.phaseId)
	GameUtil.SetActive(lock, passLevel < data.phaseId or ServerTime.now() < GameUtil.string2time(data.openTime))
	GameUtil.SetActive(bubble, data.phaseId == passLevel and self._curLevel == data.phaseId)

	local matType, matId, matNum = MaterialMgr.getMatParams(data.prize)

	MaterialMgr.setCellByCfg(data.prize, prizeCon)

	txtBubble.text = langPara("通关可获得%s*%d", MaterialMgr.getMaterialsName(matType, matId), matNum)

	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickLevel(data.phaseId)
	end, self)
end

function NewEraQiClgLevelView:getSurviveColor()
	return "#ffff9b"
end

function NewEraQiClgLevelView:getCurResetViewName()
	return ViewName.NewEraQiClgResetView
end

return NewEraQiClgLevelView
