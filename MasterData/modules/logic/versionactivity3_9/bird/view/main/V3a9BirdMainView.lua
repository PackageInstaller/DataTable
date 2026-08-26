-- chunkname: @modules/logic/versionactivity3_9/bird/view/main/V3a9BirdMainView.lua

module("modules.logic.versionactivity3_9.bird.view.main.V3a9BirdMainView", package.seeall)

local V3a9BirdMainView = class("V3a9BirdMainView", BaseView)

function V3a9BirdMainView:onInitView()
	self._scrollsection = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_section")
	self._btngo = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn_go")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "root/middle/bg_grade/grade_1/#txt_num")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "root/middle/bg_grade/grade_2/#txt_num")
	self._txtplayername = gohelper.findChildText(self.viewGO, "root/middle/bg_grade/txt_playername")
	self._txtbroadcast = gohelper.findChildText(self.viewGO, "root/announce/bg_desc/mask/txt_desc")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9BirdMainView:addEvents()
	self._btngo:AddClickListener(self._btngoOnClick, self)
	self.addEventCb(self, V3a9BirdController.instance, V3a9BirdEvent.CloseFinishLoadingView, self._closeFinishLoadingView, self)
end

function V3a9BirdMainView:removeEvents()
	self._btngo:RemoveClickListener()
	self.removeEventCb(self, V3a9BirdController.instance, V3a9BirdEvent.CloseFinishLoadingView, self._closeFinishLoadingView, self)
end

function V3a9BirdMainView:_btngoOnClick()
	self._animPlayer:Play("switchclose", self._openLoading, self)
end

function V3a9BirdMainView:_closeFinishLoadingView()
	self:closeThis()
end

function V3a9BirdMainView:_openLoading()
	ViewMgr.instance:openView(ViewName.V3a9BirdLoadingView, self.viewParam)
end

function V3a9BirdMainView:_btnClickLevelOnClick(index)
	local item = self._levelItems[index]

	if not item then
		return
	end

	local episodeId = item.levelMo:getEpisodeId()

	if episodeId == self._selectlevelMo:getEpisodeId() then
		return
	end

	self:_refreshSelectLevel(episodeId)
end

function V3a9BirdMainView:_editableInitView()
	self._levelItems = self:getUserDataTb_()
	self.goLevelItem = gohelper.findChild(self.viewGO, "root/#scroll_section/viewport/content/go_sectionitem")
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function V3a9BirdMainView:onUpdateParam()
	return
end

function V3a9BirdMainView:onOpen()
	if self.viewParam then
		self._actId = self.viewParam.actId or V3a9BirdModel.instance:getActId()
	end

	if self.viewParam then
		local episodeId = self.viewParam.episodeId

		self._episodeId = episodeId

		local levelMos = V3a9BirdModel.instance:getLevelMos()
		local levelList = {}

		if levelMos then
			for _, mo in pairs(levelMos) do
				table.insert(levelList, mo)
			end

			table.sort(levelList, function(a, b)
				return a:getEpisodeId() < b:getEpisodeId()
			end)
		end

		for i, mo in ipairs(levelList) do
			local levelItem = self:_getLevelItem(i)

			levelItem.levelMo = mo

			gohelper.setActive(levelItem.goselect, i == self._selectEpisodeId)

			local starCount = mo:getStarCount()

			for j, starItem in ipairs(levelItem.starItems) do
				gohelper.setActive(starItem.goLight, j <= starCount)
			end

			if episodeId then
				if episodeId == mo:getEpisodeId() then
					self._selectlevelMo = mo
				end
			elseif mo:isUnlock() then
				self._selectlevelMo = mo
			end
		end

		self._selectlevelMo = self._selectlevelMo or levelList[1]

		for i = 1, #self._levelItems do
			gohelper.setActive(self._levelItems[i].go, i <= #levelList)
		end

		self:_refreshPlayerInfo()
		self:_setBroadcastText()

		local aniName = self.viewParam.isReturn and "switchopen" or "open"

		self._animPlayer:Play(aniName, nil, self)

		if not self.viewParam.isReturn then
			AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_langchao_tv_unfold)
		end
	end
