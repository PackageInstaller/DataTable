-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/view/OriginchenclgmainView.lua

module("logic.extensions.originchenclg.view.OriginchenclgmainView", package.seeall)

local OriginchenclgmainView = class("OriginchenclgmainView", ViewComponent)

function OriginchenclgmainView:buildUI()
	OriginchenclgmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/txtTitle/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "openTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnGos = {}

	local jumpBtnCol = self:getGo("jumpBtnCol")

	for i = 1, jumpBtnCol.transform.childCount do
		local go = goutil.findChild(self.mainGO, string.format("jumpBtnCol/btnJump%s", i))

		table.insert(self._jumpBtnGos, go)
	end

	self._btnExt = self:getBtn("btnExt/btn")
	self._btnNor = self:getBtn("btnNor/btn")
	self._imgPassGoExt = self:getGo("btnExt/btn/imgPass")
	self._itemcellGo = self:getGo("btnExt/bubble/itemcell")
	self._imgHasGainGoExt = self:getGo("btnExt/bubble/imgHasGain")
end

function OriginchenclgmainView:bindEvents()
	OriginchenclgmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtnJump, self, i))
	end

	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
	self._btnExt:AddClickListener(self._onClickbtnExt, self)
	self._btnNor:AddClickListener(self._onClickbtnNor, self)
end

function OriginchenclgmainView:unbindEvents()
	OriginchenclgmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.rmClickHandler(v)
	end

	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnExt:RemoveClickListener()
	self._btnNor:RemoveClickListener()
end

function OriginchenclgmainView:onEnter()
	OriginchenclgmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginChenClgGetInfoRes, self._updateUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._actCfg = OriginChenClgConfig.instance:getActivityCfg(self._activityId)

	self:_updateStaticUI()
	OriginChenClgAgent.instance:sendPM_OriginChenClgGetInfoReq(self._activityId)
end

function OriginchenclgmainView:onExit()
	OriginchenclgmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
end

function OriginchenclgmainView:_getRaceId()
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._actCfg.skinId)

	return petSkinCfg.raceId
end

function OriginchenclgmainView:_onClickBtnTip()
	local challengeCfg = OriginChenClgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OriginchenclgmainView:_onClickBtnJump(idx)
	if self._actCfg.jumpList and self._actCfg.jumpList[idx] then
		GotoMgr.gotoByString(self._actCfg.jumpList[idx])
	end
end

function OriginchenclgmainView:_onClickbtnSkill()
	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self:_getRaceId())
end

function OriginchenclgmainView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function OriginchenclgmainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = OriginChenClgController.instance:getActivityId()
	end
end

function OriginchenclgmainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self._actCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local raceId = self:_getRaceId()

	if raceId > 0 then
		MaterialMgr.setCell(MatType.Rare, raceId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	MaterialMgr.setCellByCfg(self._actCfg.extremePrize, self._itemcellGo)
end

function OriginchenclgmainView:_updateUI()
	local mo = OriginChenClgModel.instance:getSubMo(self._activityId)

	self._info = mo and mo:getInfo(self._activityId)
	self._isNorPass = false

	if self._info then
		local passedNormalStageIdMap = {}

		for i, v in ipairs(self._info.passedNormalStageIds) do
			passedNormalStageIdMap[v] = true
		end

		self._isNorPass = true

		local stageCfgs = OriginChenClgConfig.instance:getNorStageCfgs(self._activityId)

		for i, v in ipairs(stageCfgs) do
			if not passedNormalStageIdMap[v.stageId] then
				self._isNorPass = false

				break
			end
		end

		GameUtil.SetActive(self._imgPassGoExt, self._info.gainExtremePrize)
		GameUtil.SetActive(self._imgHasGainGoExt, self._info.gainExtremePrize)
	end
end

function OriginchenclgmainView:_onClickbtnExt()
	UIStateManager.instance:push(ViewName.OriginchenclgextremestageView, self._activityId)
end

function OriginchenclgmainView:_onClickbtnNor()
	if self._isNorPass then
		FloatWordMgr.instance:show("已通过所有挑战")

		return
	end

	UIStateManager.instance:push(ViewName.OriginchenclgnormalstageView, self._activityId)
end

return OriginchenclgmainView
