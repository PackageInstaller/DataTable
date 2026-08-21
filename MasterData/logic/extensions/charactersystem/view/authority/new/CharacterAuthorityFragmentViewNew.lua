-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/authority/new/CharacterAuthorityFragmentViewNew.lua

module("logic.extensions.charactersystem.view.authority.new.CharacterAuthorityFragmentViewNew", package.seeall)

local M = class("CharacterAuthorityFragmentViewNew", CharacterMainSystemSubViewBase)

M.NodeCellShowOrder = {
	HeroPowerConfig.PowerNodeEffectEnum.POWER_LEVEL_UP,
	HeroPowerConfig.PowerNodeEffectEnum.SKILL_UPGRADE,
	HeroPowerConfig.PowerNodeEffectEnum.ATTR_ADD
}
M.NodeTipsInfoShowOrder = {
	HeroPowerConfig.PowerNodeEffectEnum.POWER_LEVEL_UP,
	HeroPowerConfig.PowerNodeEffectEnum.ATTR_ADD,
	HeroPowerConfig.PowerNodeEffectEnum.SKILL_UPGRADE
}
M.RingCtrlTyp = {
	Default = 0,
	Mode1 = 1
}

local anchorX = 314

function M:getPageIndex()
	return CommEnum.CharacterSystemTab.Authority
end

function M:buildUI()
	M.super.buildUI(self)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Authority)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Language)

	self._rectTrSwitch = self._registry:getUIComponent("authority_main_panel_copy_88516964", UIComponentType.RectTransform)

	local rootLv = self._registry:getUIComponent("authority_main_panel_copy_-1739194296", UIComponentType.RectTransform)

	self._cellLvGroup = {}

	for i = 1, 5 do
		local _level = i
		local go = goutil.findChild(rootLv, string.format("level%s", _level)).gameObject

		self._cellLvGroup[_level] = {
			go = go,
			goMarkUnLock = goutil.findChild(go, "unLock").gameObject,
			goMarkLock = goutil.findChild(go, "lock").gameObject,
			animation = go:GetComponent(ComponentType.Animation),
			canvasGroup = go:GetComponent(ComponentType.CanvasGroup)
		}
	end

	self._goCellBgLv5 = self._registry:getGo("authority_main_panel_copy_-273997753")
	self._rootNode = self._registry:getUIComponent("authority_main_panel_copy_975601540", UIComponentType.RectTransform)

	self:_initNodes()

	local _go = self:isLoaded()

	self._authorityDetailTips = Astral.SimpleLuaComponentContainer.Add(_go, CharacterAuthorityDetailTips)
	self._authorityRingCtrl = Astral.SimpleLuaComponentContainer.Add(_go, CharacterAuthorityRingCtrl)

	self._authorityRingCtrl:setHandler(self)
	self:addSubView(MoneyView.New(CommEnum.MoneyShowType.OnlyMoneyShowType, self._registry:getGo("top_currency_1050779625")))

	self._dropCtrlTyp = goutil.findChildComponent(_go, "CtrlTyp/dropDownCtrlTyp", UIComponentType.Dropdown)
	self._dropAdapterCtrlTyp = goutil.findChildComponent(_go, "CtrlTyp/dropDownCtrlTyp", UIComponentType.DropdownApapter)
	self._goChange = self._registry:getGo("authority_main_panel_copy_2135346567")
	self._btnChange = self._registry:getBtn("authority_main_panel_copy_2135346567")
	self._textChange = self._registry:getText("authority_main_panel_copy_-705511955")

	goutil.setActive(self._goChange, false)

	self._btnChangeBottom = self._registry:getBtn("authority_main_panel_copy_1066087361")
	self._textChangeBottom = self._registry:getText("authority_main_panel_copy_1270683176")

	goutil.setActive(self._btnChangeBottom.gameObject, false)
end

function M:_initNodes()
	self._cellNodeGroup = {}

	local instGos = AuthorityResMgr.instance:getResInstances()

	for i = 1, 5 do
		for j = 1, 5 do
			local _nodeId = j + (i - 1) * 5
			local rootGo = goutil.findChild(self._rootNode, string.format("node%s_%s", i, j)).gameObject
			local cellGo = #instGos > 0 and table.remove(instGos, 1) or AuthorityResMgr.instance:getResInstance(ResName.CharacterSystem_Authority_Node)

			goutil.addChildToParent(cellGo, rootGo)
			GameUtils.setAnchorXY(cellGo.transform, anchorX, 0)

			self._cellNodeGroup[_nodeId] = self:_buildCellNode(rootGo, cellGo, i, j, _nodeId)
		end
	end
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._isEnter = nil

	self:_setEvent(false)

	for _, cell in pairs(self._cellNodeGroup or {}) do
		if cell.destroyUI then
			cell.destroyUI()
		end
	end

	self._cellNodeGroup = nil
	self._cellLvGroup = nil

	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.CharacterSysAuthority)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Authority)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Language)
