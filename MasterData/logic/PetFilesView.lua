-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetFilesView.lua

module("logic.extensions.handbook.view.PetFilesView", package.seeall)

local PetFilesView = class("PetFilesView", TableViewComponent)
local SORT_NAME = {
	function(obj)
		return FightingPowerFormula.instance:getPetMaxFightingPower(obj.raceId)
	end,
	"rare",
	function(obj)
		return GameUtil.string2time(obj.piecesOnlineTime)
	end,
	"raceId"
}
local SORT_VALUE = {
	{
		-1,
		ArraySort.DESCENDING,
		ArraySort.NONE
	},
	{
		-1,
		ArraySort.DESCENDING,
		ArraySort.NONE
	},
	{
		-1,
		ArraySort.NONE,
		ArraySort.DESCENDING
	},
	{
		ArraySort.NONE
	}
}

function PetFilesView:ctor()
	PetFilesView.super.ctor(self)
end

function PetFilesView:destroyUI()
	PetFilesView.super.destroyUI(self)
end

function PetFilesView:onExitFinished()
	PetFilesView.super.onExitFinished(self)

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)
	end

	self._eff = nil
end

function PetFilesView:onEnterFinished()
	PetFilesView.super.onEnterFinished(self)
end

function PetFilesView:unbindEvents()
	PetFilesView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnShare:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._filterButton:RemoveClickListener()
	self._btnPetList:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function PetFilesView:bindEvents()
	PetFilesView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnShare:AddClickListener(self._onClickShare, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnSwitch:AddClickListener(self._onClickSwitch, self)
	self._btnDetail:AddClickListener(self._onClickDetail, self)
	self._filterButton:AddClickListener(self._onClickJob, self)
	self._btnPetList:AddClickListener(function()
		self:_onClickTab(true)
	end)
	self._btnInfo:AddClickListener(function()
		self:_onClickTab(false)
	end)
end

function PetFilesView:onExit()
	PetFilesView.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role2 = RoleObjectPool.instance:removeRole(self._role2)

	self:_clearCurSelected()
	self:_onClickTab(true)
end

function PetFilesView:_getPath()
	return {
		cellPath = "right/petlist/tablecell",
		viewPath = "right/petlist/tableview"
	}
end

function PetFilesView:buildUI()
	PetFilesView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._btnHome = self:getBtn("topleft/btnHome")

	local left = self:getGo("left")

	self._txtName = goutil.findChildTextComponent(left, "txtName")
	self._imgRare = goutil.findChildComponent(left, "imgRare", "Image")
	self._imgRareChange = self._imgRare:GetComponent("UIImageSpriteChange")
	self._imgAttr = goutil.findChildComponent(left, "Nego_Attr/Img_attr", "UIImageSpriteChange")
	self._imgJob = goutil.findChildComponent(left, "Nego_Job/ImgC_Job", "UIImageSpriteChange")
	self._imgJob1 = goutil.findChildComponent(left, "Nego_Job1/ImgC_Job", "UIImageSpriteChange")
	self._goJob1 = goutil.findChild(left, "Nego_Job1")
	self._imgSex = goutil.findChildComponent(left, "imgSex", "UIImageSpriteChange")
	self._btnDetail = Framework.ButtonAdapter.GetFrom(left, "btnDetail")
	self._btnShare = Framework.ButtonAdapter.GetFrom(left, "btnShare")

	local mid = self:getGo("mid")

	self._btnGet = Framework.ButtonAdapter.GetFrom(mid, "btnGet")
	self._btnSwitch = Framework.ButtonAdapter.GetFrom(mid, "btnSwitch")
	self._switchOn = goutil.findChild(self._btnSwitch.gameObject, "on")
	self._switchOff = goutil.findChild(self._btnSwitch.gameObject, "off")
	self._btnPetList = Framework.ButtonAdapter.GetFrom(mid, "btnPetList")
	self._btnInfo = Framework.ButtonAdapter.GetFrom(mid, "btnInfo")
	self._rolePoint = goutil.findChild(mid, "rolePoint")
	self._rolePoint2 = goutil.findChild(mid, "rolePoint2")
	self._txtPower = goutil.findChildTextComponent(mid, "power/txtPower")

	goutil.setActive(self._btnGet.gameObject, false)

	self._info = self:getGo("right/info")
	self._txtDesc = goutil.findChildTextComponent(self._info, "description/ScrollView/txtDesc")
	self._txtStrategy = goutil.findChildTextComponent(self._info, "strategy/ScrollView/txtStrategy")
	self._txtPosition = goutil.findChildTextComponent(self._info, "strategy/txtPosition")

	local Nego_Skill = goutil.findChild(self._info, "skill/Nego_Skill")
	local skillCell = goutil.findChild(Nego_Skill, "cell")

	self._Skills = {}

	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local go = goutil.clone(skillCell)

		go.transform:SetParent(Nego_Skill.transform, false)

		self._Skills[#self._Skills + 1] = go
	end

	self._petList = self:getGo("right/petlist")
	self._filterButton = Framework.ButtonAdapter.GetFrom(self._petList, "btnFilter")

	self:_onClickTab(true, true)

	self._canvas = goutil.findChildComponent(self.mainGO, "canvas", "Canvas")

	local canvas = UGUIToolHelper.FindCanvas(self.mainGO)

	self._canvas.sortingOrder = canvas.sortingOrder - 2
end

function PetFilesView:onEnter()
	PetFilesView.super.onEnter(self)

	local parm = self:getOpenParam()

	self.selectRaceId = nil

	if parm then
		self.selectRaceId = parm[1]

		self:_onClickTab(false)
	end

	self._isLihui = true

	HandbookController.instance:checkDataAndCall(self._updateUI, self)

	local path = "fx_ui_tujian/fx_ui_tujian_all.prefab"

	self._eff = UIEffectManager.instance:playHUDEffect(path, self._canvas, true, nil, nil, function(finishHandlerTarget, eff)
		GoUtil.SetSortingOrder(eff.effGo, self._canvas.sortingOrder + 1)
	end, nil, false)
end

function PetFilesView:_getPosAndSizeDelta(go)
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}
end

function PetFilesView:updateFilterData(starList, jobList, rareList)
	self:_updateList()
end

function PetFilesView:SetNextSort(idx)
	local v = self._sortValue[idx]

	v = v + 1

	local vArr = SORT_VALUE[idx]

	v = v % #vArr
	self._sortValue[idx] = v
end

function PetFilesView:GetSortParms()
	local parm1 = {}
	local parm2 = {}
	local sortName

	for k, v in ipairs(self._sortValue) do
		local vArr = SORT_VALUE[k]

		if vArr[v + 1] ~= -1 then
			table.insert(parm1, SORT_NAME[k])
			table.insert(parm2, vArr[v + 1])
		end
	end

	return parm1, parm2
end

function PetFilesView:_updateCell(view, cell, data)
	local container = goutil.findChild(cell.gameObject, "container")
	local imgQua = goutil.findChildComponent(container, "imgQua", "UIImageSpriteChange")
	local imgIcon = goutil.findChild(container, "imgIcon")
	local imgRare = goutil.findChildComponent(container, "imgRare", "Image")
	local imgRareChange = imgRare:GetComponent("UIImageSpriteChange")
	local progress = goutil.findChild(container, "progress")
	local imgProgress = goutil.findChildComponent(progress, "imgProgress", "Image")
	local txtProgress = goutil.findChildComponent(progress, "txtProgress", "Text")
	local selected = goutil.findChild(container, "selected")
	local goCanCompose = goutil.findChild(container, "canCompose")
	local btn = Framework.ButtonAdapter.Get(container)

	imgQua:SetState(data.rare + 1)
	imgRareChange:SetState(data.rare - 1)
	imgRare:SetNativeSize()

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.faceIds))
	local icon = modelCo == nil and "" or modelCo.headName

	uGuiUtil.setSpriteToImage(imgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(icon))
	goutil.setActive(selected, data == self._cfg)
	goutil.setActive(canCompose, false)

	local isHasPet = HandbookModel.instance:isHasPet(data.raceId)
	local curPieceNum = MaterialFacade.instance:getMatNumber(MatType.PetPiece, data.raceId)
	local needPieceNum = checknumber(data.needPieceNum)
	local canCompose = self:getCanCompose(data)
	local r, g, b = 1, 1, 1

	if not isHasPet and not canCompose then
		b = 0.4
		g = 0.4
		r = 0.396078431372549
	end

	Game.ImageUtil.SetColorRGBA(imgIcon:GetComponent("Image"), r, g, b, 1)
	goutil.setActive(goCanCompose, canCompose)

	if needPieceNum > 0 then
		imgProgress.fillAmount = curPieceNum / needPieceNum or 0
	end

	txtProgress.text = string.format("<size=18>%s/</size>%s", curPieceNum, needPieceNum)

	btn:AddClickListener(function()
		self:_onClickPet(data, canCompose)
	end)
