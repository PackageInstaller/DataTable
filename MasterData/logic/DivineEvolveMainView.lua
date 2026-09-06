-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveMainView.lua

module("logic.extensions.divineevolve.view.DivineEvolveMainView", package.seeall)

local DivineEvolveMainView = class("DivineEvolveMainView", TableViewComponent)

DivineEvolveMainView.PreChallenge = 1
DivineEvolveMainView.PreEvolve = 2
DivineEvolveMainView.PostEvolve = 3

local pathDic = {
	"cao",
	"shui",
	"huo",
	"guang",
	"an"
}
local rareDic = {
	[GameEnum.PetRare.R] = "huanshoudaoju",
	[GameEnum.PetRare.SR] = "chaonengdaoju",
	[GameEnum.PetRare.SSR] = "chuanshuodaoju"
}

function DivineEvolveMainView:ctor()
	DivineEvolveMainView.super.ctor(self)
end

function DivineEvolveMainView:buildUI()
	DivineEvolveMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._rightEmpty = self:getGo("right/rightEmpty")
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
	self._btnExtChallenge = self:getBtn("left/btnExtChallenge")
	self._redPointExtChallenge = self:getGo("left/btnExtChallenge/redpoint")
	self._imgExtChallenge = self:getGo("left/btnExtChallenge")
	self._txtExtChallenge = self:getTxt("left/btnExtChallenge/txt")
	self._btnLook = self:getBtn("right/btnLook")
	self._btnChange = self:getBtn("right/btnChange")
	self._btnGo = self:getBtn("btnGo")
	self._bubble = self:getGo("bubble")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnMaterial = self:getBtn("btnMaterial")
	self._preEvolveCells = {}

	for i = 1, 4 do
		local element = {}

		element.go = self:getGo(string.format("left/preEvolve/cell%d", i))
		element.bgIcon = self:getGo(string.format("left/preEvolve/cell%d/bgIcon", i))
		element.item = self:getGo(string.format("left/preEvolve/cell%d/item", i))
		element.txtNum = self:getTxt(string.format("left/preEvolve/cell%d/txtNum", i))
		element.btnAdd = self:getBtn(string.format("left/preEvolve/cell%d/btnAdd", i))
		element.mask = self:getGo(string.format("left/preEvolve/cell%d/btnAdd/imgMask1", i))
		element.plusGo = self:getGo(string.format("left/preEvolve/cell%d/btnAdd/img", i))
		element.awakenGo = self:getGo(string.format("left/preEvolve/cell%d/awakenLv", i))
		element.txtAwaken = self:getTxt(string.format("left/preEvolve/cell%d/awakenLv/txtNum", i))
		element.txtLevel = self:getTxt(string.format("left/preEvolve/cell%d/bgIcon/txtLevel", i))

		table.insert(self._preEvolveCells, element)
	end

	self._preChallengeCells = {}

	for i = 1, 4 do
		local element = {}

		element.bgIcon = self:getGo(string.format("left/preChallenge/cell%d/bgIcon", i))
		element.item = self:getGo(string.format("left/preChallenge/cell%d/item", i))
		element.txtNum = self:getTxt(string.format("left/preChallenge/cell%d/txtNum", i))
		element.awakenGo = self:getGo(string.format("left/preChallenge/cell%d/awakenLv", i))
		element.txtAwaken = self:getTxt(string.format("left/preChallenge/cell%d/awakenLv/txtNum", i))
		element.txtLevel = self:getTxt(string.format("left/preChallenge/cell%d/bgIcon/txtLevel", i))

		table.insert(self._preChallengeCells, element)
	end
end

function DivineEvolveMainView:_getPath()
	return {
		cellPath = "right/cell",
		viewPath = "right/tableview"
	}
end

