-- chunkname: @modules/logic/autochess/main/view/game/AutoChessBeginView.lua

module("modules.logic.autochess.main.view.game.AutoChessBeginView", package.seeall)

local AutoChessBeginView = class("AutoChessBeginView", BaseView)

function AutoChessBeginView:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "root/title/#txt_Title")
	self._goBoss = gohelper.findChild(self.viewGO, "root/#go_Boss")
	self._goCardpack = gohelper.findChild(self.viewGO, "root/#go_Cardpack")
	self._scrollCardpack = gohelper.findChildScrollRect(self.viewGO, "root/#go_Cardpack/#scroll_Cardpack")
	self._goLeader = gohelper.findChild(self.viewGO, "root/#go_Leader")
	self._btnCheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Check")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Next")
	self._txtNext = gohelper.findChildText(self.viewGO, "root/#btn_Next/#txt_Next")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessBeginView:addEvents()
	self._btnCheck:AddClickListener(self._btnCheckOnClick, self)
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
end

function AutoChessBeginView:removeEvents()
	self._btnCheck:RemoveClickListener()
	self._btnNext:RemoveClickListener()
end

function AutoChessBeginView:_btnCheckOnClick()
	self.checking = true
	self.lastStep = self.step
	self.step = 1

	self:refreshUI()
end

function AutoChessBeginView:_btnNextOnClick()
	if self.checking then
		self.step = self.lastStep
		self.lastStep = nil
		self.checking = false

		self:refreshUI()

		return
	end

	if self.step == 1 then
		self.step = 2

		self:refreshUI()
		self:checkGuide()
	elseif self.step == 2 then
		if self.cardpackId then
			Activity182Rpc.instance:sendAct182ChooseCardpackRequest(self.actId, self.cardpackId, self.onChooseCardpackReply, self)
		else
			GameFacade.showToast(ToastEnum.V3a2AutoChessBeginViewTips1)
		end
	elseif self.step == 3 then
		self:_btnStartOnClick()
	end
end

function AutoChessBeginView:_editableInitView()
	self.actId = Activity182Model.instance:getCurActId()
	self.moduleId = AutoChessEnum.ModuleId.PVP

	local goMesh = gohelper.findChild(self._goBoss, "Mesh")

	self.meshCompB = MonoHelper.addNoUpdateLuaComOnceToGo(goMesh, AutoChessMeshComp)
	self.txtHpB = gohelper.findChildText(self._goBoss, "Hp/txt_Hp")
	self.txtAttackB = gohelper.findChildText(self._goBoss, "Attack/txt_Attack")
	self.txtNameB = gohelper.findChildText(self._goBoss, "txt_Name")
	self.txtDescB = gohelper.findChildText(self._goBoss, "scroll_des/viewport/content/txt_Desc")
	self.cardpackItemList = {}

	local itemRoot = gohelper.findChild(self._goLeader, "scroll_teamleaderlist/viewport/go_ItemRoot")

	self.leaderItemList = {}

	for i = 1, 3 do
		local go = self:getResInst(AutoChessStrEnum.ResPath.LeaderItem, itemRoot)

		gohelper.setActive(go, false)

		local leaderItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessLeaderItem)

		leaderItem:setClickCallback(self.onClickLeader, self)

		self.leaderItemList[i] = leaderItem
	end

	self.btnFresh = gohelper.findChildButtonWithAudio(self._goLeader, "btn_Fresh")

	self.addClickCb(self, self.btnFresh, self._btnFreshOnClick, self)
end

function AutoChessBeginView:onOpen()
	self.actMo = Activity182Model.instance:getActMo()
	self.gameInfo = self.actMo:getGameMo(self.actId, self.moduleId)
	self.unlockCardpackCfgs = {}

	for id, config in pairs(lua_auto_chess_cardpack.configDict[self.actId]) do
		local unlockLvl = AutoChessConfig.instance:getCardpackUnlockLevel(id)

		if unlockLvl <= self.actMo.warnLevel then
			self.unlockCardpackCfgs[#self.unlockCardpackCfgs + 1] = config
		end
	end

	table.sort(self.unlockCardpackCfgs, function(a, b)
		return a.id < b.id
	end)
	self:checkStep()

	if self.step == 1 then
		AudioMgr.instance:trigger(AudioEnum3_2.AutoChess.play_ui_shengyan_guardian_list)
	end

	self:refreshUI()
end

function AutoChessBeginView:checkStep()
	self.step = #self.gameInfo.masterIdBox ~= 0 and 3 or 1
end

function AutoChessBeginView:refreshUI()
	self._txtTitle.text = luaLang("autochess_beginview_title" .. tostring(self.step))
	self._txtNext.text = self.checking and luaLang("autochess_beginview_btn2") or luaLang("autochess_beginview_btn1")

	gohelper.setActive(self._goBoss, self.step == 1)
	gohelper.setActive(self._btnCheck, self.step ~= 1)
	gohelper.setActive(self._goCardpack, self.step == 2)
	gohelper.setActive(self._goLeader, self.step == 3)

	if self.step == 1 then
		self:refreshBossPart()
	elseif self.step == 2 then
		self:refreshCardpackPart()
	elseif self.step == 3 then
		self:refreshLeaderPart()
	end
end

function AutoChessBeginView:refreshBossPart()
	self:setBtnNextGray(false)

	local bossId = self.gameInfo.bossId
	local config = AutoChessConfig.instance:getChessCfg(bossId)

	if config then
		self.meshCompB:setData(config.image, true)

		self.txtHpB.text = config.hp
		self.txtAttackB.text = config.attack
		self.txtNameB.text = config.name
		self.txtDescB.text = config.skillDesc
	end
end

function AutoChessBeginView:refreshCardpackPart()
	self:setBtnNextGray(not self.cardpackId)

	if next(self.cardpackItemList) then
		return
	end

	local content = gohelper.findChild(self._scrollCardpack.gameObject, "viewport/content")

	for k, config in ipairs(self.unlockCardpackCfgs) do
		local go = self:getResInst(AutoChessStrEnum.ResPath.CardPackItem, content)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessCardpackItem)

		item:setData(config)
		item:setClickCallback(self.onClickCardpackItem, self)
		item:setCheckCallback(self.onCheckCardpackItem, self)

		self.cardpackItemList[k] = item
	end

	self._scrollCardpack.horizontalNormalizedPosition = 0
