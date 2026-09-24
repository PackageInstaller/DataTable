-- chunkname: @modules/logic/versionactivity4_0/deleike/view/comp/DeleikeLevelItem.lua

module("modules.logic.versionactivity4_0.deleike.view.comp.DeleikeLevelItem", package.seeall)

local DeleikeLevelItem = class("DeleikeLevelItem", LuaCompBase)

function DeleikeLevelItem:init(go)
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

function DeleikeLevelItem:_initNode(nodeGo)
	local node = self:getUserDataTb_()

	node.go = nodeGo
	node._txtName = gohelper.findChildText(nodeGo, "txt_StageName")
	node._txtNum = gohelper.findChildText(nodeGo, "txt_StageNum")
	node._gostar = gohelper.findChild(nodeGo, "Star/go_Star")
	node._golock = gohelper.findChild(nodeGo, "#go_Locked")

	table.insert(self._typeNode, node)
end

function DeleikeLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnOnClick, self)
end

function DeleikeLevelItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function DeleikeLevelItem:_btnOnClick()
	DeleikeController.instance:clickEpisodeLevel(self.id, self.index)
end

function DeleikeLevelItem:setParam(co, index, actId)
	self.config = co
	self.id = self.config.episodeId
	self.actId = actId
	self.index = index

	local isSpecial = self.config.gameId ~= 0 or self.config.fightEpisodeId ~= 0

	if isSpecial then
		self.node = self._typeNode[2] or self._typeNode[1]
	end

	gohelper.setActive(self._typeNode[1].go, not isSpecial)
	gohelper.setActive(self._typeNode[2].go, isSpecial)
	self:refreshUI()
end

function DeleikeLevelItem:isEpisodeUnlock()
	local mo = Activity220Model.instance:getById(self.actId)

	return mo:isEpisodeUnlock(self.id)
end

function DeleikeLevelItem:isEpisodePass()
	local episodeInfo = Activity220Model.instance:getEpisodeInfo(self.actId, self.id)

	return episodeInfo and episodeInfo:isEpisodePass() or false
end

function DeleikeLevelItem:getCurEpisode()
	local mo = Activity220Model.instance:getById(self.actId)

	return mo:getCurEpisode()
end

function DeleikeLevelItem:refreshUI()
	self._isunlock = self:isEpisodeUnlock()
	self._ispass = self:isEpisodePass()
	self.node._txtName.text = self.config.name
	self.node._txtNum.text = string.format("%02d", self.index)

	local isCurrent = self.id == self:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self.node._gostar, self._ispass)
	gohelper.setActive(self.node._golock, not self._isunlock)
end

function DeleikeLevelItem:playFinish()
	self._ispass = self:isEpisodePass()

	gohelper.setActive(self._goCurrent, false)

	if self._anim then
		self._anim.enabled = true

		self._anim:Play("finish", 0, 0)
	end

	if self._isunlock then
		gohelper.setActive(self.node._gostar, self._ispass)
	end
end

function DeleikeLevelItem:playUnlock()
	self._isunlock = self:isEpisodeUnlock()

	local isCurrent = self.id == self:getCurEpisode()

	gohelper.setActive(self._goCurrent, isCurrent)
	gohelper.setActive(self.node._golock, not self._isunlock)

	if self._anim then
		self._anim:Play("unlock", 0, 0)
	end
end

function DeleikeLevelItem:playStarAnim()
	AudioMgr.instance:trigger(AudioEnum.RoleActivity.star_show)
end

return DeleikeLevelItem
