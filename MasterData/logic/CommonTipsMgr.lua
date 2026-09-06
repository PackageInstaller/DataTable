-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/manager/CommonTipsMgr.lua

module("logic.extensions.common.instruction.manager.CommonTipsMgr", package.seeall)

local CommonTipsMgr = class("CommonTipsMgr")
local ZERO_POS = Vector3.New(0, 0, 0)

function CommonTipsMgr:ctor()
	self.openingList = {}
	self.willClosePool = {}
	self.index = 0
	self.openIndexPool = {}
end

function CommonTipsMgr:openTipsByConfStr(go, itemStr)
	if string.nilorempty(itemStr) then
		return
	end

	itemStr = string.gsub(itemStr, "=", ":")

	local info = string.split(itemStr, ":")
	local matType = checknumber(info[1])
	local cfgId = checknumber(info[2])
	local ext1 = checknumber(info[3])
	local ext2 = checknumber(info[4])
	local ext3 = checknumber(info[5])

	self:openMaterialTips(go, matType, cfgId, ext1, ext2, ext3)
end

function CommonTipsMgr:openMaterialTips(goOrPos, matType, id, extData1, extData2, extData3)
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	if matType > 0 and id > 0 then
		if matType == MatType.Skill then
			self:_openCommonSkillTips({
				type = matType,
				id = id,
				extData1 = extData1,
				extData2 = extData2,
				extData3 = extData3
			}, pos, sizeDelta)
		elseif matType == MatType.Job then
			self:_openCommonJobTips({
				type = matType,
				id = id,
				extData1 = extData1
			}, pos, sizeDelta)
		elseif matType == MatType.Race then
			self:_openCommonRaceTips({
				type = matType,
				id = id,
				extData1 = extData1
			}, pos, sizeDelta)
		elseif matType == MatType.Equipment or matType == MatType.Decoration then
			self:_openCommonEquipTips(matType, id, extData1, extData2, pos, sizeDelta)
		elseif matType == MatType.StarGodPlus then
			self:_openCommonStarGodTips(id, extData1, extData2, pos, sizeDelta)
		elseif matType == MatType.HolyStripe then
			self:_openCommonHolyStripeTips(id, pos, sizeDelta, extData1)
		elseif matType == MatType.PetTitle then
			self:_openCommonPetTitleTips(id, pos, sizeDelta)
		elseif matType == MatType.DROP_ITEM then
			self:_openCommonDropTips({
				type = matType,
				id = id,
				extData1 = extData1,
				extData2 = extData2
			}, pos, sizeDelta)
		elseif matType == MatType.Rune then
			local data = MaterialMgr.getModel(MatType.Rune, id)

			if data then
				self:_openCommonRuneTips(data, pos, sizeDelta)
			else
				local cfg = MaterialMgr.getMatCfg(MatType.Rune, id)

				if cfg then
					self:_openCommonInsView({
						type = matType,
						id = id,
						extData1 = extData1,
						extData2 = extData2
					}, pos, sizeDelta)
				end
			end
		elseif matType == MatType.Pet then
			local petMo = BagPetsController.instance:getPet(id)

			if petMo then
				self:showPetTips(petMo)
			else
				self:showMaxLvlPetTips(id, extData1, extData2)
			end
		elseif matType == MatType.PayDiamond then
			self:_openCommonInsView({
				type = MatType.Diamond,
				id = MatType.Diamond_Normal,
				extData1 = extData1,
				extData2 = extData2
			}, pos, sizeDelta)
		elseif matType == MatType.PET_SKIN then
			ViewMgr.instance:close(ViewName.DropTipsView)
			ViewAutoShowController.instance:saveCurModalView()
			UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, id)
		elseif matType == MatType.Item or matType == MatType.Item_Fake or matType == MatType.EmojiPack then
			local cfg = MaterialMgr.getMatCfg(matType, id)

			if cfg then
				if not string.nilorempty(cfg.rewardPreview) then
					self:_openCommonDropTips({
						type = matType,
						id = id,
						extData1 = extData1,
						extData2 = extData2
					}, pos, sizeDelta)
				else
					self:_openCommonInsView({
						type = matType,
						id = id,
						extData1 = extData1,
						extData2 = extData2
					}, pos, sizeDelta)
				end
			end
		elseif matType == MatType.CutePet then
			self:_openCommonCutePetTips({
				raceId = id,
				lv = extData1,
				quality = extData2,
				mo = extData3
			}, pos, sizeDelta)
		elseif matType == MatType.Coin or matType == MatType.Diamond or matType == MatType.GodGem or matType == MatType.PokeBall or matType == MatType.Strength or matType == MatType.PetPiece or matType == MatType.ACTIVITY_ITEM or matType == MatType.Title or matType == MatType.Throne or matType == MatType.Hoshigami or matType == MatType.TimedItem or matType == MatType.StarGodPlus or matType == MatType.Cloth or matType == MatType.HeadFrame or matType == MatType.HeadIcon or matType == MatType.ACTIVITY_ENERGY or matType == MatType.Bubble or matType == MatType.OpeningEffect or matType == MatType.HomePageBg or matType == MatType.NameFrame or matType == MatType.PlayerMessageSkin or matType == MatType.BattleUserInterfaceSkin or matType == MatType.BattleBackgroundSkin or matType == MatType.ImpressionSticker or matType == MatType.ImpressionPoster or matType == MatType.ExpirableItem then
			self:_openCommonInsView({
				type = matType,
				id = id,
				extData1 = extData1,
				extData2 = extData2
			}, pos, sizeDelta)
		else
			print(" ========= 还没实现的 Tips 功能 <color=#ff6600> 请自己实现!! </color>")
		end
	end