end

function AutoChessBeginView:onClickCardpackItem(cardpackId)
	if self.cardpackId == cardpackId then
		return
	end

	AudioMgr.instance:trigger(AudioEnum3_2.AutoChess.play_ui_shengyan_card_pack)

	self.cardpackId = cardpackId

	for i = 1, #self.cardpackItemList do
		local item = self.cardpackItemList[i]
		local id = self.unlockCardpackCfgs[i].id

		item:setSelect(id == cardpackId)
	end

	self:setBtnNextGray(not self.cardpackId)

	if not GuideModel.instance:isGuideFinish(32012) then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZTrigger32012, 5)
	end
end

function AutoChessBeginView:onCheckCardpackItem(cardpackId)
	local checkIndex

	for k, config in ipairs(self.unlockCardpackCfgs) do
		if config.id == cardpackId then
			checkIndex = k

			break
		end
	end

	local param = {
		index = checkIndex,
		configs = self.unlockCardpackCfgs
	}

	ViewMgr.instance:openView(ViewName.AutoChessCardpackInfoView, param)
end

function AutoChessBeginView:refreshLeaderPart()
	local isFresh = self.gameInfo.refreshed

	gohelper.setActive(self.btnFresh, not isFresh)

	for i = 1, 3 do
		local leaderItem = self.leaderItemList[i]

		leaderItem:setData(self.gameInfo.masterIdBox[i])
		gohelper.setActive(leaderItem.go, true)
	end

	self:setBtnNextGray(not self.selectLeaderId)
end

function AutoChessBeginView:onClickLeader(id)
	if self.selectLeaderId == id then
		return
	end

	if id then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_level_chosen)

		if not GuideModel.instance:isGuideFinish(32012) then
			AutoChessController.instance:dispatchEvent(AutoChessEvent.ZTrigger32012, 4)
		end
	end

	self.selectLeaderId = id

	for _, item in ipairs(self.leaderItemList) do
		item:setSelect(item.id == self.selectLeaderId)
	end

	self:setBtnNextGray(not self.selectLeaderId)
end

function AutoChessBeginView:_btnStartOnClick()
	if not self.selectLeaderId then
		GameFacade.showToast(ToastEnum.AutoChessSelectLeader)

		return
	end

	local param = {
		actId = self.actId,
		moduleId = self.moduleId,
		episodeId = AutoChessConfig.instance:getPvpEpisodeCo(self.actId).id,
		leaderId = self.selectLeaderId
	}

	AutoChessController.instance:openLeaderNextView(param)
	self:closeThis()
end

function AutoChessBeginView:_btnFreshOnClick()
	Activity182Rpc.instance:sendAct182RefreshMasterRequest(self.actId, self.refreshReply, self)
end

function AutoChessBeginView:onChooseCardpackReply(_, resultCode)
	if resultCode == 0 then
		self:checkStep()
		self:refreshUI()
		self:checkGuide()
	end
end

function AutoChessBeginView:refreshReply(_, resultCode)
	if resultCode == 0 then
		self:onClickLeader(nil)
		self:refreshUI()
	end
end

function AutoChessBeginView:setBtnNextGray(isGray)
	ZProj.UGUIHelper.SetGrayscale(self._btnNext.gameObject, isGray)
	ZProj.UGUIHelper.SetGrayscale(self._txtNext.gameObject, isGray)
end

function AutoChessBeginView:checkGuide()
	if not GuideModel.instance:isGuideFinish(32012) then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.ZTrigger32012, self.step)
	end
end

return AutoChessBeginView
