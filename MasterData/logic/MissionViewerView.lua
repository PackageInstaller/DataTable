-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionViewerView.lua

module(..., package.seeall)

local MissionViewerView = class("MissionViewerView", ViewComponent)

function MissionViewerView:_registerEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._Btn_HeroSkill:AddClickListener(self._onClickHeroSkill, self)

	for i = 1, 9 do
		local go = self._seats[i]
		local btn = Framework.ButtonAdapter.Get(go)

		btn:AddClickListener(function()
			local pet = self:_getPetBySeat(i)

			if pet then
				local petData = {
					raceId = pet.raceId,
					level = pet.lv,
					name = pet.name,
					_curZdl = pet.zdl
				}

				CommonTipsMgr.instance:showPetTips(petData)
			end
		end, nil)
	end
end

function MissionViewerView:_unregisterEvents()
	self._Btn_HeroSkill:RemoveClickListener()
	self._closeButton:RemoveClickListener()

	for i = 1, 9 do
		local go = self._seats[i]
		local btn = Framework.ButtonAdapter.Get(go)

		btn:RemoveClickListener()
	end
end

function MissionViewerView:buildUI()
	self:_buildFormation()

	self._maskBlock = self:getGo("MaskBlock")
	self._closeButton = self:getBtn("Close")
	self._teamPlayerName = self:getGo("Titlebg/teamPlayerName"):GetComponent("Text")
end

function MissionViewerView:_buildFormation()
	self._Nego_Character = self:getGo("Nego_Character")

	local _Nego_Left = self:getGo("Nego_Left")
	local _Nego_Select = goutil.findChild(_Nego_Left, "Nego_Select")

	self._Btn_HeroSkill = Framework.ButtonAdapter.GetFrom(_Nego_Select, "Btn_HeroSkill")
	self._Img_HeroSkill = goutil.findChild(_Nego_Select, "Btn_HeroSkill"):GetComponent("UIImageSpriteChange")
	self._heroSkillIcon = goutil.findChild(_Nego_Select, "Btn_HeroSkill/IconBg/Icon")
	self._Btn_ContractPet = goutil.findChild(_Nego_Select, "Btn_ContractPet"):GetComponent("UIImageSpriteChange")
	self._contactPetIcon = goutil.findChild(_Nego_Select, "Btn_ContractPet/IconBg/Icon")
	self._TxtC_ContractPet = goutil.findChild(self._Btn_ContractPet, "TxtC_ContractPet"):GetComponent("Text")

	local _Nego_TeamInfo = goutil.findChild(_Nego_Left, "Nego_TeamInfo")

	self._TxtC_Power = goutil.findChild(_Nego_TeamInfo, "Nego_TeamPower/TxtC_TeamPower"):GetComponent("ImgNumber")
	self._powerBtn = Framework.ButtonAdapter.GetFrom(_Nego_TeamInfo, "Nego_TeamPower")
	self._Btn_Formation = goutil.findChild(_Nego_Select, "Btn_Formation")
	self._TxtC_Formation = goutil.findChild(self._Btn_Formation.gameObject, "TxtC_Formation"):GetComponent("Text")
	self._formationIcon = goutil.findChild(self._Btn_Formation.gameObject, "IconBg/Icon"):GetComponent("UIImageSpriteChange")

	local _Nego_Seats = goutil.findChild(_Nego_Left, "Nego_Seats")

	self._seats = {}

	for i = 1, 9 do
		self._seats[i] = goutil.findChild(_Nego_Seats, string.format("Item_Seat_%d", i))
	end

	self._Nego_PetTips = goutil.findChild(_Nego_Left, "Nego_PetTips")
end

function MissionViewerView:destroyUI()
	return
end

function MissionViewerView:onEnter()
	self._playerView = self._viewPresentor._openParam[1]

	self._maskBlock:SetActive(false)

	self._teamPlayerName.text = self._playerView.nickName .. "的阵容"

	self:_showFormation()
	self:_registerEvents()
end

function MissionViewerView:_showFormation()
	local formationId = self._playerView.formationId

	self:_SetFormationNameAndIcon(formationId)
	self:_SetHeroSkill(self._playerView.heroSkillId)
	self:_RefreshView()
	self:_SetSummonPet()
end

function MissionViewerView:_SetFormationNameAndIcon(id)
	self._TxtC_Formation.text = ""
end

function MissionViewerView:_SetHeroSkill(id)
	if not id or id == 0 then
		self._heroSkillIcon:SetActive(false)
		self._Img_HeroSkill:ChangeStateNow(1)
	else
		self._heroSkillIcon:SetActive(true)
		self._Img_HeroSkill:ChangeStateNow(0)
		self:_setSkillBtnName(id)
	end
end

function MissionViewerView:_setSkillBtnName(id)
	local skillCo = BattleConfig.instance:getSkillCo(id)

	if skillCo == nil then
		printInfo("id:" .. id)

		return
	end

	BagPetsFacade.setHeadIconByRaceId(self._heroSkillIcon, math.fmod(id, 100000))
end

function MissionViewerView:_getSummonPetId()
	for i = 1, #self._playerView.characterViews do
		if self._playerView.characterViews[i].isSummonedCharacter then
			return self._playerView.characterViews[i].raceId
		end
	end

	return 0
end

function MissionViewerView:_SetSummonPet()
	self._Btn_ContractPet.gameObject:SetActive(false)
end

function MissionViewerView:_RefreshView()
	self:_SetPower()
	self:_RefeshSeats()
end

function MissionViewerView:_SetPower()
	self._TxtC_Power:SetNum(self._playerView.fightPower)
end

function MissionViewerView:_RefeshSeats()
	for i = 1, 9 do
		local pet = self:_getPetBySeat(i)
		local itemSeat = ItemViewerSeat.AddOnce(self._seats[i])

		itemSeat:SetSeatInfo(i, pet)
		itemSeat:SetSelect(false)
		itemSeat:SetRestrain("", false)
	end
end

function MissionViewerView:_getPetBySeat(seat)
	for i = 1, #self._playerView.characterViews do
		local v = self._playerView.characterViews[i]
		local fmtIndex = v.y * 3 + v.x + 1

		if fmtIndex == seat then
			return v
		end
	end
end

function MissionViewerView:onExit()
	self:_unregisterEvents()
	self._maskBlock:SetActive(false)
end

function MissionViewerView:_onClickClose()
	UIStateManager.instance:pop()
end

function MissionViewerView:_onClickHeroSkill()
	if self._playerView.heroSkillId and self._playerView.heroSkillId > 0 then
		CommonTipsMgr.instance:openMaterialTips(self._Btn_HeroSkill, MatType.Skill, self._playerView.heroSkillId)
	end
end

function MissionViewerView:_onClickSeat()
	return
end

return MissionViewerView
