-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossMainView.lua

module("logic.extensions.worldboss.view.WorldBossMainView", package.seeall)

local WorldBossMainView = class("WorldBossMainView", ViewComponent)

function WorldBossMainView:ctor()
	WorldBossMainView.super.ctor(self)
end

function WorldBossMainView:buildUI()
	WorldBossMainView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._bgMask = self:getGo("bg/mask")
	self._btnClose = self:getBtn("btnClose")
	self._btnExplain = self:getBtn("btnExplain")
	self._tip = self:getGo("tip")
	self._tipText = self:getGo("tip/Text"):GetComponent("Text")
	self._rolePoint = self:getGo("mid/rolePoint")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtCount = self:getGo("btnChallenge/txtCount"):GetComponent("Text")
	self._txtCountValue = self:getGo("btnChallenge/txtCountValue"):GetComponent("Text")
	self._btnBuyTimes = self:getBtn("btnChallenge/btnBuyTimes")
	self._btnPractice = self:getBtn("btnPractice")
	self._btnRankReward = self:getBtn("btnRankReward")
	self._btnRank = self:getBtn("btnRank")
	self._btnChange = self:getBtn("btnChange")
	self._imgRankKingBk = self:getGo("imgRankKingBk")

	self._imgRankKingBk.gameObject:SetActive(false)

	self._imgKingIcon = self:getGo("imgRankKingBk/imgKingIcon")
	self._txtRankKingValue = self:getGo("imgRankKingBk/txtRankKingValue"):GetComponent("Text")
	self._txtRankKingName = self:getGo("imgRankKingBk/txtRankKingName"):GetComponent("Text")
	self._txt_lv = self:getGo("imgRankKingBk/txt_lv"):GetComponent("Text")
	self._widSkill = self:getGo("widSkill")

	local _widSkillCell = self:getGo("skillCell")

	self._Skills = {}

	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local go = goutil.clone(_widSkillCell)

		go.transform:SetParent(self._widSkill.transform, false)

		self._Skills[#self._Skills + 1] = go
	end

	self._goldBar = self:getGo("goldBar")
	self._imgSkillTip = self:getGo("imgSkillTip")

	self._imgSkillTip.gameObject:SetActive(false)

	self._btnSkillTip = self:getBtn("btnSkillTip")

	self._btnSkillTip.gameObject:SetActive(false)

	self._txtSkillTitle = self:getGo("imgSkillTip/txtSkillTitle"):GetComponent("Text")
	self._txtSkillContent = self:getGo("imgSkillTip/txtSkillContent"):GetComponent("Text")
	self._imgBossBgGroup = self:getGo("widRight"):GetComponent("UIChangeGroup")
	self._rightBgGo = self:getGo("widRight/imgBG")
	self._imgBossName = self:getGo("widRight/imgBossName"):GetComponent("UIImageSpriteChange")
	self._txtRemindTitle = self:getGo("widRight/imgRemind/txtRemindTitle"):GetComponent("Text")
	self._txtRemindContent = self:getGo("widRight/imgRemind/txtRemindContent"):GetComponent("Text")
	self._txtRemindTitle = self:getGo("widRight/imgReward/txtRemindTitle"):GetComponent("Text")
	self._itemCell = self:getGo("widRight/imgReward/itemCell")
	self._rewardView = ScrollerList.create(self:getGo("widRight/imgReward/view"), self._itemCell, GameUtil.handler(self._updateRewardView, self), GameUtil.handler(self._clearCell, self))
	self._txtDamageValue = self:getGo("imgDamageBk/txtDamageValue"):GetComponent("Text")
	self._txtDamageValue.text = 0
	self._txtCountDownTimeValue = self:getGo("imgCountDownTime/value"):GetComponent("Text")

	self:_updateCountDownTime()

	self._scheduleBtn = self:getBtn("scheduleBtn")
	self.itemGDC = self:getGo("goldenDiamond/item")
	self.showTip = self:getTxt("goldenDiamond/showTip")
	self.colorChange = self:getGo("goldenDiamond/showTip"):GetComponent("UITextColorChange")
	self.addTime = GoldenDiamondCardConfig.instance:getPrivilegeDefaultValue(GoldenDiamondCardModel.PrivilegeType.WorldBossFreeTime)
	self._buffTip = self:getGo("buffTip")
	self._buffCon = self:getGo("buffTip/buffCon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._buffCell = self:getGo("buffTip/buffCell")
end

function WorldBossMainView:bindEvents()
	WorldBossMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnExplain:AddClickListener(self._onClickBtnExplain, self)
	self._btnChallenge:AddClickListener(self._onClickBtnChallenge, self)
	self._btnBuyTimes:AddClickListener(self._onClickBtnBuyTimes, self)
	self._btnPractice:AddClickListener(self._onClickBtnPractice, self)
	self._btnRankReward:AddClickListener(self._onClickBtnRankReward, self)
	self._btnRank:AddClickListener(self._onClickBtnRank, self)
	self._btnChange:AddClickListener(self._onClickExchange, self)
	self._btnSkillTip:AddClickListener(self._onClickSkillTip, self)
	self._scheduleBtn:AddClickListener(self._onClickSchedule, self)
end

function WorldBossMainView:unbindEvents()
	WorldBossMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnBuyTimes:RemoveClickListener()
	self._btnPractice:RemoveClickListener()
	self._btnRankReward:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnSkillTip:RemoveClickListener()
	self._scheduleBtn:RemoveClickListener()
end

function WorldBossMainView:destroyUI()
	WorldBossMainView.super.destroyUI(self)
end

function WorldBossMainView:onEnter()
	WorldBossMainView.super.onEnter(self)
	WorldBossController.instance:requestWorldBossInfo()
	self:_updateSkill()
	self:_updateBossInfo()
	self._rewardView:reloadData(WorldBossController.instance:getWorldBossPrizeTypeByBossId())
	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor)
	removetimer(self._updateCountDownTime, self)
	settimer(1, self._updateCountDownTime, self, true)

	self.isUserOfGDC = GoldenDiamondCardModel.instance.isUser

	uGuiUtil.setRawImageGrayState(self.itemGDC, not self.isUserOfGDC)
	self.colorChange:SetState(self.isUserOfGDC and 0 or 1)

	self.showTip.text = self.isUserOfGDC and langPara("金钻特权已获得免费次数%s次", self.addTime) or langPara("激活金钻特权每日获得免费次数%s次", self.addTime)
end

function WorldBossMainView:onEnterFinished()
	WorldBossMainView.super.onEnterFinished(self)
	self:_updateLihui()
end

function WorldBossMainView:onExit()
	WorldBossMainView.super.onExit(self)

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	removetimer(self._updateCountDownTime, self)
	self._rewardView:dispose()

	for i, go in pairs(self._cloneBuffCells) do
		local buffIcon = goutil.findChild(self._cloneBuffCells[i], "buffIcon/icon")

		uGuiUtil.clearImage(buffIcon)
		goutil.destroy(self._cloneBuffCells[i])
	end
end

function WorldBossMainView:onExitFinished()
	WorldBossMainView.super.onExitFinished(self)
end

function WorldBossMainView:_updateCountDownTime()
	local _bossEndTime = WorldBossController.instance:_getBossEndTime()

	if not _bossEndTime then
		return
	end

	local now = ServerTime.now()
	local _leftTime = _bossEndTime - now

	if WorldBossController.instance:isInBossFightTime() then
		if _leftTime > 0 and WorldBossController.instance:isInBossCanFightTime() then
			local timeVale = TimeUtil:timeConvert2(_leftTime, "HH:MM:SS", true)

			self._txtCountDownTimeValue.text = string.format("活动时间：%s", timeVale)

			local buyFlag = WorldBossConfig.instance:getWorldBossCommonConfig().BUY_TIMES_SWITCH.value

			goutil.setActive(self._btnBuyTimes.gameObject, buyFlag ~= "FALSE")
		else
			self._txtCountDownTimeValue.text = "活动已结束"

			self._btnChallenge:RemoveClickListener()
			self._btnPractice:RemoveClickListener()
			uGuiUtil.setImageGrayStateRecursive(self._btnChallenge.gameObject, true)
			uGuiUtil.setImageGrayStateRecursive(self._btnPractice.gameObject, true)
			goutil.setActive(self._btnBuyTimes.gameObject, false)
		end
	else
		self:close()
	end
end

function WorldBossMainView:_onClickBtnClose()
	self:close()
end

function WorldBossMainView:_onClickBtnExplain()
	ViewMgr.instance:open(ViewName.RulesView, "worldbossmainrule")
end

function WorldBossMainView:_onClickBtnChallenge()
	if not WorldBossController.instance:isInBossCanFightTime() then
		FloatWordMgr.instance:show(lang("world_Boss_tip14"))

		return
	end

	local _allTimes = WorldBossController.instance:getAllChallengeTime()
	local _bossInfo = WorldBossController.instance:getWorldBossInfo()

	if not _bossInfo then
		return
	end

	local _leftTime = _allTimes - _bossInfo.fightTimes

	if _leftTime <= 0 then
		local price = WorldBossController.instance:_buyChallengePrice()
		local buyFlag = WorldBossConfig.instance:getWorldBossCommonConfig().BUY_TIMES_SWITCH.value

		if price and buyFlag ~= "FALSE" then
			local _tipStr = string.format(lang("world_Boss_tip8"), price)

			TipsFacade.instance:openPopupCostDiamondView(price, _tipStr, function()
				WorldBossAgent.instance:sendPM_WorldBossBuyTimesReq(function()
					WorldBossController.instance:updateWorldBossBuyTimes()
				end)
			end)
		else
			FloatWordMgr.instance:show(lang("world_Boss_tip7"))
		end
	else
		UIStateManager.instance:push(ViewName.WorldBossMissionView, WorldBossController.FightTypeChallenge)
	end
end

function WorldBossMainView:_onClickBtnBuyTimes()
	local price = WorldBossController.instance:_buyChallengePrice()

	if price then
		local _tipStr = string.format(lang("world_Boss_tip8"), price)

		TipsFacade.instance:openPopupCostDiamondView(price, _tipStr, function()
			WorldBossAgent.instance:sendPM_WorldBossBuyTimesReq(function()
				WorldBossController.instance:updateWorldBossBuyTimes()
			end)
		end)
	end
end

function WorldBossMainView:_onClickBtnPractice()
	if not WorldBossController.instance:isInBossCanFightTime() then
		FloatWordMgr.instance:show(lang("world_Boss_tip14"))

		return
	end

	local _bossInfo = WorldBossController.instance:getWorldBossInfo()

	if not _bossInfo then
		return
	end

	UIStateManager.instance:push(ViewName.WorldBossMissionView, WorldBossController.FightTypePratice)
end

function WorldBossMainView:_onClickBtnRankReward()
	UIStateManager.instance:push(ViewName.WorldbossrewardtabView)
end

function WorldBossMainView:_onClickBtnRank()
	UIStateManager.instance:push(ViewName.WorldBossRankView)
end

function WorldBossMainView:_updateBossInfo()
	local _bossInfo = WorldBossController.instance:getEmenyBossInfo()

	if not _bossInfo then
		return
	end

	local _todayBossId = WorldBossController.instance:getTodayBossId() or 1

	if _todayBossId then
		local _enemyTeamInfo = WorldBossController.instance:getEnemyTeamInfo(_todayBossId)

		if _enemyTeamInfo then
			self._imgBossBgGroup:SetState(_enemyTeamInfo.nameId)
			uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("worldboss/" .. _enemyTeamInfo.bg))
			uGuiUtil.setSpriteToImage(self._bgMask, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("worldboss/" .. _enemyTeamInfo.mask))

			self._txtRemindContent.text = _enemyTeamInfo.description

			if not string.nilorempty(_enemyTeamInfo.rightBg) then
				uGuiUtil.setSpriteToImage(self._rightBgGo, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl("worldboss/" .. _enemyTeamInfo.rightBg))
			end

			self._cloneBuffCells = {}

			GameUtil.SetActive(self._buffCell, false)

			local buffIdArr = string.split(_enemyTeamInfo.buffId, "#")
			local buffTime = WorldBossConfig.instance:getWorldBossCommonConfigValueByKey("BUFF_TIME")
			local timeArr = string.split(buffTime, "#")
			local checkIsTime = GameUtil.checkIsInTimePeriod(timeArr[1], timeArr[2])

			if #buffIdArr > 0 and checkIsTime then
				for i, id in ipairs(buffIdArr) do
					local cfg = BattleConfig.instance:getBuffCo(checknumber(id))

					if cfg then
						local clone = goutil.cloneAndSetParent(self._buffCell, self._buffCon.transform)

						table.insert(self._cloneBuffCells, clone)

						local buffIcon = goutil.findChild(clone, "buffIcon/icon")
						local buffDesc = goutil.findChildTextComponent(clone, "txtBuffDesc")

						uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))

						buffDesc.text = cfg.buffDesc

						GameUtil.SetActive(clone, true)
					end
				end

				self._buffCon:Layout()
				GameUtil.SetActive(self._buffTip, true)
			else
				GameUtil.SetActive(self._buffTip, false)
			end
		end
	end
