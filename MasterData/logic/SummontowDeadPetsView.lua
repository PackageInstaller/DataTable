-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowDeadPetsView.lua

module("logic.extensions.summontower.view.SummontowDeadPetsView", package.seeall)

local SummontowDeadPetsView = class("SummontowDeadPetsView", ViewComponent)

function SummontowDeadPetsView:buildUI()
	SummontowDeadPetsView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._cells = {}
	self._cells[1] = self:getGo("petGroup/cell")
end

function SummontowDeadPetsView:bindEvents()
	SummontowDeadPetsView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function SummontowDeadPetsView:unbindEvents()
	SummontowDeadPetsView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function SummontowDeadPetsView:onEnter()
	SummontowDeadPetsView.super.onEnter(self)

	self._petList = self:getFirstParam()
	self._callback = self:getOpenParam()[2]
	self._callbackObj = self:getOpenParam()[3]

	self:_refreshPetsView()
end

function SummontowDeadPetsView:_refreshPetsView()
	local cnt = #self._petList

	while cnt > #self._cells do
		table.insert(self._cells, UGUIToolHelper.AddChild(self._cells[1].transform.parent.gameObject, self._cells[1]))
	end

	for i = 1, cnt do
		local go = self._cells[i]

		go:SetActive(true)

		local petId = self._petList[i]
		local pet = goutil.findChild(go, "pet/item")
		local txtName = goutil.findChildTextComponent(go, "pet/txtName")
		local txtLevel = goutil.findChildTextComponent(go, "pet/txtLevel")
		local petCo = SummontowerConfig.instance:getPetCo(petId)

		txtName.text = petCo.creepsName
		txtLevel.text = "Lv:" .. tostring(petCo.lv)

		local item = MatType.Pet .. ":" .. petCo.raceId .. ":" .. petCo.lv

		MaterialMgr.resetAll(pet)

		local proxy = MaterialMgr.setCellByCfg(item, pet)

		if proxy then
			local curFaceId = checknumber(petCo.faceId)

			if curFaceId == 0 then
				curFaceId = checknumber(petCo.raceId)
			end

			proxy.binder:setStars(petCo.awakenLv)
			proxy.binder:setSkin(curFaceId)
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				local fightingPower = FightingPowerPetMo.New(petCo.raceId, level)

				fightingPower:fromChallengeCreepCo(petCo, cfgs)

				local petMo = {
					contractSkillId = 0,
					raceId = petCo.raceId,
					curFaceId = curFaceId,
					level = level,
					name = petCo.creepsName,
					_curZdl = fightingPower:getFightingPower(),
					awakenLv = petCo.awakenLv
				}

				CommonTipsMgr.instance:showPetTips(petMo)
			end)
		end
	end

	for i = cnt + 1, #self._cells do
		local go = self._cells[i]

		go:SetActive(false)
	end
end

function SummontowDeadPetsView:onExit()
	SummontowDeadPetsView.super.onExit(self)

	for i = 1, #self._cells do
		local go = self._cells[i]
		local pet = goutil.findChild(go, "pet/item")

		MaterialMgr.resetAll(pet)
	end

	self._callback = nil
	self._callbackObj = nil
end

function SummontowDeadPetsView:_onClickSure()
	local callback = self._callback
	local callbackObj = self._callbackObj

	self:close()

	if callback then
		self._callback(callbackObj)
	end
end

return SummontowDeadPetsView