end

function M:bindEvents()
	self._dropAdapterCtrlTyp:AddListener(self._onDropDownCtrlTyp, self)
	self._btnChange:AddClickListener(self._onClickChange, self)
	self._btnChangeBottom:AddClickListener(self._onClickChange, self)
end

function M:unbindEvents()
	self._dropAdapterCtrlTyp:RemoveClickListener()

	for _, cell in pairs(self._cellNodeGroup or {}) do
		if cell.btnClick then
			cell.btnClick:RemoveClickListener()
		end
	end

	self._btnChange:RemoveClickListener()
	self._btnChangeBottom:RemoveClickListener()
end

function M:_onDropDownCtrlTyp(index)
	self._ringCtrlTyp = index

	for _lv, cell in pairs(self._cellLvGroup) do
		goutil.setActive(cell.goMarkUnLock.gameObject, false)
		goutil.setActive(cell.goMarkLock.gameObject, false)
	end

	self:_refreshAuthorityNodes()
end

function M:getRingCtrlTyp()
	return self._ringCtrlTyp or M.RingCtrlTyp.Mode1
end

function M:onEnter()
	self:_setEvent(true)

	self._isEnter = true

	self:_setRightInfo()
	M.super.onEnter(self)
end

function M:onExit()
	removetimer(self.onEnterNextFrame, self)
	self:_setEvent(false)
	self._authorityDetailTips:onExit()
	self._authorityRingCtrl:onExit()

	self._isEnter = false

	CharacterAuthorityModel.instance:setRunLineEffect(false)
	ViewBlockMgr.instance:blockClick(false, ViewBlockKey.CharacterSysAuthority)

	for _, cell in pairs(self._cellNodeGroup or {}) do
		cell.setUnlockVfxShow(false)
	end

	self._lastUnLockLvCache = false
end

function M:onExitFinished()
	return
end

function M:_setRightInfo()
	if not self._isEnter then
		return
	end

	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	self._heroData = viewPageMo and viewPageMo.hero or false
	self._heroList = viewPageMo and viewPageMo.list or false
	self._maxPowerGroupCount = HeroPowerConfig.instance:getMaxPowerGroupCount(self._heroData:getId())
	self._maxPowerLevel = HeroPowerConfig.instance:getMaxPowerLevel(self._heroData:getId())

	goutil.setActive(self._goCellBgLv5, self._maxPowerGroupCount >= 5)
	self._authorityDetailTips:onEnter()
	self._authorityDetailTips:setHeroData(self._heroData, self._maxPowerLevel)
	self._authorityDetailTips:setlectTab(CharacterAuthorityDetailTips.TipsTabTyp.Node)
	self:_selectNode(nil)
	self:_selectNodeLv(nil)
	self._authorityRingCtrl:onEnter()
	self._authorityRingCtrl:setMaxPowerGroupCount(self._maxPowerGroupCount)
	CharacterAuthorityModel.instance:initHeroPowerNodesMO(self._heroData:getId())

	local orgAngle = self._authorityRingCtrl:getMinAngle()

	self._authorityRingCtrl:lerpRingToAngle(orgAngle, DG.Tweening.Ease.Linear, 0, true, true)
	self:_refreshAuthorityNodes()
	self:_refreshChange()
end

function M:playGuiAni(name, isNormal)
	local __isNormal = true

	if isNormal ~= nil then
		__isNormal = isNormal
	end

	if not string.nilorempty(name) and __isNormal and self.mainGO.activeSelf and string.match(name, "open") then
		self._needAutoSelect = nil
	else
		self._needAutoSelect = {}
	end

	M.super.playGuiAni(self, name, isNormal)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HERO_POWER_REFRESH_NODE_INFO, self._refreshAuthorityNodes, self)
		GlobalDispatcher:addEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self)
		GlobalDispatcher:addEventListener(EventType.HERO_POWER_UNLOCK, self._handleHeroPowerUnlock, self)
		GlobalDispatcher:addEventListener(EventType.HERO_POWER_UPGRADE_TIPS_CLOSE, self._refreshAuthorityNodes, self)
		GlobalDispatcher:addEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self._refreshByHeroChange, self)
		GlobalDispatcher:addEventListener(EventType.CHARACTER_AUTHORITY_SWITCH_CIRCLE, self._onCircleChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HERO_POWER_REFRESH_NODE_INFO, self._refreshAuthorityNodes, self)
		GlobalDispatcher:removeEventListener(EventType.REFRESH_HERO_DEPOT_DATA, self._handleRefreshHeroDepotData, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self)
		GlobalDispatcher:removeEventListener(EventType.HERO_POWER_UNLOCK, self._handleHeroPowerUnlock, self)
		GlobalDispatcher:removeEventListener(EventType.HERO_POWER_UPGRADE_TIPS_CLOSE, self._refreshAuthorityNodes, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self._refreshByHeroChange, self)
		GlobalDispatcher:removeEventListener(EventType.CHARACTER_AUTHORITY_SWITCH_CIRCLE, self._onCircleChange, self)
	end
