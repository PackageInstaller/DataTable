-- chunkname: @modules/logic/character/view/extra/CharacterSkillTalentNodeTipView.lua

module("modules.logic.character.view.extra.CharacterSkillTalentNodeTipView", package.seeall)

local CharacterSkillTalentNodeTipView = class("CharacterSkillTalentNodeTipView", BaseView)

function CharacterSkillTalentNodeTipView:onInitView()
	self._gotip = gohelper.findChild(self.viewGO, "#go_tip")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tipclose")
	self._imageTag = gohelper.findChildImage(self.viewGO, "#go_tip/#image_Tag")
	self._golichang = gohelper.findChild(self.viewGO, "#go_tip/Scroll View/Viewport/Content/#go_lichang")
	self._goWarning = gohelper.findChild(self.viewGO, "#go_tip/Scroll View/Viewport/Content/#go_lichang/#go_Warning")
	self._txtWarning = gohelper.findChildText(self.viewGO, "#go_tip/Scroll View/Viewport/Content/#go_lichang/#go_Warning/txt_Warning")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tip/#btn_yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tip/#btn_no")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tip/#btn_Locked")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_tip/#btn_Locked/txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkillTalentNodeTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onClickTalentTreeNode, self._onClickTalentTreeNode, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, self._closeTip, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, self._closeTip, self)
end

function CharacterSkillTalentNodeTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onClickTalentTreeNode, self._onClickTalentTreeNode, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onChoiceHero3124TalentTreeReply, self._closeTip, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onCancelHero3124TalentTreeReply, self._closeTip, self)
end

function CharacterSkillTalentNodeTipView:_btncloseOnClick()
	self:_closeTip()
end

function CharacterSkillTalentNodeTipView:_btnyesOnClick()
	if not self.heroMo:isOwnHero() then
		return
	end

	if not self.skillTalentMo then
		return
	end

	if self.skillTalentMo:isNullTalentPonit(self.heroMo) then
		return
	end

	if self._nodeMo:isLight() then
		return
	end

	HeroRpc.instance:setChoiceHero3124TalentTreeRequest(self.heroMo.heroId, self._sub, self._level)
end

function CharacterSkillTalentNodeTipView:_btnnoOnClick()
	if not self.heroMo:isOwnHero() then
		return
	end

	if not self.skillTalentMo then
		return
	end

	if not self._nodeMo:isLight() then
		return
	end

	HeroRpc.instance:setCancelHero3124TalentTreeRequest(self.heroMo.heroId, self._sub, self._level)
end

function CharacterSkillTalentNodeTipView:_onClickTalentTreeNode(sub, level)
	self:_openNodeTip(sub, level)
end

function CharacterSkillTalentNodeTipView:_closeTip()
	self:_activeTip(false)
	CharacterController.instance:dispatchEvent(CharacterEvent.onCloseSkillTalentTipView, self._sub, self._level)
end

function CharacterSkillTalentNodeTipView:_editableInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "#go_tip/txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_tip/Scroll View/Viewport/Content/txt_desc")
	self._txtyesnum = gohelper.findChildText(self.viewGO, "#go_tip/#btn_yes/txt_num")
	self._txtnonum = gohelper.findChildText(self.viewGO, "#go_tip/#btn_no/txt_num")
	self._txtlocknum = gohelper.findChildText(self.viewGO, "#go_tip/#btn_Locked/txt_num")
	self._txtlock = gohelper.findChildText(self.viewGO, "#go_tip/#btn_Locked/no")
	self._txtfield = gohelper.findChildText(self._golichang, "txt_desc")
	self._gofieldbg = gohelper.findChild(self._golichang, "image_LightBG")
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self._gotip.gameObject)
end

function CharacterSkillTalentNodeTipView:onOpen()
	self.heroMo = self.viewParam

	local extraMo = self.heroMo.extraMo

	self.skillTalentMo = extraMo:getSkillTalentMo()
	self._isShowTip = false

	gohelper.setActive(self._gotip, false)
	gohelper.setActive(self._btnclose.gameObject, false)
end

local addCode = "+"
local reduceCode = "-"

