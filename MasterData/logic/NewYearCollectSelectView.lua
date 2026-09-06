-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/NewYearCollectSelectView.lua

module("logic.extensions.birthdaywishes.view.NewYearCollectSelectView", package.seeall)

local NewYearCollectSelectView = class("NewYearCollectSelectView", ViewComponent)

function NewYearCollectSelectView:buildUI()
	NewYearCollectSelectView.super.buildUI(self)

	self._tableview = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnSure = self:getGo("btnSure")
end

function NewYearCollectSelectView:bindEvents()
	NewYearCollectSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function NewYearCollectSelectView:unbindEvents()
	NewYearCollectSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function NewYearCollectSelectView:onEnter()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local userWordId = GameUtil.getUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY) or 1

	self._wishPlanId = checknumber(params[2]) or BirthdayWishesConfig.instance:getWishesTextPlan(self._activityId)
	self._curWordId = userWordId or 1
	self._petData = BirthdayWishesConfig.instance:getBirthdayWishesTextPlanCfgs(self._wishPlanId)

	self:_updateUI()
end

function NewYearCollectSelectView:onExit()
	NewYearCollectSelectView.super.onExit(self)
	GameUtil.saveUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY, self._curWordId)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBirthdayWishesInfo)
end

function NewYearCollectSelectView:_updateUI()
	self._scrollList:reloadData(self._petData)
	self._scrollList:MoveCellToCenter(self._curWordId)
end

function NewYearCollectSelectView:_updateCell(view, cell, data)
	local petCon = goutil.findChild(cell, "conMask/con")
	local selectGo = goutil.findChild(cell, "selectGo")

	if not data.raceId then
		local raceId = -1
		local modelCo = CharacterConfig.instance:getModelCo(raceId)

		if modelCo then
			if not modelCo.headName then
				local petIconName = ""

				GameUtil.SetActive(selectGo, data.wishesTextId == self._curWordId)
				uGuiUtil.clearImage(petCon.gameObject)
				uGuiUtil.setSpriteToImage(petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petIconName))
				GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickCell, self, data), self)
			end
		end
	end
end

function NewYearCollectSelectView:_onClickCell(data)
	self._curWordId = data.wishesTextId

	self:_updateUI()
end

function NewYearCollectSelectView:_clearCell(cell)
	local petCon = goutil.findChild(cell, "conMask/con")

	uGuiUtil.clearImage(petCon.gameObject)
end

function NewYearCollectSelectView:_onClickBtnSure()
	GameUtil.saveUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY, self._curWordId)
	self:close()
end

return NewYearCollectSelectView
