-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/NewYearCollectView.lua

module("logic.extensions.birthdaywishes.view.NewYearCollectView", package.seeall)

local NewYearCollectView = class("NewYearCollectView", ViewComponent)

function NewYearCollectView:buildUI()
	NewYearCollectView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._iconPet = self:getGo("pet/icon")
	self._btnWish = self:getGo("btnWish")
	self._btnClose = self:getGo("btnClose")
	self._btnPet = self:getGo("pet")
	self._conMat = self:getGo("matNum/item")
	self._txtMatNum = self:getTxt("matNum/txt")
end

function NewYearCollectView:bindEvents()
	NewYearCollectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnWish, self._onClickBtnWish, self)
	GameUtil.addClickHandler(self._btnPet, self._onClickBtnPet, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NewYearCollectView:unbindEvents()
	NewYearCollectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnWish)
	GameUtil.rmClickHandler(self._btnPet)
	GameUtil.rmClickHandler(self._btnClose)
end

function NewYearCollectView:onEnter()
	self.addGEvent(self, GlobalNotify.UpdataBirthdayWishesInfo, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._wishPlanId = checknumber(params[2]) or BirthdayWishesConfig.instance:getWishesTextPlan(self._activityId)
	self._curWordId = checknumber(params[3]) or 1
	self._petData = BirthdayWishesConfig.instance:getBirthdayWishesTextPlanCfgs(self._wishPlanId)
	self._actData = BirthdayWishesConfig.instance:getActData(self._activityId)

	self:_onSetUI()
	self:_updateUI()
end

function NewYearCollectView:onExit()
	NewYearCollectView.super.onExit(self)
	GameUtil.saveUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY, self._curWordId)
	uGuiUtil.clearImage(self._iconPet.gameObject)
	MaterialMgr.clearIcon(self._conMat)
	MaterialMgr.resetAll(self._iconPet)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBirthdayWishesInfo)
end

function NewYearCollectView:_onSetUI()
	if self._actData then
		if not self._actData.costStr then
			local matStr = "8:1:1"
			local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
			local curMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

			MaterialMgr.setIcon(self._conMat, matType, matId, nil, nil)

			self._txtMatNum.text = curMatNum .. "/" .. matNum
		end
	end
end

function NewYearCollectView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function NewYearCollectView:_updateData()
	self._curWordId = GameUtil.getUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY) or 1
end

function NewYearCollectView:_updateUI()
	local data = self._petData[self._curWordId]

	if not data.raceId then
		local raceId = -1
		local modelCo = CharacterConfig.instance:getModelCo(raceId)

		if modelCo then
			if not modelCo.cardName then
				local cardName = ""

				self._scrollList:reloadData(self._petData)
				self._scrollList:MoveCellToCenter(self._curWordId)
				uGuiUtil.clearImage(self._iconPet.gameObject)
				uGuiUtil.setSpriteToImage(self._iconPet.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(cardName))
			end
		end
	end
end

function NewYearCollectView:_updateCell(view, cell, data)
	local petCon = goutil.findChild(cell, "conMask/con")
	local selectGo = goutil.findChild(cell, "selectGo")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

	txtDesc.text = data.desc

	GameUtil.SetActive(selectGo, data.wishesTextId == self._curWordId)
	GameUtil.addClickHandler(cell.gameObject, GameUtil.handler(self._onClickCell, self, data))
end

function NewYearCollectView:_onClickCell(data)
	self._curWordId = data.wishesTextId

	self:_updateUI()
end

function NewYearCollectView:_clearCell(cell)
	return
end

function NewYearCollectView:_onClickBtnWish()
	if self._actData then
		if not self._actData.costStr then
			local matStr = "8:1:1"
			local matType, matId, needNum = MaterialMgr.getMatParams(matStr)
			local curMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
			local matName = MaterialMgr.getMaterialsNameByCfg(matStr)

			if curMatNum < needNum then
				FloatWordMgr.instance:show(matName .. "不足，点击\"完成任务\"或\"换字大厅\"看看吧")

				return
			end

			MaterialFacade.instance:useItem(matType, matId, needNum, nil, nil, MaterialController.CI_SHOW_TYPE_FLY)
			GameUtil.saveUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY, self._curWordId)
			UIStateManager.instance:push(ViewName.NewYearFlyWishView, self._activityId, self._wishPlanId, self._curWordId)
			self:close()
		end
	end
end

function NewYearCollectView:_onClickBtnPet()
	GameUtil.saveUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY, self._curWordId)
	UIStateManager.instance:push(ViewName.NewYearCollectSelectView, self._activityId, self._wishPlanId, self._curWordId)
end

return NewYearCollectView