function CharacterSkillTalentNodeTipView:_openNodeTip(sub, level)
	local exSkillLevel = self.heroMo.exSkillLevel

	recthelper.setAnchorX(self._gotip.transform, sub == 2 and 500 or 0)

	local mo = self.skillTalentMo:getTreeNodeMoBySubLevel(sub, level)

	self._sub = sub
	self._level = level
	self._txtname.text = mo.co.name

	local desc = mo:getDesc(exSkillLevel)
	local fieldActivateDesc = mo:getFieldActivateDesc(exSkillLevel)

	self._skillDesc = MonoHelper.addNoUpdateLuaComOnceToGo(self._txtdesc.gameObject, SkillDescComp)

	self._skillDesc:updateInfo(self._txtdesc, desc, self.heroMo.heroId)
	UISpriteSetMgr.instance:setUiCharacterSprite(self._imageTag, self.skillTalentMo:getSmallSubIconPath(sub))

	self._treeMo = self.skillTalentMo:getTreeMosBySub(sub)
	self._nodeMo = self.skillTalentMo:getTreeNodeMoBySubLevel(sub, level)

	local nodeList = self.skillTalentMo:getLightOrCancelNodes(sub, level)
	local nodeCount = #nodeList
	local isNoEnoughPoint = nodeCount > self.skillTalentMo:getTalentpoint()

	self._fieldDesc = MonoHelper.addNoUpdateLuaComOnceToGo(self._txtfield.gameObject, SkillDescComp)

	self._fieldDesc:updateInfo(self._txtfield, fieldActivateDesc, self.heroMo.heroId)

	local isAllLightTreeNode = self._treeMo:isAllLight()
	local lock = self._nodeMo:isLock()
	local light = self._nodeMo:isLight()
	local normal = self._nodeMo:isNormal()
	local treeCount = self.skillTalentMo:getExtraCount()
	local tipStr = ""
	local warningStr = ""

	if isNoEnoughPoint then
		tipStr = luaLang("characterskilltalent_warning_3")
	end

	local mo = self.skillTalentMo:getMainFieldMo()

	if mo then
		if mo.co then
			do
				local _sub = mo.co.sub

				if _sub and _sub ~= sub then
					if not isNoEnoughPoint then
						tipStr = luaLang("characterskilltalent_warning_2")
					end

					local warnFormat = luaLang("characterskilltalent_warning_1")
					local curLangSubName = luaLang("characterskilltalent_sub_" .. _sub)
					local subName = luaLang("characterskilltalent_sub_" .. sub)

					warningStr = GameUtil.getSubPlaceholderLuaLangTwoParam(warnFormat, curLangSubName, subName)
				end
			end

			local isLock = isAllLightTreeNode and treeCount > 1
			local isShowTip = lock and not string.nilorempty(tipStr)
			local isShowWarning = not string.nilorempty(warningStr)
			local isField = not string.nilorempty(fieldActivateDesc)
			local isOwnHero = self.heroMo:isOwnHero()

			gohelper.setActive(self._gofieldbg.gameObject, isOwnHero and (isShowWarning or isField))
			gohelper.setActive(self._golichang.gameObject, isOwnHero and isField)
			gohelper.setActive(self._txtTips.gameObject, isOwnHero and isShowTip)
			gohelper.setActive(self._txtWarning.gameObject, isOwnHero and isShowWarning)
			gohelper.setActive(self._btnyes.gameObject, isOwnHero and not isLock and normal)
			gohelper.setActive(self._btnno.gameObject, isOwnHero and not isLock and light)
			gohelper.setActive(self._btnLocked.gameObject, isOwnHero and (isLock or isShowTip))
			gohelper.setActive(self._goWarning.gameObject, isOwnHero and not isAllLightTreeNode and isShowWarning)
			self:_activeTip(true)

			if self._nodeMo:isLight() then
				self._txtnonum.text = addCode .. nodeCount
				self._txtlocknum.text = addCode .. nodeCount
				self._txtlock.text = luaLang("characterskilltalent_cancel_light")
			elseif self._nodeMo:isLock() then
				self._txtlocknum.text = reduceCode .. nodeCount
				self._txtlock.text = luaLang("characterskilltalent_sure_light")
			else
				self._txtyesnum.text = reduceCode .. nodeCount
			end

			self._txtWarning.text = warningStr
			self._txtTips.text = tipStr
		end
	end
end

function CharacterSkillTalentNodeTipView:_activeTip(active)
	if active then
		self._isShowTip = true

		gohelper.setActive(self._gotip, true)
		gohelper.setActive(self._btnclose.gameObject, true)
		self._animPlayer:Play(CharacterExtraEnum.SkillTreeAnimName.OpenTip, self._playAnimCallback, self)
		AudioMgr.instance:trigger(AudioEnum2_9.Character.ui_role_kashan_zhuangbei)
	elseif self._isShowTip then
		self._isShowTip = false

		self._animPlayer:Play(CharacterExtraEnum.SkillTreeAnimName.CloseTip, self._playAnimCallback, self)
	end
end

function CharacterSkillTalentNodeTipView:_playAnimCallback()
	if not self._isShowTip then
		gohelper.setActive(self._gotip, false)
		gohelper.setActive(self._btnclose.gameObject, false)
	end
end

function CharacterSkillTalentNodeTipView:onClose()
	return
end

function CharacterSkillTalentNodeTipView:onDestroyView()
	return
end

return CharacterSkillTalentNodeTipView
