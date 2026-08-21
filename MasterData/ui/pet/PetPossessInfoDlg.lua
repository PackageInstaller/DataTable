-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetPossessInfoDlg.lua

local ResClientConfirm = require("ClientData/ResClientConfirm")
local ResPetPossessAttr = require("ClientData/ResPetPossessAttr")
local ResPetStar = require("ClientData/ResPetStar")
local ResPetGifted = require("ClientData/ResPetGifted")
local ResClientNotice = require("ClientData/ResClientNotice")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local EventConst = require("EventConst")
local PetPossessInfoDlg = Class("PetPossessInfoDlg", UIControls.Window)

function PetPossessInfoDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.loopPet = UIControls.ScrollViewLoopV(self, "BgPanel/PetList")

	self.loopPet:addEventCellChanged(self.onLoopPetChange)

	self.petCellDic = {}
	self.txtTotalNum = UIControls.Label(self, "BgPanel/EnchantNumPanel/TextNum")
	self.petCell = UIControls.ItemGridChild(self, "BgPanel/PetPanel/GridPanel", "System/Common/Grid/GridMaterialItem")

	self.petCell:setClickEnable(false)
	self.petCell:setVisible(true)

	self.txtPetName = UIControls.Label(self, "BgPanel/PetPanel/TextPetName")
	self.panelStarList = {}

	for i = 1, 5 do
		local panelStar = UIControls.Panel(self, "BgPanel/PetPanel/StartGroup/Start0" .. i .. "/Background/Checkmark")

		table.insert(self.panelStarList, panelStar)
	end

	self.careerPanel = UIControls.Panel(self, "BgPanel/PetPanel/EnchantStatePanel")
	self.imgCareer = UIControls.Image(self, "BgPanel/PetPanel/EnchantStatePanel/ImgCareer")
	self.btnOpenTipsPanel = UIControls.Button(self, "BgPanel/AttrPanel/TextTitle/BtnTips")

	self.btnOpenTipsPanel:addEventClick(self.onClickBtnOpenTipsPanel)

	self.btnCloseTipsPanel = UIControls.Button(self, "TipsPanel/UIClickThrough")

	self.btnCloseTipsPanel:addEventClick(self.onClickBtnCloseTipsPanel)

	self.tipsPanel = UIControls.Panel(self, "TipsPanel")
	self.tipsBgPanel = UIControls.Panel(self, "BgPanel/AttrPanel/TextTitle/BtnTips/BgImg")
	self.attrCellList = {}

	for i = 1, 4 do
		local cell = HeroAttrPanel(self, "BgPanel/AttrPanel/AttrLessPanel/Attr" .. i)

		table.insert(self.attrCellList, cell)
	end

	self.btnPossess = UIControls.Button(self, "BgPanel/BtnControl")

	self.btnPossess:addEventClick(self.onClickBtnPossess)

	self.panelPossessOn = UIControls.Panel(self, "BgPanel/BtnControl/OnPanel")
	self.panelPossessOff = UIControls.Panel(self, "BgPanel/BtnControl/OffPanel")
	self.panelPossessReplace = UIControls.Panel(self, "BgPanel/BtnControl/ReplacePanel")
	self.panelPossessDisable = UIControls.Panel(self, "BgPanel/BtnControl/TextTips")
	self.txtOnTime = UIControls.Label(self, "BgPanel/BtnControl/OnPanel/TextCD")
	self.txtReplaceTime = UIControls.Label(self, "BgPanel/BtnControl/ReplacePanel/TextCD")
	self.imgReplaceRed = UIControls.Image(self, "BgPanel/BtnControl/ReplacePanel/IconNew")
	self.btnIntelligence = UIControls.Button(self, "BgPanel/AttrPanel/BtnWash")

	self.btnIntelligence:addEventClick(self.onClickBtnIntelligence)

	self.intelligenceNmlPanel = UIControls.Panel(self, "BgPanel/AttrPanel/BtnWash/NmlPanel")
	self.intelligenceDisPanel = UIControls.Panel(self, "BgPanel/AttrPanel/BtnWash/DisPanel")
	self.intelligenceRed = UIControls.RedDot(self, "BgPanel/AttrPanel/BtnWash/NmlPanel/IconNew")

	self.intelligenceRed:addHint({
		UIConst.RD_HINT_PET_POSSESS_INTELLIGENCE
	})

	self.btnAllGift = UIControls.Button(self, "BgPanel/SkillPanel/BtnAllSkill")

	self.btnAllGift:addEventClick(self.onClickBtnAllGift)

	self.btnGift = UIControls.Button(self, "BgPanel/SkillPanel/BtnGetSkill")

	self.btnGift:addEventClick(self.onClickBtnGift)

	self.giftNmlPanel = UIControls.Panel(self, "BgPanel/SkillPanel/BtnGetSkill/NmlPanel")
	self.giftDisPanel = UIControls.Panel(self, "BgPanel/SkillPanel/BtnGetSkill/DisPanel")
	self.giftRed = UIControls.RedDot(self, "BgPanel/SkillPanel/BtnGetSkill/NmlPanel/IconNew")

	self.giftRed:addHint({
		UIConst.RD_HINT_PET_POSSESS_GIFT
	})

	self.giftListPanel = UIControls.Panel(self, "BgPanel/SkillPanel/SkillList")
	self.possessEfx = UIControls.LazyEffectPlayer(self, "BgPanel/PetPanel/EnchantStatePanel/Efx")
	self.possessCd = Const.PET_POSSESS_CD
	self.slotOnClickPetCell = Slot(self.onClickPetCell, self)
	self.slotOnPetPossessDataChange = Slot(self.onPetPossessDataChange, self)
	self.slotRefreshRight = Slot(self.refreshRight, self)

	EventCenter.addEventListener(EventConst.PET_POSSESS_DATA_CHANGE, self.slotOnPetPossessDataChange)
	EventCenter.addEventListener(EventConst.PET_INTELLIGENCE_CHANGE, self.slotRefreshRight)
	EventCenter.addEventListener(EventConst.PET_GIFT_CHANGE, self.slotRefreshRight)