function DivineEvolveMainView:bindEvents()
	DivineEvolveMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnEvolve:AddClickListener(self._onClickEvolve, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnLook:AddClickListener(self._onClickLook, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._btnGo:AddClickListener(self._onClickGo, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnMaterial:AddClickListener(self._onClickMaterial, self)
	self._btnExtChallenge:AddClickListener(self._onClickExtChallenge, self)
end

function DivineEvolveMainView:unbindEvents()
	DivineEvolveMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnEvolve:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnLook:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnMaterial:RemoveClickListener()
	self._btnExtChallenge:RemoveClickListener()
end

function DivineEvolveMainView:onEnter()
	DivineEvolveMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.NoahChallengeBuyEndRes, self._onNoahChallengeBuyEndRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GetDivineEvolveInfoRes, self._onGetDivineEvolveInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DivineEvolveRes, self._onDivineEvolveRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DivineEvolveAnimationEnd, self._onAnimationEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.GodARuiShiChallengeInfoRes, self._refreshCurPetInfo, self)
	DivineEvolveController.instance:registerNotify(DivineEvolveController.MainItemClick, self._onClickItem, self)
	DivineEvolveController.instance:registerNotify(DivineEvolveController.UpdateEvolveCondition, self._onUpdateEvolveCondition, self)
	goutil.setActive(self._maskGo, false)
	goutil.setActive(self._effectGo, false)
	GameUtil.SetActive(self._btnExtChallenge, false)

	self._initSelectRaceId = self:getFirstParam()

	GodARuiShiChallengeController.instance:send_GodARuiShiChallengeInfoReq(GodARuiShiChallengeConfig.instance:getChallengeExtChallengeId())
	PetAgent.instance:sendPM_GetDivineEvolveInfoReq()

	self._curPetInfo = nil
	self._curSelectPetIds = {}

	self:_loadEffect()
end

function DivineEvolveMainView:onExit()
	DivineEvolveMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NoahChallengeBuyEndRes, self._onNoahChallengeBuyEndRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GetDivineEvolveInfoRes, self._onGetDivineEvolveInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.DivineEvolveRes, self._onDivineEvolveRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.DivineEvolveAnimationEnd, self._onAnimationEnd, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodARuiShiChallengeInfoRes, self._refreshCurPetInfo, self)
	DivineEvolveController.instance:unregisterNotify(DivineEvolveController.MainItemClick, self._onClickItem, self)
	DivineEvolveController.instance:unregisterNotify(DivineEvolveController.UpdateEvolveCondition, self._onUpdateEvolveCondition, self)
	self:_resetRoleModel()
	self:_removePreEvolveConditions()
	self:_removePreChallengeCells()
	self:_removeEffect()
end

function DivineEvolveMainView:_onClickClose()
	self:close()
end

function DivineEvolveMainView:_onClickEvolve()
	if self._curPetInfo then
		local petMo = self._curPetInfo.petMo
		local raceId = self._curPetInfo.raceId
		local state = self._curPetInfo.state

		if state == DivineEvolveMainView.PreChallenge then
			self:_onClickPreChallenge(petMo, raceId)
		elseif state == DivineEvolveMainView.PreEvolve then
			if petMo then
				self:_onClickPreEvolve(petMo)
			else
				local cfg = CharacterConfig.instance:getPetCo(raceId)

				if cfg then
					FloatWordMgr.instance:show("还未获得" .. cfg.name)
				end
			end
		else
			self:_onClickPostEvolve(petMo)
		end
	end
end

function DivineEvolveMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "jinglingshenqi")
end

function DivineEvolveMainView:_onClickInfo()
	if self._curPetInfo then
		local isPostEvolveInFact = self._curPetInfo.state == DivineEvolveMainView.PostEvolve
		local raceId = self._curPetInfo.raceId
		local targetRaceId = raceId

		if not isPostEvolveInFact then
			local cfg = EvolveConfig.instance:getDivineEvolveCfg(raceId)

			targetRaceId = self._curPetInfo.isPostEvolve and cfg.newRaceId or self._curPetInfo.petMo and self._curPetInfo.petMo.raceId or cfg.raceId
		else
			local cfg = EvolveConfig.instance:getDivineEvolveCfgByNewRaceId(raceId)

			targetRaceId = self._curPetInfo.isPostEvolve and (self._curPetInfo.petMo and self._curPetInfo.petMo.raceId or cfg.newRaceId) or cfg.raceId
		end

		UIStateManager.instance:updateParms(ViewName.DivineEvolveMainView, {
			raceId
		})
		PetbookController.instance:openPetinfoView(targetRaceId)
	end
end

function DivineEvolveMainView:_onClickLook()
	if self._curPetInfo then
		UIStateManager.instance:push(ViewName.DivineEvolveLookView, self._curPetInfo.raceId)
	end
end

function DivineEvolveMainView:_onClickChange()
	if self._curPetInfo then
		local skinId = self:_changeRoleModel()

		self:_setPetBaseInfo(skinId)
	end
end

