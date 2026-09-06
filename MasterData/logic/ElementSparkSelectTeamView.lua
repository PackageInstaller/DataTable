-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementSparkSelectTeamView.lua

module("logic.extensions.elementspark.view.ElementSparkSelectTeamView", package.seeall)

local ElementSparkSelectTeamView = class("ElementSparkSelectTeamView", ViewComponent)

function ElementSparkSelectTeamView:ctor()
	ElementSparkSelectTeamView.super.ctor(self)
end

function ElementSparkSelectTeamView:unbindEvents()
	ElementSparkSelectTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnTeam)
end

function ElementSparkSelectTeamView:bindEvents()
	ElementSparkSelectTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnTeam, self._onClickTeam, self)
end

function ElementSparkSelectTeamView:buildUI()
	ElementSparkSelectTeamView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnTeam = self:getBtn("btnTeam")
	self._tableViewGo = self:getGo("tableview")
	self._cellGo = self:getGo("cell")
	self._tableView = ScrollerList.create(self._tableViewGo, self._cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ElementSparkSelectTeamView:onExit()
	ElementSparkSelectTeamView.super.onExit(self)
	self._tableView:dispose()
end

function ElementSparkSelectTeamView:onEnter()
	ElementSparkSelectTeamView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.EleSparkGetMyFormsRes, self._refresh, self)

	self._activityId = ElementSparkController.instance:getActivityId()

	self:_sendInfoReq()

	local params = self:getOpenParam()

	self._challengeType = checknumber(params[1])
	self._chunkId = checknumber(params[2])
	self._petCellCount = 6
	self._needStrength = 0
	self._teamId = ElementSparkModel.instance:getSelectTeamId()
	self._maxPower = ElementSparkConfig.instance:getCommonCfgByKey("TEAM_STRENGTH_LIMIT", true)
end

function ElementSparkSelectTeamView:_sendInfoReq()
	ElementSparkController.instance:sendPM_EleSparkGetMyFormsReq(self._activityId)
end

function ElementSparkSelectTeamView:_refresh()
	if self._challengeType == GameEnum.ElementChallengeType.Boss then
		self._needStrength = ElementSparkConfig.instance:getCommonCfgByKey("ATTACK_BOSS_COST", true)
	elseif self._challengeType == GameEnum.ElementChallengeType.Guard then
		local belong = ElementSparkModel.instance:getChunkBelong(self._chunkId)

		self._needStrength = belong <= 0 and ElementSparkConfig.instance:getCommonCfgByKey("ATTACK_SYS_COST", true) or ElementSparkConfig.instance:getCommonCfgByKey("ATTACK_PLAYER_COST", true)
	end

	self._teamInfo = {}
	self._teamInfo = ElementSparkController.instance:getAttackInfo(self._teamInfo)

	local teamInfo = self._teamInfo[self._teamId].teamInfo

	if teamInfo.teamStrength then
		if not teamInfo.teamStrength.strength then
			local selectTeamStrength = 0

			if selectTeamStrength < self._needStrength then
				for i, v in ipairs(self._teamInfo) do
					local info = v.teamInfo.teamStrength

					if info then
						local strength = info.strength

						if strength >= self._needStrength then
							self._teamId = i

							ElementSparkModel.instance:setSelectTeamId(self._teamId)

							break
						end
					end
				end
			end

			self._tableView:reloadData(self._teamInfo)
		end
	end
end

function ElementSparkSelectTeamView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "info/txtName")
	local txtPower = goutil.findChildTextComponent(cell, "info/txtPower")
	local empty = goutil.findChild(cell, "empty")
	local btnSelect = goutil.findChildButtonComponent(cell, "btnSelect")
	local select = goutil.findChild(cell, "btnSelect/imgSelect")
	local teamMo = ElementSparkController.instance:getTeamMo(data.teamInfo.form)

	for i = 1, self._petCellCount do
		local empty = goutil.findChild(cell, "petCell_" .. i .. "/empty")
		local pet = goutil.findChild(cell, "petCell_" .. i .. "/pet")

		if teamMo[i] then
			GameUtil.SetActive(empty, false)
			GameUtil.SetActive(pet, true)

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
		else
			GameUtil.SetActive(empty, true)
			GameUtil.SetActive(pet, false)
		end
	end

	GameUtil.SetActive(select, self._teamId == cell.index + 1)

	local teamStrength = data.teamInfo.teamStrength

	txtPower.text = string.format("体力：%d/%d", (teamStrength ~= nil or nil) and data.teamInfo.teamStrength.strength, self._maxPower)
	txtName.text = string.format("队伍%s", ConstString.ChineseNumber[cell.index + 1])

	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickSelectTeam, self, cell.index + 1, cell))
end

function ElementSparkSelectTeamView:_clearCell(cell)
	local btnSelect = goutil.findChildButtonComponent(cell, "btnSelect")

	for i = 1, self._petCellCount do
		local petCon = goutil.findChild(cell, "petCell_" .. i .. "/pet/mask/con")

		uGuiUtil.clearImage(petCon)
	end

	GameUtil.rmClickHandler(btnSelect)
end

function ElementSparkSelectTeamView:_onClickSelectTeam(teamId, cell)
	self._teamId = teamId

	self._tableView:refresh()
end

function ElementSparkSelectTeamView:_onClickTeam()
	UIStateManager.instance:push(ViewName.ElementSparkSetTeamView)
	self:close()
end

function ElementSparkSelectTeamView:_onClickChallenge()
	local info = self._teamInfo[self._teamId].teamInfo

	if ((info.teamStrength or nil) and info.teamStrength.strength) < self._needStrength and self._teamId > 0 then
		FloatWordMgr.instance:show("挑战需要体力不足" .. self._needStrength)

		return
	end

	ElementSparkModel.instance:setSelectTeamId(self._teamId)
	ElementSparkController.instance:openElementSparkSetForm(self._activityId, self._teamId, false, self._chunkId, self._challengeType)
	self:close()
end

return ElementSparkSelectTeamView