end

function PetPossessInfoDlg:onOpen()
	PetPossessInfoDlg.super.onOpen(self)

	local ui = UIManager.getUI("petPossessMainDlg")

	if ui then
		self:bindWindow(ui)
	end
end

function PetPossessInfoDlg:destroy()
	PetPossessInfoDlg.super.destroy(self)
	EventCenter.removeEventListener(EventConst.PET_POSSESS_DATA_CHANGE, self.slotOnPetPossessDataChange)
	EventCenter.removeEventListener(EventConst.PET_INTELLIGENCE_CHANGE, self.slotRefreshRight)
	EventCenter.removeEventListener(EventConst.PET_GIFT_CHANGE, self.slotRefreshRight)

	if self.txtTime then
		ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_POSSESS_INTELLIGENCE, false)
	RedDotManager.setKeyState(UIConst.RD_HINT_PET_POSSESS_GIFT, false)

	for petCell, _ in pairs(self.petCellDic) do
		petCell:clearCd()
	end
end

function PetPossessInfoDlg:setJumpArg(careerId)
	local data = CurAvatar:getPetPossessDataByCareerId(careerId)
	local petList = data and data.petList

	if petList and #petList > 0 then
		local pet = CurAvatar:getPetByResId(petList[1])

		self:setData(careerId, pet)
	else
		self:setData(careerId, nil)
	end
end