function DivineEvolveMainView:_onClickGo()
	if self._curPetInfo then
		local preEvolveRaceId = self._curPetInfo.raceId
		local evolveCfg = EvolveConfig.instance:getDivineEvolveCfg(preEvolveRaceId)

		if not evolveCfg or string.nilorempty(evolveCfg.payJump) then
			return
		end

		UIStateManager.instance:updateParms(ViewName.DivineEvolveMainView, {
			preEvolveRaceId
		})
		GotoMgr.gotoByString(evolveCfg.payJump)
	end
end

function DivineEvolveMainView:_onClickExchange()
	local jump = EvolveConfig.instance:getDivineExchangeJump()

	if string.nilorempty(jump) then
		return
	end

	GotoMgr.gotoByString(jump)
end

function DivineEvolveMainView:_onClickMaterial()
	local jump = EvolveConfig.instance:getDivineMaterialJump()

	if string.nilorempty(jump) then
		return
	end

	GotoMgr.gotoByString(jump)
end

function DivineEvolveMainView:_onClickPreChallenge(petMo, raceId)
	local petId = 0
	local petRaceId = 0

	if petMo then
		petId = petMo:getPetId()
		petRaceId = petMo.raceId
	else
		petRaceId = raceId
	end

	local cfg = EvolveConfig.instance:getDivineEvolveCfg(petRaceId)

	if not cfg then
		return
	end

	local challengeId = cfg.challengeId

	UIStateManager.instance:updateParms(ViewName.DivineEvolveMainView, {
		petRaceId
	})

	local isEnterFormMainView = true

	UIStateManager.instance:push(cfg.challengeView, challengeId, petRaceId, isEnterFormMainView)
end

function DivineEvolveMainView:_onClickPreEvolve(petMo)
	if self._curSelectPetIds and self._curSelectPetIds[1] and self._curSelectPetIds[2] and self._curSelectPetIds[3] then
		local cfg = EvolveConfig.instance:getDivineEvolveCfg(petMo.raceId)

		if MaterialMgr.getMatEnough(cfg.goodsCost) then
			if PasswordLockController.instance:checkNeedOpenVerifyView() then
				return
			end

			local petIds = {}

			table.insert(petIds, self._curSelectPetIds[1])
			table.insert(petIds, self._curSelectPetIds[2])
			table.insert(petIds, self._curSelectPetIds[3])
			DivineEvolveController.instance:sendPM_DivineEvolveReq(petMo.petId, petIds, cfg.raceId, cfg.newRaceId)
		else
			FloatWordMgr.instance:show("请先收集足够的材料")
		end
	else
		FloatWordMgr.instance:show("请先放入符合条件的精灵")
	end
end

function DivineEvolveMainView:_onClickPostEvolve(petMo)
	FuncOpenController.instance:openFunc(358, petMo:getPetId())
end

function DivineEvolveMainView:_onClickExtChallenge()
	if self._curPetInfo then
		local petMo = self._curPetInfo.petMo
		local raceId = self._curPetInfo.raceId
		local petId = 0
		local petRaceId = 0

		if petMo then
			petId = petMo:getPetId()
			petRaceId = petMo.raceId
		else
			petRaceId = raceId
		end

		local cfg = EvolveConfig.instance:getDivineEvolveCfgByNewRaceId(petRaceId)

		if not cfg then
			cfg = EvolveConfig.instance:getDivineEvolveCfg(petRaceId)

			if not cfg then
				return
			end
		end

		local challengeId = checknumber(cfg.challengeAfaterId) > 0 and cfg.challengeAfaterId or cfg.challengeId

		if DivineEvolveModel.instance:getExtChallengeRedPoint(challengeId) == nil then
			DivineEvolveModel.instance:saveExtChallengeRedPoint(challengeId)
		end

		UIStateManager.instance:updateParms(ViewName.DivineEvolveMainView, {
			petRaceId
		})

		local isEnterFormMainView = true

		UIStateManager.instance:push(cfg.challengeView, challengeId, petRaceId, isEnterFormMainView)
	end
end

function DivineEvolveMainView:_onGetDivineEvolveInfoRes()
	self:_initPetList()
end

function DivineEvolveMainView:_onNoahChallengeBuyEndRes()
	if self._curPetInfo then
		self._curPetInfo.state = self:_getPetMoState(self._curPetInfo.petMo, self._curPetInfo.raceId)
	end

	self:_refreshPetInfo(self._curPetInfo)
