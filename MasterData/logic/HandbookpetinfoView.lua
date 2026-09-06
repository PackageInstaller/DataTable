-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/HandbookpetinfoView.lua

module("logic.extensions.handbook.view.HandbookpetinfoView", package.seeall)

local HandbookpetinfoView = class("HandbookpetinfoView", ViewComponent)
local STACK_LIST = {
	ViewName.HandbookpetbasicView,
	ViewName.HandbookpetintroduceView,
	ViewName.HandbookpetattributeView
}
local TABSTATE = {
	introduce = 2,
	basic = 1,
	attribute = 3
}
local INDEX_TO_PATH = {
	"fx_ui_tujian/fx_ui_shengji_tujian_shengming.prefab",
	"fx_ui_tujian/fx_ui_shengji_tujian_gongji.prefab",
	"fx_ui_tujian/fx_ui_shengji_tujian_wufang.prefab",
	"fx_ui_tujian/fx_ui_shengji_tujian_mofang.prefab"
}

function HandbookpetinfoView:_getPath()
	return {
		cellPath = "Cell",
		viewPath = "ScrollView"
	}
end

function HandbookpetinfoView:ctor()
	HandbookpetinfoView.super.ctor(self)
end

function HandbookpetinfoView:buildUI()
	HandbookpetinfoView.super.buildUI(self)

	self._btnTips = self:getGo("sumAttribute/btnTips")
	self._btnTipsCol = self:getGo("sumAttribute/btnTips/tipsCol")
	self._btnTipsContView = self:getGo("sumAttribute/btnTips/tipsCol/contView")
	self._btnTipClickMask = self:getGo("sumAttribute/btnTips/tipsCol/clickMask")
	self._btnClose = self:getBtn("btnClose")
	self._btnLeft = self:getBtn("btn_left")
	self._btnRight = self:getBtn("btn_right")
	self._imgJob = goutil.findChildComponent(self.mainGO, "job/icon", "UIImageSpriteChange")
	self._imgJob1 = goutil.findChildComponent(self.mainGO, "job1/icon", "UIImageSpriteChange")
	self._imgAttr = goutil.findChildComponent(self.mainGO, "attr/icon", "UIImageSpriteChange")
	self._Job = goutil.findChild(self.mainGO, "job")
	self._Job1 = goutil.findChild(self.mainGO, "job1")
	self._Attr = goutil.findChild(self.mainGO, "attr")
	self._txtPower = goutil.findChildComponent(self.mainGO, "power/txt_power", "Text")
	self._btnBasic = self:getBtn("btnBasic")
	self._goBasicSelect = self:getGo("btnBasic/select")
	self._btnIntroduce = self:getBtn("btnIntroduce")
	self._goIntroSelect = self:getGo("btnIntroduce/select")
	self._btnAtt = self:getBtn("btnAttribute")
	self._goAttSelect = self:getGo("btnAttribute/select")
	self._btnToget = self:getBtn("btnToget")
	self._goToget = self:getGo("btnToget")
	self._btnShare = self:getBtn("btnShare")
	self._btnVideo = self:getBtn("btnVideo")
	self._btnZoom = self:getBtn("btnZoom")
	self._btnDrawing = self:getBtn("btnDrawing")
	self.commentBtn = self:getBtn("commentBtn")
	self._switchOn = goutil.findChild(self._btnDrawing.gameObject, "on")
	self._switchOff = goutil.findChild(self._btnDrawing.gameObject, "off")
	self.txt_name = goutil.findChildTextComponent(self.mainGO, "txt_name")
	self._rarePoint = self:getGo("imgRare")
	self._imgSex = goutil.findChildComponent(self.mainGO, "imgSex", "UIImageSpriteChange")
	self.txt_power = goutil.findChildTextComponent(self.mainGO, "power/txt_power")
	self._bubble = self:getGo("mask/role/bubble")
	self.txtEvname = goutil.findChildTextComponent(self.mainGO, "cv/txtEvname")
	self._btnVoice = self:getBtn("btnVoice")
	self._gocvName = goutil.findChild(self.mainGO, "cv")
	self._goVoice = goutil.findChild(self.mainGO, "btnVoice")
	self._Container = self:getGo("container")
	self._customInput = UICustomInput.Get(self._Container)

	local dragContent = self:getGo("mask/role/dragContent")
	local rawImg = goutil.findChild(dragContent, "role_image_1")

	self._rawImgDrag = RawImageDrag.New(dragContent, rawImg)

	self._rawImgDrag:setUpdateCallback(self._updateCell, self)
	self._rawImgDrag:setClickCallback(self._onClickCell, self)

	self._nowayMask = goutil.findChild(self.mainGO, "nowayMask")
	self._txtLife = goutil.findChildTextComponent(self.mainGO, "sumAttribute/life/txtNum")
	self._txtAttack = goutil.findChildTextComponent(self.mainGO, "sumAttribute/attack/txtNum")
	self._txtDefend = goutil.findChildTextComponent(self.mainGO, "sumAttribute/defend/txtNum")
	self._txtMagic = goutil.findChildTextComponent(self.mainGO, "sumAttribute/magic/txtNum")
	self._goEffectList = {}

	table.insert(self._goEffectList, self:getGo("sumAttribute/life/effect"))
	table.insert(self._goEffectList, self:getGo("sumAttribute/attack/effect"))
	table.insert(self._goEffectList, self:getGo("sumAttribute/defend/effect"))
	table.insert(self._goEffectList, self:getGo("sumAttribute/magic/effect"))

	self._attrRedPoint = self:getGo("btnAttribute/redPoint")
	self._effectList = {}
