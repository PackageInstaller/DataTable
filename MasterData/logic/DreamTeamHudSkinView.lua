-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudSkinView.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudSkinView", package.seeall)

local DreamTeamHudSkinView = class("DreamTeamHudSkinView", ViewComponent)

function DreamTeamHudSkinView:buildUI()
	DreamTeamHudSkinView.super.buildUI(self)

	self._btnShowPoster = self:getBtn("btnShowPoster")
	self._btnShowSkill = self:getBtn("btnShowSkill")
	self._listSkin = {}

	for i = 1, 5 do
		local cell = {}

		cell.cfg = nil
		cell.go = self:getGo("listSkin/cell_" .. i)
		cell.btnSkin = goutil.findChild(cell.go, "btnSkin")
		cell.btnToGet = goutil.findChild(cell.go, "btnToGet")
		cell.txtDate = goutil.findChildTextComponent(cell.go, "date/txtDate")
		cell.redPoint = goutil.findChild(cell.btnToGet, "rd")
		self._listSkin[i] = cell
	end
end

function DreamTeamHudSkinView:onEnter()
	DreamTeamHudSkinView.super.onEnter(self)

	local cfgs = DreamTeamHudConfig.instance:getSkinViewCfgs()

	for i = 1, 5 do
		local cell = self._listSkin[i]

		cell.cfg = cfgs[i]

		goutil.setActive(cell.redPoint, false)

		local timeStart = GameUtil.string2time(cell.cfg.startTime)

		if timeStart < ServerTime.now() then
			goutil.setActive(cell.btnSkin, true)
			goutil.setActive(cell.btnToGet, true)
			goutil.setActive(cell.txtDate.gameObject, false)
			RedPointController.instance:regRedPoint(cell.redPoint, cell.cfg.redpoint)
		else
			goutil.setActive(cell.btnSkin, false)
			goutil.setActive(cell.btnToGet, false)
			goutil.setActive(cell.txtDate.gameObject, true)

			cell.txtDate.text = langPara("%s后\n开放获得", GameUtil.formatTimeStamp("%m/%d %H:00", timeStart))
		end
	end

	DreamTeamHudController.instance:setRDInfo(RedPointModel.ID_DREAMTEAMHUD_SECOND, DreamTeamHudController.UserDataSaveType.First)
end

function DreamTeamHudSkinView:onExit()
	DreamTeamHudSkinView.super.onExit(self)

	for i = 1, 5 do
		RedPointController.instance:unregRedPoint(self._listSkin[i].redPoint)
	end
end

function DreamTeamHudSkinView:bindEvents()
	DreamTeamHudSkinView.super.bindEvents(self)

	for i = 1, 5 do
		GameUtil.addClickHandler(self._listSkin[i].btnSkin, GameUtil.handler(self._onClickBtnSkin, self, i))
		GameUtil.addClickHandler(self._listSkin[i].btnToGet, GameUtil.handler(self._onClickBtnToGet, self, i))
	end

	self._btnShowPoster:AddClickListener(self._onClickBtnShowPoster, self)
	self._btnShowSkill:AddClickListener(self._onClickShowSkill, self)
end

function DreamTeamHudSkinView:unbindEvents()
	DreamTeamHudSkinView.super.unbindEvents(self)

	for i = 1, 5 do
		GameUtil.rmClickHandler(self._listSkin[i].btnSkin)
		GameUtil.rmClickHandler(self._listSkin[i].btnSkin)
	end

	self._btnShowPoster:RemoveClickListener()
	self._btnShowSkill:RemoveClickListener()
end

function DreamTeamHudSkinView:_onClickBtnToGet(Id)
	local cfg = self._listSkin[Id].cfg

	if cfg then
		MaterialMgr.openGetSource(MatType.PET_SKIN, cfg.skinId)
		DreamTeamHudController.instance:setRDInfo(cfg.redpoint, DreamTeamHudController.UserDataSaveType.First)
		SurveyController.instance:reportBehavior(cfg.reportBehavior)
	end
end

function DreamTeamHudSkinView:_onClickBtnSkin(Id)
	local cfg = self._listSkin[Id].cfg

	if cfg then
		UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, cfg.skinId)
	end
end

function DreamTeamHudSkinView:_onClickBtnShowPoster()
	TipsFacade.instance:openCommonTips(lang("合体海报将于1月28日上线"))
end

function DreamTeamHudSkinView:_onClickShowSkill()
	FuncOpenController.instance:openFunc(149, 10342)
end

return DreamTeamHudSkinView
