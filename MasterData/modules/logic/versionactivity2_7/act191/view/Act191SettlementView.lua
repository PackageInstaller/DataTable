-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191SettlementView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191SettlementView", package.seeall)

local Act191SettlementView = class("Act191SettlementView", BaseView)

function Act191SettlementView:onInitView()
	self._imageLevel = gohelper.findChildImage(self.viewGO, "Left/herogroupcontain/mainTitle/#image_Level")
	self._scrollFetter = gohelper.findChildScrollRect(self.viewGO, "Left/herogroupcontain/#scroll_Fetter")
	self._goFetterContent = gohelper.findChild(self.viewGO, "Left/herogroupcontain/#scroll_Fetter/Viewport/#go_FetterContent")
	self._goNodeList = gohelper.findChild(self.viewGO, "Right/node/#go_NodeList")
	self._goBadgeItem = gohelper.findChild(self.viewGO, "Right/badge/layout/#go_BadgeItem")
	self._txtScore = gohelper.findChildText(self.viewGO, "Right/score/#txt_Score")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191SettlementView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Act191SettlementView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Act191SettlementView:_btnCloseOnClick()
	self:closeThis()
end

function Act191SettlementView:_editableInitView()
	self.heroContainer = gohelper.findChild(self.viewGO, "Left/herogroupcontain/heroContainer")

	self:initHeroInfoItem()

	self.animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	self.animEvent:AddEventListener("PlayBadgeAnim", self.playBadgeAnim, self)

	self.actInfo = Activity191Model.instance:getActInfo()
	self.gameInfo = self.actInfo:getGameInfo()
	self.maxTeamSlot = self.gameInfo.mainTeamSize + self.gameInfo.subTeamSize

	self:initHeroAndEquipItem()
	self:initBadge()
end

function Act191SettlementView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)

	self.gameEndInfo = self.actInfo:getGameEndInfo()

	self:refreshLeft()
	self:refreshRight()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_fight_end)
end

function Act191SettlementView:onClose()
	self.actInfo:clearEndInfo()

	local manual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, manual)
end

function Act191SettlementView:onDestroyView()
	self.animEvent:RemoveEventListener("PlayBadgeAnim")
end

function Act191SettlementView:initHeroInfoItem()
	self.heroInfoItemList = {}

	for i = 1, 4 do
		local heroInfoItem = self:getUserDataTb_()
		local go = gohelper.findChild(self.heroContainer, "bg" .. i)

		heroInfoItem.goIndex = gohelper.findChild(go, "Index")
		heroInfoItem.txtName = gohelper.findChildText(go, "Name")
		self.heroInfoItemList[i] = heroInfoItem
	end
end

function Act191SettlementView:initHeroAndEquipItem()
	self.heroPosTrList = self:getUserDataTb_()

	local recordPos = gohelper.findChild(self.viewGO, "Left/herogroupcontain/recordPos")

	for i = 1, self.maxTeamSlot do
		local go = gohelper.findChild(recordPos, "heroPos" .. i)

		if go then
			self.heroPosTrList[i] = go.transform
		else
			logError("缺失Slot节点" .. i)
		end
	end

	local goHeroItem = gohelper.findChild(self.heroContainer, "go_HeroItem")
	local goEquipItem = gohelper.findChild(self.heroContainer, "go_EquipItem")

	self.heroItemList = {}

	for i = 1, self.maxTeamSlot do
		local cloneGo = gohelper.cloneInPlace(goHeroItem, "hero" .. i)
		local heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, Act191HeroGroupItem1)

		heroItem:setIndex(i)

		self.heroItemList[i] = heroItem

		self:_setHeroItemPos(heroItem, i)
	end

	gohelper.setActive(goHeroItem, false)
	gohelper.setActive(goEquipItem, false)
end

