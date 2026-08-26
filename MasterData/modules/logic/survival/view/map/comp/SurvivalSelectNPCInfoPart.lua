-- chunkname: @modules/logic/survival/view/map/comp/SurvivalSelectNPCInfoPart.lua

module("modules.logic.survival.view.map.comp.SurvivalSelectNPCInfoPart", package.seeall)

local SurvivalSelectNPCInfoPart = class("SurvivalSelectNPCInfoPart", ShelterManagerInfoView)

function SurvivalSelectNPCInfoPart:initNpc()
	SurvivalSelectNPCInfoPart.super.initNpc(self)

	self.btnInTeam = gohelper.findChildButtonWithAudio(self.goNpc, "bottom/#btn_inteam")
	self.btnOutTeam = gohelper.findChildButtonWithAudio(self.goNpc, "bottom/#btn_outteam")
end

function SurvivalSelectNPCInfoPart:addEventListeners()
	SurvivalSelectNPCInfoPart.super.addEventListeners(self)
	self.btnInTeam:AddClickListener(self._onClickInTeam, self)
	self.btnOutTeam:AddClickListener(self._onClickOutTeam, self)
end

function SurvivalSelectNPCInfoPart:removeEventListeners()
	SurvivalSelectNPCInfoPart.super.removeEventListeners(self)
	self.btnInTeam:RemoveClickListener()
	self.btnOutTeam:RemoveClickListener()
end

function SurvivalSelectNPCInfoPart:updateMo(npcMo, noBtn)
	self._npcMo = npcMo
	self.showId = npcMo.id
	self.otherParam = {}

	self:refreshNpc()
	gohelper.setActive(self.goNpcReset, false)
	gohelper.setActive(self.btnNpcGoto, false)
	gohelper.setActive(self.btnNpcReset, false)

	if noBtn then
		gohelper.setActive(self.btnInTeam, false)
		gohelper.setActive(self.btnOutTeam, false)

		return
	end

	local initGroup = SurvivalMapModel.instance:getInitGroup()
	local isInTeam = tabletool.indexOf(initGroup.allSelectNpcs, npcMo)
	local isFull = tabletool.len(initGroup.allSelectNpcs) == initGroup:getCarryNPCCount()
	local canSelect = true

	gohelper.setActive(self.btnInTeam, canSelect and not isFull and not isInTeam)
	gohelper.setActive(self.btnOutTeam, canSelect and isInTeam)
	ZProj.UGUIHelper.SetGrayscale(self.imgNpcChess.gameObject, not canSelect)

	self._initGroup = initGroup
end

function SurvivalSelectNPCInfoPart:_onClickInTeam()
	table.insert(self._initGroup.allSelectNpcs, self._npcMo)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnNPCInTeamChange)
end

function SurvivalSelectNPCInfoPart:_onClickOutTeam()
	tabletool.removeValue(self._initGroup.allSelectNpcs, self._npcMo)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnNPCInTeamChange)
end

return SurvivalSelectNPCInfoPart
