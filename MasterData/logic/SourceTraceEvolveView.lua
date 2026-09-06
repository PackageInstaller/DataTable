-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/view/SourceTraceEvolveView.lua

module("logic.extensions.sourcetrace.view.SourceTraceEvolveView", package.seeall)

local SourceTraceEvolveView = class("SourceTraceEvolveView", ViewComponent)
local SKIP_KEY = "SourceTraceEvolveView_SKIP"
local State_Fold = 1
local State_UnFold = 2

function SourceTraceEvolveView:ctor()
	SourceTraceEvolveView.super.ctor(self)
end

function SourceTraceEvolveView:buildUI()
	SourceTraceEvolveView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableview = self:getGo("right/tableview")
	self._roleGo = self:getGo("role")
	self._maskGo = self:getGo("mask")
	self._effectGo = self:getGo("left/btnEvolve/effect")
	self._leftParent = self:getGo("left")
	self._rareGo = self:getGo("left/info/rare")
	self._attrChange = self:getGo("left/info/attr/img"):GetComponent(typeof(UIImageSpriteChange))
	self._career1 = self:getGo("left/info/career/img"):GetComponent(typeof(UIImageSpriteChange))
	self._career2 = self:getGo("left/info/career2/img"):GetComponent(typeof(UIImageSpriteChange))
	self._careerGo2 = self:getGo("left/info/career2")
	self._txtName = self:getTxt("left/info/txtName")
	self._txtDesc = self:getTxt("left/info/txtDesc")
	self._btnInfo = self:getBtn("left/info/btnInfo")
	self._txtBtnEvolve = self:getTxt("left/btnEvolve/txt")
	self._preChallengeGo = self:getGo("left/preChallenge")
	self._preEvolveGo = self:getGo("left/preEvolve")
	self._btnEvolve = self:getBtn("left/btnEvolve")
	self._btnTip = self:getBtn("btnTip")
	self._redPointExtChallenge = self:getGo("left/btnExtChallenge/redpoint")
	self._imgExtChallenge = self:getGo("left/btnExtChallenge")
	self._txtExtChallenge = self:getTxt("left/btnExtChallenge/txt")
	self._btnLook = self:getBtn("btnLook")
	self._btnChange = self:getBtn("btnChange")
	self._btnShop = self:getBtn("btnShop")
	self._imgSelect = self:getGo("btnSkip/imgSelect")
	self._btnSkip = self:getGo("btnSkip")
	self._preEvolveCells = {}

	for i = 1, 3 do
		local element = {}
		local go = self:getGo(string.format("left/preEvolve/cell%d", i))

		element.go = go
		element.bgIcon = self:getGo(string.format("left/preEvolve/cell%d/bgIcon", i))
		element.item = self:getGo(string.format("left/preEvolve/cell%d/item", i))
		element.txtNum = self:getTxt(string.format("left/preEvolve/cell%d/txtNum", i))
		element.btnAdd = self:getBtn(string.format("left/preEvolve/cell%d/btnAdd", i))
		element.mask = self:getGo(string.format("left/preEvolve/cell%d/btnAdd/imgMask1", i))
		element.plusGo = self:getGo(string.format("left/preEvolve/cell%d/btnAdd/img", i))
		element.awakenGo = self:getGo(string.format("left/preEvolve/cell%d/awakenLv", i))
		element.txtAwaken = self:getTxt(string.format("left/preEvolve/cell%d/awakenLv/txtNum", i))
		element.txtLevel = self:getTxt(string.format("left/preEvolve/cell%d/bgIcon/txtLevel", i))
		element.del = goutil.findChild(go, "del")
		element.lock = goutil.findChild(go, "btnAdd/lock")

		table.insert(self._preEvolveCells, element)
	end

	self._tip1 = self:getGo("left/bubble/tip1")
	self._tip2 = self:getGo("left/bubble/tip2")
	self._txtTips1 = self:getTxt("left/bubble/tip1/txt")
	self._txtTips2 = self:getTxt("left/bubble/tip2/txt")
	self._bgUnique = self:getGo("left/preEvolve/bgUnique")
	self._petSelectMaskGo = self:getGo("right/mask")
	self._petSelectRectTrans = self._tableview:GetComponent(goutil.Type_RectTransform)
	self._uiTableGrid = self._tableview:GetComponent("UITableGrid")
	self._btnUnfold = self:getBtn("right/tableview/btnUnfold")
	self._iconUnfold = goutil.findChild(self._btnUnfold, "icon")
	self._unfoldColorChange = self._iconUnfold:GetComponent(ComponentType.UIImageColorChange)
	self._btnFilter = self:getBtn("right/tableview/btnFilter")
	self._InputC_Search = self:getGo("right/tableview/InputC_Search"):GetComponent("InputField")
	self._btnClear = self:getBtn("right/tableview/InputC_Search/BtnClear")

	goutil.setActive(self._InputC_Search.gameObject, false)

	local cell = self:getGo("right/cell")

	self._scrollList = ScrollerList.create(self._tableview, cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
end

function SourceTraceEvolveView:bindEvents()
	SourceTraceEvolveView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnEvolve:AddClickListener(self._onClickEvolve, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnLook:AddClickListener(self._onClickLook, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._btnUnfold:AddClickListener(self._onClickUnfold, self)
	self._btnFilter:AddClickListener(self._onClickFilter, self)
	self._btnShop:AddClickListener(self._onClickShop, self)
	self._btnClear:AddClickListener(self._onClickClearSearch, self)

	self._onInputSearchValueChangedHandler = InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):AddLuaHandler(function(go, text)
		self:_OnSearchTextChanged(text)
	end)

	GameUtil.addClickHandler(self._btnSkip, self._onClickSkip, self)
end

function SourceTraceEvolveView:unbindEvents()
	SourceTraceEvolveView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnEvolve:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnLook:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnUnfold:RemoveClickListener()
	self._btnFilter:RemoveClickListener()
	self._btnClear:RemoveClickListener()
	InputFieldValueChangedHandler.Get(self._InputC_Search.gameObject):RemoveLuaHandler(self._onInputSearchValueChangedHandler)
	GameUtil.rmClickHandler(self._btnSkip)
end

function SourceTraceEvolveView:onEnter()
	SourceTraceEvolveView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineEvolvePlusRes, self._onDivineEvolveRes, self)
	self.addGEvent(self, GlobalNotify.SourceTraceEvolvePlusAnimationEnd, self._onAnimationEnd, self)
	DivineEvolveController.instance:registerNotify(DivineEvolvePlusController.UpdateEvolveCondition, self._onUpdateEvolveCondition, self)
	self:_initGameObjects()

	self._initSelectRaceId = self:getFirstParam()
	self._curPetInfo = nil
	self._curSelectPetIds = {}
	self._isExistUnique = false
	self._curEvolveConditionType = DivineEvolvePlusController.EvolveCondition.None
	self._isUnfold = false

	self:_refreshFoldState(State_Fold, false)
	self:_loadEffect()
	self:_initPetList()
	self:_createFilterList()
	self:_setSkipImgVisible()
	DivineEvolvePlusController.instance:tryOpenEvolveItemView()
end

function SourceTraceEvolveView:onExit()
	SourceTraceEvolveView.super.onExit(self)
	DivineEvolveController.instance:unregisterNotify(DivineEvolvePlusController.UpdateEvolveCondition, self._onUpdateEvolveCondition, self)
	self:_removeEffect()
	self:_removePreEvolveConditions()
	self._scrollList:dispose()
end

function SourceTraceEvolveView:_onClickClose()
	self:close()
end

function SourceTraceEvolveView:_onClickEvolve()
	if self._curPetInfo then
		self:_onClickPreEvolve()
	end
end

function SourceTraceEvolveView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "source_trace_evolve_rule")
end

