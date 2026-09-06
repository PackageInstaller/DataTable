-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/view/DivineMiZongClgFmtExtisonView.lua

module("logic.extensions.divinemizongclg.view.DivineMiZongClgFmtExtisonView", package.seeall)

local DivineMiZongClgFmtExtisonView = class("DivineMiZongClgFmtExtisonView", ViewComponent)

function DivineMiZongClgFmtExtisonView:ctor()
	DivineMiZongClgFmtExtisonView.super.ctor(self)
end

function DivineMiZongClgFmtExtisonView:buildUI()
	DivineMiZongClgFmtExtisonView.super.buildUI(self)

	self._btnBuff = self:getGo("btnBuff")
	self._effRootBuff = self:getGo("btnBuff/effRoot")
	self._petCon = self:getGo("btnBuff/petCon")
	self._iconBuff = self:getGo("btnBuff/icon")
	self._tagView = self:getGo("tagView")
end

function DivineMiZongClgFmtExtisonView:bindEvents()
	DivineMiZongClgFmtExtisonView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function DivineMiZongClgFmtExtisonView:unbindEvents()
	DivineMiZongClgFmtExtisonView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnBuff)
end

function DivineMiZongClgFmtExtisonView:onEnter()
	DivineMiZongClgFmtExtisonView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._fmtMo = params[1]
	self._activityId = self._fmtMo:getActivityId()
	self._clgMo = DivineMiZongClgController.instance:getClgMo(self._activityId)

	self.addGEvent(self, GlobalNotify.DivineMiZongClg_UpdateFmtCenterPet, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.DivineMiZongClg_ForbitStartClg, self._divineMiZongClg_ForbitStartClg, self)
	self:_onUpdate()
end

function DivineMiZongClgFmtExtisonView:onExit()
	DivineMiZongClgFmtExtisonView.super.onExit(self)
	MaterialMgr.clearIcon(self._petCon)
end

function DivineMiZongClgFmtExtisonView:_divineMiZongClg_ForbitStartClg()
	self:playViewEffectUniGo("common/fx_ui_zhiyin_quan_03.prefab", self._effRootBuff, self._effRootBuff, false)
end

function DivineMiZongClgFmtExtisonView:_onUpdate()
	local centerPosId = self._fmtMo:getCenterPosId()

	for idx = 1, self._tagView.transform.childCount do
		local mainGo = self._tagView.transform:GetChild(idx - 1).gameObject

		GameUtil.SetActive(mainGo, idx == centerPosId)
	end

	local centerPetId = self._fmtMo:getCenterPetId()
	local petMo = self._fmtMo:getPetMoById(centerPetId)

	if petMo then
		MaterialMgr.setIcon(self._petCon, MatType.Pet, petMo.curFaceId, nil, nil)
	else
		MaterialMgr.clearIcon(self._petCon)
	end

	GameUtil.SetActive(self._petCon, petMo ~= nil)
	GameUtil.SetActive(self._iconBuff, petMo == nil)
end

function DivineMiZongClgFmtExtisonView:_onClickBuff()
	UIStateManager.instance:push(ViewName.DivineMiZongClgFmtBuffView, self._fmtMo)
end

return DivineMiZongClgFmtExtisonView
