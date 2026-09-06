-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetShowInfoStackNew.lua

module("logic.extensions.bag.view.stack.PetShowInfoStackNew", package.seeall)

local PetShowInfoStackNew = class("PetShowInfoStackNew", ViewComponent)
local localDataKey = "PetShowInfo_"
local AttrRank = {
	GameEnum.AttrType.Hp,
	GameEnum.AttrType.Attack,
	GameEnum.AttrType.Speed,
	GameEnum.AttrType.DefensePhysical,
	GameEnum.AttrType.DefenseMagic
}
local AttrName = {
	[GameEnum.AttrType.Attack] = "_attack",
	[GameEnum.AttrType.DefensePhysical] = "_physicalDefence",
	[GameEnum.AttrType.DefenseMagic] = "_magicDefence",
	[GameEnum.AttrType.Hp] = "_maxHp",
	[GameEnum.AttrType.Speed] = "_speed",
	[GameEnum.AttrType.HitRate] = "_hitRate",
	[GameEnum.AttrType.DodgeRate] = "_dodgeRate",
	[GameEnum.AttrType.StrikeRate] = "_strikeRate",
	[GameEnum.AttrType.BlockRate] = "_blockRate",
	[GameEnum.AttrType.CriticalRate] = "_criticalRate",
	[GameEnum.AttrType.AntiCriticalRate] = "_antiCriticalRate"
}

function PetShowInfoStackNew:ctor(go, view)
	PetShowInfoStackNew.super.ctor(self)

	self._cacheV3 = Vector3.New(0, 0, 0)
end

function PetShowInfoStackNew:destroyUI()
	PetShowInfoStackNew.super.destroyUI(self)
end

function PetShowInfoStackNew:unbindEvents()
	PetShowInfoStackNew.super.unbindEvents(self)
	self._btnAddExp:RemoveClickListener()
	self._btnMore:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnPowerCheck)
	GameUtil.rmClickHandler(self.btnRune)
	GameUtil.rmClickHandler(self.btnAwake)
	GameUtil.rmClickHandler(self.btnShenqi)
	GameUtil.rmClickHandler(self.btnShenyao)
	GameUtil.rmClickHandler(self.btnContract)
	GameUtil.rmClickHandler(self._btnJuanyou)
	GameUtil.rmClickHandler(self._btnShenshi)
	GameUtil.rmClickHandler(self._btnShuLing)
	GameUtil.rmClickHandler(self._btnTianjue)
	GameUtil.rmClickHandler(self._btnTianjueContract)
	self._btnShare:RemoveClickListener()
	self._btnPetBond:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnChangePetTitle)
	GameUtil.rmClickHandler(self._btnShowName)
end

function PetShowInfoStackNew:bindEvents()
	PetShowInfoStackNew.super.bindEvents(self)
	self._btnAddExp:AddClickListener(self._onClickAddExp, self)
	self._btnMore:AddClickListener(self._onClickMore, self)
	GameUtil.addClickHandler(self.btnPowerCheck, self._onClickPowerCheck, self)
	GameUtil.addClickHandler(self.btnRune, self.onClickRune, self)
	GameUtil.addClickHandler(self.btnAwake, self.onClickAwake, self)
	GameUtil.addClickHandler(self.btnShenqi, self.onClickShenqi, self)
	GameUtil.addClickHandler(self.btnShenyao, self.onClickShenyao, self)
	GameUtil.addClickHandler(self.btnContract, self.onClickContract, self)
	GameUtil.addClickHandler(self._btnJuanyou, self._onClickJuanyou, self)
	GameUtil.addClickHandler(self._btnShenshi, self._onClickShenshi, self)
	GameUtil.addClickHandler(self._btnShuLing, self._onClickShuLing, self)
	GameUtil.addClickHandler(self._btnTianjue, self._onClickBtnTianjue, self)
	GameUtil.addClickHandler(self._btnTianjueContract, self._onClickBtnTianjueContract, self)
	self._btnShare:AddClickListener(self._onClickShare, self)
	self._btnPetBond:AddClickListener(self._onClickBond, self)
	self._btnLock:AddClickListener(self._onClickLock, self)
	GameUtil.addClickHandler(self._btnChangePetTitle, self._onClickChangePetTitle, self)
	GameUtil.addClickHandler(self._btnShowName, self._onClickShowName, self)
end

function PetShowInfoStackNew:onExit()
	PetShowInfoStackNew.super.onExit(self)

	self._role = RoleObjectPool.instance:removeRole(self._role)

	for i, obj in ipairs(self._petListInBond) do
		MaterialMgr.resetAll(obj.go)
		GameUtil.SetActive(obj.go, false)
	end

	MaterialMgr.resetAll(self._rarePoint)

	self._skillInfoList = {}
	self._skillGroupList = {}

	for _, go in ipairs(self._skillTabsGoList) do
		goutil.destroy(go, true)
	end

	self._skillTabsGoList = {}

	GameUtil.saveUserData(localDataKey .. "IsShowPetName", self._isShowPetName)
	self:_resetNode()
end