end

function DivineEvolveMainView:_onDivineEvolveRes(preEvolveRaceId, postEvolveRaceId, oldPetMo, newPetMo)
	goutil.setActive(self._maskGo, true)
	goutil.setActive(self._effectGo, false)
	TweenUtil.DoDelay(1.5, function()
		goutil.setActive(self._maskGo, false)
		goutil.setActive(self._effectGo, true)
		DivineEvolveController.instance:playEvolveAnimation(preEvolveRaceId, postEvolveRaceId, oldPetMo, newPetMo)
	end)
end

function DivineEvolveMainView:_onAnimationEnd(postEvolveRaceId)
	self:_refreshPetList(postEvolveRaceId)
end

function DivineEvolveMainView:_onClickItem(petInfo)
	if petInfo.isSelect then
		return
	end

	self:_refreshSelectState(petInfo)
	self:_refreshPetInfo(petInfo)
end

function DivineEvolveMainView:_onUpdateEvolveCondition(index, petId)
	self._curSelectPetIds[index] = petId

	local element = self._preEvolveCells[index]
	local petMo = BagModel.instance:getBagPetById(petId)

	element.bgIcon:SetActive(false)
	MaterialMgr.resetAll(element.item)
	MaterialMgr.setCellByMo(petMo, element.item)

	element.txtNum.text = "1/1"

	element.mask:SetActive(false)
	element.plusGo:SetActive(false)
end

