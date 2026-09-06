-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ciyuanlonghuangnuoya/view/CiyuanlonghuangnuoyaresultlView.lua

module("logic.extensions.ciyuanlonghuangnuoya.view.CiyuanlonghuangnuoyaresultlView", package.seeall)

local CiyuanlonghuangnuoyaresultlView = class("CiyuanlonghuangnuoyaresultlView", ViewComponent)

function CiyuanlonghuangnuoyaresultlView:unbindEvents()
	CiyuanlonghuangnuoyaresultlView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnOk)
	GameUtil.rmClickHandler(self._btnCancel)
end

function CiyuanlonghuangnuoyaresultlView:bindEvents()
	CiyuanlonghuangnuoyaresultlView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnOk, self._onClickOK, self)
end

function CiyuanlonghuangnuoyaresultlView:buildUI()
	CiyuanlonghuangnuoyaresultlView.super.buildUI(self)

	self._btnOk = self:getGo("btnOk")
	self._btnCancel = self:getGo("btnCancel")
	self._txtDesc = self:getTxt("txtDesc")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._empty = self:getGo("empty")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)
end

function CiyuanlonghuangnuoyaresultlView:onExit()
	CiyuanlonghuangnuoyaresultlView.super.onExit(self)
	self._scrollList:dispose()
end

function CiyuanlonghuangnuoyaresultlView:onEnter()
	CiyuanlonghuangnuoyaresultlView.super.onEnter(self)

	local pb = self:getFirstParam()

	if pb == nil then
		self:close()
	else
		self._activityId = pb.activityId
		self._confirmNum = pb.confirmNum
		self._info = CiyuanlonghuangnuoyaModel.instance:getInfo(self._activityId) or {}

		if not pb.curFightRaceIdLocked then
			local curFightRaceIdLocked = {}

			self._scrollList:reloadData(curFightRaceIdLocked)
			GameUtil.SetActive(self._empty, #curFightRaceIdLocked == 0)

			local curFightTotalTimeScore = checknumber(pb.curFightTotalTimeScore)

			if not pb.curFightBalanceInfo then
				local arr = {}

				for i, v in ipairs(pb.curFightBalanceInfo) do
					local planId = v.left
					local cfg = CiyuanlonghuangnuoyaConfig.instance:getPlanCfgById(planId)

					if cfg then
						local desc = langPara(cfg.desc, v.right)

						table.insert(arr, desc)
					end
				end

				self._txtDesc.text = langPara("本次获得时间点数：%s\n%s", curFightTotalTimeScore, table.concat(arr, ","))
			end
		end
	end
end

function CiyuanlonghuangnuoyaresultlView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local lock = goutil.findChild(cell, "lock")

	MaterialMgr.setCell(MatType.Pet, data, con)
	GameUtil.SetActive(lock, true)
end

function CiyuanlonghuangnuoyaresultlView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function CiyuanlonghuangnuoyaresultlView:_onClickOK()
	BattleController.instance:endBattle()
	CiyuanlonghuangnuoyaController.instance:sendConfirm(self._activityId, self._confirmNum, true)
	self:close()
end

function CiyuanlonghuangnuoyaresultlView:_onClickClose()
	BattleController.instance:endBattle()
	CiyuanlonghuangnuoyaController.instance:sendConfirm(self._activityId, self._confirmNum, false)
	self:close()
end

return CiyuanlonghuangnuoyaresultlView
