-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarTowerSignView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarTowerSignView", package.seeall)

local GodStatuesWarTowerSignView = class("GodStatuesWarTowerSignView", ViewComponent)

function GodStatuesWarTowerSignView:ctor()
	GodStatuesWarTowerSignView.super.ctor(self)
end

function GodStatuesWarTowerSignView:buildUI()
	GodStatuesWarTowerSignView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local pillarScrView = goutil.findChild(self.mainGO, "pillarCol/pillarScrView")
	local pillarScrCell = goutil.findChild(self.mainGO, "pillarCol/pillarScrCell")

	self._pillarScrollList = ScrollerList.create(pillarScrView, pillarScrCell, GameUtil.handler(self._updatePillarCell, self), GameUtil.handler(self._clearPillarCell, self))
end

function GodStatuesWarTowerSignView:bindEvents()
	GodStatuesWarTowerSignView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function GodStatuesWarTowerSignView:unbindEvents()
	GodStatuesWarTowerSignView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GodStatuesWarTowerSignView:onEnter()
	GodStatuesWarTowerSignView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._tierId = checknumber(params[2])
	self._seatIdx = checknumber(params[3])

	local isInTime = GodStatuesWarController.instance:isInSeasonTime(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d )", self._seasonId))
		self:close()

		return
	end

	self._seasonData = GodStatuesWarConfig.instance:getNfbSeasonData(self._seasonId)
	self._stepMgr = GodStatuesWarController.instance:gswStepMgrOnEnter(self._seasonId)
	self._isFamilyChief = GodStatuesWarController.instance:isFamilyChief()

	self.addGEvent(self, GlobalNotify.GodStatuesWarStepChange, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetDivinePillarMapRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleSetFlagRes, self._onUpdate, self)
	self:_onUpdate()
end

function GodStatuesWarTowerSignView:onExit()
	GodStatuesWarTowerSignView.super.onExit(self)
	self:_onClear()

	if self._stepMgr then
		GodStatuesWarController.instance:gswStepMgrOnExit(self._seasonId)

		self._stepMgr = nil
	end
end

function GodStatuesWarTowerSignView:_onUpdate()
	local stepInterval = self._stepMgr:getStepInterval(self._stepMgr:getNewestStep())

	if stepInterval ~= GswEnum.StepInterval_Bat then
		local text = "不在战斗阶段内"

		local function func()
			return
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)
		self:close()

		return
	end

	self:_onUpdateData()
	self:_onUpdateUI()
end

function GodStatuesWarTowerSignView:_onUpdateData()
	return
end

function GodStatuesWarTowerSignView:_onUpdateUI()
	self:_onUpdatePillarColUI()
end

function GodStatuesWarTowerSignView:_onClear()
	self:_onClearPillarColUI()
end

function GodStatuesWarTowerSignView:_onUpdatePillarColUI()
	local pillarIdList = {}
	local cfg = GodStatuesWarConfig.instance:getNfbPillarEntryCfg(self._seasonId)

	for _, data in ipairs(cfg) do
		local isEmpty = GodStatuesWarController.instance:isEmptyPillar(self._seasonId, data.pillarId)

		if not isEmpty then
			table.insert(pillarIdList, data.pillarId)
		end
	end

	self._pillarScrollList:reloadData(pillarIdList)
end

function GodStatuesWarTowerSignView:_onClearPillarColUI()
	self._pillarScrollList:dispose()
end

function GodStatuesWarTowerSignView:_updatePillarCell(view, cell, pillarId, tag)
	local data = GodStatuesWarConfig.instance:getNfbPillarInfoData(self._seasonId, pillarId)
	local familyId = GodStatuesWarController.instance:getFamilyIdInGroup(self._seasonId, pillarId)
	local familyName = GodStatuesWarController.instance:getFamilyNameInGroup(self._seasonId, pillarId)
	local energyValue = GodStatuesWarController.instance:getEnergyInGroup(self._seasonId, pillarId)
	local isAttack = GodStatuesWarController.instance:isAttackFlagOfFamily(self._seasonId, familyId)
	local isDefense = GodStatuesWarController.instance:isNoAttackFlagOfFamily(self._seasonId, familyId)
	local isMyPillar = GodStatuesWarController.instance:isMyPillar(self._seasonId, pillarId)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "iconGo")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtEnergy = goutil.findChildTextComponent(mainGo, "txtEnergy")
	local btnAttack = goutil.findChild(mainGo, "btnAttack")
	local btnDefense = goutil.findChild(mainGo, "btnDefense")

	txtName.text = familyName
	txtEnergy.text = string.format("家族能量：<color=#20b376>%s</color>", energyValue)

	GameUtil.SetGray(btnAttack, not isAttack or isMyPillar)
	GameUtil.SetGray(btnDefense, not isDefense or isMyPillar)
	self:_loadBigBg(iconGo, string.format("ui/bigbg/%s", data.midIcon))
	GameUtil.addClickHandler(btnAttack, GameUtil.handler(self._onClickPillarCellSignBtn, self, pillarId, GswEnum.SignType_Attack))
	GameUtil.addClickHandler(btnDefense, GameUtil.handler(self._onClickPillarCellSignBtn, self, pillarId, GswEnum.SignType_Defense))
end

function GodStatuesWarTowerSignView:_clearPillarCell(cell)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "iconGo")
	local btnAttack = goutil.findChild(mainGo, "btnAttack")
	local btnDefense = goutil.findChild(mainGo, "btnDefense")

	self:_unLoadBigBg(iconGo)
	GameUtil.rmClickHandler(btnAttack)
	GameUtil.rmClickHandler(btnDefense)
end

function GodStatuesWarTowerSignView:_onClickPillarCellSignBtn(pillarId, signType)
	local familyId = GodStatuesWarController.instance:getFamilyIdInGroup(self._seasonId, pillarId)

	if familyId <= 0 then
		return
	end

	if GodStatuesWarController.instance:isMyPillar(self._seasonId, pillarId) then
		FloatWordMgr.instance:show("不能标记自己所在家族")

		return
	end

	self._attackFlagFamilyId = self._attackFlagFamilyId or 0
	self._noAttackFlagFamilyId = self._noAttackFlagFamilyId or 0

	if signType == GswEnum.SignType_Attack then
		if self._attackFlagFamilyId == familyId then
			self._attackFlagFamilyId = 0
		else
			self._attackFlagFamilyId = familyId

			if self._noAttackFlagFamilyId == familyId then
				self._noAttackFlagFamilyId = 0
			end
		end
	elseif signType == GswEnum.SignType_Defense then
		if self._noAttackFlagFamilyId == familyId then
			self._noAttackFlagFamilyId = 0
		else
			self._noAttackFlagFamilyId = familyId

			if familyId == self._attackFlagFamilyId then
				self._attackFlagFamilyId = 0
			end
		end
	end

	GodStatuesWarController.instance:sendPM_NewFamilyBattleSetFlagReq(self._seasonId, self._attackFlagFamilyId, self._noAttackFlagFamilyId)
end

function GodStatuesWarTowerSignView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function GodStatuesWarTowerSignView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

return GodStatuesWarTowerSignView