function DivineEvolveMainView:_updateCell(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local postEvolve = goutil.findChild(cell, "postEvolve")
	local select = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")
	local birthdayTag = goutil.findChild(cell, "birthdayTag")

	txtName.text = ""

	MaterialMgr.resetAll(icon)
	btnClick:AddClickListener(function()
		DivineEvolveController.instance:notify(DivineEvolveController.MainItemClick, data)
	end)
	goutil.setActive(select, data.isSelect)
	goutil.setActive(postEvolve, data.state == DivineEvolveMainView.PostEvolve)

	local proxy = MaterialMgr.setCell(MatType.Pet, data.raceId, icon)

	if not data.isExistInBag then
		proxy.binder:setGray(true)
	end

	local cfg = CharacterConfig.instance:getPetCo(data.raceId)

	if cfg then
		txtName.text = cfg.name
	end

	goutil.setActive(birthdayTag, self:_birthdayTagState(data.raceId, data.state))
end

function DivineEvolveMainView:_clearTableview(cell)
	local icon = goutil.findChild(cell, "icon")
	local btnClick = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnClick")

	MaterialMgr.resetAll(icon)
	btnClick:RemoveClickListener()
end

function DivineEvolveMainView:_initPetList()
	local petMoList = DivineEvolveController.instance:getDivineMainList()

	if #petMoList == 0 then
		self:_showRightEmpty(true)
		self:_refreshPetInfo(nil)
	else
		self:_showRightEmpty(false)

		local selectIndex = 1
		local showList = {}

		for i, v in ipairs(petMoList) do
			local element = {}

			element.isExistInBag = v.isExistInBag
			element.petMo = v.petMo
			element.raceId = v.raceId
			element.state = self:_getPetMoState(v.petMo, v.raceId)
			element.isPostEvolve = element.state == DivineEvolveMainView.PostEvolve
			element.isSelect = (self._initSelectRaceId == nil or self._initSelectRaceId == 0) and i == 1 or v.petMo and v.petMo.raceId == self._initSelectRaceId and true or self._initSelectRaceId == v.raceId

			if element.isSelect then
				selectIndex = i
			end

			table.insert(showList, element)
		end

		self:updateListData(showList)
		self:_refreshPetInfo(showList[selectIndex])
	end
end

function DivineEvolveMainView:_refreshPetList(postEvolveRaceId)
	local petMoList = DivineEvolveController.instance:getDivineMainList()

	if #petMoList == 0 then
		self:_showRightEmpty(true)
		self:_refreshPetInfo(nil)
	else
		self:_showRightEmpty(false)

		local showList = {}
		local index = 1

		for i, v in ipairs(petMoList) do
			local element = {}

			element.isExistInBag = v.isExistInBag
			element.petMo = v.petMo
			element.raceId = v.raceId
			element.state = self:_getPetMoState(v.petMo, v.raceId)
			element.isPostEvolve = element.state == DivineEvolveMainView.PostEvolve

			if element.state == DivineEvolveMainView.PostEvolve and v.petMo and postEvolveRaceId == v.petMo.raceId then
				element.isSelect = true
				index = i
			else
				element.isSelect = false
			end

			table.insert(showList, element)
		end

		self:updateListData(showList)
		self:_refreshPetInfo(showList[index])
	end
end

function DivineEvolveMainView:_getPetMoState(petMo, raceId)
	if petMo then
		if PetSkinConfig.instance:checkHasJob(petMo.curFaceId, GameEnum.CareerType.Shenqi) then
			return DivineEvolveMainView.PostEvolve
		end

		local cfgDivineEvolve = EvolveConfig.instance:getDivineEvolveCfg(petMo.raceId)

		if cfgDivineEvolve and DivineEvolveModel.instance:isFinishEvolveCondition(cfgDivineEvolve.newRaceId) then
			return DivineEvolveMainView.PreEvolve
		else
			return DivineEvolveMainView.PreChallenge
		end
	else
		local cfgDivineEvolve = EvolveConfig.instance:getDivineEvolveCfg(raceId)

		if cfgDivineEvolve and DivineEvolveModel.instance:isFinishEvolveCondition(cfgDivineEvolve.newRaceId) then
			return DivineEvolveMainView.PreEvolve
		else
			return DivineEvolveMainView.PreChallenge
		end
	end
end

function DivineEvolveMainView:_showRightEmpty(isShow)
	self._rightEmpty:SetActive(false)
end

function DivineEvolveMainView:_refreshSelectState(petInfo)
	for i, v in ipairs(self._curViewDatas) do
		v.isSelect = v.petMo and petInfo.petMo and v.petMo.petId == petInfo.petMo.petId or v.raceId == petInfo.raceId
		v.isPostEvolve = v.state == DivineEvolveMainView.PostEvolve
	end

	self:reloadData()
end

function DivineEvolveMainView:_refreshPetInfo(petInfo)
	if petInfo then
		self._curPetInfo = petInfo

		if not self._leftParent.activeSelf then
			self._leftParent:SetActive(true)
		end

		local petMo = petInfo.petMo
		local state = petInfo.state
		local skinId = petInfo.raceId

		self:_setPetBaseInfo(skinId)
		self:_showRoleModel(skinId)
		self:_setBtnEvolveState(state)
		self:_setConditions(state, petMo, petInfo.raceId)
		self:_setBtnExtChallenge(petMo, petInfo.raceId)
	else
		self._leftParent:SetActive(false)
	end

	self:_updateBtnGoState()
end

function DivineEvolveMainView:_birthdayTagState(raceId, state)
	if raceId == 14000 and state == 1 or raceId == 10145 and state == 1 then
		return true
	else
		return false
	end
end

function DivineEvolveMainView:_updateBtnGoState()
	goutil.setActive(self._btnGo.gameObject, false)
	goutil.setActive(self._bubble, false)
end

function DivineEvolveMainView:_setConditions(state, petMo, raceId)
	if state == DivineEvolveMainView.PreChallenge then
		self._preChallengeGo:SetActive(true)
		self._preEvolveGo:SetActive(false)
		self:_setPreChallengeCells((petMo or nil) and (petMo.raceId or raceId))
	elseif state == DivineEvolveMainView.PreEvolve then
		self._preChallengeGo:SetActive(false)
		self._preEvolveGo:SetActive(true)
		self:_setPreEvolveConditions((petMo or nil) and (petMo.raceId or raceId))
	else
		self._preChallengeGo:SetActive(false)
		self._preEvolveGo:SetActive(false)
	end
end

function DivineEvolveMainView:_setBtnEvolveState(state)
	self._txtBtnEvolve.text = state == DivineEvolveMainView.PreChallenge and "神启挑战" or state == DivineEvolveMainView.PreEvolve and "神启进化" or "神威"
end

function DivineEvolveMainView:_isShowExtChallenge(cfg)
	local extChallengId = GodARuiShiChallengeConfig.instance:getChallengeExtChallengeId()

	if DivineEvolveModel.instance:getExtChallengeRedPoint(extChallengId) == true then
		GameUtil.SetActive(self._redPointExtChallenge, false)
	else
		GameUtil.SetActive(self._redPointExtChallenge, true)
	end

	local isShowBtnExtChallenge = not GodARuiShiChallengeModel.instance:isPass() or not GodXiuerChallengeModel.instance:isPass(cfg.challengeAfaterId)

	if DivineEvolveModel.instance:isFinishEvolveCondition(cfg.newRaceId) == true and isShowBtnExtChallenge then
		GameUtil.SetActive(self._btnExtChallenge, true)

		self._txtExtChallenge.text = cfg.txt

		uGuiUtil.setSpriteToImage(self._imgExtChallenge, uGuiUtil.SpriteType.BigBg, cfg.res)
	else
		GameUtil.SetActive(self._btnExtChallenge, false)
	end
end

function DivineEvolveMainView:_setBtnExtChallenge(petMo, raceId)
	local cfg = self._curPetInfo.state == DivineEvolveMainView.PostEvolve and EvolveConfig.instance:getDivineEvolveCfgByNewRaceId((petMo or nil) and (petMo.raceId or raceId)) or EvolveConfig.instance:getDivineEvolveCfg((petMo or nil) and (petMo.raceId or raceId))

	if checknumber(cfg.challengeAfaterId) > 0 then
		self:_isShowExtChallenge(cfg)
	else
		GameUtil.SetActive(self._redPointExtChallenge, false)
		GameUtil.SetActive(self._btnExtChallenge, false)
	end
end

function DivineEvolveMainView:_setPetBaseInfo(skinId)
	local raceId = 0
	local rare = 1
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	raceId = skinCfg and skinCfg.raceId or raceId
	rare = CharacterConfig.instance:getInitRare(raceId)
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)

	local petInfoCfg = CharacterConfig.instance:getPetInfoCo(raceId)

	self._txtDesc.text = string.gsub(petInfoCfg.stragegy, "\n", "，")

	local proxy = MaterialMgr.setCell(MatType.Rare, raceId, self._rareGo)

	if proxy then
		proxy.binder:setRare(rare)
	end

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

	self._career1:SetState(firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(skinId)

	GameUtil.SetActive(self._careerGo2, false)

	if secondJobIdx > 20 then
		GameUtil.SetActive(self._careerGo2, true)
		self._career2:SetState(secondJobIdx - 1 - 20)
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	self._attrChange:SetState(targetValue)
end

function DivineEvolveMainView:_showRoleModel(skinId)
	self:_resetRoleModel()

	local offset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._roleGo, scale, nil, true, x, y)