function SourceTraceEvolveView:_onClickInfo()
	if self._curPetInfo then
		local raceId = self._curPetInfo.cfg.raceId
		local targetRaceId = self:_getRaceId(self._curPetInfo)

		UIStateManager.instance:updateParms(ViewName.SourceTraceEvolveView, {
			raceId
		})
		PetbookController.instance:openPetinfoView(targetRaceId)
	end
end

function SourceTraceEvolveView:_onClickLook()
	if self._curPetInfo then
		UIStateManager.instance:push(ViewName.SourceTraceEvolveLookView, self._curPetInfo.cfg.raceId)
	end
end

function SourceTraceEvolveView:_onClickChange()
	if self._curPetInfo then
		self._curPetInfo.isShowNew = not self._curPetInfo.isShowNew

		local raceId = self:_getRaceId(self._curPetInfo)

		self:_showRoleModel(raceId)
		self:_setPetBaseInfo(raceId)
	end
end

function SourceTraceEvolveView:_onClickShop()
	if self._curPetInfo and self._curPetInfo.cfg and not string.nilorempty(self._curPetInfo.cfg.jumpTo) then
		GotoMgr.gotoByString(self._curPetInfo.cfg.jumpTo)
	end
end

function SourceTraceEvolveView:_onClickUnfold()
	self._isUnfold = not self._isUnfold

	self:_refreshFoldState((self._isUnfold or nil) and (State_UnFold or State_Fold), true)
end

function SourceTraceEvolveView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_DIVINE_EVOLVE, pos, sizeDelta, GameUtil.handler(self._updateFilterData, self))
end

function SourceTraceEvolveView:_onClickClearSearch()
	self._InputC_Search.text = ""
end

function SourceTraceEvolveView:_openSourceTracePopup(text, okFunc, cfg)
	local previewEndTime = SourceTraceController.instance:getEvolveOpenTime(cfg)
	local isPreview = SourceTraceController.instance:isEvolvePreviewState(cfg)

	UIStateManager.instance:push(ViewName.SourceTracePopupView, text, okFunc, previewEndTime, isPreview, cfg)
end

