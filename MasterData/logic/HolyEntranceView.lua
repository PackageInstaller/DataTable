-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/HolyEntranceView.lua

module("logic.extensions.kingway.view.HolyEntranceView", package.seeall)

local HolyEntranceView = class("HolyEntranceView", ViewComponent)

function HolyEntranceView:ctor()
	HolyEntranceView.super.ctor(self)
end

function HolyEntranceView:buildUI()
	HolyEntranceView.super.buildUI(self)

	local spriteIconGo = self:getGo("spriteIconGo")

	self._nameTxt = goutil.findChildTextComponent(spriteIconGo, "nameTxt")
	self._stageGo = goutil.findChild(spriteIconGo, "stageGo")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(spriteIconGo, "skillBtn")
	self._explainBtn = Framework.ButtonAdapter.GetFrom(spriteIconGo, "explainBtn")
	self._attrIma = goutil.findChildComponent(spriteIconGo, "attrIma", "UIImageSpriteChange")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._gotoBtn = self:getBtn("gotoBtn")
	self._redpointGo = self:getGo("gotoBtn/redpointGo")
	self._effPos = self:getGo("viewEffPos")
	self._nameTxt.text = ""

	self._redpointGo:SetActive(false)
end

function HolyEntranceView:bindEvents()
	HolyEntranceView.super.bindEvents(self)
	self._tipsBtn:AddClickListener(function()
		ViewMgr.instance:open(ViewName.RulesView, "holychall")
	end, self)
	self._gotoBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.HolyChall)
	end, self)
end

function HolyEntranceView:unbindEvents()
	HolyEntranceView.super.unbindEvents(self)
	self._tipsBtn:RemoveClickListener()
	self._gotoBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._explainBtn:RemoveClickListener()
end

function HolyEntranceView:onExit()
	MaterialMgr.resetAll(self._stageGo)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil
end

function HolyEntranceView:destroyUI()
	HolyEntranceView.super.destroyUI(self)
end

function HolyEntranceView:onEnter()
	HolyEntranceView.super.onEnter(self)

	local matId = 10027
	local skinId = 10027
	local cfg = MaterialMgr.getMatCfg(MatType.Pet, matId)
	local racdIndex = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	self._attrIma:SetState(racdIndex - 1)

	self._nameTxt.text = cfg.name

	local proxy = MaterialMgr.setCell(MatType.Rare, matId, self._stageGo)

	proxy.binder:setRare(CharacterConfig.instance:getInitRare(matId))
	self._skillBtn:AddClickListener(function()
		SevenDaysModel.instance.openBonusName = ViewName.HolyEntrance

		PetbookController.instance:previewBattle(matId)
	end, self)
	self._explainBtn:AddClickListener(function()
		SevenDaysModel.instance.openBonusName = ViewName.HolyEntrance

		PetbookController.instance:openPetinfoView(matId)
	end, self)

	local isShow = RedPointModel.instance:isActive(RedPointModel.ID_HOLYCHALL2)

	self._redpointGo:SetActive(isShow)

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self._effPos, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self._effPos.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
end

return HolyEntranceView
