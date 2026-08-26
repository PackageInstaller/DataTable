-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessLevelItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessLevelItem", package.seeall)

local AutoChessLevelItem = class("AutoChessLevelItem", LuaCompBase)

AutoChessLevelItem.UnlockPrefsKey = "AutoChessLevelItemEpisodeUnlock"
AutoChessLevelItem.FinishPrefsKey = "AutoChessLevelItemEpisodeFinish"

function AutoChessLevelItem:ctor(view)
	self._handleView = view
end

function AutoChessLevelItem:init(go)
	self.go = go
	self._btnClick = gohelper.findChildButtonWithAudio(go, "#btn_Click")
	self._goLock = gohelper.findChild(go, "#go_Lock")
	self._txtNameL = gohelper.findChildText(go, "#go_Lock/#txt_NameL")
	self._imageNameL = gohelper.findChildImage(go, "#go_Lock/Name/#image_NameL")
	self._btnRewardL = gohelper.findChildButtonWithAudio(go, "#go_Lock/#btn_RewardL")
	self._goUnlock = gohelper.findChild(go, "#go_Unlock")
	self._txtNameU = gohelper.findChildText(go, "#go_Unlock/#txt_NameU")
	self._imageNameU = gohelper.findChildImage(go, "#go_Unlock/Name/#image_NameU")
	self._goHasGet = gohelper.findChild(go, "#go_Unlock/#go_HasGet")
	self._btnRewardU = gohelper.findChildButtonWithAudio(go, "#go_Unlock/#btn_RewardU")
	self._goRound = gohelper.findChild(go, "#go_Unlock/#go_Round")
	self._txtRound = gohelper.findChildText(go, "#go_Unlock/#go_Round/#txt_Round")
	self._btnGiveUp = gohelper.findChildButtonWithAudio(go, "#go_Unlock/#go_Round/#btn_GiveUp")
	self._goCurrent = gohelper.findChild(go, "#go_Unlock/#go_Current")
	self._goNew = gohelper.findChild(go, "#go_New")
	self._goRewardTips = gohelper.findChild(go, "#go_RewardTips")
	self._btnCloseReward = gohelper.findChildButtonWithAudio(go, "#go_RewardTips/#btn_CloseReward")
	self._goRewardDesc = gohelper.findChild(go, "#go_RewardTips/#go_RewardDesc")
	self._goTipsBg = gohelper.findChild(go, "#go_RewardTips/#go_Tipsbg")
	self._txtUnlockTips = gohelper.findChildText(go, "#go_RewardTips/#go_Tipsbg/#txt_UnlockTips")
	self._goSpecialDesc = gohelper.findChild(go, "#go_RewardTips/#go_SpecialDesc")
	self._goRewardItem = gohelper.findChild(go, "#go_RewardTips/#go_RewardItem")
	self._btnRewardTips = gohelper.findButtonWithAudio(self._goRewardTips)
	self.moduleId = AutoChessEnum.ModuleId.PVE
	self.anim = go:GetComponent(gohelper.Type_Animator)
end

function AutoChessLevelItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnRewardU:AddClickListener(self._btnRewardOnClick, self)
	self._btnRewardL:AddClickListener(self._btnRewardOnClick, self)
	self._btnGiveUp:AddClickListener(self._btnGiveUpOnClick, self)
	self._btnCloseReward:AddClickListener(self._btnCloseRewardOnClick, self)
	self.addEventCb(self, Activity182Controller.instance, Activity182Event.UpdateInfo, self.refreshUI, self)
end

function AutoChessLevelItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
	self._btnRewardU:RemoveClickListener()
	self._btnRewardL:RemoveClickListener()
	self._btnGiveUp:RemoveClickListener()
	self._btnCloseReward:RemoveClickListener()
end

function AutoChessLevelItem:_btnClickOnClick()
	self._handleView:onClickItem(self.co.id)
end

function AutoChessLevelItem:_btnRewardOnClick()
	self._handleView:onOpenItemReward(self.co.id)
end

function AutoChessLevelItem:_btnGiveUpOnClick()
	self._handleView:onGiveUpGame(self.co.id)
end

function AutoChessLevelItem:_btnCloseRewardOnClick()
	self._handleView:onCloseItemReward(self.co.id)
end