function PetPossessInfoDlg:setData(careerId, pet)
	self.careerId = careerId
	self.operatePet = pet
	self.operatePossessTick = self.operatePet and self.operatePet.possessTick or 0
	self.operatePossessNum = CurAvatar:getPetPossessNum(self.careerId)
	self.petList = {}

	for i = 1, #CurAvatar.petList do
		table.insert(self.petList, CurAvatar.petList[i])
	end

	local function sortFunc(pet1, pet2)
		if pet1 == self.operatePet then
			return true
		end

		if pet2 == self.operatePet then
			return false
		end

		if self.operatePet then
			local careerId1 = CurAvatar:getPetPossessInfoByPetId(pet1.id) or 0
			local careerId2 = CurAvatar:getPetPossessInfoByPetId(pet2.id) or 0

			if careerId1 ~= careerId2 then
				if careerId1 == self.careerId then
					return true
				end

				if careerId2 == self.careerId then
					return false
				end

				return careerId1 < careerId2
			else
				local cur = ClientUtils:getServerTime()
				local left1 = pet1.possessTick + self.possessCd - cur

				left1 = left1 <= 0 and 0 or 1

				local left2 = pet2.possessTick + self.possessCd - cur

				left2 = left2 <= 0 and 0 or 1

				if left1 ~= left2 then
					return left1 < left2
				elseif pet1.quality ~= pet2.quality then
					return pet1.quality > pet2.quality
				elseif pet1.star ~= pet2.star then
					return pet1.star > pet2.star
				else
					return pet1.id < pet2.id
				end
			end
		else
			local cur = ClientUtils:getServerTime()
			local left1 = pet1.possessTick + self.possessCd - cur

			left1 = left1 <= 0 and 0 or 1

			local left2 = pet2.possessTick + self.possessCd - cur

			left2 = left2 <= 0 and 0 or 1

			if left1 ~= left2 then
				return left1 < left2
			else
				local careerId1 = CurAvatar:getPetPossessInfoByPetId(pet1.id) or 0
				local careerId2 = CurAvatar:getPetPossessInfoByPetId(pet2.id) or 0

				if careerId1 ~= careerId2 then
					return careerId1 < careerId2
				elseif pet1.quality ~= pet2.quality then
					return pet1.quality > pet2.quality
				elseif pet1.star ~= pet2.star then
					return pet1.star > pet2.star
				else
					return pet1.id < pet2.id
				end
			end
		end
	end

	table.sort(self.petList, sortFunc)

	self.selectPet = pet or self.petList[1]
	self.selectPetCell = nil

	self:refreshView()
end

