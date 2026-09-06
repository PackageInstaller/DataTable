-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InflameChallengeView.lua

module("logic.extensions.infinitefuture.view.InflameChallengeView", package.seeall)

local InflameChallengeView = class("InflameChallengeView", ViewComponent)

function InflameChallengeView:ctor()
	InflameChallengeView.super.ctor(self)
end

function InflameChallengeView:unbindEvents()
	InflameChallengeView.super.unbindEvents(self)
	self._introduceBtn:RemoveClickListener()

	for i = 1, 3 do
		self._btnChallenge[i]:RemoveClickListener()
	end
end

function InflameChallengeView:bindEvents()
	InflameChallengeView.super.bindEvents(self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(12005)
	end, self)

	for i = 1, 3 do
		self._btnChallenge[i]:AddClickListener(function()
			local actid = InfinitefutureModel.instance.viretaActIds[i]
			local actType = math.floor(actid / 1000)
			local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, actid)

			if not isInTime then
				TipsFacade.instance:openTipWindow(lang("tip"), "没有到活动开放时间哦~", function()
					return
				end, "确定")

				return
			end

			if GameUtil.getUserData("viretaover" .. tostring(actid)) ~= nil then
				FloatWordMgr.instance:show("已通过所有关卡")
			else
				InfinitefutureModel.instance.viretaActId = actid

				UIStateManager.instance:push(ViewName.InflamedlevelsView, actid)
			end
		end, self)
	end
end

function InflameChallengeView:buildUI()
	InflameChallengeView.super.buildUI(self)

	self._sprintGo = self:getGo("con")
	self._introduceBtn = self:getBtn("petInfo/btnIntroduce")
	self._sprintRareGo = self:getGo("petInfo/pointRare")
	self._btnChallenge = {}

	for i = 1, 3 do
		self._btnChallenge[i] = self:getBtn("btnChallenge" .. i)
	end
end

function InflameChallengeView:onExit()
	InflameChallengeView.super.onExit(self)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_HUD_VIRETA)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	MaterialMgr.resetAll(self._sprintRareGo)

	for i = 1, 3 do
		MaterialMgr.findGraphicText(self._btnChallenge[i].gameObject, "txtReward").text = ""
	end
end

function InflameChallengeView:onEnter()
	InflameChallengeView.super.onEnter(self)
	self:onRefreshUI()
	self:_showSpriteRawInfo()
	self:_showUIEff()
	self:_redPointState()
end

function InflameChallengeView:onRefreshUI()
	for i = 1, 3 do
		local curAct = InfinitefutureModel.instance.viretaActIds[i]
		local actType = math.floor(curAct / 1000)
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, curAct)
		local actCfg = InfinitefutureConfig.instance:getPlanCfg(curAct)
		local lock = goutil.findChild(self._btnChallenge[i].gameObject, "lock")

		if lock then
			lock:SetActive(not isInTime)
		end

		MaterialMgr.findGraphicText(self._btnChallenge[i].gameObject, "txtReward").text = actCfg.pageTips
	end
end

function InflameChallengeView:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, 12005, self._sprintRareGo)

	local x, y, scale = 0, 0, 1

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, 12005, self._sprintGo, scale, nil, true, x, y)
end

function InflameChallengeView:_showUIEff()
	local effPath = "20220602/weileita/fx_ui_weileita_jiemian.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function InflameChallengeView:_redPointState()
	if GameUtil.getUserWeekData("ID_VIRETA_CHALLENGE") == nil then
		GameUtil.saveUserWeekData("ID_VIRETA_CHALLENGE", 1)
	end
end

return InflameChallengeView