function SourceTraceEvolveView:_onClickPreEvolve()
	printInfo("test SourceTraceEvolveView:_onClickPreEvolve1", self._curEvolveConditionType, self._isExistUnique)

	if self._curEvolveConditionType == DivineEvolvePlusController.EvolveCondition.None then
		printInfo("test SourceTraceEvolveView:_onClickPreEvolve2", self._isExistUnique)

		if self._isExistUnique then
			FloatWordMgr.instance:show("请先放入符合条件的精灵或道具")
		else
			FloatWordMgr.instance:show("请先放入符合条件的精灵")
		end
	elseif self._curEvolveConditionType == DivineEvolvePlusController.EvolveCondition.UniqueItem then
		printInfo("test SourceTraceEvolveView:_onClickPreEvolve3", self._isExistUnique)

		if not self._isExistUnique then
			return
		end

		local cfg = EvolveConfig.instance:getDivineEvolvePlusCfg(self._curPetInfo.cfg.raceId, EvolveEnum.EvolveType.SourceTrace)

		if MaterialMgr.getMatEnough(cfg.goodsCost) then
			local matType, id, matNum = MaterialMgr.getMatParams(cfg.goodsCost)
			local cfgExchange = EvolveConfig.instance:getExchangeCfg(cfg.newRaceId)
			local matType2, id2, matNum2 = MaterialMgr.getMatParams(cfgExchange.petCostItem)
			local name1 = MaterialMgr.getMaterialsName(matType, id)
			local name2 = MaterialMgr.getMaterialsName(matType2, id2)
			local text = string.format("是否消耗<color=#EB4642> %s </color>*%d 和 %s *%d 进行源起进化？", name1, matNum, name2, matNum2)

			local function okFunc()
				local isUsePet = false

				DivineEvolvePlusController.instance:sendPM_DivineExchangeReq(nil, 0, cfg.newRaceId, isUsePet)
			end

			self:_openSourceTracePopup(text, okFunc, cfg)
		else
			FloatWordMgr.instance:show("请先收集足够的材料")
		end
	else
		printInfo("test SourceTraceEvolveView:_onClickPreEvolve4", self._isExistUnique)

		if self._curSelectPetIds and self._curSelectPetIds[1] then
			local petId = self._curSelectPetIds[1]
			local petMo = BagModel.instance:getPet(petId)

			if petMo then
				local petBookLvNotMaxAddTip = "※源起进化需要<color=#EB4642>消耗1只精灵</color>，建议该精灵<color=#EB4642>图鉴满级后</color>再进行源起进化"
				local cfg = EvolveConfig.instance:getDivineEvolvePlusCfg(petMo.raceId, EvolveEnum.EvolveType.SourceTrace)
				local isSamePet = cfg and cfg.raceId == self._curPetInfo.cfg.raceId
				local attLevel = HandbookModel.instance:getAttributeLevel(petMo.raceId)
				local maxLvl = CharacterConfig.instance:getMaxAwaken(petMo.raceId)

				attLevel = Mathf.Clamp(attLevel, 0, maxLvl)

				local petBookLvMax = attLevel == maxLvl
				local petBookLvNotMaxAddStr = ""
				local petBookLvDesc = ""

				if not petBookLvMax then
					petBookLvNotMaxAddStr = "\n" .. petBookLvNotMaxAddTip
				end

				petBookLvDesc = petBookLvMax and "<color=green>[精灵图鉴等级:已满级]</color>" or string.format("<color=#EB4642>[精灵图鉴等级:%s]</color>", attLevel)

				if isSamePet then
					if MaterialMgr.getMatEnough(cfg.goodsCost) then
						if PasswordLockController.instance:checkNeedOpenVerifyView() then
							return
						end

						local name1 = PetSkinConfig.instance:getPetSkinName(petMo.curFaceId)
						local matType, id, matNum = MaterialMgr.getMatParams(cfg.goodsCost)
						local name2 = MaterialMgr.getMaterialsName(matType, id)
						local num2 = matNum
						local text = string.format("是否消耗<color=#EB4642> %s </color>*1 %s和 %s *%d 进行源起进化？\n\n※放入指定精灵，继承精灵等级和觉醒\n※放入同属性传说精灵，不继承等级和觉醒%s", name1, petBookLvDesc, name2, num2, petBookLvNotMaxAddStr)

						local function okFunc()
							DivineEvolvePlusController.instance:sendPM_DivinePlusEvolveReq(petId, cfg.raceId, cfg.newRaceId)
						end

						self:_openSourceTracePopup(text, okFunc, self._curPetInfo.cfg)
					else
						FloatWordMgr.instance:show("请先收集足够的材料")
					end
				elseif self._curPetInfo and self._curPetInfo.cfg and MaterialMgr.getMatEnough(self._curPetInfo.cfg.goodsCost) then
					if PasswordLockController.instance:checkNeedOpenVerifyView() then
						return
					end

					local name1 = PetSkinConfig.instance:getPetSkinName(petMo.curFaceId)
					local matType, id, matNum = MaterialMgr.getMatParams(self._curPetInfo.cfg.goodsCost)
					local name2 = MaterialMgr.getMaterialsName(matType, id)
					local num2 = matNum
					local petMoRaceId = petMo.raceId
					local newRaceId = self._curPetInfo.cfg.newRaceId
					local text = string.format("是否消耗<color=#EB4642> %s </color>*1 %s和 %s *%d 进行源起进化？\n\n※放入指定精灵，继承精灵等级和觉醒\n※放入同属性传说精灵，不继承等级和觉醒%s", name1, petBookLvDesc, name2, num2, petBookLvNotMaxAddStr)

					local function okFunc()
						DivineEvolvePlusController.instance:sendPM_DivineExchangeReq(petId, petMoRaceId, newRaceId, true)
					end

					self:_openSourceTracePopup(text, okFunc, self._curPetInfo.cfg)
				else
					FloatWordMgr.instance:show("请先收集足够的材料")
				end
			end
		else
			FloatWordMgr.instance:show("请先放入符合条件的精灵")
		end
	end
end

function SourceTraceEvolveView:_setSkipImgVisible()
	local index = checknumber(GameUtil.getUserData(SKIP_KEY))

	GameUtil.SetActive(self._imgSelect, index == 1)
