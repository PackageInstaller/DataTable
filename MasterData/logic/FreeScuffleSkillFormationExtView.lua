-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleSkillFormationExtView.lua

module("logic.extensions.freescuffle.view.FreeScuffleSkillFormationExtView", package.seeall)

local FreeScuffleSkillFormationExtView = class("FreeScuffleSkillFormationExtView", ViewComponent)

function FreeScuffleSkillFormationExtView:buildUI()
	FreeScuffleSkillFormationExtView.super.buildUI(self)

	self._emptyTag = self:getGo("emptyTag")
	self._btnSkill = self:getGo("btnSkill")
	self._btnJump = self:getGo("emptyTag/btnJump")
	self._btnBagSkill = self:getGo("btnBagSkill")
	self._btnCancel = self:getGo("btnCancel")
	self._txtBuff = self:getTxt("buff/txt")
	self._btnLottery = self:getGo("btnLottery")
end

function FreeScuffleSkillFormationExtView:bindEvents()
	FreeScuffleSkillFormationExtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickBtnJump, self)
	GameUtil.addClickHandler(self._btnBagSkill, self._onClickBtnBagSkill, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnJump, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
end

function FreeScuffleSkillFormationExtView:unbindEvents()
	FreeScuffleSkillFormationExtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnJump)
	GameUtil.rmClickHandler(self._btnBagSkill)
	GameUtil.rmClickHandler(self._btnLottery)
end

function FreeScuffleSkillFormationExtView:onEnter()
	FreeScuffleSkillFormationExtView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._customFmtMo = params[1]
	self._activityId = self._customFmtMo:getActivityId()
	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)

	self.addGEvent(self, GlobalNotify.FreeScuffleUpdateSkillBag, self._freeScuffleUpdateSkillBag, self)
	self:_onUpdate()
end

function FreeScuffleSkillFormationExtView:onExit()
	FreeScuffleSkillFormationExtView.super.onExit(self)
end

function FreeScuffleSkillFormationExtView:_freeScuffleUpdateSkillBag()
	self._customFmtMo:onDispatchFormationChanged()
end

function FreeScuffleSkillFormationExtView:_onUpdate()
	local infos = self._subMo:getBattlePetIdDic()

	GameUtil.SetActive(self._emptyTag, TableUtil.isTableEmpty(infos))

	local buffId = FreeScuffleController.instance:getCurBuffId(self._activityId)
	local buffData = FreeScuffleConfig.instance:getGlobalBuffData(self._activityId, buffId)

	if buffData then
		self._txtBuff.text = buffData.desc or "无"
	end
end

function FreeScuffleSkillFormationExtView:_onClickBtnSkill()
	local infos = self._subMo:getBattlePetIdDic()

	if TableUtil.isTableEmpty(infos) then
		FloatWordMgr.instance:show("还未拥有战斗精灵，无法调整技能")

		return
	end

	local petMoList = {}
	local positions = self._customFmtMo:getCurFormation():GetPositions()

	for _, creepsId in ipairs(positions) do
		if creepsId > 0 then
			local petMo = self._customFmtMo:getPetMoById(creepsId)

			table.insert(petMoList, petMo)
		end
	end

	if #petMoList <= 0 then
		FloatWordMgr.instance:show("未上阵战斗精灵，无法调整技能")

		return
	end

	UIStateManager.instance:push(ViewName.FreeScuffleSkillBagView, self._activityId, FreeScuffleEnum.FmtType_Defense, petMoList)
end

function FreeScuffleSkillFormationExtView:_onClickBtnBagSkill()
	local infos = self._subMo:getBattlePetIdDic()

	if TableUtil.isTableEmpty(infos) then
		FloatWordMgr.instance:show("还未拥有战斗精灵，无法调整技能")

		return
	end

	UIStateManager.instance:push(ViewName.FreeScuffleSkillBagView, self._activityId, FreeScuffleEnum.FmtType_Defense, self._customFmtMo._rightPetList)
end

function FreeScuffleSkillFormationExtView:_onClickBtnJump()
	FreeScuffleCardPoolView.DefaultPoolType = FreeScuffleEnum.PoolTypes_BattlePet

	UIStateManager.instance:push(ViewName.FreeScuffleCardPoolView, self._activityId, FreeScuffleEnum.PoolTabs_Pet)
end

function FreeScuffleSkillFormationExtView:_onClickBtnCancel()
	self._customFmtMo:setSaveHandler(nil, nil)
	UIStateManager.instance:popByName(ViewName.CustomFormationView)
end

return FreeScuffleSkillFormationExtView