function PetShowInfoStackNew:buildUI()
	self._roleContainer = self:getGo("infoview/card/role")
	self.btnContract = self:getGo("downtween/layoutBtn/btnContract")
	self.iconContract = self:getGo("downtween/layoutBtn/btnContract/icon")
	self._txtContract = self:getTxt("downtween/layoutBtn/btnContract/txt")
	self._btnJuanyou = self:getGo("downtween/layoutBtn/btnJuanyou")
	self._iconJuanyou = self:getGo("downtween/layoutBtn/btnJuanyou/icon")
	self._btnShenshi = self:getGo("downtween/layoutBtn/btnShenshi")
	self._iconShenshi = self:getGo("downtween/layoutBtn/btnShenshi/icon")
	self._btnShuLing = self:getGo("downtween/layoutBtn/btnShuLing")
	self._iconShuLing = self:getGo("downtween/layoutBtn/btnShuLing/icon")
	self.btnAwake = self:getGo("downtween/btnAwake")
	self.imgAwake = self:getGo("downtween/btnAwake/imgLv")
	self.lockAwake = self:getGo("downtween/btnAwake/imgLock")
	self.redAwake = self:getGo("downtween/btnAwake/red_point")
	self.btnShenqi = self:getGo("downtween/layoutBtn/btnShenqi")
	self.imgShenqi = self:getGo("downtween/layoutBtn/btnShenqi/imgLv")
	self.redShenqi = self:getGo("downtween/layoutBtn/btnShenqi/red_point")
	self.btnShenyao = self:getGo("downtween/layoutBtn/btnShenyao")
	self.imgShenyao = self:getGo("downtween/layoutBtn/btnShenyao/imgLv")
	self.redShenyao = self:getGo("downtween/layoutBtn/btnShenyao/red_point")
	self._btnTianjue = self:getGo("downtween/layoutBtn/btnTianjue")
	self._btnTianjueContract = self:getGo("downtween/layoutBtn/btnTianjueContract")
	self.btnRune = self:getGo("btnRune")
	self.runeGo = self:getGo("btnRune/stargod")
	self.txtRuneName = self:getTxt("btnRune/stargod/txtName")
	self.runeIcon = goutil.findChildComponent(self.mainGO, "btnRune/stargod/icon", "UIImageSpriteChange")
	self.runeImgLock = self:getGo("btnRune/imgLock")
	self._rarePoint = self:getGo("righttween/con")
	self._txtName = goutil.findChildComponent(self.mainGO, "righttween/txt_name", "Text")
	self._rawName = goutil.findChild(self.mainGO, "righttween/rawName")
	self._txtRawName = goutil.findChildComponent(self.mainGO, "righttween/rawName/txt", "Text")
	self._imgJob = goutil.findChildComponent(self.mainGO, "righttween/job/icon", "UIImageSpriteChange")
	self._imgJob1 = goutil.findChildComponent(self.mainGO, "righttween/job1/icon", "UIImageSpriteChange")
	self._imgJob.transform.name = "jobIcon"
	self._imgJob1.transform.name = "job1Icon"
	self._initJob1X, self._initJob1Y, self._initJob1Z = Framework.TransformUtil.GetLocalPos(self._imgJob.transform, 0, 0, 0)
	self._initJob2X, self._initJob2Y, self._initJob2Z = Framework.TransformUtil.GetLocalPos(self._imgJob1.transform, 0, 0, 0)
	self._initJob1Size = self._imgJob:GetComponent(typeof(UnityEngine.RectTransform)).sizeDelta
	self._initJob2Size = self._imgJob1:GetComponent(typeof(UnityEngine.RectTransform)).sizeDelta
	self._imgAttr = goutil.findChildComponent(self.mainGO, "righttween/attr/icon", "UIImageSpriteChange")
	self._Job = goutil.findChild(self.mainGO, "righttween/job")
	self._Job1 = goutil.findChild(self.mainGO, "righttween/job1")
	self._Attr = goutil.findChild(self.mainGO, "righttween/attr")
	self._txtPower = goutil.findChildComponent(self.mainGO, "lefttween/up/txt_power", "Text")
	self._txtLv = goutil.findChildComponent(self.mainGO, "downtween/btnLevelUp/lv/txt_lv", "Text")
	self._sliderExp = goutil.findChildComponent(self.mainGO, "downtween/btnLevelUp/lv/bloodbar", "Slider")
	self.talentRedGo = self:getGo("downtween/btnLevelUp/red_point")
	self.btnPowerCheck = self:getGo("lefttween/up/btnPowerCheck")
	self._btnAddExp = self:getBtn("downtween/btnLevelUp")
	self._txtExp = goutil.findChildComponent(self.mainGO, "downtween/btnLevelUp/lv/txt_power", "Text")
	self._btnMore = self:getBtn("lefttween/bg_shuxing/btn_more")
	self._posGo = self:getGo("lefttween/bg_shuxing")

	local _Nego_Attr = self:getGo("lefttween/Attrs")
	local attrGo = self:getGo("lefttween/item_attr")

	self._Nego_Attr = _Nego_Attr
	self._Attrs = {}

	for k, _ in ipairs(AttrRank) do
		local go = goutil.cloneAndSetParent(attrGo, _Nego_Attr.transform, "item_attr_" .. k)

		GameUtil.SetActive(go, true)

		self._Attrs[#self._Attrs + 1] = go
	end

	self._isShowDetail = true
	self._txtJob = goutil.findChildTextComponent(self.mainGO, "middle/txt_job")
	self._txtStrategy = goutil.findChildTextComponent(self.mainGO, "middle/txt_Desc")
	self.starGo = self:getGo("lefttween/starLv")
	self._starItem = PetStarItem.New(self.starGo)
	self._btnShare = self:getBtn("btnShare")
	self._CVGo = goutil.findChild(self.mainGO, "righttween/CV")
	self._txtCvName = goutil.findChildTextComponent(self.mainGO, "righttween/CV/txtName")
	self._infoView = self:getGo("lefttween/infoView/Viewport/Content")

	self:_buildPetBond()

	self._lock = self:getGo("righttween/lock")
	self._btnLock = Framework.ButtonAdapter.Get(self._lock)
	self._btnShowName = self:getGo("righttween/btnShowName")

	self:_buildSkillsNode()

	self._txtPetTitle = self:getTxt("lefttween/up/petTitle/txtPetTitle")
	self._btnChangePetTitle = self:getBtn("lefttween/up/petTitle/btnChange")
	self._petTitleTagGo = self:getGo("lefttween/up/petTitle/tag")
	self._txtPetTitleTag = self:getTxt("lefttween/up/petTitle/tag/txtTag")
	self._petTitleRedGo = self:getGo("lefttween/up/petTitle/dot")

	GameUtil.SetActive(self._petTitleRedGo, false)
	self:_updatePetTitle()
	self:_updatePetTitleBtnState()

	self._borrowTimeGo = self:getGo("borrowTime")
	self._txtBorrowTime = self:getTxt("borrowTime/txtBorrowTime")
	self._downtween = self:getGo("downtween"):GetComponent(ComponentType.TweenPosition)
	self._lefttween = self:getGo("lefttween"):GetComponent(ComponentType.TweenPosition)
	self._righttween = self:getGo("righttween"):GetComponent(ComponentType.TweenPosition)
	self._borrowtween = self:getGo("borrowTime"):GetComponent(ComponentType.TweenPosition)
end

function PetShowInfoStackNew:_buildPetBond()
	self._goBtnPetBond = self:getGo("lefttween/infoView/Viewport/Content/btnPetBond")
	self._btnPetBond = self:getBtn("lefttween/infoView/Viewport/Content/btnPetBond/btn_more")
	self._txtBondName = goutil.findChildTextComponent(self._goBtnPetBond, "txtName")
	self._txtDescGo = goutil.findChild(self._goBtnPetBond, "txtDesc")
	self._txtDesc = goutil.findChildTextComponent(self._goBtnPetBond, "txtDesc")
	self._txtDescCha = goutil.findChildComponent(self._goBtnPetBond, "txtDesc", "UITextColorChange")
	self._petListInBondExtGo = goutil.findChild(self._goBtnPetBond, "petListInBondExt")
	self._petListInBond = {}

	local petItem = {}

	petItem.go = goutil.findChild(self._goBtnPetBond, "petListInBondExt/pet_" .. 1)

	table.insert(self._petListInBond, petItem)

	for i = 2, 4 do
		local petItem = {}

		petItem.go = goutil.findChild(self._goBtnPetBond, "petListInBondExt/other/pet_" .. i)

		table.insert(self._petListInBond, petItem)
	end
end

function PetShowInfoStackNew:_buildSkillsNode()
	self._skillsNode = goutil.findChild(self.mainGO, "lefttween/infoView/Viewport/Content/skillsNode")

	local _Nego_Skill = goutil.findChild(self.mainGO, "lefttween/infoView/Viewport/Content/skillsNode/skillList/viewport/Nego_Skill")
	local skillCell = goutil.findChild(self.mainGO, "lefttween/cell")

	self._skillGoList = {}

	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local go = goutil.clone(skillCell)

		go.transform:SetParent(_Nego_Skill.transform, false)

		self._skillGoList[#self._skillGoList + 1] = go
	end

	sortedKeys = MaterialMgr.getPsychicSkillSortedKeys()
	self._psychicSkillsNode = goutil.findChild(self.mainGO, "lefttween/infoView/Viewport/Content/psychicSkillsNode")
	_Nego_Skill = goutil.findChild(self.mainGO, "lefttween/infoView/Viewport/Content/psychicSkillsNode/Nego_Skill")
	self._psychicSkillGoList = {}

	for index, skillType in ipairs(sortedKeys) do
		local go = goutil.clone(skillCell)

		go.transform:SetParent(_Nego_Skill.transform, false)

		self._psychicSkillGoList[#self._psychicSkillGoList + 1] = go
	end
end

function PetShowInfoStackNew:_updateJob(mo)
	local cfg = CharacterConfig.instance:getPetCo(mo.raceId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(mo.curFaceId)

	self._imgJob:SetState(firstJobIdx - 1)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(mo.curFaceId)

	race = race % 10

	local targetValue = race - 1

	self._imgAttr:SetState(targetValue)
	GameUtil.asBtn(self._Attr):RemoveClickListener()
	GameUtil.asBtn(self._Attr):AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._Attr, MatType.Race, race)
	end)
	GameUtil.asBtn(self._Job):RemoveClickListener()

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(mo.curFaceId)

	GameUtil.asBtn(self._Job):AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._Job, MatType.Job, firstJobIdx)
	end)

	self._txtJob.text = ConstString.JobIdxToStr[firstJobIdx]

	GameUtil.SetActive(self.btnContract, false)
	GameUtil.SetActive(self._btnJuanyou, false)
	GameUtil.SetActive(self._btnShenshi, false)
	GameUtil.SetActive(self.iconContract, false)
	MaterialMgr.resetAll(self.iconContract)

	self._txtContract.text = ""

	MaterialMgr.clearIcon(self._iconJuanyou)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(mo.curFaceId)

	GameUtil.SetActive(self.btnShenqi, secondJobIdx == GameEnum.CareerType.Shenqi)
	GameUtil.SetActive(self.btnShenyao, PetSkinConfig.instance:checkHasJob(mo.curFaceId, GameEnum.CareerType.ShenYao))

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)

	goutil.setActive(self._Job1, false)

	local isSwap = false

	if secondJobIdx > 20 then
		if PetSkinConfig.instance:checkHasJob(mo.curFaceId, GameEnum.CareerType.Zhaohuanshi) then
			GameUtil.SetActive(self.btnContract, true)
			GameUtil.SetActive(self.iconContract, true)

			if skinCfg and skinCfg.summonSkillId then
				local skillCfg = BattleConfig.instance:getSkillCo(skinCfg.summonSkillId, mo.curFaceId)
				local proxy = MaterialMgr.setCell(MatType.Skill, skinCfg.summonSkillId, self.iconContract)

				if proxy then
					proxy:setAutoTips(false)
				end

				self._txtContract.text = skillCfg.name
			end
		end

		goutil.setActive(self._Job1, true)
		self._imgJob1:SetState(secondJobIdx - 1 - 20)

		self._txtJob.text = ConstString.JobIdxToStr[secondJobIdx]
		isSwap = true

		GameUtil.asBtn(self._Job):AddClickListener(function()
			CommonTipsMgr.instance:openMaterialTips(self._Job, MatType.Job, secondJobIdx)
		end)
		GameUtil.asBtn(self._Job1):AddClickListener(function()
			local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(mo.curFaceId)

			CommonTipsMgr.instance:openMaterialTips(self._Job1, MatType.Job, firstJobIdx)
		end)
	end

	self:_updateJobIcon(isSwap)

	if checknumber(mo.contractSkillId) > 0 then
		GameUtil.SetActive(self.btnContract, true)
		GameUtil.SetActive(self.iconContract, true)

		local skillCfg = BattleConfig.instance:getSkillCo(checknumber(mo.contractSkillId), mo.curFaceId)
		local proxy = MaterialMgr.setCell(MatType.Skill, checknumber(mo.contractSkillId), self.iconContract)

		if proxy then
			proxy:setAutoTips(false)
		end

		self._txtContract.text = skillCfg.name
	end

	if skinCfg and checknumber(skinCfg.carriedSkillId) > 0 then
		GameUtil.SetActive(self._btnJuanyou, true)

		local colligationMo = MaterialMgr.getModel(MatType.Pet, mo.carriedPetId)

		if colligationMo then
			MaterialMgr.setIcon(self._iconJuanyou, MatType.Pet, colligationMo.curFaceId)
		end
	end

	if mo.carriedPetId > 0 then
		local carriedPetMo = MaterialMgr.getModel(MatType.Pet, mo.carriedPetId)

		if carriedPetMo then
			MaterialMgr.setIcon(self._iconJuanyou, MatType.Pet, carriedPetMo.curFaceId)
		end
	end

	if skinCfg and checknumber(skinCfg.oracleSkillId) > 0 then
		GameUtil.SetActive(self._btnShenshi, true)

		local colligationMo = MaterialMgr.getModel(MatType.Pet, mo.oraclePetId)

		if colligationMo then
			MaterialMgr.setIcon(self._iconShenshi, MatType.Pet, colligationMo.curFaceId)
		end
	end

	if mo.oraclePetId > 0 then
		local oracleMo = MaterialMgr.getModel(MatType.Pet, mo.oraclePetId)

		if oracleMo then
			MaterialMgr.setIcon(self._iconShenshi, MatType.Pet, oracleMo.curFaceId)
		end
	end

	if ContractConfig.instance:getBookSpiritCfgs(mo.raceId) ~= nil then
		GameUtil.SetActive(self._btnShuLing, true)
		MaterialMgr.clearIcon(self._iconShuLing)
	else
		MaterialMgr.clearIcon(self._iconShuLing)
		GameUtil.SetActive(self._btnShuLing, false)
	end

	if mo.bookSpiritPetId > 0 then
		local bookSpiritMo = MaterialMgr.getModel(MatType.Pet, mo.bookSpiritPetId)

		if bookSpiritMo then
			MaterialMgr.setIcon(self._iconShuLing, MatType.Pet, bookSpiritMo.curFaceId)
		end
	end
