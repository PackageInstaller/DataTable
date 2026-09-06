-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessvote/view/GoddessVoteView.lua

module("logic.extensions.goddessvote.view.GoddessVoteView", package.seeall)

local GoddessVoteView = class("GoddessVoteView", TableViewComponent)

function GoddessVoteView:ctor()
	GoddessVoteView.super.ctor(self)

	self._curViewDatas = nil
	self._leftBtnsList = nil
	self._chosIndex = nil
end

function GoddessVoteView:bindEvents()
	GoddessVoteView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "goddessvote")
	end, self)
	self._daibiBtn:AddClickListener(function()
		if self._actCfg and not string.nilorempty(self._actCfg.voteItem) then
			MaterialMgr.openGetSourceByStr(self._actCfg.voteItem)
		end
	end, self)
	self._shenzuanBtn:AddClickListener(function()
		if self._actCfg and not string.nilorempty(self._actCfg.voteItemPrice) then
			MaterialMgr.openGetSourceByStr(self._actCfg.voteItemPrice)
		end
	end, self)
	GameUtil.asBtn(self._leftBtnsList[1].itemGo):AddClickListener(function()
		self:_onClickLeftItemBtn(1)
	end, self)
	GameUtil.asBtn(self._leftBtnsList[2].itemGo):AddClickListener(function()
		self:_onClickLeftItemBtn(2)
	end, self)
	self._freeBtn:AddClickListener(function()
		if not self._isOpenVote then
			FloatWordMgr.instance:show(lang("text_goddess_desc_1"))

			return
		end

		if self._actCfg and not string.nilorempty(self._actCfg.voteItem) then
			MaterialMgr.openGetSourceByStr(self._actCfg.voteItem)
		end
	end, self)
	self._buyBtn:AddClickListener(function()
		if not self._isOpenVote then
			FloatWordMgr.instance:show(lang("text_goddess_desc_1"))

			return
		end

		UIStateManager.instance:push(ViewName.GoddessBuy, self._actCfg.activityId)
	end, self)
	self._skillBtn:AddClickListener(function()
		if self._isOpenVote then
			FloatWordMgr.instance:show(lang("text_goddess_desc_2"))

			return
		end

		if self._actCfg and not string.nilorempty(self._actCfg.skillGoto) then
			GotoMgr.gotoByString(self._actCfg.skillGoto)
		end
	end, self)
	self._equipBtn:AddClickListener(function()
		if self._isOpenVote then
			FloatWordMgr.instance:show(lang("text_goddess_desc_2"))

			return
		end

		if self._actCfg and not string.nilorempty(self._actCfg.equipGoto) then
			GotoMgr.gotoByString(self._actCfg.equipGoto)
		end
	end, self)
	self._wakeBtn:AddClickListener(function()
		if self._isOpenVote then
			FloatWordMgr.instance:show(lang("text_goddess_desc_2"))

			return
		end

		if self._actCfg and not string.nilorempty(self._actCfg.wakeGoto) then
			GotoMgr.gotoByString(self._actCfg.wakeGoto)
		end
	end, self)
end

function GoddessVoteView:unbindEvents()
	GoddessVoteView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._daibiBtn:RemoveClickListener()
	self._shenzuanBtn:RemoveClickListener()
	GameUtil.asBtn(self._leftBtnsList[1].itemGo):RemoveClickListener()
	GameUtil.asBtn(self._leftBtnsList[2].itemGo):RemoveClickListener()
	self._freeBtn:RemoveClickListener()
	self._buyBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._equipBtn:RemoveClickListener()
	self._wakeBtn:RemoveClickListener()
end

function GoddessVoteView:onExit()
	GoddessVoteView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataGoddessVoteInfo, self._updataLeftBtnShow, self)

	self._chosIndex = nil
end

function GoddessVoteView:destroyUI()
	GoddessVoteView.super.destroyUI(self)
	uGuiUtil.clearImage(self._daibiImaGo)
	uGuiUtil.clearImage(self._shenzuanImaGo)

	self._curViewDatas = nil
	self._leftBtnsList = nil
end