end

function SourceTraceEvolveView:_onClickSkip()
	local index = checknumber(GameUtil.getUserData(SKIP_KEY))

	if index == 0 then
		GameUtil.saveUserData(SKIP_KEY, 1)
	else
		GameUtil.saveUserData(SKIP_KEY, 0)
	end

	self:_setSkipImgVisible()
end

function SourceTraceEvolveView:_onDivineEvolveRes(newPetMo, oldPetMo)
	printInfo("test 源起进化成功！！！", oldPetMo, newPetMo)

	local index = checknumber(GameUtil.getUserData(SKIP_KEY))

	if index == 0 then
		goutil.setActive(self._maskGo, true)
		goutil.setActive(self._effectGo, true)
		TweenUtil.DoDelay(1.5, function()
			goutil.setActive(self._maskGo, false)
			DivineEvolvePlusController.instance:playSourceTraceEvolveAnimation(newPetMo, oldPetMo)
		end)
	else
		GlobalDispatcher:dispatch(GlobalNotify.SourceTraceEvolvePlusAnimationEnd, newPetMo, oldPetMo)
	end
end

function SourceTraceEvolveView:_onAnimationEnd(newPetMo, oldPetMo)
	local cfg = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(newPetMo.raceId)

	if cfg then
		self:_refreshPetList(cfg.raceId)
	end
end

function SourceTraceEvolveView:_initGameObjects()
	goutil.setActive(self._maskGo, false)
	goutil.setActive(self._effectGo, false)
	goutil.setActive(self._tip1, false)
	goutil.setActive(self._tip2, false)

	self._txtTips1.text = lang("divineEvolvePlus_notputin")

	goutil.setActive(self._bgUnique, false)

	for i, v in ipairs(self._preEvolveCells) do
		goutil.setActive(v.lock, false)
		goutil.setActive(v.del, false)

		v.txtNum.text = ""
	end

	self._InputC_Search.text = ""
end

function SourceTraceEvolveView:_loadEffect()
	self:_removeEffect()

	local effectPath = "fx_ui_2021930/fx_ui_shenqi/fx_ui_shenqijinhua.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effectPath, self._effectGo.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	uiEffect.hideEffWhileNotOnTop = false
	self._uiEffect = uiEffect
end

function SourceTraceEvolveView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function SourceTraceEvolveView:_initPetList()
	local cfgList = SourceTraceController.instance:getEvolvePreviewVisibleList()
	local selectIndex = 1
	local list = {}

	for i, v in ipairs(cfgList) do
		local petInfo = {}

		petInfo.index = i
		petInfo.cfg = v
		petInfo.isSelect = false
		petInfo.isShowNew = true
		petInfo.isGeted = BagModel.instance:isExistRaceId(petInfo.cfg.newRaceId)

		table.insert(list, petInfo)
	end

	self._initList = list
	self._sortFilterList = {}

	for i, v in ipairs(self._initList) do
		table.insert(self._sortFilterList, v)
	end

	self:_sortPetListByGetState(self._sortFilterList)

	for i, v in ipairs(self._sortFilterList) do
		v.isSelect = self:_isSelectPet(i, v, self._initSelectRaceId)

		if v.isSelect then
			selectIndex = v.index
		end
	end

	self:_refreshPetInfo(self._initList[selectIndex])

	if self._curPetInfo then
		if not self._curPetInfo.cfg.raceId then
			local raceId = 0

			self:_supperUpdateListData(self._sortFilterList, raceId)
		end
	end
end

function SourceTraceEvolveView:updateListData(list)
	self._curViewDatas = list

	self._scrollList:reloadData(list)
end

function SourceTraceEvolveView:_refreshPetList(preEvolveRaceId)
	local selectIndex = 1

	for i, v in ipairs(self._initList or {}) do
		v.isSelect = self:_isSelectPet(i, v, preEvolveRaceId)

		if v.isSelect then
			selectIndex = v.index
		end

		v.isGeted = v.isGeted or BagModel.instance:isExistRaceId(v.cfg.newRaceId)
	end

	self:_sortPetListByGetState(self._curViewDatas)
	self:_refreshPetInfo(self._initList[selectIndex])

	if self._curPetInfo then
		if not self._curPetInfo.cfg.raceId then
			local raceId = 0

			self:_supperUpdateListData(self._curViewDatas, raceId)
		end
	end
end

function SourceTraceEvolveView:_sortPetListByGetState(list)
	if list == nil or #list < 2 then
		return
	end

	local function compareFunc(a, b)
		return not a.isGeted and b.isGeted
	end

	for i = 2, #list do
		local key = list[i]
		local j = i - 1

		while j > 0 and compareFunc(key, list[j]) do
			list[j + 1] = list[j]
			j = j - 1
		end

		list[j + 1] = key
	end
end

function SourceTraceEvolveView:_isSelectPet(index, info, raceId)
	return (raceId == nil or raceId == 0) and index == 1 or raceId == ((info or nil) and (info.cfg.raceId or -1))
end

function SourceTraceEvolveView:_supperUpdateListData(list, raceId)
	raceId = checknumber(raceId)

	self:updateListData(list)
end

