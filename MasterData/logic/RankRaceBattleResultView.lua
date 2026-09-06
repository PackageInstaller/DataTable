-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/view/RankRaceBattleResultView.lua

module("logic.extensions.rankrace.view.RankRaceBattleResultView", package.seeall)

local RankRaceBattleResultView = class("RankRaceBattleResultView", ViewComponent)

function RankRaceBattleResultView:buildUI()
	RankRaceBattleResultView.super.buildUI(self)
	self:_initTeams()
	self:_initPlayerInfo()

	self._imgBg = self:getBtn("imgBg")
	self._imgBase = self:getGo("imgBase")
	self._imgTitle = self:getGo("imgTitle"):GetComponent("UIImageSpriteChange")
	self._teamName = self:getTxt("TeamName")
	self._resultText = self:getTxt("ResultText")
	self._resultText2 = self:getTxt("ResultText2")
	self._imgAlivePetsNum = self:getGo("imgAlivePetsNum"):GetComponent("UIImageSpriteChange")
	self._continue = self:getGo("Continue")
	self._btnVideo = self:getBtn("Video")
	self._animator = self.mainGO:GetComponent("Animator")
end

function RankRaceBattleResultView:_initTeams()
	self._teams = {}

	local leftTeams = {}
	local rightTeams = {}

	self._leftTitle = self:getTxt("Left/TitleName")
	self._rightTitle = self:getTxt("Right/TitleName")

	for i = 1, 9 do
		local go = self:getGo("Left/Item" .. i)
		local dead = goutil.findChild(go, "Dead")

		leftTeams[i] = {}
		leftTeams[i].go = go
		leftTeams[i].icon = goutil.findChild(go, "Icon")
		leftTeams[i].isDead = dead
	end

	for i = 1, 9 do
		local go = self:getGo("Right/Item" .. i)
		local dead = goutil.findChild(go, "Dead")

		rightTeams[i] = {}
		rightTeams[i].go = go
		rightTeams[i].icon = goutil.findChild(go, "Icon")
		rightTeams[i].isDead = dead
	end

	self._teams[GameEnum.BattleTeam.Left] = leftTeams
	self._teams[GameEnum.BattleTeam.Right] = rightTeams
end

function RankRaceBattleResultView:_initPlayerInfo()
	self._PlayerInfo = self:getGo("PlayerInfo")
	self._playerHeadIcon = self:getGo("PlayerInfo/ImgHead/mask/img_head")
	self._playerName = self:getTxt("PlayerInfo/Name")
	self._playerDeclaration = self:getTxt("PlayerInfo/Declaration")
	self._declarationImage = self:getGo("PlayerInfo/Image")
end

function RankRaceBattleResultView:bindEvents()
	RankRaceBattleResultView.super.bindEvents(self)
	self._btnVideo:AddClickListener(self._onClickVideo, self)
	self._imgBg:AddClickListener(self._onClickContinue, self)
end

function RankRaceBattleResultView:unbindEvents()
	RankRaceBattleResultView.super.unbindEvents(self)
	self._btnVideo:RemoveClickListener()
	self._imgBg:RemoveClickListener()
end

function RankRaceBattleResultView:onEnter()
	RankRaceBattleResultView.super.onEnter(self)

	local param = self._viewPresentor:getOpenParam()

	self._reason = param and param[1]
	self._detailData = param and param[3].data
	self._detailMyAttackBattleResult = param and param[3].myAttackBattleResult
	self._detailOpAttackBattleResult = param and param[3].opAttackBattleResult

	if self:_openByDetail() then
		self._imgBg.gameObject:SetActive(false)
		self._continue.gameObject:SetActive(false)
		self._PlayerInfo.gameObject:SetActive(false)
		self._imgTitle.gameObject:SetActive(false)
		GameUtil.setLocalPos(self._btnVideo, 524, -290, 0)

		self._isShowingSelf = param[2]
		self._animator.enabled = false
	else
		self._imgBg.gameObject:SetActive(true)
		self._continue.gameObject:SetActive(true)
		self._PlayerInfo.gameObject:SetActive(true)
		self._imgTitle.gameObject:SetActive(true)
		GameUtil.setLocalPos(self._btnVideo, 524, 278, 0)

		self._isShowingSelf = RankRaceResultModel.instance:getBattleResultStage() == RankRaceResultModel.ResStage_Mine
	end

	self:_updateResultInfos()
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)

	self._ani = self.mainGO:GetComponent("Animator")

	GlobalDispatcher:addListener(GlobalNotify.ItemGetViewDoClosed, self._itemGetViewDoClosed, self)

	if RankRaceModel.instance:getReportTo() then
		goutil.setActive(self._imgBase, false)
	else
		goutil.addChildToParent(self.mainGO, goutil.findChild(self.mainGO.transform.parent.parent, "NOTIFY").transform)
	end
