-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/hud/YearCardPreheatHud2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.hud.YearCardPreheatHud2023View", package.seeall)

local YearCardPreheatHud2023View = class("YearCardPreheatHud2023View", ViewComponent)

function YearCardPreheatHud2023View:buildUI()
	YearCardPreheatHud2023View.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnPoster = self:getGo("btnPoster")

	local parentEnterCell = self:getGo("enterList")

	self._enterList = {}

	for i = 1, 6 do
		local childPath = "enterCell" .. i
		local cell = {}

		cell.go = goutil.findChild(parentEnterCell, childPath)
		cell.btn = goutil.findChild(cell.go, "btn")
		cell.redPoint = goutil.findChild(cell.btn, "redpoint")
		cell.txt = goutil.findChildTextComponent(cell.btn, "txt")
		cell.cfg = nil
		self._enterList[childPath] = cell
	end

	self.skinId = 16010
	self._rare = self:getGo("petInfo/rare")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")
end

function YearCardPreheatHud2023View:bindEvents()
	YearCardPreheatHud2023View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPoster, self._onClickPoster, self)

	for k, v in pairs(self._enterList) do
		GameUtil.addClickHandler(v.btn, GameUtil.handler(self._onClickGotoBtn, self, k))
	end

	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function YearCardPreheatHud2023View:unbindEvents()
	YearCardPreheatHud2023View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPoster)

	for k, v in pairs(self._enterList) do
		GameUtil.rmClickHandler(v.btn)
	end

	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function YearCardPreheatHud2023View:onEnter()
	YearCardPreheatHud2023View.super.onEnter(self)

	self._planId = self:getFirstParam()
	self._hudCfgs = YearCardConfig.instance:getpreheatviewCfgById(checkint(self._planId))

	self:refreshView()

	local key = self:_getKey()

	if checkint(GameUtil.getUserData(key)) <= 0 then
		self:_onClickPoster()
	end

	MaterialMgr.setCell(MatType.Rare, self.skinId, self._rare)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	self._txtName.text = skinCfg.name

	local path = "20221223/nianfeigonglue/fx_ui_nianfeigonglue.prefab"

	self._eff = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)
	end)
end

function YearCardPreheatHud2023View:onExit()
	YearCardPreheatHud2023View.super.onExit(self)
	self:resetView()
	MaterialMgr.resetAll(self._rare)

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

function YearCardPreheatHud2023View:resetView()
	for k, v in pairs(self._enterList) do
		v.cfg = nil

		goutil.setActive(v.go, false)
		goutil.setActive(v.redPoint, false)
		RedPointController.instance:unregRedPoint(v.redPoint)
	end
end

function YearCardPreheatHud2023View:refreshView()
	self:resetView()

	if self._hudCfgs then
		for k, cfg in ipairs(self._hudCfgs) do
			local cell = self._enterList[cfg.enterPath]

			if GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) and cell then
				cell.cfg = cfg

				goutil.setActive(cell.go, true)

				cell.txt.text = cfg.showTip == 0 and "" or lang(cfg.showTip)

				RedPointController.instance:regRedPoint(cell.redPoint, unpack(string.split(cfg.redpointId or "", "#")))
			end
		end
	end
end

function YearCardPreheatHud2023View:_onClickGotoBtn(id)
	if self._enterList[id] then
		local cfg = self._enterList[id].cfg

		if cfg then
			local gotoStr = cfg.gotoStr

			if not string.nilorempty(gotoStr) then
				GotoMgr.gotoByString(gotoStr)

				return
			end

			local showMatStr = cfg.showReward

			if not string.nilorempty(showMatStr) then
				CommonTipsMgr.instance:openTipsByConfStr(self._enterList[id].go, showMatStr)
			end
		end
	end
end

function YearCardPreheatHud2023View:_onClickPoster()
	UIStateManager.instance:push(ViewName.YearCardPoster2023View)
end

function YearCardPreheatHud2023View:_onClickInfo()
	PetbookController.instance:openPetinfoView(self.skinId)
end

function YearCardPreheatHud2023View:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.skinId)
	end
end

function YearCardPreheatHud2023View:_getKey()
	return ViewName.YearCardPoster2023View .. "_show_poster"
end

return YearCardPreheatHud2023View
