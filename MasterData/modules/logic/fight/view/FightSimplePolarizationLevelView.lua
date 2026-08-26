-- chunkname: @modules/logic/fight/view/FightSimplePolarizationLevelView.lua

module("modules.logic.fight.view.FightSimplePolarizationLevelView", package.seeall)

local FightSimplePolarizationLevelView = class("FightSimplePolarizationLevelView", FightBaseView)

function FightSimplePolarizationLevelView:onInitView()
	self._click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#btn_level")
	self._nameText = gohelper.findChildText(self.viewGO, "name")
	self._levelText = gohelper.findChildText(self.viewGO, "level")
	self._tips = gohelper.findChild(self.viewGO, "#go_leveltip")
	self._btnClose = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_leveltip/#btn_close")
	self._title = gohelper.findChildText(self.viewGO, "#go_leveltip/bg/#txt_title")
	self._desc = gohelper.findChildText(self.viewGO, "#go_leveltip/bg/#txt_dec")
end

function FightSimplePolarizationLevelView:addEvents()
	self:com_registClick(self._click, self._onClick)
	self:com_registClick(self._btnClose, self._onBtnClose)
	self:com_registMsg(FightMsgId.RefreshSimplePolarizationLevel, self._onRefreshSimplePolarizationLevel)
	self:com_registFightEvent(FightEvent.TouchFightViewScreen, self._onTouchFightViewScreen)
end

function FightSimplePolarizationLevelView:_onTouchFightViewScreen()
	gohelper.setActive(self._tips, false)
end

function FightSimplePolarizationLevelView:_onBtnClose()
	gohelper.setActive(self._tips, false)
end

function FightSimplePolarizationLevelView:_onClick()
	if FightDataHelper.stateMgr.isReplay then
		return
	end

	gohelper.setActive(self._tips, true)
end

function FightSimplePolarizationLevelView:_onRefreshSimplePolarizationLevel()
	self:_refreshUI()
end

function FightSimplePolarizationLevelView:onOpen()
	self:_refreshUI()
end

function FightSimplePolarizationLevelView:_refreshUI()
	if not FightDataHelper.tempMgr.simplePolarizationLevel then
		local curLevel = 0
		local config = lua_simple_polarization.configDict[curLevel]

		self._levelText.text = "LV." .. curLevel

		if config then
			self._nameText.text = config.name
			self._title.text = config.name
			self._desc.text = HeroSkillModel.instance:skillDesToSpot(config.desc, "#c56131", "#7c93ad")
		else
			logError("减震表找不到等级:" .. curLevel)
		end
	end
end

return FightSimplePolarizationLevelView