end

function M:_handleViewCloseEvent(e, viewName)
	return
end

function M:_handleHeroPowerUnlock(e, nodeStatusCache)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_qinhedujiesuo, nil, nil, nil)

	if nodeStatusCache then
		printWarn("====EventType._handleHeroPowerUnlock===", nodeStatusCache.skillId, nodeStatusCache.powerLvUpNum)

		if nodeStatusCache.skillId > 0 then
			-- block empty
		elseif nodeStatusCache.powerLvUpNum > 0 then
			-- block empty
		end
	else
		ToolTipsMgr.showCharacterTopToast(lang("tip_authority_unlock_success"), CommEnum.CharacterTopToastIcon.Succ, 1)
	end

	self:_refreshChange()
end

function M:_handleRefreshHeroDepotData(e, data)
	if data:getId() == self._heroData:getId() then
		self._heroData = data

		self._authorityDetailTips:setHeroData(self._heroData, self._maxPowerLevel)
		HeroDepotModel.instance:setViewPageMo({
			index = 1,
			hero = self._heroData,
			list = {
				self._heroData
			}
		})
	end
end

function M:_tryDealUpgradeTips()
	local showTips = false
	local unlockingNodeId = CharacterAuthorityModel.instance:getUnLockNodeIndex()
	local nodeStatusCache = CharacterAuthorityModel.instance:getPowerNodeUnlockCache(self._heroData:getId(), unlockingNodeId)

	if nodeStatusCache then
		local isUnlockSkill = nodeStatusCache.isUnlockSkill
		local isChangeNode = not string.nilorempty(nodeStatusCache.guideVideo)
		local isEnhanceSkill = nodeStatusCache.isEnhanceSkill

		if isUnlockSkill or isChangeNode then
			showTips = true

			local params = {
				heroId = nodeStatusCache.heroId,
				nodeId = nodeStatusCache.nodeId,
				isChangeNode = isChangeNode
			}

			ViewMgr.instance:open(ViewName.CharacterAuthorityNodeUnlockView, params)
		else
			showTips = true

			local params = {}

			params.type = isEnhanceSkill and CommEnum.MultiFunctionDataType.AuthoritySkillEnhance or CommEnum.MultiFunctionDataType.AuthorityUp
			params.data = {
				hasVideo = false,
				heroId = nodeStatusCache.heroId,
				id = nodeStatusCache.nodeId,
				powerLvUpNum = nodeStatusCache.powerLvUpNum
			}

			ViewMgr.instance:open(ViewName.MultiFuntionView, params)
		end
	end

	return showTips
end

function M:onDragToNode(nodeLv, nodeId)
	if not self._isEnter then
		return
	end

	self._authorityDetailTips:refreshTipsInfo(nodeLv, nodeId, false)
end

function M:onEndDragMatchNode(nodeLv, nodeId, angleOutOfLimit)
	if not self._isEnter then
		return
	end

	self._authorityDetailTips:refreshTipsInfo(nodeLv, nodeId, false)
	self:_selectNode(nodeId)
	self:_selectNodeLv(nodeLv)
	self:_setEffect(nodeLv)

	local ease = angleOutOfLimit and DG.Tweening.Ease.OutQuint or DG.Tweening.Ease.Linear
	local targetAngle = 0

	if self:getRingCtrlTyp() == M.RingCtrlTyp.Default then
		targetAngle = self._authorityRingCtrl:getNodeLvAngle(nodeLv)
	else
		targetAngle = self._authorityRingCtrl:getNodeAngle(nodeId, true)
	end

	self._authorityRingCtrl:lerpRingToAngle(targetAngle, ease, nil, false, true)
end

