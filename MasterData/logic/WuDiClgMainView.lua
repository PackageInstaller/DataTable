-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wudiclg/view/WuDiClgMainView.lua

module("logic.extensions.wudiclg.view.WuDiClgMainView", package.seeall)

local WuDiClgMainView = class("WuDiClgMainView", ViewComponent)

function WuDiClgMainView:buildUI()
	WuDiClgMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._clgBtnCol = goutil.findChild(self.mainGO, "clgBtnCol")
	self._clgBtnCol_btnClg1 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1")
	self._clgBtnCol_btnClg1_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn")
	self._clgBtnCol_btnClg1_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/redPoint")
	self._clgBtnCol_btnClg1_imgPass = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/btn/imgPass")
	self._clgBtnCol_btnClg1_bubble = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble")
	self._clgBtnCol_btnClg1_bubble_itemcell = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/itemcell")
	self._clgBtnCol_btnClg1_bubble_imgHasGain = goutil.findChild(self.mainGO, "clgBtnCol/btnClg1/bubble/imgHasGain")
	self._clgBtnCol_btnClg1_bubble_txt = goutil.findChildTextComponent(self.mainGO, "clgBtnCol/btnClg1/bubble/txt")
	self._clgBtnCol_btnClg2 = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2")
	self._clgBtnCol_btnClg2_btn = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn")
	self._clgBtnCol_btnClg2_redPoint = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/redPoint")
	self._clgBtnCol_btnClg2_imgPass = goutil.findChild(self.mainGO, "clgBtnCol/btnClg2/btn/imgPass")

	self:_recordGoDefaultActive(self._jumpBtnCol)
	self:_recordGoDefaultActive(self._clgBtnCol_btnClg2)
	self:_recordGoDefaultActive(self._clgBtnCol_btnClg1_bubble)
end

function WuDiClgMainView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function WuDiClgMainView:_isActiveInDefault(go)
	self._goDefaultActives = self._goDefaultActives or {}

	return self._goDefaultActives[go]
end

function WuDiClgMainView:_refreshDefaultActive(go)
	GameUtil.SetActive(go, self:_isActiveInDefault(go))
end

function WuDiClgMainView:bindEvents()
	WuDiClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._clgBtnCol_btnClg1_btn, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._clgBtnCol_btnClg2_btn, self._onClickBtnClg2, self)
end

function WuDiClgMainView:unbindEvents()
	WuDiClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg1_btn)
	GameUtil.rmClickHandler(self._clgBtnCol_btnClg2_btn)
end

function WuDiClgMainView:onEnter()
	WuDiClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = WuDiClgController.instance:getActivityId()
	end

	self._activityType = WuDiClgController.instance:getActivityType()

	local isInTime = WuDiClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._actData = WuDiClgConfig.instance:getWdcActData(self._activityId)

	self:_onSetUI()
	self.addGEvent(self, GlobalNotify.WuDiClgGetInfoRes, self._onUpdate, self)
	WuDiClgController.instance:sendPM_WuDiClgGetInfoReq(self._activityId)
end

function WuDiClgMainView:onExit()
	WuDiClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg1_bubble_itemcell)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump1_redPoint)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump2_redPoint)
	RedPointController.instance:unregRedPoint(self._jumpBtnCol_btnJump3_redPoint)
	RedPointController.instance:unregRedPoint(self._clgBtnCol_btnClg1_redPoint)
	RedPointController.instance:unregRedPoint(self._clgBtnCol_btnClg2_redPoint)
end

function WuDiClgMainView:_onSetUI()
	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._jumpBtnCol, false)
		GameUtil.SetActive(self._clgBtnCol_btnClg2, false)
		GameUtil.SetActive(self._clgBtnCol_btnClg1_bubble, false)
	else
		self:_refreshDefaultActive(self._jumpBtnCol)
		self:_refreshDefaultActive(self._clgBtnCol_btnClg2)
		self:_refreshDefaultActive(self._clgBtnCol_btnClg1_bubble)
	end

	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local redInfoList = {
		{
			{
				WuDiClgConfig.instance:getWdcCommonValue(self._activityId, "jumpRedIdOne")
			},
			self._jumpBtnCol_btnJump1_redPoint
		},
		{
			{
				WuDiClgConfig.instance:getWdcCommonValue(self._activityId, "jumpRedIdTwo")
			},
			self._jumpBtnCol_btnJump2_redPoint
		},
		{
			{
				WuDiClgConfig.instance:getWdcCommonValue(self._activityId, "jumpRedIdThree")
			},
			self._jumpBtnCol_btnJump3_redPoint
		},
		{
			{
				RedPointModel.ID_WuDiClg_Ext
			},
			self._clgBtnCol_btnClg1_redPoint
		},
		{
			{
				RedPointModel.ID_WuDiClg_Nor
			},
			self._clgBtnCol_btnClg2_redPoint
		}
	}

	for _, redInfo in ipairs(redInfoList) do
		local list = redInfo[1]
		local redGo = redInfo[2]
		local redIdList = {}

		for _, redId in ipairs(list) do
			if not string.nilorempty(redId) or checknumber(redId) ~= 0 then
				table.insert(redIdList, redId)
			end
		end

		if #redIdList > 0 and not goutil.isNil(redGo) then
			RedPointController.instance:regRedPoint(redGo, unpack(redIdList))
		end
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	MaterialMgr.setCellByCfg(self._actData.extremeClgPrize, self._clgBtnCol_btnClg1_bubble_itemcell)

	local matName = MaterialMgr.getMaterialsNameByCfg(self._actData.extremeClgPrize)

	self._clgBtnCol_btnClg1_bubble_txt.text = string.format("通关获得%s", matName)
end

function WuDiClgMainView:_onUpdate()
	local result, tips = WuDiClgController.instance:getTryEnterExtClgResultAndTips(self._activityId)

	GameUtil.SetActive(self._clgBtnCol_btnClg1_imgPass, result == GameEnum.ResultCode.IsHasGain)
	GameUtil.SetActive(self._clgBtnCol_btnClg1_bubble_imgHasGain, result == GameEnum.ResultCode.IsHasGain)
end

function WuDiClgMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function WuDiClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function WuDiClgMainView:_getRaceId()
	return WuDiClgController.instance:getRaceId(self._activityId)
end

function WuDiClgMainView:_getSkinId()
	return WuDiClgController.instance:getSkinId(self._activityId)
end

function WuDiClgMainView:_onClickBtnJump(key)
	if self._isAoqiGodProcessType then
		return
	end

	local jumpToStr = WuDiClgConfig.instance:getWdcCommonValue(self._activityId, key)

	GotoMgr.gotoByString(jumpToStr)
end

function WuDiClgMainView:_onClickBtnClg1()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local result, tips = WuDiClgController.instance:getTryEnterExtClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.WuDiClgExtView, self._activityId)
end

function WuDiClgMainView:_onClickBtnClg2()
	if self._isAoqiGodProcessType then
		return
	end

	local result, tips = WuDiClgController.instance:getTryEnterNorClgResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.WuDiClgNorView, self._activityId)
end

function WuDiClgMainView:_onClickBtnTip()
	local key = WuDiClgConfig.instance:getWdcCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return WuDiClgMainView
