-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonCutePetInfoView.lua

module("logic.extensions.season.view.SeasonCutePetInfoView", package.seeall)

local SeasonCutePetInfoView = class("SeasonCutePetInfoView", ViewComponent)

function SeasonCutePetInfoView:ctor()
	SeasonCutePetInfoView.super.ctor(self)
end

function SeasonCutePetInfoView:unbindEvents()
	SeasonCutePetInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._btnClearInput)
	self._inputSearch:RemoveOnValueChanged()
	self._customInput:RemoveListener()

	for i, v in ipairs(self._filterList) do
		GameUtil.rmClickHandler(v.go)
	end
end

function SeasonCutePetInfoView:bindEvents()
	SeasonCutePetInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilterList, self)
	GameUtil.addClickHandler(self._btnClearInput, self._onClickClearInput, self)
	self._inputSearch:AddOnValueChanged(self._onSearchTextChanged, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)

	for i, v in ipairs(self._filterList) do
		GameUtil.addClickHandler(v.go, function()
			self:_onClickFilter(i)
		end, self)
	end
end

function SeasonCutePetInfoView:buildUI()
	SeasonCutePetInfoView.super.buildUI(self)

	self._btnClose = self:getGo("topleft/btn_close")
	self._btnRule = self:getGo("topleft/btnRules")
	self._btnSure = self:getGo("btnSure")
	self._txtPetName = self:getTxt("info/basicInfo/txtName")
	self._imgQuality = self:getGo("info/basicInfo/imgQuality")
	self._changePetType = goutil.findChildComponent(self.mainGO, "info/basicInfo/imgType", "UIImageSpriteChange")
	self._headIconGo = self:getGo("info/basicInfo/headCon/ImgIcon")
	self._txtGainTips = self:getTxt("info/basicInfo/gainTips/txt")
	self._txtLevel = self:getTxt("info/basicInfo/txtLv")
	self._starList = {}

	for i = 1, 6 do
		table.insert(self._starList, {
			star = self:getGo("info/basicInfo/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "info/basicInfo/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._attrTableView = self:getGo("info/attrInfo/ScrollView")
	self._attrTableCell = self:getGo("info/attrInfo/attrCell")
	self._txtTalent = self:getTxt("info/talentSkill/txtDesc")
	self._talentEmpty = self:getGo("info/talentSkill/empty")
	self._txtStarSkill = self:getTxt("info/starSkill/skillCell/bg/txtDesc")
	self._txtStar = self:getTxt("info/starSkill/skillCell/star/txt")
	self._petTableView = self:getGo("petTableview")
	self._petTableCell = self:getGo("petTableCell")
	self._talentTableView = self:getGo("talentTableview")
	self._talentTableCell = self:getGo("talentTableCell")
	self._inputSearch = self:getInput("InputC_Search")
	self._btnClearInput = self:getGo("InputC_Search/BtnClear")
	self._btnFilter = self:getGo("btnFilter")
	self._filterContent = self:getGo("content")
	self._customInput = UICustomInput.Get(self:getGo("content"))
	self._filterList = {}

	for i = 0, self._filterContent.transform.childCount - 1 do
		local filterGo = self._filterContent.transform:GetChild(i)
		local changeGroup = filterGo:GetComponent(ComponentType.UIChangeGroup)

		table.insert(self._filterList, {
			go = filterGo,
			selectChange = changeGroup
		})
	end
end

function SeasonCutePetInfoView:onExit()
	SeasonCutePetInfoView.super.onExit(self)
	uGuiUtil.clearImage(self._headIconGo)
end

function SeasonCutePetInfoView:onEnter()
	SeasonCutePetInfoView.super.onEnter(self)

	self._attrTableList = ScrollerList.create(self._attrTableView, self._attrTableCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._petTableList = ScrollerList.create(self._petTableView, self._petTableCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self._talentTableList = ScrollerList.create(self._talentTableView, self._talentTableCell, GameUtil.handler(self._updateTalentCell, self), GameUtil.handler(self._clearTalentCell, self))

	local cutePetList = SeasonMainCampConfig.instance:getAllCutePetInfo()
	local params = self:getOpenParam()

	self._teamId = params[1]
	self._raceId = params[2].raceId

	local teamMO = SeasonTeamsModel.instance:getTeam(self._teamId)

	self.cutePetMap = teamMO:getCutePetInfoMap()

	local cutePetInfo = self.cutePetMap[self._raceId]

	GameUtil.SetActive(self._filterContent, false)

	self._filterJob = {}

	if cutePetInfo then
		self._equipPetId = cutePetInfo.cutePetType or 0
	end

	if cutePetInfo then
		self._selectPetId = cutePetInfo.cutePetType or cutePetList[1].cutePetType
	end

	if cutePetInfo then
		self._selectTalentId = cutePetInfo.cutePetTalentId or 0
	end

	self:_refreshView()
end

function SeasonCutePetInfoView:_refreshView()
	self:_refreshFilterContent()
	self:_refreshPetList()

	local attrRes = {}
	local levelCfg = SeasonMainCampConfig.instance:getCutePetLevelInfoList(self._selectPetId)
	local mainLevel = SeasonMainCampModel.instance:getCampLv()
	local cutePetLevelCfg

	for i, v in ipairs(levelCfg) do
		if mainLevel >= v.campLv then
			cutePetLevelCfg = v
		else
			break
		end
	end

	cutePetLevelCfg = cutePetLevelCfg or levelCfg[1]

	local attrs = {}

	self._txtStarSkill.text = cutePetLevelCfg.desc
	self._txtLevel.text = cutePetLevelCfg.showLevel
	self._txtStar.text = cutePetLevelCfg.showStar

	for i = 1, #self._starList do
		if i <= cutePetLevelCfg.showStar then
			self._starList[i].starChange:SetState(0)
		else
			self._starList[i].starChange:SetState(1)
		end

		if i <= cutePetLevelCfg.showStar then
			GameUtil.SetActive(self._starList[i].star, true)
		else
			GameUtil.SetActive(self._starList[i].star, false)
		end
	end

	attrs = FightingPowerFormula.instance:parseAttrValues(cutePetLevelCfg.propertyApp) or {}
	attrRes = AttrMo.addSameAttrs(attrs, attrRes)

	local talentCfgs = SeasonMainCampConfig.instance:getCutePetTalentInfo(self._selectPetId)
	local talentCfg = talentCfgs[self._selectTalentId]

	if talentCfg then
		maxLevel = 0

		for i, v in pairs(talentCfg) do
			if maxLevel < v.campLv and mainLevel >= v.campLv then
				maxLevel = v.campLv
			end
		end

		local curTalentCfg = talentCfg[maxLevel]

		attrs = FightingPowerFormula.instance:parseAttrValues(curTalentCfg.propertyApp) or {}
		attrRes = AttrMo.addSameAttrs(attrs, attrRes)
		self._txtTalent.text = curTalentCfg.desc

		GameUtil.SetActive(self._talentEmpty, false)
	else
		self._txtTalent.text = ""

		GameUtil.SetActive(self._talentEmpty, true)
	end

	local attrList = {}

	for i, v in pairs(attrRes) do
		table.insert(attrList, {
			attrType = i,
			attrValue = v
		})
	end

	table.sort(attrList, function(a, b)
		return a.attrType < b.attrType
	end)

	for i, v in ipairs(attrList) do
		attrList[i].index = i
	end

	self._attrTableList:reloadData(attrList)

	local selectTalentCfgs = {}

	for talentId, v in ipairs(talentCfgs) do
		maxLevel = -1

		local minLevel = math.huge

		for campLv, cfg in pairs(v) do
			if campLv <= mainLevel and campLv > maxLevel then
				maxLevel = campLv
			end

			if campLv < minLevel then
				minLevel = campLv
			end
		end

		if maxLevel > 0 then
			table.insert(selectTalentCfgs, v[maxLevel])
		else
			table.insert(selectTalentCfgs, v[minLevel])
		end
	end

	table.sort(selectTalentCfgs, function(a, b)
		if a.campLv ~= b.campLv then
			return a.campLv < b.campLv
		else
			return a.talentId < b.talentId
		end
	end)
	self._talentTableList:reloadData(selectTalentCfgs)

	local cutePetCfg = SeasonMainCampConfig.instance:getCutePetInfo(self._selectPetId)

	uGuiUtil.setSpriteToImage(self._headIconGo.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCutePetIconUrl(cutePetCfg.cutePetIcon))

	self._txtPetName.text = cutePetCfg.cutePetName

	self._changePetType:SetState(cutePetCfg.cutePetJob - 1)
	GameUtil.SetActive(self._txtGainTips, mainLevel < cutePetCfg.openCampLv)
	GameUtil.SetActive(self._txtPetName, mainLevel >= cutePetCfg.openCampLv)
	GameUtil.SetActive(self._imgQuality, mainLevel >= cutePetCfg.openCampLv)
	GameUtil.SetActive(self._txtLevel, mainLevel >= cutePetCfg.openCampLv)
	GameUtil.SetActive(self._changePetType, mainLevel >= cutePetCfg.openCampLv)

	self._txtGainTips.text = langPara("主营地%d级解锁", cutePetCfg.openCampLv)
end

function SeasonCutePetInfoView:_refreshPetList()
	local cutePetList = SeasonMainCampConfig.instance:getAllCutePetInfo()
	local cutePetShowList = {}

	for i, v in ipairs(cutePetList) do
		local insertResult = ItemFilter.checkIsMatch(self._filterJob, v.cutePetJob) == true

		if ((not string.nilorempty(self._fillterName) and not string.find(v.cutePetName, self._fillterName) or nil) and false) == true then
			table.insert(cutePetShowList, v)
		end
	end

	table.sort(cutePetShowList, function(a, b)
		local isEquipA = a.cutePetType == self._equipPetId
		local isEquipB = b.cutePetType == self._equipPetId

		if isEquipA ~= isEquipB then
			return isEquipA
		end

		local isUnlockA = SeasonMainCampModel.instance:getCampLv() >= a.openCampLv
		local isUnlockB = SeasonMainCampModel.instance:getCampLv() >= a.openCampLv

		if isUnlockA ~= isUnlockB then
			return isUnlockA
		end

		return a.cutePetType < b.cutePetType
	end)
	self._petTableList:reloadData(cutePetShowList)
end

function SeasonCutePetInfoView:_refreshFilterContent()
	for i, v in ipairs(self._filterList) do
		if self._filterJob[i] then
			v.selectChange:SetState(1)
		else
			v.selectChange:SetState(0)
		end
	end
end

function SeasonCutePetInfoView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgChange = go:GetComponent(ComponentType.UIImageColorChange)
	local txtName = goutil.findChildTextComponent(go, "txtType")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local typeChange = goutil.findChildComponent(go, "icon", "UIImageSpriteChange")

	typeChange:SetState(data.attrType - 1)

	txtNum.text = data.attrValue >= 1 and string.format("%d", math.floor(data.attrValue)) or string.format("%.2f%%", data.attrValue * 100)

	bgChange:SetState(data.index % 2)

	txtName.text = GameEnum.AttrTypeName[data.attrType]
end

function SeasonCutePetInfoView:_clearAttrCell(cell)
	return
end

function SeasonCutePetInfoView:_updateTalentCell(view, cell, data, tag)
	local go = cell.gameObject
	local lockGo = goutil.findChild(go, "lock")
	local selectGo = goutil.findChild(go, "selectBg")
	local isSelectGo = goutil.findChild(go, "selectBg/select")
	local txtDesc = goutil.findChildTextComponent(go, "txt")
	local btnClick = goutil.findChild(go, "btnClick")

	txtDesc.text = data.desc

	GameUtil.SetActive(lockGo, data.campLv > SeasonMainCampModel.instance:getCampLv())
	GameUtil.SetActive(selectGo, data.campLv <= SeasonMainCampModel.instance:getCampLv())
	GameUtil.SetActive(isSelectGo, data.talentId == self._selectTalentId)
	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		if data.campLv <= SeasonMainCampModel.instance:getCampLv() then
			self:_onClickTalent(data.talentId)
		else
			FloatWordMgr.instance:show(langPara("主营地%d级解锁", data.campLv))
		end
	end)
end

function SeasonCutePetInfoView:_clearTalentCell(cell)
	return
end

function SeasonCutePetInfoView:_updatePetCell(view, cell, data, tag)
	local go = cell.gameObject
	local selectGo = goutil.findChild(go, "imgSelect")
	local icon = goutil.findChild(go, "itemCon/ImgIcon")
	local changeType = goutil.findChildComponent(go, "itemCon/imgType", "UIImageSpriteChange")
	local btnClick = goutil.findChild(go, "raycast")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local lockGo = goutil.findChild(go, "lock")
	local txtLockTip = goutil.findChildTextComponent(go, "lock/txt")
	local txtLv = goutil.findChildTextComponent(go, "txtLevel")
	local levelCfg = SeasonMainCampConfig.instance:getCutePetLevelInfoList(data.cutePetType)
	local mainLevel = SeasonMainCampModel.instance:getCampLv()
	local cutePetLevelCfg

	for i, v in ipairs(levelCfg) do
		if mainLevel >= v.campLv then
			cutePetLevelCfg = v
		else
			break
		end
	end

	cutePetLevelCfg = cutePetLevelCfg or levelCfg[1]
	txtLv.text = string.format("Lv.%d", cutePetLevelCfg.showLevel)

	local maxStar = cutePetLevelCfg.showStar

	for i = 1, 6 do
		local star = goutil.findChild(go, "starLv/star_" .. i)
		local starChange = goutil.findChildComponent(go, "starLv/star_" .. i, "UIImageSpriteChange")

		GameUtil.SetActive(star, i <= maxStar)

		if i <= cutePetLevelCfg.showStar then
			starChange:SetState(0)
		else
			starChange:SetState(1)
		end
	end

	txtName.text = data.cutePetName

	changeType:SetState(data.cutePetJob - 1)
	GameUtil.SetActive(selectGo, data.cutePetType == self._selectPetId)
	GameUtil.rmClickHandler(btnClick)
	GameUtil.addClickHandler(btnClick, function()
		self:_onClickPet(data.cutePetType)
	end)
	GameUtil.SetActive(lockGo, data.openCampLv > SeasonMainCampModel.instance:getCampLv())

	txtLockTip.text = langPara("主营地%d级解锁", data.openCampLv)

	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCutePetIconUrl(data.cutePetIcon))
end

function SeasonCutePetInfoView:_clearPetCell(cell)
	local go = cell.gameObject
	local btnClick = goutil.findChild(go, "raycast")
	local icon = goutil.findChild(go, "itemCon/ImgIcon")

	GameUtil.rmClickHandler(btnClick)
	uGuiUtil.clearImage(icon)
end

function SeasonCutePetInfoView:_onClickPet(petType)
	local cutePetCfg = SeasonMainCampConfig.instance:getCutePetInfo(petType)

	if cutePetCfg.openCampLv > SeasonMainCampModel.instance:getCampLv() then
		-- block empty
	end

	self._selectPetId = petType

	self:_refreshView()
end

function SeasonCutePetInfoView:_onClickTalent(talentId)
	self._selectTalentId = talentId

	self:_refreshView()
end

function SeasonCutePetInfoView:_onClickSure()
	local cutePetCfg = SeasonMainCampConfig.instance:getCutePetInfo(self._selectPetId)

	if cutePetCfg.openCampLv > SeasonMainCampModel.instance:getCampLv() then
		FloatWordMgr.instance:show(lang("萌宠未解锁"))

		return
	end

	if checknumber(self._selectTalentId) <= 0 then
		FloatWordMgr.instance:show(lang("请选择一个天赋"))

		return
	end

	SeasonController.instance:sendAndSetPetCutePetInfo(self._teamId, self._raceId, self._selectPetId, self._selectTalentId)
	self:close()
end

function SeasonCutePetInfoView:_onClickRule()
	TipsFacade.instance:openRulesView("chongwu_rule")
end

function SeasonCutePetInfoView:_onClickFilterList()
	GameUtil.SetActive(self._filterContent, true)
end

function SeasonCutePetInfoView:_onClickFilter(filterId)
	if self._filterJob[filterId] then
		self._filterJob[filterId] = nil
	else
		self._filterJob[filterId] = true
	end

	self:_refreshFilterContent()
	self:_refreshPetList()
end

function SeasonCutePetInfoView:_onSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._fillterName then
		self._fillterName = text

		self:_refreshPetList()
	end
end

function SeasonCutePetInfoView:_onClickClearInput()
	self._inputSearch:SetText("")

	self._fillterName = ""

	self:_refreshPetList()
end

function SeasonCutePetInfoView:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._filterContent, false)
	end
end

return SeasonCutePetInfoView
