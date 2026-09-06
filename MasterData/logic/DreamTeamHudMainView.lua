-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/dreamteam/DreamTeamHudMainView.lua

module("logic.extensions.operationsummary.view.dreamteam.DreamTeamHudMainView", package.seeall)

local DreamTeamHudMainView = class("DreamTeamHudMainView", ViewComponent)

function DreamTeamHudMainView:buildUI()
	DreamTeamHudMainView.super.buildUI(self)

	self._cantainer = self:getGo("cantainer")
	self._btnClose = self:getBtn("btnClose")
	self._listEnter = {}

	for i = 1, 4 do
		local cell = {}

		cell.cfg = nil
		cell.go = self:getGo("listEnter/btn_" .. i)
		cell.redPoint = goutil.findChild(cell.go, "redPoint")
		cell.select = goutil.findChild(cell.go, "select")
		self._listEnter[i] = cell
	end

	self._curShowIndex = -1
end

function DreamTeamHudMainView:onEnter()
	DreamTeamHudMainView.super.onEnter(self)

	local cfgs = DreamTeamHudConfig.instance:getMainViewCfgs()

	for i = 1, 4 do
		self._listEnter[i].cfg = cfgs[i]

		goutil.setActive(self._listEnter[i].redPoint, false)

		if cfgs[i] and cfgs[i].redPointIds then
			RedPointController.instance:regRedPoint(self._listEnter[i].redPoint, unpack(cfgs[i].redPointIds or {}))
		end
	end

	local firstShowId = checkint(self:getFirstParam())

	if firstShowId <= 0 then
		firstShowId = self._curShowIndex == -1 and 1 or self._curShowIndex
	end

	self._curShowIndex = -1

	self:_swtichView(firstShowId)

	if self._playEff then
		UIEffectManager.instance:stopEffect(self._playEff)

		self._playEff = nil
	end

	self._playEff = UIEffectManager.instance:playEffect(self, "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab", self.mainGO.transform, 0, 0, true, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(self.mainGO.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
		eff:setClipping(self.mainGO:GetComponent(goutil.Type_RectTransform))
	end)
end

function DreamTeamHudMainView:onExit()
	DreamTeamHudMainView.super.onExit(self)

	for i = 1, 4 do
		RedPointController.instance:unregRedPoint(self._listEnter[i].redPoint)
	end

	if self._playEff then
		UIEffectManager.instance:stopEffect(self._playEff)

		self._playEff = nil
	end
end

function DreamTeamHudMainView:bindEvents()
	DreamTeamHudMainView.super.bindEvents(self)

	for i = 1, 4 do
		GameUtil.addClickHandler(self._listEnter[i].go, GameUtil.handler(self._swtichView, self, i))
	end

	self._btnClose:AddClickListener(self.close, self)
end

function DreamTeamHudMainView:unbindEvents()
	DreamTeamHudMainView.super.unbindEvents(self)

	for i = 1, 4 do
		GameUtil.rmClickHandler(self._listEnter[i].go)
	end

	self._btnClose:RemoveClickListener()
end

function DreamTeamHudMainView:_swtichView(id)
	if self._curShowIndex ~= id then
		self:showTabAt(self._cantainer, "")

		local cfg = self._listEnter[id].cfg

		if not string.nilorempty(cfg and cfg.viewname) then
			self:showTabAt(self._cantainer, cfg.viewname, cfg)
		end

		SurveyController.instance:reportBehavior(cfg.reportBehavior)

		self._curShowIndex = id
	end

	for k, v in ipairs(self._listEnter) do
		goutil.setActive(v.select, id == k)
	end
end

return DreamTeamHudMainView