end

function WorldBossMainView:_updateSkill()
	local _bossInfo = WorldBossController.instance:getEmenyBossInfo()

	if not _bossInfo then
		return
	end

	local data = {}

	data.raceId = _bossInfo.raceId
	data.awakeLevel = _bossInfo.awakenLv
	data.summonedPetId = _bossInfo.summonedPetId

	local petCo = PetSkinConfig.instance:getPetSkinCfg(data.raceId)
	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.SkillName[skillType]
		local go = self._Skills[index]
		local con = goutil.findChild(go, "icon")
		local txt = goutil.findChildTextComponent(go, "txt_skillname")
		local skillId = petCo[v]
		local txtSkillLv = goutil.findChildTextComponent(go, "txt_skill_lv")
		local txtSkillType = goutil.findChildTextComponent(go, "txt_skill_type")
		local skillCfg = BattleConfig.instance:getSkillCo(skillId)

		GameUtil.asBtn(go):RemoveClickListener()
		MaterialMgr.resetAll(con)

		if skillId == 0 then
			go:SetActive(false)
		else
			go:SetActive(true)

			local proxy = MaterialMgr.setSkillByFaceId(skillId, data.raceId, con)

			if proxy then
				proxy:setAutoTips(false)
				GameUtil.asBtn(go):AddClickListener(GameUtil.handler(self._OnClickSkill, self, skillType, skillId, go))
			end

			txtSkillType.text = MaterialMgr.getSkillTypeName(skillId)
			txtSkillLv.text = string.format("等级%s", CharacterConfig.instance:getSkillMaxLv(data.raceId, skillType))
			txt.text = skillCfg.name
		end
	end