function PetPossessInfoDlg:refreshView()
	self:refreshRight()
	self.loopPet:setTotalCount(#self.petList)
	self.txtTotalNum:setText(CurAvatar:getTotalPetPossessNum() .. "/" .. CurAvatar:getTotalMaxPetPossessNum())
end

function PetPossessInfoDlg:onLoopPetChange(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.PetCardLoop(sender, "System/Pet/GridPetCard", newIdx)

		targetCell:setSelectCallback(self.slotOnClickPetCell)
	else
		targetCell.mIndex = newIdx
	end

	self.petCellDic[targetCell] = true

	local pet = self.petList[newIdx]

	targetCell:setPet(pet)

	local checkSelect = pet == self.selectPet

	targetCell:setSelected(checkSelect)

	if checkSelect then
		self.selectPetCell = targetCell
	end

	local careerId = CurAvatar:getPetPossessInfoByPetId(pet.id)

	targetCell:showPossessCareer(careerId)
	targetCell:showPossessState(pet == self.operatePet, careerId)
	targetCell:setRed2(CurAvatar:checkPetPossessReplaceRedByReplacePet(self.careerId, self.operatePet, pet))

	local cur = ClientUtils:getServerTime()
	local left = pet.possessTick + self.possessCd - cur

	targetCell:setCd(left)
end

function PetPossessInfoDlg:onClickPetCell(cell)
	if cell.pet == self.selectPet then
		return
	end

	if self.selectPetCell then
		self.selectPetCell:setSelected(false)
	end

	self.selectPetCell = cell
	self.selectPet = self.selectPetCell.pet

	self.selectPetCell:setSelected(true)
	self:refreshRight()
end

function PetPossessInfoDlg:refreshRight()
	self.petCell:setObj(self.selectPet)
	self.txtPetName:setText(self.selectPet.name)

	for i, panelStar in ipairs(self.panelStarList) do
		panelStar:setVisible(i <= self.selectPet.star)
	end

	self.mostPossessNum = CurAvatar:getMostPetPossessNum()
	self.selectCareerId = CurAvatar:getPetPossessInfoByPetId(self.selectPet.id)
	self.selectPossessNum = CurAvatar:getPetPossessNum(self.selectCareerId)
	self.selectPossessTick = self.selectPet.possessTick

	self.careerPanel:setVisible(self.selectCareerId ~= nil)

	if self.selectCareerId then
		self.imgCareer:setImage("Atlas/PetAtlas/PetEnchantAtlas6", "IconCareer" .. self.selectCareerId)
	end

	local checkShowOn = not self.operatePet and (not self.selectCareerId or self.selectCareerId ~= self.careerId)
	local checkShowReplace = self.operatePet and (not self.selectCareerId or self.selectCareerId ~= self.careerId)
	local checkShowOff = self.operatePet == self.selectPet
	local checkShowDisable = self.operatePet ~= self.selectPet and self.selectCareerId == self.careerId

	self.panelPossessOn:setVisible(checkShowOn)
	self.panelPossessOff:setVisible(checkShowOff)
	self.panelPossessReplace:setVisible(checkShowReplace)
	self.panelPossessDisable:setVisible(checkShowDisable)
	self.btnPossess:setEnable(not checkShowDisable)

	if checkShowReplace then
		self.imgReplaceRed:setVisible(CurAvatar:checkPetPossessReplaceRedByReplacePet(self.careerId, self.operatePet, self.selectPet))
	end

	if self.txtTime then
		ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	end

	if checkShowOn or checkShowReplace then
		self.txtTime = checkShowOn and self.txtOnTime or checkShowReplace and self.txtReplaceTime

		local cur = ClientUtils:getServerTime()
		local left = self.selectPossessTick + self.possessCd - cur

		self.txtTime:setVisible(left > 0)

		if left > 0 then
			self.slotCdEndCb = self.slotCdEndCb or Slot(self.cdEndCb, self)

			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, left, false, nil, self.slotCdEndCb)
		end
	end

	local cellNum = #self.attrCellList
	local possessAttrConfig = ResPetPossessAttr[self.selectPet.quality]

	for index, config in ipairs(possessAttrConfig) do
		if cellNum < index then
			break
		end

		local petAttrName = BattleConst.PROP_TYPE_CONFIG[config.pet_attr]
		local zhName, attrValue = ClientUtils.getRolePropZhName(petAttrName, 0)
		local intelligence = self.selectPet.intelligenceList[index] or 0
		local intelligenceLimit = config.intelligence_limit[self.selectPet.star]
		local cell = self.attrCellList[index]

		cell:setData(zhName, intelligence .. "/" .. intelligenceLimit, nil, petAttrName)
		cell:setSlider(intelligence / intelligenceLimit)
	end

	local checkIntelligenceLimit = CurAvatar:checkPetIntelligenceLimit(self.selectPet)

	self.intelligenceNmlPanel:setVisible(not checkIntelligenceLimit)
	self.intelligenceDisPanel:setVisible(checkIntelligenceLimit)

	local curMaxGiftNum = ResPetStar[self.selectPet.star].gifted_limit
	local maxGiftNum = ResPetStar[#ResPetStar].gifted_limit

	self.checkGiftLimit = curMaxGiftNum <= 0

	if self.checkGiftLimit then
		self.strGiftLimitNotice = ""

		for star, config in ipairs(ResPetStar) do
			if config.gifted_limit == 1 then
				self.strGiftLimitNotice = string.format(ResClientNotice[761].notice, star)

				break
			end
		end
	end

	self.giftNmlPanel:setVisible(not self.checkGiftLimit)
	self.giftDisPanel:setVisible(self.checkGiftLimit)

	local giftIdList = self.selectPet.giftList

	self.giftCellList = self.giftCellList or {}

	local dataNum = #giftIdList
	local cellNum = #self.giftCellList

	for i = 1, maxGiftNum do
		local cell

		if i <= cellNum then
			cell = self.giftCellList[i]
		else
			cell = UIControls.GridPetGiftLongChild(self, "BgPanel/SkillPanel/SkillList", "System/Pet/GridEnchantLongSkill")

			table.insert(self.giftCellList, cell)
		end

		cell:setVisible(true)

		if i <= dataNum then
			cell:setData(true, giftIdList[i])
		elseif i <= curMaxGiftNum then
			cell:setData(true, 0)
		else
			for star, config in ipairs(ResPetStar) do
				if config.gifted_limit == i then
					cell:setData(false, 0, star)

					break
				end
			end
		end
	end

	if maxGiftNum < cellNum then
		for i = maxGiftNum + 1, cellNum do
			self.giftCellList[i]:setVisible(false)
		end
	end

	self:refreshIntelligenceRed()
	self:refreshGiftRed()
end

function PetPossessInfoDlg:refreshIntelligenceRed()
	local checkRed = CurAvatar:checkPetPossessIntelligenceRed(self.selectPet)

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_POSSESS_INTELLIGENCE, checkRed)
end

function PetPossessInfoDlg:refreshGiftRed()
	local checkRed = CurAvatar:checkPetPossessGiftRed(self.selectPet)

	RedDotManager.setKeyState(UIConst.RD_HINT_PET_POSSESS_GIFT, checkRed)
end

function PetPossessInfoDlg:cdEndCb()
	self.txtTime:setVisible(false)
end

function PetPossessInfoDlg:onClickBtnClose()
	CurAvatar:onClosePetPossessInfoDlg(self.careerId, self.operatePet)
	self:setVisible(false)
end

function PetPossessInfoDlg:onClickBtnPossess()
	if self.operatePet then
		if self.selectPet == self.operatePet then
			if self.selectPossessNum < self.mostPossessNum then
				UIManager.showConfirmWithId(1110)

				local ui = UIManager.tryGetUI("confirmui")

				if ui and ui.textContent then
					ui.textContent:setText(utils.format(ResClientConfirm[1110].content, self.mostPossessNum, self.selectPossessNum))
				end
			elseif self.operatePet:checkCanPossess() then
				RPC.petPossess(self.selectPet.id, self.careerId, Const.PET_POSSESS_TYPE.Off)
			else
				local function func()
					RPC.petPossess(self.selectPet.id, self.careerId, Const.PET_POSSESS_TYPE.Off)
				end

				UIManager.showConfirmWithId(1111, func)

				local ui = UIManager.tryGetUI("confirmui")

				if ui and ui.textContent then
					local now = ClientUtils:getServerTime()
					local left = self.operatePossessTick + Const.PET_POSSESS_CD - now

					ui.textContent:setText(string.format(ResClientConfirm[1111].content, utils.calcTimeTxt(left)))
				end
			end
		else
			if not self.selectPet:checkCanPossess(true) then
				return
			end

			if self.selectCareerId then
				if self.operatePet:checkCanPossess() then
					if self.selectPossessNum < self.mostPossessNum then
						local function func()
							RPC.petPossessReplace(Const.PET_POSSESS_TYPE.NoCd, self.selectPet.id, self.operatePet.id, self.selectCareerId, self.careerId)
						end

						UIManager.showConfirmWithId(1113, func)

						local ui = UIManager.tryGetUI("confirmui")

						if ui and ui.textContent then
							ui.textContent:setText(string.format(ResClientConfirm[1113].content, Const.CAREER_CONFIG[self.selectCareerId].name))
						end
					else
						local function func1()
							RPC.petPossessReplace(Const.PET_POSSESS_TYPE.NoCd, self.selectPet.id, self.operatePet.id, self.selectCareerId, self.careerId)
						end

						local function func2()
							RPC.petPossessReplace(Const.PET_POSSESS_TYPE.SrcOff, self.selectPet.id, self.operatePet.id, self.selectCareerId, self.careerId)
						end

						UIManager.showConfirmWithId(1106, nil, func1, func2)

						local ui = UIManager.tryGetUI("confirmui")

						if ui and ui.textContent then
							ui.textContent:setText(string.format(ResClientConfirm[1106].content, Const.CAREER_CONFIG[self.selectCareerId].name))
						end
					end
				elseif self.selectPossessNum < self.mostPossessNum then
					UIManager.showConfirmWithId(1112)

					local ui = UIManager.tryGetUI("confirmui")

					if ui and ui.textContent then
						ui.textContent:setText(utils.format(ResClientConfirm[1112].content, self.mostPossessNum, self.selectPossessNum, self.selectPossessNum))
					end
				else
					local function func()
						RPC.petPossessReplace(Const.PET_POSSESS_TYPE.SrcOff, self.selectPet.id, self.operatePet.id, self.selectCareerId, self.careerId)
					end

					UIManager.showConfirmWithId(1107, func)

					local ui = UIManager.tryGetUI("confirmui")

					if ui and ui.textContent then
						local now = ClientUtils:getServerTime()
						local left = self.operatePossessTick + Const.PET_POSSESS_CD - now

						ui.textContent:setText(string.format(ResClientConfirm[1107].content, utils.calcTimeTxt(left)))
					end
				end
			else
				local function cb()
					RPC.petPossessReplace(Const.PET_POSSESS_TYPE.Normal, self.selectPet.id, self.operatePet.id, self.selectCareerId, self.careerId)
				end

				UIManager.showConfirmWithId(1105, cb)
			end
		end
	else
		if not self.selectPet:checkCanPossess(true) then
			return
		end

		if self.selectCareerId then
			if self.selectPossessNum < self.mostPossessNum then
				UIManager.showConfirmWithId(1110)

				local ui = UIManager.tryGetUI("confirmui")

				if ui and ui.textContent then
					ui.textContent:setText(utils.format(ResClientConfirm[1110].content, self.mostPossessNum, self.selectPossessNum))
				end
			else
				local function func()
					RPC.petPossess(self.selectPet.id, self.selectCareerId, Const.PET_POSSESS_TYPE.Off)
				end

				UIManager.showConfirmWithId(1114, func)

				local ui = UIManager.tryGetUI("confirmui")

				if ui and ui.textContent then
					ui.textContent:setText(string.format(ResClientConfirm[1114].content, Const.CAREER_CONFIG[self.selectCareerId].name))
				end
			end
		else
			local totalMax = CurAvatar:getTotalMaxPetPossessNum()
			local total = CurAvatar:getTotalPetPossessNum()

			if totalMax <= total then
				MsgManager.clientNotice(756)

				return
			end

			if self.selectPet:checkCanPossess(true) then
				local function cb()
					RPC.petPossess(self.selectPet.id, self.careerId, Const.PET_POSSESS_TYPE.On)
				end

				UIManager.showConfirmWithId(1105, cb)
			end
		end
	end
end

function PetPossessInfoDlg:onClickBtnIntelligence()
	if CurAvatar:checkPetIntelligenceLimit(self.selectPet, true) then
		return
	end

	local ui = UIManager.getUI("petPossessIntelligenceDlg", true)

	if ui then
		ui:setData(self.selectPet)
	end
end

function PetPossessInfoDlg:onClickBtnGift()
	if self.checkGiftLimit then
		MsgManager.notice(self.strGiftLimitNotice)

		return
	end

	local ui = UIManager.getUI("petPossessGiftDlg", true)

	if ui then
		ui:setData(self.selectPet)
	end
end

function PetPossessInfoDlg:onClickBtnOpenTipsPanel()
	self.tipsPanel:setVisible(true)
	self.tipsBgPanel:setVisible(true)
end

function PetPossessInfoDlg:onClickBtnCloseTipsPanel()
	self.tipsPanel:setVisible(false)
	self.tipsBgPanel:setVisible(false)
end

function PetPossessInfoDlg:onClickBtnAllGift()
	local ui = UIManager.getUI("petPossessAllGiftDlg", true)

	if ui then
		ui:setData(self.selectPet)
	end
end

function PetPossessInfoDlg:onPetPossessDataChange(careerId, opType, petId)
	local checkPlayEfx = false

	if opType == Const.PET_POSSESS_TYPE.On then
		self.operatePet = CurAvatar:getPetByResId(petId)
		checkPlayEfx = true
	elseif opType == Const.PET_POSSESS_TYPE.Off then
		self.operatePet = nil
	elseif opType == Const.PET_POSSESS_TYPE.Normal then
		self.operatePet = CurAvatar:getPetByResId(petId)
		checkPlayEfx = true
	elseif opType == Const.PET_POSSESS_TYPE.NoCd then
		self.operatePet = CurAvatar:getPetByResId(petId)
		checkPlayEfx = true
	elseif opType == Const.PET_POSSESS_TYPE.SrcOff then
		self.operatePet = CurAvatar:getPetByResId(petId)
		checkPlayEfx = true
	end

	self.operatePossessNum = CurAvatar:getPetPossessNum(self.careerId)
	self.operatePossessTick = self.operatePet and self.operatePet.possessTick or 0

	self:refreshView()

	if checkPlayEfx then
		self.possessEfx:playEffect()
	end
end

return PetPossessInfoDlg
