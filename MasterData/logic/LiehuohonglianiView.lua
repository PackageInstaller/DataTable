-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/moyan/LiehuohonglianiView.lua

module("logic.extensions.timelimitedchallenge.view.moyan.LiehuohonglianiView", package.seeall)

local LiehuohonglianiView = class("LiehuohonglianiView", ViewComponent)

function LiehuohonglianiView:ctor()
	LiehuohonglianiView.super.ctor(self)
end

function LiehuohonglianiView:unbindEvents()
	LiehuohonglianiView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function LiehuohonglianiView:bindEvents()
	LiehuohonglianiView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function LiehuohonglianiView:buildUI()
	LiehuohonglianiView.super.buildUI(self)

	self._challengeId = 20
	self._type = MoyanModel.TYPE_1
	self.btnClose = self:getGo("btnClose")
	self.txtDesc = self:getTxt("bottom/txtDesc")
	self.items = {}

	for i = 1, 3 do
		local go = self:getGo("challenge/challenge_" .. i)

		table.insert(self.items, go)
	end
end

function LiehuohonglianiView:onExit()
	LiehuohonglianiView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_MOYAN_GETINFORES, self.onRefreshUI, self)
end

function LiehuohonglianiView:onEnter()
	LiehuohonglianiView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_MOYAN_GETINFORES, self.onRefreshUI, self)
	MoyanModel.instance:getSingleChanllengeInfo(self._challengeId, self._type)
	self:initView()
	self:onRefreshUI()
end

function LiehuohonglianiView:onRefreshUI()
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
	local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, self._type)
	local mo = MoyanModel.instance:getSingleInfo(self._challengeId, self._type)
	local tdPassedStage = 0

	if mo.linearSysPetTypeInfo then
		tdPassedStage = checknumber(mo.linearSysPetTypeInfo.tdPassedStage)
	end

	for i, go in ipairs(self.items) do
		local btn = goutil.findChild(go, "btn")
		local pass = goutil.findChild(go, "pass")

		GameUtil.SetActive(pass, i <= tdPassedStage)
		GameUtil.SetActive(btn, tdPassedStage < i)
	end
end

function LiehuohonglianiView:clickStart(idx)
	local mo = MoyanModel.instance:getSingleInfo(self._challengeId, self._type)

	if idx == ((mo.linearSysPetTypeInfo or nil) and checknumber(mo.linearSysPetTypeInfo.tdPassedStage)) + 1 then
		local params = {}

		params.challengeId = self._challengeId
		params.type = self._type
		params.stageId = idx

		UIStateManager.instance:push(ViewName.MoyanMissionView, params)
	else
		TipsFacade.instance:openCommonTips(lang("liehuohonglianiview__1"))
	end
end

function LiehuohonglianiView:initView()
	local baseCfg = MoyanConfig.instance:getBaseConfig(self._challengeId) or {}
	local cfg = MoyanConfig.instance:getPlanCfg(baseCfg.challengePlan, self._type)

	self.txtDesc.text = cfg.desc

	local stagePlan = cfg.stagePlan

	for i, go in ipairs(self.items) do
		local btn = goutil.findChild(go, "btn")
		local pass = goutil.findChild(go, "pass")
		local posCellList = {}

		for j = 1, 9 do
			local con = goutil.findChild(go, "formation/cell_" .. j .. "/con")

			MaterialMgr.resetAll(con)
			table.insert(posCellList, con)
		end

		GameUtil.addClickHandler(btn, GameUtil.handler(self.clickStart, self, i))

		local temp = MoyanConfig.instance:getMonsterCfg(stagePlan, i)
		local creepsMasterId = -1

		if temp then
			creepsMasterId = temp.creepsMasterId
		end

		if creepsMasterId > 0 then
			for k, cr in pairs((MoyanConfig.instance:getCreepsCfg(creepsMasterId))) do
				local con = posCellList[cr.posId]
				local skinId = checknumber(cr.faceId)

				if skinId == 0 then
					skinId = checknumber(cr.raceId)
				end

				MaterialMgr.setCell(MatType.Pet, skinId, con)
			end
		end
	end
end

return LiehuohonglianiView
