-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongLevelItem.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongLevelItem", package.seeall)

local V3a8EchoSongLevelItem = class("V3a8EchoSongLevelItem", ListScrollCellExtend)

function V3a8EchoSongLevelItem:onInitView()
	self._goNormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._goSpecial = gohelper.findChild(self.viewGO, "#go_Special")
	self._goCurrent = gohelper.findChild(self.viewGO, "#go_Current")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8EchoSongLevelItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function V3a8EchoSongLevelItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function V3a8EchoSongLevelItem:_btnClickOnClick()
	V3a8EchoSongController.instance:clickEpisodeLevel(self.id, self._index)
end

function V3a8EchoSongLevelItem:_editableInitView()
	self.transform = self.viewGO.transform
	self._typeNode = {}

	self:_initNode(self._goNormal)
	self:_initNode(self._goSpecial)

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function V3a8EchoSongLevelItem:_initNode(nodeGo)
	local node = self:getUserDataTb_()

	node.go = nodeGo
	node._txtName = gohelper.findChildText(nodeGo, "Layout/txt_StageName")
	node._goNum = gohelper.findChild(nodeGo, "Layout/Num")
	node._txtNum = gohelper.findChildText(nodeGo, "Layout/Num/txt_StageNum")
	node._gostar = gohelper.findChild(nodeGo, "Star/go_Star")
	node._golock = gohelper.findChild(nodeGo, "#go_Locked")

	table.insert(self._typeNode, node)
end

function V3a8EchoSongLevelItem:_editableAddEvents()
	return
end

function V3a8EchoSongLevelItem:_editableRemoveEvents()
	return
end

function V3a8EchoSongLevelItem:setParam(co, index, actId)
	self._config = co
	self.id = co.episodeId
	self._actId = actId
	self._index = index
	self.gameId = self._config.gameId
	self._isStoryEpisode = self.gameId == 0

	if self._isStoryEpisode then
		self._node = self._typeNode[1] or self._typeNode[2]
	end

	gohelper.setActive(self._typeNode[1].go, self._isStoryEpisode)
	gohelper.setActive(self._typeNode[2].go, not self._isStoryEpisode)

	if self._config then
		local isNormalLevel = self._config.type == 0

		gohelper.setActive(self._typeNode[1]._goNum, isNormalLevel)
		gohelper.setActive(self._typeNode[2]._goNum, isNormalLevel)
		self:refreshUI()
	end
end

function V3a8EchoSongLevelItem:isEpisodeUnlock()
	local mo = Activity220Model.instance:getById(self._actId)

	return mo:isEpisodeUnlock(self.id)
end

function V3a8EchoSongLevelItem:isEpisodePass()
	local episodeInfo = Activity220Model.instance:getEpisodeInfo(self._actId, self.id)

	return episodeInfo and episodeInfo:isEpisodePass() or false
end

function V3a8EchoSongLevelItem:getCurEpisode()
	local mo = Activity220Model.instance:getById(self._actId)

	return mo:getCurEpisode()
end

function V3a8EchoSongLevelItem:refreshUI()
	self._isunlock = self:isEpisodeUnlock()
	self._ispass = self:isEpisodePass()
	self._node._txtName.text = self._config.name
	self._node._txtNum.text = string.format("%02d", self._index)

	local isCurrent = self.id == self:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self._node._gostar, self._ispass)
	gohelper.setActive(self._node._golock, not self._isunlock)
end

function V3a8EchoSongLevelItem:playFinish()
	self._ispass = self:isEpisodePass()

	gohelper.setActive(self._goCurrent, false)

	self._anim.enabled = true

	self._anim:Play("finish", 0, 0)

	if self._isunlock then
		gohelper.setActive(self._node._gostar, self._ispass)
	end
end

function V3a8EchoSongLevelItem:playUnlock()
	self._isunlock = self:isEpisodeUnlock()

	local isCurrent = self.id == self:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self._node._golock, not self._isunlock)
	self._anim:Play("unlock", 0, 0)
end

function V3a8EchoSongLevelItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

function V3a8EchoSongLevelItem:onDestroyView()
	return
end

return V3a8EchoSongLevelItem
