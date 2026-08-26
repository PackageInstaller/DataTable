-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinQuestDetailView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinQuestDetailView", package.seeall)

local AssassinQuestDetailView = class("AssassinQuestDetailView", BaseView)

function AssassinQuestDetailView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._goquestItem = gohelper.findChild(self.viewGO, "root/#go_questItem")
	self._imagequesItem = gohelper.findChildImage(self.viewGO, "root/#go_questItem/image_icon")
	self._gotips = gohelper.findChild(self.viewGO, "root/#go_tips")
	self._imagequesttype = gohelper.findChildImage(self.viewGO, "root/#go_tips/#go_title/#img_icon")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/#go_tips/#go_title/#txt_title")
	self._gopic = gohelper.findChild(self.viewGO, "root/#go_tips/#go_pic")
	self._simageinfo = gohelper.findChildSingleImage(self.viewGO, "root/#go_tips/#go_pic/#simage_info")
	self._btninfo = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_tips/#go_pic/#btn_info", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/#go_tips/#go_desc/#scroll_desc/Viewport/Content/#txt_desc")
	self._txtunlock = gohelper.findChildText(self.viewGO, "root/#go_tips/#go_desc/#scroll_desc/Viewport/Content/#txt_unlock")
	self._txtrecommend = gohelper.findChildText(self.viewGO, "root/#go_tips/#go_desc/#scroll_desc/Viewport/Content/#txt_recommend")
	self._goreward = gohelper.findChild(self.viewGO, "root/#go_tips/#go_desc/#go_reward")
	self._txtrewardnum = gohelper.findChildText(self.viewGO, "root/#go_tips/#go_desc/#go_reward/#txt_rewardNum")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_tips/#btn_start", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._txtstart = gohelper.findChildText(self.viewGO, "root/#go_tips/#btn_start/txt_start")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinQuestDetailView:addEvents()
	self._btninfo:AddClickListener(self._btninfoOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function AssassinQuestDetailView:removeEvents()
	self._btninfo:RemoveClickListener()
	self._btnstart:RemoveClickListener()
end

function AssassinQuestDetailView:_btninfoOnClick()
	AssassinController.instance:openAssassinStealthGameOverView(self._questId)
end

function AssassinQuestDetailView:_btnstartOnClick()
	AssassinController.instance:startQuest(self._questId)
	self:closeThis()
end

function AssassinQuestDetailView:_editableInitView()
	self._transRoot = self._goroot.transform
	self._transQuestItem = self._goquestItem.transform
	self._transTips = self._gotips.transform

	local tipWidth = recthelper.getWidth(self._transTips)

	self._space = recthelper.getAnchorX(self._transTips)
	self._tipNeedWidth = self._space + tipWidth / 2
end

function AssassinQuestDetailView:onUpdateParam()
	self._questId = self.viewParam.questId
end

function AssassinQuestDetailView:onOpen()
	self:onUpdateParam()
	self:setInfo()
	self:setQuestItem()
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_taskchoose)
end

function AssassinQuestDetailView:setInfo()
	local questType = AssassinConfig.instance:getQuestType(self._questId)

	AssassinHelper.setQuestTypeIcon(questType, self._imagequesttype)

	self._txtstart.text = luaLang((questType == AssassinEnum.QuestType.Dialog or nil) and "p_assassinquestdetailview_txt_start2")
	self._txttitle.text = AssassinConfig.instance:getQuestName(self._questId)
	self._txtdesc.text = AssassinConfig.instance:getQuestDesc(self._questId)

	local pic = AssassinConfig.instance:getQuestPicture(self._questId)

	if string.nilorempty(pic) then
		gohelper.setActive(self._gopic, false)
	else
		local path = ResUrl.getSp01AssassinSingleBg("map/" .. pic)

		self._simageinfo:LoadImage(path)
		gohelper.setActive(self._gopic, true)
	end

	local rewardCount = AssassinConfig.instance:getQuestRewardCount(self._questId)

	self._txtrewardnum.text = rewardCount

	gohelper.setActive(self._goreward, rewardCount and rewardCount > 0)

	local heroIdList = AssassinConfig.instance:getQuestRecommendHeroList(self._questId)

	if heroIdList then
		local targetDesc
		local connchar = luaLang("room_levelup_init_and1")

		for _, heroId in ipairs(heroIdList) do
			local heroCfg = AssassinConfig.instance:getHeroCfgByAssassinHeroId(heroId)

			if heroCfg then
				targetDesc = targetDesc and targetDesc .. connchar .. heroCfg.name or heroCfg.name
			end
		end

		local txt = luaLang("assassin_stealth_game_recommend_hero")

		self._txtrecommend.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, targetDesc)
	else
		gohelper.setActive(self._txtrecommend, false)
	end

	local unlockHeroId = AssassinConfig.instance:getUnlockHeroId(self._questId)

	if unlockHeroId then
		local heroCfg = AssassinConfig.instance:getHeroCfgByAssassinHeroId(unlockHeroId)

		if heroCfg then
			if not heroCfg.name then
				local name = ""
				local txt = luaLang("assassin_stealth_game_unlock_hero")

				self._txtunlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, name)
			end
		end
	else
		gohelper.setActive(self._txtunlock, false)
	end

	UnityEngine.Canvas.ForceUpdateCanvases()
end

function AssassinQuestDetailView:setQuestItem()
	local questType = AssassinConfig.instance:getQuestType(self._questId)

	AssassinHelper.setQuestTypeIcon(questType, self._imagequesItem)

	local posX, posY = 0, 0

	if self.viewParam then
		local worldPos = self.viewParam.worldPos

		if worldPos then
			local pos = self._transRoot:InverseTransformPoint(worldPos)

			posX = pos.x
			posY = pos.y
		end

		recthelper.setAnchor(self._transQuestItem, posX, posY)

		local viewW, viewH = GameUtil.getViewSize()
		local halfViewW = viewW / 2
		local leftRemainWidth = halfViewW - posX
		local showInRight = leftRemainWidth >= self._tipNeedWidth

		if showInRight then
			if not (posX + self._space) then
				local tipsX = posX - self._space
				local halfViewH = viewH / 2
				local tipHeight = recthelper.getHeight(self._transTips)
				local maxY = halfViewH - tipHeight / 2
				local tipsY = Mathf.Clamp(posY, -maxY, maxY)

				recthelper.setAnchor(self._transTips, tipsX, tipsY)
			end
		end
	end
end

function AssassinQuestDetailView:onClose()
	return
end

function AssassinQuestDetailView:onDestroyView()
	self._simageinfo:UnLoadImage()
end

return AssassinQuestDetailView
