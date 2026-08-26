-- chunkname: @modules/logic/tips/view/SkillTipView.lua

module("modules.logic.tips.view.SkillTipView", package.seeall)

local SkillTipView = class("SkillTipView", BaseView)

function SkillTipView:onInitView()
	self._gonewskilltip = gohelper.findChild(self.viewGO, "#go_newskilltip")
	self._goassassinbg = gohelper.findChild(self.viewGO, "#go_newskilltip/skillbgassassin")
	self._goBuffContainer = gohelper.findChild(self.viewGO, "#go_buffContainer")
	self._goBuffItem = gohelper.findChild(self.viewGO, "#go_buffContainer/#go_buffitem")
	self._btnupgradeShow = gohelper.findChildButtonWithAudio(self.viewGO, "#go_newskilltip/#btn_upgradeShow")
	self._goScrollSkill = gohelper.findChild(self.viewGO, "#scroll_skill")
	self._goContentSkill = gohelper.findChild(self.viewGO, "#scroll_skill/Viewport/Content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkillTipView:addEvents()
	return
end

function SkillTipView:removeEvents()
	return
end

function SkillTipView:_editableInitView()
	gohelper.setActive(self._goBuffContainer, false)
	gohelper.setActive(self._btnupgradeShow.gameObject, false)

	self._viewInitialized = true
end

function SkillTipView:showInfo(info, isCharacter, entityId)
	if not self._viewInitialized then
		return
	end

	self.entityMo = FightDataHelper.entityMgr:getById(entityId)
	self.monsterName = FightConfig.instance:getEntityName(entityId)
	self.entitySkillIndex = info.skillIndex

	if string.nilorempty(self.monsterName) then
		logError("SkillTipView monsterName 为 nil, entityId : " .. tostring(entityId))

		self.monsterName = ""
	end

	self._upgradeSelectShow = false

	self:initInfo(info, isCharacter, entityId)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)
end

function SkillTipView:hideInfo()
	if not self._viewInitialized then
		return
	end

	gohelper.setActive(self._goScrollSkill, false)
	gohelper.setActive(self._gonewskilltip, false)

	if self._normalSkillLevelComp then
		self._normalSkillLevelComp.upgraded = false
		self._normalSkillLevelComp._upgradeSelectShow = false
	end

	self._curSkillLevel = nil
end

function SkillTipView:_getLevelComp(index)
	local comp = self._skillTiplLevelComps[index]

	if not comp then
		local go = gohelper.clone(self._gonewskilltip, self._goContentSkill)

		comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, SkillTipLevelComp, self)
		self._skillTiplLevelComps[index] = comp
	end

	return comp
end

function SkillTipView:_refreshLevelComps()
	return
end

function SkillTipView:initInfo(info, isCharacter, entityId)
	self._skillTiplLevelComps = self._skillTiplLevelComps or self:getUserDataTb_()

	if not self.viewParam then
		local param = {}

		param.viewName = self.viewName
		param.entityId = entityId
		param.heroId = param and param.heroId
		param.skillIndex = param and param.skillIndex

		if self.viewName == ViewName.FightFocusView then
			param.monsterName = self.monsterName
		end

		local skillIdList = param.skillIdList

		if info then
			skillIdList = info.skillIdList
			param.super = info.super
			param.isCharacter = isCharacter
			param.entitySkillIndex = info.skillIndex
		end

		local skillChoice = SkillConfig.instance:getFightCardChoice(skillIdList)

		if skillChoice then
			do
				local compCount = #skillChoice

				for i = 1, compCount do
					param.skillIdList = skillChoice[i]

					local comp = self:_getLevelComp(i)

					comp:initInfo(param)
				end

				if self.viewName == ViewName.FightFocusView then
					if self.viewGO.transform.parent then
						if self.viewGO.transform.parent and self.viewGO.transform.parent.x ~= 0 then
							self._goScrollSkill.transform.offsetMin = Vector2(-self.viewGO.transform.parent.x, self.viewGO.transform.parent.y)
						end
					end
				end

				for i = compCount + 1, #self._skillTiplLevelComps do
					local comp = self._skillTiplLevelComps[i]

					comp:hideInfo()
				end

				gohelper.setActive(self._goScrollSkill, true)
				gohelper.setActive(self._gonewskilltip, false)
			end
		else
			self._normalSkillLevelComp = self._normalSkillLevelComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._gonewskilltip, SkillTipLevelComp, self)
			param.skillIdList = skillIdList

			self._normalSkillLevelComp:initInfo(param)
			self:_setSkillTipPos()
			gohelper.setActive(self._goScrollSkill, false)
			gohelper.setActive(self._gonewskilltip, true)
		end

		gohelper.setActive(self._goassassinbg, self.viewParam and self.viewParam.showAssassinBg)
		self:_setViewAnchorPos()
	end
end

function SkillTipView:_setViewAnchorPos()
	local viewTrans = self.viewGO.transform

	if self.viewParam then
		if self.viewParam then
			recthelper.setAnchorX(viewTrans, self.viewParam)
		end

		if self.viewParam then
			local anchorY = self.viewParam.anchorY

			if anchorY then
				recthelper.setAnchorY(viewTrans, anchorY)
			end
		end
	end
end

function SkillTipView:_setSkillTipPos()
	local trans = self._goBuffItem.transform

	if self.viewName == ViewName.FightFocusView then
		if ViewMgr.instance:isOpen(ViewName.FightFocusView) then
			transformhelper.setLocalPosXY(self._gonewskilltip.transform, 270, -24.3)
			recthelper.setAnchorX(trans, -38)
		else
			transformhelper.setLocalPosXY(self._gonewskilltip.transform, 185.12, 49.85)
			recthelper.setAnchorX(trans, -120)
		end
	else
		transformhelper.setLocalPosXY(self._gonewskilltip.transform, 0.69, -0.54)
		recthelper.setAnchorX(trans, -304)
	end
end

function SkillTipView:onClickSkillItem(level)
	if self._curSkillLevel and level == self._curSkillLevel then
		return
	end

	self._curSkillLevel = level

	if self._normalSkillLevelComp then
		self._normalSkillLevelComp:_refreshSkill(level)
	end

	if self._skillTiplLevelComps and #self._skillTiplLevelComps > 0 then
		for _, comp in ipairs(self._skillTiplLevelComps) do
			comp:_refreshSkill(level)
		end
	end
end

function SkillTipView:onUpdateParam()
	if self.viewName ~= ViewName.FightFocusView then
		self:initInfo()
	end
end

function SkillTipView:onOpen()
	if self.viewName ~= ViewName.FightFocusView then
		self:initInfo()
	else
		self:hideInfo()
	end
end

function SkillTipView:onClose()
	return
end

function SkillTipView:onDestroyView()
	if self._skillTiplLevelComps then
		for _, comp in ipairs(self._skillTiplLevelComps) do
			comp:onDestroyView()
		end
	end

	if self._normalSkillLevelComp then
		self._normalSkillLevelComp:onDestroyView()
	end
end

return SkillTipView
