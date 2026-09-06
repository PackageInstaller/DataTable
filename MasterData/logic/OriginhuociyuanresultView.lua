-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originhuociyuan/view/OriginhuociyuanresultView.lua

module("logic.extensions.originhuociyuan.view.OriginhuociyuanresultView", package.seeall)

local OriginhuociyuanresultView = class("OriginhuociyuanresultView", ViewComponent)

function OriginhuociyuanresultView:ctor()
	OriginhuociyuanresultView.super.ctor(self)
end

function OriginhuociyuanresultView:unbindEvents()
	OriginhuociyuanresultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnOk)
end

function OriginhuociyuanresultView:bindEvents()
	OriginhuociyuanresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOk, self)
end

function OriginhuociyuanresultView:buildUI()
	OriginhuociyuanresultView.super.buildUI(self)

	self._btnOk = self:getGo("btnGroup/btnOk")
	self._txtTitle = self:getTxt("txtTitle")
	self._Text = self:getTxt("win/Text")
	self._true = self:getGo("win/true")
	self._false = self:getGo("win/false")
	self._Text2 = self:getTxt("perfectWin/Text")
	self._true2 = self:getGo("perfectWin/true")
	self._false2 = self:getGo("perfectWin/false")
	self._tablecell = self:getGo("rewards/tableview/tablecell")
	self._tableview = self:getGo("rewards/tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)

	self._emptyTips = self:getGo("emptyTips")
end

function OriginhuociyuanresultView:onExit()
	OriginhuociyuanresultView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginhuociyuanresultView:onEnter()
	OriginhuociyuanresultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._customFmtMo = params[3]

	if self._customFmtMo then
		self._formationMo = self._customFmtMo:getCurFormation()
	end

	self:_refreshUI()
end

function OriginhuociyuanresultView:_refreshUI()
	local pb = OriginHuociyuanModel.instance:getFightPb(self._activityId) or {}
	local isWin = checkbool(pb.isWin)

	if not pb.alivePetIds then
		local alivePetIds = {}

		GameUtil.SetActive(self._true, isWin)
		GameUtil.SetActive(self._false, not isWin)

		self._txtTitle.text = isWin and "战斗胜利" or "战斗失败"

		local cfg = OriginHuociyuanConfig.instance:getStageCfgById(self._activityId, self._stageId) or {}
		local alivePetNum = cfg.alivePetNum
		local curCount = #alivePetIds

		self._Text2.text = langPara("精灵存活数（<color=%s>%s</color>/%s）", (alivePetNum <= curCount or nil) and "#20b376", curCount, alivePetNum)

		GameUtil.SetActive(self._true2, alivePetNum <= curCount)
		GameUtil.SetActive(self._false2, curCount < alivePetNum)
		self._scrollList:reloadData(alivePetIds)
		GameUtil.SetActive(self._emptyTips, #alivePetIds == 0)
	end
end

function OriginhuociyuanresultView:_updateCell(view, cell, data, tag)
	if self._formationMo then
		local petMo = self._formationMo:_getPet(data)

		if petMo then
			MaterialMgr.setCellByMo(petMo, cell)
		end
	else
		local petMo = BagPetsController.instance:getPet(data)

		if petMo then
			MaterialMgr.setCellByMo(petMo, cell)
		end
	end
end

function OriginhuociyuanresultView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function OriginhuociyuanresultView:_onClickOk()
	self:close()
	BattleController.instance:endBattle()
end

return OriginhuociyuanresultView
