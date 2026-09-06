-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleSkillBagView.lua

module("logic.extensions.freescuffle.view.FreeScuffleSkillBagView", package.seeall)

local FreeScuffleSkillBagView = class("FreeScuffleSkillBagView", ViewComponent)

function FreeScuffleSkillBagView:ctor()
	FreeScuffleSkillBagView.super.ctor(self)

	self._creepsIdList = {}
	self._petMoDic = {}
	self._curSkillType = FreeScuffleEnum.SkillTypes[1]
	self._curIdx = 1
	self._skillListInPets = {}
	self._skillToPets = {}
	self._skillLists = {}
	self._pressHelpers = {}
end

function FreeScuffleSkillBagView:buildUI()
	FreeScuffleSkillBagView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnLeft = self:getGo("petCol/btnLeft")
	self._btnRight = self:getGo("petCol/btnRight")
	self._pointRare = self:getGo("petCol/petInfo/pointRare")
	self._txtName = self:getTxt("petCol/petInfo/name/txt")
	self._con = self:getGo("petCol/mask/con")

	local pageScrView = self:getGo("pageCol/scrView")
	local pageScrCell = self:getGo("pageCol/scrCell")

	self._pageScrollerList = ScrollerList.create(pageScrView, pageScrCell, GameUtil.handler(self._updatePageCell, self), GameUtil.handler(self._clearPageCell, self))

	local skillScrView = self:getGo("skillCol/scrView")
	local skillScrCell = self:getGo("skillCol/scrCell")

	self._skillScrollerList = ScrollerList.create(skillScrView, skillScrCell, GameUtil.handler(self._updateSkillCell, self), GameUtil.handler(self._clearSkillCell, self))
	self._btnJump = self:getGo("skillCol/empty/btnJump")
	self._emptySkill = self:getGo("skillCol/empty")
	self._Attrs = self:getGo("propertyCol/Attrs")
end

function FreeScuffleSkillBagView:bindEvents()
	FreeScuffleSkillBagView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLeft, GameUtil.handler(self._switchPet, self, -1))
	GameUtil.addClickHandler(self._btnRight, GameUtil.handler(self._switchPet, self, 1))
	GameUtil.addClickHandler(self._btnJump, self._onClickBtnJump, self)
end

function FreeScuffleSkillBagView:unbindEvents()
	FreeScuffleSkillBagView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
	GameUtil.rmClickHandler(self._btnJump)
end

