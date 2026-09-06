-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originjiu/view/OriginJiuBattleResultLockHpView.lua

module("logic.extensions.originjiu.view.OriginJiuBattleResultLockHpView", package.seeall)

local OriginJiuBattleResultLockHpView = class("OriginJiuBattleResultLockHpView", ViewComponent)

function OriginJiuBattleResultLockHpView:buildUI()
	OriginJiuBattleResultLockHpView.super.buildUI(self)

	self._tagReach = self:getGo("detail/tagReach")
	self._txtDetail = self:getTxt("detail/txt")
	self._btnSure = self:getGo("btnSure")
	self._btnAgain = self:getGo("btnAgain")
	self._btnClose = self:getGo("btnClose")

	local petScrView = self:getGo("petCol/scrView")
	local petScrCell = self:getGo("petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._tagEmpty = self:getGo("petCol/tagEmpty")
end

function OriginJiuBattleResultLockHpView:bindEvents()
	OriginJiuBattleResultLockHpView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function OriginJiuBattleResultLockHpView:unbindEvents()
	OriginJiuBattleResultLockHpView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginJiuBattleResultLockHpView:onEnter()
	OriginJiuBattleResultLockHpView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local msg = GameUtil.pbToTable(params[1]) or {}

	self._activityId = msg.activityId
	self._modelId = msg.modelId
	self._phaseId = msg.phaseId
	self._isWin = checkbool(msg.isWin)
	self._petHpDataMap = {}
	self._lockHpRaceIds = {}

	if msg.wheelInfo and msg.wheelInfo.wheelTeam then
		for _, team in ipairs(msg.wheelInfo.wheelTeam or {}) do
			if not team.pets then
				for _, pet in ipairs(team.pets) do
					local petId = pet.petId
					local petMo = BagPetsController.instance:getPet(petId)
					local raceId = petMo and petMo:getDefineId()
					local leftHp = checknumber(pet.leftHp)
					local maxHp = checknumber(petMo and petMo._maxHp)
					local hpRate = 0

					if leftHp < 0 then
						hpRate = 1
					else
						hpRate = maxHp > 0 and checknumber(leftHp / maxHp) or 0
						hpRate = Mathf.Clamp(hpRate, 0, 1)
					end

					self._petHpDataMap[raceId] = hpRate

					table.insert(self._lockHpRaceIds, raceId)
				end
			end
		end
	end

	self:_onUpdate()
end

function OriginJiuBattleResultLockHpView:onExit()
	OriginJiuBattleResultLockHpView.super.onExit(self)
	self._petScrollerList:dispose()
end

function OriginJiuBattleResultLockHpView:_onUpdate()
	GameUtil.SetActive(self._tagReach, self._isWin)

	self._txtDetail.text = "击败所有敌人"

	self._petScrollerList:reloadData(self._lockHpRaceIds)
	GameUtil.SetActive(self._tagEmpty, #self._lockHpRaceIds == 0)
end

function OriginJiuBattleResultLockHpView:_updatePetCell(view, cell, raceId, tag)
	local hpRate = checknumber(self._petHpDataMap[raceId])
	local isDie = hpRate <= 0
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")
	local hpSliderGo = goutil.findChild(mainGo, "hpSlider")
	local tagDie = goutil.findChild(mainGo, "tagDie")
	local proxy = MaterialMgr.setCell(MatType.Pet, raceId, itemGo)

	if proxy then
		proxy.binder:setClickCallBack(nil)
		proxy.binder:setGray(isDie)
	end

	GameUtil.SetActive(tagDie, isDie)
	GameUtil.SetActive(hpSliderGo, not isDie)

	local hpSlider = Framework.SliderAdapter.GetFrom(mainGo, "hpSlider")
	local fillChangeComp = goutil.findChildComponent(mainGo, "hpSlider/FillArea/Fill", ComponentType.UIImageColorChange)
	local level = Mathf.Clamp(math.floor(hpRate * 10) - 1, 0, 9)

	if fillChangeComp then
		fillChangeComp:SetState(level)
	end

	hpSlider:SetValue(hpRate)
end

function OriginJiuBattleResultLockHpView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local itemGo = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(itemGo)
end

function OriginJiuBattleResultLockHpView:_onClickBtnSure()
	self:close()
	BattleController.instance:endBattle()
end

return OriginJiuBattleResultLockHpView
