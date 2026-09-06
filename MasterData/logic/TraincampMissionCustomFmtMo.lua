-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampdefense/model/TraincampMissionCustomFmtMo.lua

module("logic.extensions.traincampdefense.model.TraincampMissionCustomFmtMo", package.seeall)

local TraincampMissionCustomFmtMo = class("TraincampMissionCustomFmtMo", ICustomFmtMo)

function TraincampMissionCustomFmtMo:initSaveHandler()
	self.setSaveHandler(self, function()
		return
	end, self)
end

function TraincampMissionCustomFmtMo:initParams()
	self.isShowTab = false
	self.ruleDescStr = "击败对方所有精灵"
end

function TraincampMissionCustomFmtMo:initPetList()
	local pets = BagPetsController.instance:getFightBagPet()

	for i, petMo in ipairs(pets) do
		self:addPetToList(petMo)
	end
end

function TraincampMissionCustomFmtMo:refreshPetList(changePetMoMap)
	for petId, petMo in pairs(changePetMoMap) do
		self:updatePetMo(petMo)
	end
end

function TraincampMissionCustomFmtMo:initFightHandler()
	local function handler()
		local myForm = self:getCurFormation():createFormPb()
		local fmtMo = FormationMO.New(function(petId)
			return self._petMos[petId]
		end)

		fmtMo:SetData(self._otherPlayerView.curForm)

		local otherForm = fmtMo:createFormPb()

		UIJumper.instance:pushOneStack(ViewName.PkmainView)
		UIJumper.instance:pushOneStack(ViewName.TraincampdefenselistView)
		TrainCampDefenseFormAgent.instance:sendPM_DF_ChallengeReq(self._otherPlayerId, myForm, otherForm, self._defenseFormZdl)
	end

	self:setFightHandler(handler, nil)
end

function TraincampMissionCustomFmtMo:setOtherPlayerView(otherPlayerView, otherPlayerId, defenseFormZdl, userName)
	self.topTitleStr = userName
	self._otherPlayerView = otherPlayerView
	self._otherPlayerId = otherPlayerId
	self._defenseFormZdl = defenseFormZdl
	self._fakeMonsterCo = otherPlayerView.curForm.extParams
	self._other_teams = {}
	self._oterh_formations = {}
	self._petMos = {}

	for i, v in ipairs(otherPlayerView.petSimpleView) do
		local petMo = BagPetMo.New()

		petMo:initBaseView(v)

		self._petMos[v.petId] = petMo
	end

	for i, petId in pairs(otherPlayerView.curForm.pos) do
		if petId and checknumber(petId) > 0 then
			local pet = self._petMos[petId]

			pet.position = i

			table.insert(self._other_teams, pet)

			self._oterh_formations[i] = pet
		end
	end
end

function TraincampMissionCustomFmtMo:getMonsterConfigList()
	return
end

function TraincampMissionCustomFmtMo:getFmtInfoConfig()
	return self._fakeMonsterCo
end

function TraincampMissionCustomFmtMo:getTeamAndFormation()
	ArraySort.sortOn(self._other_teams, "position")

	return self._other_teams, self._oterh_formations
end

return TraincampMissionCustomFmtMo
