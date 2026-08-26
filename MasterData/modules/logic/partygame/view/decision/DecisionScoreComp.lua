-- chunkname: @modules/logic/partygame/view/decision/DecisionScoreComp.lua

module("modules.logic.partygame.view.decision.DecisionScoreComp", package.seeall)

local DecisionScoreComp = class("DecisionScoreComp", LuaCompBase)

function DecisionScoreComp:init(go)
	self.go = go
	self._txtScore = gohelper.findChildText(go, "#txt_score")
end

function DecisionScoreComp:initData(data)
	self._data = data
	self._uiFollower = gohelper.onceAddComponent(self.go, typeof(ZProj.UIFollower))

	self._uiFollower:SetEnable(true)

	if not self._newgo then
		self._newgo = gohelper.create3d()
		self._newgo.transform.position = self._data.pos

		local mainCamera = CameraMgr.instance:getMainCamera()
		local uiCamera = CameraMgr.instance:getUICamera()
		local plane = ViewMgr.instance:getUIRoot().transform

		self._uiFollower:Set(mainCamera, uiCamera, plane, self._newgo.transform, 0, 0, 0, 0, 0)
	end
end

function DecisionScoreComp:update()
	local round = PartyGameHelper.instance:getSingleComponentData("PartyGame.Runtime.Games.Decision.Component.DecisionDataComponent", "curRound")
	local cfgId = PartyGameHelper.instance:getSingleComponentData("PartyGame.Runtime.Games.Decision.Component.DecisionDataComponent", "cfgGroupId")
	local co = GameUtil.getTbValue(lua_partygame_decision.configDict, round, cfgId)

	if not co then
		return
	end

	self._txtScore.text = tostring(co["pos" .. self._data.index])
end

function DecisionScoreComp:onDestroy()
	if self._newgo then
		gohelper.destroy(self._newgo)

		self._newgo = nil
	end
end

return DecisionScoreComp