function AutoChessLevelItem:setData(co)
	self.actId = Activity182Model.instance:getCurActId()
	self.co = co

	if co then
		self:refreshSpecialUnlockTips()
		self:refreshUI()

		local firstBouns = GameUtil.splitString2(self.co.firstBounds, true)

		for _, boun in ipairs(firstBouns) do
			local go = gohelper.cloneInPlace(self._goRewardItem)
			local item = IconMgr.instance:getCommonItemIcon(go)

			item:setMOValue(boun[1], boun[2], boun[3])

			local goBg = item:getCountBg()

			transformhelper.setLocalScale(goBg.transform, 1, 1.7, 1)
			item:setCountFontSize(45)
		end

		gohelper.setActive(self._goRewardItem, false)
		gohelper.setActive(self._btnRewardU, not self.isPass)
		gohelper.setActive(self._goHasGet, self.isPass)
	end
end

function AutoChessLevelItem:refreshUI()
	self.actMo = Activity182Model.instance:getActMo()

	self:refreshLock()
	self:refreshSelect()
	self:refreshFinish()
	self:refreshBtnSate()

	if self.unlock and self.isSelect then
		self.anim:Play("challenge", 0, 0)
	end
end

function AutoChessLevelItem:refreshSelect()
	local gameMo = self.actMo:getGameMo(self.actId, self.moduleId)

	self.isSelect = gameMo.episodeId == self.co.id

	if self.isSelect then
		self._txtRound.text = string.format("%d/%d", gameMo.currRound, self.co.maxRound)
	end

	gohelper.setActive(self._goCurrent, self.isSelect)
	gohelper.setActive(self._goRound, self.isSelect)
end

function AutoChessLevelItem:refreshLock()
	self.unlock = self.actMo:isEpisodeUnlock(self.co.id)

	gohelper.setActive(self._goLock, not self.unlock)
	gohelper.setActive(self._goUnlock, self.unlock)
	ZProj.UGUIHelper.SetGrayscale(self.goArrow, not self.unlock)

	if self.unlock then
		self._txtNameU.text = self.co.name

		UISpriteSetMgr.instance:setAutoChessSprite(self._imageNameU, self.co.image)

		local prefsKey = AutoChessLevelItem.UnlockPrefsKey .. self.co.id
		local value = AutoChessHelper.getPlayerPrefs(prefsKey, 0)

		if value == 0 then
			gohelper.setActive(self._goLock, true)
			self.anim:Play("unlock", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
			AutoChessHelper.setPlayerPrefs(prefsKey, 1)
		end
	else
		self._txtNameL.text = self.co.name

		UISpriteSetMgr.instance:setAutoChessSprite(self._imageNameL, self.co.image)
	end
end

function AutoChessLevelItem:refreshFinish()
	self.isPass = self.actMo:isEpisodePass(self.co.id)

	if self.isPass then
		gohelper.setActive(self._goHasGet, true)

		local prefsKey = AutoChessLevelItem.FinishPrefsKey .. self.co.id
		local value = AutoChessHelper.getPlayerPrefs(prefsKey, 0)

		if value == 0 then
			self.anim:Play("finish", 0, 0)
			AutoChessHelper.setPlayerPrefs(prefsKey, 1)
		end
	end
end

function AutoChessLevelItem:refreshSpecialUnlockTips()
	local pvpEpisodeCo = AutoChessConfig.instance:getPvpEpisodeCo(self.actId)
	local unlockRefresh = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderRefresh].value)
	local unlockSlot = tonumber(lua_auto_chess_const.configDict[AutoChessEnum.ConstKey.UnlockLeaderSlot].value)
	local unlockPVP = pvpEpisodeCo.preEpisode

	if self.co.id == unlockRefresh then
		self._txtUnlockTips.text = luaLang("autochess_levelview_unlocktips3")
	elseif self.co.id == unlockSlot then
		self._txtUnlockTips.text = luaLang("autochess_levelview_unlocktips2")
	elseif self.co.id == unlockPVP then
		self._txtUnlockTips.text = luaLang("autochess_levelview_unlocktips1")
	else
		gohelper.setActive(self._goRewardDesc, true)
		gohelper.setActive(self._goTipsBg, false)
		gohelper.setActive(self._goSpecialDesc, false)
	end
end

function AutoChessLevelItem:refreshBtnSate()
	gohelper.setActive(self._btnGiveUp, GuideModel.instance:isGuideFinish(25406))
end

function AutoChessLevelItem:openReward()
	gohelper.setActive(self._goRewardTips, true)
end

function AutoChessLevelItem:closeReward()
	gohelper.setActive(self._goRewardTips, false)
end

function AutoChessLevelItem:enterLevel()
	if self.unlock then
		AutoChessController.instance:startGame(self.actId, self.moduleId, self.co)
	else
		GameFacade.showToast(ToastEnum.AutoChessEpisodeLock)
	end
end

return AutoChessLevelItem