end

function V3a9BirdMainView:exitGame()
	self._animPlayer:Play("close", self.closeThis, self)
	AudioMgr.instance:trigger(AudioEnum3_9.Bird.play_ui_langchao_tv_close)
end

function V3a9BirdMainView:_getLevelItem(index)
	local item = self._levelItems[index]

	if not item then
		item = self:getUserDataTb_()

		if index == 1 then
			item.go = self.goLevelItem or gohelper.cloneInPlace(self.goLevelItem)
		end

		item.gounlock = gohelper.findChild(item.go, "unlock")
		item.txtunlock = gohelper.findChildText(item.gounlock, "#txt_index")
		item.goselect = gohelper.findChild(item.gounlock, "#go_select")
		item.golock = gohelper.findChild(item.go, "locked")
		item.txtlock = gohelper.findChildText(item.golock, "#txt_index")
		item.starItems = self:getUserDataTb_()

		local goStar = gohelper.findChild(item.gounlock, "#go_progress/#go_progressitem")

		for i = 1, 3 do
			local starItem = self:getUserDataTb_()

			starItem.go = i == 1 and goStar or gohelper.cloneInPlace(goStar)
			starItem.goLight = gohelper.findChild(starItem.go, "#image_icon")
			item.starItems[i] = starItem
		end

		local goClick = gohelper.findChild(item.go, "#go_clickarea")

		item.btnClick = gohelper.getClick(goClick)

		item.btnClick:AddClickListener(self._btnClickLevelOnClick, self, index)

		self._levelItems[index] = item
	end

	return item
end

function V3a9BirdMainView:_refreshSelectLevel(episodeId)
	for _, item in pairs(self._levelItems) do
		gohelper.setActive(item.goselect, episodeId == item.levelMo:getEpisodeId())
	end

	self._selectEpisodeId = episodeId
end

function V3a9BirdMainView:_refreshPlayerInfo()
	self._txtplayername.text = PlayerModel.instance:getPlayerName()

	if self._selectlevelMo then
		self._txtnum1.text = self._selectlevelMo:getBestScore()
		self._txtnum2.text = self._selectlevelMo:getStarCount()
	end
end

local BroadcastSpacing = 100

function V3a9BirdMainView:_setBroadcastText()
	local desc = luaLang("p_v3a9_bird_announce_desc")

	self._txtbroadcastWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(self._txtbroadcast, desc)
	self._broadcastRootWidth = recthelper.getWidth(self._txtbroadcast.transform.parent.transform)

	recthelper.setWidth(self._txtbroadcast.transform, self._txtbroadcastWidth)
	recthelper.setAnchorX(self._txtbroadcast.transform, 0)

	self._txtbroadcast.text = desc

	self:_doTweenBroadcastText()
end

function V3a9BirdMainView:_doTweenBroadcastText()
	self:_onKillnBroadcast()

	local x = recthelper.getAnchorX(self._txtbroadcast.transform)
	local targerX = -self._txtbroadcastWidth - BroadcastSpacing
	local time = (x - targerX) * 0.01

	self._broadcastTweenId = ZProj.TweenHelper.DOAnchorPosX(self._txtbroadcast.transform, targerX, time, self._onFinishBroadcast, self, nil, EaseType.Linear)
end

function V3a9BirdMainView:_onFinishBroadcast()
	recthelper.setAnchorX(self._txtbroadcast.transform, self._broadcastRootWidth + BroadcastSpacing)
	self:_doTweenBroadcastText()
end

function V3a9BirdMainView:_onKillnBroadcast()
	if self._broadcastTweenId then
		ZProj.TweenHelper.KillById(self._broadcastTweenId)

		self._broadcastTweenId = nil
	end
end

function V3a9BirdMainView:onClose()
	self:_onKillnBroadcast()
end

function V3a9BirdMainView:onDestroyView()
	for _, item in ipairs(self._levelItems) do
		if item.btnClick then
			item.btnClick:RemoveClickListener()
		end
	end

	self:_onKillnBroadcast()
end

return V3a9BirdMainView
