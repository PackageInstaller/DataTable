-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationLevelView.lua

module("logic.extensions.threeelimination.view.ThreeEliminationLevelView", package.seeall)

local ThreeEliminationLevelView = class("ThreeEliminationLevelView", ViewComponent)

function ThreeEliminationLevelView:ctor()
	ThreeEliminationLevelView.super.ctor(self)
end

function ThreeEliminationLevelView:unbindEvents()
	ThreeEliminationLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function ThreeEliminationLevelView:bindEvents()
	ThreeEliminationLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function ThreeEliminationLevelView:buildUI()
	ThreeEliminationLevelView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtBtn = self:getTxt("btnSure/txt")
	self._txtCurLevel = self:getTxt("level/txtCur")
	self._imgLevelArrow = self:getGo("level/imgArrow")
	self._txtNextLevel = self:getTxt("level/txtNext")
	self._tableView = self:getGo("tableview")
	self._tableCell = self:getGo("qualityCell")
	self._cost = self:getGo("cost")
	self._costCon = self:getGo("cost/con")
	self._txtCost = self:getTxt("cost/txtCost")
	self._maxLevelGo = self:getGo("maxLevel")
end

function ThreeEliminationLevelView:onExit()
	ThreeEliminationLevelView.super.onExit(self)
end

function ThreeEliminationLevelView:onEnter()
	ThreeEliminationLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ThreeEliminationGameLvlUpPlayerRes, self._refreshView, self)

	self._qualityList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityId = self:getFirstParam()

	self:_refreshView()
end

function ThreeEliminationLevelView:_refreshView()
	self._curCfg = ThreeEliminationConfig.instance:getPlayerLevelCfg(self._activityId, ThreeEliminationOtherModel.instance:getPlayerLv())
	self._nextCfg = ThreeEliminationConfig.instance:getPlayerLevelCfg(self._activityId, ThreeEliminationOtherModel.instance:getPlayerLv() + 1)
	self._txtCurLevel.text = langPara("%d", self._curCfg.playerLvl)

	GameUtil.SetActive(self._imgLevelArrow, self._nextCfg ~= nil)
	GameUtil.SetActive(self._txtNextLevel, self._nextCfg ~= nil)
	GameUtil.SetActive(self._cost, self._nextCfg ~= nil)

	if self._nextCfg then
		self._txtNextLevel.text = self._nextCfg.playerLvl

		local matType, matId, matNum = MaterialMgr.getMatParams(self._nextCfg.lvlUpCost)

		MaterialMgr.setIcon(self._costCon, matType, matId)

		self._txtCost.text = matNum
		self._txtBtn.text = lang("升级")

		GameUtil.SetActive(self._maxLevelGo, false)
	else
		GameUtil.SetActive(self._maxLevelGo, true)

		self._txtBtn.text = lang("确认")
	end

	self._qualityList:reloadData(ThreeEliminationConfig.instance:getQualityCfgs(self._activityId))
end

function ThreeEliminationLevelView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtQuality = goutil.findChildTextComponent(go, "txtQuality")
	local colorChangeQuality = goutil.findChildComponent(go, "txtQuality", "UITextColorChange")
	local txtCur = goutil.findChildTextComponent(go, "txtCur")
	local txtNext = goutil.findChildTextComponent(go, "txtNext")
	local imgArrow = goutil.findChild(go, "imgArrow")
	local curLevel = self._curCfg.playerLvl
	local curLevelQualityCfg = data[curLevel]

	txtQuality.text = curLevelQualityCfg.desc
	txtCur.text = langPara("%d万", curLevelQualityCfg.zdl)

	colorChangeQuality:SetState(curLevelQualityCfg.quality - 1)

	if self._nextCfg then
		local nextLevel = self._nextCfg.playerLvl
		local nextLevelQualityCfg = data[nextLevel]

		if nextLevelQualityCfg.zdl == curLevelQualityCfg.zdl then
			GameUtil.SetActive(imgArrow, false)
			GameUtil.SetActive(txtNext, false)
		else
			GameUtil.SetActive(imgArrow, true)
			GameUtil.SetActive(txtNext, true)

			txtNext.text = langPara("%d万", nextLevelQualityCfg.zdl)
		end
	else
		GameUtil.SetActive(imgArrow, false)
		GameUtil.SetActive(txtNext, false)
	end
end

function ThreeEliminationLevelView:_clearCell(cell)
	return
end

function ThreeEliminationLevelView:_onClickSure()
	if self._nextCfg then
		local matType, matId, matNum = MaterialMgr.getMatParams(self._nextCfg.lvlUpCost)

		if MaterialModel.instance:IsEnough(matType, matId, matNum) == true then
			ThreeEliminationGameAgent.instance:sendPM_ThreeEliminationGameLvlUpPlayerReq(self._activityId)
		else
			FloatWordMgr.instance:show(lang("材料不足"))
		end
	else
		self:close()
	end
end

return ThreeEliminationLevelView
