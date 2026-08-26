-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRecoverResultView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRecoverResultView", package.seeall)

local V1a6_CachotRoleRecoverResultView = class("V1a6_CachotRoleRecoverResultView", BaseView)

function V1a6_CachotRoleRecoverResultView:onInitView()
	self._gotipswindow = gohelper.findChild(self.viewGO, "#go_tipswindow")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goteamprepareitem = gohelper.findChild(self.viewGO, "#go_teamprepareitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotRoleRecoverResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V1a6_CachotRoleRecoverResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V1a6_CachotRoleRecoverResultView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotRoleRecoverResultView:_editableInitView()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_easter_success)
end

function V1a6_CachotRoleRecoverResultView:onUpdateParam()
	return
end

function V1a6_CachotRoleRecoverResultView:_initPresetItem()
	local path = self.viewContainer:getSetting().otherRes[1]
	local childGO = self:getResInst(path, self._goteamprepareitem)

	self._item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotRoleRecoverPresetItem)
end

function V1a6_CachotRoleRecoverResultView:_initPrepareItem()
	local path = self.viewContainer:getSetting().otherRes[2]
	local childGO = self:getResInst(path, self._goteamprepareitem)

	self._item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotRoleRecoverPrepareItem)
end

function V1a6_CachotRoleRecoverResultView:onOpen()
	self._mo = self.viewParam[1]

	local seatInfo = V1a6_CachotTeamModel.instance:getSeatInfo(self._mo)

	if seatInfo then
		self:_initPresetItem()
	else
		self:_initPrepareItem()
	end

	self._item:onUpdateMO(self._mo)
	self:_tweenHp()
end

function V1a6_CachotRoleRecoverResultView:_tweenHp()
	local lifes = V1a6_CachotModel.instance:getChangeLifes()

	if not lifes then
		return
	end

	local heroMo = self._item:getHeroMo()

	if not heroMo then
		return
	end

	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()

	for i, v in ipairs(lifes) do
		if heroMo.heroId == v.heroId then
			local hpInfo = teamInfo:getHeroHp(v.heroId)

			self._item:tweenHp(v.life, hpInfo.life, 0.3)

			break
		end
	end
end

function V1a6_CachotRoleRecoverResultView:onClose()
	return
end

function V1a6_CachotRoleRecoverResultView:onDestroyView()
	return
end

return V1a6_CachotRoleRecoverResultView
