-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat2023/view/YearCardPreheat2023ClueView.lua

module("logic.extensions.yearcardpreheat2023.view.YearCardPreheat2023ClueView", package.seeall)

local YearCardPreheat2023ClueView = class("YearCardPreheat2023ClueView", ViewComponent)

function YearCardPreheat2023ClueView:buildUI()
	YearCardPreheat2023ClueView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._txtDesc = self:getTxt("txtDesc")
	self._icon = self:getGo("icon")
	self._txtIcon = goutil.findChildTextComponent(self._icon, "txt")
end

function YearCardPreheat2023ClueView:bindEvents()
	YearCardPreheat2023ClueView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function YearCardPreheat2023ClueView:unbindEvents()
	YearCardPreheat2023ClueView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function YearCardPreheat2023ClueView:onEnter()
	YearCardPreheat2023ClueView.super.onEnter(self)

	self._actId = YearCardPreheat2023Model.instance:getActId()

	local actCfg = YearCardPreheat2023Config.instance:getActCfgByActId(self._actId)
	local designCfgs = YearCardPreheat2023Config.instance:getDesignCfgsByPlanId(actCfg.designPlanId)
	local designId = YearCardPreheat2023Model.instance:getCurDesignId()
	local designCfg = designCfgs and designCfgs[designId]

	if designCfg then
		if not string.nilorempty(designCfg.cluePicture) then
			uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/%s.png", designCfg.cluePicture))

			self._txtIcon.text = designCfg.cluePicture
		end

		self._txtDesc.text = designCfg.content
	end

	self._isShowMain = designId == #designCfgs

	YearCardPreheat2023Controller.instance:collateClue(self._actId)
end

function YearCardPreheat2023ClueView:onExit()
	YearCardPreheat2023ClueView.super.onExit(self)
	uGuiUtil.clearImage(self._icon)
end

function YearCardPreheat2023ClueView:_onClickClose()
	UIStateManager.instance:popByName(ViewName.YearCardPreheat2023GameView)
	self:close()

	if self._isShowMain then
		UIStateManager.instance:push(ViewName.YearCardPreheat2023View, self._actId)
	else
		UIStateManager.instance:push(ViewName.YearCardPreheat2023ExploreView)
	end
end

return YearCardPreheat2023ClueView