end

function PetShowInfoStackNew:_updateJobIcon(isSwap)
	print("isSwap = " .. tostring(isSwap))

	local img1 = self._imgJob
	local img2 = self._imgJob1

	if isSwap then
		img1 = self._imgJob1
		img2 = self._imgJob
	end

	img1.transform:SetParent(self._Job.transform)
	img2.transform:SetParent(self._Job1.transform)
	Framework.TransformUtil.SetLocalPos(img1.transform, self._initJob1X, self._initJob1Y, self._initJob1Z)
	Framework.TransformUtil.SetLocalPos(img2.transform, self._initJob2X, self._initJob2Y, self._initJob2Z)

	img1:GetComponent(typeof(UnityEngine.RectTransform)).sizeDelta = self._initJob1Size
	img2:GetComponent(typeof(UnityEngine.RectTransform)).sizeDelta = self._initJob2Size
end

function PetShowInfoStackNew:_updateSkill(data)
	self._skillInfoList = {}
	self._skillGroupList = {}
	self._skillTabsGoList = self._skillTabsGoList or {}

	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	self:_updateSkillsByTypes(data, sortedKeys, MaterialMgr.SkillName)

	sortedKeys = MaterialMgr.getPsychicSkillSortedKeys()

	self:_updateSkillsByTypes(data, sortedKeys, MaterialMgr.PsychicSkillName)

	local skillBtns = goutil.findChild(self.mainGO, "lefttween/infoView/Viewport/Content/skillsNode/btns").transform
	local btnskill = goutil.findChild(self.mainGO, "lefttween/infoView/Viewport/Content/skillsNode/btns/btnSkill")

	for _, go in ipairs(self._skillTabsGoList) do
		GameUtil.SetActive(go, false)
	end

	for id, name in ipairs(self._skillGroupList) do
		local btnCell = self._skillTabsGoList[id]

		if not btnCell then
			btnCell = goutil.cloneAndSetParent(btnskill, skillBtns, "btnSkill_" .. id)

			table.insert(self._skillTabsGoList, btnCell)
		end

		local txt = goutil.findChildTextComponent(btnCell, "txt")

		GameUtil.setLocalPos(btnCell, (id - 1) * 124, 0, 0)

		txt.text = name

		GameUtil.SetActive(btnCell, true)
		GameUtil.addClickHandler(btnCell, GameUtil.handler(self._updateSkillCellInfo, self, name, id))
	end

	self:_updateSkillCellInfo(self._skillGroupList[1], 1)
