-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/tianmanking/TianmanKingMissionFmtLeftView.lua

module("logic.extensions.timelimitedchallenge.view.tianmanking.TianmanKingMissionFmtLeftView", package.seeall)

local TianmanKingMissionFmtLeftView = class("TianmanKingMissionFmtLeftView", FormationLeftViewBase)

function TianmanKingMissionFmtLeftView:onEnter()
	local openParam = self:getOpenParam()

	self._challengeType, self._challengeId = openParam[1], openParam[2]

	TianmanKingMissionFmtLeftView.super.onEnter(self)
	goutil.setActive(self._Btn_Formation.gameObject, false)
	self:_setActiveBtnFormationUse(self._challengeType ~= 2)
end

function TianmanKingMissionFmtLeftView:_saveCurrFmt()
	if self._challengeType == 2 then
		-- block empty
	else
		TianmanKingMissionFmtLeftView.super._saveCurrFmt(self)
	end
end

function TianmanKingMissionFmtLeftView:_OnClickBtnContractPet()
	if self._challengeType == 2 then
		-- block empty
	else
		TianmanKingMissionFmtLeftView.super._OnClickBtnContractPet(self)
	end
end

function TianmanKingMissionFmtLeftView:getSummonMasterPets()
	if self._challengeType == 2 then
		local helpPets = TianmanKingModel.instance:getAllHelpPets(self._challengeId) or {}
		local map = {}

		for _, v in ipairs(helpPets) do
			if checknumber(v.summonedPetId) > 0 then
				map[v.raceId] = v
			end
		end

		local masterMoList = {}
		local cusMasterMo
		local positions = self:_getCurPositions()

		for i, v in ipairs(positions) do
			if v > 0 then
				local petMo = self:_getPet(v)

				if petMo and map[petMo.raceId] then
					table.insert(masterMoList, petMo)

					cusMasterMo = petMo
				end
			end
		end

		return masterMoList, cusMasterMo
	else
		local masterMoList, cusMasterMo = TianmanKingMissionFmtLeftView.super.getSummonMasterPets(self)

		return masterMoList, cusMasterMo
	end
end

function TianmanKingMissionFmtLeftView:getSummonPetList()
	if self._challengeType == 2 then
		return TianmanKingModel.instance:getAllHelpPets(self._challengeId) or {}
	else
		return (BagPetsController.instance:getFightBagPet())
	end
end

function TianmanKingMissionFmtLeftView:_getItemSeatCls()
	if self._challengeType == 2 then
		return TianmanKingItemSeat
	else
		return TianmanKingMissionFmtLeftView.super._getItemSeatCls(self)
	end
end

function TianmanKingMissionFmtLeftView:_OnClickSeat(go, eventData)
	if self._dragSeat then
		self._dragSeat:ShowPet()
	end

	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat or not itemSeat:IsOpen() then
		return
	end

	if not itemSeat:isHasPet() then
		return
	end

	local petId = itemSeat:GetData()
	local petMo = self:_getPet(petId)
	local bagPetMo = BagPetsController.instance:getPet(petId)

	if not bagPetMo then
		petMo = clone(petMo)
		petMo.hideZdl = true
	end

	CommonTipsMgr.instance:showPetTips(petMo)
end

function TianmanKingMissionFmtLeftView:_getPet(petId)
	if self._challengeType == 2 then
		return TianmanKingModel.instance:getPetMo(petId)
	else
		return TianmanKingMissionFmtLeftView.super._getPet(self, petId)
	end
end

function TianmanKingMissionFmtLeftView:_getCurFormId()
	if self._challengeType == 2 then
		return 10
	else
		return TianmanKingMissionFmtLeftView.super._getCurFormId(self)
	end
end

function TianmanKingMissionFmtLeftView:_getCurFormation()
	if self._challengeType == 2 then
		local fmo = TianmanKingModel.instance:getForm()

		fmo.isBanMySummonPet = true

		return fmo
	else
		return TianmanKingMissionFmtLeftView.super._getCurFormation(self)
	end
end

return TianmanKingMissionFmtLeftView
