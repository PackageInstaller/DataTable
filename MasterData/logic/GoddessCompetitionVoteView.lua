-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscompetition/view/GoddessCompetitionVoteView.lua

module("logic.extensions.goddesscompetition.view.GoddessCompetitionVoteView", package.seeall)

local GoddessCompetitionVoteView = class("GoddessCompetitionVoteView", ViewComponent)

function GoddessCompetitionVoteView:ctor()
	GoddessCompetitionVoteView.super.ctor(self)
end

function GoddessCompetitionVoteView:unbindEvents()
	GoddessCompetitionVoteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnLess)
	GameUtil.rmClickHandler(self._btnAdd100)
	GameUtil.rmClickHandler(self._btnLess100)
	GameUtil.rmClickHandler(self._btnAdd1000)
	GameUtil.rmClickHandler(self._btnLess1000)
	GameUtil.rmClickHandler(self._btnJumpUse)
	self._input:RemoveOnValueChanged()
end

function GoddessCompetitionVoteView:bindEvents()
	GoddessCompetitionVoteView.super.bindEvents(self)
	self._input:AddOnValueChanged(self._onInPutChanged, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._onClickSwitch, self, true))
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._onClickSwitch, self, false))
	GameUtil.addClickHandler(self._btnAdd, GameUtil.handler(self._onClickChangeNum, self, 1))
	GameUtil.addClickHandler(self._btnLess, GameUtil.handler(self._onClickChangeNum, self, -1))
	GameUtil.addClickHandler(self._btnAdd100, GameUtil.handler(self._onClickChangeNum, self, 100))
	GameUtil.addClickHandler(self._btnLess100, GameUtil.handler(self._onClickChangeNum, self, -100))
	GameUtil.addClickHandler(self._btnAdd1000, GameUtil.handler(self._onClickChangeNum, self, 1000))
	GameUtil.addClickHandler(self._btnLess1000, GameUtil.handler(self._onClickChangeNum, self, -1000))
	GameUtil.addClickHandler(self._btnJumpUse, self._onClickJumpUse, self)
end

function GoddessCompetitionVoteView:buildUI()
	GoddessCompetitionVoteView.super.buildUI(self)

	self._petIcon = self:getGo("petCell/pet/petIcon")
	self._txtVoteNum = self:getTxt("petCell/voteNum/txt")
	self._txtPetName = self:getTxt("petCell/name/txt")
	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._btnRight = self:getGo("btnRight")
	self._btnLeft = self:getGo("btnLeft")
	self._btnAdd = self:getGo("batchVote/Marks/btnAdd")
	self._btnLess = self:getGo("batchVote/Marks/btnLess")
	self._btnAdd100 = self:getGo("batchVote/Marks/btnAdd100")
	self._btnLess100 = self:getGo("batchVote/Marks/btnLess100")
	self._btnAdd1000 = self:getGo("batchVote/Marks/btnAdd1000")
	self._btnLess1000 = self:getGo("batchVote/Marks/btnLess1000")
	self._input = self:getInput("batchVote/input")
	self._txtNumCost = self:getTxt("btnSure/txtNum")
	self._iconCost = self:getGo("btnSure/iconCost")
	self._txtAddValue = self:getTxt("petCell/txtAddValue")
	self._txtTips = self:getTxt("txtTips")
	self._goldBarItem = self:getGo("goldBar/img")
	self._goldBarNum = self:getTxt("goldBar/txt")
	self._tagEmpty = self:getGo("extraItem/tagEmpty")
	self._btnJumpUse = self:getGo("extraItem/tagEmpty/btnJumpUse")
	self._content = self:getGo("extraItem/content")
	self._extraItem = self:getGo("extraItem/content/item")
	self._txtItemName = self:getTxt("extraItem/content/txtName")
	self._txtCount = self:getTxt("extraItem/content/count/txt")
end

function GoddessCompetitionVoteView:onExit()
	GoddessCompetitionVoteView.super.onExit(self)
	uGuiUtil.clearImage(self._petIcon)
	MaterialMgr.resetAll(self._iconCost)
	MaterialMgr.resetAll(self._goldBarItem)
	MaterialMgr.resetAll(self._extraItem)
end