end

function PetShowInfoStackNew:_updateSkillCellInfo(skillTypeName, id)
	for index, go in ipairs(self._skillTabsGoList) do
		local imgChange = GameUtil.getUIChangeGroup(go)

		imgChange:SetState(index == id and 1 or 0)
	end

	for index, v in ipairs(self._skillGoList) do
		local go = self._skillGoList[index]
		local con = goutil.findChild(go, "icon")
		local txt = goutil.findChildTextComponent(go, "txt_skillname")
		local txtSkillLv = goutil.findChildTextComponent(go, "txt_skill_lv")
		local txtSkillType = goutil.findChildTextComponent(go, "txt_skill_type")
		local tonglingIcon = goutil.findChild(go, "tonglingIcon")
		local data = self._skillInfoList[index]

		if data and data.skillTypName == skillTypeName then
			MaterialMgr.resetAll(con)
			go:SetActive(true)

			local proxy = MaterialMgr.setSkillByFaceId(data.skillId, data.curFaceId, con)

			if proxy then
				proxy:setAutoTips(false)
			end

			GameUtil.asBtn(go):AddClickListener(GameUtil.handler(self._OnClickSkill, self, data.skillType, data.skillId, go))

			txt.text = data.name
			txtSkillLv.text = data.skillLv
			txtSkillType.text = MaterialMgr.getSkillTypeName(data.skillId, data.curFaceId)

			goutil.setActive(tonglingIcon, data.isPsychicSkill)
		else
			go:SetActive(false)
		end
	end
end

function PetShowInfoStackNew:_updateSkillsByTypes(data, sortedKeys, skillNameList)
	local curFaceId = data.curFaceId
	local petCo = PetSkinConfig.instance:getPetSkinCfg(curFaceId)

	for index, skillType in ipairs(sortedKeys) do
		local skillData = {}
		local v = skillNameList[skillType]
		local skillId = checknumber(petCo[v])
		local lvl = skillId % 10
		local key = MaterialMgr.SkillLvlKey[skillType]

		if not string.nilorempty(key) then
			lvl = data[key]

			if data[key] then
				local skillInfocfg = CharacterConfig.instance:getSkillInfoByLvl(curFaceId, lvl)

				if skillInfocfg then
					skillId = checknumber(skillInfocfg[v])
				else
					printError("配置缺失 petId", data.petId, "curFaceId", curFaceId, "lvl", lvl)
				end
			end
		end

		local skillCfg = BattleConfig.instance:getSkillCo(skillId)

		if skillCfg and skillId > 0 then
			skillData.typeName = MaterialMgr.getSkillTypeName(skillId, curFaceId)

			if skillCfg.isNotShowLvl == 1 then
				skillData.skillLv = ConstString.SkillType[skillType]
				skillData.skillType = MaterialMgr.getSkillTypeName(skillId, curFaceId)
				skillData.skillTypName = "职业技能"

				if skillType == GameEnum.SkillRaceType.Normal or skillType == GameEnum.SkillRaceType.Ult then
					skillData.skillTypName = "技能"
				end
			else
				skillData.skillLv = langPara("等级%s", lvl)
				skillData.skillType = skillType
				skillData.skillTypName = "技能"
			end

			if not string.nilorempty(MaterialMgr.PsychicSkillName[skillType]) then
				skillData.isPsychicSkill = true
			end

			skillData.name = skillCfg.name
			skillData.skillId = skillId
			skillData.curFaceId = curFaceId

			table.insert(self._skillInfoList, skillData)

			if not TableUtil.isHad(self._skillGroupList, skillData.skillTypName) then
				table.insert(self._skillGroupList, skillData.skillTypName)
			end
		else
			print("=======>>>>>>>>>>找不到技能 id = ", skillId)
		end
	end