function SourceTraceEvolveView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local select = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")
	local noGet = goutil.findChild(cell, "noGet")

	txtName.text = ""

	MaterialMgr.resetAll(icon)

	local raceId = data.cfg.newRaceId
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(raceId)

	btnClick:AddClickListener(function()
		printInfo("test 点击精灵", petSkinCfg.name)
		self:_onClickPetItem(data)
	end)
	goutil.setActive(select, data.isSelect)
	MaterialMgr.setCell(MatType.Pet, raceId, icon)

	txtName.text = petSkinCfg.name

	goutil.setActive(noGet, not data.isGeted)
end

function SourceTraceEvolveView:_clearTableview(cell)
	local icon = goutil.findChild(cell, "icon")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	MaterialMgr.resetAll(icon)
	btnClick:RemoveClickListener()
end

function SourceTraceEvolveView:_onClickPetItem(petInfo)
	if petInfo.isSelect then
		return
	end

	petInfo.isShowNew = true

	self:_refreshSelectState(petInfo)
	self:_refreshPetInfo(petInfo)

	local raceId = petInfo.cfg.raceId

	UIStateManager.instance:updateParms(ViewName.SourceTraceEvolveView, {
		raceId
	})
end

function SourceTraceEvolveView:_refreshSelectState(petInfo)
	for i, v in ipairs(self._initList) do
		v.isSelect = v.cfg.raceId == petInfo.cfg.raceId
	end

	self:_supperUpdateListData(self._curViewDatas, petInfo.cfg.raceId)
end

function SourceTraceEvolveView:_getRaceId(petInfo)
	return (petInfo.isShowNew or nil) and (petInfo.cfg.newRaceId or petInfo.cfg.raceId)
end

function SourceTraceEvolveView:_refreshPetInfo(petInfo)
	if petInfo then
		self._curPetInfo = petInfo

		if not self._leftParent.activeSelf then
			self._leftParent:SetActive(true)
		end

		local raceId = self:_getRaceId(petInfo)

		self:_setPetBaseInfo(raceId)
		self:_showRoleModel(raceId)
		self:_setPreEvolveConditions(petInfo.cfg.raceId)
	else
		self._leftParent:SetActive(false)
	end
end

