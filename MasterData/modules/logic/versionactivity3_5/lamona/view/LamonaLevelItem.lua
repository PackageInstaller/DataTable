-- chunkname: @modules/logic/versionactivity3_5/lamona/view/LamonaLevelItem.lua

module("modules.logic.versionactivity3_5.lamona.view.LamonaLevelItem", package.seeall)

local LamonaLevelItem = class("LamonaLevelItem", LuaCompBase)

function LamonaLevelItem:init(go)
	self.viewGO = go
	self.transform = self.viewGO.transform
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Click")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_Normal")
	self._gospecial = gohelper.findChild(self.viewGO, "#go_Special")
	self._goCurrent = gohelper.findChild(self.viewGO, "#go_Current")
	self._typeNode = {}

	self:_initNode(self._gonormal)
	self:_initNode(self._gospecial)

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function LamonaLevelItem:_initNode(nodeGo)
	local node = self:getUserDataTb_()

	node.go = nodeGo
	node._txtName = gohelper.findChildText(nodeGo, "Layout/txt_StageName")
	node._goNum = gohelper.findChild(nodeGo, "Layout/Num")
	node._txtNum = gohelper.findChildText(nodeGo, "Layout/Num/txt_StageNum")
	node._gostar = gohelper.findChild(nodeGo, "Star/go_Star")
	node._golock = gohelper.findChild(nodeGo, "#go_Locked")

	table.insert(self._typeNode, node)
end

function LamonaLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
end

function LamonaLevelItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function LamonaLevelItem:_btnOnClick()
	LamonaController.instance:clickEpisodeLevel(self.id, self._index)
end

function LamonaLevelItem:setParam(co, index, actId)
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

function LamonaLevelItem:isEpisodeUnlock()
	local mo = Activity220Model.instance:getById(self._actId)

	return mo:isEpisodeUnlock(self.id)
end

function LamonaLevelItem:isEpisodePass()
	local episodeInfo = Activity220Model.instance:getEpisodeInfo(self._actId, self.id)

	return episodeInfo and episodeInfo:isEpisodePass() or false
end

function LamonaLevelItem:getCurEpisode()
	local mo = Activity220Model.instance:getById(self._actId)

	return mo:getCurEpisode()
end

function LamonaLevelItem:refreshUI()
	self._isunlock = self:isEpisodeUnlock()
	self._ispass = self:isEpisodePass()
	self._node._txtName.text = self._config.name
	self._node._txtNum.text = string.format("%02d", self._index)

	local isCurrent = self.id == self:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self._node._gostar, self._ispass)
	gohelper.setActive(self._node._golock, not self._isunlock)
end

function LamonaLevelItem:playFinish()
	self._ispass = self:isEpisodePass()

	gohelper.setActive(self._goCurrent, false)

	self._anim.enabled = true

	self._anim:Play("finish", 0, 0)

	if self._isunlock then
		gohelper.setActive(self._node._gostar, self._ispass)
	end
end

function LamonaLevelItem:playUnlock()
	self._isunlock = self:isEpisodeUnlock()

	local isCurrent = self.id == self:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self._node._golock, not self._isunlock)
	self._anim:Play("unlock", 0, 0)
end

function LamonaLevelItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

return LamonaLevelItem
