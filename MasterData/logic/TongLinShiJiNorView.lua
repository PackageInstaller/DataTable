-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiNorView.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiNorView", package.seeall)

local TongLinShiJiNorView = class("TongLinShiJiNorView", ViewComponent)

function TongLinShiJiNorView:ctor()
	TongLinShiJiNorView.super.ctor(self)
end

function TongLinShiJiNorView:buildUI()
	TongLinShiJiNorView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._redpoint = self:getGo("reward/redpoint")
	self._txtChallengeTime = self:getTxt("left/chanllengeTime/txt")
	self._txtBossTime = self:getTxt("chanllengeSlider/btnClg/desc/txt")
	self._itemcell = self:getGo("reward/itemcell")
	self._btnGet = self:getGo("reward/btnGet")
	self._txtPetName = self:getTxt("reward/txtPetName")
	self._imgHasGain = self:getGo("reward/imgHasGain")
	self._slider = self:getSlider("chanllengeSlider/slider")
	self._sliderText = self:getTxt("chanllengeSlider/slider/Fill Area/Fill/Text")
	self._btnBossChallenge = self:getGo("chanllengeSlider/btnClg/btn")
	self._cells = self:getGo("left/cells")
	self._cellGoList = {}

	for i = 1, self._cells.transform.childCount do
		local cell = goutil.findChild(self._cells, "cell" .. i)

		table.insert(self._cellGoList, cell)
	end

	self._cellList = {}
end

function TongLinShiJiNorView:bindEvents()
	TongLinShiJiNorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickBtnGet, self)
	GameUtil.addClickHandler(self._btnBossChallenge, self._onClickBossChallenge, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
end

function TongLinShiJiNorView:unbindEvents()
	TongLinShiJiNorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnBossChallenge)
end

function TongLinShiJiNorView:onEnter()
	TongLinShiJiNorView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_JiClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_JiClgGainPrizeRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.ItemGetViewDoClosed, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = TongLinShiJiController.instance:getActivityId()
	end

	self._activityType = TongLinShiJiController.instance:getActivityType()

	local isInTime = TongLinShiJiController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.dailyClgNorTimes = TongLinShiJiConfig.instance:getJiActivityData(self._activityId).dailyClgNormalStageTimes
	self.dailyClgNorBossTimes = TongLinShiJiConfig.instance:getJiActivityData(self._activityId).dailyClgNormalBossTimes
	self._norStageData = TongLinShiJiConfig.instance:getJiNormalStageData(self._activityId)
	self._buffData = TongLinShiJiConfig.instance:getJiBuffData()

	for idx, cell in ipairs(self._cellGoList) do
		local cur = {}

		cur.bg = goutil.findChild(cell, "bg")
		cur.icon = goutil.findChild(cell, "frame/icon")
		cur.title = goutil.findChildTextComponent(cell, "title")
		cur.titleUIGradient = cur.title.gameObject:GetComponent(ComponentType.UIGradient)
		cur.txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
		cur.imgGainHelp = goutil.findChild(cell, "imgGainHelp")
		cur.go = cell

		table.insert(self._cellList, cur)
	end

	RedPointController.instance:regRedPoint(self._redpoint, RedPointModel.ID_TONG_LIN_SHI_JI_NOR_REWARD)
	self:_onSetUI()
	TongLinShiJiController.instance:sendPM_JiClgGetInfoReq(self._activityId)
end

function TongLinShiJiNorView:onExit()
	TongLinShiJiNorView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcell)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	RedPointController.instance:unregRedPoint(self._redpoint)

	for i, cell in ipairs(self._cellList) do
		uGuiUtil.clearImage(cell.icon)
		uGuiUtil.clearImage(cell.bg)
		GameUtil.rmClickHandler(cell.go)
	end

	self._cellList = {}
end

function TongLinShiJiNorView:_onSetUI()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	local normalPassPrize, _ = TongLinShiJiConfig.instance:GetPrizes(self._activityId)

	MaterialMgr.setCellByCfg(normalPassPrize, self._itemcell)

	local matType, matId, matNum = MaterialMgr.getMatParams(normalPassPrize)
	local petName
	local petData = CharacterConfig.instance:getPetCo(matId)

	if petData then
		self._txtPetName.text = petData.name
	end

	self:_onUpdate()
end

function TongLinShiJiNorView:_init()
	GameUtil.SetActive(self._btnGet, false)
	GameUtil.SetActive(self._txtPetName.gameObject, true)
end

function TongLinShiJiNorView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function TongLinShiJiNorView:_updateData()
	return
end