function SourceTraceEvolveView:_setPetBaseInfo(raceId)
	local rare = CharacterConfig.instance:getInitRare(raceId)

	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, raceId)

	local petInfoCfg = CharacterConfig.instance:getPetInfoCo(raceId)

	self._txtDesc.text = string.gsub(petInfoCfg.stragegy, "\n", "，")

	local proxy = MaterialMgr.setCell(MatType.Rare, raceId, self._rareGo)

	if proxy then
		proxy.binder:setRare(rare)
	end

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(raceId)

	self._career1:SetState(firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(raceId)

	GameUtil.SetActive(self._careerGo2, false)

	if secondJobIdx > 20 then
		GameUtil.SetActive(self._careerGo2, true)
		self._career2:SetState(secondJobIdx - 1 - 20)
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(raceId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	self._attrChange:SetState(targetValue)
end

function SourceTraceEvolveView:_showRoleModel(raceId)
	self:_resetRoleModel()

	local offset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, raceId, self._roleGo, scale, nil, true, x, y)
end

function SourceTraceEvolveView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function SourceTraceEvolveView:_setPreEvolveConditions(raceId)
	self._isExistUnique = false
	self._curEvolveConditionType = DivineEvolvePlusController.EvolveCondition.None

	self:_removePreEvolveConditions()
	table.clear(self._curSelectPetIds)

	local cfg = EvolveConfig.instance:getDivineEvolvePlusCfg(raceId, EvolveEnum.EvolveType.SourceTrace)

	if cfg then
		self:_setPreEvolveCell(1, self._preEvolveCells[1], cfg.petValidator, cfg.des, cfg.newRaceId)
		self:_setPreEvolveItem(self._preEvolveCells[2], cfg.goodsCost)

		local cfgExchange = EvolveConfig.instance:getExchangeCfg(cfg.newRaceId)
		local timeOk = self:_exchangeTimeOk(cfgExchange)

		if cfgExchange and timeOk then
			self:_setPreEvolveUniqueItem(self._preEvolveCells[3], cfgExchange.petCostItem)
		else
			self:_setPreEvolveUniqueItem(self._preEvolveCells[3], "")
		end
	end

	self:_updateTip1(true, (cfg or nil) and (cfg.newRaceId or 0))
	self:_updateTip2(false)
end

function SourceTraceEvolveView:_removePreEvolveConditions()
	for i, v in ipairs(self._preEvolveCells) do
		MaterialMgr.clearIcon(v.bgIcon)
		MaterialMgr.resetAll(v.item)
		v.btnAdd:RemoveClickListener()
	end
end

function SourceTraceEvolveView:_resetPreEvolveCell(element, conditionStr, newRaceId)
	element.lock:SetActive(false)
	element.mask:SetActive(true)
	element.plusGo:SetActive(true)
	goutil.setActive(element.del, false)

	element.txtNum.text = "0/1"

	MaterialMgr.resetAll(element.item)

	local race, initRare, awakenLevel, level, raceType = DivineEvolvePlusController.instance:getAttrs(conditionStr)

	if race == nil and initRare ~= nil and raceType ~= nil then
		element.bgIcon:SetActive(true)

		local iconPath = self:_getIconPath(initRare, raceType)

		uGuiUtil.setSpriteToImage(element.bgIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(iconPath))

		element.txtLevel.text = checknumber(level) .. "级"
	else
		element.bgIcon:SetActive(false)
	end

	element.awakenGo:SetActive(false)

	if race ~= nil then
		local proxy = MaterialMgr.setCell(MatType.Pet, race, element.item)

		if proxy and level ~= nil then
			proxy.binder:setLvl(level)
		end

		if awakenLevel ~= nil then
			element.awakenGo:SetActive(true)

			element.txtAwaken.text = awakenLevel
		end
	end

	if newRaceId and newRaceId > 0 then
		self:_updateTip1(true, newRaceId)
	else
		self:_updateTip1(false)
	end

	self:_updateTip2(false)

	local cfgExchange = EvolveConfig.instance:getExchangeCfg(newRaceId)
	local timeOk = self:_exchangeTimeOk(cfgExchange)
	local exchangeConditionStr

	return cfgExchange and timeOk and cfgExchange.petValidator or ""
end

function SourceTraceEvolveView:_setPreEvolveCell(index, element, conditionStr, desc, newRaceId)
	local exchangeConditionStr = self:_resetPreEvolveCell(element, conditionStr, newRaceId)

	element.btnAdd:RemoveClickListener()
	element.btnAdd:AddClickListener(function()
		if self._curEvolveConditionType == DivineEvolvePlusController.EvolveCondition.Pet then
			self:_resetPreEvolveCell(element, conditionStr, newRaceId)
			self:_unlockUniqueItemCondition()

			return
		elseif self._curEvolveConditionType == DivineEvolvePlusController.EvolveCondition.UniqueItem then
			FloatWordMgr.instance:show("已放入源起材料，无需再次放入")

			return
		end

		local title = desc

		local function filterFunc(petMo)
			return GameUtil.expScript(conditionStr, GameUtil.handler(self.OnFilter, self, petMo)) or not string.nilorempty(exchangeConditionStr) and GameUtil.expScript(exchangeConditionStr, GameUtil.handler(self.OnFilter, self, petMo))
		end

		local function onSeletCallBack(petIds, petIdList)
			if petIdList and #petIdList > 0 then
				local petMo = BagModel.instance:getPet(petIdList[1])

				DivineEvolveController.instance:notify(DivineEvolvePlusController.UpdateEvolveCondition, index, petIdList[1])
			end
		end

		local function sortFunc(pets)
			local names, opt = BagModel.instance:GetSortParms()

			names[1] = FormationGroupModel.checkIsInTeamByMo

			local raceId = self._curPetInfo.cfg.raceId
			local needSetFirstList = {}

			for i = #pets, 1, -1 do
				local pet = pets[i]

				if pet.raceId == raceId then
					table.insert(needSetFirstList, pet)
					table.remove(pets, i)
				end
			end

			ArraySort.sortOn(pets, names, opt)

			for i, v in ipairs(needSetFirstList) do
				table.insert(pets, 1, v)
			end

			return true
		end

		local function isTopFunc(raceId)
			return raceId == self._curPetInfo.cfg.raceId
		end

		if race ~= nil then
			local allPetsList = BagModel.instance:getBagPets()
			local isExistMatch = false
			local isExistPet = false

			for i, v in ipairs(allPetsList) do
				if v.raceId == race then
					isExistPet = true
				end

				if filterFunc(v) then
					isExistMatch = true

					break
				end
			end

			if isExistMatch then
				local params = {
					onlyoneOrCount = true,
					showbagpetRaceName = true,
					title = title,
					filterFunc = filterFunc,
					submitFunc = onSeletCallBack,
					sortFunc = sortFunc,
					isTopFunc = isTopFunc
				}

				PetSelectController.instance:OpenViewWithParams(params)
			elseif isExistPet then
				local function func()
					UIStateManager.instance:push(ViewName.PetView)
				end

				TipsFacade.instance:openTipWindow(lang("tip"), "无符合条件精灵", func, "前往培养")
			else
				MaterialMgr.openGetSource(MatType.Pet, race)
			end
		else
			local params = {
				onlyoneOrCount = true,
				showbagpetRaceName = true,
				title = title,
				filterFunc = filterFunc,
				submitFunc = onSeletCallBack,
				sortFunc = sortFunc,
				isTopFunc = isTopFunc
			}

			PetSelectController.instance:OpenViewWithParams(params)
		end
	end)
end

function SourceTraceEvolveView:_setPreEvolveItem(element, goodsCost)
	MaterialMgr.resetAll(element.item)
	goutil.setActive(element.btnAdd.gameObject, false)

	local matType, id, matNum = MaterialMgr.getMatParams(goodsCost)
	local curCount = MaterialModel.instance:getMaterialsNumber(matType, id)
	local proxy = MaterialMgr.setCellByCfg(goodsCost, element.item)

	if proxy then
		proxy.binder:setNum(0)
		proxy.binder:setAutoTips(false)
		proxy:setCallBack(function()
			if curCount < matNum then
				MaterialMgr.openGetSource(matType, id)
			elseif element and element.item then
				CommonTipsMgr.instance:openMaterialTips(element.item, matType, id, 0)
			end
		end)
	end

	element.txtNum.text = string.format("%s/%s", curCount, matNum)

	element.btnAdd:RemoveClickListener()
end

function SourceTraceEvolveView:_resetPreEvolveUniqueItem(element, petCostItem)
	goutil.setActive(self._bgUnique, true)
	goutil.setActive(element.go, true)
	goutil.setActive(element.btnAdd.gameObject, true)
	goutil.setActive(element.del, false)
	goutil.setActive(element.lock, false)
	goutil.setActive(element.mask, true)
	goutil.setActive(element.img, true)
	goutil.setActive(element.plusGo, true)

	self._isExistUnique = true

	local matType, id, matNum = MaterialMgr.getMatParams(petCostItem)
	local proxy = MaterialMgr.setCellByCfg(petCostItem, element.item)

	if proxy then
		proxy.binder:setNum(0)
	end

	element.txtNum.text = string.format("%d/%d", 0, matNum)

	if self._curPetInfo then
		self:_updateTip1(true, self._curPetInfo.cfg.newRaceId)
	else
		self:_updateTip1(false)
	end

	self:_updateTip2(false)
end

function SourceTraceEvolveView:_setPreEvolveUniqueItem(element, petCostItem)
	MaterialMgr.resetAll(element.item)

	local isShowUnique = not string.nilorempty(petCostItem)

	if not isShowUnique then
		goutil.setActive(element.go, false)
		goutil.setActive(self._bgUnique, false)

		self._isExistUnique = false
	else
		self:_resetPreEvolveUniqueItem(element, petCostItem)

		local function callback()
			if self._curEvolveConditionType == DivineEvolvePlusController.EvolveCondition.UniqueItem then
				self:_resetPreEvolveUniqueItem(element, petCostItem)
				self:_unlockEvolvePetCondition()

				return
			elseif self._curEvolveConditionType == DivineEvolvePlusController.EvolveCondition.Pet then
				FloatWordMgr.instance:show("已放入源起材料，无需再次放入")

				return
			end

			local matType, id, matNum = MaterialMgr.getMatParams(petCostItem)
			local curCount = MaterialModel.instance:getMaterialsNumber(matType, id)

			if curCount < matNum then
				MaterialMgr.openGetSource(matType, id)
			else
				self:_onSelectUniqueItemConditon(matNum)
			end
		end

		element.btnAdd:AddClickListener(callback)
	end
end

function SourceTraceEvolveView:_getIconPath(initRare, raceType)
	local pre = rareDic[initRare]
	local post = pathDic[GameEnum.Races[raceType]]

	return (string.format("icon_%s_%s", pre, post))
end

function SourceTraceEvolveView:_onUpdateEvolveCondition(index, petId)
	self._curSelectPetIds[index] = petId

	local element = self._preEvolveCells[index]
	local petMo = BagModel.instance:getBagPetById(petId)

	element.bgIcon:SetActive(false)
	MaterialMgr.resetAll(element.item)
	MaterialMgr.setCellByMo(petMo, element.item)

	element.txtNum.text = "1/1"

	element.mask:SetActive(false)
	element.plusGo:SetActive(false)
	goutil.setActive(element.del, true)
	self:_updateTip1(false)
	self:_updateTip2(true, petMo.raceId)

	element.txtAwaken.text = petMo:getAwakenLv()

	self:_lockUniqueItemCondition()
end

function SourceTraceEvolveView:OnFilter(petMo, str)
	return FightingPowerFormula.instance:OnFilter(petMo, str)
end

function SourceTraceEvolveView:_updateTip1(active, newRaceId)
	goutil.setActive(self._tip1, active)

	local cfg = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(newRaceId)

	if cfg and not string.nilorempty(cfg.DescBubble_before) then
		self._txtTips1.text = cfg.DescBubble_before or lang("divineEvolvePlus_notputin")
	end
end

function SourceTraceEvolveView:_updateTip2(active, raceId)
	goutil.setActive(self._tip2, active)

	if active and self._curPetInfo then
		local cfg = self._curPetInfo.cfg
		local isSamePet = cfg and cfg.raceId == raceId

		self._txtTips2.text = isSamePet and (cfg.DescBubble_after or lang("divineEvolvePlus_specify")) or cfg.DescBubble_after2 or lang("divineEvolvePlus_sameLine")
	end
end

function SourceTraceEvolveView:_lockUniqueItemCondition()
	local itemElement = self._preEvolveCells[3]

	goutil.setActive(itemElement.lock, true)

	self._curEvolveConditionType = DivineEvolvePlusController.EvolveCondition.Pet
end

function SourceTraceEvolveView:_unlockUniqueItemCondition()
	local itemElement = self._preEvolveCells[3]

	goutil.setActive(itemElement.lock, false)

	self._curEvolveConditionType = DivineEvolvePlusController.EvolveCondition.None
end

function SourceTraceEvolveView:_onSelectUniqueItemConditon(matNum)
	local element = self._preEvolveCells[3]

	goutil.setActive(element.del, true)
	goutil.setActive(element.lock, false)
	goutil.setActive(element.mask, false)
	goutil.setActive(element.img, false)
	goutil.setActive(element.plusGo, false)

	element.txtNum.text = string.format("%d/%d", matNum, matNum)

	self:_lockEvolvePetCondition()
	self:_updateTip1(false)

	if self._curPetInfo then
		self:_updateTip2(true, self._curPetInfo.cfg.newRaceId)
	else
		self:_updateTip2(false)
	end
end

function SourceTraceEvolveView:_lockEvolvePetCondition()
	local itemElement = self._preEvolveCells[1]

	goutil.setActive(itemElement.lock, true)

	self._curEvolveConditionType = DivineEvolvePlusController.EvolveCondition.UniqueItem
end

function SourceTraceEvolveView:_unlockEvolvePetCondition()
	local itemElement = self._preEvolveCells[1]

	goutil.setActive(itemElement.lock, false)

	self._curEvolveConditionType = DivineEvolvePlusController.EvolveCondition.None
end

function SourceTraceEvolveView:_refreshFoldState(state, isRefreshList)
	if state == State_Fold then
		goutil.setActive(self._InputC_Search.gameObject, false)
		goutil.setActive(self._petSelectMaskGo, false)

		self._iconUnfold.transform.localScale = Vector3.New(-1, 1, 1)

		self._unfoldColorChange:SetState(0)

		self._uiTableGrid.numRowsOrCols = 1
		self._petSelectRectTrans.pivot = Vector2.New(0, 1)
		self._petSelectRectTrans.anchorMin = Vector2.New(0, 0.5)
		self._petSelectRectTrans.anchorMax = Vector2.New(0, 0.5)
		self._petSelectRectTrans.anchoredPosition = Vector2.New(22, 230)
		self._petSelectRectTrans.sizeDelta = Vector2.New(170, 578)
	else
		goutil.setActive(self._InputC_Search.gameObject, true)
		goutil.setActive(self._petSelectMaskGo, true)

		self._iconUnfold.transform.localScale = Vector3.New(1, 1, 1)

		self._unfoldColorChange:SetState(1)

		self._uiTableGrid.numRowsOrCols = 7
		self._petSelectRectTrans.pivot = Vector2.New(0.5, 0.5)
		self._petSelectRectTrans.anchorMin = Vector2.New(0.5, 0.5)
		self._petSelectRectTrans.anchorMax = Vector2.New(0.5, 0.5)
		self._petSelectRectTrans.anchoredPosition = Vector2.New(0, -59)
		self._petSelectRectTrans.sizeDelta = Vector2.New(1236, 578)
	end

	if isRefreshList then
		if self._curPetInfo then
			if not self._curPetInfo.cfg.raceId then
				local raceId = 0

				self:_supperUpdateListData(self._curViewDatas, raceId)
			end
		end
	end
end

function SourceTraceEvolveView:_createFilterList()
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_DIVINE_EVOLVE)

	PetFilterMgr.instance:resetData(data)

	for i = 1, 4 do
		if i == GameEnum.PetRare.SSR then
			data.rareSelectList[i] = true
			data.rareActiveList[i] = true
			data.rareClickAble[i] = false
		else
			data.rareSelectList[i] = false
			data.rareActiveList[i] = true
			data.rareClickAble[i] = false
		end
	end

	for i = 1, PetFilterMgr.MAX_PET_JOB_INDEX do
		if i == GameEnum.CareerType.ShenYao then
			data.jobSelectList[i] = false
			data.jobActiveList[i] = true
			data.jobClickAble[i] = true
		else
			data.jobSelectList[i] = false
			data.jobActiveList[i] = true
			data.jobClickAble[i] = true
		end
	end