end

function HandbookpetinfoView:bindEvents()
	HandbookpetinfoView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBasic:AddClickListener(function()
		self:_onClickSwitch(TABSTATE.basic)
	end, self)
	self._btnIntroduce:AddClickListener(function()
		self:_onClickSwitch(TABSTATE.introduce)
	end, self)
	self._btnAtt:AddClickListener(function()
		self:_onClickSwitch(TABSTATE.attribute)
	end, self)
	self._btnToget:AddClickListener(self._onClickToGet, self)
	self._btnShare:AddClickListener(function()
		ShareController.instance:share(1, {
			self._btnShare.gameObject
		}, nil, 200290)
	end)
	self._btnVideo:AddClickListener(self._onClickVideo, self)
	self._btnZoom:AddClickListener(self._onClickZoom, self)
	self._btnLeft:AddClickListener(function()
		self:_onClickSwitchPet(true)
	end, self)
	self._btnRight:AddClickListener(function()
		self:_onClickSwitchPet(false)
	end, self)
	self._btnDrawing:AddClickListener(self._onClickSwitchDrawing, self)
	self.commentBtn:AddClickListener(function()
		UIStateManager.instance:open(ViewName.PetComment, self.raceId)
	end, self)
	self._btnVoice:AddClickListener(self._onClickVoice, self)
	self._customInput:AddListener(self._onCloseCVviewCallback, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnTipClickMask, self._onClickBtnTipClickMask, self)
end

function HandbookpetinfoView:unbindEvents()
	HandbookpetinfoView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBasic:RemoveClickListener()
	self._btnAtt:RemoveClickListener()
	self._btnIntroduce:RemoveClickListener()
	self._btnToget:RemoveClickListener()
	self._btnShare:RemoveClickListener()
	self._btnVideo:RemoveClickListener()
	self._btnZoom:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnDrawing:RemoveClickListener()
	self.commentBtn:RemoveClickListener()
	self._btnVoice:RemoveClickListener()
	self._customInput:RemoveListener()
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnTipClickMask)
end

function HandbookpetinfoView:destroyUI()
	HandbookpetinfoView.super.destroyUI(self)
end

function HandbookpetinfoView:onEnter()
	HandbookpetinfoView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self.raceId = checknumber(params[1])
	self._allList = params[2] or {}

	if #self._allList <= 0 then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(self.raceId)

		self._allList = {
			cfg
		}
	end

	self._rawImgDrag:setDragEnabled(#self._allList > 0)

	self._curIndex = 1

	for i, v in ipairs(self._allList) do
		if self.raceId == v.raceId then
			self._curIndex = i

			break
		end
	end

	self._petPhotoShows = {}
	self.petCvViewOnShow = false
	self._isLihui = true

	local prize = ShareController.instance.activeByTimes(1, goutil.findChild(self._btnShare.gameObject, "bubble"))

	MaterialMgr.setCellByCfg(prize, goutil.findChild(self._btnShare.gameObject, "bubble/reward"))

	if HandbookController.instance:getIfCanActiveOrUpgrade(self.raceId) then
		self._tabView = TABSTATE.attribute
	else
		self._tabView = PetbookModel.instance:getEnterTab() or TABSTATE.basic

		PetbookModel.instance:setEnterTab()
	end

	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.HandBookAttributeChange, self._setAttribute, self)
	GlobalDispatcher:addListener(GlobalNotify.HandBookAttributeChange, self._showEffect, self)
	self:centerOnIndex(self._curIndex, false)
	self:_setAttribute()

	self._needGc = false

	settimer(10, self._onGcTime, self)
