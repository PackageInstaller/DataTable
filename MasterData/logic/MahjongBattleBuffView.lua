-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mahjongbattle/view/MahjongBattleBuffView.lua

module("logic.extensions.mahjongbattle.view.MahjongBattleBuffView", package.seeall)

local MahjongBattleBuffView = class("MahjongBattleBuffView", ViewComponent)

function MahjongBattleBuffView:ctor()
	MahjongBattleBuffView.super.ctor(self)
end

function MahjongBattleBuffView:unbindEvents()
	MahjongBattleBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function MahjongBattleBuffView:bindEvents()
	MahjongBattleBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function MahjongBattleBuffView:buildUI()
	MahjongBattleBuffView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")

	local goTab = self:getGo("tableview")
	local goCell = self:getGo("buffcell")

	self._tableview = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function MahjongBattleBuffView:onExit()
	MahjongBattleBuffView.super.onExit(self)
	self._tableview:dispose()
end

function MahjongBattleBuffView:onEnter()
	MahjongBattleBuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MahjongBattleSelectSummonBuffRes, self._handleSelectBuff, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 571001
	end

	if not self:_checkState() then
		self:close()
		MahjongBattleController.instance:continueGame(self._activityId)

		return
	end

	self._curSelectBuffId = 0

	self:_updateUIByInfo()
end

function MahjongBattleBuffView:_updateUIByInfo()
	self._curBuffCfgs = {}

	local challengeInfo = MahjongBattleModel.instance:getCurChallengeInfoByActId(self._activityId)

	if challengeInfo then
		if not challengeInfo.summonType then
			local summonType = 0
			local summonCfg = MahjongBattleConfig.instance:getSummonTypeCfgById(self._activityId, summonType)

			if summonCfg then
				if not summonCfg.buffPlan then
					self._curBuffCfgs = MahjongBattleConfig.instance:getSummonBuffCfgsByPlan(self._activityId, summonCfg.buffPlan) or {}
				end
			end
		end
	end

	self:_onClickBuffCell(0)
end

function MahjongBattleBuffView:_updateCell(view, cell, data)
	local go = cell.gameObject

	GameUtil.addClickHandler(go, GameUtil.handler(self._onClickBuffCell, self, data.buffId))

	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "sv/Viewport/txtDesc")
	local select = goutil.findChild(go, "select")

	txtName.text = data.buffName or ""
	txtDesc.text = data.buffDesc or ""

	goutil.setActive(select, self._curSelectBuffId == data.buffId)

	local goBuffIcon = goutil.findChild(go, "buffIcon")
	local spriteName = GameUrl.getIconUrl(data.buffIcon)

	uGuiUtil.setSpriteToImage(goBuffIcon, nil, spriteName)
end

function MahjongBattleBuffView:_clearCell(cell)
	local go = cell.gameObject

	GameUtil.rmClickHandler(go)

	local goBuffIcon = goutil.findChild(go, "buffIcon")

	uGuiUtil.clearImage(goBuffIcon)
end

function MahjongBattleBuffView:_onClickBuffCell(buffId)
	self._curSelectBuffId = buffId or 0

	self._tableview:reloadData(self._curBuffCfgs)
	self._tableview:setCenterMode(true)
end

function MahjongBattleBuffView:_onClickSure()
	if self._curSelectBuffId == 0 then
		FloatWordMgr.instance:show(lang("请先选择Buff"))

		return
	end

	MahjongBattleController.instance:selectSummonBuff(self._activityId, self._curSelectBuffId)
end

function MahjongBattleBuffView:_checkState()
	local state = MahjongBattleModel.instance:getCurStateByActId(self._activityId)

	return state == MahjongBattleModel.PLAYER_STATE.WAITING_SELECT_SUMMON_BUFF
end

function MahjongBattleBuffView:_handleSelectBuff()
	if not self:_checkState() then
		self:close()
		MahjongBattleController.instance:continueGame(self._activityId)
	end
end

return MahjongBattleBuffView