function TongLinShiJiNorView:_updateUI()
	self:_init()

	local canGetNorReward = TongLinShiJiController.instance:CanGetNorReward(self._activityId)
	local finishChallenge = TongLinShiJiModel.instance:FinishNorChallenge(self._activityId)
	local curNorBossHP = TongLinShiJiController.instance:GetNorBossHP(self._activityId)
	local curNorBossProgress = TongLinShiJiController.instance:GetNorBossProgress(self._activityId)
	local challengeTimesClg, bossTimesClg = TongLinShiJiConfig.instance:GetNorTimesClg(self._activityId)
	local curChallengeLeftTime, curBossLeftTime = TongLinShiJiModel.instance:GetNorLeftTimes(self._activityId)

	self._txtChallengeTime.text = "每日破执BUFF获得次数" .. curChallengeLeftTime .. "/" .. challengeTimesClg
	self._txtBossTime.text = "今日次数" .. curBossLeftTime .. "/" .. bossTimesClg

	self._slider:SetValue(curNorBossProgress)

	self._sliderText.text = "<color=#244C7A>剩余血量</color>\n<color=#FF0000>" .. curNorBossHP .. "%</color>"

	if canGetNorReward and not finishChallenge then
		GameUtil.SetActive(self._btnGet, true)
		GameUtil.SetActive(self._txtPetName.gameObject, false)
	end

	GameUtil.SetActive(self._imgHasGain, finishChallenge)

	for idx, cell in ipairs(self._cellList) do
		local canGainHelp = TongLinShiJiModel.instance:CanGainHelp(self._activityId, idx)
		local creepsId = self._norStageData[idx].unlockSupportCreepsId
		local curSupportPetData = TongLinShiJiConfig.instance:getJiSupportPetData(creepsId)

		if not curSupportPetData.faceId then
			if self._buffData[idx] then
				local iconBuffName = self._buffData[idx].iconBuff

				if self._buffData[idx] then
					local bgBuffName = self._buffData[idx].bgBuff

					uGuiUtil.setSpriteToImage(cell.icon, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("challenge", iconBuffName))
					uGuiUtil.setSpriteToImage(cell.bg, uGuiUtil.SpriteType.BigBg, GameUrl.getIconFolderUrl("challenge", bgBuffName))

					if self._buffData[idx] then
						local descBuff = self._buffData[idx].descBuff
						local descArr = self:getDescBuff(descBuff)
						local titleColorArr = self:getTitleColor(self._buffData[idx].titleColor)
						local colorUp = GameUtil.getColorByHexColor(titleColorArr[1])
						local colorDown = GameUtil.getColorByHexColor(titleColorArr[2])

						cell.title.text = descArr[1] or ""
						cell.titleUIGradient.TopColor = UnityEngine.Color32.New(colorUp.r * 255, colorUp.g * 255, colorUp.b * 255, colorUp.a * 255)
						cell.titleUIGradient.BottomColor = UnityEngine.Color32.New(colorDown.r * 255, colorDown.g * 255, colorDown.b * 255, colorDown.a * 255)
						cell.txtDesc.text = descArr[2] or ""

						GameUtil.SetActive(cell.imgGainHelp, canGainHelp)
						GameUtil.rmClickHandler(cell.go)
						GameUtil.addClickHandler(cell.go, function()
							if canGainHelp then
								FloatWordMgr.instance:show("已获得该效果！无法再次挑战获得")

								return
							end

							if curChallengeLeftTime <= 0 then
								FloatWordMgr.instance:show("今日破执次数已用完，请明天再来")

								return
							end

							TongLinShiJiController.instance:enterNorBattleClg(self._activityId, idx)
						end)
					end
				end
			end
		end
	end
end

function TongLinShiJiNorView:_onBtnSkillClg()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function TongLinShiJiNorView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function TongLinShiJiNorView:_onClickBtnTip()
	local key = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "ruleKeyNormal")

	TipsFacade.instance:openRulesView(key)
end

function TongLinShiJiNorView:_onClickBtnGet()
	TongLinShiJiController.instance:sendPM_JiClgGainPrizeReq(self._activityId, TongLinShiJiModel.NOR_PRIZE_TYPE)
end

function TongLinShiJiNorView:_onClickBossChallenge()
	local _, curBossLeftTime = TongLinShiJiModel.instance:GetNorLeftTimes(self._activityId)

	if curBossLeftTime <= 0 then
		FloatWordMgr.instance:show("今日挑战次数已用完，请明天再来")
	end

	UIStateManager.instance:push(ViewName.TongLinShiJiNorBossView, self._activityId)
end

function TongLinShiJiNorView:_getRaceId()
	return TongLinShiJiController.instance:getRaceId(self._activityId)
end

function TongLinShiJiNorView:_getSkinId()
	return TongLinShiJiController.instance:getSkinId(self._activityId)
end

function TongLinShiJiNorView:getDescBuff(descBuff)
	return (string.split(descBuff, "#"))
end

function TongLinShiJiNorView:getTitleColor(titleColor)
	return (string.split(titleColor, "-"))
end

return TongLinShiJiNorView
