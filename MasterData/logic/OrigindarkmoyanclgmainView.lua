-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/view/OrigindarkmoyanclgmainView.lua

module("logic.extensions.origindarkmoyanclg.view.OrigindarkmoyanclgmainView", package.seeall)

local OrigindarkmoyanclgmainView = class("OrigindarkmoyanclgmainView", ViewComponent)
local CLG_COUNT = 3

function OrigindarkmoyanclgmainView:buildUI()
	OrigindarkmoyanclgmainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/txtTitle/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/rare")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnGos = {}

	local jumpBtnCol = self:getGo("jumpBtnCol")

	for i = 1, jumpBtnCol.transform.childCount do
		local go = jumpBtnCol.transform:GetChild(i - 1).gameObject

		table.insert(self._jumpBtnGos, go)
	end

	self._clgItems = {}

	for i = 1, CLG_COUNT do
		local prefix = "btnClg" .. i

		self._clgItems[i] = {
			effectGo = self:getGo(prefix .. "/bubble/effect"),
			passGo = self:getGo(prefix .. "/pass"),
			imgHasGainGo = self:getGo(prefix .. "/bubble/imgHasGain"),
			itemcellGo = self:getGo(prefix .. "/bubble/itemcell"),
			txtOpenTime = self:getTxt(prefix .. "/time/txt"),
			openTimeGo = self:getGo(prefix .. "/time"),
			btnClg = self:getBtn(prefix),
			bg = self:getGo(prefix .. "/bg")
		}
	end

	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/rd")
	self._txtLevelBuff = self:getTxt("buffCol/Lv/txt")
end

function OrigindarkmoyanclgmainView:bindEvents()
	OrigindarkmoyanclgmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickBtnJump, self, i))
	end

	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)

	for i = 1, CLG_COUNT do
		GameUtil.addClickHandler(self._clgItems[i].btnClg, GameUtil.handler(self._onClickbtnClg, self, i))
	end
end

function OrigindarkmoyanclgmainView:unbindEvents()
	OrigindarkmoyanclgmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for i, v in ipairs(self._jumpBtnGos) do
		GameUtil.rmClickHandler(v)
	end

	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()

	for i = 1, CLG_COUNT do
		self._clgItems[i].btnClg:RemoveClickListener()
	end

	GameUtil.rmClickHandler(self._btnGainBuff)
end

function OrigindarkmoyanclgmainView:onEnter()
	OrigindarkmoyanclgmainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginDarkMoYanClgGetInfoRes, self._updateUI, self)
	self:_initActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show("活动未开放")
		self:close()

		return
	end

	self._actCfg = OrigindarkmoyanclgConfig.instance:getActivityCfg(self._activityId)

	self:_updateStaticUI()
	OriginDarkMoYanClgAgent.instance:sendPM_OriginDarkMoYanClgGetInfoReq(self._activityId)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function OrigindarkmoyanclgmainView:onExit()
	OrigindarkmoyanclgmainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)

	for i = 1, CLG_COUNT do
		MaterialMgr.resetAll(self._clgItems[i].itemcellGo)
	end

	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OrigindarkmoyanclgmainView:_getRaceId()
	return self._actCfg.raceId
end

function OrigindarkmoyanclgmainView:_onClickBtnTip()
	local challengeCfg = OrigindarkmoyanclgController.instance:getChallengeCfg()

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function OrigindarkmoyanclgmainView:_onClickBtnJump(idx)
	if self._actCfg.jumpList and self._actCfg.jumpList[idx] then
		GotoMgr.gotoByString(self._actCfg.jumpList[idx])
	end
end

function OrigindarkmoyanclgmainView:_onClickbtnSkill()
	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self:_getRaceId())
end

function OrigindarkmoyanclgmainView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function OrigindarkmoyanclgmainView:_onClickbtnClg(idx)
	if not self._info then
		return
	end

	if idx < self._info.stageId then
		FloatWordMgr.instance:show("已通关")

		return
	end

	if idx > self._info.stageId then
		FloatWordMgr.instance:show("先通过前置关卡")

		return
	end

	local stageCfg = OrigindarkmoyanclgConfig.instance:getStageCfg(self._activityId, idx)

	if stageCfg and not string.nilorempty(stageCfg.openTime) then
		local openTime = GameUtil.string2time(stageCfg.openTime)

		if openTime > ServerTime.now() then
			FloatWordMgr.instance:show(lang("未到开启时间"))

			return
		end
	end

	UIStateManager.instance:push(ViewName.OrigindarkmoyanclgstageView, self._activityId, idx)
end

function OrigindarkmoyanclgmainView:_initActivityId()
	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = OrigindarkmoyanclgController.instance:getActivityId()
	end
end

function OrigindarkmoyanclgmainView:_updateStaticUI()
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	local skinId = self:_getRaceId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	local stageCfgs = OrigindarkmoyanclgConfig.instance:getStageCfgs(self._activityId)
	local nowTime = ServerTime.now()

	for i, v in ipairs(stageCfgs) do
		local item = self._clgItems[i]

		if item then
			MaterialMgr.setCellByCfg(v.prize, item.itemcellGo)

			if not string.nilorempty(v.openTime) then
				local openTime = GameUtil.string2time(v.openTime)

				GameUtil.SetActive(item.openTimeGo, nowTime < openTime)
				GameUtil.SetGray(item.bg, nowTime < openTime)

				local openDate = GameUtil.time2date(openTime)

				item.txtOpenTime.text = langPara("{0}.{1}.{2} {3}:%02d开启", openDate.year, openDate.month, openDate.day, openDate.hour, openDate.min)
			else
				GameUtil.SetActive(item.openTimeGo, false)
			end
		end
	end
end

function OrigindarkmoyanclgmainView:_updateUI()
	self._info = OrigindarkmoyanclgModel.instance:getInfo(self._activityId)

	if self._info then
		local stageCfgs = OrigindarkmoyanclgConfig.instance:getStageCfgs(self._activityId)

		for i, v in ipairs(stageCfgs) do
			local item = self._clgItems[i]

			GameUtil.SetActive(item.passGo, self._info.stageId > v.stageId)
			GameUtil.SetActive(item.imgHasGainGo, self._info.stageId > v.stageId)
		end
	end
end

function OrigindarkmoyanclgmainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end

	self._txtLevelBuff.text = buffCfg and string.format("Lv.%s", buffCfg.buffLevel) or "Lv.0"
end

return OrigindarkmoyanclgmainView
