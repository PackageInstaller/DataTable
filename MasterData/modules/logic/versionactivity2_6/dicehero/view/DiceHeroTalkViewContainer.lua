-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroTalkViewContainer.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroTalkViewContainer", package.seeall)

local DiceHeroTalkViewContainer = class("DiceHeroTalkViewContainer", BaseViewContainer)

function DiceHeroTalkViewContainer:buildViews()
	local views = {
		DiceHeroTalkView.New()
	}

	DiceHeroStatHelper.instance:resetTalkDt()

	DiceHeroModel.instance.guideLevel = self.viewParam.co.id

	if self.viewParam.co.type == DiceHeroEnum.LevelType.Story then
		table.insert(views, TabViewGroup.New(1, "#go_lefttop"))
	end

	return views
end

function DiceHeroTalkViewContainer:buildTabViews(tabContainerId)
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

function DiceHeroTalkViewContainer:defaultOverrideCloseClick()
	local co = self.viewParam.co
	local gameInfo = DiceHeroModel.instance:getGameInfo(co.chapter)

	if gameInfo.currLevel == co.id and not gameInfo.allPass then
		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DiceHeroExitFight, MsgBoxEnum.BoxType.Yes_No, self.statAndClose, nil, nil, self)
	else
		self:statAndClose()
	end
end

function DiceHeroTalkViewContainer:statAndClose()
	DiceHeroStatHelper.instance:sendStoryEnd(false, false)
	self:closeThis()
end

return DiceHeroTalkViewContainer