end

function PetShowInfoStackNew:_OnClickSkill(skillType, skillId, go)
	local data = BagPetsController.instance:GetCurPetMo()

	if skillType == GameEnum.SkillRaceType.Domain then
		ViewMgr.instance:open(ViewName.DomainSkillTipsView, data.curFaceId, skillId)

		return
	end

	if data ~= nil and skillType == GameEnum.SkillRaceType.Summon then
		local canContractLvl = ContractConfig.instance:getConstValueByKey("SUMMON_MASTER_MIN_LVL")

		if data.level >= checknumber(canContractLvl) then
			-- block empty
		else
			FloatWordMgr.instance:show(langPara("等级还没达到%s级不可以契约", canContractLvl))
		end

		if not data[MaterialMgr.SkillLvlKey[skillType]] then
			local skillLv = 1

			CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillId, data.curFaceId, skillLv, data)
		end
	elseif not data[MaterialMgr.SkillLvlKey[skillType]] then
		local skillLv = 1

		CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillId, data.curFaceId, skillLv, data)
	end
end

function PetShowInfoStackNew:onEnter()
	PetShowInfoStackNew.super.onEnter(self)
	MopupModel.instance:setPetTalentUpCostStr()

	self._isShowPetName = GameUtil.getUserData(localDataKey .. "IsShowPetName") or false

	self:_ShowPetDetail()
	self.addGEvent(self, GlobalNotify.OnPetSelect, self._ShowPetDetail, self)
	self.addGEvent(self, GlobalNotify.OpenLevelUpView, self._onOpenLevelUpView, self)
	self.addGEvent(self, GlobalNotify.PetTitleModelInit, self._updatePetTitleBtnState, self)
	self.addGEvent(self, GlobalNotify.PetTitleModelChange, self._updatePetTitleBtnState, self)
	self.addGEvent(self, GlobalNotify.PetShowViewNodeFold, self._onPetShowViewNodeFold, self)
	self.addGEvent(self, GlobalNotify.BagPetChanged, self._ShowPetDetail, self)

	if BagPetsFacade.instance:getOnceFlag() then
		self:_onClickAddExp(true)
	end

	self._curSelectType = ""
	self._isFold = false

	self:_resetNode()
end

function PetShowInfoStackNew:_onOpenLevelUpView()
	self:_onClickAddExp(true)
end

function PetShowInfoStackNew:_ShowPetDetail()
	local bagPetMo = BagPetsController.instance:GetCurPetMo()

	self:setData(bagPetMo)
	self:_updateLock(true)
	Framework.TransformUtil.SetLocalPos(self._infoView.transform, 0, 0, 0)
end

function PetShowInfoStackNew:setData(mo)
	self._petMo = mo

	local isSkining = false

	if mo ~= nil then
		self._txtName.text = not string.nilorempty(mo.skinOtherName) and mo.skinOtherName or mo.name

		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)

		if skinCfg then
			self._txtRawName.text = skinCfg.name
			isSkining = skinCfg.skinName ~= skinCfg.name

			GameUtil.SetActive(self._btnShowName, isSkining)
		end

		local proxy = MaterialMgr.setCell(MatType.Rare, mo.raceId, self._rarePoint)

		if proxy then
			proxy.binder:setRare(mo.rare)
		end

		self:_updateJob(mo)

		local cvName = PetSkinConfig.instance:getSkinCvName(mo.curFaceId)

		self._txtCvName.text = cvName

		GameUtil.SetActive(self._CVGo, not string.nilorempty(cvName))

		local canCheck = self:checkPetCanPowerCheck()

		GameUtil.SetActive(self.btnPowerCheck, canCheck)
		GameUtil.SetActive(self._btnTianjue.gameObject, false)
		GameUtil.SetActive(self._btnTianjueContract.gameObject, skinCfg.heavenAwakenSkillId > 0)

		self._txtLv.text = mo.level
		self._txtPower.text = mo:getFightingPower()

		local curExp = mo:getCurExceedExp()
		local needExp = mo:getNextLvlExp()
		local isMaxLv = mo:isMaxLv()

		self._txtExp.text = isMaxLv and lang("已满级") or string.format("%s/%s", curExp, needExp)
		self._sliderExp.value = needExp <= 0 and 1 or curExp / needExp

		GameUtil.SetActive(self.talentRedGo, false)

		local maxTalentLv = CharacterConfig.instance:getMaxLvByTalentLv(mo.talentLevel)

		if not isMaxLv and mo.level == maxTalentLv then
			local isCanTalent = BagPetsController.instance:getTalentCanLvlup(mo)

			GameUtil.SetActive(self.talentRedGo, isCanTalent)
		end

		self:_updateSkill(mo)
		self:_updateAttrs(mo)

		local cfg = CharacterConfig.instance:getPetCo(mo.raceId)
		local petInfo = CharacterConfig.instance:getPetInfoCo(mo.raceId)

		self._txtStrategy.text = ""

		local ackType = ""

		if petInfo then
			local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(mo.curFaceId)

			if firstJobIdx > 0 then
				local jobCo = CharacterConfig.instance:getJobCo(firstJobIdx)

				if jobCo then
					if jobCo.attackType == 1 then
						ackType = lang("类型：<color='#eb4642'>【物理】</color>")
					elseif jobCo.attackType == 2 then
						ackType = lang("类型：<color='#1cc2ff'>【魔法】</color>")
					end
				end
			end

			ackType = ackType .. GameUtil.HtmlColorTxt(langPara("【%s】", ConstString.BestPosition[petInfo.bestPosition]), ConstString.BestPositionColor[petInfo.bestPosition])

			local ct = string.gsub(petInfo.stragegy, "\n", "，")

			self._txtStrategy.text = ackType .. "\n" .. ct
		end

		local isFirst = checknumber(cfg.awakenCostStrategyId) < 0

		self._starItem:updateStar(mo.awakeLevel, isFirst)
		GameUtil.SetGray(self._sliderExp, BagModel.instance:isPowerCrystalFollower(self._petMo.petId))
	end

	GameUtil.SetActive(self._rawName, self._isShowPetName and isSkining)
	self:_updateRune(mo)
	self:_updateAwake(mo)
	self:_updateBond(mo)
	self:_updatePetTitle(mo)
	self:_updatePetTitleBtnState()
	self:_updateBorrow(mo)
