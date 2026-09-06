-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originanangel/view/OriginAnAngelMainView.lua

module("logic.extensions.originanangel.view.OriginAnAngelMainView", package.seeall)

local OriginAnAngelMainView = class("OriginAnAngelMainView", ViewComponent)

function OriginAnAngelMainView:ctor()
	OriginAnAngelMainView.super.ctor(self)
end

function OriginAnAngelMainView:unbindEvents()
	OriginAnAngelMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnGainBuff)
end

function OriginAnAngelMainView:bindEvents()
	OriginAnAngelMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnChallenge, self._onBtnChallenge, self)
	GameUtil.addClickHandler(self._btnGainBuff, self._onClickBtnGainBuff, self)
end

function OriginAnAngelMainView:buildUI()
	OriginAnAngelMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._firstPass = self:getGo("btnNorClg/firstPass")
	self._btnChallenge = self:getGo("btnNorClg/btn")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._buffText = self:getTxt("buffCol/txtDesc")
	self._buffRed = self:getGo("buffCol/cell/redPoint")
	self._tagHasGain = self:getGo("bubble/tagHasGain")
	self._item = self:getGo("bubble/item")
end

function OriginAnAngelMainView:onExit()
	OriginAnAngelMainView.super.onExit(self)
	MaterialMgr.resetAll(self._role)
	MaterialMgr.resetAll(self._item)
end

function OriginAnAngelMainView:onEnter()
	OriginAnAngelMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_IF_GETINFORES, self._getInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_ZXL_GETSIGN, self._onUpdateUI, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 123018
	end

	self._actCfg = InfinitefutureConfig.instance:getPlanCfg(self._activityId)
	self._hasGetInfo = false
	InfinitefutureModel.instance.curActId = self._activityId
	InfinitefutureModel.instance.curPetId = self._actCfg.skinId

	self:_onSetUI()
	InfinitefutureController.instance:sendInfoReq(self._activityId)
end

function OriginAnAngelMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	local skinId = self._actCfg.skinId
	local petName
	local petData = CharacterConfig.instance:getPetCo(skinId)
	local stageCfgs = InfinitefutureConfig.instance:getStageCfgs(self._activityId)

	if stageCfgs then
		if not stageCfgs[#stageCfgs] then
			local lastCfg = {}

			if lastCfg then
				if not lastCfg.prize then
					local prize = ""

					self._txtPetNameInInfo.text = (petData or nil) and petData.name
					self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

					if skinId > 0 then
						MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
					end

					MaterialMgr.setCellByCfg(prize, self._item)
				end
			end
		end
	end
end

function OriginAnAngelMainView:_onClickBtnJump(jumpIdx)
	local jumpStr = self._actCfg["jumpTo" .. jumpIdx]

	GotoMgr.gotoByString(jumpStr)
end

function OriginAnAngelMainView:_onClickBtnTip()
	local key = self._actCfg.ruleId

	TipsFacade.instance:openRulesView(key)
end

function OriginAnAngelMainView:_onBtnSkillClg()
	local skinId = self._actCfg.skinId

	PetbookController.instance:previewBattle(skinId)
end

function OriginAnAngelMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self._actCfg.skinId)
end

function OriginAnAngelMainView:_onBtnChallenge()
	if not self._hasGetInfo then
		FloatWordMgr.instance:show(lang("正在加载数据，请稍后重试"))

		return
	end

	local stageId = InfinitefutureModel.instance.curStageId
	local totalCount = InfinitefutureConfig.instance:getStageCount(self._activityId)

	if totalCount < stageId then
		FloatWordMgr.instance:show(lang("已通关"))

		return
	end

	UIStateManager.instance:push(ViewName.OriginAnAngelLevelsView, self._activityId)
end

function OriginAnAngelMainView:_onClickBtnGainBuff()
	if self.isTop then
		FloatWordMgr.instance:show("已达到签到加成上限")

		return
	end

	if InfinitefutureModel.instance.isSignToday then
		FloatWordMgr.instance:show("今日已签到")

		return
	end

	InfinitefutureController.instance:sendSignInReq(self._activityId)
end

function OriginAnAngelMainView:_getInfoRes()
	self._hasGetInfo = true

	self:_onUpdateUI()
end

function OriginAnAngelMainView:_onUpdateUI()
	local stageId = InfinitefutureModel.instance.curStageId
	local totalCount = InfinitefutureConfig.instance:getStageCount(self._activityId)
	local isOver = totalCount < stageId
	local cfgs = InfinitefutureConfig.instance:getSignCfgs(self._activityId)

	self.isTop = InfinitefutureModel.instance.curDailySignId >= #cfgs

	local buffcfg = cfgs[InfinitefutureModel.instance.curDailySignId]

	self._buffText.text = buffcfg == nil and "未获得加成" or buffcfg.desc

	self._buffRed:SetActive(not InfinitefutureModel.instance.isSignToday and not self.isTop)
	goutil.setActive(self._challengePass, isOver)
	goutil.setActive(self._tagHasGain, isOver)
end

return OriginAnAngelMainView
