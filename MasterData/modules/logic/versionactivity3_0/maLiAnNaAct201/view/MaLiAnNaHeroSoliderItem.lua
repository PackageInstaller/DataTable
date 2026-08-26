-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/MaLiAnNaHeroSoliderItem.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaHeroSoliderItem", package.seeall)

local MaLiAnNaHeroSoliderItem = class("MaLiAnNaHeroSoliderItem", ListScrollCellExtend)

function MaLiAnNaHeroSoliderItem:onInitView()
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txtRoleName = gohelper.findChildText(self.viewGO, "#go_tips/#txt_RoleName")
	self._txtdec = gohelper.findChildText(self.viewGO, "#go_tips/#txt_dec")
	self._txtRoleHP = gohelper.findChildText(self.viewGO, "#go_tips/#txt_RoleHP")
	self._goSelf = gohelper.findChild(self.viewGO, "#go_Self")
	self._goEnemy = gohelper.findChild(self.viewGO, "#go_Enemy")
	self._simageRole = gohelper.findChildSingleImage(self.viewGO, "image/#simage_Role")
	self._txtRoleHP2 = gohelper.findChildText(self.viewGO, "image_RoleHPNumBG/#txt_RoleHP_2")
	self._goDead = gohelper.findChild(self.viewGO, "#go_Dead")
	self._btnrole = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_role")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MaLiAnNaHeroSoliderItem:addEvents()
	self._btnrole:AddClickListener(self._btnroleOnClick, self)
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self.onTouchScreen, self)
end

function MaLiAnNaHeroSoliderItem:removeEvents()
	self._btnrole:RemoveClickListener()
	self.removeEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self.onTouchScreen, self)
end

function MaLiAnNaHeroSoliderItem:_btnroleOnClick()
	self:refreshTip()
end

function MaLiAnNaHeroSoliderItem:_editableInitView()
	self._goRoleHP = gohelper.findChild(self.viewGO, "image_RoleHPNumBG")
	self._txtReduceHP = gohelper.findChildText(self.viewGO, "#txt_reduceHP")
	self._goReduceHp = self._txtReduceHP.gameObject

	self:_hideReduce()
end

function MaLiAnNaHeroSoliderItem:_editableAddEvents()
	return
end

function MaLiAnNaHeroSoliderItem:_editableRemoveEvents()
	return
end

function MaLiAnNaHeroSoliderItem:onTouchScreen()
	if self._gotips then
		if gohelper.isMouseOverGo(self._gotips) or gohelper.isMouseOverGo(self._btnrole) then
			return
		end

		self._isShowTips = false

		self:_refreshTipState()
	end
end

function MaLiAnNaHeroSoliderItem:refreshTip()
	self._isShowTips = not self._isShowTips

	self:_refreshTipState()
end

function MaLiAnNaHeroSoliderItem:_refreshTipState()
	gohelper.setActive(self._gotips, self._isShowTips)
	gohelper.setActive(self._goRoleHP, not self._isShowTips)
end

function MaLiAnNaHeroSoliderItem:initData(mo)
	self._soliderMo = mo

	if self._soliderMo == nil then
		return
	end

	local config = self._soliderMo:getConfig()

	self._txtdec.text = config.description
	self._txtRoleName.text = config.name
	self._isShowTips = false

	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._goSelf, self._soliderMo:getCamp() == Activity201MaLiAnNaEnum.CampType.Player)
	gohelper.setActive(self._goEnemy, self._soliderMo:getCamp() == Activity201MaLiAnNaEnum.CampType.Enemy)
	self._simageRole:LoadImage(self._soliderMo:getSmallIcon())
end

function MaLiAnNaHeroSoliderItem:updateInfo(mo)
	self._soliderMo = mo

	if self._soliderMo == nil then
		return
	end

	local hp = self._soliderMo:getHp()

	if self._lastHp == nil or self._lastHp ~= hp then
		self._txtRoleHP.text = hp
		self._txtRoleHP2.text = hp
		self._lastHp = hp

		gohelper.setActive(self._goDead, self._soliderMo:isDead())
	end
end

function MaLiAnNaHeroSoliderItem:showDiff(addValue)
	if self._isShowDiff then
		if self._isShowDiffList == nil then
			self._isShowDiffList = {}
		end

		table.insert(self._isShowDiffList, addValue)
	else
		if addValue == nil and self._isShowDiffList ~= nil and #self._isShowDiffList > 0 then
			addValue = table.remove(self._isShowDiffList, 1)
		end

		self:_showDiff(addValue)
	end
end

function MaLiAnNaHeroSoliderItem:_showDiff(value)
	if value == nil then
		return
	end

	if self._goReduceHp.activeSelf then
		gohelper.setActive(self._goReduceHp, false)
	end

	self._txtReduceHP.text = value

	gohelper.setActive(self._goReduceHp, true)

	self._isShowDiff = true

	local time = 1

	if self._isShowDiffList and #self._isShowDiffList > 0 then
		time = time * 0.4
	end

	TaskDispatcher.runDelay(self._hideReduce, self, time)
end

function MaLiAnNaHeroSoliderItem:_hideReduce()
	gohelper.setActive(self._goReduceHp, false)

	self._isShowDiff = false

	self:showDiff()
end

function MaLiAnNaHeroSoliderItem:reset()
	if self._isShowDiffList then
		tabletool.clear(self._isShowDiffList)

		self._isShowDiffList = nil
	end

	TaskDispatcher.cancelTask(self._hideReduce, self)
	self:_hideReduce()
end

function MaLiAnNaHeroSoliderItem:onDestroyView()
	if self._isShowDiffList then
		tabletool.clear(self._isShowDiffList)

		self._isShowDiffList = nil
	end

	TaskDispatcher.cancelTask(self._hideReduce, self)
end

return MaLiAnNaHeroSoliderItem