function GoddessCompetitionVoteView:onEnter()
	GoddessCompetitionVoteView.super.onEnter(self)

	self._activityId = GoddessCompetitionModel.instance:getCurActId()
	self._curVoteFaceId = checknumber(self:getFirstParam())

	local baseInfo = GoddessCompetitionModel.instance:getCurActBaseInfo()
	local curStepId = baseInfo.curStepId

	self._curShowInfoList = GoddessCompetitionModel.instance:getCurGoddessList(curStepId)

	local myUserId = tostring(RoleModel.instance:getUserId())

	self._curShowId = 0

	local isSuperFan = false

	for i, goddessInfo in ipairs(self._curShowInfoList) do
		if self._curVoteFaceId == goddessInfo.faceId then
			self._curShowId = i

			if not goddessInfo.superFansList then
				for _, fanInfo in ipairs(goddessInfo.superFansList) do
					if fanInfo.headInfo.userId == myUserId then
						isSuperFan = true
					end
				end

				break
			end
		end
	end

	if self._curShowId == 0 then
		self:close()
		FloatWordMgr.instance:show("当前阶段不可对该女神投票")

		return
	end

	self._actCfg = GoddessCompetitionConfig.instance:getActCfg(self._activityId)
	self._isSuperFan = isSuperFan

	if isSuperFan then
		if not self._actCfg.superFanPopularityRate then
			local exchangeRatio = self._actCfg.normalFanPopularityRate
			local doubleCard = GoddessCompetitionModel.instance:getDoubleCardInfo()
			local effectDoubleCardId = doubleCard and checknumber(doubleCard.effectDoubleCardId) or 0

			if effectDoubleCardId > 0 then
				local doubleCardCfg = GoddessCompetitionConfig.instance:getDoubleCardCfg(self._activityId, effectDoubleCardId)

				exchangeRatio = doubleCardCfg and checknumber(doubleCardCfg.ratio) or 1
			end

			self._txtTips.text = string.format("投票后将以<color=#EB4642>1:%s</color>的比例为女神增加人气", exchangeRatio)

			self:_updateCurVoteInfo()

			self._curOwnNum = MaterialMgr.getMatCount(self._actCfg.voteItem)
			self._minCount = 0
			self._maxCount = self._curOwnNum
			self._curVoteNum = self._curOwnNum > 0 and 1 or 0

			self:_refreshVoteCount()

			local matType, cfgId = MaterialMgr.getMatParams(self._actCfg.voteItem)

			MaterialMgr.setIcon(self._iconCost, matType, cfgId)

			self._exchangeItemName = MaterialMgr.getMaterialsNameByCfg(self._actCfg.exchangeItem)

			self.addGEvent(self, GlobalNotify.GoddessCompetitionVoteRes, self._handleVote, self)
			MaterialMgr.setIcon(self._goldBarItem, matType, cfgId)

			self._goldBarNum.text = MaterialModel.instance:getMaterialsNumber(matType, cfgId)

			self:_updateDoubleCardInfo()
		end
	end
end