end

function HandbookpetinfoView:onEnterFinished()
	HandbookpetinfoView.super.onEnterFinished(self)
end

function HandbookpetinfoView:onExit()
	HandbookpetinfoView.super.onExit(self)
	self:_stopEffect()
	PetCvController.instance:turnOffCurCv(false)
	MaterialMgr.resetAll(self._rarePoint)

	for _, v in ipairs(self._petPhotoShows) do
		v:destroy()
	end

	self._petPhotoShows = nil
	self._curPetPhotoShow = nil

	GlobalDispatcher:removeListener(GlobalNotify.HandBookAttributeChange, self._setAttribute, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedpoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookAttributeChange, self._showEffect, self)
	MaterialMgr.resetAll(goutil.findChild(self._btnShare.gameObject, "bubble/reward"))
	removetimer(self._onGcTime, self)
	self:_onGcTime()
end

function HandbookpetinfoView:_onGcTime()
	if self._needGc then
		self._needGc = false

		ResGcMgr.instance:gc()
	end
end

function HandbookpetinfoView:onExitFinished()
	HandbookpetinfoView.super.onExitFinished(self)
end

function HandbookpetinfoView:_onClickClose()
	self:close()
end

function HandbookpetinfoView:_refresh()
	self._curIndex = self._curIndex or 1

	local obj = {}

	obj = #self._allList > 0 and self._allList[self._curIndex] or MaterialMgr.getMatCfg(MatType.Pet, self.raceId)
	self.raceId = obj.raceId
	self._skinId = obj.skinId

	local cfg = HandbookConfig.instance:getPetDetailsCfgById(self.raceId)

	GameUtil.SetActive(self._nowayMask, checknumber(cfg.unproved) == 1)
	goutil.setActive(self._switchOn, self._isLihui)
	goutil.setActive(self._switchOff, not self._isLihui)
	GameUtil.SetActive(self._btnDrawing, CharacterConfig.instance:CheckHasTowAsset(self.raceId))

	cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

	if cfg then
		self:refreshJob(cfg)

		self.txt_name.text = cfg.skinName

		self._imgSex:SetState(cfg.genderId - 1)

		local petCo = CharacterConfig.instance:getPetCo(self.raceId)
		local rare = GameEnum.PetRare.N

		rare = CharacterConfig.instance:getRareByAwakenLv(petCo.initAwakenLv, self.raceId)

		local proxy = MaterialMgr.setCell(MatType.Rare, cfg.raceId, self._rarePoint)

		proxy.binder:setRare(rare)
	end

	local maxMo = FightingPowerFormula.instance:getRealMaxFightingPowerPetMo(self.raceId)

	self._txtPower.text = maxMo:getFightingPower()

	local cvName = PetSkinConfig.instance:getSkinCvName(self._skinId)
	local cvIsExist = not string.nilorempty(cvName)

	if cvIsExist then
		self.txtEvname.text = "CV." .. cvName

		goutil.setActive(self._gocvName, true)
		goutil.setActive(self._goVoice, true)
	else
		goutil.setActive(self._gocvName, false)
		goutil.setActive(self._goVoice, false)
	end

	local unproved = HandbookConfig.instance:getPetDetailsCfgById(self.raceId).unproved == 1

	goutil.setActive(self._goToget, not unproved)
	self:_updateSwitchBtnStatus()
	self:_refreshTabView()
	self:_updateRedpoint()
end