function GoddessVoteView:buildUI()
	GoddessVoteView.super.buildUI(self)

	local upShowGo = self:getGo("upShowTran")

	self._closeBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewCloseBtn")
	self._tipsBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewNameTxt/tipsBtn")
	self._daibiBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "daibiItem")
	self._daibiImaGo = goutil.findChild(self._daibiBtn.gameObject, "daibiIconIma")
	self._daibiTxt = goutil.findChild(self._daibiBtn.gameObject, "daibiCountTxt"):GetComponent("Text")
	self._shenzuanBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "shenzuanItem")
	self._shenzuanImaGo = goutil.findChild(self._shenzuanBtn.gameObject, "shenzuanIconIma")
	self._shenzuanTxt = goutil.findChild(self._shenzuanBtn.gameObject, "shenzuanCountTxt"):GetComponent("Text")
	self._viewTimeGo = goutil.findChild(upShowGo, "viewTimeGo")
	self._timeTxt = goutil.findChild(self._viewTimeGo, "timeTxt"):GetComponent("Text")
	self._daibiTxt.text = ""
	self._shenzuanTxt.text = ""
	self._timeTxt.text = ""
	self._leftBtnsList = {}

	local voteItemGo = self:getBtn("voteItem")

	self._leftBtnsList[1] = {
		itemGo = voteItemGo,
		choiseGo = goutil.findChild(voteItemGo, "choiseGo"),
		redpointGo = goutil.findChild(voteItemGo, "redpointGo"),
		tagImaGo = goutil.findChild(voteItemGo, "choiseGo/tagImaGo"),
		tagTxt = goutil.findChildTextComponent(voteItemGo, "choiseGo/tagImaGo/tagTxt")
	}

	local wakeItemGo = self:getBtn("wakeItem")

	self._leftBtnsList[2] = {
		itemGo = wakeItemGo,
		choiseGo = goutil.findChild(wakeItemGo, "choiseGo"),
		redpointGo = goutil.findChild(wakeItemGo, "redpointGo"),
		tagImaGo = goutil.findChild(wakeItemGo, "choiseGo/tagImaGo"),
		tagTxt = goutil.findChildTextComponent(wakeItemGo, "choiseGo/tagImaGo/tagTxt"),
		lockGo = goutil.findChild(wakeItemGo, "lockGo")
	}
	self._voteInfoGo = self:getGo("voteInfoGo")
	self._freeBtn = Framework.ButtonAdapter.GetFrom(self._voteInfoGo, "freeBtn")
	self._buyBtn = Framework.ButtonAdapter.GetFrom(self._voteInfoGo, "buyBtn")
	self._wakeInfoGo = self:getGo("wakeInfoGo")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(self._wakeInfoGo, "skillBtn")
	self._equipBtn = Framework.ButtonAdapter.GetFrom(self._wakeInfoGo, "equipBtn")
	self._wakeBtn = Framework.ButtonAdapter.GetFrom(self._wakeInfoGo, "wakeBtn")
end

function GoddessVoteView:onEnter()
	GoddessVoteView.super.onEnter(self)

	local actId = GoddessVoteConfig.instance:getOpenActivityId()

	if checknumber(actId) <= 0 then
		error("sr----  GoddessVoteView:onEnter() y运营-美女投票    活动时间过了，还能打开？请配置功能开启id！！")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataGoddessVoteInfo, self._updataLeftBtnShow, self)

	self._chosIndex = 1

	if checknumber(self:getFirstParam()) > 0 then
		self._chosIndex = self:getFirstParam()
	end

	self._actCfg = GoddessVoteConfig.instance:getGoddessActivityCfg(actId)
	self._leftBtnsList[2].tagTxt.text = ""

	GameUtil.SetActive(self._leftBtnsList[2].tagImaGo, false)
	GameUtil.SetActive(self._leftBtnsList[2].redpointGo, false)

	self._leftBtnsList[1].choiseGo:GetComponent("Image").enabled = false
	self._leftBtnsList[2].choiseGo:GetComponent("Image").enabled = false

	MaterialMgr.updateItemByStr(self._daibiImaGo, self._actCfg.voteItem)
	MaterialMgr.updateItemByStr(self._shenzuanImaGo, self._actCfg.voteItemPrice)
	self:_updataLeftBtnShow()
	GoddessVoteController.instance:csRequestGVGetInfoReq(actId)
end

function GoddessVoteView:_updataLeftBtnShow(str)
	self:_updataCurrencyShow()

	if not string.nilorempty(str) and str == "buy" then
		return
	end

	local cfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.GoddessVote, self._actCfg.activityId)

	self._isOpenVote = true

	if cfg and not string.nilorempty(cfg.startTime) and not string.nilorempty(cfg.endTime) then
		local startTime = GameUtil.string2time(cfg.startTime)
		local endTime = GameUtil.string2time(cfg.endTime)
		local modTime = GameUtil.string2time(self._actCfg.awakenStartTime)

		if modTime <= startTime or endTime <= modTime then
			error("sr----  GoddessVoteView:_updataLeftBtnShow() y运营-美女投票    觉醒时间配置错误！！")
		end

		self._isOpenVote = modTime > ServerTime.now()
	end

	if self._isOpenVote then
		self._leftBtnsList[1].tagTxt.text = ""

		GameUtil.SetActive(self._leftBtnsList[1].tagImaGo, false)
		GameUtil.SetActive(self._leftBtnsList[2].lockGo, true)
		self:_onClickLeftItemBtn(1, true)
	else
		GameUtil.SetActive(self._leftBtnsList[2].lockGo, false)
		GameUtil.SetActive(self._leftBtnsList[1].tagImaGo, true)

		self._leftBtnsList[1].tagTxt.text = lang("text_goddess_desc_3")

		self:_onClickLeftItemBtn(2, true)
	end
end

function GoddessVoteView:_updataCurrencyShow()
	GameUtil.SetActive(self._leftBtnsList[1].redpointGo, GoddessVoteModel.instance:getGoddessVoteRedpoint())

	local have = MaterialMgr.getMatCount(self._actCfg.voteItem)

	self._daibiTxt.text = tostring(have)
	have = MaterialMgr.getMatCount(self._actCfg.voteItemPrice)
	self._shenzuanTxt.text = tostring(have)
