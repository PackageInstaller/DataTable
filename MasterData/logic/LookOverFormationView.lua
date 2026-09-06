-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/LookOverFormationView.lua

module("logic.extensions.dragonlords.view.LookOverFormationView", package.seeall)

local LookOverFormationView = class("LookOverFormationView", ViewComponent)

function LookOverFormationView:ctor()
	LookOverFormationView.super.ctor(self)
end

function LookOverFormationView:unbindEvents()
	LookOverFormationView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function LookOverFormationView:bindEvents()
	LookOverFormationView.super.bindEvents(self)
	self._btnSure:AddClickListener(function()
		self:close()
	end)
	self._btnClose:AddClickListener(function()
		self:close()
	end)
end

function LookOverFormationView:onExit()
	LookOverFormationView.super.onExit(self)
	self:_clearPetList()
end

function LookOverFormationView:buildUI()
	LookOverFormationView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("Btn_Close")
	self._txtPass = self:getTxt("txtPass")
	self._formation = self:getGo("info/formation")
	self._petList = {}

	for i = 1, 9 do
		local obj = goutil.findChild(self._formation, string.format("cell_%d/con", i))

		MaterialMgr.resetAll(obj)
		obj.transform.parent.gameObject:SetActive(false)

		self._petList[i] = obj
	end
end

function LookOverFormationView:onEnter()
	LookOverFormationView.super.onEnter(self)

	local index = self:getFirstParam()

	self:initPetList(index)
end

function LookOverFormationView:initPetList(index)
	local cfg = DragonLordsConfig.instance:getLimitChallengeCfg(index)
	local creepCfgs = DragonLordsConfig.instance:getCreepsMasterById(cfg.creepsMasterId)

	for i, v in pairs(creepCfgs) do
		local raceId, posId = v.raceId, v.posId
		local obj = self._petList[posId]

		obj.transform.parent.gameObject:SetActive(true)
		MaterialMgr.setIcon(obj, MatType.PET_SKIN, (checknumber(v.faceId) > 0 or nil) and checknumber(v.faceId))
		GameUtil.asBtn(obj):RemoveClickListener()
		GameUtil.asBtn(obj):AddClickListener(function()
			local petMo = FightingPowerPetMo.New()

			petMo:fromChallengeCreepCo(v, creepCfgs)

			petMo.creepName = v.creepName

			CommonTipsMgr.instance:showPetTips(petMo)
		end)
	end

	self._txtPass.text = string.format("通过条件:%s", cfg.levelDescription)
end

function LookOverFormationView:_clearPetList()
	for k, obj in pairs(self._petList) do
		MaterialMgr.resetAll(obj)
		obj.transform.parent.gameObject:SetActive(false)
	end
end

return LookOverFormationView