function HandbookpetinfoView:_refreshTabView()
	goutil.setActive(self._goBasicSelect, self._tabView == TABSTATE.basic)
	goutil.setActive(self._goIntroSelect, self._tabView == TABSTATE.introduce)
	goutil.setActive(self._goAttSelect, self._tabView == TABSTATE.attribute)

	local name = STACK_LIST[self._tabView]

	if name == nil then
		FloatWordMgr.instance:show(ConstString.NotRelease)

		return
	end

	if self.petCvViewOnShow then
		self:showTabAt(self._Container, ViewName.PetcvView)
	else
		self:showTabAt(self._Container, name)
	end
end

function HandbookpetinfoView:_setAttribute()
	local lifeSum, attackSum, defendSum, magicSum = HandbookController.instance:calculateSumAttr()
	local fixLifeSum, fixAttackSum, fixDefendSum, fixMagicSum = HandbookController.instance:calculateSumFixAttr()

	self._txtLife.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", lifeSum, fixLifeSum)
	self._txtAttack.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", attackSum, fixAttackSum)
	self._txtDefend.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", defendSum, fixDefendSum)
	self._txtMagic.text = langPara("+%s%%(<color=#75F859FF>+%s</color>)", magicSum, fixMagicSum)

	GameUtil.SetActive(self._btnTipsCol, false)
end