function FreeScuffleSkillBagView:onEnter()
	FreeScuffleSkillBagView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._fmtType = params[2]

	local petMoList = params[3]
	local selectPetId = checknumber(params[4])
	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)

	table.clear(self._creepsIdList)
	table.clear(self._petMoDic)

	for _, petMo in ipairs(petMoList) do
		table.insert(self._creepsIdList, petMo:getPetId())

		self._petMoDic[petMo:getPetId()] = petMo
	end

	table.sort(self._creepsIdList, function(a, b)
		return b < a
	end)

	if selectPetId > 0 then
		for idx, creepsId in ipairs(self._creepsIdList) do
			if selectPetId == creepsId then
				self._curIdx = idx

				break
			end
		end
	end

	self._curIdx = self._curIdx or 1
	self._curIdx = Mathf.Clamp(self._curIdx, 0, #self._creepsIdList)

	self.addGEvent(self, GlobalNotify.HandlePM_FreeScuffleBattleInfoRes, self._onUpdate, self)
	self:_onUpdate()
end

function FreeScuffleSkillBagView:onExit()
	FreeScuffleSkillBagView.super.onExit(self)
	self:_onSave()
	self:_onClearPageCol()
	self:_onClearSkillCol()
	self:_onClearPetInfo()

	self._orginSkillListInPets = nil

	for k, v in pairs(self._pressHelpers) do
		self._pressHelpers[k]:dispose()

		self._pressHelpers[k] = nil
	end
end

function FreeScuffleSkillBagView:_onSave()
	self._subMo:setSkillListInPets(self._fmtType, self._skillListInPets)

	if self._fmtType == FreeScuffleEnum.FmtType_Pk then
		local result = {}
		local skillNum = table.nums(FreeScuffleEnum.SkillIndexs)
		local oldId, newId = 0, 0

		for _, creepsId in ipairs(self._creepsIdList) do
			if not self._orginSkillListInPets[creepsId] then
				if not self._skillListInPets[creepsId] then
					local newList = {}

					for index = 1, skillNum do
						if checknumber(self._orginSkillListInPets[creepsId][index]) ~= checknumber(newList[index]) then
							result[creepsId] = newList

							break
						end
					end
				end
			end
		end

		local petList = FreeScuffleController.instance:getCompleteSkillList(result)

		if #petList > 0 then
			FreeScuffleController.instance:sendPM_FreeScuffleChangeSkillReq(self._activityId, petList)
		end
	elseif self._fmtType == FreeScuffleEnum.FmtType_Defense then
		-- block empty
	end

	GlobalDispatcher:dispatch(GlobalNotify.FreeScuffleUpdateSkillBag)
end

function FreeScuffleSkillBagView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function FreeScuffleSkillBagView:_onUpdateData()
	self._skillListInPets = self._subMo:getSkillListInPets(self._fmtType)

	for _, creepsId in ipairs(self._creepsIdList) do
		self._skillListInPets[creepsId] = self._skillListInPets[creepsId] or {}
	end

	self._orginSkillListInPets = TableUtil.deepcopy(self._skillListInPets)

	table.clear(self._skillToPets)

	for creepsId, skillList in pairs(self._skillListInPets) do
		for _, skillId in ipairs(skillList) do
			if skillId > 0 then
				self._skillToPets[skillId] = creepsId
			end
		end
	end

	table.clear(self._skillLists)

	for _, skillType in ipairs(FreeScuffleEnum.SkillTypes) do
		self._skillLists[skillType] = self._skillLists[skillType] or {}

		local dataList = FreeScuffleConfig.instance:getSkillDataListByType(self._activityId, skillType) or {}

		for _, data in ipairs(dataList) do
			if self._subMo:isWithSkill(data.skillId) then
				table.insert(self._skillLists[skillType], data.skillId)
			end
		end
	end
end

function FreeScuffleSkillBagView:_getCurCreepsId()
	return checknumber(self._curIdx and self._creepsIdList[self._curIdx])
end

function FreeScuffleSkillBagView:_onUpdateUI()
	self:_onUpdatePageColUI()
	self:_onUpdateSkillColUI()
	self:_onUpdatePetInfo()
	self:_onUpdatePropertyColUI()
end

local AttrRank = {
	GameEnum.AttrType.Hp,
	GameEnum.AttrType.Speed,
	GameEnum.AttrType.Attack,
	GameEnum.AttrType.DefensePhysical
}

function FreeScuffleSkillBagView:_onUpdatePropertyColUI()
	local creepsId = self:_getCurCreepsId()
	local petMo = self._petMoDic[creepsId]

	for index, attrType in ipairs(AttrRank) do
		local mainGo = self._Attrs.transform:GetChild(index - 1).gameObject
		local ImgC_Icon = goutil.findChild(mainGo, "ImgC_Icon")
		local ImgC_Score = goutil.findChild(mainGo, "ImgC_Score")
		local TxtC_Name = goutil.findChildTextComponent(mainGo, "TxtC_Name")
		local TxtC_Value = goutil.findChildTextComponent(mainGo, "TxtC_Value")

		if petMo then
			if not petMo.attrMo.finalAttrs[attrType] then
				local value = 0
				local itemAttr = ItemAttr.Get(mainGo)

				itemAttr:SetIsRate(value > 0 and value < 1)
				itemAttr:SetValue(attrType, value)

				local propertyName = GameEnum.PetAttrScoreTitle[attrType]
				local score = petMo and BagPetsController.instance:getPetAttrScore(petMo, propertyName) or 0

				itemAttr:setScore(score)
			end
		end
	end
end

function FreeScuffleSkillBagView:_onUpdatePageColUI()
	local list = {}
	local curCreepsId = self:_getCurCreepsId()
	local isHeroPet = FreeScuffleController.instance:isHeroPetInBattle(self._activityId, curCreepsId)

	if isHeroPet then
		for _, skillType in ipairs(FreeScuffleEnum.SkillTypes) do
			table.insert(list, skillType)
		end
	else
		for _, skillType in ipairs(FreeScuffleEnum.SkillTypes) do
			if skillType ~= FreeScuffleEnum.SkillTypes_Hero then
				table.insert(list, skillType)
			end
		end
	end

	self._pageScrollerList:reloadData(list)
end

function FreeScuffleSkillBagView:_onClearPageCol()
	self._pageScrollerList:dispose()
end

function FreeScuffleSkillBagView:_updatePageCell(view, cell, skillType, tag)
	local curCreepsId = self:_getCurCreepsId()
	local orginSkillid = FreeScuffleController.instance:getCreepsSkillId(self._activityId, curCreepsId, skillType)
	local skillIndex = FreeScuffleEnum.SkillIndexs[skillType]

	if self._skillListInPets[curCreepsId] then
		if not self._skillListInPets[curCreepsId][skillIndex] then
			local withSkillId = 0
			local isUseOrgin = withSkillId <= 0
			local matSkillId = 0

			if isUseOrgin then
				if orginSkillid > 0 then
					matSkillId = orginSkillid
				end
			else
				local skillData = FreeScuffleConfig.instance:getSkillData(self._activityId, withSkillId)

				matSkillId = skillData.battleSkillId
			end

			local mainGo = cell.gameObject
			local icon = goutil.findChild(mainGo, "icon")
			local tagSwitch = goutil.findChild(mainGo, "tagSwitch")
			local tagSelect = goutil.findChild(mainGo, "tagSelect")
			local txtPage = goutil.findChildTextComponent(mainGo, "txtPage")
			local name = goutil.findChild(mainGo, "name")
			local txtName = goutil.findChildTextComponent(mainGo, "name/txt")

			txtPage.text = skillType

			GameUtil.SetActive(name, matSkillId > 0)
			GameUtil.SetActive(tagSelect, self._curSkillType == skillType)
			GameUtil.setUIGroupIdx(tagSwitch, isUseOrgin and 0 or 1)

			if matSkillId > 0 then
				MaterialMgr.setCell(MatType.Skill, matSkillId, icon)

				txtName.text = MaterialMgr.getMaterialsName(MatType.Skill, matSkillId)
			else
				MaterialMgr.resetAll(icon)

				txtName.text = ""
			end

			if not self._pressHelpers[mainGo] then
				local pressHelper = BtnLongPressHelper.create(mainGo)

				pressHelper:addClickHandler(function()
					if self._curSkillType == skillType then
						return
					end

					self._curSkillType = skillType

					self:_onUpdatePageColUI()
					self:_onUpdateSkillColUI()
				end)
				pressHelper:addLongPressStartHandler(function()
					if matSkillId > 0 then
						CommonTipsMgr.instance:openMaterialTips(mainGo, MatType.Skill, matSkillId)
					end
				end)
				GameUtil.addClickHandler(tagSwitch, function()
					if isUseOrgin then
						return
					end

					local curCreepsId = self:_getCurCreepsId()
					local skillIndex = FreeScuffleEnum.SkillIndexs[skillType]

					if not self._skillListInPets[curCreepsId][skillIndex] then
						local withSkillId = 0
						local withCreepsId = checknumber(self._skillToPets[withSkillId])

						for _, creepsId in ipairs({
							curCreepsId,
							withCreepsId
						}) do
							if self._skillListInPets[creepsId] then
								if not self._skillListInPets[creepsId][skillIndex] then
									self._skillListInPets[creepsId][skillIndex] = 0
									self._skillToPets[self._skillListInPets[creepsId][skillIndex]] = 0
								end
							end
						end

						self._curSkillType = skillType
						self._skillListInPets[curCreepsId][skillIndex] = 0

						self:_onUpdatePageColUI()
						self:_onUpdateSkillColUI()
					end
				end)
			end
		end
	end
end

function FreeScuffleSkillBagView:_clearPageCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")

	MaterialMgr.resetAll(icon)

	local pressHelper = self._pressHelpers[mainGo]

	if pressHelper then
		pressHelper:clearAllHandlers()
	end
end

function FreeScuffleSkillBagView:_onUpdateSkillColUI()
	if not self._skillLists[self._curSkillType] then
		local list = {}

		self._skillScrollerList:reloadData(list)
		GameUtil.SetActive(self._emptySkill, #list <= 0)
	end
end

function FreeScuffleSkillBagView:_onClearSkillCol()
	self._skillScrollerList:dispose()
end

function FreeScuffleSkillBagView:_updateSkillCell(view, cell, skillId, tag)
	local curCreepsId = self:_getCurCreepsId()
	local withCreepsId = checknumber(self._skillToPets[skillId])
	local petData = FreeScuffleConfig.instance:getScuffleBattlePetData(self._activityId, withCreepsId)
	local skillData = FreeScuffleConfig.instance:getSkillData(self._activityId, skillId)
	local skinId = checknumber(petData and petData.faceId)

	if skinId <= 0 then
		skinId = petData and petData.raceId or 0
	end

	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local tagIcon = goutil.findChild(mainGo, "tagWith/icon")
	local tagWith = goutil.findChild(mainGo, "tagWith")
	local tagSelect = goutil.findChild(mainGo, "tagSelect")
	local txtName = goutil.findChildTextComponent(mainGo, "name/txt")

	txtName.text = MaterialMgr.getMaterialsName(MatType.Skill, skillData.battleSkillId)

	MaterialMgr.setCell(MatType.Skill, skillData.battleSkillId, icon)

	if skinId > 0 then
		MaterialMgr.setIcon(tagIcon, MatType.Pet, skinId, nil, nil)
	else
		MaterialMgr.clearIcon(tagIcon)
	end

	GameUtil.SetActive(tagSelect, curCreepsId == withCreepsId and withCreepsId ~= 0)
	GameUtil.SetActive(tagWith, withCreepsId > 0)

	if not self._pressHelpers[mainGo] then
		local pressHelper = BtnLongPressHelper.create(mainGo)

		self._pressHelpers[mainGo]:addClickHandler(function()
			local curCreepsId = self:_getCurCreepsId()

			if skillData.type == FreeScuffleEnum.SkillTypes_Hero then
				local isHeroPet = FreeScuffleController.instance:isHeroPetInBattle(self._activityId, curCreepsId)

				if not isHeroPet then
					FloatWordMgr.instance:show("非英雄精灵无法使用英雄技能")

					return
				end
			end

			local withCreepsId = checknumber(self._skillToPets[skillId])

			local function okFunc()
				local isSame = withCreepsId == curCreepsId and withCreepsId ~= 0
				local skillIndex = FreeScuffleEnum.SkillIndexs[skillData.type]

				for _, creepsId in ipairs({
					curCreepsId,
					withCreepsId
				}) do
					if self._skillListInPets[creepsId] then
						if not self._skillListInPets[creepsId][skillIndex] then
							self._skillListInPets[creepsId][skillIndex] = 0
							self._skillToPets[self._skillListInPets[creepsId][skillIndex]] = 0
						end
					end
				end

				if isSame then
					-- block empty
				else
					self._skillListInPets[curCreepsId][skillIndex] = skillId
					self._skillToPets[skillId] = curCreepsId
				end

				self:_onUpdatePageColUI()
				self:_onUpdateSkillColUI()
			end

			if withCreepsId > 0 and curCreepsId ~= withCreepsId then
				local tipsContent = string.format("该技能已被%s使用，是否进行替换？", petData.creepsName)

				TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
			else
				okFunc()
			end
		end)
		self._pressHelpers[mainGo]:addLongPressStartHandler(function()
			CommonTipsMgr.instance:openMaterialTips(mainGo, MatType.Skill, skillData.battleSkillId)
		end)
	end
end

function FreeScuffleSkillBagView:_clearSkillCell(cell)
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local tagIcon = goutil.findChild(mainGo, "tagWith/icon")

	MaterialMgr.resetAll(icon)
	MaterialMgr.clearIcon(tagIcon)

	local pressHelper = self._pressHelpers[mainGo]

	if pressHelper then
		pressHelper:clearAllHandlers()
	end
end

function FreeScuffleSkillBagView:_onUpdatePetInfo()
	local creepsId = self:_getCurCreepsId()
	local petData = FreeScuffleConfig.instance:getScuffleBattlePetData(self._activityId, creepsId)
	local skinId = checknumber(petData and petData.faceId)

	if skinId <= 0 then
		skinId = petData and petData.raceId or 0
	end

	if skinId > 0 then
		self:_updateRole(skinId)
	else
		self._role = RoleObjectPool.instance:removeRole(self._role)
	end

	if petData then
		self._txtName.text = petData.creepsName or ""
	end

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	else
		MaterialMgr.resetAll(self._pointRare)
	end
end

function FreeScuffleSkillBagView:_updateRole(skinId)
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, function(go)
					if self._matList == nil then
						self._matList = {}
					end

					local list = go:GetComponentsInChildren(typeof(Spine.Unity.SkeletonGraphic), true)

					for i = 0, list.Length - 1 do
						local skeletonGraphic = list[i]
						local mat = self._matList[i]

						if mat == nil then
							mat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
							self._matList[i] = mat
						end

						mat.mainTexture = skeletonGraphic.material.mainTexture
						skeletonGraphic.material = mat
					end
				end, true, modelCfg[1], y)
			end
		end
	end
end

function FreeScuffleSkillBagView:_onClearPetInfo()
	if self._matList then
		for k, v in pairs(self._matList) do
			goutil.destroy(v)

			self._matList[k] = nil
		end
	end

	self._role = RoleObjectPool.instance:removeRole(self._role)

	MaterialMgr.resetAll(self._pointRare)
end

function FreeScuffleSkillBagView:_switchPet(delta)
	local length = #self._creepsIdList

	self._curIdx = (self._curIdx + delta - 1) % length + 1

	self:_onUpdateUI()
end

function FreeScuffleSkillBagView:_onClickBtnJump()
	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:close()
	end

	FreeScuffleCardPoolView.DefaultPoolType = FreeScuffleEnum.PoolTypes_Skill

	UIStateManager.instance:push(ViewName.FreeScuffleCardPoolView, self._activityId, FreeScuffleEnum.PoolTabs_Skill)
end

return FreeScuffleSkillBagView