end

function WorldBossMainView:_OnClickSkill(skillType, skillId, go)
	local _bossInfo = WorldBossController.instance:getEmenyBossInfo()

	if not _bossInfo then
		return
	end

	local raceId = _bossInfo.raceId
	local data = {
		raceId = raceId,
		talentLevel = _bossInfo.talentLv
	}

	if not data[MaterialMgr.SkillLvlKey[skillType]] then
		CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillId, data.raceId, data[MaterialMgr.SkillLvlKey[skillType]])
	end
end

function WorldBossMainView:_onClickSkillTip()
	self._imgSkillTip.gameObject:SetActive(false)
	self._btnSkillTip.gameObject:SetActive(false)
end

function WorldBossMainView:_onClickSchedule()
	UIStateManager.instance:push(ViewName.WorldBossScheduleView)
end

function WorldBossMainView:_updateLihui()
	local _bossInfo = WorldBossController.instance:getEmenyBossInfo()

	if not _bossInfo then
		return
	end

	local raceId = _bossInfo.raceId

	if not _bossInfo.displayPos then
		local faceIds = CharacterConfig.instance:getPetCo(raceId).faceIds

		if not _bossInfo.displayPos[1] then
			if not _bossInfo.displayPos[2] then
				local y = 0

				if not _bossInfo.displayPos[3] then
					local scale = 1

					self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, faceIds, self._rolePoint, scale, nil, true, _bossInfo.displayPos[1], y)
				end
			end
		end
	end