end

function PetFilesView:_updateUI()
	self._curViewDatas = self:_getCurViewDatas()

	if self.selectRaceId then
		for k, cfg in pairs(self._curViewDatas) do
			if cfg.raceId == self.selectRaceId then
				self._cfg = cfg

				break
			end
		end

		self.selectRaceId = nil
	elseif self._cfg == nil then
		self._cfg = self._curViewDatas[1]
	end

	self:reloadData()
	self:_updateRightUI()
end

function PetFilesView:_updateList()
	self._curViewDatas = self:_getCurViewDatas()

	self:reloadData()
end

function PetFilesView:_updateRightUI()
	local cfg = CharacterConfig.instance:getModelCo(checknumber(self._cfg.faceIds))

	self._hasLihui = cfg ~= nil and not string.nilorempty(cfg.bustName)
	self._isHasPet = HandbookModel.instance:isHasPet(self._cfg.raceId)

	goutil.setActive(self._btnSwitch.gameObject, self._hasLihui and self._isHasPet)
	self:_updateInfo()
	self:_updateState()
end

function PetFilesView:_updateState()
	self._showLihui = self._isHasPet and self._isLihui and self._hasLihui or self._hasLihui

	goutil.setActive(self._switchOn, self._isLihui)
	goutil.setActive(self._switchOff, not self._isLihui)
	goutil.setActive(self._rolePoint, self._showLihui)
	goutil.setActive(self._rolePoint2, not self._showLihui)
	self:_updateDrawing()
