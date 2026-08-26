-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonPolygonSuccView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonPolygonSuccView", package.seeall)

local AtomicDungeonPolygonSuccView = class("AtomicDungeonPolygonSuccView", BaseView)

function AtomicDungeonPolygonSuccView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDungeonPolygonSuccView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function AtomicDungeonPolygonSuccView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function AtomicDungeonPolygonSuccView:_btncloseOnClick()
	self:closeThis()
end

function AtomicDungeonPolygonSuccView:_editableInitView()
	return
end

function AtomicDungeonPolygonSuccView:onUpdateParam()
	return
end

function AtomicDungeonPolygonSuccView:onOpen()
	AtomicDungeonModel.instance:setNeedPlayPolygonEnterFinish(true)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_decrypt_success1)
end

function AtomicDungeonPolygonSuccView:onClose()
	return
end

function AtomicDungeonPolygonSuccView:onDestroyView()
	return
end

return AtomicDungeonPolygonSuccView
