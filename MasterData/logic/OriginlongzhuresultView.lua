-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originlongzhu/view/OriginlongzhuresultView.lua

module("logic.extensions.originlongzhu.view.OriginlongzhuresultView", package.seeall)

local OriginlongzhuresultView = class("OriginlongzhuresultView", ViewComponent)

function OriginlongzhuresultView:unbindEvents()
	OriginlongzhuresultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnOk)
end

function OriginlongzhuresultView:bindEvents()
	OriginlongzhuresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOk, self)
end

function OriginlongzhuresultView:buildUI()
	OriginlongzhuresultView.super.buildUI(self)

	self._btnOk = self:getGo("btnGroup/btnOk")
	self._txtTitle = self:getTxt("txtTitle")
	self._rwd_tablecell = self:getGo("rewards/tableview/tablecell")
	self._rwd_tableview = self:getGo("rewards/tableview")
	self._txtTotal = self:getTxt("txtTotal")
	self._scrollList = ScrollerList.create(self._rwd_tableview, self._rwd_tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)

	self._emptyTips = self:getGo("emptyTips")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList2 = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateDescCell, self), GameUtil.handler(self._clearDescCell, self))

	self._scrollList2:setCenterMode(true)
end

function OriginlongzhuresultView:onExit()
	OriginlongzhuresultView.super.onExit(self)
	self._scrollList:dispose()
end

function OriginlongzhuresultView:onEnter()
	OriginlongzhuresultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._customFmtMo = params[3]

	if self._customFmtMo then
		self._formationMo = self._customFmtMo:getCurFormation()
	end

	self:_refreshUI()
end

function OriginlongzhuresultView:_refreshUI()
	local pb = OriginLongzhuModel.instance:getFightPb(self._activityId) or {}
	local isWin = checkbool(pb.win)
	local alivePetIds = {}

	if isWin and self._formationMo then
		for i, v in ipairs(self._formationMo:GetPositions()) do
			if v > 0 then
				table.insert(alivePetIds, v)
			end
		end
	end

	self._txtTitle.text = isWin and "战斗胜利" or "战斗失败"

	if not pb.stageInfo then
		local stageInfo = {}
		local damageScore = checknumber(stageInfo.damageScore)
		local map = {}

		for i, v in ipairs(pb.type2OriginData or {}) do
			map[v.left] = v.right
		end

		local list = {}
		local obj = {}

		obj.desc = langPara("对标记精灵的伤害:%s", checknumber(pb.damage))
		obj.value = damageScore

		table.insert(list, obj)

		local buffScore = 0

		for i, v in ipairs(stageInfo.typeScores or {}) do
			buffScore = buffScore + v.right

			local cfg = OriginLongzhuConfig.instance:getScoreTypeCfgById(self._activityId, v.left)

			if cfg then
				local obj = {}

				obj.desc = langPara("%s:%s", cfg.desc, checknumber(map[v.left]))
				obj.value = v.right

				table.insert(list, obj)
			end
		end

		self._txtTotal.text = damageScore + buffScore

		self._scrollList:reloadData(alivePetIds)
		GameUtil.SetActive(self._emptyTips, #alivePetIds == 0)
		self._scrollList2:reloadData(list)
	end
end

function OriginlongzhuresultView:_updateCell(view, cell, data, tag)
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

function OriginlongzhuresultView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function OriginlongzhuresultView:_updateDescCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtValue = goutil.findChildTextComponent(cell, "txtValue")

	txtDesc.text = data.desc
	txtValue.text = langPara("积分：%s", data.value)
end

function OriginlongzhuresultView:_clearDescCell(cell)
	return
end

function OriginlongzhuresultView:_onClickOk()
	self:close()
	BattleController.instance:endBattle()
end

return OriginlongzhuresultView