end

function PetFilesView:_updateDrawing()
	local raceId = checknumber(self._cfg.faceIds)
	local object = CharactorFacade.instance
	local displayBagOffset = self._showLihui and object:getHandbookLihuiModelUIPosAndScale(raceId) or object:getHandbookModelUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	if self._showLihui then
		self._role = RoleObjectPool.instance:addRoleToParent(self._role, raceId, self._rolePoint, scale, function(go)
			return
		end, true, x, y)
	else
		self._role2 = RoleObjectPool.instance:addRoleToParent(self._role2, raceId, self._rolePoint2, scale, function(go)
			return
		end, false, x, y)
	end
end

function PetFilesView:_updateSpineMat(go)
	local r = goutil.findChildComponent(go, "skeleton", "SkeletonGraphic")

	if not self._isHasPet then
		self._tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphicFill"))
		self._tempMat.mainTexture = r.material.mainTexture
		r.material = self._tempMat

		self._tempMat:SetFloat("_FillPhase", 1)
		GoUtil.SetMatColor(self._tempMat, "_Color", 0.596078431372549, 0.7137254901960784, 0.807843137254902, 1)
	else
		self._tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
		self._tempMat.mainTexture = r.material.mainTexture
		r.material = self._tempMat

		GoUtil.SetMatColor(r.material, "_Color", 1, 1, 1, 1)
	end
end

function PetFilesView:_updateInfo()
	local petInfo = CharacterConfig.instance:getPetInfoCo(self._cfg.raceId)

	self._txtDesc.text = petInfo.introduce
	self._txtStrategy.text = petInfo.stragegy
	self._txtPosition.text = petInfo.bestPosition

	self:_updateSkill()

	self._txtName.text = self._cfg.name

	self._imgSex:SetState(self._cfg.gender - 1)
	self._imgRareChange:SetState(self._cfg.rare - 1)
	self._imgRare:SetNativeSize()

	self._txtPower.text = FightingPowerFormula.instance:getPetMaxFightingPower(self._cfg.raceId)

	local isHasPet = HandbookModel.instance:isHasPet(self._cfg.raceId)

	goutil.setActive(self._btnGet.gameObject, not isHasPet)
	goutil.setActive(self._btnDetail.gameObject, isHasPet)
	goutil.setActive(self._btnShare.gameObject, isHasPet)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(self._cfg.raceId)

	self._imgJob:SetState(firstJobIdx - 1)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(self._cfg.raceId)

	self._imgAttr:SetState(race - 1)
	goutil.setActive(self._goJob1, false)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(self._cfg.raceId)

	if secondJobIdx > 20 then
		goutil.setActive(self._goJob1, true)
		self._imgJob1:SetState(secondJobIdx - 1 - 20)
	end
end

