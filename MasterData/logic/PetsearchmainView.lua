-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/view/PetsearchmainView.lua

module("logic.extensions.petsearch.view.PetsearchmainView", package.seeall)

local PetsearchmainView = class("PetsearchmainView", ViewComponent)

function PetsearchmainView:ctor()
	PetsearchmainView.super.ctor(self)
end

function PetsearchmainView:buildUI()
	PetsearchmainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnGo = self:getBtn("btnGo")
	self._btnTip = self:getBtn("btnTip")
	self._txtCount = self:getTxt("txtCount")
	self._txtRefreshTime = self:getTxt("searchList/txtRefreshTime")
	self._cell = self:getGo("searchList/cell")
	self._table = self:getGo("searchList/tableview")
	self._tableView = ScrollerList.create(self._table, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._goSearchAnim = self:getGo("goSearchAnim")
	self._sldProgress = self:getSlider("goSearchAnim/progress")
end

function PetsearchmainView:bindEvents()
	PetsearchmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnGo:AddClickListener(self._onClickBtnGo, self)
	self._btnTip:AddClickListener(self._onClickBtnTip, self)
end

function PetsearchmainView:unbindEvents()
	PetsearchmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function PetsearchmainView:destroyUI()
	PetsearchmainView.super.destroyUI(self)
end

function PetsearchmainView:onEnter()
	PetsearchmainView.super.onEnter(self)
	PetsearchController.instance:resetRedPoint()

	self._curCycleId = nil
	self._bossId = nil

	self:_updateInfo()
	GlobalDispatcher:addListener(GlobalNotify.RefreshSearchPet, self._updateInfo, self)
	GlobalDispatcher:addListener(GlobalNotify.StartSearchPet, self._playSearchAni, self)
end

function PetsearchmainView:onEnterFinished()
	PetsearchmainView.super.onEnterFinished(self)
end

function PetsearchmainView:onExit()
	PetsearchmainView.super.onExit(self)
	removetimer(self._updateTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.StartSearchPet, self._playSearchAni, self)
	GlobalDispatcher:removeListener(GlobalNotify.RefreshSearchPet, self._updateInfo, self)
end

function PetsearchmainView:onExitFinished()
	PetsearchmainView.super.onExitFinished(self)
end

function PetsearchmainView:_updateCell(view, cell, data)
	MaterialMgr.resetAll(cell)
	MaterialMgr.setCellByCfg(data, cell)
end

function PetsearchmainView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function PetsearchmainView:_updateInfo()
	goutil.setActive(self._goSearchAnim, false)
	PetsearchController.instance:sendGetInfo(self._updateUI, self)
end

function PetsearchmainView:_updateUI()
	self._txtCount.text = string.format("今天剩余次数：<color=#FFEDB5FF>%s</color>", PetsearchModel.instance:getCurChallengeTimes())

	local bossId = PetsearchModel.instance:getCurBossId()
	local curCycleId, curCycleTimeEnd = PetsearchConfig.instance:getCurCycleIdAndEndTimeByBossId(bossId)

	self:_updateCycle(curCycleId)
	self:_updateBossId(bossId)

	self._curCycleTimeEnd = curCycleTimeEnd
end

function PetsearchmainView:_preSecReset()
	if not self._curCycleTimeEnd then
		return
	end

	if self._curCycleTimeEnd <= ServerTime.now() then
		PetsearchController.instance:sendGetInfo(self._updateUI, self)

		return
	end

	local left = self._curCycleTimeEnd - ServerTime.now()

	if left > 0 then
		local timestr = GameUtil.FormatTimeSymbol(left)

		self._txtRefreshTime.text = string.format("名单将在：<color=#FFEDB5FF>%s</color>后更新", timestr)
	end
end

function PetsearchmainView:_updateCycle(cycleId)
	if self._curCycleId ~= cycleId then
		self._curCycleId = cycleId

		local dataList = {}
		local cfgs = PetsearchConfig.instance:getSearchPetCfgsPerCycle(self._curCycleId)

		for _, v in pairs(cfgs) do
			local teamCfg = PetsearchConfig.instance:getTeamCfg(v.creepsMasterId)
			local petRaceId = teamCfg.introdRaceId

			if checknumber(teamCfg.introdRaceId) ~= 0 then
				local petMatStr = string.format("%s:%s:0:1", MatType.Pet, petRaceId)

				table.insert(dataList, petMatStr)
			end
		end

		self._tableView:reloadData(dataList)
	end
end

function PetsearchmainView:_updateBossId(bossId)
	if bossId and bossId > 0 then
		if self._bossId ~= bossId then
			self._bossId = bossId

			if ViewMgr.instance:isOpen(ViewName.PetsearchsuccessView) then
				UIStateManager.instance:popByName(ViewName.PetsearchsuccessView)
			end

			UIStateManager.instance:push(ViewName.PetsearchsuccessView)
		end
	elseif ViewMgr.instance:isOpen(ViewName.PetsearchsuccessView) then
		FloatWordMgr.instance:show("精灵已逃逸，请重新寻觅")
		UIStateManager.instance:popByName(ViewName.PetsearchsuccessView)
		UIStateManager.instance:popByName(ViewName.PetsearchdirectView)
	end
end

function PetsearchmainView:_onClickBtnGo()
	if PetsearchModel.instance:getCurChallengeTimes() > 0 then
		PetsearchController.instance:sendSeekPet()
	else
		FloatWordMgr.instance:show("今日寻觅次数用耗尽，请明日再来！")
	end
end

function PetsearchmainView:_onClickBtnTip()
	ViewMgr.instance:open(ViewName.RulesView, "petsearch")
end

function PetsearchmainView:_playSearchAni()
	removetimer(self._updateTime, self)

	self._aniTimer = 0
	self._stepTime = 0.1
	self._totalTimer = 30
	self._stepValue = 1 / self._totalTimer
	self._sldValue = 0

	goutil.setActive(self._goSearchAnim, true)
	settimer(self._stepTime, self._updateTime, self)
end

function PetsearchmainView:_updateTime()
	self._aniTimer = self._aniTimer + 1
	self._sldValue = self._sldValue + self._stepValue

	self._sldProgress:SetValue(self._sldValue)

	if self._aniTimer >= self._totalTimer then
		removetimer(self._updateTime, self)
		goutil.setActive(self._goSearchAnim, false)

		self._bossId = 0

		self:_updateUI()
	end
end

return PetsearchmainView
