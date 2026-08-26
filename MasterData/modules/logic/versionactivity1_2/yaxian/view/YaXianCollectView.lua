-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/YaXianCollectView.lua

module("modules.logic.versionactivity1_2.yaxian.view.YaXianCollectView", package.seeall)

local YaXianCollectView = class("YaXianCollectView", BaseView)

function YaXianCollectView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btncloseView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeview")
	self._simageblackbg = gohelper.findChildSingleImage(self.viewGO, "#simage_blackbg")
	self._gonodeitem = gohelper.findChild(self.viewGO, "#simage_blackbg/#scroll_reward/Viewport/#go_content/#go_nodeitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#simage_blackbg/#btn_close")
	self._txtnum = gohelper.findChildText(self.viewGO, "#simage_blackbg/bottom/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianCollectView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncloseView:AddClickListener(self._btncloseOnClick, self)
end

function YaXianCollectView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btncloseView:RemoveClickListener()
end

YaXianCollectView.IndexColor = {
	Had = GameUtil.parseColor("#EDFFDD"),
	NotHad = GameUtil.parseColor("#86907E")
}
YaXianCollectView.DescColor = {
	Had = GameUtil.parseColor("#A3AB9C"),
	NotHad = GameUtil.parseColor("#7C8376")
}

function YaXianCollectView:_btncloseviewOnClick()
	self:closeThis()
end

function YaXianCollectView:_btnrepalyOnClick()
	return
end

function YaXianCollectView:_btncloseOnClick()
	self:closeThis()
end

function YaXianCollectView:btnReplayClick(toothItem)
	local hadTooth = YaXianModel.instance:hadTooth(toothItem.toothConfig.id)

	if hadTooth then
		StoryController.instance:playStory(toothItem.toothConfig.story)
	end
end

function YaXianCollectView:_editableInitView()
	self._goScroll = gohelper.findChild(self.viewGO, "#simage_blackbg/#scroll_reward")

	self._simagebg:LoadImage(ResUrl.getYaXianImage("img_deco_zhizhuwang"))
	self._simageblackbg:LoadImage(ResUrl.getYaXianImage("img_tanchuang_bg"))

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goScroll)

	self._drag:AddDragBeginListener(self._onDragBeginHandler, self)
	gohelper.setActive(self._gonodeitem, false)

	self.toothItemList = {}
end

function YaXianCollectView:_onDragBeginHandler()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_swath_open)
end

function YaXianCollectView:onUpdateParam()
	return
end

function YaXianCollectView:onOpen()
	self.totalToothCount = #lua_activity115_tooth.configList
	self._txtnum.text = YaXianModel.instance:getHadToothCount() - 1 .. "/" .. self.totalToothCount - 1

	self:refreshUI()
end

function YaXianCollectView:refreshUI()
	for index, toothConfig in ipairs(lua_activity115_tooth.configList) do
		local toothItem = self:createToothItem()

		toothItem.toothConfig = toothConfig

		if toothConfig.id == 0 then
			self.zeroToothItem = toothItem
		end

		gohelper.setActive(toothItem.go, true)
		gohelper.setActive(toothItem.goRightLine, self.totalToothCount ~= index)

		local hadTooth = YaXianModel.instance:hadTooth(toothConfig.id)

		gohelper.setActive(toothItem.goTooth, hadTooth)
		gohelper.setActive(toothItem.goNone, not hadTooth)

		toothItem.txtIndex.text = string.format("%02d", toothConfig.id)

		if hadTooth then
			toothItem.txtIndex.color = YaXianCollectView.IndexColor.Had or YaXianCollectView.IndexColor.NotHad
		end

		if hadTooth then
			toothItem.txtDesc.color = YaXianCollectView.DescColor.Had or YaXianCollectView.DescColor.NotHad
		end

		if hadTooth then
			toothItem.txtDesc.text = toothConfig.desc
			toothItem.txtName.text = toothConfig.name

			self:loadToothIcon(toothItem)

			local unlockSkillId = YaXianConfig.instance:getToothUnlockSkill(toothConfig.id)

			gohelper.setActive(toothItem.goUnLockSkill, unlockSkillId)

			if unlockSkillId then
				toothItem.txtUnLockSkill.text = luaLang("versionactivity_1_2_yaxian_unlock_skill_" .. unlockSkillId)
			end

			local heroTemplate = YaXianConfig.instance:getToothUnlockHeroTemplate(toothConfig.id)
			local templateCo = lua_hero_trial.configDict[YaXianEnum.HeroTrialId][heroTemplate]

			if templateCo then
				local showLevel = HeroConfig.instance:getCommonLevelDisplay(templateCo.level or 0)

				toothItem.txtUp.text = string.format(luaLang("versionactivity_1_2_yaxian_up_to_level"), showLevel)
			end
		else
			toothItem.txtDesc.text = luaLang("versionactivity_1_2_yaxian_not_found_tooth")
		end
	end
