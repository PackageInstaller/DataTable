-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\TopPvpKnockoutDragHeroDlg.lua

local MultiDragHeroDlg = require("UI/Battle/MultiDragHeroDlg")
local strClassName = "TopPvpKnockoutDragHeroDlg"
local DragPlane = require("UI/Control/Com/DragPlane")
local TopPvpKnockoutDragHeroDlg = Class(strClassName, MultiDragHeroDlg)
local ResBPPvpRoomTimer = require("ClientData/ResBPPvpRoomTimer")
local ResBPPvpMisc = require("ClientData/ResBPPvpMisc")
local ResBPPvpHeroCareerOrder = require("ClientData/ResBPPvpHeroCareerOrder")

function TopPvpKnockoutDragHeroDlg:ctor()
	return
end

function TopPvpKnockoutDragHeroDlg:_initUI()
	TopPvpKnockoutDragHeroDlg.super._initUI(self)

	self.btnTeamSwitch = UIControls.Button(self, "TeamPanel/BtnTeamSwitch")
	self.maskTopPVP = UIControls.Image(self, "MaskTopPVP")
	self.imgTopPVP = UIControls.Image(self, "ImgTopPVP")

	self.imgTopPVP:setVisible(true)

	self.txtEliminate = UIControls.Label(self, "ImgTopPVP/TextEliminate")

	self.txtEliminate:setVisible(true)

	self.txtGroupMatch = UIControls.Label(self, "ImgTopPVP/Text")

	self.txtGroupMatch:setVisible(false)

	self.topPVPTimePanel = UIControls.Image(self, "TopPVPTimePanel")
	self.txtTime = UIControls.Label(self, "TopPVPTimePanel/TextTime")

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	local actData = CurAvatar:getTopPVPActivityData()
	local remainTime = actData:getKnockoutFormationRemainTime()

	self.postions = {}
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:setVisible(false)

	for i = 1, 3 do
		table.insert(self.postions, i)
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if remainTime and remainTime > 0 then
		self.topPVPTimePanel:setVisible(true)
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, remainTime, false)

		local function fun()
			self:setVisible(false)
		end

		self.timer = Timer.New(fun, remainTime, 1)
	end

	self.listHeros.panelSort:setVisible(false)
end

function TopPvpKnockoutDragHeroDlg:_initTeamFormation()
	self.btnSwitch:setVisible(false)

	self.teamFormations = {}
	self.teamPets = {}

	local actData = CurAvatar:getTopPVPActivityData()
	local formations = actData:getMyKnockoutFormation()

	self.formations = formations

	for i = 1, 3 do
		self.teamFormations[i] = {}
	end

	if actData then
		self.heroBags = actData:getMyFormationHeros()
	end

	if formations then
		for i = 1, 3 do
			local pos = formations[i].pos

			for j = 1, #formations[i].item do
				local item = formations[i].item[j]
				local gid = item.gid
				local index = item.idx

				self.teamFormations[pos][gid] = index
			end

			self.teamPets[pos] = {}
			self.teamPets[pos].petId = formations[i].pet_id
		end
	else
		self:initDefaultFormation()
	end

	self:onTeamSelect(self.teamBtns[1])

	self.selectTeam = 1
end

local function sortHeroByPriority(a, b)
	if a == nil or b == nil then
		return
	end

	if a.priority == nil or b.priority == nil then
		return
	else
		return a.priority < b.priority
	end

	if a.gid == nil or b.gid == nil then
		return
	else
		return a.gid < b.gid
	end
end

local function sortPetByCapacity(a, b)
	if a == nil or b == nil then
		return
	end

	if a.vis == nil or b.vis == nil then
		return
	end

	if a.vis == true and b.vis == false then
		return true
	elseif a.vis == false and b.vis == true then
		return false
	elseif a.capacity ~= b.capacity then
		if a.capacity and b.capacity then
			return a.capacity > b.capacity
		else
			return
		end
	elseif a.petId and b.petId then
		return a.petId > b.petId
	end
end