end

function SourceTraceEvolveView:_getPosAndSizeDelta(go)
	local sizeDelta = {
		0,
		0
	}
	local rect = go:GetComponent("RectTransform")

	sizeDelta = {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}

	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, sizeDelta
end

function SourceTraceEvolveView:_updateFilterData(starList, jobList, rareList)
	self:_refreshFilterPetList()
end

function SourceTraceEvolveView:_refreshFilterPetList()
	table.clear(self._sortFilterList)

	for k, v in ipairs(self._initList) do
		if self:_onFilter(v) then
			table.insert(self._sortFilterList, v)
		end
	end

	printInfo("test _refreshFilterPetList", #self._sortFilterList)
	self:_sortPetListByGetState(self._sortFilterList)

	if self._curPetInfo then
		if not self._curPetInfo.cfg.raceId then
			local raceId = 0

			self:_supperUpdateListData(self._sortFilterList, raceId)
		end
	end
end

function SourceTraceEvolveView:_onFilter(petInfo)
	local petCo = CharacterConfig.instance:getPetCo(petInfo.cfg.newRaceId)
	local isHit = false

	isHit = self:_isMatch(petCo, petInfo.cfg.rare, petInfo.cfg.curFaceId)

	printInfo("test 筛选_onFilter", petCo.name, isHit)

	if not string.nilorempty(self._SearchText) then
		local str = StringUtil.RelpaceEscapeChar(self._SearchText)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function SourceTraceEvolveView:_isMatch(cfg, rare, skinId)
	return (PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_DIVINE_EVOLVE, cfg, rare, skinId))
end

function SourceTraceEvolveView:_OnSearchTextChanged(text)
	if text ~= self._SearchText then
		self._SearchText = text

		self:_refreshFilterPetList()
	end
end

function SourceTraceEvolveView:_exchangeTimeOk(cfgExchange)
	if not cfgExchange then
		return false
	end

	local evolveCfg = EvolveConfig.instance:getDivineEvolvePlusCfgByNewRaceId(cfgExchange.raceId)

	if evolveCfg then
		return SourceTraceController.instance:isEvolveVisible(evolveCfg)
	end

	return string.nilorempty(cfgExchange.beginTime) or ServerTime.now() > GameUtil.string2time(cfgExchange.beginTime)
end

function SourceTraceEvolveView:_onClickShop()
	if self._curPetInfo and self._curPetInfo.cfg and not string.nilorempty(self._curPetInfo.cfg.jumpTo) then
		GotoMgr.gotoByString(self._curPetInfo.cfg.jumpTo)
	end
end

return SourceTraceEvolveView