end

function DivineEvolveMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DivineEvolveMainView:_changeRoleModel()
	if self._curPetInfo then
		local raceId = self._curPetInfo.raceId
		local isPostEvolveInFact = self._curPetInfo.state == DivineEvolveMainView.PostEvolve
		local skinId = 0
		local cfg

		if not isPostEvolveInFact then
			local cfg = EvolveConfig.instance:getDivineEvolveCfg(raceId)

			if cfg then
				skinId = self._curPetInfo.isPostEvolve and raceId or cfg.newRaceId
			end
		else
			local cfg = EvolveConfig.instance:getDivineEvolveCfgByNewRaceId(raceId)

			if cfg then
				skinId = self._curPetInfo.isPostEvolve and cfg.raceId or cfg.newRaceId
				skinId = self._curPetInfo.isPostEvolve and cfg.raceId or raceId
			end
		end

		self._curPetInfo.isPostEvolve = not self._curPetInfo.isPostEvolve

		if skinId > 0 then
			self:_showRoleModel(skinId)
		end

		return skinId
	end

	return 0
end

function DivineEvolveMainView:_setPreEvolveConditions(raceId)
	self:_removePreEvolveConditions()
	table.clear(self._curSelectPetIds)

	local cfg = EvolveConfig.instance:getDivineEvolveCfg(raceId)

	for i = 1, 3 do
		local element = self._preEvolveCells[i]
		local conditionStr = cfg.petCost[i]

		self:_setPreEvolveCell(i, element, conditionStr, cfg.des[i])
	end

	self:_setPreEvolveItem(cfg.goodsCost)
end

function DivineEvolveMainView:_removePreEvolveConditions()
	for i, v in ipairs(self._preEvolveCells) do
		MaterialMgr.clearIcon(v.bgIcon)
		MaterialMgr.resetAll(v.item)
		v.btnAdd:RemoveClickListener()
	end
end

function DivineEvolveMainView:_getAttrs(conditionStr)
	return DivineEvolveController.instance:getAttrs(conditionStr)
end

