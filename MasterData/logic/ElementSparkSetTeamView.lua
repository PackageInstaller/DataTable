-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkSetTeamView.lua

module("logic.extensions.elementspark.view.ElementSparkSetTeamView", package.seeall)

local ElementSparkSetTeamView = class("ElementSparkSetTeamView", ViewComponent)

function ElementSparkSetTeamView:ctor()
	ElementSparkSetTeamView.super.ctor(self)
end

function ElementSparkSetTeamView:unbindEvents()
	ElementSparkSetTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function ElementSparkSetTeamView:bindEvents()
	ElementSparkSetTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function ElementSparkSetTeamView:buildUI()
	ElementSparkSetTeamView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtDesc = self:getTxt("state/txtDesc")
	self._tableViewGo = self:getGo("tableview")
	self._cellGo = self:getGo("cell")
	self._tableView = ScrollerList.create(self._tableViewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ElementSparkSetTeamView:onExit()
	ElementSparkSetTeamView.super.onExit(self)
	self._tableView:dispose()
end

function ElementSparkSetTeamView:onEnter()
	ElementSparkSetTeamView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkGetMyFormsRes, self._refresh, self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._petCellCount = 6
	self._teamId = 1

	self:_sendInfoReq()

	self._maxPower = ElementSparkConfig.instance:getCommonCfgByKey("TEAM_STRENGTH_LIMIT", true)
end

function ElementSparkSetTeamView:_sendInfoReq()
	ElementSparkController.instance:sendPM_EleSparkGetMyFormsReq(self._activityId)
end

function ElementSparkSetTeamView:_refresh()
	self._teamInfo = ElementSparkController.instance:getTeamInfo()

	self._tableView:reloadData(self._teamInfo)
end

function ElementSparkSetTeamView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "info/txtName")
	local txtMode = goutil.findChildTextComponent(cell, "info/txtMode")
	local txtPower = goutil.findChildTextComponent(cell, "info/txtPower")
	local btnDetail = goutil.findChildButtonComponent(cell, "btnDetail")
	local txtState = goutil.findChildTextComponent(cell, "btnDetail/txtState")
	local txtDesc = goutil.findChildTextComponent(cell, "btnDetail/txtDesc")
	local teamMo = ElementSparkController.instance:getTeamMo(data.teamInfo.form)
	local change = cell.gameObject:GetComponent("UIChangeGroup")

	for i = 1, self._petCellCount do
		local btn = goutil.findChildButtonComponent(cell, "petCell_" .. i .. "/btn")
		local pet = goutil.findChild(cell, "petCell_" .. i .. "/pet")
		local addGo = goutil.findChild(cell, "petCell_" .. i .. "/add")

		GameUtil.SetActive(addGo, not teamMo[i])
		GameUtil.SetActive(pet, teamMo[i])

		if teamMo[i] then
			local petCon = goutil.findChild(cell, "petCell_" .. i .. "/pet/mask/con")
			local quality = goutil.findChild(cell, "petCell_" .. i .. "/pet/qualitybg"):GetComponent("UIImageSpriteChange")
			local attr = goutil.findChild(cell, "petCell_" .. i .. "/pet/attr"):GetComponent("UIImageSpriteChange")
			local job1 = goutil.findChild(cell, "petCell_" .. i .. "/pet/job1"):GetComponent("UIImageSpriteChange")
			local job2 = goutil.findChild(cell, "petCell_" .. i .. "/pet/job2"):GetComponent("UIImageSpriteChange")
			local tag = goutil.findChild(cell, "petCell_" .. i .. "/pet/tag")
			local txtLevel = goutil.findChildTextComponent(cell, "petCell_" .. i .. "/pet/txtLv")

			GameUtil.SetActive(tag, teamMo[i].isSupportedPet)
			quality:SetState(teamMo[i]:getRare())

			local raceId = teamMo[i].curFaceId
			local cfg = CharacterConfig.instance:getPetCo(raceId)

			if cfg then
				local race = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId)

				attr:SetState(race - 1)
			end

			local modelCfg = CharacterConfig.instance:getModelCo(raceId)

			if modelCfg then
				uGuiUtil.setSpriteToImage(petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCfg.cardName))
			end

			local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(raceId)

			GameUtil.setUIImageSpriteIdx(job1, firstJobIdx - 1)

			local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(raceId)
			local isNeedJob1 = secondJobIdx > 20

			GameUtil.SetActive(job2, isNeedJob1)

			if isNeedJob1 then
				GameUtil.setUIImageSpriteIdx(job1, secondJobIdx - 1 - 20)
			end

			txtLevel.text = teamMo[i]:getPetLv()
		end

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickSetTeam, self, cell.index + 1))
	end

	GameUtil.SetActive(txtPower.gameObject, data.mode == "攻击")
	GameUtil.SetActive(btnDetail.gameObject, data.mode ~= "攻击")

	if data.mode == "攻击" then
		do
			local teamStrength = data.teamInfo.teamStrength

			txtPower.text = string.format("体力：%d/%d", (teamStrength ~= nil or nil) and data.teamInfo.teamStrength.strength, self._maxPower)

			change:SetState(0)
		end
	end

	if not data.teamInfo.defenseChunkId then
		do
			local defenseChunkId = 0

			GameUtil.SetActive(txtDesc.gameObject, defenseChunkId > 0)
			change:SetState(1)

			if defenseChunkId > 0 then
				txtState.text = "守城中"

				local campName = ElementSparkController.instance:getMyCampName()
				local planId = ElementSparkController.instance:getMapPlanId()
				local chunkCfg = ElementSparkConfig.instance:getMapChunkCfgById(planId, defenseChunkId)
				local pos = chunkCfg.pos

				txtDesc.text = string.format("%s阵营\n(%d,%d)地块", campName, pos[1], pos[2])
			else
				txtState.text = "空闲中"
			end

			GameUtil.addClickHandler(btnDetail, GameUtil.handler(self._onClickDetail, self, defenseChunkId))
		end

		local id = cell.index + 1

		txtName.text = "队伍" .. id
		txtMode.text = string.format("仅可用于%s", data.mode)
	end
end

function ElementSparkSetTeamView:_clearCell(cell)
	local btnDetail = goutil.findChildButtonComponent(cell, "btnDetail")

	for i = 1, self._petCellCount do
		local petCon = goutil.findChild(cell, "petCell_" .. i .. "/pet/mask/con")

		uGuiUtil.clearImage(petCon)

		local btn = goutil.findChildButtonComponent(cell, "petCell_" .. i .. "/btn")

		GameUtil.rmClickHandler(btn)
	end

	GameUtil.rmClickHandler(btnDetail)
end

function ElementSparkSetTeamView:_onClickTip()
	TipsFacade.instance:openRulesView("ElementSparkSetTeam_rule")
end

function ElementSparkSetTeamView:_onClickSetTeam(teamId)
	if ElementSparkController.instance:checkResultTime() then
		return
	end

	ElementSparkController.instance:openElementSparkSetForm(self._activityId, teamId, true)
end

function ElementSparkSetTeamView:_onClickDetail(defenseChunkId)
	if defenseChunkId <= 0 then
		FloatWordMgr.instance:show("队伍空闲中，快去守卫地块吧~")

		return
	end

	local tips = langPara("elementspark_7")

	local function sureChange()
		GlobalDispatcher:dispatch(GlobalNotify.ElementSparkMoveChunkToCenter, defenseChunkId)
		self:close()
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow(lang("text_tong_tips"), tips, sureChange, cencelFunc, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

return ElementSparkSetTeamView