end

function YaXianCollectView:loadToothIcon(toothItem)
	local toothConfig = toothItem.toothConfig

	if toothConfig.id ~= 0 then
		toothItem.toothIcon:LoadImage(ResUrl.getYaXianImage(toothConfig.icon))

		return
	end

	toothItem.toothIcon:LoadImage(ResUrl.getYaXianImage(toothConfig.icon), self.loadImageDone, self)

	local iconGo = toothItem.toothIcon.gameObject
	local rectTr = iconGo.transform

	rectTr.anchorMin = RectTransformDefine.Anchor.CenterMiddle
	rectTr.anchorMax = RectTransformDefine.Anchor.CenterMiddle

	recthelper.setAnchor(rectTr, 0, 0)

	local parentImage = rectTr.parent:GetComponent(typeof(UnityEngine.UI.Image))

	parentImage.enabled = false
end

function YaXianCollectView:loadImageDone()
	if self.zeroToothItem then
		local image = self.zeroToothItem.toothIcon.gameObject:GetComponent(typeof(UnityEngine.UI.Image))

		image:SetNativeSize()
	end
end

function YaXianCollectView:createToothItem()
	local toothItem = self:getUserDataTb_()

	toothItem.go = gohelper.cloneInPlace(self._gonodeitem)
	toothItem.goTooth = gohelper.findChild(toothItem.go, "go_tooth")
	toothItem.goNone = gohelper.findChild(toothItem.go, "go_none")
	toothItem.txtIndex = gohelper.findChildText(toothItem.go, "txt_index")
	toothItem.txtDesc = gohelper.findChildText(toothItem.go, "#scroll_desc/Viewport/Content/txt_desc")
	toothItem.goRightLine = gohelper.findChild(toothItem.go, "line")
	toothItem._scrolldesc = gohelper.findChild(toothItem.go, "#scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	toothItem.toothIcon = gohelper.findChildSingleImage(toothItem.go, "go_tooth/icon_bg/tooth_icon")
	toothItem.txtName = gohelper.findChildText(toothItem.go, "go_tooth/middle/txt_name")
	toothItem.goUnLockSkill = gohelper.findChild(toothItem.go, "go_tooth/middle/go_unlockskill")
	toothItem.txtUnLockSkill = gohelper.findChildText(toothItem.go, "go_tooth/middle/go_unlockskill/txt_unlockskill")
	toothItem.txtUp = gohelper.findChildText(toothItem.go, "go_tooth/middle/txt_up")
	toothItem.btnReplay = gohelper.findChildButtonWithAudio(toothItem.go, "go_tooth/bottom/btn_replay")

	toothItem.btnReplay:AddClickListener(self.btnReplayClick, self, toothItem)

	toothItem._scrolldesc.parentGameObject = self._goScroll

	table.insert(self.toothItemList, toothItem)

	return toothItem
end

function YaXianCollectView:onClose()
	return
end

function YaXianCollectView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageblackbg:UnLoadImage()
	self._drag:RemoveDragBeginListener()

	self._drag = nil

	for _, toothItem in ipairs(self.toothItemList) do
		toothItem.btnReplay:RemoveClickListener()
		toothItem.toothIcon:UnLoadImage()
	end
end

return YaXianCollectView
