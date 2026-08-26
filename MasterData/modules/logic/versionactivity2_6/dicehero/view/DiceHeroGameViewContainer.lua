-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroGameViewContainer.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroGameViewContainer", package.seeall)

local DiceHeroGameViewContainer = class("DiceHeroGameViewContainer", BaseViewContainer)

function DiceHeroGameViewContainer:buildViews()
	DiceHeroStatHelper.instance:resetGameDt()

	DiceHeroModel.instance.guideLevel = DiceHeroModel.instance.lastEnterLevelId

	return {
		DiceHeroGameView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function DiceHeroGameViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		local navView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		navView:setOverrideClose(self.defaultOverrideCloseClick, self)

		return {
			navView
		}
	end
end

function DiceHeroGameViewContainer:defaultOverrideCloseClick()
	if DiceHeroFightModel.instance.finishResult ~= DiceHeroEnum.GameStatu.None then
		return
	end

	local lastEnterLevelId = DiceHeroModel.instance.lastEnterLevelId
	local co = lua_dice_level.configDict[lastEnterLevelId]

	if co then
		local gameInfo = DiceHeroModel.instance:getGameInfo(co.chapter)

		if gameInfo.currLevel ~= lastEnterLevelId or gameInfo.allPass then
			return self:statAndClose()
		end
	else
		return self:closeThis()
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroExitFight, MsgBoxEnum.BoxType.Yes_No, self.statAndClose, nil, nil, self)
end

function DiceHeroGameViewContainer:statAndClose()
	DiceHeroStatHelper.instance:sendFightEnd(nil, nil)
	self:closeThis()
end

return DiceHeroGameViewContainer