function M:refreshSwitchBtnWidth()
	if not self._roleMaskRange then
		local cameraTarget = CameraTargetMgr.instance:getUICameraTarget()
		local camera = cameraTarget:getCamera()
		local left, right, top, bottom = 0, 0, 0, 0
		local tempRectTr = self._goTips1:GetComponent(UIComponentType.RectTransform)

		left, right, top, bottom = RectTransformUtils.GetViewPortPercent(tempRectTr, camera, left, right, top, bottom)
		self._roleMaskRange = Vector4.New(left, right, 0, 1)
	end
end

function M:_selectNode(nodeId)
	if self._lastSelectNodeId and self._lastSelectNodeId ~= nodeId and self._cellNodeGroup[self._lastSelectNodeId] then
		self._cellNodeGroup[self._lastSelectNodeId].setSelect(false)
	end

	if nodeId and self._cellNodeGroup[nodeId] then
		self._cellNodeGroup[nodeId].setSelect(true)
	end

	self._lastSelectNodeId = nodeId
end

function M:_selectNodeLv(nodeLv)
	if self:getRingCtrlTyp() ~= M.RingCtrlTyp.Default then
		return
	end

	if self._lastSelectNodeLv and self._lastSelectNodeLv ~= nodeLv then
		goutil.setActive(self._cellLvGroup[self._lastSelectNodeLv].goMarkUnLock.gameObject, false)
		goutil.setActive(self._cellLvGroup[self._lastSelectNodeLv].goMarkLock.gameObject, true)
	end

	if nodeLv then
		goutil.setActive(self._cellLvGroup[nodeLv].goMarkUnLock.gameObject, true)
		goutil.setActive(self._cellLvGroup[nodeLv].goMarkLock.gameObject, false)
	end

	self._lastSelectNodeLv = nodeLv
end

function M:_setEffect(nodeLv)
	local powerLv = self._heroData:getPowerLv() == 0 and 1 or self._heroData:getPowerLv()
	local showSmokeLv = powerLv < nodeLv and powerLv or nodeLv

	GlobalDispatcher:dispatchEvent(EventType.CHARACTER_AUTH_SMOKE_SWITCH, showSmokeLv)
end

function M:_onNodeCellClick(nodeLv, nodeId, duration, speedBase)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_qinhedujieduanxuanze, nil, nil, nil)
	self._authorityDetailTips:refreshTipsInfo(nodeLv, nodeId, true)
	self:_selectNode(nodeId)
	self:_selectNodeLv(nodeLv)
	self:_setEffect(nodeLv)

	local targetAngle = 0

	if self:getRingCtrlTyp() == M.RingCtrlTyp.Default then
		targetAngle = self._authorityRingCtrl:getNodeLvAngle(nodeLv)
	else
		targetAngle = self._authorityRingCtrl:getNodeAngle(nodeId, true)
	end

	self._authorityRingCtrl:lerpRingToAngle(targetAngle, DG.Tweening.Ease.Linear, duration, true, speedBase)
end

function M:getNodeCell(nodeId)
	if nodeId and self._cellNodeGroup then
		return self._cellNodeGroup[nodeId]
	end

	return nil
end

