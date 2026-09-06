-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/RankItem.lua

module("logic.extensions.rank.view.RankItem", package.seeall)

local RankItem = class("RankItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function RankItem:ctor(go)
	self.mainGO = go
	self._texts = {}

	self:buildUI()
end

function RankItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, RankItem)

	component = component or LuaComponentContainer.Add(go, RankItem)

	return component
end

function RankItem:buildUI()
	self._imgIcon = goutil.findChild(self.mainGO, "imgIcon")
	self._imgPetIcon = goutil.findChildComponent(self.mainGO, "imgPetIcon", "Image")
	self._imgPetIconChange = goutil.findChild(self.mainGO, "imgPetIcon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtFamily = self:addText(self.mainGO, "txtFamily")
	self._txtName = self:addText(self.mainGO, "txtName")
	self._txtWin = self:addText(self.mainGO, "txtWin")
	self._txtWinRate = self:addText(self.mainGO, "txtWinRate")
	self._tagFloat = goutil.findChildComponent(self.mainGO, "tagFloat", "UIImageSpriteChange")
	self._tagFloatNum = self:addText(self.mainGO, "tagFloatNum")
	self._btnPlay = Framework.ButtonAdapter.GetFrom(self.mainGO.gameObject, "btnPlay")
	self._btnDef = Framework.ButtonAdapter.GetFrom(self.mainGO.gameObject, "btnDef")
	self._imgLeft = goutil.findChildComponent(self.mainGO, "imgLeft", "UIImageSpriteChange")
	self._imgRight = goutil.findChildComponent(self.mainGO, "imgRight", "UIImageSpriteChange")
	self._txtRank = self:addText(self.mainGO, "txtRank")

	self._btnPlay.gameObject:SetActive(false)
	self._btnDef.gameObject:SetActive(false)
	self._btnPlay:AddClickListener(self._onClickPlay, self)

	self._fightPower = goutil.findChild(self.mainGO, "fightPower")
	self._passTime = goutil.findChild(self.mainGO, "passTime")
	self._defPower = goutil.findChild(self.mainGO, "defPower")
	self._maxPower = goutil.findChild(self.mainGO, "maxPower")
	self._xiaonuobian = goutil.findChild(self.mainGO, "xiaonuobian")
	self._score = goutil.findChild(self.mainGO, "score")
	self._txtFightPower = self:addText(self._fightPower, "txtFightPower")
	self._txtPassTime = self:addText(self._passTime, "txtPassTime")
	self._txtDefPower = self:addText(self._defPower, "txtFightPower")
	self._txtMaxPower = self:addText(self._maxPower, "txtMaxPower")
	self._txtScore = self:addText(self._score, "txtScore")
	self._txtTotalMoney = self:addText(self._xiaonuobian, "txtTotalMoney")
	self._txtProgress = self:addText(self.mainGO, "txtProgress")
	self._btnIcon = Framework.ButtonAdapter.GetFrom(self.mainGO.gameObject, "btnIcon")
	self._countFlower = goutil.findChild(self.mainGO, "countFlower")
	self._txtCountFlower = goutil.findChildTextComponent(self._countFlower, "txt")
	self._btnSupport = Framework.ButtonAdapter.GetFrom(self.mainGO.gameObject, "btnSupport")
	self._itemPrize = goutil.findChild(self.mainGO, "itemPrize")
	self._btnSupportTween = self._btnSupport.gameObject:GetComponent("TweenPosition")
	self._reward = goutil.findChild(self.mainGO, "reward")
	self._rewardTab = goutil.findChild(self.mainGO, "reward/rewardList")
	self._rewardCell = goutil.findChild(self.mainGO, "reward/rewardItem")
	self._rewardList = nil
end

function RankItem:addText(container, offset)
	return (goutil.findChildTextComponent(container, offset))
end

function RankItem:updateSeniorArena(mo)
	self:_resetTextLocalPos()
	goutil.setActive(self._imgIcon, true)

	local parent = self.mainGO.transform
	local childCount = parent.childCount

	for i = 1, childCount - 1 do
		parent:GetChild(i).gameObject:SetActive(false)
	end

	self._imgIcon:SetActive(true)
	self._txtRank.gameObject:SetActive(true)
	self._txtFamily.gameObject:SetActive(true)
	self._txtName.gameObject:SetActive(true)
	self._btnDef.gameObject:SetActive(true)
	HeadItemController.instance:setHeadCellByInfo(self._imgIcon, mo.headInfo)

	self._txtRank.text = mo.rank
	self._txtFamily.text = mo.score

	if mo.headInfo then
		self._txtName.text = mo.headInfo.userName or ""
	end

	self._btnDef:AddClickListener(function()
		if mo.headInfo then
			SeniorArenaController.instance:openOtherDefendFormsView(mo.headInfo.userId, mo)
		end
	end)
	GameUtil.SetActive(self._btnIcon, true)

	if self._btnIcon ~= nil then
		self._btnIcon:RemoveClickListener()
		self._btnIcon:AddClickListener(function()
			if mo.headInfo then
				self:_onClickIcon(checknumber(mo.headInfo.userId))
			end
		end)
	end
end

function RankItem:updateFamilyHonor(mo)
	for i = 1, self.mainGO.transform.childCount - 1 do
		self.mainGO.transform:GetChild(i).gameObject:SetActive(false)
	end

	GameUtil.SetActive(self._txtRank, true)

	self._txtRank.text = tostring(mo.rank)

	GameUtil.SetActive(self._txtName, true)

	self._txtName.text = mo.familyName

	GameUtil.SetActive(self._txtFamily, true)

	self._txtFamily.text = tostring(mo.starList[3])

	GameUtil.SetActive(self._txtWin, true)

	self._txtWin.text = tostring(mo.starList[2])

	GameUtil.SetActive(self._txtWinRate, true)

	self._txtWinRate.text = tostring(mo.starList[1])

	GameUtil.SetActive(self._txtProgress, true)

	self._txtProgress.text = tostring(mo.gloryValue)

	Framework.TransformUtil.SetAnchoredPos(self._txtName.gameObject.transform, 280, -60)
	Framework.TransformUtil.SetAnchoredPos(self._txtFamily.gameObject.transform, 500, -60)
	Framework.TransformUtil.SetAnchoredPos(self._txtWin.gameObject.transform, 660, -60)
	Framework.TransformUtil.SetAnchoredPos(self._txtWinRate.gameObject.transform, 800, -60)
	Framework.TransformUtil.SetAnchoredPos(self._txtProgress.gameObject.transform, 950, -60)
end

function RankItem:_resetTextLocalPos()
	Framework.TransformUtil.SetAnchoredPos(self._txtName.gameObject.transform, 268, -60)
	Framework.TransformUtil.SetAnchoredPos(self._txtFamily.gameObject.transform, 586, -60)
	Framework.TransformUtil.SetAnchoredPos(self._txtWin.gameObject.transform, 767, -60)
	Framework.TransformUtil.SetAnchoredPos(self._txtWinRate.gameObject.transform, 896, -60)
	Framework.TransformUtil.SetAnchoredPos(self._txtProgress.gameObject.transform, 1006, -60)
	Framework.TransformUtil.SetAnchoredPos(self._passTime.transform, 767, -60)
end

function RankItem:updateGloryTowerRank(mo, selectedLeaf)
	self:onSetMo(mo, selectedLeaf, GameEnum.RankType.GloryTowerRank)
end

function RankItem:updateAchievementRank(mo)
	self:onSetMo(mo, nil, GameEnum.RankType.AchievementRank)
	goutil.setActive(self._score, false)
	goutil.setActive(self._passTime, true)

	if checknumber(mo.timeStamp) > 0 then
		local time = GameUtil.time2date(checknumber(mo.timeStamp / 1000))

		self._txtPassTime.text = string.format("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
	end

	goutil.setActive(self._txtProgress.gameObject, mo.score ~= nil)

	if mo.score ~= nil then
		self._txtProgress.text = mo.score
	end
end

function RankItem:updateFamilyTeamPlay(mo, selectedLeaf)
	if selectedLeaf == 5 then
		for i = 1, self.mainGO.transform.childCount - 1 do
			self.mainGO.transform:GetChild(i).gameObject:SetActive(false)
		end

		GameUtil.SetActive(self._txtRank, true)

		self._txtRank.text = tostring(mo.rank)

		GameUtil.SetActive(self._txtName, true)

		self._txtName.text = mo.familyName

		GameUtil.SetActive(self._txtFamily, true)

		self._txtFamily.text = tostring(mo.starList[3])

		GameUtil.SetActive(self._txtWin, true)

		self._txtWin.text = tostring(mo.starList[2])

		GameUtil.SetActive(self._txtWinRate, true)

		self._txtWinRate.text = tostring(mo.starList[1])

		GameUtil.SetActive(self._txtProgress, true)

		self._txtProgress.text = tostring(mo.gloryValue)

		GameUtil.SetActive(self._imgPetIcon, true)
		self._imgPetIconChange:SetState(mo.iconId)
		Framework.TransformUtil.SetAnchoredPos(self._txtName.gameObject.transform, 280, -60)
		Framework.TransformUtil.SetAnchoredPos(self._txtFamily.gameObject.transform, 500, -60)
		Framework.TransformUtil.SetAnchoredPos(self._txtWin.gameObject.transform, 660, -60)
		Framework.TransformUtil.SetAnchoredPos(self._txtWinRate.gameObject.transform, 800, -60)
		Framework.TransformUtil.SetAnchoredPos(self._txtProgress.gameObject.transform, 950, -60)
	else
		for i = 1, self.mainGO.transform.childCount - 1 do
			self.mainGO.transform:GetChild(i).gameObject:SetActive(false)
		end

		GameUtil.SetActive(self._txtRank, true)

		self._txtRank.text = tostring(mo.rank)

		GameUtil.SetActive(self._txtName, true)

		self._txtName.text = mo.familyName

		GameUtil.SetActive(self._txtFamily, true)

		self._txtFamily.text = mo.areaName

		GameUtil.SetActive(self._txtWin, true)

		self._txtWin.text = tostring(mo.score)

		GameUtil.SetActive(self._imgPetIcon, true)
		self._imgPetIconChange:SetState(mo.familyIconId)
		GameUtil.SetActive(self._btnIcon, true)

		if self._btnIcon ~= nil then
			self._btnIcon:RemoveClickListener()
			self._btnIcon:AddClickListener(function()
				self:_onClickFamilyIcon(mo.familyName, mo.familyId, mo.areaName)
			end)
		end

		Framework.TransformUtil.SetAnchoredPos(self._txtName.gameObject.transform, 280, -60)
		Framework.TransformUtil.SetAnchoredPos(self._txtFamily.gameObject.transform, 580, -60)
		Framework.TransformUtil.SetAnchoredPos(self._txtWin.gameObject.transform, 940, -60)
	end
end

function RankItem:updateSendFlower(mo, selectedLeaf)
	self:onSetMo(mo, selectedLeaf, GameEnum.RankType.SendFlower_RANK)
end

function RankItem:updateCharm(mo)
	self:onSetMo(mo, nil, GameEnum.RankType.Charm_RANK)
end

function RankItem:onSetMo(mo, selectedLeaf, rankType)
	self:_resetTextLocalPos()
	self._btnDef:AddClickListener(self._onClickDef, self)

	self._mo = mo
	self._rankType = rankType

	goutil.setActive(self.mainGO.gameObject, mo ~= nil)
	goutil.setActive(self._reward, false)

	if not mo then
		return
	end

	if mo.raceId then
		self._imgIcon.gameObject:SetActive(false)
		self._imgPetIcon.gameObject:SetActive(true)

		local modelCo = CharacterConfig.instance:getModelCo(checknumber(mo.raceId))

		if modelCo then
			uGuiUtil.setSpriteToImage(self._imgPetIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
		else
			self._imgPetIcon.gameObject:SetActive(false)
			print("mo.raceId:", mo.raceId, ", 没有配置头像")
		end
	else
		self._imgIcon.gameObject:SetActive(true)
		self._imgPetIcon.gameObject:SetActive(false)

		if mo.headInfo then
			HeadItemController.instance:setHeadCellByInfo(self._imgIcon, mo.headInfo)

			self._txtName.text = mo.headInfo.userName
		end
	end

	self._txtFamily.text = self._rankType == GameEnum.RankType.Mirror_Rank and checknumber(mo.stageId) .. "层" or string.nilorempty(mo.familyName) and (string.nilorempty(mo.fightTimes) and lang("无") or mo.fightTimes) or mo.familyName

	local rank = checknumber(mo.rank)

	if self._txtRank then
		self._txtRank.text = tostring(rank)
	end

	if mo.petName then
		self._txtName.text = mo.petName
	end

	if mo.winTimes then
		self._txtWin.gameObject:SetActive(true)

		self._txtWin.text = mo.winTimes
	else
		self._txtWin.gameObject:SetActive(false)
	end

	if mo.winRate then
		self._txtWinRate.gameObject:SetActive(true)

		self._txtWinRate.text = mo.winRate .. "%"
	else
		self._txtWinRate.gameObject:SetActive(false)
	end

	if mo.rank and mo.oldRank then
		self._tagFloatNum.gameObject:SetActive(true)

		local subRank

		if mo.oldRank > -1 then
			subRank = mo.oldRank - mo.rank

			if mo.oldRank - mo.rank > 0 then
				self._tagFloat.gameObject:SetActive(true)
				self._tagFloat:SetState(0)

				self._tagFloatNum.text = subRank
			elseif subRank < 0 then
				self._tagFloat.gameObject:SetActive(true)
				self._tagFloat:SetState(1)

				self._tagFloatNum.text = subRank
			else
				self._tagFloat.gameObject:SetActive(false)

				self._tagFloatNum.text = "-"
			end
		else
			self._tagFloat:SetState(0)

			self._tagFloatNum.text = "新上榜"
		end
	else
		self._tagFloat.gameObject:SetActive(false)
		self._tagFloatNum.gameObject:SetActive(false)
	end

	if self._imgLeft then
		self._imgLeft:SetState(rank % 2 == 0 and 1 or 0)
	end

	if self._imgRight then
		self._imgRight:SetState(rank % 2 == 0 and 1 or 0)
	end

	goutil.setActive(self._fightPower, checknumber(mo.zhanDouLi) > 0)

	if checknumber(mo.zhanDouLi) > 0 then
		self._txtFightPower.text = tostring(checknumber(mo.zhanDouLi))
	end

	if checknumber(mo.passTime) > 0 then
		local time = GameUtil.time2date(checknumber(mo.passTime / 1000))

		self._txtPassTime.text = string.format("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
	end

	goutil.setActive(self._passTime, rankType == GameEnum.RankType.FlyNuo and checknumber(mo.value) > 0 or checknumber(mo.passTime) > 0)

	if rankType == GameEnum.RankType.Mirror_Rank then
		goutil.setActive(self._passTime, true)

		local timer = mo.time
		local time = GameUtil.time2date(checknumber(timer / 1000))

		self._txtPassTime.text = string.format("%d月%d日 %02d:%02d:%02d", time.month, time.day, time.hour, time.min, time.sec)
	end

	if rankType == GameEnum.RankType.FlyNuo and checknumber(mo.value) > 0 then
		self._txtPassTime.text = tostring(checknumber(mo.value))
	end

	goutil.setActive(self._defPower, mo.everMaxZdl ~= nil)

	self._txtDefPower.text = tostring(checknumber(mo.everMaxZdl))

	uGuiUtil.setGoGrayState(self._btnPlay.btn.gameObject, mo.hideResult)
	goutil.setActive(self._maxPower, rankType ~= GameEnum.RankType.FlyNuo and checknumber(mo.value) > 0)

	if checknumber(mo.value) > 0 then
		self._txtMaxPower.text = tostring(checknumber(mo.value))
	end

	goutil.setActive(self._score, checknumber(mo.score) > 0)

	if rankType == GameEnum.RankType.RankMatchClass or rankType == GameEnum.RankType.RankMatchLimit then
		Framework.TransformUtil.SetAnchoredPos(self._score.transform, 928, -58.3)
	else
		Framework.TransformUtil.SetAnchoredPos(self._score.transform, 787, -58.3)
	end

	if checknumber(mo.score) > 0 then
		self._txtScore.text = tostring(checknumber(mo.score))
	elseif (rankType == GameEnum.RankType.RankMatchClass or rankType == GameEnum.RankType.RankMatchLimit) and (selectedLeaf == 1 or selectedLeaf == 2) then
		goutil.setActive(self._score, true)

		self._txtScore.text = "0"
	end

	goutil.setActive(self._xiaonuobian, checknumber(mo.totalMoney) > 0)

	if checknumber(mo.totalMoney) > 0 then
		self._txtTotalMoney.text = StringUtil.numberToString(checknumber(mo.totalMoney))
	end

	goutil.setActive(self._txtProgress.gameObject, mo.progressId ~= nil)

	if mo.progressId ~= nil then
		self._txtProgress.text = mo.progressId .. "关"
	end

	self._btnPlay.gameObject:SetActive(checknumber(mo.zhanDouLi) > 0)
	self._btnDef.gameObject:SetActive(mo.isShowDefBtn)
	GameUtil.SetActive(self._btnIcon, true)

	if self._btnIcon ~= nil then
		self._btnIcon:RemoveClickListener()
		self._btnIcon:AddClickListener(function()
			if mo and mo.headInfo then
				self:_onClickIcon(checknumber(mo.headInfo.userId))
			end
		end)
	end

	self._playSupportBtn = false
	self._supportUserId = nil

	removetimer(self._onFinishSupport, self)

	self._btnSupportTween.enabled = false

	if rankType == GameEnum.RankType.SendFlower_RANK then
		goutil.setActive(self._countFlower, true)

		self._txtCountFlower.text = mo.rankValue

		MaterialMgr.resetAll(self._itemPrize)

		if selectedLeaf == 3 then
			if not SendFlowerConfig.RANKTYPE_CHARM then
				local key = SendFlowerConfig.RANKTYPE_SEND
				local prize = SendFlowerConfig.instance:getFlowerPrize(key, mo.rank)

				if selectedLeaf == 1 or selectedLeaf == 2 then
					MaterialMgr.resetAll(self._itemPrize)
					goutil.setActive(self._itemPrize, false)

					self._txtFamily.text = GameUtil.formatTimeStamp("%Y.%m.%d %H:%M:%S", mo.time / 1000)
				else
					self._txtFamily.text = ""

					if not GameUtil.isEmptyString(prize) then
						goutil.setActive(self._itemPrize, true)
						MaterialMgr.setCellByCfg(prize, self._itemPrize)
					end
				end

				goutil.setActive(self._btnSupport.btn.gameObject, false)
				Framework.TransformUtil.SetAnchoredPos(self._itemPrize.gameObject.transform, 900, -60)
				Framework.TransformUtil.SetAnchoredPos(self._txtFamily.gameObject.transform, 900, -60)
			end
		end
	else
		MaterialMgr.resetAll(self._itemPrize)
		goutil.setActive(self._itemPrize, false)
		goutil.setActive(self._countFlower, false)
		self._btnSupport:RemoveClickListener()
		goutil.setActive(self._btnSupport.btn.gameObject, false)
	end

	self:_GloryTowerRank(selectedLeaf)
end

function RankItem:_onClickSupport(headInfo)
	if not headInfo then
		return
	end

	if not SendFlowerModel.instance:getIsAbleToSupport() then
		TipsFacade.instance:openCommonTips("支持次数已用尽，明日再来吧")

		return
	end

	if headInfo.userId == RoleModel.instance:getUserId() then
		TipsFacade.instance:openCommonTips("不要贪心 多支持下别人吧~")

		return
	end

	TipsFacade.instance:openCommonTips(langPara("增加了%s，%s点魅力值", headInfo.userName, SendFlowerConfig.instance:getCommonParamByKey("SUPPORT_ADD_VALUE")))

	if self._playSupportBtn then
		return
	end

	self._playSupportBtn = true
	self._supportUserId = headInfo.userId
	self._btnSupportTween.enabled = true

	removetimer(self._onFinishSupport, self)
	settimer(1, self._onFinishSupport, self, false)
end

function RankItem:_onFinishSupport()
	self._playSupportBtn = false
	self._btnSupportTween.enabled = false

	Framework.TransformUtil.SetAnchoredPos(self._btnSupport.transform, 1006, -60)

	if self._supportUserId then
		SendFlowerController.instance:tryToSupport(self._supportUserId)

		self._supportUserId = nil
	end
end

function RankItem:_onClickIcon(userId)
	print("click Icon = " .. userId)
	FriendController.instance:showInfoView(userId, self._imgIcon)
end

function RankItem:_onClickPlay()
	if not self._mo or self._mo.hideResult then
		FloatWordMgr.instance:show("该玩家隐藏了本场战斗录像")

		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.RankPlayRecord, self._mo.rank)
end

function RankItem:_onClickDef()
	if not self._mo or not self._mo.headInfo then
		return
	end

	UIStateManager.instance:open(ViewName.ArenaDefFmtView, self._mo.headInfo.userId, self._mo.headInfo.userName, self._mo.everMaxZdl)
end

function RankItem:_onClickFamilyIcon(familyName, familyId, areaName)
	if RoleModel.instance:getAreaName() == areaName then
		FamilyController.instance:sendSearchFamilyReq(familyName, familyId, true, true)
	else
		printInfo("test RankItem:_onClickFamilyIcon", familyName, familyId, areaName, RoleModel.instance:getAreaName())
	end
end

function RankItem:_GloryTowerRank(selectedLeaf)
	if self._rankType == GameEnum.RankType.GloryTowerRank then
		goutil.setActive(self._passTime, true)

		self._txtPassTime.text = GameUtil.formatTimeStamp("%m月%d日 %H:%M:%S", self._mo.time / 1000)
		self._txtFamily.text = self._mo.value

		goutil.setActive(self._maxPower, false)

		self._rewardList = self._rewardList or ScrollerList.create(self._rewardTab, self._rewardCell, GameUtil.handler(self._updateReward, self), GameUtil.handler(self._clearReward, self))

		local challengeId = HonourTowerController.instance:getChallengeIdByRankTabIdx(selectedLeaf)
		local rewardCfg = HonourTowerConfig.instance:getRankRewardCfg(challengeId, self._mo.rank)
		local rewardList = string.split(rewardCfg, "#")

		self._rewardList:reloadData(rewardList)
		goutil.setActive(self._reward, true)
		Framework.TransformUtil.SetAnchoredPos(self._passTime.transform, 650, -60)
		Framework.TransformUtil.SetAnchoredPos(self._txtFamily.gameObject.transform, 510, -60)
	end
end

function RankItem:_updateReward(view, cell, data)
	local itemCon = goutil.findChild(cell, "itemCon")

	MaterialMgr.resetAll(itemCon)
	MaterialMgr.setCellByCfg(data, itemCon)
end

function RankItem:_clearReward(cell)
	local itemCon = goutil.findChild(cell, "itemCon")

	MaterialMgr.resetAll(itemCon)
end

function RankItem:_familyTeamPlay(selectedLeaf)
	if self._rankType == GameEnum.RankType.FamilyTeamPlay then
		goutil.setActive(self._txtWin.gameObject, true)
		goutil.setActive(self._txtProgress.gameObject, true)
		goutil.setActive(self._imgPetIcon.gameObject, true)
		goutil.setActive(self._imgIcon.gameObject, false)

		self._txtRank.text = self._mo.rank
		self._txtName.text = self._mo.familyName
		self._txtProgress.text = ""
		self._txtWin.text = self._mo.score
		self._txtFamily.text = ""

		self._imgPetIconChange:SetState(self._mo.iconId)

		self._txtScore.text = ""
		self._txtProgress.fontSize = 24
	else
		self._txtProgress.fontSize = 30
	end
end

return RankItem
