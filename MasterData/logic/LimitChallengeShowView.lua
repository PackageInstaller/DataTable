-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/limit/LimitChallengeShowView.lua

module("logic.extensions.legend.view.limit.LimitChallengeShowView", package.seeall)

local LimitChallengeShowView = class("LimitChallengeShowView", ViewComponent)

function LimitChallengeShowView:buildUI(go)
	printInfo("test buildUI")

	self.mainGO = go
	self._closeButton = self:getBtn("btnClose")
	self._role = self:getGo("role")
	self._btnSkill = self:getBtn("info/btnSkill")
	self._btnIntroduce = self:getBtn("info/btnIntroduce")
	self._btnStart = self:getBtn("btnStart")
	self._pointRare = self:getGo("info/pointRare")
	self._redPoint = goutil.findChild(self._btnStart.gameObject, "dot")
	self._txtLeftTime = self:getTxt("txtLeftTime")
end

function LimitChallengeShowView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnIntroduce:AddClickListener(self._onClickIntroduce, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
end

function LimitChallengeShowView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnIntroduce:RemoveClickListener()
	self._btnStart:RemoveClickListener()
end

function LimitChallengeShowView:onEnter(id)
	self._cfg = TimeLimitedConfig.instance:getCfgById(id)

	if not self._cfg then
		return
	end

	local redPointIds = TimeLimitedConfig.instance:getRedPointIds(id)

	RedPointController.instance:regRedPoint(self._redPoint, unpack(redPointIds))
	self:_loadRole()
	self:_setRare()

	if self._txtLeftTime then
		self._txtLeftTime.text = ""

		settimer(0.5, self._onTick, self, true)
	end
end

function LimitChallengeShowView:_onTick()
	local challengeId = self._cfg.challengeId

	if challengeId == nil or not TLChallengeController.instance:isInOpenTime(challengeId) then
		self._txtLeftTime.text = ""

		local text = "活动已经结束"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
		removetimer(self._onTick, self)
	else
		local leftTimeFormat = TLChallengeController.instance:getLeftTimeFormat(challengeId)

		self._txtLeftTime.text = string.format("剩余：%s", leftTimeFormat)
	end
end

function LimitChallengeShowView:onExit()
	self:_removeRole()
	self:_removeRare()
	RedPointController.instance:unregRedPoint(self._redPoint)
	removetimer(self._onTick, self)
end

function LimitChallengeShowView:_onClickClose()
	GlobalDispatcher:dispatch(GlobalNotify.CloseLimitChallengeShow)
end

function LimitChallengeShowView:_onClickSkill()
	PetbookController.instance:previewBattle(self._cfg.raceId)
end

function LimitChallengeShowView:_onClickIntroduce()
	PetbookController.instance:openPetinfoView(self._cfg.raceId)
end

function LimitChallengeShowView:_onClickStart()
	if self._cfg then
		GotoMgr.gotoByString(self._cfg.jumpTo)
	end
end

function LimitChallengeShowView:_loadRole()
	local faceId = self._cfg.raceId

	if not faceId or faceId == 0 then
		return
	end

	local offset = CharactorFacade.instance:getPetChallengeUIPosAndScale(faceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, faceId, self._role, scale, nil, true, x, y)
end

function LimitChallengeShowView:_removeRole()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function LimitChallengeShowView:_setRare()
	local rareNum = CharacterConfig.instance:getInitRare(self._cfg.raceId)

	self:_removeRare()
	MaterialMgr.setCell(MatType.Rare, self._cfg.raceId, self._pointRare)
end

function LimitChallengeShowView:_removeRare()
	MaterialMgr.resetAll(self._pointRare)
end

return LimitChallengeShowView
