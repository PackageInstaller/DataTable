-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominateChallengeUnitView.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominateChallengeUnitView", package.seeall)

local DominateChallengeUnitView = class("DominateChallengeUnitView", KdChallengeUnitView)

function DominateChallengeUnitView:ctor()
	DominateChallengeUnitView.super.ctor(self)
end

function DominateChallengeUnitView:unbindEvents()
	DominateChallengeUnitView.super.unbindEvents(self)
end

function DominateChallengeUnitView:bindEvents()
	DominateChallengeUnitView.super.bindEvents(self)
end

function DominateChallengeUnitView:onExit()
	DominateChallengeUnitView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function DominateChallengeUnitView:buildUI()
	DominateChallengeUnitView.super.buildUI(self)

	self._con = goutil.findChild(self.mainGO, "con")
end

function DominateChallengeUnitView:onEnter()
	self._challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeGetInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeUnitUnitResetRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeResultConfirmRes, self._onUpdate, self)
	KdChallengeController.instance:sendPM_TQKingDragonGetInfoReq(self._challengeId)

	local redId = RedPointModel.ID_NUOYA_LANDINGONCE_RED_UNIT

	KdChallengeController.instance:saveRedAsLandingOnce(redId, true)
end

function DominateChallengeUnitView:_onSetUI()
	local itemsStr = KdChallengeConfig.instance:getNuoyaShowResource()

	if not string.nilorempty(itemsStr) then
		local itemsStrArray = string.split(itemsStr, "#")
		local list = {}

		for _, itemStr in ipairs(itemsStrArray) do
			t = {
				showAdd = true,
				id = itemStr
			}

			table.insert(list, t)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	end

	local effParent = self._effRoot
	local pathName = "20220902/wzsltiaozhan/fx_ui_wzsl_guang"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	local ruleData = RulesConfig.instance:getRuleCo("zhuzainuoya_rule_3_1")

	if ruleData then
		self._txtTitle.text = ruleData.title
	end

	local skinId = KdChallengeConfig.instance:getNuoyaCurSkinId()

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, function()
		GameUtil.setLocalRotation(self._role.asset, 0, 0, 0)
	end, true, nil, nil)
end

function DominateChallengeUnitView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("zhuzainuoya_rule_3")
end

function DominateChallengeUnitView:_onUpdatePartColData()
	local infoList = {}
	local unitCfg = KdChallengeConfig.instance:getKdUnitCfgByCId(self._challengeId)

	for _, data in ipairs(unitCfg) do
		infoList[data.unitId] = {
			data = data,
			unitRecord = KdChallengeModel.instance:getRecordAsUnit(data.unitId),
			congBuffId = KdChallengeController.instance:getNuoyaCongBuffIdAsUnit(data.unitId),
			acqBuffIdList = KdChallengeController.instance:getNuoyaAcqBuffIdListAsUnit(data.unitId)
		}
	end

	self._partInfoList = infoList
end

return DominateChallengeUnitView