function DivineEvolveMainView:_setPreEvolveCell(index, element, conditionStr, desc)
	element.mask:SetActive(true)
	element.plusGo:SetActive(true)

	element.txtNum.text = "0/1"

	MaterialMgr.resetAll(element.item)

	local race, initRare, awakenLevel, level, raceType = self:_getAttrs(conditionStr)

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

	element.btnAdd:RemoveClickListener()
	element.btnAdd:AddClickListener(function()
		local title = desc

		local function filterFunc(petMo)
			return GameUtil.expScript(conditionStr, GameUtil.handler(self.OnFilter, self, petMo))
		end

		local function onSeletCallBack(petIds, petIdList)
			if petIdList and #petIdList > 0 then
				DivineEvolveController.instance:notify(DivineEvolveController.UpdateEvolveCondition, index, petIdList[1])
			end
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
				PetSelectController.instance:OpenView(true, title, filterFunc, onSeletCallBack, nil)
			elseif isExistPet then
				local function func()
					UIStateManager.instance:push(ViewName.PetView)
				end

				TipsFacade.instance:openTipWindow(lang("tip"), "无符合条件精灵", func, "前往培养")
			else
				local function func()
					MaterialMgr.openGetSource(MatType.Pet, race)
				end

				TipsFacade.instance:openTipWindow(lang("tip"), "无符合条件精灵", func, "获取途径")
			end
		else
			PetSelectController.instance:OpenView(true, title, filterFunc, onSeletCallBack, nil)
		end
	end)
end

function DivineEvolveMainView:_setPreEvolveItem(goodsCost)
	local element = self._preEvolveCells[4]

	MaterialMgr.resetAll(element.item)

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

	element.txtNum.text = string.format("%d/%d", curCount, matNum)
end

function DivineEvolveMainView:OnFilter(petMo, str)
	return FightingPowerFormula.instance:OnFilter(petMo, str)
end

function DivineEvolveMainView:_getIconPath(initRare, raceType)
	local pre = rareDic[initRare]
	local post = pathDic[GameEnum.Races[raceType]]

	return (string.format("icon_%s_%s", pre, post))
end

function DivineEvolveMainView:_setPreChallengeCells(raceId)
	self:_removePreChallengeCells()

	local cfg = EvolveConfig.instance:getDivineEvolveCfg(raceId)

	for i = 1, 3 do
		local element = self._preChallengeCells[i]

		element.txtNum.text = "1"

		local conditionStr = cfg.petCost[i]

		MaterialMgr.resetAll(element.item)

		local race, initRare, awakenLevel, level, raceType = self:_getAttrs(conditionStr)

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

				local function callback()
					MaterialMgr.openGetSource(MatType.Pet, race)
				end

				proxy.binder:setClickCallBack(callback)
			end

			if awakenLevel ~= nil then
				element.awakenGo:SetActive(true)

				element.txtAwaken.text = awakenLevel
			end
		end
	end

	self:_setPreChallengeItem(cfg.goodsCost)
end

function DivineEvolveMainView:_removePreChallengeCells()
	for i, v in ipairs(self._preChallengeCells) do
		MaterialMgr.clearIcon(v.bgIcon)
		MaterialMgr.resetAll(v.item)
	end
end

function DivineEvolveMainView:_setPreChallengeItem(goodsCost)
	local element = self._preChallengeCells[4]

	MaterialMgr.resetAll(element.item)

	local matType, id, matNum = MaterialMgr.getMatParams(goodsCost)
	local proxy = MaterialMgr.setCellByCfg(goodsCost, element.item)

	if proxy then
		proxy.binder:setNum(0)
		proxy.binder:setAutoTips(false)
		proxy:setCallBack(function()
			MaterialMgr.openGetSource(matType, id)
		end)
	end

	element.txtNum.text = matNum
end

function DivineEvolveMainView:_loadEffect()
	self:_removeEffect()

	local effectPath = "fx_ui_2021930/fx_ui_shenqi/fx_ui_shenqijinhua.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effectPath, self._effectGo.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	uiEffect.hideEffWhileNotOnTop = false
	self._uiEffect = uiEffect
end

function DivineEvolveMainView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function DivineEvolveMainView:_refreshCurPetInfo()
	if self._curPetInfo then
		self._curPetInfo.state = self:_getPetMoState(self._curPetInfo.petMo, self._curPetInfo.raceId)
	end

	self:_refreshPetInfo(self._curPetInfo)
end

return DivineEvolveMainView