function Act191SettlementView:refreshLeft()
	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if gameInfo.rank ~= 0 then
		if not gameInfo.rank then
			local rank = 1
			local rankCfg = Activity191Config.instance:getRankCfg(rank)

			if rankCfg then
				UISpriteSetMgr.instance:setAct174Sprite(self._imageLevel, "act191_level_" .. string.lower(rankCfg.fightLevel))
			end

			local teamInfo = gameInfo:getTeamInfo()

			for i = 1, 4 do
				local info = Activity191Helper.matchKeyInArray(teamInfo.battleHeroInfo, i)
				local heroId

				if info then
					heroId = info.heroId
				end

				self.heroItemList[i]:setData(heroId)

				local infoItem = self.heroInfoItemList[i]

				if heroId and heroId ~= 0 then
					local heroInfo = gameInfo:getHeroInfoInWarehouse(heroId)
					local roleCo = Activity191Config.instance:getRoleCoByNativeId(heroId, heroInfo.star)

					infoItem.txtName.text = roleCo.name

					gohelper.setActive(infoItem.goIndex, false)
					gohelper.setActive(infoItem.txtName, true)
				else
					gohelper.setActive(infoItem.goIndex, true)
					gohelper.setActive(infoItem.txtName, false)
				end

				local subIndex = i + 4
				local subInfo = Activity191Helper.matchKeyInArray(teamInfo.subHeroInfo, i)

				if subInfo then
					if not subInfo.heroId then
						local subHeroId = 0

						self.heroItemList[subIndex]:setData(subHeroId)
					end
				end
			end

			local fetterCntDic = gameInfo:getTeamFetterCntDic()
			local fetterInfoList = Activity191Helper.getActiveFetterInfoList(fetterCntDic)

			for _, info in ipairs(fetterInfoList) do
				local go = self:getResInst(Activity191Enum.PrefabPath.FetterItem, self._goFetterContent)
				local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191FetterItem)

				item:setData(info.config, info.count)
				gohelper.setActive(item.go, true)
			end

			self._scrollFetter.horizontalNormalizedPosition = 0
		end
	end
end

function Act191SettlementView:_setHeroItemPos(heroItem, index, tween, callback, callbackObj)
	local posTr = self.heroPosTrList[index]
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, self.heroContainer.transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(heroItem.go.transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(heroItem.go.transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Act191SettlementView:_setEquipItemPos(equipItem, index, tween, callback, callbackObj)
	local posTr = self.equipPosTrList[index]
	local anchorPos = recthelper.rectToRelativeAnchorPos(posTr.position, self.heroContainer.transform)

	if tween then
		return ZProj.TweenHelper.DOAnchorPos(equipItem.go.transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(equipItem.go.transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Act191SettlementView:refreshRight()
	if self.gameInfo.curStage ~= 0 then
		local nodeGo = self:getResInst(Activity191Enum.PrefabPath.NodeListItem, self._goNodeList)
		local nodeComp = MonoHelper.addNoUpdateLuaComOnceToGo(nodeGo, Act191NodeListItem)

		nodeComp:setClickEnable(false)
	end

	self._txtScore.text = self.gameEndInfo.gainScore
end

function Act191SettlementView:initBadge()
	self.badgeItemList = {}

	local scoreChangeDic = self.actInfo:getBadgeScoreChangeDic()
	local badgeMoList = self.actInfo:getBadgeMoList()

	for _, badgeMo in ipairs(badgeMoList) do
		local badgeItem = self:getUserDataTb_()
		local go = gohelper.cloneInPlace(self._goBadgeItem)

		badgeItem.Icon = gohelper.findChildSingleImage(go, "root/image_icon")

		local txtNum = gohelper.findChildText(go, "root/txt_num")
		local txtScore = gohelper.findChildText(go, "root/txt_score")

		txtNum.text = badgeMo.count

		local change = scoreChangeDic[badgeMo.id]

		if change and change ~= 0 then
			txtScore.text = "+" .. change
		end

		gohelper.setActive(txtScore, change and change ~= 0)

		local state = badgeMo:getState()
		local path = ResUrl.getAct174BadgeIcon(badgeMo.config.icon, state)

		badgeItem.Icon:LoadImage(path)

		badgeItem.anim = go:GetComponent(gohelper.Type_Animator)
		badgeItem.id = badgeMo.id
		self.badgeItemList[#self.badgeItemList + 1] = badgeItem
	end

	gohelper.setActive(self._goBadgeItem, false)
end

function Act191SettlementView:playBadgeAnim()
	local scoreChangeDic = self.actInfo:getBadgeScoreChangeDic()

	for _, badgeItem in ipairs(self.badgeItemList) do
		local change = scoreChangeDic[badgeItem.id]

		if change and change ~= 0 then
			badgeItem.anim:Play("refresh")
		end
	end
end

function Act191SettlementView:clickCollection(id)
	if id and id ~= 0 then
		Activity191Controller.instance:openCollectionTipView({
			itemId = id
		})
	end
end

return Act191SettlementView
