-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/EndlessdchallengeView.lua

module("logic.extensions.infinitefuture.view.EndlessdchallengeView", package.seeall)

local EndlessdchallengeView = class("EndlessdchallengeView", ViewComponent)

function EndlessdchallengeView:ctor()
	EndlessdchallengeView.super.ctor(self)
end

function EndlessdchallengeView:unbindEvents()
	EndlessdchallengeView.super.unbindEvents(self)
	self._introduceBtn:RemoveClickListener()

	for i = 1, 3 do
		self._btnChallenge[i]:RemoveClickListener()
	end
end

function EndlessdchallengeView:bindEvents()
	EndlessdchallengeView.super.bindEvents(self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(10314)
	end, self)

	for i = 1, 3 do
		self._btnChallenge[i]:AddClickListener(function()
			local actid = InfinitefutureModel.instance.endlessActIds[i]

			if GameUtil.getUserData("endlessover" .. tostring(actid)) ~= nil then
				FloatWordMgr.instance:show("已通过所有关卡")
			else
				UIStateManager.instance:push(ViewName.EndlessdlevelsView, actid)
			end
		end, self)
	end
end

function EndlessdchallengeView:buildUI()
	EndlessdchallengeView.super.buildUI(self)

	self._sprintGo = self:getGo("con")
	self._introduceBtn = self:getBtn("petInfo/btnIntroduce")
	self._sprintRareGo = self:getGo("petInfo/pointRare")
	self._btnChallenge = {}

	for i = 1, 3 do
		self._btnChallenge[i] = self:getBtn("btnChallenge" .. i)
	end
end

function EndlessdchallengeView:onExit()
	EndlessdchallengeView.super.onExit(self)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_HUD_ENDLESS)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	MaterialMgr.resetAll(self._sprintRareGo)

	for i = 1, 3 do
		MaterialMgr.findGraphicText(self._btnChallenge[i].gameObject, "txtReward").text = ""
	end
end

function EndlessdchallengeView:onEnter()
	EndlessdchallengeView.super.onEnter(self)
	self:onRefreshUI()
	self:_showSpriteRawInfo()
	self:_showUIEff()
end

function EndlessdchallengeView:onRefreshUI()
	for i = 1, 3 do
		local curAct = InfinitefutureModel.instance.endlessActIds[i]
		local actType = math.floor(curAct / 1000)
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, curAct)
		local actCfg = InfinitefutureConfig.instance:getPlanCfg(curAct)
		local lock = goutil.findChild(self._btnChallenge[i].gameObject, "lock")

		if lock then
			lock:SetActive(not isInTime)
		end

		self._btnChallenge[i].btn.enabled = isInTime
		MaterialMgr.findGraphicText(self._btnChallenge[i].gameObject, "txtReward").text = actCfg.pageTips
	end
end

function EndlessdchallengeView:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, 10314, self._sprintRareGo)

	local x, y, scale = 0, 0, 1

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, 10314, self._sprintGo, scale, nil, true, x, y)
end

function EndlessdchallengeView:_showUIEff()
	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

return EndlessdchallengeView