end

function CommonTipsMgr:showTextTips(data, goOrPos, sizeDelta)
	local viewName = ViewName.SimpletxttipsView
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	self:_openOneView(viewName, data, pos, sizeDelta)
end

function CommonTipsMgr:showTips(data, goOrPos, sizeDelta)
	local pos = goOrPos

	if goOrPos and goOrPos.gameObject then
		if sizeDelta == nil then
			local rect = goOrPos.gameObject:GetComponent("RectTransform")

			if rect ~= nil then
				sizeDelta = {
					rect.sizeDelta.x,
					rect.sizeDelta.y
				}
			end
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	local viewName = ViewName.CommonTextTipsView

	self:_openOneView(viewName, data, pos, sizeDelta)
end

function CommonTipsMgr:_openCommonRuneTips(data, pos, sizeDelta)
	local viewName = ViewName.RunetipView

	self:_openOneView(viewName, data, pos, sizeDelta)
end

function CommonTipsMgr:showMaxLvlPetTips(raceId, lvl, awakenLv, skinId)
	local co = MaterialMgr.getMatCfg(MatType.Pet, raceId)

	if co then
		if checknumber(lvl) > 0 then
			-- block empty
		else
			lvl = co.maxLv
		end

		local zdl = 0

		if lvl == co.maxLv then
			zdl = FightingPowerFormula.instance:getPetMaxFightingPower(raceId)
		else
			local tmpMo = FightingPowerPetMo.createPetByLevel(raceId, lvl, awakenLv, skinId)

			if tmpMo then
				zdl = tmpMo:getFightingPower()
			end
		end

		local curFaceId = checknumber(skinId)

		if curFaceId == 0 then
			curFaceId = checknumber(raceId)
		end

		local petMo = {
			raceId = raceId,
			level = lvl,
			name = co.name,
			_curZdl = zdl,
			curFaceId = curFaceId
		}

		petMo.awakenLv = awakenLv and awakenLv or CharacterConfig.instance:getMaxAwaken(raceId)

		self:showPetTips(petMo)
	end
end

