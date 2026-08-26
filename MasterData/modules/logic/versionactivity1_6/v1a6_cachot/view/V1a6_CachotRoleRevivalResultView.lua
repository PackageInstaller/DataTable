-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoleRevivalResultView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoleRevivalResultView", package.seeall)

local V1a6_CachotRoleRevivalResultView = class("V1a6_CachotRoleRevivalResultView", BaseView)

function V1a6_CachotRoleRevivalResultView:onInitView()
	self._gotipswindow = gohelper.findChild(self.viewGO, "#go_tipswindow")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goteamprepareitem = gohelper.findChild(self.viewGO, "#go_teamprepareitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotRoleRevivalResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V1a6_CachotRoleRevivalResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V1a6_CachotRoleRevivalResultView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotRoleRevivalResultView:_editableInitView()
	return
end

function V1a6_CachotRoleRevivalResultView:onUpdateParam()
	return
end

function V1a6_CachotRoleRevivalResultView:_initPresetItem()
	local path = self.viewContainer:getSetting().otherRes[1]
	local childGO = self:getResInst(path, self._goteamprepareitem)

	self._item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotRoleRevivalPresetItem)
end

function V1a6_CachotRoleRevivalResultView:_initPrepareItem()
	local path = self.viewContainer:getSetting().otherRes[2]
	local childGO = self:getResInst(path, self._goteamprepareitem)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotRoleRevivalPrepareItem)

	item:hideDeadStatus(true)

	self._item = item
end

function V1a6_CachotRoleRevivalResultView:onOpen()
	self._mo = self.viewParam[1]

	self:_initPrepareItem()
	self._item:onUpdateMO(self._mo)
end

function V1a6_CachotRoleRevivalResultView:onClose()
	return
end

function V1a6_CachotRoleRevivalResultView:onDestroyView()
	return
end

return V1a6_CachotRoleRevivalResultView