function M:_buildCellNode(rootGo, go, nodeLv, nodeIndexInLv, nodeId)
	local cell = {
		rootGo = rootGo,
		go = go,
		nodeLv = nodeLv,
		nodeId = nodeId,
		nodeIndexInLv = nodeIndexInLv,
		goBigPoint = goutil.findChild(go, "bigPoint"),
		goNormalPoint = goutil.findChild(go, "normalPoint"),
		goMarkLock = goutil.findChild(go, "normalPoint/lock").gameObject,
		imgIconLock = goutil.findChildImageComponent(go, "normalPoint/lock/imgIcon"),
		txtNumLock = goutil.findChildTextComponent(go, "normalPoint/lock/txtNum"),
		goMarkUnLock = goutil.findChild(go, "normalPoint/unLock").gameObject,
		imgIconUnLock = goutil.findChildImageComponent(go, "normalPoint/unLock/imgIcon"),
		txtNumUnLock = goutil.findChildTextComponent(go, "normalPoint/unLock/txtNum"),
		goVFXUnlock = goutil.findChild(go, "normalPoint/unLock/vfx").gameObject,
		canvasGroupCurrent = goutil.findChildComponent(go, "normalPoint/current", ComponentType.CanvasGroup),
		imgIconCurrent = goutil.findChildImageComponent(go, "normalPoint/current/imgIcon"),
		txtNumCurrent = goutil.findChildTextComponent(go, "normalPoint/current/txtNum"),
		goMarkSelect = goutil.findChild(go, "normalPoint/select").gameObject,
		goMarkLockBig = goutil.findChild(go, "bigPoint/lock").gameObject,
		imgIconLockBig = goutil.findChildImageComponent(go, "bigPoint/lock/imgIcon"),
		txtNumLockBig = goutil.findChildTextComponent(go, "bigPoint/lock/txtNum"),
		goYiNengLock = goutil.findChild(go, "bigPoint/lock/iconYineng"),
		goMarkUnLockBig = goutil.findChild(go, "bigPoint/unLock").gameObject,
		imgIconUnLockBig = goutil.findChildImageComponent(go, "bigPoint/unLock/imgIcon"),
		txtNumUnLockBig = goutil.findChildTextComponent(go, "bigPoint/unLock/txtNum"),
		goYiNengUnlock = goutil.findChild(go, "bigPoint/unLock/iconYineng"),
		goVFXUnlockBig = goutil.findChild(go, "bigPoint/unLock/vfx").gameObject,
		canvasGroupCurrentBig = goutil.findChildComponent(go, "bigPoint/current", ComponentType.CanvasGroup),
		imgIconCurrentBig = goutil.findChildImageComponent(go, "bigPoint/current/imgIcon"),
		txtNumCurrentBig = goutil.findChildTextComponent(go, "bigPoint/current/txtNum"),
		goYiNengCurrent = goutil.findChild(go, "bigPoint/current/iconYineng"),
		goMarkSelectBig = goutil.findChild(go, "bigPoint/select").gameObject,
		goLineRoot = goutil.findChild(go, "line").gameObject,
		imgLineNext = goutil.findChildImageComponent(go, "line/line2"),
		goMarkRedPoint = goutil.findChild(go, "goRedPoint").gameObject,
		btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "click").gameObject)
	}

	function cell.getAngleZ()
		local rx, ry, rz = TransformUtils.GetLocalEulerAngles(rootGo.transform, 0, 0, 0)

		return rz
	end

	function cell.setSelect(select)
		goutil.setActive(cell.goMarkSelect, select)
		goutil.setActive(cell.goMarkSelectBig, select)
	end

	function cell.setRedPointShow(show)
		goutil.setActive(cell.goMarkRedPoint, show)
	end

	function cell.setUnLock(unLock, toBeUnlock)
		goutil.setActive(cell.goMarkLock, not unLock)
		goutil.setActive(cell.goMarkUnLock, unLock)
		goutil.setActive(cell.canvasGroupCurrent.gameObject, not unLock and toBeUnlock)
		goutil.setActive(cell.goMarkLockBig, not unLock)
		goutil.setActive(cell.goMarkUnLockBig, unLock)
		goutil.setActive(cell.canvasGroupCurrentBig.gameObject, not unLock and toBeUnlock)
	end

	function cell.setUnlockVfxShow(show)
		goutil.setActive(cell.goVFXUnlock, show)
		goutil.setActive(cell.goVFXUnlockBig, show)
	end

	function cell.updateIcon(heroId)
		local mo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(heroId, cell.nodeId)
		local _cfg = mo:getConfig() or {}
		local _effect = _cfg.effect or {}
		local _showTyp = HeroPowerConfig.PowerNodeEffectEnum.ATTR_ADD

		if mo:getPowerLevelUpNum() then
			_showTyp = HeroPowerConfig.PowerNodeEffectEnum.POWER_LEVEL_UP
		elseif mo:getAddSkillId() > 0 or mo:getSkillId() then
			_showTyp = HeroPowerConfig.PowerNodeEffectEnum.SKILL_UPGRADE
		end

		local isVideoGuide = _cfg.videoName ~= ""
		local isPowerLvUp = _showTyp == HeroPowerConfig.PowerNodeEffectEnum.POWER_LEVEL_UP
		local isShowBig = isPowerLvUp or _showTyp == HeroPowerConfig.PowerNodeEffectEnum.SKILL_UPGRADE or isVideoGuide

		goutil.setActive(cell.goNormalPoint, not isShowBig)
		goutil.setActive(cell.goBigPoint, isShowBig)
		goutil.setActive(cell.imgIconLock.gameObject, not isPowerLvUp)
		goutil.setActive(cell.imgIconUnLock.gameObject, not isPowerLvUp)
		goutil.setActive(cell.imgIconCurrent.gameObject, not isPowerLvUp)
		goutil.setActive(cell.txtNumLock.gameObject, isPowerLvUp)
		goutil.setActive(cell.txtNumUnLock.gameObject, isPowerLvUp)
		goutil.setActive(cell.txtNumCurrent.gameObject, isPowerLvUp)
		goutil.setActive(cell.imgIconLockBig.gameObject, not isPowerLvUp and not isVideoGuide)
		goutil.setActive(cell.imgIconUnLockBig.gameObject, not isPowerLvUp and not isVideoGuide)
		goutil.setActive(cell.imgIconCurrentBig.gameObject, not isPowerLvUp and not isVideoGuide)
		goutil.setActive(cell.txtNumLockBig.gameObject, isPowerLvUp)
		goutil.setActive(cell.txtNumUnLockBig.gameObject, isPowerLvUp)
		goutil.setActive(cell.txtNumCurrentBig.gameObject, isPowerLvUp)
		goutil.setActive(cell.goYiNengLock, isVideoGuide)
		goutil.setActive(cell.goYiNengUnlock, isVideoGuide)
		goutil.setActive(cell.goYiNengCurrent, isVideoGuide)

		if isPowerLvUp then
			local _lv = mo:getPowerLevelUpNum()

			cell.txtNumLock.text = _lv
			cell.txtNumUnLock.text = _lv
			cell.txtNumCurrent.text = _lv
			cell.txtNumLockBig.text = _lv
			cell.txtNumUnLockBig.text = _lv
			cell.txtNumCurrentBig.text = _lv
		elseif isVideoGuide then
			-- block empty
		elseif _showTyp == HeroPowerConfig.PowerNodeEffectEnum.SKILL_UPGRADE then
			local _skillId = mo:getAddSkillId() > 0 and mo:getAddSkillId() or mo:getSkillId()
			local skillCO = ActiveSkillConfig.instance:getActiveSkillCO(_skillId)
			local icon = ActiveSkillCOUtil.getSkillIcon(skillCO)

			IconLoader.setSprite(cell.imgIconLock, IconType.SkillIcon, icon)
			IconLoader.setSprite(cell.imgIconUnLock, IconType.SkillIcon, icon)
			IconLoader.setSprite(cell.imgIconCurrent, IconType.SkillIcon, icon)
			IconLoader.setSprite(cell.imgIconLockBig, IconType.SkillIcon, icon)
			IconLoader.setSprite(cell.imgIconUnLockBig, IconType.SkillIcon, icon)
			IconLoader.setSprite(cell.imgIconCurrentBig, IconType.SkillIcon, icon)
		else
			local icon = "qhd_icon_ren"

			IconLoader.setSprite(cell.imgIconLock, IconType.DynSpriteAtlas_CharacterSystem_Authority, icon)
			IconLoader.setSprite(cell.imgIconUnLock, IconType.DynSpriteAtlas_CharacterSystem_Authority, icon)
			IconLoader.setSprite(cell.imgIconCurrent, IconType.DynSpriteAtlas_CharacterSystem_Authority, icon)
			IconLoader.setSprite(cell.imgIconLockBig, IconType.DynSpriteAtlas_CharacterSystem_Authority, icon)
			IconLoader.setSprite(cell.imgIconUnLockBig, IconType.DynSpriteAtlas_CharacterSystem_Authority, icon)
			IconLoader.setSprite(cell.imgIconCurrentBig, IconType.DynSpriteAtlas_CharacterSystem_Authority, icon)
		end
	end

	function cell.setLineFillAmount(fillAmount, duration)
		cell.imgLineNext:DOKill()

		duration = duration or 0

		local show = fillAmount > 0

		if cell.lineFillShow ~= show then
			cell.lineFillShow = show

			goutil.setActive(cell.imgLineNext.gameObject, show)

			if show then
				cell.imgLineNext.fillAmount = 0
			end
		end

		if duration > 0 then
			cell.imgLineNext:DOFillAmount(fillAmount, duration):SetEase(DG.Tweening.Ease.Linear):SetAutoKill(true)
		else
			cell.imgLineNext.fillAmount = fillAmount
		end
	end

	function cell.setLineShow(show)
		goutil.setActive(cell.goLineRoot, show)
	end

	cell.btnClick:AddClickListener(function()
		self:_onNodeCellClick(nodeLv, nodeId, 0.25, false)
	end, self)

	function cell.destroyUI()
		cell.imgLineNext:DOKill()
		cell.btnClick:RemoveClickListener()
	end

	cell.setUnlockVfxShow(false)

	return cell