end

function PetShowInfoStackNew:_updateBond(data)
	if data == nil then
		return
	end

	GameUtil.SetActive(self._goBtnPetBond, false)

	for i, obj in ipairs(self._petListInBond) do
		MaterialMgr.resetAll(obj.go)
		GameUtil.SetActive(obj.go, false)
	end

	local isForm = false
	local cfg = CharacterConfig.instance:getBondCfgsOnForm(data.raceId, true)

	if cfg then
		isForm = true
	else
		cfg = CharacterConfig.instance:getBondCfgsCollect(data.raceId, true)
	end

	if cfg then
		self._txtBondName.text = isForm and lang("上阵羁绊：") .. cfg.name or lang("收集羁绊：") .. cfg.name

		local petlist = {}
		local petlistInCfg = cfg.relativeRaceIds

		table.insert(petlist, data.raceId)

		for i = 1, #petlistInCfg do
			table.insert(petlist, petlistInCfg[i])
		end

		if #petlistInCfg > 1 then
			GameUtil.setAnchoredPos(self._petListInBondExtGo, 88.8, -67.8)
		else
			GameUtil.setAnchoredPos(self._petListInBondExtGo, 111.6, -67.8)
		end

		local hasAll = true

		for i, raceId in ipairs(petlist) do
			local obj = self._petListInBond[i]

			GameUtil.SetActive(obj.go, true)

			local proxy = MaterialMgr.setCell(MatType.Pet, raceId, obj.go)
			local has = false

			has = isForm and BagModel.instance:isExistRaceId(raceId) or HandbookModel.instance:isHasPet(raceId)

			if proxy then
				proxy.binder:setUseLock(false)
				proxy.binder:setGray(not has)
			end

			if has then
				GameUtil.SetGray(obj.go, false)
			else
				hasAll = false

				GameUtil.SetGray(obj.go, true)
			end
		end

		self._txtDesc.text = cfg.desc

		GameUtil.SetGray(self._txtDescGo, not hasAll)
		GameUtil.SetActive(self._goBtnPetBond, true)
	end
end

function PetShowInfoStackNew:_updateAwake(petMo)
	if petMo == nil then
		return
	end

	GameUtil.SetActive(self.lockAwake, not FuncOpenModel.instance:getFuncIsOpen(49))
	GameUtil.SetActive(self.redAwake, BagPetsController.instance:getPetAwakeStatus(petMo))
	GameUtil.SetActive(self.redShenqi, DomainCultivateController.instance:getIfKamuiActive(petMo.petId))
	GameUtil.SetActive(self.redShenyao, DomainCultivateController.instance:getIfKamuiActive(petMo.petId))
	GameUtil.setUIImageSpriteIdx(self.imgAwake, petMo.awakeLevel)

	local com = GameUtil.getUIImageSpriteChange(self.imgShenqi)

	if com and #petMo:getKamuiInfos() > 0 then
		com:SetState(#petMo:getKamuiInfos() - 1)
		self.imgShenqi:GetComponent("Image"):SetNativeSize()
	end

	local com = GameUtil.getUIImageSpriteChange(self.imgShenyao)

	if com and #petMo:getKamuiInfos() > 0 then
		com:SetState(#petMo:getKamuiInfos() - 1)
		self.imgShenyao:GetComponent("Image"):SetNativeSize()
	end
end

function PetShowInfoStackNew:_updateRune(petMo)
	if petMo and petMo.runeSuit and petMo.runeSuit.runeSuitId > 0 then
		GameUtil.SetActive(self.runeGo, true)

		local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, petMo.runeSuit.runeSuitId)

		self.runeIcon:SetState(petMo.runeSuit.runeSuitId - 1)

		self.txtRuneName.text = cfg.name
	else
		GameUtil.SetActive(self.runeGo, false)
	end

	GameUtil.SetActive(self.runeImgLock, not FuncOpenModel.instance:getFuncIsOpen(72))
end

function PetShowInfoStackNew:_updateAttrs(data)
	for k, v in ipairs(AttrRank) do
		local na = AttrName[v]
		local value = data[na]
		local itemAttr = ItemAttr.Get(self._Attrs[k])

		itemAttr:SetIsRate(value > 0 and value < 1)
		itemAttr:SetValue(v, value)

		local propertyName = GameEnum.PetAttrScoreTitle[v]
		local score = BagPetsController.instance:getPetAttrScore(data, propertyName)

		itemAttr:setScore(score)
	end

	self.isExt = true
end

function PetShowInfoStackNew:_updatePetTitle(petMo)
	local petTitleName = lang("暂无称号")
	local petTitleTag = ""

	if petMo and petMo.petTitleId and petMo.petTitleId > 0 then
		local petTitleConf = PetTitleConfig.instance:getPetTitleConfig(petMo.petTitleId)

		if petTitleConf then
			petTitleName = petTitleConf.name
			petTitleTag = petTitleConf.tag
		end
	end

	self._txtPetTitle.text = petTitleName
	self._txtPetTitleTag.text = petTitleTag

	goutil.setActive(self._petTitleTagGo, not string.nilorempty(petTitleTag))
end

function PetShowInfoStackNew:_updatePetTitleBtnState()
	if self._petMo then
		local bNOtEmpty = true

		bNOtEmpty = self._petMo.raceId

		if self._petMo.raceId then
			if #PetTitleModel.instance:getTitleMoArrayByRaceId(self._petMo.raceId) <= 0 then
				bNOtEmpty = false
			end

			GameUtil.SetActive(self._btnChangePetTitle, bNOtEmpty)
			GameUtil.SetActive(self._petTitleRedGo, self._petMo and PetTitleModel.instance:checkPetIsRed(self._petMo.raceId))
		end
	end
end

function PetShowInfoStackNew:_updateBorrow(petMo)
	removetimer(self._onClockTime, self)
	GameUtil.SetActive(self._borrowTimeGo, false)

	self._txtBorrowTime.text = ""

	if petMo == nil then
		return
	end

	GameUtil.SetActive(self._borrowTimeGo, petMo:isBorrowPet())

	local time = (petMo.expiredTime - ServerTime.nowMs()) / 1000

	if time > 0 then
		self._borrowTime = petMo.expiredTime

		self:_onClockTime()
		settimer(1, self._onClockTime, self)
	else
		self._txtBorrowTime.text = lang("已过期")
	end
end

function PetShowInfoStackNew:_onClockTime()
	if self._borrowTime then
		local time = (self._borrowTime - ServerTime.nowMs()) / 1000

		if time > 0 then
			self._txtBorrowTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeWordsNoSec(time))
		else
			removetimer(self._onClockTime, self)

			local mo = BagPetsController.instance:GetCurPetMo()

			self:_updateBorrow(mo)
		end
	end
