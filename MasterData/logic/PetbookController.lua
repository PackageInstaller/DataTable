-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/controller/PetbookController.lua

module("logic.extensions.handbook.controller.PetbookController", package.seeall)

local PetbookController = class("PetbookController", BaseController)

PetbookController.NotifyName_HandBookPlayPetAnim = "handbookplaypetanim"
PetbookController.NotifyName_HandBookHandBookOpenPetInfoView = "handbookopenpetinfoview"
PetbookController.NotifyName_HandBookHandBookOpenSkinView = "handbookopenskinview"
PetbookController.NotifyName_HandBookHandBookOpenPreviewBattle = "handbookopenpetpreviewbattle"
PetbookController.SortType = {
	Default = "Default",
	Awaken = "Awaken"
}
PetbookController.SortTypeDetail = {
	[PetbookController.SortType.Default] = {
		cellIdx = 1,
		name = "默认"
	},
	[PetbookController.SortType.Awaken] = {
		cellIdx = 2,
		name = "觉醒"
	}
}

function PetbookController:ctor()
	return
end

function PetbookController:onInit()
	self:onReset()
end

function PetbookController:onReset()
	self._skip = nil

	GlobalDispatcher:removeListener(GlobalNotify.BattleEnd, self._recoveryChaoSha, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleEnd, self._recoveryChaoSha, self)
	GlobalDispatcher:addListener(PetbookController.NotifyName_HandBookHandBookOpenPetInfoView, self.gotoPetinfoView, self)
	GlobalDispatcher:addListener(PetbookController.NotifyName_HandBookHandBookOpenSkinView, self.gotoSkinView, self)
	GlobalDispatcher:addListener(PetbookController.NotifyName_HandBookHandBookOpenPreviewBattle, self.gotoPreviewBattle, self)
	self:resetDataToZero()
end

function PetbookController:gotoPreviewBattle(params)
	local skinId = checknumber(params[1])

	self:previewBattleWithSkinId(skinId)
end

function PetbookController:previewBattle(raceId, skinId, isCloseOtherView)
	raceId = checknumber(raceId)
	skinId = checknumber(skinId)

	if not isCloseOtherView then
		UIJumper.instance:saveCurStack()
	end

	self:_openChaoSha()
	BattleFacade.instance:sendPreviewPetBattle(raceId, skinId)
end

function PetbookController:previewBattleWithSkinId(skinId, isCloseOtherView)
	local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	if cfg then
		local raceId = cfg.raceId

		self:previewBattle(raceId, skinId)
	end
end

function PetbookController:gotoPetinfoView(params)
	local raceId = checknumber(params[1])

	self:openPetinfoView(raceId)
end

function PetbookController:gotoSkinView(params)
	local skinId = checknumber(params[1])

	self:openSkinViewNoSetAttr(skinId)
end

function PetbookController:openPetinfoView(raceId)
	raceId = checknumber(raceId)

	ViewAutoShowController.instance:saveCurModalView()
	PetbookModel.instance:setAttrAndRare()

	local petDetail = HandbookConfig.instance:getPetDetailsCfgById(raceId)

	if petDetail and petDetail.unproved == 1 then
		PetbookModel.instance:getPetDatas(nil, 5)
	else
		PetbookModel.instance:getPetDatas()
	end

	if raceId > 0 then
		local bFound = PetbookModel.instance:setSelectedPet(raceId)

		if bFound then
			self:openPetinfoViewNoSetAttr(raceId)
		else
			FloatWordMgr.instance:show(lang("该精灵图鉴未开放"))
		end
	end
end

function PetbookController:openPetinfoViewNoSetAttr(raceId)
	ViewAutoShowController.instance:saveCurModalView()

	local list = PetbookModel.instance:getFilterPetList()

	PetbookModel.instance:setSelectedPet(raceId)
	UIStateManager.instance:push(ViewName.HandbookpetinfoView, raceId, list)
end

function PetbookController:openSkinViewNoSetAttr(raceId)
	PetManualAgent.instance:sendGetSkinManualInfoReq(function()
		ViewAutoShowController.instance:saveCurModalView()

		local list = PetbookModel.instance:getFilterSkinList()

		PetbookModel.instance:setSelectedPet(raceId)
		UIStateManager.instance:push(ViewName.HandbookSkinView, raceId, list)
	end)
end

function PetbookController:_openChaoSha()
	self._skip = BattleModel.instance:getAutoSkipUtilSkill()
	AMPlayer.autoJumpSkill = false

	BattleModel.instance:setAutoSkipUtilSkill(false)
end

function PetbookController:_recoveryChaoSha()
	if self._skip ~= nil then
		AMPlayer.autoJumpSkill = self._skip
		self._skip = nil

		BattleModel.instance:setAutoSkipUtilSkill(self._skip)
	end
end

function PetbookController:resetDataToZero()
	PetbookModel.instance:setPetbookTab(nil)
	PetbookModel.instance:setAttrAndRare(nil, nil)
	PetbookModel.instance:setSkinQuality(nil)
	PetbookModel.instance:setPage(nil)
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PET_FILES)
end

PetbookController.instance = PetbookController.New()

return PetbookController