end

function M:_refreshAuthorityNodes()
	local heroId = self._heroData:getId()
	local nextUnlockId, isAllNormalUnlock = CharacterAuthorityModel.instance:getNextBeUnlockIndex(heroId)
	local affinity = self._heroData:getCharacterCo().affinity
	local powerLv = self._heroData:getPowerLv() == 0 and 1 or self._heroData:getPowerLv()
	local runLineEffect = CharacterAuthorityModel.instance:getRunLineEffect()
	local unlockingNodeId = -1

	if runLineEffect then
		CharacterAuthorityModel.instance:setRunLineEffect(false)

		unlockingNodeId = CharacterAuthorityModel.instance:getUnLockNodeIndex()
	end

	if Astral.OSDef.isEditor then
		printWarn(string.format("=refreshAuthorityNodes=>\n unlockingNodeId[%s],nextUnlockId[%s],powerLv[%s],runLineEffect[%s]", unlockingNodeId, nextUnlockId, powerLv, runLineEffect), debug.traceback())
	end

	local maxPowerGroup = self._maxPowerGroupCount
	local maxNodeId = maxPowerGroup * 5

	for _lv, cell in pairs(self._cellLvGroup) do
		local show = _lv <= maxPowerGroup

		goutil.setActive(cell.go, show)
	end

	for _, cell in pairs(self._cellNodeGroup) do
		local mo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(heroId, cell.nodeId)
		local isNormalNode = cell.nodeId <= 20
		local show = maxNodeId >= cell.nodeId
		local showLine = isNormalNode and maxNodeId > cell.nodeId
		local _isUnlock = CharacterAuthorityModel.instance:checkNodeIsUnlock(heroId, cell.nodeId)
		local _nextUnlock = CharacterAuthorityModel.instance:checkNodeIsUnlock(heroId, cell.nodeId + 1)
		local _toBeUnLock = not _isUnlock and cell.nodeId == nextUnlockId

		if show then
			cell.updateIcon(heroId)

			local duration = 0
			local _fillAmount = 0
			local _updateLockDirectly = true

			if isNormalNode then
				if isAllNormalUnlock then
					_fillAmount = cell.nodeId < 20 and 1 or 0
				else
					_fillAmount = _nextUnlock and 1 or 0
				end

				if runLineEffect then
					if cell.nodeId == unlockingNodeId - 1 then
						duration = 0.5

						ViewBlockMgr.instance:blockClick(true, ViewBlockKey.CharacterSysAuthority)

						self._delayTween = DoTweenUtil.DelayedCall(duration, function()
							local showTips = self:_tryDealUpgradeTips()

							if not showTips then
								self:_refreshAuthorityNodes()
								ToolTipsMgr.showCharacterTopToast(lang("tip_authority_unlock_success"), CommEnum.CharacterTopToastIcon.Succ, 1)
							end

							ViewBlockMgr.instance:blockClick(false, ViewBlockKey.CharacterSysAuthority)
						end)
					elseif cell.nodeId == unlockingNodeId then
						_updateLockDirectly = false

						local showVfx = true

						cell.setUnlockVfxShow(showVfx)

						if unlockingNodeId == 1 then
							local showTips = self:_tryDealUpgradeTips()

							if not showTips then
								self._needAutoSelect = {}

								self:_refreshAuthorityNodes()
								ToolTipsMgr.showCharacterTopToast(lang("tip_authority_unlock_success"), CommEnum.CharacterTopToastIcon.Succ, 1)
							end
						end
					end
				end
			end

			if _updateLockDirectly then
				cell.setUnLock(_isUnlock, _toBeUnLock)
			end

			cell.setLineFillAmount(_fillAmount, duration)
			cell.setLineShow(showLine)

			local _preUnlock = true

			if isNormalNode then
				if cell.nodeId > 1 then
					_preUnlock = CharacterAuthorityModel.instance:checkNodeIsUnlock(heroId, cell.nodeId - 1)
				end
			else
				_preUnlock = isAllNormalUnlock
			end

			cell.setRedPointShow(_preUnlock and not _isUnlock and mo:getNodeUnlockCostEnough())
		end

		goutil.setActive(cell.rootGo, show)
	end

	if runLineEffect then
		return
	end

	local defaultSelectId = nextUnlockId

	if self.params and self.params[1] and self.params[1].data then
		GlobalDispatcher:dispatchEvent(EventType.LEVELUP_TO_AUTHORITY)

		defaultSelectId = self.params[1].data
		self.params = false
	end

	if isAllNormalUnlock and maxPowerGroup > 4 then
		local findExtraNode

		for i = 21, 25 do
			if not findExtraNode and not CharacterAuthorityModel.instance:checkNodeIsUnlock(heroId, i) then
				findExtraNode = i
			end
		end

		defaultSelectId = findExtraNode and findExtraNode or defaultSelectId
	end

	local defaultSelectLv = math.min(math.ceil(nextUnlockId / 5), maxPowerGroup)

	defaultSelectId = math.min(defaultSelectId, maxNodeId)

	if self._needAutoSelect then
		self:_onNodeCellClick(defaultSelectLv, defaultSelectId, 0.25, false)
	else
		self._needAutoSelect = {}

		self:_onNodeCellClick(defaultSelectLv, defaultSelectId, 0, false)
	end

	self._needAutoSelect.nodeLv = defaultSelectLv
	self._needAutoSelect.nodeId = defaultSelectId

	self:_refreshAuthorityLv()
	CharacterAuthorityModel.instance:checkRedPoint(heroId)
