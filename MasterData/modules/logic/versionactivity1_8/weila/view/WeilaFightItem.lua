-- chunkname: @modules/logic/versionactivity1_8/weila/view/WeilaFightItem.lua

module("modules.logic.versionactivity1_8.weila.view.WeilaFightItem", package.seeall)

local WeilaFightItem = class("WeilaFightItem", LuaCompBase)

function WeilaFightItem:init(go)
	self.viewGO = go
	self._goNormal = gohelper.findChild(self.viewGO, "#go_UnSelected")
	self._btnclick = gohelper.findChildButton(self.viewGO, "#go_UnSelected/#btn_click")
	self._txtstageNumN = gohelper.findChildText(self.viewGO, "#go_UnSelected/info/#txt_stageNum")
	self._gostar1N = gohelper.findChild(self.viewGO, "#go_UnSelected/info/#go_star/star1/#go_star1")
	self._gostar2N = gohelper.findChild(self.viewGO, "#go_UnSelected/info/#go_star/star2/#go_star2")
	self._goLock = gohelper.findChild(self.viewGO, "#go_UnSelected/#go_Lock")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._txtstagenameS = gohelper.findChildText(self.viewGO, "#go_Selected/info/#txt_stagename")
	self._txtstageNumS = gohelper.findChildText(self.viewGO, "#go_Selected/info/#txt_stagename/#txt_stageNum")
	self._gostar1S = gohelper.findChild(self.viewGO, "#go_Selected/info/#txt_stagename/star1/#go_star1")
	self._gostar2S = gohelper.findChild(self.viewGO, "#go_Selected/info/#txt_stagename/star2/#go_star2")
	self._btnNormal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Selected/#btn_Normal")
	self._btnHard = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Selected/#btn_Hard")
	self._goHardLock = gohelper.findChild(self.viewGO, "#go_Selected/#btn_Hard/#go_Lock")
	self._selectAnim = self._goSelected:GetComponent(gohelper.Type_Animator)
	self._animLock = self._goLock:GetComponent(gohelper.Type_Animator)
	self._animStar1S = self._gostar1S:GetComponent(gohelper.Type_Animation)
	self._animStar2S = self._gostar2S:GetComponent(gohelper.Type_Animation)
	self._animHardLock = self._goHardLock:GetComponent(gohelper.Type_Animator)
	self._gostar1Nno = gohelper.findChild(self.viewGO, "#go_UnSelected/info/#go_star/star1/no")
	self._gostar2Nno = gohelper.findChild(self.viewGO, "#go_UnSelected/info/#go_star/star2/no")
	self._gostar1Sno = gohelper.findChild(self.viewGO, "#go_Selected/info/#txt_stagename/star1/no")
	self._gostar2Sno = gohelper.findChild(self.viewGO, "#go_Selected/info/#txt_stagename/star2/no")
end

function WeilaFightItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
	self._btnNormal:AddClickListener(self._btnOnNormal, self)
	self._btnHard:AddClickListener(self._btnOnHard, self)
end

function WeilaFightItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self._btnNormal:RemoveClickListener()
	self._btnHard:RemoveClickListener()
end

function WeilaFightItem:onDestroy()
	return
end

function WeilaFightItem:_btnOnClick()
	if not self.unlock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	ActWeilaController.instance:dispatchEvent(ActWeilaEvent.FightItemClick, self.index)
end

function WeilaFightItem:_btnOnNormal()
	self:enterFight(self.config)
end

function WeilaFightItem:_btnOnHard()
	local unLock = ActWeilaModel.instance:isLevelUnlock(self.hardConfig.id)

	if not unLock then
		GameFacade.showToast(ToastEnum.DungeonIsLockNormal)

		return
	end

	self:enterFight(self.hardConfig)
end

function WeilaFightItem:setParam(co, _index)
	self.config = co
	self.id = co.id
	self.hardConfig = DungeonConfig.instance:getEpisodeCO(self.id + 1)
	self.index = _index

	self:_refreshUI()
end

function WeilaFightItem:_refreshUI()
	self:refreshStatus()

	self._txtstageNumN.text = "0" .. self.index
	self._txtstageNumS.text = "0" .. self.index
	self._txtstagenameS.text = self.config.name
end

function WeilaFightItem:refreshStatus()
	self.unlock = ActWeilaModel.instance:isLevelUnlock(self.id)

	local hardUnlock = ActWeilaModel.instance:isLevelUnlock(self.hardConfig.id)

	gohelper.setActive(self._goLock, not self.unlock)
	gohelper.setActive(self._goHardLock, not hardUnlock)
	self:refreshStar()
end

function WeilaFightItem:refreshStar()
	local passNormal = ActWeilaModel.instance:isLevelPass(self.id)
	local passHard = ActWeilaModel.instance:isLevelPass(self.hardConfig.id)

	gohelper.setActive(self._gostar1N, passNormal)
	gohelper.setActive(self._gostar1S, passNormal)
	gohelper.setActive(self._gostar2N, passHard)
	gohelper.setActive(self._gostar2S, passHard)
	gohelper.setActive(self._gostar1Nno, not passNormal)
	gohelper.setActive(self._gostar1Sno, not passNormal)
	gohelper.setActive(self._gostar2Nno, not passHard)
	gohelper.setActive(self._gostar2Sno, not passHard)
end

function WeilaFightItem:refreshSelect(_index)
	_index = _index or self.index

	gohelper.setActive(self._goNormal, self.index ~= _index)
	gohelper.setActive(self._goSelected, self.index == _index)

	if _index and self._goSelected.activeInHierarchy then
		self._selectAnim:Play("open")
	end
end

function WeilaFightItem:isUnlock()
	return self.unlock
end

function WeilaFightItem:enterFight(episodeConfig)
	local chapterId = episodeConfig.chapterId
	local episodeId = episodeConfig.id
	local battleId = episodeConfig.battleId

	if chapterId and episodeId and battleId > 0 then
		ActWeilaModel.instance:setEnterFightIndex(self.index)
		DungeonFightController.instance:enterFightByBattleId(chapterId, episodeId, battleId)
	end
end

function WeilaFightItem:playUnlock()
	self._animLock:Play("unlock")
end

function WeilaFightItem:playHardUnlock()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_level_difficulty)
	self._animHardLock:Play("unlock")
end

function WeilaFightItem:playStarAnim(firstStar)
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)

	if firstStar then
		self._animStar1S:Play()
	else
		self._animStar2S:Play()
	end
end

return WeilaFightItem