end

function RankRaceBattleResultView:onExit()
	RankRaceBattleResultView.super.onExit(self)

	for k, teams in pairs(self._teams) do
		for i = 1, #teams do
			local bigImg = Framework.ImageBigBG.Get(teams[i].icon)

			bigImg:ClearImage()
		end
	end

	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self._onViewOpened, self)
	GlobalDispatcher:removeListener(GlobalNotify.ItemGetViewDoClosed, self._itemGetViewDoClosed, self)
end

function RankRaceBattleResultView:_updateResultInfos()
	self:_updateTitle()
	self:_updateTeamTitle()
	self:_updateShowTeamName()
	self:_updateBattleResult()
	self:_updateBattleTeams()
	self:_updatePlayerInfo()
	self:_updateDeclaration()
end

function RankRaceBattleResultView:_updateTitle()
	if self:_openByDetail() then
		return
	end

	if self._isShowingSelf then
		self._imgTitle:SetState(0)
	else
		self._imgTitle:SetState(1)
	end
end

function RankRaceBattleResultView:_updateTeamTitle()
	if self._isShowingSelf then
		self._leftTitle.text = "我方攻阵"
		self._rightTitle.text = "敌方守阵"
	else
		self._leftTitle.text = "敌方攻阵"
		self._rightTitle.text = "我方守阵"
	end
end

function RankRaceBattleResultView:_updateShowTeamName()
	self._teamName.text = self._isShowingSelf and "我方" or "敌方"
end

function RankRaceBattleResultView:_updatePlayerInfo()
	if self:_openByDetail() then
		return
	end

	if self._isShowingSelf then
		self._playerName.text = RoleModel.instance:getUserName()

		HeadItemController.instance:setHeadCellByInfo(self._playerHeadIcon, RoleModel.instance:GetRole())
	else
		self._playerName.text = RankRaceChallengerModel.instance:getOpUserName()

		HeadItemController.instance:setHeadCellByInfo(self._playerHeadIcon, RankRaceChallengerModel.instance:getHeadInfo())
	end
end

function RankRaceBattleResultView:_updateDeclaration()
	if self:_openByDetail() then
		return
	end

	local myDeclearWord, opDeclearWord = RankRaceController.instance:getResultDeclear()

	if self._isShowingSelf then
		if not myDeclearWord or myDeclearWord == "" then
			self._PlayerInfo.gameObject:SetActive(false)
		else
			self._PlayerInfo.gameObject:SetActive(true)

			self._playerDeclaration.text = myDeclearWord

			GameUtil.setWidth(self._declarationImage, StringUtil.GetUtf8Length(myDeclearWord) * 24 + 70)
		end
	elseif not opDeclearWord or opDeclearWord == "" then
		self._PlayerInfo.gameObject:SetActive(false)
	else
		self._PlayerInfo.gameObject:SetActive(true)

		self._playerDeclaration.text = opDeclearWord

		GameUtil.setWidth(self._declarationImage, StringUtil.GetUtf8Length(opDeclearWord) * 24 + 70)
	end
end

