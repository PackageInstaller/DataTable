-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uifollow/UIBattleUnitPropertyInCenter.lua

module("logic.battle.uifollow.UIBattleUnitPropertyInCenter", package.seeall)

local M = class("UIBattleUnitPropertyInCenter", IBattleReusable)

function M:getCapacity()
	return BattleConst.ObjPoolCapacityMid
end

function M:ctor()
	local sceneGoMgr = BattleMgr.instance:getSceneGameObjectMgr()
	local parentGo = sceneGoMgr:getUnitUIRoot(UIFollowType.Center)

	self.rootGO = goutil.create("UIBattleUnitPropertyInCenter", true)

	goutil.addChildToParent(self.rootGO, parentGo)

	self._priorityEnableMgr = GameObjectsEnableByPriority.New()
	self.mainGO = false
	self._url = false
end

function M:reuse()
	goutil.setActive(self.rootGO, true)
	goutil.setActive(self._sanityGo, false)
end

function M:reset()
	goutil.setActive(self.rootGO, false)
	BattleSynAnimUtil.stopAnim(self._deadAnim)
	self:setRestrainRelation(false)
	self._priorityEnableMgr:disableAllGameObject()
end

function M:destroy()
	self:_clearResource()

	self._url = false

	if self.rootGO then
		goutil.destroy(self.rootGO)

		self.rootGO = false
	end
end

function M:_clearResource()
	if self.mainGO then
		self:destroyUI()
		goutil.destroy(self.mainGO)

		self.mainGO = false
	end

	self._url = false
end

function M:buidUI()
	self._goDeadMark = goutil.findChild(self.mainGO, "deadSign")
	self._goSanityDeadMark = goutil.findChild(self.mainGO, "expendedSign")
	self._sanityGo = goutil.findChild(self.mainGO, "sanity_copy")
	self._sanityBreakAnim = self._sanityGo:GetComponent(ComponentType.Animation)
	self._deadAnim = self.mainGO:GetComponent(ComponentType.Animation)
	self._goRestrainPanel = goutil.findChild(self.mainGO, "arrows")
	self._goRestrainSign = goutil.findChild(self.mainGO, "arrows/imgArrowsUp")
	self._goBeRestrainSign = goutil.findChild(self.mainGO, "arrows/imgArrowsDown")
	self._goEnableToAct = goutil.findChild(self.mainGO, "imgEnableToAct")
	self._goSniping = goutil.findChild(self.mainGO, "snipe_role_sign")

	self:setRestrainRelation(false)
	goutil.setActive(self._sanityGo, false)
	goutil.setActive(self._goEnableToAct, false)
	self._priorityEnableMgr:clear()
	self._priorityEnableMgr:addGameObject(self._goSanityDeadMark, 5)
	self._priorityEnableMgr:addGameObject(self._goDeadMark, 4)
	self._priorityEnableMgr:addGameObject(self._goRestrainPanel, 2)
	self._priorityEnableMgr:addGameObject(self._goSniping, 1)
	self._priorityEnableMgr:disableAllGameObject()
end

function M:destroyUI()
	BattleSynAnimUtil.stopAnim(self._deadAnim)
	self._priorityEnableMgr:clear()

	self._goDeadMark = nil
end

function M:setUrl(url)
	if self._url == url then
		return
	end

	self:_clearResource()

	local resMgr = BattleMgr.instance:getResourceMgr()
	local mainGO = resMgr:getInst(url)

	goutil.addChildToParent(mainGO, self.rootGO)

	self._url = url
	self.mainGO = mainGO

	self:buidUI()
end

function M:setPlaySpeed(playSpeed)
	return
end

function M:setDiableActionArrowStatus(visible)
	goutil.setActive(self._goEnableToAct, visible)
end

function M:setSnipingStatus(visible)
	self._priorityEnableMgr:setGameObjectEnable(self._goSniping, visible)
end

function M:setRestrainRelation(restrainRelation)
	local hasRestrain = restrainRelation == BattleEnum.Restrain.RESTRAIN or restrainRelation == BattleEnum.Restrain.BE_RESTRAIN

	self._priorityEnableMgr:setGameObjectEnable(self._goRestrainPanel, hasRestrain)
	goutil.setActive(self._goRestrainSign, restrainRelation == BattleEnum.Restrain.RESTRAIN)
	goutil.setActive(self._goBeRestrainSign, restrainRelation == BattleEnum.Restrain.BE_RESTRAIN)
end

function M:clearForecast()
	BattleSynAnimUtil.stopAnim(self._deadAnim)
	self._priorityEnableMgr:setGameObjectEnable(self._goDeadMark, false)
	self._priorityEnableMgr:setGameObjectEnable(self._goSanityDeadMark, false)
end

function M:forecast(forecastEntityInfo)
	local forecastHp = forecastEntityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP)
	local forecastSanity = forecastEntityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_SAN)

	if forecastHp <= 0 then
		self._priorityEnableMgr:setGameObjectEnable(self._goDeadMark, true)
		self._priorityEnableMgr:setGameObjectEnable(self._goSanityDeadMark, false)
		BattleSynAnimUtil.playAnimSyn(self._deadAnim, "deadsign_ui_1")
	elseif forecastSanity and forecastSanity < BattleConst.MIN_SANITY then
		self._priorityEnableMgr:setGameObjectEnable(self._goDeadMark, false)
		self._priorityEnableMgr:setGameObjectEnable(self._goSanityDeadMark, true)
		BattleSynAnimUtil.playAnimSyn(self._deadAnim, "deadsign_ui_1")
	else
		self._priorityEnableMgr:setGameObjectEnable(self._goDeadMark, false)
		self._priorityEnableMgr:setGameObjectEnable(self._goSanityDeadMark, false)
		BattleSynAnimUtil.stopAnim(self._deadAnim)
	end
end

function M:playSanityBreakAnim()
	goutil.setActive(self._sanityGo, true)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_battle_san_minus1_dead, nil, nil, nil)
	AnimationUtils.SetPlaySpeed(self._sanityBreakAnim, BattleTime.timeScale)
	self._sanityBreakAnim:Play("sanity_break")
end

return M
