-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originalchemymengmeng/view/OriginAlchemyMengMengFightEndView.lua

module("logic.extensions.originalchemymengmeng.view.OriginAlchemyMengMengFightEndView", package.seeall)

local OriginAlchemyMengMengFightEndView = class("OriginAlchemyMengMengFightEndView", ViewComponent)

function OriginAlchemyMengMengFightEndView:ctor()
	OriginAlchemyMengMengFightEndView.super.ctor(self)
end

function OriginAlchemyMengMengFightEndView:unbindEvents()
	OriginAlchemyMengMengFightEndView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReFight)
	GameUtil.rmClickHandler(self._btnSureLose)
	GameUtil.rmClickHandler(self._btnSureWin)
end

function OriginAlchemyMengMengFightEndView:bindEvents()
	OriginAlchemyMengMengFightEndView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReFight, self._onClickBtnReFight, self)
	GameUtil.addClickHandler(self._btnSureLose, self._endFight, self)
	GameUtil.addClickHandler(self._btnSureWin, self._endFight, self)
end

function OriginAlchemyMengMengFightEndView:buildUI()
	OriginAlchemyMengMengFightEndView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._targetCell = self:getGo("targetCell")
	self._targets = self:getGo("targets")
	self._lose = self:getGo("lose")
	self._btnReFight = self:getGo("lose/btnReFight")
	self._btnSureLose = self:getGo("lose/btnSure")
	self._win = self:getGo("win")
	self._btnSureWin = self:getGo("win/btnSure")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function OriginAlchemyMengMengFightEndView:onExit()
	OriginAlchemyMengMengFightEndView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginAlchemyMengMengFightEndView:onEnter()
	OriginAlchemyMengMengFightEndView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._msg = checktable(params[1])
	self._activityId = checknumber(self._msg.activityId)
	self._stageId = checknumber(self._msg.stageId)
	self._isWin = checkbool(self._msg.isWin)
	self._isPass = checkbool(self._msg.isPass)
	self._stageCfg = OriginalChemyMengMengConfig.instance:getStageCfg(self._activityId, self._stageId) or {}

	local passMarkPos = checktable(self._msg.reachConditionPosition)

	self._markPosition = checktable(self._stageCfg.markPosition)
	self._passMarkMap = {}

	for i, posId in ipairs(passMarkPos) do
		self._passMarkMap[posId + 1] = true
	end

	self:_onSetUI()
end

function OriginAlchemyMengMengFightEndView:_onSetUI()
	local list = {}
	local tb = {}

	tb.desc = lang("击败敌阵所有精灵")
	tb.pass = self._isWin

	table.insert(list, tb)

	local markMap = self:filtMarkPosition()
	local curPosMap = {}

	for pos, markId in pairs(markMap) do
		curPosMap[markId] = curPosMap[markId] ~= nil and curPosMap[markId] and checkbool(self._passMarkMap[pos]) or checkbool(self._passMarkMap[pos])
	end

	for markId, pass in pairs(curPosMap) do
		local markCfg = OriginalChemyMengMengConfig.instance:getMarkCfg(self._activityId, markId)
		local tb = {}

		tb.desc = markCfg.desc
		tb.pass = pass

		table.insert(list, tb)
	end

	GameUtil.updateCellsList(self._targets, self._targetCell, list, self._updateTargetList, self)

	local compoundList, compoundMap = OriginalChemyMengMengController.instance:getPassGetCompoundListNMap(self._activityId, self._stageId)

	self._compoundMap = compoundMap

	self._scrollList:reloadData(compoundList)
	GameUtil.SetActive(self._win, self._isPass)
	GameUtil.SetActive(self._lose, not self._isPass)
end

function OriginAlchemyMengMengFightEndView:filtMarkPosition()
	local filMap = {}

	for pos, markId in ipairs(self._markPosition) do
		if markId > 0 then
			filMap[pos] = markId
		end
	end

	return filMap
end

function OriginAlchemyMengMengFightEndView:_updateTargetList(cell, data, index)
	local go = cell
	local imgTargetChangeComp = goutil.findChild(go, "imgTarget"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local changeIdx = data.pass and 1 or 0

	txtNum.text = data.desc

	imgTargetChangeComp:SetState(changeIdx)
	GameUtil.SetActive(go, true)
end

function OriginAlchemyMengMengFightEndView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")
	local compoundCfg = OriginalChemyMengMengConfig.instance:getCompoundCfg(self._activityId, data)
	local matType, matId, matNum = MaterialMgr.getMatParams(compoundCfg.materialStr)

	txtNum.text = self._isPass and checknumber(self._compoundMap[data]) or 0

	MaterialMgr.setIcon(item, matType, matId, nil, nil)
end

function OriginAlchemyMengMengFightEndView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.clearIcon(item)
end

function OriginAlchemyMengMengFightEndView:_onClickBtnReFight()
	local fmtMo = OriginalChemyMengMengModel.instance:getFmtMo(self._activityId)

	fmtMo:updateCfg(self._activityId, self._stageId)
	UIJumper.instance:pushOneStack(ViewName.CustomMissionView, false, fmtMo)
	BattleController.instance:endBattle()
	self:close()
end

function OriginAlchemyMengMengFightEndView:_endFight()
	BattleController.instance:endBattle()
	self:close()
end

return OriginAlchemyMengMengFightEndView
