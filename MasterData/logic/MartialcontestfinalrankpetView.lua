-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalrankpetView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalrankpetView", package.seeall)

local MartialcontestfinalrankpetView = class("MartialcontestfinalrankpetView", ViewComponent)

function MartialcontestfinalrankpetView:ctor()
	MartialcontestfinalrankpetView.super.ctor(self)
end

function MartialcontestfinalrankpetView:unbindEvents()
	MartialcontestfinalrankpetView.super.unbindEvents(self)
end

function MartialcontestfinalrankpetView:bindEvents()
	MartialcontestfinalrankpetView.super.bindEvents(self)
end

function MartialcontestfinalrankpetView:buildUI()
	MartialcontestfinalrankpetView.super.buildUI(self)

	self._rankScrollerview = goutil.findChild(self.mainGO, "rankCol/rankScrollerview")
	self._rankScrollercell = goutil.findChild(self.mainGO, "rankCol/rankScrollercell")
	self._emptyGo = goutil.findChild(self.mainGO, "rankCol/emptyGo")
	self._rankScrollList = ScrollerList.create(self._rankScrollerview, self._rankScrollercell, GameUtil.handler(self._updateRankCell, self), GameUtil.handler(self._clearRankCell, self))
	self._itemScrollercell = goutil.findChild(self.mainGO, "rankCol/itemScrollercell")
	self._itemScrollListDic = {}

	GameUtil.SetActive(self._itemScrollercell, false)

	self._txtUp = self:getTxt("rankCol/titleCol/txtUp")
	self._txtTip1 = self:getTxt("tipsCol/txtTip1")
end

function MartialcontestfinalrankpetView:onExit()
	MartialcontestfinalrankpetView.super.onExit(self)
	self._rankScrollList:dispose()
end

function MartialcontestfinalrankpetView:onEnter()
	MartialcontestfinalrankpetView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._tabId = checknumber(params[2])
	self._tabCfg = MartialContestConfig.instance:getFinalsRankViewCfg(self._tabId)
	self._txtTip1.text = self._tabCfg.txtTips

	local arr = string.split(self._tabCfg.param, "#")
	local stepId = checknumber(arr[1])

	self._winRank = checknumber(arr[2]) == 1
	self._stepId = stepId
	self._rankList = {}
	self._txtUp.text = not self._winRank and "上阵次数" or "上阵胜率"

	self.addGEvent(self, GlobalNotify.MCQualifierPetRaceRankRes, self._onMCQualifierPetRaceRankRes, self)
	MartialContestAgent.instance:sendPM_MCQualifierPetRaceRankReq(self._activityId, self._stepId, self._winRank)
end

function MartialcontestfinalrankpetView:_onMCQualifierPetRaceRankRes(msg)
	if msg.activityId ~= self._activityId then
		return
	end

	self._rankList = msg.infoList or {}

	self:_onUpdate()
end

function MartialcontestfinalrankpetView:_onUpdate()
	GameUtil.SetActive(self._emptyGo, #self._rankList <= 0)
	self._rankScrollList:reloadData(self._rankList)

	local idx = 0
	local isMotion = true

	self._rankScrollList:MoveCellInView(idx, isMotion)
end

function MartialcontestfinalrankpetView:_updateRankCell(view, cell, info, tag)
	local rank = info.rank
	local mainGo = cell.gameObject
	local headGo = goutil.findChild(mainGo, "headRoot/head")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtRank = goutil.findChildTextComponent(mainGo, "txtRank")
	local txtUp = goutil.findChildTextComponent(mainGo, "txtUp")
	local imgRank = goutil.findChildComponent(mainGo, "imgRank", ComponentType.UIImageSpriteChange)

	txtRank.text = rank

	local isTop3 = checknumber(rank) <= 3

	imgRank.gameObject:SetActive(isTop3)
	txtRank.gameObject:SetActive(not isTop3)

	if isTop3 then
		imgRank:SetState(rank - 1)
	end

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(info.raceId)

	txtName.text = petSkinCfg.skinName

	if not self._winRank then
		txtUp.text = info.fightTimes or langPara("%s%%", info.winRate)
	end

	MaterialMgr.setIcon(headGo, MatType.Pet, info.raceId)
end

function MartialcontestfinalrankpetView:_clearRankCell(cell)
	local mainGo = cell.gameObject
	local headGo = goutil.findChild(mainGo, "headRoot/head")

	MaterialMgr.resetAll(headGo)
end

function MartialcontestfinalrankpetView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function MartialcontestfinalrankpetView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return MartialcontestfinalrankpetView