function TopPvpKnockoutDragHeroDlg:initDefaultFormation()
	for i = 1, 3 do
		if ResBPPvpMisc[1].hero_idx and self.heroBags and self.heroBags[i] then
			local heroIndex = ResBPPvpMisc[1].hero_idx
			local num = math.min(#heroIndex, #self.heroBags[i])
			local sortData = {}

			for _, hero in pairs(self.heroBags[i]) do
				local data = {}

				data.gid = hero.gid
				data.priority = ResBPPvpHeroCareerOrder[hero.career].id

				table.insert(sortData, data)
			end

			table.sort(sortData, sortHeroByPriority)

			local num = math.min(#sortData, #heroIndex)

			for index = 1, num do
				self.teamFormations[i][sortData[index].gid] = heroIndex[index]
			end
		end
	end

	local pets = CurAvatar.petDic

	if pets then
		local visPetId = {}
		local sortPets = {}

		for petId, pet in pairs(pets) do
			local data = {}

			if visPetId[petId] == true then
				data.vis = true
			else
				data.vis = false
			end

			data.capacity = pet:getCapacity()
			data.petId = petId

			table.insert(sortPets, data)
		end

		table.sort(sortPets, sortPetByCapacity)

		local sizeOfPet = 0

		for k, v in pairs(pets) do
			sizeOfPet = sizeOfPet + 1
		end

		local capacity = math.min(3, sizeOfPet)

		for i = 1, capacity do
			self.teamPets[i] = {}
			self.teamPets[i].petId = sortPets[i].petId
		end
	end
end

function TopPvpKnockoutDragHeroDlg:refreshTeamObjects()
	DragPlane.clearObject()
	DragPlane.startObjEntering()

	local teams = self.teamFormations[self.selectTeam]

	for gid, pos in pairs(teams) do
		local hero = CurAvatar.heroDic[gid]

		if hero then
			DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
		end
	end

	self:refreshPetObject()
	self:updatePlayerCampEnhance()
	self:refreshWearRedDot()
end

function TopPvpKnockoutDragHeroDlg:onSwitchTeam()
	self:saveNowFormation()

	local switchDlg = UIManager.getUI("multiDragSwitchDlg", nil, false)

	switchDlg = switchDlg or UIManager.getUI("multiDragSwitchDlg", true)

	if self.battleType == BattleConst.BATTLE_TYPE_DEFEND_THREE_TEAM then
		switchDlg:onShow(self.teamFormations, nil, self.battleType, self.teamPets)
	else
		switchDlg:onShow(self.teamFormations, nil, self.battleType, self.teamPets)
	end
end

function TopPvpKnockoutDragHeroDlg:isSameFormation()
	return false
end

function TopPvpKnockoutDragHeroDlg:updateHeroBag(...)
	if not self.teamFormations then
		self:_initTeamFormation()
	end

	local herosField = {}

	for pos, obj in pairs(DragPlane.fieldObjs or {}) do
		if obj.hero and pos > 0 then
			herosField[obj.hero.gid] = true
		end
	end

	for nowIndex, form in ipairs(self.teamFormations) do
		if nowIndex ~= self.selectTeam then
			for gid, pos in pairs(form) do
				herosField[gid] = true
			end
		end
	end

	self.listHeros:updateHeroBag(self.heroBags[self.selectTeam], herosField)
	self:updatePlayerCampEnhance()
	self:_updateHeroBag()
	self:refreshRedDot()

	if self.formations then
		self:AfterConfirm(false)
	end
end

function TopPvpKnockoutDragHeroDlg:_onConfirm(...)
	local isEmpty, minIndex = self:haveEmptyTeam()

	if isEmpty == true then
		MsgManager.clientNotice(261)
		self:onTeamSelect(self.teamBtns[minIndex])

		return
	end

	self:saveNowFormation()

	local function yesfun()
		local actId = CurAvatar:getTopPVPActivityOpId()
		local actData = CurAvatar:getTopPVPActivityData()
		local myNowRoom = actData:getMyKnockoutRoom()
		local roomId = myNowRoom.info.room_id
		local areaId = math.floor(actData.myKnockoutRoomId % 1000 / 100)
		local result = {}

		for i, info in ipairs(self.teamFormations) do
			local data = {
				hero = {}
			}

			for gid, pos in pairs(info) do
				table.insert(data.hero, {
					idx = pos,
					gid = gid
				})
			end

			if self.teamPets[i] and self.teamPets[i].petId then
				data.pet = self.teamPets[i].petId
			end

			table.insert(result, data)
		end

		local postion = {}

		for k, v in pairs(self.postions) do
			table.insert(postion, v)
		end

		actData:updateCacheRommInfoMyFormation()
		RPC.bPPvpKnockoutFormation(actId, areaId, roomId, result, postion)
		self:AfterConfirm(false)
	end

	UIManager.showConfirmWithId(1086, yesfun)
end

function TopPvpKnockoutDragHeroDlg:selectPlanCallBack(btnPlan)
	if btnPlan.plan.id == Const.EQUIP_PLAN_EDIT_ID then
		local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", true)
		local herosField = self:_getNowHeros()

		battleBeforeWearDlg:setData(herosField, self.battleType, self.nowSelectPetId)
		self.wearingPlanlist:setVisible(false)
		self.btnWearingPlan:setEnable(true)

		if self.isSetedInAnimTrap then
			self.isSetedInAnimTrap = false

			self:getController():SetInAnimName("InTeamSetMain")
		end

		local actData = CurAvatar:getTopPVPActivityData()

		if actData then
			local remainTime = actData:getKnockoutFormationRemainTime()

			if remainTime and remainTime > 0 then
				UIManager.getUI("topPvpTimeDlg", true):onShow(remainTime)
			end
		end
	else
		RPC.equipSchemeApply(btnPlan.plan.id, CurAvatar.equipPlanVersion)
		self.wearingPlanlist:setVisible(false)
		self.btnWearingPlan:setEnable(true)
	end
end

function TopPvpKnockoutDragHeroDlg:AfterConfirm(isShow)
	self.btnSwitch:setVisible(isShow)

	if UIControls.checkControlFunc(self, "BtnWearingPlan") then
		self.btnWearingPlan:setVisible(isShow)
	end

	self.btnListOpen:setVisible(isShow)
	self.maskTopPVP:setVisible(not isShow)

	if not isShow then
		self.panelList:setVisible(false)
	end

	for i = 1, 3 do
		self.teamBtns[i].imgNew:setVisible(isShow)
	end

	self.btnConfirm:setVisible(false)
end

function TopPvpKnockoutDragHeroDlg:onListToggle(sender)
	if self.formations then
		return
	end

	if self.wearingPlanlist and self.wearingPlanlist:getVisible() then
		self:playAni("CloseList", self.onWearListChangeFinished)

		self.sender = sender
	else
		self:changeHeroList(sender)
	end
end

function TopPvpKnockoutDragHeroDlg:onChangeFormation(fromIndex, toIndex)
	local tmpForm = self.teamFormations[fromIndex]

	self.teamFormations[fromIndex] = self.teamFormations[toIndex]
	self.teamFormations[toIndex] = tmpForm

	local tmpPets = self.teamPets[fromIndex]

	self.teamPets[fromIndex] = self.teamPets[toIndex]
	self.teamPets[toIndex] = tmpPets

	local heros = self.heroBags[fromIndex]

	self.heroBags[fromIndex] = self.heroBags[toIndex]
	self.heroBags[toIndex] = heros

	local postion = self.postions[fromIndex]

	self.postions[fromIndex] = self.postions[toIndex]
	self.postions[toIndex] = postion

	if fromIndex == self.selectTeam or toIndex == self.selectTeam then
		self:refreshTeamObjects()
	end

	self:updateHeroBag()
	self:onSwitchTeam()
	self:refreshRedDot()
end

function TopPvpKnockoutDragHeroDlg:refreshRedDot(...)
	local lessMap = {}
	local usedHeroMap = {}

	for i = 1, 3 do
		usedHeroMap[i] = {}
	end

	for i = 1, 3 do
		local count, useHeroIdMap = self:getTeamPutCount(i)

		for heroId, state in pairs(useHeroIdMap) do
			usedHeroMap[i][heroId] = state
		end

		if count < 5 then
			lessMap[i] = true
		end
	end

	local canPut = {}

	for i = 1, 3 do
		for index, hero in pairs(self.heroBags[i]) do
			if usedHeroMap[i][hero.id] ~= true then
				canPut[i] = true
			end
		end
	end

	for i = 1, 3 do
		self.teamBtns[i].imgNew:setVisible(lessMap[i] == true and canPut[i] and canPut[i] == true)
	end
end

function TopPvpKnockoutDragHeroDlg:onTeamSelect(sender)
	if self.selectTeam then
		self:saveNowFormation()
	end

	local herosField = {}

	for pos, obj in pairs(DragPlane.fieldObjs or {}) do
		if obj.hero and pos > 0 then
			herosField[obj.hero.gid] = true
		end
	end

	for nowIndex, form in ipairs(self.teamFormations) do
		if nowIndex ~= self.selectTeam then
			for gid, pos in pairs(form) do
				herosField[gid] = true
			end
		end
	end

	self.selectTeam = sender.teamIndex

	for index, btn in ipairs(self.teamBtns) do
		btn:setEnable(sender ~= btn)
	end

	if self.selectTeam == self.MAX_TEAM_NUM then
		self.btnConfirm:setText(Lang.get(79265))
	else
		self.btnConfirm:setText(Lang.get(30148))
	end

	self.listHeros:updateHeroBag(self.heroBags[self.selectTeam], herosField)
	self:refreshTeamObjects()
end

function TopPvpKnockoutDragHeroDlg:destory()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	TopPvpKnockoutDragHeroDlg.super.destory(self)
end

return TopPvpKnockoutDragHeroDlg
