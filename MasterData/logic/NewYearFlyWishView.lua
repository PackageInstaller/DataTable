-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/birthdaywishes/view/NewYearFlyWishView.lua

module("logic.extensions.birthdaywishes.view.NewYearFlyWishView", package.seeall)

local NewYearFlyWishView = class("NewYearFlyWishView", ViewComponent)

function NewYearFlyWishView:buildUI()
	NewYearFlyWishView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._icon = self:getGo("bg/mask/petIcon")
	self._txtContent = self:getTxt("scrView/Viewport/Content")
end

function NewYearFlyWishView:bindEvents()
	NewYearFlyWishView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function NewYearFlyWishView:unbindEvents()
	NewYearFlyWishView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function NewYearFlyWishView:onEnter()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._wishPlanId = checknumber(params[2]) or BirthdayWishesConfig.instance:getWishesTextPlan(self._activityId)
	self._curWordId = checknumber(params[3]) or 1
	self._petData = BirthdayWishesConfig.instance:getBirthdayWishesTextPlanCfgs(self._wishPlanId) or {}

	self:_onSetUI()
end

function NewYearFlyWishView:onExit()
	NewYearFlyWishView.super.onExit(self)

	local random = math.random(1, #self._petData)

	self._curWordId = random ~= self._curWordId and random or random % #self._petData + 1

	uGuiUtil.clearImage(self._icon.gameObject)
	GameUtil.saveUserData(BirthdayWishesModel.NEW_YEAR_COLLECT_WORD_KEY, self._curWordId)
	GlobalDispatcher:dispatch(GlobalNotify.UpdataBirthdayWishesInfo)
end

function NewYearFlyWishView:_onSetUI()
	local data = self._petData[self._curWordId]

	if not data.raceId then
		local raceId = -1
		local modelCo = CharacterConfig.instance:getModelCo(raceId)

		if modelCo then
			if not modelCo.cardName then
				local cardName = ""
				local strWords = data.desc

				uGuiUtil.clearImage(self._icon.gameObject)
				uGuiUtil.setSpriteToImage(self._icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(cardName))

				self._txtContent.text = strWords
			end
		end
	end
end

return NewYearFlyWishView