function PetFilesView:_updateSkill()
	local petCo = PetSkinConfig.instance:getPetSkinCfg(self._cfg.raceId)
	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.SkillName[skillType]
		local go = self._Skills[index]
		local con = goutil.findChild(go, "icon")
		local txt = goutil.findChildTextComponent(go, "txt_skillname")
		local skillId = petCo[v]
		local txtSkillLv = goutil.findChildTextComponent(go, "txt_skill_lv")
		local txtSkillType = goutil.findChildTextComponent(go, "txt_skill_type")
		local skillCfg = BattleConfig.instance:getSkillCo(skillId)

		GameUtil.asBtn(go):RemoveClickListener()
		MaterialMgr.resetAll(con)

		if skillId == 0 then
			go:SetActive(false)
		else
			go:SetActive(true)

			local proxy = MaterialMgr.setSkillByFaceId(skillId, self._cfg.raceId, con)

			if proxy then
				proxy:setAutoTips(false)
			end

			GameUtil.asBtn(go):AddClickListener(function()
				CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillId, self._cfg.raceId)
			end)

			txtSkillType.text = MaterialMgr.getSkillTypeName(skillId, self._cfg.raceId)
			txtSkillLv.text = "等级" .. CharacterConfig.instance:getSkillMaxLv(petCo.raceId, skillType)
			txt.text = skillCfg.name
		end

		if skillType == GameEnum.SkillRaceType.Summon then
			go:SetActive(false)
		end
	end
end

function PetFilesView:_getCurViewDatas()
	local t = {}
	local cfgs = CharacterConfig.instance:getPetCfg()

	for _, cfg in ipairs(cfgs) do
		if self:_getIsFilter(cfg) then
			table.insert(t, cfg)
		end
	end

	table.sort(t, function(a, b)
		local x = self:getCanCompose(a)
		local y = self:getCanCompose(b)

		if x ~= y then
			return x == true
		else
			return checknumber(a.bookIds) < checknumber(b.bookIds)
		end
	end)

	return t
end

function PetFilesView:getCanCompose(cfg)
	local curPieceNum = MaterialFacade.instance:getMatNumber(MatType.PetPiece, cfg.raceId)
	local needPieceNum = checknumber(cfg.needPieceNum)

	return needPieceNum <= curPieceNum
end

function PetFilesView:_isMatch(cfg)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PET_FILES, cfg)
end

function PetFilesView:_getIsFilter(cfg)
	if string.nilorempty(cfg.bookIds) then
		return false
	end

	return self:_isMatch(cfg)
end

function PetFilesView:_onClickClose()
	PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_PET_FILES)
	self:close()
end

function PetFilesView:_onClickHome()
	UIStateManager.instance:clear(true)
end

function PetFilesView:_onClickPet(data, canCompose)
	if canCompose then
		PetAgent.instance:sendPM_CompositePetPiecesReq(data.raceId, function()
			print("compose success")
			self:_clearCurSelected()

			self._cfg = data

			self:_updateCellByData(data)
			self:_updateRightUI()
		end, self)
	else
		self:_clearCurSelected()

		self._cfg = data

		self:_updateCellByData(data)
		self:_updateRightUI()
	end
end

function PetFilesView:_onClickSwitch()
	self._isLihui = not self._isLihui

	self:_updateState()
end

function PetFilesView:_onClickTab(isPetList, isForce)
	if isForce or self._isPetList ~= isPetList then
		self._isPetList = isPetList

		goutil.setActive(self._petList, isPetList)
		goutil.setActive(self._info, not isPetList)
		goutil.setActive(self._btnPetList.gameObject, not isPetList)
		goutil.setActive(self._btnInfo.gameObject, isPetList)
	end
end

function PetFilesView:_clearCurSelected()
	local cfg = self._cfg

	self._cfg = nil

	if cfg ~= nil then
		self:_updateCellByData(cfg)
	end
end

function PetFilesView:_updateCellByData(data)
	for k, v in ipairs(self._curViewDatas) do
		if v == data then
			self._tableview:UpdateCellAtIndex(k - 1)
		end
	end
end

function PetFilesView:_onClickJob()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._filterButton.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_PET_FILES, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function PetFilesView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self.filterPane, false)
	end
end

function PetFilesView:_onClickShare()
	FloatWordMgr.instance:show("分享系统暂未开启")
end

function PetFilesView:_onClickDetail()
	if self._cfg then
		UIStateManager.instance:push(ViewName.PetDrawing, self._cfg.raceId)
	end
end

function PetFilesView:_onClickGet()
	if self._cfg then
		MaterialMgr.openGetSource(MatType.PetPiece, self._cfg.raceId)
	end
end

return PetFilesView