end

function M:_refreshAuthorityLv()
	if self:getRingCtrlTyp() == M.RingCtrlTyp.Default then
		-- block empty
	else
		local heroId = self._heroData:getId()
		local allUnlockCount = CharacterAuthorityModel.instance:getAllNodeUnlockCount(heroId)
		local unlockLv = math.ceil(allUnlockCount / 5)
		local showUpgradeEffect = false

		if self._lastUnLockLvCache and self._lastUnLockLvCache ~= unlockLv then
			showUpgradeEffect = true
		end

		self._lastUnLockLvCache = unlockLv

		for _lv, cell in pairs(self._cellLvGroup) do
			local _isUnlcok = false

			if allUnlockCount > 0 then
				_isUnlcok = _lv == unlockLv
			end

			local playUpgradeAni = showUpgradeEffect and _lv == unlockLv

			cell.canvasGroup.alpha = playUpgradeAni and 0 or 1

			goutil.setActive(cell.goMarkUnLock.gameObject, _isUnlcok)
			goutil.setActive(cell.goMarkLock.gameObject, not _isUnlcok)

			if playUpgradeAni then
				cell.animation:Stop()
				cell.animation:Play("authority_main_panel_copy_level1_open")
			elseif _isUnlcok then
				cell.animation:Stop()
				cell.animation:Play("authority_main_panel_copy_level1_open")
				AnimationUtils.ResetToLastFrame(cell.animation)
				cell.animation:Stop()
			end
		end
	end
