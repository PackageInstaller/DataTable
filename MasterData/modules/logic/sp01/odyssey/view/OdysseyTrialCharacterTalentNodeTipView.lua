-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyTrialCharacterTalentNodeTipView.lua

module("modules.logic.sp01.odyssey.view.OdysseyTrialCharacterTalentNodeTipView", package.seeall)

local OdysseyTrialCharacterTalentNodeTipView = class("OdysseyTrialCharacterTalentNodeTipView", CharacterSkillTalentNodeTipView)

function OdysseyTrialCharacterTalentNodeTipView:onInitView()
	OdysseyTrialCharacterTalentNodeTipView.super.onInitView(self)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyTrialCharacterTalentNodeTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onClickTalentTreeNode, self._onClickTalentTreeNode, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, self._closeTip, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, self._closeTip, self)
end

function OdysseyTrialCharacterTalentNodeTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.onClickTalentTreeNode, self._onClickTalentTreeNode, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeChange, self._closeTip, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.TrialTalentTreeReset, self._closeTip, self)
end

function OdysseyTrialCharacterTalentNodeTipView:_btnyesOnClick()
	if not self.skillTalentMo then
		return
	end

	if self.skillTalentMo:isNullTalentPonit(self.heroMo) then
		return
	end

	if self._nodeMo:isLight() then
		return
	end

	if self.isActTrialHero then
		OdysseyRpc.instance:sendOdysseyTalentCassandraTreeChoiceRequest(self._sub, self._level)
	end
end

function OdysseyTrialCharacterTalentNodeTipView:_btnnoOnClick()
	if not self.skillTalentMo then
		return
	end

	if not self._nodeMo:isLight() then
		return
	end

	if self.isActTrialHero then
		OdysseyRpc.instance:sendOdysseyTalentCassandraTreeCancelRequest(self._sub, self._level)
	end
end

function OdysseyTrialCharacterTalentNodeTipView:_onClickTalentTreeNode(sub, level)
	self:_openNodeTip(sub, level)
end

function OdysseyTrialCharacterTalentNodeTipView:onOpen()
	self.heroMo = self.viewParam

	local extraMo = self.heroMo.extraMo
	local trialHeroConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local trialHeroId = tonumber(trialHeroConstCo.value)

	self.isActTrialHero = self.heroMo.trialCo and self.heroMo.trialCo.id == trialHeroId
	self.skillTalentMo = extraMo and self.heroMo.trialCo and self.isActTrialHero and OdysseyTalentModel.instance:getTrialCassandraTreeInfo() or extraMo:getSkillTalentMo()
	self._isShowTip = false

	gohelper.setActive(self._gotip, false)
	gohelper.setActive(self._btnclose.gameObject, false)
end

function OdysseyTrialCharacterTalentNodeTipView:_openNodeTip(sub, level)
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

	if self._nodeMo:isLight() then
		self._txtnonum.text = "+" .. nodeCount
		self._txtlocknum.text = "+" .. nodeCount
	elseif self._nodeMo:isLock() then
		self._txtlocknum.text = "+" .. nodeCount
	else
		self._txtyesnum.text = "-" .. nodeCount
	end

	self._fieldDesc = MonoHelper.addNoUpdateLuaComOnceToGo(self._txtfield.gameObject, SkillDescComp)

	self._fieldDesc:updateInfo(self._txtfield, fieldActivateDesc, self.heroMo.heroId)

	local isAllLightTreeNode = self._treeMo:isAllLight()
	local lock = self._nodeMo:isLock()
	local light = self._nodeMo:isLight()
	local normal = self._nodeMo:isNormal()
	local treeCount = self.skillTalentMo:getExtraCount()
	local tipStr = ""
	local warningStr = ""
	local isNoEnoughPoint = nodeCount > self.skillTalentMo:getTalentpoint()

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

			local isLock = isAllLightTreeNode and treeCount == 2

			self._txtWarning.text = warningStr
			self._txtTips.text = tipStr

			local isShowTip = lock and not string.nilorempty(tipStr)
			local isShowWarning = not string.nilorempty(warningStr)
			local isField = not string.nilorempty(fieldActivateDesc)

			gohelper.setActive(self._gofieldbg.gameObject, self.isActTrialHero and (isShowWarning or isField))
			gohelper.setActive(self._golichang.gameObject, self.isActTrialHero and isField)
			gohelper.setActive(self._txtTips.gameObject, self.isActTrialHero and isShowTip)
			gohelper.setActive(self._txtWarning.gameObject, self.isActTrialHero and isShowWarning)
			gohelper.setActive(self._btnyes.gameObject, self.isActTrialHero and not isLock and normal)
			gohelper.setActive(self._btnno.gameObject, self.isActTrialHero and not isLock and light)
			gohelper.setActive(self._btnLocked.gameObject, self.isActTrialHero and (isLock or isShowTip))
			gohelper.setActive(self._goWarning.gameObject, self.isActTrialHero and not isAllLightTreeNode and isShowWarning)
			self:_activeTip(true)
		end
	end
end

return OdysseyTrialCharacterTalentNodeTipView
