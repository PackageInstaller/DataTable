-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyMembersTipView.lua

module("modules.logic.sp01.odyssey.view.OdysseyMembersTipView", package.seeall)

local OdysseyMembersTipView = class("OdysseyMembersTipView", BaseView)

function OdysseyMembersTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._golevel = gohelper.findChild(self.viewGO, "#go_root/Info/#go_level")
	self._txtLevel = gohelper.findChildText(self.viewGO, "#go_root/Info/#go_level/#txt_Level")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_root/Info/name/#txt_Name")
	self._txtType = gohelper.findChildText(self.viewGO, "#go_root/Info/name/#txt_Type")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "#go_root/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_root/#scroll_desc/Viewport/Content/#txt_desc")
	self._godescEffect = gohelper.findChild(self.viewGO, "#go_root/image_LightBG")
	self._goclue = gohelper.findChild(self.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_clue")
	self._goclueContent = gohelper.findChild(self.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_clue/#go_clueContent")
	self._goclueItem = gohelper.findChild(self.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_clue/#go_clueContent/#go_clueItem")
	self._goitemRoot = gohelper.findChild(self.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_itemRoot")
	self._goitemContent = gohelper.findChild(self.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_itemRoot/#go_itemContent")
	self._goitem = gohelper.findChild(self.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_itemRoot/#go_itemContent/#go_item")
	self._gorewardRoot = gohelper.findChild(self.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_rewardRoot")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_rewardRoot/#go_rewardContent")
	self._goreward = gohelper.findChild(self.viewGO, "#go_root/#scroll_desc/Viewport/Content/#go_rewardRoot/#go_rewardContent/#go_reward")
	self._goExposed = gohelper.findChild(self.viewGO, "#go_root/#go_Exposed")
	self._btncanExpose = gohelper.findChildClick(self.viewGO, "#go_root/#go_Exposed/#btn_canExpose")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "#go_root/#go_Exposed/#btn_canExpose/#image_progress")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_root/#go_Exposed/#btn_canExpose/#go_reddot")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "#go_root/#go_Exposed/#btn_goto")
	self._godead = gohelper.findChild(self.viewGO, "#go_root/#go_dead")
	self._gounExposed = gohelper.findChild(self.viewGO, "#go_root/#go_unExposed")
	self._txtunExposed = gohelper.findChildText(self.viewGO, "#go_root/#go_unExposed/#txt_unExposed")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyMembersTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btncanExpose:AddClickDownListener(self.canExposeOnClickDown, self)
	self._btncanExpose:AddClickUpListener(self.canExposeOnClickUp, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.RefreshReligionMembers, self.refreshUI, self)
	self.addEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowExposeEffect, self.showExposeEffect, self)
end

function OdysseyMembersTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btngoto:RemoveClickListener()
	self._btncanExpose:RemoveClickDownListener()
	self._btncanExpose:RemoveClickUpListener()
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.RefreshReligionMembers, self.refreshUI, self)
	self.removeEventCb(self, OdysseyDungeonController.instance, OdysseyEvent.ShowExposeEffect, self.showExposeEffect, self)
end

function OdysseyMembersTipView:_btncloseOnClick()
	self:closeThis()
end

function OdysseyMembersTipView:_btngotoOnClick()
	OdysseyDungeonController.instance:jumpToMapElement(self.fightElementCo.id)
	self:closeThis()
	ViewMgr.instance:closeView(ViewName.OdysseyMembersView)
end

function OdysseyMembersTipView:canExposeOnClickDown()
	if self.religionMo then
		return
	end

	self:cleanProgressTween()

	self.progressTweenId = ZProj.TweenHelper.DOFillAmount(self._imageprogress, 1, (1 - self._imageprogress.fillAmount) * 2, self.onExposeProgressFull, self)

	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_press)
end

function OdysseyMembersTipView:canExposeOnClickUp()
	self:cleanProgressTween()

	if self._imageprogress.fillAmount >= 1 or self.religionMo then
		return
	end

	self.progressTweenId = ZProj.TweenHelper.DOFillAmount(self._imageprogress, 0, self._imageprogress.fillAmount * 2)
end

function OdysseyMembersTipView:onExposeProgressFull()
	OdysseyRpc.instance:sendOdysseyFightReligionDiscloseRequest(self.religionId)
end

function OdysseyMembersTipView:_editableInitView()
	self.clueItemMap = self:getUserDataTb_()
	self.rewardItemMap = self:getUserDataTb_()
	self._imageprogress.fillAmount = 0

	gohelper.setActive(self._godescEffect, false)
end

function OdysseyMembersTipView:onUpdateParam()
	return
end

function OdysseyMembersTipView:onOpen()
	self.religionCo = self.viewParam.config
	self.religionId = self.religionCo.id
	self.curMemberItemPos = self.viewParam.pos

	self:setViewPos()
	self:refreshUI()
	OdysseyMembersModel.instance:setHasClickReglionId(self.religionId)
end

OdysseyMembersTipView.TipHalfWidth = 434

function OdysseyMembersTipView:setViewPos()
	local itemScreenPosVector = recthelper.uiPosToScreenPos(self.curMemberItemPos.transform)
	local isClickRight = GameUtil.checkClickPositionInRight(itemScreenPosVector)
	local posX, posY = recthelper.screenPosToAnchorPos2(itemScreenPosVector, self.viewGO.transform)

	if isClickRight then
		if not (posX - OdysseyMembersTipView.TipHalfWidth) then
			local tipPosX = posX + OdysseyMembersTipView.TipHalfWidth

			recthelper.setAnchorX(self._goroot.transform, tipPosX)
		end
	end
end

function OdysseyMembersTipView:refreshUI()
	self.religionMo = OdysseyModel.instance:getReligionInfoData(self.religionId)

	gohelper.setActive(self._golevel, self.religionMo)
	gohelper.setActive(self._txtdesc.gameObject, self.religionMo)

	self.fightElementCo = OdysseyConfig.instance:getElementFightConfig(self.religionCo.elementId)

	if self.fightElementCo then
		if not self.fightElementCo.enemyLevel then
			local enemyLevel = 1
			local curHeroLevel = OdysseyModel.instance:getHeroCurLevelAndExp()

			self._txtLevel.text = curHeroLevel < enemyLevel and string.format("<#E76969>%s</color>", enemyLevel) or enemyLevel

			if self.religionMo then
				self._txtName.text = self.religionCo.name or self.religionCo.notExposeName
			end

			self._txtType.text = self.religionCo.type
			self._txtdesc.text = self.religionCo.desc
			self.canExpose = OdysseyMembersModel.instance:checkReligionMemberCanExpose(self.religionId)

			gohelper.setActive(self._gounExposed, not self.canExpose)

			self._txtunExposed.text = self.religionCo.tips

			gohelper.setActive(self._godead, self.religionMo and self.religionMo.status == OdysseyEnum.MemberStatus.Dead)
			gohelper.setActive(self._goExposed, self.canExpose)
			gohelper.setActive(self._btncanExpose.gameObject, self.canExpose and not self.religionMo)
			gohelper.setActive(self._goreddot, self.canExpose and not self.religionMo)
			gohelper.setActive(self._btngoto.gameObject, self.religionMo and self.religionMo.status == OdysseyEnum.MemberStatus.Expose)
			gohelper.setActive(self._goclue, not self.religionMo)

			local clueList = string.splitToNumber(self.religionCo.clueList, "#")

			self.newUnlockClueIdList = OdysseyMembersModel.instance:getNewClueIdList(self.religionId)

			gohelper.CreateObjList(self, self.onClueShow, clueList, self._goclueContent, self._goclueItem)

			local clueItemList = self:getClueUnlockItem(clueList)

			gohelper.CreateObjList(self, self.onClueItemShow, clueItemList, self._goitemContent, self._goitem)
			gohelper.setActive(self._goitemRoot, #clueItemList > 0)

			local rewardStr = self.fightElementCo.reward

			gohelper.setActive(self._gorewardRoot, not string.nilorempty(rewardStr))

			if not string.nilorempty(rewardStr) then
				local rewardList = GameUtil.splitString2(rewardStr)

				gohelper.CreateObjList(self, self.onRewardItemShow, rewardList, self._gorewardContent, self._goreward)
			end
		end
	end
end

function OdysseyMembersTipView:onClueShow(obj, data, index)
	local txtClue = obj:GetComponent(gohelper.Type_TextMesh)
	local goUnknown = gohelper.findChild(obj, "go_unknown")
	local goKnowned = gohelper.findChild(obj, "go_knowned")
	local goLightEffect = gohelper.findChild(obj, "image_LightBG")
	local clueCo = OdysseyConfig.instance:getReligionClueConfig(data)
	local unlockConditionStr = clueCo.unlockCondition
	local canUnlock = OdysseyDungeonModel.instance:checkConditionCanUnlock(unlockConditionStr)

	txtClue.text = canUnlock and string.format("<#B69B6F>%s</color>", clueCo.clue) or luaLang("odyssey_religion_notexpose_clue")

	gohelper.setActive(goUnknown, not canUnlock)
	gohelper.setActive(goKnowned, canUnlock)
	gohelper.setActive(goLightEffect, false)

	local hasClick = OdysseyMembersModel.instance:getHasClickReglionId(self.religionId)
	local canShowLightEffect = tabletool.indexOf(self.newUnlockClueIdList, data)

	gohelper.setActive(goLightEffect, canShowLightEffect and not hasClick)
end

function OdysseyMembersTipView:onClueItemShow(obj, data, index)
	local itemPos = obj
	local clueItem = self.clueItemMap[data.clueId]

	if not clueItem then
		clueItem = {
			itemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], itemPos)
		}
		clueItem.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(clueItem.itemGO, OdysseyItemIcon)
		self.clueItemMap[data.clueId] = clueItem
	end

	clueItem.itemIcon:initRewardItemInfo(data.itemType, data.itemId, data.itemCount)
end

function OdysseyMembersTipView:getClueUnlockItem(clueList)
	local clueItemList = {}

	for _, clueId in ipairs(clueList) do
		local clueCo = OdysseyConfig.instance:getReligionClueConfig(clueId)
		local conditionStr = clueCo.unlockCondition

		if not string.nilorempty(conditionStr) then
			local unlockConditionList = GameUtil.splitString2(conditionStr)

			for _, conditionData in ipairs(unlockConditionList) do
				if conditionData[1] == OdysseyEnum.ConditionType.Item and OdysseyItemModel.instance:getItemCount(tonumber(conditionData[2])) > 0 then
					table.insert(clueItemList, {
						clueId = clueId,
						itemType = conditionData[1],
						itemId = tonumber(conditionData[2]),
						itemCount = tonumber(conditionData[3])
					})
				end
			end
		end
	end

	return clueItemList
end

function OdysseyMembersTipView:onRewardItemShow(obj, data, index)
	local itemType = data[1]
	local itemId = tonumber(data[2])
	local itemCount = tonumber(data[3])
	local itemPos = gohelper.findChild(obj, "go_pos")
	local goGet = gohelper.findChild(obj, "go_get")
	local rewardItem = self.rewardItemMap[index]

	if not rewardItem then
		rewardItem = {
			itemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], itemPos)
		}
		rewardItem.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(rewardItem.itemGO, OdysseyItemIcon)
		self.rewardItemMap[index] = rewardItem
	end

	rewardItem.itemIcon:initRewardItemInfo(itemType, itemId, itemCount)
	gohelper.setActive(goGet, self.religionMo and self.religionMo.status == OdysseyEnum.MemberStatus.Dead)
end

function OdysseyMembersTipView:showExposeEffect()
	gohelper.setActive(self._godescEffect, false)
	gohelper.setActive(self._godescEffect, true)
end

function OdysseyMembersTipView:cleanProgressTween()
	if self.progressTweenId then
		ZProj.TweenHelper.KillById(self.progressTweenId)

		self.progressTweenId = nil
	end
end

function OdysseyMembersTipView:onClose()
	self:cleanProgressTween()
end

function OdysseyMembersTipView:onDestroyView()
	return
end

return OdysseyMembersTipView