function CommonTipsMgr:showPetTips(param, isHideZdl, canJumpOut)
	if not param then
		printError("CommonTipsMgr:showPetTips()  参数是nil，堆栈=" .. debug.traceback())

		return
	end

	self:_openOneView(ViewName.PetTips, param, isHideZdl, canJumpOut)
end

function CommonTipsMgr:showBattleTips(unit)
	local petMo = {
		unit = unit,
		raceId = unit.raceId,
		curFaceId = checknumber(unit.modelId),
		level = unit.attrs:getLevel(),
		name = unit.attrs:getName(),
		otherName = unit.attrs:getOtherName(),
		_curZdl = unit.attrs:getFightingPower(),
		awakenLv = unit.attrs:getAwakenLv()
	}

	self:showPetTips(petMo)
end

function CommonTipsMgr:_openCommonInsView(data, pos, sizeDelta)
	local viewName = ViewName.commonInstruction

	self:_openOneView(viewName, data, pos, sizeDelta)
end

function CommonTipsMgr:_openCommonSkillTips(data, pos, sizeDelta)
	local viewName = ViewName.SkillTips

	self:_openOneView(viewName, data, pos, sizeDelta)
end

function CommonTipsMgr:_openCommonJobTips(data, pos, sizeDelta)
	local viewName = ViewName.CommonJobTipsView

	self:_openOneView(viewName, data, pos, sizeDelta)
end

function CommonTipsMgr:_openCommonRaceTips(data, pos, sizeDelta)
	local viewName = ViewName.CommonRaceTipsView

	self:_openOneView(viewName, data, pos, sizeDelta)
end

function CommonTipsMgr:showBuddyHirePetTips(petMo, type, goOrPos, headInfo)
	local data = {
		petMo = petMo,
		goOrPos = goOrPos,
		type = type,
		headInfo = headInfo
	}
	local viewName = ViewName.BuddyhiredetailView

	self:_openOneView(viewName, data)
end

function CommonTipsMgr:_openCommonSourcemonTips(data, pos, sizeDelta)
	return
end