function RankRaceBattleResultView:_updateBattleResult()
	local result

	if self._isShowingSelf then
		self._teamName.text = "我方"

		if self:_openByDetail() then
			self._imgAlivePetsNum:SetState(self._detailData.myAlivePetSize)
		else
			self._imgAlivePetsNum:SetState(RankRaceResultModel.instance:getMyPetLeftCount())
		end

		result = RankRaceResultModel.instance:getAttackResult()
	else
		self._teamName.text = "敌方"

		if self:_openByDetail() then
			self._imgAlivePetsNum:SetState(self._detailData.opAlivePetSize)
		else
			self._imgAlivePetsNum:SetState(RankRaceResultModel.instance:getOpPetLeftCount())
		end

		result = RankRaceResultModel.instance:getDefenseResult()
	end

	if self:_openByDetail() then
		if self._isShowingSelf then
			if self._detailData.myAlivePetSize == self._detailData.opAlivePetSize then
				-- block empty
			else
				self._resultText2.text = self._detailData.myAlivePetSize > self._detailData.opAlivePetSize and "成功" or "失败"
			end
		elseif self._detailData.myAlivePetSize == self._detailData.opAlivePetSize then
			-- block empty
		else
			self._resultText2.text = self._detailData.myAlivePetSize < self._detailData.opAlivePetSize and "成功" or "失败"
		end
	else
		self._resultText2.text = (not result or result.originalWinner == GameEnum.BattleTeam.Left) and "成功" or "失败"
	end
end

function RankRaceBattleResultView:_updateBattleTeams()
	local result = self._isShowingSelf and (self:_openByDetail() and self._detailMyAttackBattleResult or RankRaceResultModel.instance:getAttackResult()) or self:_openByDetail() and self._detailOpAttackBattleResult or RankRaceResultModel.instance:getDefenseResult()

	if not result then
		return
	end

	local allPets = RankRaceResultModel.instance:getRemainPetHpsFromResult(result)

	if not allPets then
		return
	end

	for k, v in pairs(self._teams) do
		local pets = allPets[k]
		local teams = v

		for i = 1, #teams do
			local pet = pets[i]

			if not pet then
				teams[i].go:SetActive(false)
			else
				teams[i].go:SetActive(true)
				teams[i].isDead:SetActive(pet.isDead or false)

				local modelCo = CharacterConfig.instance:getModelCo(checknumber(pet.curFaceId))

				uGuiUtil.setSpriteToImage(teams[i].icon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
			end
		end
	end
end

function RankRaceBattleResultView:_onClickVideo()
	local isOpenByDetail = self:_openByDetail()

	print("isOpenByDetail = " .. tostring(isOpenByDetail))

	local btlResult

	if isOpenByDetail then
		RankRaceController.instance:setClickVideoForDetail(self._isShowingSelf and true or false)

		btlResult = self._isShowingSelf and self._detailMyAttackBattleResult or self._detailOpAttackBattleResult
	else
		RankRaceController.instance:setClickVideo(self._isShowingSelf and true or false)

		btlResult = self._isShowingSelf and RankRaceResultModel.instance:getAttackResult() or RankRaceResultModel.instance:getDefenseResult()
	end

	if btlResult then
		local str = btlResult:SerializeToString()
		local msgClone = BattleExtension_pb.PM_BattleResult()

		msgClone:ParseFromString(str)
		BattleFacade.instance:onViewUserFightMonsterBtlResult(msgClone)
	end
end

function RankRaceBattleResultView:_onClickContinue()
	if self:_openByDetail() then
		return
	end

	if self._isShowingSelf then
		self._isShowingSelf = false

		RankRaceResultModel.instance:setBattleResultStage(RankRaceResultModel.ResStage_Enermy)
		self:_updateResultInfos()
		self:_animatorReBind()
	else
		RankRaceResultModel.instance:setBattleResultStage(RankRaceResultModel.ResStage_Result)
		ViewMgr.instance:open(ViewName.RankRaceResultView)
	end
end

function RankRaceBattleResultView:_onViewOpened(view)
	if self:_openByDetail() then
		return
	end

	if view.viewName == ViewName.RankRaceResultView then
		self:close()
	end
end

function RankRaceBattleResultView:setActive(show, _reason, _showingSelf, _detailData)
	self.mainGO:SetActive(show)

	if show then
		self._reason = _reason
		self._isShowingSelf = _showingSelf
		self._detailData = _detailData.data
		self._detailMyAttackBattleResult = _detailData.myAttackBattleResult
		self._detailOpAttackBattleResult = _detailData.opAttackBattleResult

		self:_updateResultInfos()
	end
end

function RankRaceBattleResultView:_openByDetail()
	if self._reason and self._reason == "detail" then
		return true
	end
end

function RankRaceBattleResultView:_itemGetViewDoClosed()
	self:_animatorReBind()
end

function RankRaceBattleResultView:_animatorReBind()
	if self._ani then
		self._ani:Rebind()
	end
end

return RankRaceBattleResultView
