-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174SettlementView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174SettlementView", package.seeall)

local Act174SettlementView = class("Act174SettlementView", BaseView)

function Act174SettlementView:onInitView()
	self._txtWinCnt = gohelper.findChildText(self.viewGO, "Right/fight/#txt_WinCnt")
	self._txtLoseCnt = gohelper.findChildText(self.viewGO, "Right/fight/#txt_LoseCnt")
	self._gobadgeItem = gohelper.findChild(self.viewGO, "Right/badge/layout/#go_badgeItem")
	self._txtScore = gohelper.findChildText(self.viewGO, "Right/score/#txt_Score")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174SettlementView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Act174SettlementView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Act174SettlementView:_btnCloseOnClick()
	self:closeThis()
end

function Act174SettlementView:_editableInitView()
	self.animEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	self.animEvent:AddEventListener("PlayBadgeAnim", self.playBadgeAnim, self)
end

function Act174SettlementView:onUpdateParam()
	return
end

function Act174SettlementView:onOpen()
	self.actInfo = Activity174Model.instance:getActInfo()
	self.gameInfo = self.actInfo:getGameInfo()
	self.gameEndInfo = self.actInfo:getGameEndInfo()

	self:refreshLeft()
	self:refreshRight()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_fight_end)
end

function Act174SettlementView:onClose()
	if self.gameEndInfo and self.gameEndInfo.gainScore ~= 0 then
		local mo = MaterialDataMO.New()

		mo:initValue(2, 2302, self.gameEndInfo.gainScore)
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, {
			mo
		})
	end

	self.actInfo:clearEndInfo()
end

function Act174SettlementView:onDestroyView()
	self.animEvent:RemoveEventListener("PlayBadgeAnim")
end

function Act174SettlementView:refreshLeft()
	local teamMoList = self.actInfo:getGameInfo():getTeamMoList()
	local groupGo = gohelper.findChild(self.viewGO, "Left/Group/playergroup")

	if teamMoList then
		for _, teamMo in ipairs(teamMoList) do
			local group = gohelper.cloneInPlace(groupGo)
			local imageNum = gohelper.findChildImage(group, "numbg/image_Num")

			UISpriteSetMgr.instance:setAct174Sprite(imageNum, "act174_ready_num_0" .. teamMo.index)

			for i = 1, 4 do
				local info = Activity174Helper.MatchKeyInArray(teamMo.battleHeroInfo, i, "index")
				local fightHeroGo = self:getResInst(Activity174Enum.PrefabPath.BattleHero, group)
				local battleHeroItem = MonoHelper.addNoUpdateLuaComOnceToGo(fightHeroGo, Act174BattleHeroItem)

				battleHeroItem:setIndex(i)
				battleHeroItem:setData(info, teamMo.index, false)
			end
		end
	end

	gohelper.setActive(groupGo, false)
end

function Act174SettlementView:refreshRight()
	self._txtLoseCnt.text = self.gameEndInfo.winNum
	self._txtWinCnt.text = self.gameEndInfo.loseNum

	self:initBadge()

	self._txtScore.text = self.gameEndInfo.gainScore
end

function Act174SettlementView:initBadge()
	self.badgeItemList = {}

	local scoreChangeDic = self.actInfo:getBadgeScoreChangeDic()
	local badgeMoList = self.actInfo:getBadgeMoList()

	for _, badgeMo in ipairs(badgeMoList) do
		local badgeItem = self:getUserDataTb_()
		local go = gohelper.cloneInPlace(self._gobadgeItem)

		badgeItem.Icon = gohelper.findChildSingleImage(go, "root/image_icon")

		local txtNum = gohelper.findChildText(go, "root/txt_num")
		local txtScore = gohelper.findChildText(go, "root/txt_score")

		txtNum.text = badgeMo.count

		local change = scoreChangeDic[badgeMo.id]

		if change and change ~= 0 then
			txtScore.text = "+" .. change
		end

		gohelper.setActive(txtScore, change ~= 0)

		local state = badgeMo:getState()
		local path = ResUrl.getAct174BadgeIcon(badgeMo.config.icon, state)

		badgeItem.Icon:LoadImage(path)

		badgeItem.anim = go:GetComponent(gohelper.Type_Animator)
		badgeItem.id = badgeMo.id
		self.badgeItemList[#self.badgeItemList] = badgeItem
	end

	gohelper.setActive(self._gobadgeItem, false)
end

function Act174SettlementView:playBadgeAnim()
	local scoreChangeDic = self.actInfo:getBadgeScoreChangeDic()

	for _, badgeItem in ipairs(self.badgeItemList) do
		local change = scoreChangeDic[badgeItem.id]

		if change and change ~= 0 then
			badgeItem.anim:Play("refresh")
		end
	end
end

return Act174SettlementView