function CommonTipsMgr:_openCommonEquipTips(matType, id, starCount, param, pos, sizeDelta)
	if matType == MatType.Decoration and (param == nil or #param == 0) then
		self:_openCommonInsView({
			extData1 = 1,
			type = matType,
			id = id,
			extData2 = starCount
		}, pos, sizeDelta)

		return
	end

	local data = {
		isSeeInfo = true,
		matType = matType,
		baseId = id,
		starCount = starCount,
		param = param
	}

	self:_openOneView(ViewName.PetEquipInfo, data, pos, sizeDelta)
end

function CommonTipsMgr:_openCommonStarGodTips(id, lv, raceId, pos, sizeDelta)
	lv = lv or 1

	local slot = 1
	local cfg = StargodplusConfig.instance:getSlotLvPlanByLv(slot, lv)

	if cfg then
		if not cfg.exp then
			local exp = 0
			local data = {
				notFromBag = true,
				fillerDefineId = id,
				slot = slot,
				exp = exp,
				raceId = raceId
			}

			self:_openOneView(ViewName.StargodplusequiptipView, data, pos, sizeDelta)
		end
	end
end

function CommonTipsMgr:_openCommonHolyStripeTips(id, pos, sizeDelta, holyStripeMo)
	if holyStripeMo and holyStripeMo.__cname == "HolyStripeMo" then
		self:_openOneView(ViewName.HolyStripeRepaceTipsView, holyStripeMo, false, pos, sizeDelta, true)
	else
		local cfg = HolyStripeConfig.instance:getHolyStripeCfg(id)
		local data = id

		self:_openOneView(ViewName.HolyStripeSimpleTipView, data, pos, sizeDelta)
	end
end

function CommonTipsMgr:_openCommonPetTitleTips(id, pos, sizeDelta)
	local data = id

	self:_openOneView(ViewName.PetTitleTipView, data, pos, sizeDelta)
end

function CommonTipsMgr:_openCommonDropTips(data, pos, sizeDelta)
	self:_openOneView(ViewName.DropTipsView, data, pos, sizeDelta)
end

function CommonTipsMgr:_openCommonCutePetTips(data, pos, sizeDelta)
	self:_openOneView(ViewName.CutePetSimpleTipView, data, pos, sizeDelta)
end

function CommonTipsMgr:openArcBtnsView(goOrPos, dataListGroup)
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	self:_openOneView(ViewName.ArcBtnsTipsView, dataListGroup, pos, sizeDelta)
end

function CommonTipsMgr:_openOneView(viewName, data, ...)
	self:closeOneView(viewName)

	local viewMgr = ViewMgr.instance

	viewMgr:registerNotifyView(viewName)

	self.openingList[viewName] = true
	self.index = self.index + 1
	self.openIndexPool[viewName] = self.index

	viewMgr:open(viewName, data, ...)
end

function CommonTipsMgr:closeOneView(viewName)
	local viewMgr = ViewMgr.instance

	if viewMgr:isOpen(viewName) then
		self.openingList[viewName] = nil
		self.openIndexPool[viewName] = nil

		UIStateManager.instance:popByName(viewName)
	end
end

function CommonTipsMgr:checkShouldCloseNotTopTips(viewName)
	if self.openIndexPool[viewName] then
		local idx = checknumber(self.openIndexPool[viewName])

		for k, v in pairs(self.openIndexPool) do
			if idx < v and ViewMgr.instance:isOpen(k) then
				return true
			end
		end

		return false
	else
		return false
	end
end

function CommonTipsMgr:closeAllTips(force)
	local tem = {}

	for viewName, v in pairs(self.openingList) do
		if viewName == ViewName.DropTipsView then
			if force == true then
				table.insert(tem, viewName)
			end
		else
			table.insert(tem, viewName)
		end
	end

	self.openingList = {}
	self.willClosePool = {}
	self.openIndexPool = {}

	for i, v in ipairs(tem) do
		self:closeOneView(v)
	end
end

function CommonTipsMgr:doWillClose(view, hover)
	print(">>>>>>>>>>>>>>>>>>>>>>", view._viewPresentor.viewName, hover)

	local key

	if view and view._viewPresentor and view._viewPresentor.viewName then
		if self.openingList[view._viewPresentor.viewName] then
			if table.nums(self.openingList) == 1 and hover == false then
				self:closeOneView(view._viewPresentor.viewName)
			else
				self.willClosePool[view._viewPresentor.viewName] = hover
			end
		else
			self:closeOneView(view._viewPresentor.viewName)
		end
	end
end

function CommonTipsMgr:lateUpdate()
	local allClose = true
	local count = 0
	local maxIdx = 0

	for k, v in pairs(self.willClosePool) do
		if v == true then
			allClose = false
		end

		count = count + 1

		local idx = self.openIndexPool[k]

		if idx ~= nil and v then
			maxIdx = math.max(idx, maxIdx)
		end

		self.willClosePool[k] = nil
	end

	if count > 0 then
		if allClose then
			CommonTipsMgr.instance:closeAllTips(true)
		else
			local list = {}

			for k, v in pairs(self.openIndexPool) do
				if maxIdx < v then
					table.insert(list, k)
				end
			end

			for i, viewName in ipairs(list) do
				self:closeOneView(viewName)
			end
		end
	end
end

function CommonTipsMgr:openBuffTipView(data, goOrPos)
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	local viewName = ViewName.BufftipsView

	self:closeOneView(viewName)

	local viewMgr = ViewMgr.instance

	viewMgr:registerNotifyView(viewName)

	self.openingList[viewName] = true
	self.index = self.index + 1
	self.openIndexPool[viewName] = self.index

	viewMgr:open(viewName, data, pos, sizeDelta)
end

CommonTipsMgr.instance = CommonTipsMgr.New()

return CommonTipsMgr
