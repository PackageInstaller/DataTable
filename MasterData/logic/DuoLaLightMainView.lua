-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/DuoLaLightMainView.lua

module("logic.extensions.duolalight.view.DuoLaLightMainView", package.seeall)

local DuoLaLightMainView = class("DuoLaLightMainView", ViewComponent)

function DuoLaLightMainView:buildUI()
	DuoLaLightMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txt")
	self._jumpBtnCol = {}

	local mainGo = goutil.findChild(self.mainGO, "jumpBtnCol")

	self._jumpBtnCol._mainGo = mainGo
	self._jumpBtnCol._btnRank = goutil.findChild(mainGo, "btnRank")
	self._jumpBtnCol._redBtnRank = goutil.findChild(mainGo, "btnRank/redPoint")
	self._jumpBtnCol._btnStore = goutil.findChild(mainGo, "btnStore")
	self._jumpBtnCol._redBtnStore = goutil.findChild(mainGo, "btnStore/redPoint")
	self._jumpBtnCol._btnH5 = goutil.findChild(mainGo, "btnH5")
	self._jumpBtnCol._redBtnH5 = goutil.findChild(mainGo, "btnH5/redPoint")
	self._btnEnter = goutil.findChild(self.mainGO, "btnEnter/btn")
	self._redBtnEnter = goutil.findChild(self.mainGO, "btnEnter/btn/redPoint")
	self._txtDescBtnEnter = goutil.findChildTextComponent(self.mainGO, "btnEnter/desc/txt")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._con = goutil.findChild(self.mainGO, "con")
	self._tipsRoot = self:getGo("tipsRoot")
end

function DuoLaLightMainView:bindEvents()
	DuoLaLightMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol._btnRank, self._onClickBtnJumpRank, self)
	GameUtil.addClickHandler(self._jumpBtnCol._btnStore, self._onClickBtnJumpStore, self)
	GameUtil.addClickHandler(self._jumpBtnCol._btnH5, self._onClickBtnJumpH5, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
end

function DuoLaLightMainView:unbindEvents()
	DuoLaLightMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol._btnRank)
	GameUtil.rmClickHandler(self._jumpBtnCol._btnStore)
	GameUtil.rmClickHandler(self._jumpBtnCol._btnH5)
	GameUtil.rmClickHandler(self._btnEnter)
end

function DuoLaLightMainView:onEnter()
	DuoLaLightMainView.super.onEnter(self)

	self._activityType = DuoLaLightController.instance:getActivityType()

	self:_initActId()

	local isInTime = DuoLaLightController.instance:isInActivityTimeAsDuoLa(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		local btnText = "确定"
		local alignment = UnityEngine.TextAnchor.MiddleCenter

		TipsFacade.instance:openTipWindow("提示", text, func, btnText, alignment)

		return
	end

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.DuoLaGameInfoRes, self._onUpdate, self)
	DuoLaLightController.instance:sendPM_DuoLaGameInfoReq(self._activityId)
	AnnuityPrivilegeController.instance:addAnnuityPrivilegeSweepTipsView(self._tipsRoot, self._viewPresentor, self._activityId)
end

function DuoLaLightMainView:onExit()
	DuoLaLightMainView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
	end

	RedPointController.instance:unregRedPoint(self._jumpBtnCol._redBtnRank)
	RedPointController.instance:unregRedPoint(self._redBtnEnter)
end

function DuoLaLightMainView:_onSetUI()
	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	local startStamp, endStamp = 0, 0

	if self._activityId > 0 then
		startStamp, endStamp = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)
	end

	if self._txtOpenTime then
		self._txtOpenTime.text = "活动时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
	end

	local effParent = self.mainGO
	local pathName = "20230303/shenglongtiaozhan/fx_ui_sltz_jiemian"

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

	local redIdRank = DuoLaLightConfig.instance:getDlCommonValue(self._activityId, "DL_PET_TOP_RANK_RED")

	RedPointController.instance:regRedPoint(self._jumpBtnCol._redBtnRank, redIdRank)

	local redId = DuoLaLightConfig.instance:getDlCommonValue(self._activityId, "DL_RED_ID_TIMES")

	RedPointController.instance:regRedPoint(self._redBtnEnter, redId)

	local skinId = self:_getSkinId()
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, modelCfg[1], y)
			end
		end
	end
end

function DuoLaLightMainView:_onUpdate()
	local notFinsihDiffCount = DuoLaLightController.instance:getNotFinsihDiffCount(self._activityId)

	self._txtDescBtnEnter.text = string.format("今日剩余：%s次", notFinsihDiffCount)
end

function DuoLaLightMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DuoLaLightMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DuoLaLightMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DuoLaLightMainView:_getSkinId()
	return DuoLaLightConfig.instance:getDlCommonValue(self._activityId, "DL_PET_SKINID", true)
end

function DuoLaLightMainView:_onClickBtnJumpRank()
	self:_gotoByString("DL_JUMP_PET_RANK")
end

function DuoLaLightMainView:_onClickBtnJumpStore()
	self:_gotoByString("DL_JUMP_SHOP")
end

function DuoLaLightMainView:_onClickBtnJumpH5()
	self:_gotoByString("DL_JUMP_H5")
end

function DuoLaLightMainView:_gotoByString(key)
	local value = DuoLaLightConfig.instance:getDlCommonValue(self._activityId, key, false)

	GotoMgr.gotoByString(value)
end

function DuoLaLightMainView:_onClickBtnEnter()
	UIStateManager.instance:push(ViewName.DuoLaLightStageView)
end

function DuoLaLightMainView:_onClickBtnTip()
	local value = DuoLaLightConfig.instance:getDlCommonValue(self._activityId, "DL_MAIN_RULE_KEY", false)

	TipsFacade.instance:openRulesView(value)
end

function DuoLaLightMainView:_initActId()
	local enterId = checknumber(self:getFirstParam())

	if enterId > 0 then
		self._activityId = enterId
	else
		local activityId = DuoLaLightController.instance:getActivityId()

		self._activityId = activityId > 0 and activityId or ActivityDefineController.instance:getActivityIdByType(self._activityType)
	end

	DuoLaLightController.instance:setActivityId(self._activityId)
end

function DuoLaLightMainView:_onClickBtnClose()
	DuoLaLightController.instance:setActivityId(0)
	self:close()
end

return DuoLaLightMainView
