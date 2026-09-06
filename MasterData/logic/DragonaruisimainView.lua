-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonaruisi/view/DragonaruisimainView.lua

module("logic.extensions.dragonaruisi.view.DragonaruisimainView", package.seeall)

local DragonaruisimainView = class("DragonaruisimainView", DragonDishitianMainView)

function DragonaruisimainView:onExit()
	DragonaruisimainView.super.onExit(self)
end

function DragonaruisimainView:onEnter()
	self.addGEvent(self, GlobalNotify.DragonDishitianGetInfoRes, self._updateUIByInfo, self)
	DragonaruisimainView.super.onEnter(self)
end

function DragonaruisimainView:bindEvents()
	DragonaruisimainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGo, self._onClickGoAct, self)
end

function DragonaruisimainView:unbindEvents()
	DragonaruisimainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
end

function DragonaruisimainView:buildUI()
	DragonaruisimainView.super.buildUI(self)

	self._txtTips = self:getTxt("stageInfo/txtTips")
	self._buff_1 = self:getGo("stageInfo/buff_1")
	self._buff_2 = self:getGo("stageInfo/buff_2")
	self._btnGo = self:getGo("stageInfo/btnGo")
	self._buffList = {}

	table.insert(self._buffList, self._buff_1)
	table.insert(self._buffList, self._buff_2)
end

function DragonaruisimainView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.DragonaruisilevelView, self._activityId)
end

function DragonaruisimainView:_onClickTip()
	TipsFacade.instance:openRulesView("dragonaruisimainview_rule")
end

function DragonaruisimainView:_onClickGoAct()
	GotoMgr.gotoByString(self._cfgActivity.jumpToAct)
end

function DragonaruisimainView:_updateUIByInfo()
	self._txtTips.text = self._cfgActivity.actDesc
	self._buffTypeCfgs = DragonDishitianConfig.instance:getBuffTypeCfgs(self._activityId) or {}

	for i, buffCell in ipairs(self._buffList) do
		local buffTypeCfg = self._buffTypeCfgs[i]

		if buffTypeCfg then
			local icon = goutil.findChild(buffCell, "icon")
			local txtDesc = goutil.findChildTextComponent(buffCell, "txtDesc")
			local info = DragonDishitianModel.instance:getBuffInfo(self._activityId, i)
			local cfg = DragonDishitianConfig.instance:getBuffCfgByprogress(self._activityId, i, (info or nil) and info.progress)

			txtDesc.text = cfg and cfg.buffdesc or "尚未激活"

			goutil.setActive(buffCell, true)
		else
			goutil.setActive(buffCell, false)
		end
	end
end

return DragonaruisimainView