end

function GoddessVoteView:_onClickLeftItemBtn(index, isForce)
	if self._chosIndex == index and not isForce then
		return
	end

	if self._leftBtnsList[self._chosIndex] then
		Framework.TransformUtil.SetLocalScale(self._leftBtnsList[self._chosIndex].choiseGo.transform, 0.94, 0.94, 0.94)

		self._leftBtnsList[self._chosIndex].choiseGo:GetComponent("Image").enabled = false
	end

	self._chosIndex = 1

	if index == 1 then
		GameUtil.SetActive(self._daibiBtn, true)
		GameUtil.SetActive(self._shenzuanBtn, true)

		self._curViewDatas = GoddessVoteModel.instance:getVoteRaceList(self._actCfg.activityId, not self._isOpenVote)

		GameUtil.SetActive(self._wakeInfoGo, false)
		GameUtil.SetActive(self._voteInfoGo, true)
		self._tableview:ReloadData()
	elseif index == 2 then
		if self._isOpenVote then
			FloatWordMgr.instance:show(lang("text_goddess_desc_2"))
		else
			GameUtil.SetActive(self._daibiBtn, false)
			GameUtil.SetActive(self._shenzuanBtn, false)

			self._chosIndex = 2

			if self._voteInfoGo.activeSelf then
				self._curViewDatas = {}

				self._tableview:ReloadData()
				GameUtil.SetActive(self._voteInfoGo, false)
			end

			GameUtil.SetActive(self._wakeInfoGo, true)
		end
	end

	if self._leftBtnsList[self._chosIndex] then
		self._leftBtnsList[self._chosIndex].choiseGo:GetComponent("Image").enabled = true

		Framework.TransformUtil.SetLocalScale(self._leftBtnsList[self._chosIndex].choiseGo.transform, 1, 1, 1)
	end

	if self._chosIndex == 1 then
		self._timeTxt.text = self._actCfg.voteTimeDes or self._actCfg.wakeTimeDes
	end
end

function GoddessVoteView:_getPath()
	return {
		cellPath = "voteInfoGo/petCell",
		viewPath = "voteInfoGo/petListSR"
	}
end

function GoddessVoteView:_cellSize()
	return 246, 298
end

function GoddessVoteView:_updateCell(view, cell, data)
	local nameTxt = goutil.findChildTextComponent(cell, "nameBgGo/nameTxt")
	local petIconGo = goutil.findChild(cell, "petMask/petIcon")
	local popularityGo = goutil.findChild(cell, "popularityGo")
	local popuTxt = goutil.findChildTextComponent(popularityGo, "popuTxt")
	local rankBgIma = goutil.findChild(cell, "rankBgGo"):GetComponent("UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankBgGo/rankTxt")
	local rankCol = rankTxt.gameObject:GetComponent("UITextColorChange")

	GameUtil.asBtn(cell):RemoveClickListener()
	GameUtil.asBtn(popularityGo):RemoveClickListener()
	uGuiUtil.clearImage(petIconGo)

	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, data.raceId)

	if petCfg == nil then
		return
	end

	nameTxt.text = petCfg.name
	popuTxt.text = tostring(data.voteCount)

	local rank = checknumber(data.rankId)

	if rank > 0 and rank < 4 then
		rankBgIma:SetState(rank - 1)
		rankCol:SetState(rank - 1)
	else
		rankBgIma:SetState(3)
		rankCol:SetState(3)
	end

	rankTxt.text = tostring(rank)

	local modelCfg = CharacterConfig.instance:getModelCo(checknumber(petCfg.faceIds))

	if modelCfg and not string.nilorempty(modelCfg.cardName) then
		uGuiUtil.setSpriteToImage(petIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCfg.cardName))
	end

	GameUtil.asBtn(cell):AddClickListener(function()
		PetbookController.instance:openPetinfoView(data.raceId)
	end, self)
	GameUtil.asBtn(popularityGo):AddClickListener(function()
		if not self._isOpenVote then
			FloatWordMgr.instance:show(lang("text_goddess_desc_1"))

			return
		end

		self:_openTipWindowNoX(data.raceId, petCfg.name)
	end, self)
end

function GoddessVoteView:_openTipWindowNoX(raceId, petName)
	local voteName = MaterialMgr.getMaterialsNameByCfg(self._actCfg.voteItem)
	local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.votePrize)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local str = langPara("text_goddess_desc_4", voteName, petName, matNum .. matName)

	TipsFacade.instance:openPopupWindow(lang("text_goddess_desc_5"), str, function()
		local have = MaterialMgr.getMatCount(self._actCfg.voteItem)

		if checknumber(have) <= 0 then
			FloatWordMgr.instance:show(langPara("text_goddess_desc_6", voteName))

			return
		end

		GoddessVoteController.instance:csRequestGVVoteReq(self._actCfg.activityId, raceId)
	end, nil, lang("mail_confirm"), lang("mail_cancel"), UnityEngine.TextAnchor.MiddleCenter)
end

return GoddessVoteView