end

function PetShowInfoStackNew:setAttrs()
	local width = 160

	if self.isExt then
		-- block empty
	else
		width = 120
	end

	for k, v in ipairs(AttrRank) do
		local go = self._Attrs[k]

		ItemAttr.Get(go):setExt(self.isExt)
		GameUtil.setAnchoredPos(go, (k - 1) % 2 * width, -math.floor((k - 1) / 2) * 40)
	end
end

function PetShowInfoStackNew:_onClickBond()
	UIStateManager.instance:push(ViewName.PetBondDetailView, self._petMo.raceId)
end

function PetShowInfoStackNew:_onClickMore()
	local go = self._posGo
	local rect = go.gameObject:GetComponent("RectTransform")
	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	UIStateManager.instance:open(ViewName.PetAttrPopUpView, pos, (rect ~= nil or nil) and {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	})
end

function PetShowInfoStackNew:_onClickPowerCheck()
	UIStateManager.instance:push(ViewName.PetRankView, 1, self._petMo.raceId, false)
end

function PetShowInfoStackNew:checkPetCanPowerCheck()
	local cfg = MaterialMgr.getMatCfg(MatType.Pet, self._petMo.raceId)

	if cfg and cfg.hasZdlRank then
		local rare = CharacterConfig.instance:getRareByAwakenLv(cfg.initAwakenLv, self._petMo.raceId)

		if rare == GameEnum.PetRare.N then
			return false
		end

		return true
	end

	return false
end

function PetShowInfoStackNew:_onClickAddExp(ignoreTip)
	if self._petMo:isBorrowPet() then
		if ignoreTip ~= true then
			FloatWordMgr.instance:show("租借精灵不可升级")
		end

		return
	end

	if BagModel.instance:isPowerCrystalFollower(self._petMo.petId) then
		if ignoreTip ~= true then
			FloatWordMgr.instance:show("该精灵进驻在力量之核中，无法升级")
		end

		return
	end

	UIStateManager.instance:push(ViewName.PetOneKeyLvUpView)
end

function PetShowInfoStackNew:_onClickDetail()
	self._isShowDetail = not self._isShowDetail

	goutil.setActive(self._Nego_Attr, self._isShowDetail)
	goutil.setActive(self._roleContainer, not self._isShowDetail)
end

function PetShowInfoStackNew:_onBtnClick()
	self:_playCharacterAnim()
end

function PetShowInfoStackNew:onClickRune()
	local mo = BagPetsController.instance:GetCurPetMo()

	FuncOpenController.instance:openFunc(72, mo)

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(checknumber(72))
end

function PetShowInfoStackNew:onClickAwake()
	if FuncOpenController.instance:checkFuncIdOrShowLockTips(49) then
		local mo = BagPetsController.instance:GetCurPetMo()
		local maxLvl = CharacterConfig.instance:getMaxAwaken(mo.raceId)

		if maxLvl == 0 then
			TipsFacade.instance:openCommonTips(lang("当前精灵不可觉醒"))
		elseif mo.awakeLevel == maxLvl then
			TipsFacade.instance:openCommonTips(lang("当前精灵已经达到最大觉醒等级，不需要再觉醒了"))
		elseif mo:isBorrowPet() then
			TipsFacade.instance:openCommonTips(lang("租借精灵不可觉醒"))
		else
			UIStateManager.instance:push(ViewName.PetAwakeView)
		end
	end
end

function PetShowInfoStackNew:onClickShenqi()
	FuncOpenController.instance:openFunc(358, self._petMo.petId)
end

function PetShowInfoStackNew:onClickShenyao()
	FuncOpenController.instance:openFunc(865, self._petMo.petId)
end

function PetShowInfoStackNew:_playCharacterAnim()
	local mo = BagPetsController.instance:GetCurPetMo()

	if not mo then
		return
	end

	local animName = CharacterConfig.instance:getPetInfoCo(mo.curFaceId).action

	if not animName then
		return
	end

	if self._role and RoleObjectPool.instance:getCurAnimationName(self._role.asset) == "idle" then
		RoleObjectPool.instance:playAnimation(self._role.asset, animName, false, function()
			self:_resetCharacterAnim()
		end)
	end
end

function PetShowInfoStackNew:_resetCharacterAnim()
	if self._role then
		RoleObjectPool.instance:playAnimation(self._role.asset, "idle", true)
	end
end

function PetShowInfoStackNew:_onClickShare()
	UIStateManager.instance:open(ViewName.Share, GameEnum.ShareType.Pet, self._petMo.petId)
end

function PetShowInfoStackNew:_onClickLock()
	if not self._petMo:isBorrowPet() then
		local petId = self._petMo.petId

		BagPetsController.instance:changePetLockState(petId, not self._petMo:isLocked(), self._updateLock, self)
	else
		FloatWordMgr.instance:show(lang("该精灵不可上锁"))
	end
end

function PetShowInfoStackNew:_onClickChangePetTitle()
	if self._petMo then
		PetTitleModel.instance:saveClickOnce(self._petMo.raceId)
		PetTitleController.instance:showChangeCurPetTitle(self._petMo)
		self:_updatePetTitleBtnState()
	end
end

