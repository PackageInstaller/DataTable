-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonbossguideView.lua

module("logic.extensions.season.view.SeasonbossguideView", package.seeall)

local SeasonbossguideView = class("SeasonbossguideView", ViewComponent)

function SeasonbossguideView:ctor()
	SeasonbossguideView.super.ctor(self)
end

function SeasonbossguideView:unbindEvents()
	SeasonbossguideView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.mask)
	GameUtil.rmClickHandler(self.btnGoto)
	GameUtil.rmClickHandler(self.btnPossport)
	GameUtil.rmClickHandler(self.btnSkill)
	GameUtil.rmClickHandler(self.btnIntroduce)
end

function SeasonbossguideView:bindEvents()
	SeasonbossguideView.super.bindEvents(self)
	GameUtil.addClickHandler(self.mask, self.close, self)
	GameUtil.addClickHandler(self.btnGoto, self.onClickGoto, self)
	GameUtil.addClickHandler(self.btnPossport, self.onClickPossport, self)
	GameUtil.addClickHandler(self.btnSkill, self.onClickSkill, self)
	GameUtil.addClickHandler(self.btnIntroduce, self.onClickIntroduce, self)
end

function SeasonbossguideView:buildUI()
	SeasonbossguideView.super.buildUI(self)

	self.btnGoto = self:getGo("btnGoto")
	self.btnPossport = self:getGo("btnPossport")
	self.mask = self:getGo("mask")
	self.pet = self:getGo("pet/con")
	self.btnSkill = self:getGo("petInfo/btnSkill")
	self.btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self.pointRare = self:getGo("petInfo/pointRare")
	self.txtName = self:getTxt("petInfo/txtName")
	self.txtGoto = self:getTxt("btnGoto/txt")
	self.petInfo = self:getGo("petInfo")
	self.txtTitle = self:getTxt("txtTitle")
	self.txtDesc = self:getTxt("txtDesc")
	self.txtTip = self:getTxt("txtTip")
end

function SeasonbossguideView:onExit()
	SeasonbossguideView.super.onExit(self)
	self.petPhoto:clear()

	if self.pointRare then
		MaterialMgr.resetAll(self.pointRare)
	end
end

function SeasonbossguideView:onEnter()
	SeasonbossguideView.super.onEnter(self)
	self:onRefreshUI()
end

function SeasonbossguideView:onRefreshUI()
	local bossMo = SeasonModel.instance.bossMo
	local phaseId = bossMo.phaseId
	local cfg = SeasonConfig.instance:getBossPanenStep(phaseId)

	self.txtTitle.text = cfg.title

	local pevCfg = SeasonConfig.instance:getSeasonPVEConfig(SeasonModel.instance:getSeasonId())
	local doppelgangerPhaseId = checknumber(pevCfg.bossDoppelgangerPhaseId)

	if phaseId == doppelgangerPhaseId then
		local gridIds = SeasonPVEBossController.instance:getDoppelgangerReadOnlyPointIds()
		local progress = bossMo:getDoppelgangerLockCount()

		self.txtDesc.text = (cfg.content or "") .. langPara("(%s/%s)", progress, #gridIds)
	elseif not cfg.content then
		self.txtDesc.text = ""
	end

	self.txtGoto.text = cfg.btnDesc
	self.raceId = SeasonConfig.instance:getCommonValue("BOSS_GUIDE_SKINID", true)
	self.petPhoto = PetPhotoShow.Get(self.pet)

	self.petPhoto:showPetEffect(self.raceId, true, 2.2)
	self.petPhoto:setPetLocalPosAndScale(-1.8, -1.5)

	local skinId = self:getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self.pointRare)

		local cfg = PetSkinConfig.instance:getPetSkinCfg(self:getSkinId())

		if cfg then
			self.txtName.text = cfg.skinName
		end
	end
end

function SeasonbossguideView:getSkinId()
	if self._skinId == nil then
		self._skinId = SeasonConfig.instance:getCommonValue("BOSS_GUIDE_SKINID", true)
	end

	return self._skinId
end

function SeasonbossguideView:getRaceId()
	if self._raceId == nil then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(self:getSkinId())

		if cfg then
			self._raceId = cfg.raceId or 0
		end
	end

	return self._raceId
end

function SeasonbossguideView:onClickPossport()
	self:close()
	UIStateManager.instance:push(ViewName.SeasonPassPortTabView)
end

function SeasonbossguideView:onClickGoto()
	local bossMo = SeasonModel.instance.bossMo
	local phaseId = bossMo.phaseId
	local cfg = SeasonConfig.instance:getBossPanenStep(phaseId)

	if not string.nilorempty(cfg.jumpTo) then
		GotoMgr.gotoByString(cfg.jumpTo)
	else
		local teamMo = SeasonTeamsModel.instance:getCurrTeamMo()
		local list = {}
		local gridIds = string.splitToNumber(cfg.grids or "", "#")

		for i, v in ipairs(gridIds) do
			local gx, gy = SeasonPathFindingDataModel.instance:id2Grid(v)
			local obj = {}

			obj.x = gx or 0
			obj.y = gy or 0

			table.insert(list, obj)
		end

		SeasonController.instance:moveCaremaFromTeamToGridList(teamMo, list)
	end

	self:close()
end

function SeasonbossguideView:onClickSkill()
	local raceId = self:getRaceId()
	local skinId = self:getSkinId()

	if raceId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	end
end

function SeasonbossguideView:onClickIntroduce()
	PetbookController.instance:openPetinfoView(self:getRaceId())
end

return SeasonbossguideView
