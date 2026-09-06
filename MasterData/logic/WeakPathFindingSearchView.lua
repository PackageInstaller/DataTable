-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weakpathfinding/view/WeakPathFindingSearchView.lua

module("logic.extensions.weakpathfinding.view.WeakPathFindingSearchView", package.seeall)

local WeakPathFindingSearchView = class("WeakPathFindingSearchView", ViewComponent)

function WeakPathFindingSearchView:buildUI()
	WeakPathFindingSearchView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._effPos1 = self:getGo("effPos1")
	self._effPos2 = self:getGo("effPos2")
	self._txtTimeToday = self:getTxt("timeToday/txt")
	self._spineGo1 = goutil.findChild(self._effPos1, "suoding-ui_p")
	self._spineGo2 = goutil.findChild(self._effPos2, "suoding-ui_p")
end

function WeakPathFindingSearchView:bindEvents()
	WeakPathFindingSearchView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function WeakPathFindingSearchView:unbindEvents()
	WeakPathFindingSearchView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function WeakPathFindingSearchView:onEnter()
	WeakPathFindingSearchView.super.onEnter(self)
	goutil.setActive(self._effPos1, false)
	goutil.setActive(self._effPos2, false)

	self._actId = WeakPathFindingModel.instance:getCurActId()
	self._curSceneId = WeakPathFindingModel.instance:getCurSceneId()
	self._isSearching = false

	if self._curSceneId == 0 then
		WeakPathFindingController.instance:startFinding()
	else
		self:_refreshViewByInfo()
	end

	GlobalDispatcher:addListener(GlobalNotify.WeakPathFindingUpdateInfo, self._refreshViewByInfo, self)
end

function WeakPathFindingSearchView:onExit()
	WeakPathFindingSearchView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.WeakPathFindingUpdateInfo, self._refreshViewByInfo, self)
	removetimer(self._endSearch, self)
end

function WeakPathFindingSearchView:_onClickClose()
	if self._isSearching then
		FloatWordMgr.instance:show(lang("检索中"))

		return
	else
		self:close()
	end
end

function WeakPathFindingSearchView:_refreshViewByInfo()
	self._curSceneId = WeakPathFindingModel.instance:getCurSceneId()
	self._actCfg = WeakPathFindingConfig.instance:getActCfgById(self._actId)
	self._sceneCfg = WeakPathFindingConfig.instance:getSceneCfg(self._actId, self._curSceneId)
	self._todayTimes = WeakPathFindingModel.instance:getCurTodayTimes()
	self._txtTimeToday.text = langPara("%s次", self._actCfg.dailyTimes - self._todayTimes)

	if self._sceneCfg then
		if not self._sceneCfg.landingPoint then
			local cfgPos = {
				0,
				0
			}

			GameUtil.setAnchoredPos(self._effPos2, cfgPos[1] or 0, cfgPos[2] or 0)
			self:_startSearch1()
		end
	end
end

function WeakPathFindingSearchView:_startSearch1()
	self._isSearching = true

	goutil.setActive(self._effPos1, true)
	RoleObjectPool.instance:playAnimation(self._spineGo1, "suoding", false, function()
		goutil.setActive(self._effPos1, false)
		goutil.setActive(self._effPos2, true)
		RoleObjectPool.instance:playAnimation(self._spineGo2, "idle01", false)
		settimer(1, self._endSearch, self, false)
	end, self)
end

function WeakPathFindingSearchView:_endSearch()
	self._isSearching = false

	goutil.setActive(self._effPos2, false)
	goutil.setActive(self._effPos1, false)
	self:_onClickClose()
	WeakPathFindingController.instance:gotoFindNPC()
end

return WeakPathFindingSearchView
