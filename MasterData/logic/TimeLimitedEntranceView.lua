-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TimeLimitedEntranceView.lua

module("logic.extensions.timelimitedchallenge.view.TimeLimitedEntranceView", package.seeall)

local TimeLimitedEntranceView = class("TimeLimitedEntranceView", ViewComponent)

function TimeLimitedEntranceView:unbindEvents()
	TimeLimitedEntranceView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnRule:RemoveClickListener()
end

function TimeLimitedEntranceView:bindEvents()
	TimeLimitedEntranceView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
end

function TimeLimitedEntranceView:buildUI()
	TimeLimitedEntranceView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._challenges = self:getGo("challenges")
	self._btnRule = self:getBtn("topleft/btnRule")
end

function TimeLimitedEntranceView:onExit()
	TimeLimitedEntranceView.super.onExit(self)

	for _, v in ipairs(self._roles) do
		RoleObjectPool.instance:removeRole(v)
	end

	for _, v in ipairs(self._cells) do
		MaterialMgr.resetAll(v)
	end

	self._cells = nil
	self._roles = nil
end

function TimeLimitedEntranceView:onEnter()
	TimeLimitedEntranceView.super.onEnter(self)

	self._cfgs = {}

	table.insert(self._cfgs, TimeLimitedConfig.instance:getCfgById(1))
	table.insert(self._cfgs, TimeLimitedConfig.instance:getCfgById(2))

	self._roles = {}
	self._cells = {}

	GameUtil.updateCells(self._challenges, self._cfgs, self._updateOneChallenge, self)
end

function TimeLimitedEntranceView:_updateOneChallenge(go, data)
	local raceId = data.raceId
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local pointRare = goutil.findChild(go, "pointRare")
	local pointRole = goutil.findChild(go, "pointRole")
	local txtLeftTime = goutil.findChildTextComponent(go, "txtLeftTime")
	local btn = Framework.ButtonAdapter.Get(go)

	btn:AddClickListener(function()
		self:_onClickChallenge(data)
	end)

	local petCo = CharacterConfig.instance:getPetCo(raceId)

	txtName.text = petCo.name

	MaterialMgr.setCell(MatType.Rare, raceId, pointRare)
	table.insert(self._cells, pointRare)

	local idx = #self._roles + 1

	self._roles[idx] = RoleObjectPool.instance:addRoleToParent(self._roles[idx], raceId, pointRole)
	txtLeftTime.text = string.format("距离活动时间结束：%s", TLChallengeController.instance:getLeftTimeFormat(data.challengeId))
end

function TimeLimitedEntranceView:_onClickChallenge(data)
	self:close()
	GotoMgr.gotoByString(data.jumpTo)
end

function TimeLimitedEntranceView:_onClickClose()
	self:close()
end

function TimeLimitedEntranceView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "tlchallenge")
end

return TimeLimitedEntranceView