function PetShowInfoStackNew:onClickContract()
	if self._petMo:isSummonedMaster() then
		local canContractLvl = ContractConfig.instance:getConstValueByKey("SUMMON_MASTER_MIN_LVL")

		if self._petMo.level >= checknumber(canContractLvl) then
			UIStateManager.instance:push(ViewName.ContractListView, self._petMo)
		else
			FloatWordMgr.instance:show(langPara("等级还没达到%s级不可以契约", canContractLvl))
		end
	else
		UIStateManager.instance:push(ViewName.ContractskillpopView, self._petMo)
	end
end

function PetShowInfoStackNew:_onClickJuanyou()
	local list = BagPetsController.instance:getBagAndBorrowPets()

	UIStateManager.instance:push(ViewName.ChangeraceselectpopView, {
		self._petMo
	}, list)
end

function PetShowInfoStackNew:_onClickShenshi()
	local list = BagPetsController.instance:getBagAndBorrowPets()

	UIStateManager.instance:push(ViewName.OracleselectpopView, {
		self._petMo
	}, list)
end

function PetShowInfoStackNew:_onClickShuLing()
	local list = BagPetsController.instance:getBagAndBorrowPets()

	UIStateManager.instance:push(ViewName.BookSpiritSelectPopView, {
		self._petMo
	}, list)
end

function PetShowInfoStackNew:_onClickBtnTianjue()
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self._petMo.curFaceId)

	CommonTipsMgr.instance:openMaterialTips(self._btnTianjue.gameObject, MatType.Skill, skinCfg.heavenAwakenSkillId)
end

function PetShowInfoStackNew:_onClickBtnTianjueContract()
	UIStateManager.instance:push(ViewName.TianjuecontractlistView, self._petMo.raceId)
end

function PetShowInfoStackNew:_onClickShowName()
	print("[YuTestPrint] =====>\t 运行_onClickShowName")

	self._isShowPetName = not self._isShowPetName

	goutil.setActive(self._rawName, self._isShowPetName)
	GameUtil.saveUserData(localDataKey .. "IsShowPetName", self._isShowPetName)
end

function PetShowInfoStackNew:_updateLock(skipTip)
	if not self._petMo then
		return
	end

	GameUtil.SetActive(self._lock, not self._petMo:isBorrowPet())

	local locked = self._petMo:isLocked()
	local tip

	if skipTip ~= true then
		FloatWordMgr.instance:show(locked and "上锁成功~" or "解锁成功~")
	end

	self._lock:GetComponent("UIImageSpriteChange"):SetState(locked and 1 or 0)
end

function PetShowInfoStackNew:_onPetShowViewNodeFold(isFold)
	self._isFold = isFold

	self:_startTween()
end

function PetShowInfoStackNew:_resetNode()
	self:_stopTween()
	self:_startTween(0)
end

function PetShowInfoStackNew:_stopTween()
	self._lefttween:Stop()
	self._righttween:Stop()
end

function PetShowInfoStackNew:_setCacheV3(x, y)
	self._cacheV3.x = x
	self._cacheV3.y = y
end

local leftStart = {
	640,
	0
}
local leftEnd = {
	0,
	0
}
local rightStart = {
	-324.2,
	181.7
}
local rightEnd = {
	272,
	181.7
}
local borrowStart = {
	0,
	308
}
local borrowEnd = {
	0,
	397
}
local downStart = {
	-640,
	0
}
local downEnd = {
	-640,
	-250
}

function PetShowInfoStackNew:_startTween(time)
	time = time or 0.3

	if time == 0 then
		if self._isFold then
			GameUtil.setAnchoredPos(self._lefttween, leftEnd[1], leftEnd[2])
			GameUtil.setAnchoredPos(self._righttween, rightEnd[1], rightEnd[2])
			GameUtil.setAnchoredPos(self._borrowtween, borrowEnd[1], borrowEnd[2])
			GameUtil.setAnchoredPos(self._downtween, downEnd[1], downEnd[2])
		else
			GameUtil.setAnchoredPos(self._lefttween, leftStart[1], leftStart[2])
			GameUtil.setAnchoredPos(self._righttween, rightStart[1], rightStart[2])
			GameUtil.setAnchoredPos(self._borrowtween, borrowStart[1], borrowStart[2])
			GameUtil.setAnchoredPos(self._downtween, downStart[1], downStart[2])
		end

		return
	end

	if self._isFold then
		self:_setCacheV3(leftStart[1], leftStart[2])

		self._lefttween.from = self._cacheV3

		self:_setCacheV3(leftEnd[1], leftEnd[2])

		self._lefttween.to = self._cacheV3

		self:_setCacheV3(rightStart[1], rightStart[2])

		self._righttween.from = self._cacheV3

		self:_setCacheV3(rightEnd[1], rightEnd[2])

		self._righttween.to = self._cacheV3

		self:_setCacheV3(borrowStart[1], borrowStart[2])

		self._borrowtween.from = self._cacheV3

		self:_setCacheV3(borrowEnd[1], borrowEnd[2])

		self._borrowtween.to = self._cacheV3

		self:_setCacheV3(downStart[1], downStart[2])

		self._downtween.from = self._cacheV3

		self:_setCacheV3(downEnd[1], downEnd[2])

		self._downtween.to = self._cacheV3
	else
		self:_setCacheV3(leftEnd[1], leftEnd[2])

		self._lefttween.from = self._cacheV3

		self:_setCacheV3(leftStart[1], leftStart[2])

		self._lefttween.to = self._cacheV3

		self:_setCacheV3(rightEnd[1], rightEnd[2])

		self._righttween.from = self._cacheV3

		self:_setCacheV3(rightStart[1], rightStart[2])

		self._righttween.to = self._cacheV3

		self:_setCacheV3(borrowEnd[1], borrowEnd[2])

		self._borrowtween.from = self._cacheV3

		self:_setCacheV3(borrowStart[1], borrowStart[2])

		self._borrowtween.to = self._cacheV3

		self:_setCacheV3(downEnd[1], downEnd[2])

		self._downtween.from = self._cacheV3

		self:_setCacheV3(downStart[1], downStart[2])

		self._downtween.to = self._cacheV3
	end

	self._lefttween.time = time
	self._righttween.time = time
	self._borrowtween.time = time
	self._downtween.time = time

	self._lefttween:Begin()
	self._righttween:Begin()
	self._borrowtween:Begin()
	self._downtween:Begin()
end

return PetShowInfoStackNew
