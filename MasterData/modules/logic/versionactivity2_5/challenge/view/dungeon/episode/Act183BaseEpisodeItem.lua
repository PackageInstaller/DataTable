-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/episode/Act183BaseEpisodeItem.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.episode.Act183BaseEpisodeItem", package.seeall)

local Act183BaseEpisodeItem = class("Act183BaseEpisodeItem", LuaCompBase)

function Act183BaseEpisodeItem.Get(rootGo, episodeMo)
	local episodeId = episodeMo:getEpisodeId()
	local episodeType = episodeMo:getEpisodeType()
	local groupType = episodeMo:getGroupType()
	local order = episodeMo:getConfigOrder()
	local clsDefineKey = Act183Helper.getEpisodeClsKey(groupType, episodeType)
	local clsDefine = Act183Enum.EpisodeClsType[clsDefineKey]
	local parentPath = clsDefine.getItemParentPath(order)
	local parentGo = gohelper.findChild(rootGo, parentPath)

	if gohelper.isNil(parentGo) then
		logError(string.format("挑战玩法关卡挂点不存在 episodeId = %s, parentPath = %s", episodeId, parentPath))
	end

	local tempatePath = clsDefine.getItemTemplatePath()
	local templateGo = clsDefine.getItemTemplateGo(rootGo, tempatePath)
	local itemName = "item_" .. order
	local itemGo = gohelper.clone(templateGo, parentGo, itemName)
	local episodeInst = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, clsDefine)

	episodeInst.parentGo = parentGo

	episodeInst:initPosAndRotation()

	return episodeInst
end

function Act183BaseEpisodeItem.getItemParentPath(order)
	return ""
end

function Act183BaseEpisodeItem.getItemTemplateGo(rootGo, templatePath)
	return (gohelper.findChild(rootGo, templatePath))
end

function Act183BaseEpisodeItem.getItemTemplatePath(order)
	return ""
end

function Act183BaseEpisodeItem:init(go)
	self.go = go
	self._golock = gohelper.findChild(self.go, "go_lock")
	self._gounlock = gohelper.findChild(self.go, "go_unlock")
	self._gofinish = gohelper.findChild(self.go, "go_finish")
	self._gocheck = gohelper.findChild(self.go, "go_finish/image")
	self._btnclick = gohelper.findChildButton(self.go, "btn_click")
	self._goselect = gohelper.findChild(self.go, "go_select")
	self._simageicon = gohelper.findChildSingleImage(self.go, "image_icon")
	self._animfinish = gohelper.onceAddComponent(self._gofinish, gohelper.Type_Animator)
end

function Act183BaseEpisodeItem:initPosAndRotation()
	local positionRootGo = gohelper.findChild(self.parentGo, "positions")

	if gohelper.isNil(positionRootGo) then
		return
	end

	local positionRootTran = positionRootGo.transform
	local childCount = positionRootTran.childCount

	for i = 1, childCount do
		local templateTran = positionRootTran:GetChild(i - 1)

		self:setTranPosition(templateTran)
	end
end

function Act183BaseEpisodeItem:setTranPosition(templateTran)
	local goPath = templateTran.gameObject.name
	local go = gohelper.findChild(self.go, goPath)

	if gohelper.isNil(go) then
		logError(string.format("设置关卡ui坐标失败 节点不存在 rootName = %s, goPath = %s", self.parentGo.name, goPath))

		return
	end

	local positionX, positionY = recthelper.getAnchor(templateTran)
	local rotationX, rotationY, rotationZ = transformhelper.getLocalRotation(templateTran)

	recthelper.setAnchor(go.transform, positionX or 0, positionY or 0)
	transformhelper.setLocalRotation(go.transform, rotationX, rotationY, rotationZ)
end

function Act183BaseEpisodeItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.OnClickEpisode, self._onSelectEpisode, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.EpisodeStartPlayFinishAnim, self._checkPlayFinishAnim, self)
end

function Act183BaseEpisodeItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function Act183BaseEpisodeItem:_btnclickOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_ClickEpisode)
	Act183Controller.instance:dispatchEvent(Act183Event.OnClickEpisode, self._episodeId)
end

function Act183BaseEpisodeItem:_onSelectEpisode(episodeId)
	self:onSelect(episodeId == self._episodeId)
end

function Act183BaseEpisodeItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function Act183BaseEpisodeItem:onUpdateMo(episodeMo)
	self._episodeMo = episodeMo
	self._status = episodeMo:getStatus()
	self._episodeId = episodeMo:getEpisodeId()

	local episodeId = Act183Model.instance:getNewFinishEpisodeId()

	self._isFinishedButNotNew = self._status == Act183Enum.EpisodeStatus.Finished and episodeId ~= self._episodeId

	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._golock, self._status == Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(self._gounlock, self._status ~= Act183Enum.EpisodeStatus.Locked)
	gohelper.setActive(self._gofinish, self._isFinishedButNotNew)
	Act183Helper.setEpisodeIcon(self._episodeId, self._status, self._simageicon)
	self:setVisible(true)
end

function Act183BaseEpisodeItem:getConfigOrder()
	if self._episodeMo then
		local config = self._episodeMo:getConfig()

		return config and config.order
	end
end

function Act183BaseEpisodeItem:setVisible(isVisible)
	gohelper.setActive(self.go, isVisible)
end

function Act183BaseEpisodeItem:getIconTran()
	return self._simageicon.transform
end

function Act183BaseEpisodeItem:playFinishAnim()
	gohelper.setActive(self._gofinish, true)
	self._animfinish:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_EpisodeFinished)
end

function Act183BaseEpisodeItem:_checkPlayFinishAnim(episodeId)
	if self._episodeId ~= episodeId then
		return
	end

	self:playFinishAnim()
end

function Act183BaseEpisodeItem:refreshPassStarList(gostartemplate)
	if self._status ~= Act183Enum.EpisodeStatus.Finished then
		return
	end

	local allConditionCount = self._episodeMo and self._episodeMo:getTotalStarCount() or 0
	local passConditionCount = self._episodeMo and self._episodeMo:getFinishStarCount() or 0
	local useMap = {}

	for i = 1, allConditionCount do
		local starItem = self._starItemTab[i]

		if not starItem then
			starItem = self:getUserDataTb_()
			starItem.go = gohelper.cloneInPlace(gostartemplate, "star_" .. i)
			starItem.imagestar = starItem.go:GetComponent(gohelper.Type_Image)
			self._starItemTab[i] = starItem
		end

		local isFinish = i <= passConditionCount
		local color = isFinish and "#F77040" or "#87898C"

		UISpriteSetMgr.instance:setCommonSprite(starItem.imagestar, "zhuxianditu_pt_xingxing_001", true)
		SLFramework.UGUI.GuiHelper.SetColor(starItem.imagestar, color)
		gohelper.setActive(starItem.go, true)

		useMap[starItem] = true
	end

	for _, starItem in pairs(self._starItemTab) do
		if not useMap[starItem] then
			gohelper.setActive(starItem.go, false)
		end
	end
end

function Act183BaseEpisodeItem:destroySelf()
	gohelper.destroy(self.go)
end

function Act183BaseEpisodeItem:onDestroy()
	return
end

return Act183BaseEpisodeItem
