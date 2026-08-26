-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191EnhanceView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191EnhanceView", package.seeall)

local Act191EnhanceView = class("Act191EnhanceView", BaseView)

function Act191EnhanceView:onInitView()
	self._btnclosetip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closetip")
	self._goscrolltips = gohelper.findChild(self.viewGO, "#go_scrolltips")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_scrolltips/viewport/content/go_title/#txt_title")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_scrolltips/viewport/content/go_title/#image_icon")
	self._goskillitem = gohelper.findChild(self.viewGO, "#go_scrolltips/viewport/content/#go_skillitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191EnhanceView:addEvents()
	self._btnclosetip:AddClickListener(self._btnclosetipOnClick, self)
end

function Act191EnhanceView:removeEvents()
	self._btnclosetip:RemoveClickListener()
end

function Act191EnhanceView:_btnclosetipOnClick()
	self:closeThis()
end

function Act191EnhanceView:_editableInitView()
	self.actId = Activity191Model.instance:getCurActId()
	self._goContent = gohelper.findChild(self.viewGO, "#go_scrolltips/viewport/content")
end

function Act191EnhanceView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	if not self.viewParam then
		return
	end

	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	self.enhanceIds = gameInfo.warehouseInfo.enhanceId

	for _, id in ipairs(self.enhanceIds) do
		local go = gohelper.cloneInPlace(self._goskillitem)
		local enhanceCo = Activity191Config.instance:getEnhanceCo(self.actId, id)

		if enhanceCo then
			local txtSkill = gohelper.findChildText(go, "txt_skill")
			local buffIcon = gohelper.findChildSingleImage(go, "skillicon")

			txtSkill.text = enhanceCo.desc

			buffIcon:LoadImage(ResUrl.getAct174BuffIcon(enhanceCo.icon))

			local desc = SkillHelper.addLink(enhanceCo.desc)
			local effectId = string.splitToNumber(enhanceCo.effects, "|")[1]
			local effectCo = lua_activity191_effect.configDict[effectId]

			if effectCo then
				if effectCo.type == Activity191Enum.EffectType.EnhanceHero then
					txtSkill.text = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.EnhanceDestiny, effectCo.typeParam)

					SkillHelper.addHyperLinkClick(txtSkill, Activity191Helper.clickHyperLinkDestiny)
				elseif effectCo.type == Activity191Enum.EffectType.Item then
					txtSkill.text = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.EnhanceItem, effectCo.typeParam .. "#")

					SkillHelper.addHyperLinkClick(txtSkill, Activity191Helper.clickHyperLinkItem)
				elseif effectCo.type == Activity191Enum.EffectType.Hero then
					txtSkill.text = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.Hero, effectCo.typeParam)

					SkillHelper.addHyperLinkClick(txtSkill, Activity191Helper.clickHyperLinkRole)
				else
					txtSkill.text = desc
				end
			else
				txtSkill.text = desc
			end
		end
	end

	gohelper.setActive(self._goskillitem, false)
	TaskDispatcher.runDelay(self.refreshAnchor, self, 0.01)
end

function Act191EnhanceView:refreshAnchor()
	local rectTrs = self._goscrolltips.transform
	local heightA = recthelper.getHeight(rectTrs)
	local heightB = recthelper.getHeight(self._goContent.transform)
	local height = heightA < heightB and heightA or heightB
	local pos = self.viewParam.pos

	if self.viewParam.isDown then
		recthelper.setAnchor(rectTrs, pos.x, pos.y + height)
	else
		recthelper.setAnchor(rectTrs, pos.x, pos.y)
	end
end

function Act191EnhanceView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshAnchor, self)
end

return Act191EnhanceView
