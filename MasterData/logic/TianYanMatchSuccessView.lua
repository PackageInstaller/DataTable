-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchSuccessView.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchSuccessView", package.seeall)

local TianYanMatchSuccessView = class("TianYanMatchSuccessView", ViewComponent)

function TianYanMatchSuccessView:ctor()
	TianYanMatchSuccessView.super.ctor(self)
end

function TianYanMatchSuccessView:unbindEvents()
	TianYanMatchSuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function TianYanMatchSuccessView:bindEvents()
	TianYanMatchSuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function TianYanMatchSuccessView:buildUI()
	TianYanMatchSuccessView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._imgToy1 = self:getGo("info/combo/comboCon/imgToy1")
	self._imgToy2 = self:getGo("info/combo/comboCon/imgToy2")
	self._tableview = self:getGo("info/prize/tableview")
	self._tablecell = self:getGo("info/prize/tableview/tablecell")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtName = self:getTxt("info/combo/comboCon/name/txtName")
end

function TianYanMatchSuccessView:onExit()
	TianYanMatchSuccessView.super.onExit(self)
	uGuiUtil.clearImage(self._imgToy1)
end

function TianYanMatchSuccessView:onEnter()
	TianYanMatchSuccessView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_TianYanMatchGainMatchPrizeRes, self.close, self)

	self._activityId = checknumber(self:getFirstParam())

	local activityCfg = TianYanMatchConfig.instance:getActivityCfg(self._activityId)
	local info = TianYanMatchModel.instance:getMatchResultInfo(self._activityId)
	local toy1Cfg = TianYanMatchConfig.instance:getToyCfg(self._activityId, info.myToyId)

	uGuiUtil.setSpriteToImage(self._imgToy1, nil, toy1Cfg.res)

	local toy2Cfg = TianYanMatchConfig.instance:getToyCfg(self._activityId, info.matchToyId)

	if toy2Cfg then
		uGuiUtil.setSpriteToImage(self._imgToy2, nil, toy2Cfg.res)
	end

	local specialMatchId = 0
	local specialMatchCfgs = TianYanMatchConfig.instance:getSpecialMatchCfgs(self._activityId)

	for i, v in ipairs(specialMatchCfgs) do
		if v.matchToyIds[1] == info.myToyId and v.matchToyIds[2] == info.matchToyId or v.matchToyIds[2] == info.myToyId and v.matchToyIds[1] == info.matchToyId then
			specialMatchId = v.matchId

			break
		end
	end

	local prizeList
	local scoreMatType, scoreMatId, _ = MaterialMgr.getMatParams(activityCfg.scoreItem)

	if specialMatchId ~= 0 then
		local specialCfg = specialMatchCfgs[specialMatchId]

		prizeList = string.split(specialCfg.matchPrize, "#")

		if checknumber(specialCfg.matchScore) > 0 then
			table.insert(prizeList, string.format("%d:%d:%d", scoreMatType, scoreMatId, specialCfg.matchScore))
		end
	else
		prizeList = string.split(activityCfg.normalMatchPrize, "#")

		if checknumber(activityCfg.normalMatchScore) > 0 then
			table.insert(prizeList, string.format("%d:%d:%d", scoreMatType, scoreMatId, activityCfg.normalMatchScore))
		end
	end

	self._tableList:reloadData(prizeList)

	local manualId = 0
	local manualCfgs = TianYanMatchConfig.instance:getManualCfgs(self._activityId)

	for i, v in ipairs(manualCfgs) do
		if v.matchToyIds[1] == info.myToyId and v.matchToyIds[2] == info.matchToyId or v.matchToyIds[2] == info.myToyId and v.matchToyIds[1] == info.matchToyId then
			manualId = v.manualId

			break
		end
	end

	if manualId ~= 0 then
		local manualCfg = manualCfgs[manualId]

		self._txtName.text = manualCfg.name
	else
		self._txtName.text = lang("普通组合")
	end
end

function TianYanMatchSuccessView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function TianYanMatchSuccessView:_clearCell(cell)
	local go = cell.gameObject

	MaterialMgr.resetAll(go)
end

function TianYanMatchSuccessView:_onClickSure()
	TianYanMatchAgent.instance:sendPM_TianYanMatchGainMatchPrizeReq(self._activityId)
end

return TianYanMatchSuccessView