function HandbookpetinfoView:refreshJob(cfg)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.raceId)

	self._imgJob:SetState(firstJobIdx - 1)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(cfg.raceId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	self._imgAttr:SetState(targetValue)
	GameUtil.asBtn(self._Attr):RemoveClickListener()
	GameUtil.asBtn(self._Attr):AddClickListener(function()
		CommonTipsMgr.instance:openMaterialTips(self._Attr, MatType.Race, race)
	end)
	GameUtil.asBtn(self._Job):RemoveClickListener()
	GameUtil.asBtn(self._Job):AddClickListener(function()
		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(cfg.raceId)

		CommonTipsMgr.instance:openMaterialTips(self._Job, MatType.Job, firstJobIdx)
	end)
	goutil.setActive(self._imgJob1.transform.parent.gameObject, false)
	goutil.setActive(self._imgJob.transform.parent.gameObject, true)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(cfg.raceId)

	if secondJobIdx > 20 then
		goutil.setActive(self._imgJob1.transform.parent.gameObject, true)
		self._imgJob1:SetState(secondJobIdx - 1 - 20)
		GameUtil.asBtn(self._Job1):RemoveClickListener()
		GameUtil.asBtn(self._Job1):AddClickListener(function()
			CommonTipsMgr.instance:openMaterialTips(self._Job1, MatType.Job, secondJobIdx)
		end)
	end
end

function HandbookpetinfoView:centerOnIndex(idx, isSpring, isLeft)
	idx = checknumber(idx)

	local len = #self._allList

	if idx >= 1 and idx <= len then
		self._rawImgDrag:setMaxNum(len)
		self._rawImgDrag:centerOnIndex(idx, isSpring, isLeft)
	end

	self:_refresh()
end

function HandbookpetinfoView:_updateCell(idx, cell)
	if idx ~= self._curIndex then
		self._curIndex = idx

		self:_refresh()
		PetCvController.instance:turnOffCurCv()
	end

	local obj = {}

	obj = #self._allList > 0 and self._allList[self._curIndex] or MaterialMgr.getMatCfg(MatType.Pet, self.raceId)
	self.raceId = obj.raceId
	self._skinId = obj.skinId

	local petPhotoShow = PetPhotoShow.Get(cell.gameObject)

	PetbookModel.instance:setSelectedPet(self._skinId)

	local params = self:getOpenParam()

	if params then
		params[1] = self.raceId

		UIStateManager.instance:updateParms(self._viewPresentor.viewName, self._viewPresentor._openParam)
	end

	petPhotoShow:showPetEffect(self._skinId, self._isLihui, 4, "handbook")

	self._needGc = true
	self._curPetPhotoShow = petPhotoShow

	table.insert(self._petPhotoShows, petPhotoShow)
end

function HandbookpetinfoView:_onClickCell()
	local pos = self._bubble.transform.position

	PetCvController.instance:playPetCv(self._skinId, nil, true, pos)

	if self._curPetPhotoShow then
		self._curPetPhotoShow:playShowAnim()
	end
end

function HandbookpetinfoView:_onClickSwitch(tabIndex)
	if self._isTweening then
		return
	end

	if self._tabView ~= tabIndex then
		self._tabView = tabIndex

		self:_refreshTabView()
	end
end

function HandbookpetinfoView:_onClickSwitchPet(isLeft)
	if self._isTweening then
		return
	end

	if isLeft then
		if not (self._curIndex - 1) then
			local temp = self._curIndex + 1
			local len = #self._allList

			if temp < 1 or len < temp then
				return
			end

			local obj = {}

			obj = #self._allList > 0 and self._allList[self._curIndex] or MaterialMgr.getMatCfg(MatType.Pet, self.raceId)
			self.raceId = obj.raceId
			self._skinId = obj.skinId

			self:centerOnIndex(temp, true, isLeft)
		end
	end
end

function HandbookpetinfoView:_updateSwitchBtnStatus()
	local len = #self._allList

	goutil.setActive(self._btnLeft.gameObject, len > 0 and self._curIndex > 1)
	goutil.setActive(self._btnRight.gameObject, len > 0 and len > self._curIndex)
end

function HandbookpetinfoView:_onClickToGet()
	if PetbookModel.instance:getPetbookTab() == PetbookModel.TAB_PET_RACEID then
		MaterialMgr.openGetSource(MatType.PetPiece, self.raceId)
	else
		MaterialMgr.openGetSource(MatType.PET_SKIN, self._skinId)
	end
end

function HandbookpetinfoView:_onClickVideo()
	PetbookController.instance:previewBattle(self.raceId, self._skinId)
end

function HandbookpetinfoView:_onClickZoom()
	UIStateManager.instance:push(ViewName.PetDrawing, self._skinId)
end

function HandbookpetinfoView:_onClickSwitchDrawing()
	self._isLihui = not self._isLihui

	self:centerOnIndex(self._curIndex, false)
end

function HandbookpetinfoView:_onClickVoice()
	self.petCvViewOnShow = true

	self:_refresh()
	self._btnBasic.gameObject:SetActive(false)
	self._btnIntroduce.gameObject:SetActive(false)
	self._btnAtt.gameObject:SetActive(false)
	GameUtil.SetActive(self._nowayMask, false)
end

function HandbookpetinfoView:_onCloseCVviewCallback(hover)
	if not hover and self.petCvViewOnShow then
		self.petCvViewOnShow = false

		self._btnBasic.gameObject:SetActive(true)
		self._btnIntroduce.gameObject:SetActive(true)
		self._btnAtt.gameObject:SetActive(true)
		AudioVoicePlayer.instance:playVoiceByEvt(nil)
		self:_refresh()
	end
end

function HandbookpetinfoView:_updateRedpoint()
	goutil.setActive(self._attrRedPoint, HandbookController.instance:getIfCanActiveOrUpgrade(self.raceId))
end

function HandbookpetinfoView:_showEffect(raceId)
	self:_stopEffect()

	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local manualBenefitId = petCo.manualBenefitId
	local cfg = HandbookConfig.instance:getBenefitCfg(manualBenefitId, 0)
	local needToUpgradeParam = {
		cfg.formulaPropertyType
	}

	for k, v in pairs(needToUpgradeParam) do
		local index = HandbookModel.ATTTYPE_MAP[v]

		if checknumber(index) > 0 then
			local effPath = INDEX_TO_PATH[index]

			self._effectList[index] = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, false, nil, nil, function(finishHandlerTarget, eff)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
			end)

			self._effectList[index]:setParent(self._goEffectList[index].transform)
			self._effectList[index]:setScale(1)

			self._effectList[index].hideEffWhileNotOnTop = true
		end
	end
end

function HandbookpetinfoView:_stopEffect()
	for i = 1, 4 do
		if self._effectList[i] then
			UIEffectManager.instance:stopEffect(self._effectList[i])
		end
	end
end

function HandbookpetinfoView:_onClickBtnTips()
	local viewName, dataList = HandbookController.instance:getPopWinPetRelationTipsViewAndDataList()

	for idx, data in ipairs(dataList) do
		local txtCont = goutil.findChildTextComponent(self._btnTipsContView, string.format("contCell_%s/txtCont", idx))

		if txtCont then
			txtCont.text = data.txtCont
		end
	end

	GameUtil.SetActive(self._btnTipsCol, true)
end

function HandbookpetinfoView:_onClickBtnTipClickMask()
	GameUtil.SetActive(self._btnTipsCol, false)
end

return HandbookpetinfoView