function GoddessCompetitionVoteView:_updateCurVoteInfo()
	local goddessInfo = self._curShowInfoList[self._curShowId]
	local faceId = checknumber(goddessInfo.faceId)
	local modelCo = CharacterConfig.instance:getModelCo(faceId)

	uGuiUtil.setSpriteToImage(self._petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	self._txtPetName.text = PetSkinConfig.instance:getPetSkinName(faceId)
	self._txtVoteNum.text = langPara("人气：%s", goddessInfo.popularity)

	goutil.setActive(self._btnLeft, self._curShowId > 1)
	goutil.setActive(self._btnRight, self._curShowId < #self._curShowInfoList)

	self._curFaceId = goddessInfo.faceId
end

function GoddessCompetitionVoteView:_handleVote()
	FloatWordMgr.instance:show("投票成功")
	self:close()
	GoddessCompetitionController.instance:getInfo(self._activityId)
end

function GoddessCompetitionVoteView:_onClickChangeNum(changeNum)
	if self._curOwnNum <= 0 then
		return
	end

	self._curVoteNum = self._curVoteNum + checknumber(changeNum)

	self:_refreshVoteCount()
end

function GoddessCompetitionVoteView:_onInPutChanged()
	self._curVoteNum = self._curOwnNum <= 0 and 0 or checknumber(self._input:GetText())

	self:_refreshVoteCount()
end

function GoddessCompetitionVoteView:_refreshVoteCount()
	self._curVoteNum = Mathf.Clamp(self._curVoteNum, self._minCount, self._maxCount)

	local str = tostring(self._curVoteNum)

	self._input:SetText(str)

	self._txtNumCost.text = str

	local hasVoteItem = self._curOwnNum > 0

	if hasVoteItem then
		local addPopularity = GoddessCompetitionModel.instance:calcVotePopularity(self._curVoteNum, self._isSuperFan)

		self._txtAddValue.text = "+" .. addPopularity
	else
		self._txtAddValue.text = ""
	end

	GameUtil.SetGray(self._btnSure, not hasVoteItem)
end

function GoddessCompetitionVoteView:_onClickSwitch(isTurnLeft)
	self._curShowId = isTurnLeft and self._curShowId - 1 or self._curShowId + 1

	self:_updateCurVoteInfo()
end

function GoddessCompetitionVoteView:_onClickBtnMax()
	self._curVoteNum = self._maxCount

	self:_refreshVoteCount()
end

function GoddessCompetitionVoteView:_onClickBtnMin()
	self._curVoteNum = self._minCount

	self:_refreshVoteCount()
end

function GoddessCompetitionVoteView:_onClickSure()
	if self._curOwnNum <= 0 then
		self:close()
		MaterialMgr.openGetSourceByStr(self._actCfg.voteItem)

		return
	end

	if self._curVoteNum <= 0 then
		FloatWordMgr.instance:show("投票数量不能为0")

		return
	end

	if self._curVoteNum > self._curOwnNum then
		FloatWordMgr.instance:show("剩余票数不足")

		return
	end

	local isInCompetitionTime = GoddessCompetitionController.instance:isInCompetitionTime(self._activityId)

	if not isInCompetitionTime then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	local matType, cfgId = MaterialMgr.getMatParams(self._actCfg.voteItem)
	local addPopularity = GoddessCompetitionModel.instance:calcVotePopularity(self._curVoteNum, self._isSuperFan)
	local text = string.format("是否消耗%s张%s对%s进行投票，增加%s人气值，并获得%s个%s?", self._curVoteNum, MaterialMgr.getMaterialsName(matType, cfgId), self._txtPetName.text, addPopularity, self._curVoteNum, self._exchangeItemName)

	TipsFacade.instance:openPopupWindow("提示", text, function()
		GoddessCompetitionController.instance:vote(self._activityId, self._curFaceId, self._curVoteNum)
	end)
end

function GoddessCompetitionVoteView:_updateDoubleCardInfo()
	local doubleCard = GoddessCompetitionModel.instance:getDoubleCardInfo()

	if doubleCard then
		if not doubleCard.effectDoubleCardId then
			local effectDoubleCardId = 0
			local cfg = GoddessCompetitionConfig.instance:getDoubleCardCfg(self._activityId, effectDoubleCardId)
			local isEmpty = cfg == nil

			self._txtItemName.text = cfg and MaterialMgr.getMaterialsNameByCfg(cfg.cost)

			if isEmpty then
				MaterialMgr.resetAll(self._extraItem)
			else
				local proxy = MaterialMgr.setCellByCfg(cfg.cost, self._extraItem)

				if proxy then
					proxy.binder:setNum(0)
				end
			end

			if not doubleCard.doubleCardLeftValue then
				local leftValue = 0

				if cfg then
					if not cfg.cardValue then
						local cardValue = 0

						self._txtCount.text = string.format("<color=#eb4642>%s</color>/%s", leftValue, cardValue)

						goutil.setActive(self._tagEmpty, isEmpty)
						goutil.setActive(self._content, not isEmpty)
					end
				end
			end
		end
	end
end

function GoddessCompetitionVoteView:_onClickJumpUse()
	self:close()
	GlobalDispatcher:dispatch(TabFrameWorkController.NotifyTabframeworkviewJumpByName, self._activityId, ViewName.GoddessCompetitionSpecialItemView)
end

return GoddessCompetitionVoteView
