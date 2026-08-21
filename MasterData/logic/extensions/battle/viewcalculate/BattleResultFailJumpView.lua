-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcalculate/BattleResultFailJumpView.lua

module("logic.extensions.battle.viewcalculate.BattleResultFailJumpView", package.seeall)

local M = class("BattleResultFailJumpView", ViewComponent)

function M:buildUI()
	self._jumpPanelGo = goutil.findChild(self.mainGO, "failPanel/content/objTop")
	self._levelBtn = Astral.ButtonAdapter.GetFrom(self._jumpPanelGo, "btnPromoteLevel")
	self._affinityBtn = Astral.ButtonAdapter.GetFrom(self._jumpPanelGo, "btnAffinity")
	self._equipBtn = Astral.ButtonAdapter.GetFrom(self._jumpPanelGo, "btnEquip")
	self._echoBtn = Astral.ButtonAdapter.GetFrom(self._jumpPanelGo, "btnEcho")
	self._levelRecommendGo = goutil.findChild(self._levelBtn.gameObject, "com_label")
	self._affinityRecommendGo = goutil.findChild(self._affinityBtn.gameObject, "com_label")
	self._equipRecommendGo = goutil.findChild(self._equipBtn.gameObject, "com_label")
	self._echoRecommendGo = goutil.findChild(self._echoBtn.gameObject, "com_label")
	self._recommendList = {
		self._levelRecommendGo,
		self._affinityRecommendGo,
		self._equipRecommendGo,
		self._echoRecommendGo
	}
end

function M:bindEvents()
	self._levelBtn:AddClickListener(self._onClickLevel, self)
	self._affinityBtn:AddClickListener(self._onClickAffinity, self)
	self._equipBtn:AddClickListener(self._onClickEquip, self)
	self._echoBtn:AddClickListener(self._onClickEcho, self)
end

function M:unbindEvents()
	self._levelBtn:RemoveClickListener()
	self._affinityBtn:RemoveClickListener()
	self._equipBtn:RemoveClickListener()
	self._echoBtn:RemoveClickListener()
end

function M:onEnter()
	local params = self:getOpenParam()

	self._canRepentance = params[1]

	self:_updateBtnState()
end

function M:onExit()
	return
end

function M:_judgeSystemOpen(enumType, btnGo, count)
	if SystemOpenFacade.instance:isOpen(enumType, false) then
		goutil.setActive(btnGo, true)

		count = count + 1
	else
		goutil.setActive(btnGo, false)
	end

	return count
end

function M:_updateBtnState()
	local count = 0

	count = self:_judgeSystemOpen(GameEnum.SystemEnum.RoleUpgrade, self._levelBtn.gameObject, count)
	count = self:_judgeSystemOpen(GameEnum.SystemEnum.RoleAffinity, self._affinityBtn.gameObject, count)
	count = self:_judgeSystemOpen(GameEnum.SystemEnum.RoleCarryEquip, self._equipBtn.gameObject, count)
	count = self:_judgeSystemOpen(GameEnum.SystemEnum.RoleCarryEcho, self._echoBtn.gameObject, count)

	if count == 0 then
		goutil.setActive(self._jumpPanelGo, false)

		return
	end

	for i, recommendGo in ipairs(self._recommendList) do
		goutil.setActive(recommendGo, false)
	end

	local model = BattleMgr.instance:getModel()

	self._heroIds = model:getStartHeroes()

	if model:getBattleType() == BattleExtension_pb.BattleType.GM_CUSTOMIZE or model:getBattleType() == BattleExtension_pb.BattleType.GM_LEVEL then
		table.clear(self._heroIds)
	end

	goutil.setActive(self._jumpPanelGo, #self._heroIds > 0)

	if #self._heroIds == 0 then
		return
	end

	local hasRecommend = false
	local showLevel = self:_recommendJumpLevel()

	if not hasRecommend and showLevel then
		goutil.setActive(self._levelRecommendGo, true)

		hasRecommend = true
	end

	local showAffinity = self:_recommendJumpAffinity()

	if not hasRecommend and showAffinity then
		goutil.setActive(self._affinityRecommendGo, true)

		hasRecommend = true
	end

	local showEcho = self:_recommendJumpEcho()

	if not hasRecommend and showEcho then
		goutil.setActive(self._echoRecommendGo, true)

		hasRecommend = true
	end

	local showEquip = self:_recommendJumpEquip()

	if not hasRecommend and showEquip then
		goutil.setActive(self._equipRecommendGo, true)

		hasRecommend = true
	end
end

function M:_recommendJumpLevel()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleUpgrade, false) then
		return false
	end

	local recommend = false

	recommend, self._jumpLevelHeroId = CharacterUtil.getHeroLevelCodeInLstForFailTips(self._heroIds)

	return recommend
end

function M:_recommendJumpAffinity()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleAffinity, false) then
		return
	end

	local recommend = false

	recommend, self._jumpAffinityHeroId = CharacterAuthorityModel.instance:getHeroCanAffinityInLstForFailTips(self._heroIds)

	return false
end

function M:_recommendJumpEquip()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEquip, false) then
		return
	end

	local recommend = false

	recommend, self._jumpEquipHeroId = EquipController.instance:checkHerosEquipForFailTips(self._heroIds)

	return recommend
end

function M:_recommendJumpEcho()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.RoleCarryEcho, false) then
		return
	end

	local recommend = false

	recommend, self._jumpEchoHeroId = CharacterUtil.getHeroEchoCodeInLstForFailTips(self._heroIds)

	return recommend
end

function M:_onClickLevel()
	local jumpData = {}

	jumpData.jumpSystem = DungeonEnum.ReturnJumpType.CharacterSystem
	jumpData.tab = CommEnum.CharacterSystemTab.Detail
	jumpData.openView = ViewName.CharacterUpgrade
	jumpData.heroId = self._jumpLevelHeroId

	BattleCalculateMgr.instance:setBattleReturnJumpData(jumpData)
	self:_onClickJump()
end

function M:_onClickAffinity()
	local jumpData = {}

	jumpData.jumpSystem = DungeonEnum.ReturnJumpType.CharacterSystem
	jumpData.tab = CommEnum.CharacterSystemTab.Authority
	jumpData.heroId = self._jumpAffinityHeroId

	BattleCalculateMgr.instance:setBattleReturnJumpData(jumpData)
	self:_onClickJump()
end

function M:_onClickEquip()
	local jumpData = {}

	jumpData.jumpSystem = DungeonEnum.ReturnJumpType.CharacterSystem
	jumpData.tab = CommEnum.CharacterSystemTab.Equip
	jumpData.heroId = self._jumpEquipHeroId

	BattleCalculateMgr.instance:setBattleReturnJumpData(jumpData)
	self:_onClickJump()
end

function M:_onClickEcho()
	local jumpData = {}

	jumpData.jumpSystem = DungeonEnum.ReturnJumpType.CharacterSystem
	jumpData.tab = CommEnum.CharacterSystemTab.EchoItem
	jumpData.heroId = self._jumpEchoHeroId

	BattleCalculateMgr.instance:setBattleReturnJumpData(jumpData)
	self:_onClickJump()
end

function M:_onClickJump()
	local model = BattleMgr.instance:getModel()
	local resultMO = model:getResultMO()

	resultMO:setSkip(true)

	if self._canRepentance then
		BattleAgent.instance:sendSurrenderRequest()
	else
		BattleDispatcher:dispatchEvent(BattleEventType.OnFailTimesUpdate)
		BattleMgr.instance:exit()
	end

	self:close()
end

return M
