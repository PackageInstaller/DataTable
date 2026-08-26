-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174BuffTipView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174BuffTipView", package.seeall)

local Act174BuffTipView = class("Act174BuffTipView", BaseView)

function Act174BuffTipView:onInitView()
	self._btnclosetip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closetip")
	self._goscrolltips = gohelper.findChild(self.viewGO, "#go_scrolltips")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_scrolltips/viewport/content/go_title/#txt_title")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_scrolltips/viewport/content/go_title/#image_icon")
	self._goskillitem = gohelper.findChild(self.viewGO, "#go_scrolltips/viewport/content/#go_skillitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174BuffTipView:addEvents()
	self._btnclosetip:AddClickListener(self._btnclosetipOnClick, self)
end

function Act174BuffTipView:removeEvents()
	self._btnclosetip:RemoveClickListener()
end

function Act174BuffTipView:_btnclosetipOnClick()
	self:closeThis()
end

function Act174BuffTipView:_editableInitView()
	self._goContent = gohelper.findChild(self.viewGO, "#go_scrolltips/viewport/content")
end

function Act174BuffTipView:onUpdateParam()
	return
end

function Act174BuffTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)

	if not self.viewParam then
		logError("please open with param")

		return
	end

	local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	local isEnemy = self.viewParam.isEnemy

	if isEnemy then
		local matchInfo = gameInfo:getFightInfo().matchInfo

		UISpriteSetMgr.instance:setAct174Sprite(self._imageicon, "act174_ready_icon_enemy")

		self._txttitle.text = luaLang("act174_enhance_enemy")

		local fightInfo = gameInfo:getFightInfo()

		if fightInfo then
			self.enhanceList = matchInfo.enhanceId
			self.endEnhanceList = matchInfo.endEnhanceId
		else
			logError("dont exist fightInfo")

			return
		end
	else
		local wareHouseMO = gameInfo:getWarehouseInfo()

		UISpriteSetMgr.instance:setAct174Sprite(self._imageicon, "act174_ready_icon_player")

		self._txttitle.text = luaLang("act174_enhance_player")
		self.enhanceList = wareHouseMO.enhanceId
		self.endEnhanceList = wareHouseMO.endEnhanceId
	end

	self.buffIconList = self:getUserDataTb_()

	for _, id in ipairs(self.enhanceList) do
		local go = gohelper.cloneInPlace(self._goskillitem)
		local enhanceCo = lua_activity174_enhance.configDict[id]
		local txtSkill = gohelper.findChildText(go, "txt_skill")
		local buffIcon = gohelper.findChildSingleImage(go, "skillicon")
		local txtDesc = gohelper.findChildText(go, "layout/txt_dec")

		txtSkill.text = enhanceCo.title

		local desc = enhanceCo.desc

		if self.endEnhanceList and tabletool.indexOf(self.endEnhanceList, id) then
			desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act174_enhance_overduea"), desc)
		end

		txtDesc.text = desc

		buffIcon:LoadImage(ResUrl.getAct174BuffIcon(enhanceCo.icon))

		self.buffIconList[#self.buffIconList + 1] = buffIcon
	end

	gohelper.setActive(self._goskillitem, false)
	TaskDispatcher.runDelay(self.refreshAnchor, self, 0.01)
end

function Act174BuffTipView:refreshAnchor()
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

function Act174BuffTipView:onClose()
	return
end

function Act174BuffTipView:onDestroyView()
	for _, buffIcon in ipairs(self.buffIconList) do
		buffIcon:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self.refreshAnchor, self)
end

return Act174BuffTipView