end

function M:_onCircleChange(e, param)
	self._showChangeTop = param > 105
	self._showChangeBottom = param <= 39

	self:_refreshChange()
end

function M:_refreshChange()
	local hasLockChange = false
	local changeStr = ""
	local maxPowerGroup = self._maxPowerGroupCount
	local maxNodeId = maxPowerGroup * 5

	for nodeId, cell in pairs(self._cellNodeGroup) do
		if maxNodeId < nodeId then
			break
		end

		local mo = CharacterAuthorityModel.instance:getHeroPowerNodeMO(self._heroData:getId(), cell.nodeId)

		if not mo then
			return
		end

		local co = mo:getConfig()
		local isChangeNode = not string.nilorempty(co.videoName)

		if not mo:getIsUnlock() and isChangeNode then
			hasLockChange = true
			changeStr = co.name
			self._changeNodeId = cell.nodeId

			break
		end
	end

	goutil.setActive(self._goChange, hasLockChange and self._showChangeTop)
	goutil.setActive(self._btnChangeBottom.gameObject, hasLockChange and self._showChangeBottom)

	self._textChange.text = changeStr
	self._textChangeBottom.text = changeStr
end

function M:_refreshByHeroChange()
	self:_setRightInfo()
end

function M:_onClickChange()
	if self._lastSelectNodeId == self._changeNodeId then
		return
	end

	local cell = self._cellNodeGroup[self._changeNodeId]

	self:_onNodeCellClick(cell.nodeLv, cell.nodeId, 0.25, false)
end

function M:_showCanvasTips(canvasGroup, show, duration, delayHide)
	duration = duration or 0
	delayHide = delayHide or 0

	local orgVal = show and 0 or 1
	local finalVal = show and 1 or 0

	canvasGroup:DOKill(false)

	canvasGroup.alpha = orgVal

	if duration == 0 then
		goutil.setActive(canvasGroup.gameObject, show)
	else
		goutil.setActive(canvasGroup.gameObject, true)
		canvasGroup:DOFade(finalVal, duration):SetAutoKill(true):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
			if show and delayHide > 0 then
				canvasGroup:DOFade(0, duration):SetAutoKill(true):SetEase(DG.Tweening.Ease.Linear):SetDelay(delayHide)
			end
		end, self)
	end
end

return M