end

function WorldBossMainView:_updateRewardView(view, cell, data, tag)
	MaterialMgr.resetAll(cell.gameObject)

	local proxy = MaterialMgr.setCellByCfg(data, cell.gameObject)

	Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.8, 0.8, 1)
end

function WorldBossMainView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function WorldBossMainView:_updateViewByWorldBossInfoRes()
	local _bossInfo = WorldBossController.instance:getWorldBossInfo()

	if _bossInfo then
		self._txtDamageValue.text = _bossInfo.totalDamange

		self:_updateChallengeTime()

		if _bossInfo.first and _bossInfo.first ~= "" then
			local json = require("cjson")
			local rankFirstInfo = json.decode(_bossInfo.first)

			if rankFirstInfo then
				self._imgRankKingBk.gameObject:SetActive(true)
				HeadItemController.instance:setHeadCellByInfo(self._imgKingIcon, rankFirstInfo.headInfo)

				self._txtRankKingName.text = rankFirstInfo.headInfo.userName
				self._txtRankKingValue.text = rankFirstInfo.value
				self._txt_lv.text = rankFirstInfo.headInfo.playerLv or 0
			end
		end
	end
end

function WorldBossMainView:_updateChallengeTime()
	local _bossInfo = WorldBossController.instance:getWorldBossInfo()

	if not _bossInfo then
		return
	end

	local _allTimes = WorldBossController.instance:getAllChallengeTime()

	self._txtCountValue.text = string.format("%s<color>/%s</color>", _allTimes - _bossInfo.fightTimes, _allTimes)

	if _allTimes - _bossInfo.fightTimes > 0 then
		goutil.findChildComponent(self._txtCountValue.gameObject, "", "UITextColorChange"):SetState(1)
	else
		goutil.findChildComponent(self._txtCountValue.gameObject, "", "UITextColorChange"):SetState(0)
	end
end

function WorldBossMainView:_onClickExchange()
	GotoMgr.gotoByString("func#470#ExchangeWorldBoss")
end

return WorldBossMainView
