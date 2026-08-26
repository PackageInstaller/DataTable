-- chunkname: @modules/logic/fight/view/FightEditorStateView.lua

module("modules.logic.fight.view.FightEditorStateView", package.seeall)

local FightEditorStateView = class("FightEditorStateView", BaseViewExtended)

function FightEditorStateView:onInitView()
	self._btnListRoot = gohelper.findChild(self.viewGO, "root/topLeft/ScrollView/Viewport/Content")
	self._btnModel = gohelper.findChild(self._btnListRoot, "btnModel")
	self._center = gohelper.findChild(self.viewGO, "root/center")
	self._closeBtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/topRight/Button")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightEditorStateView:addEvents()
	self.addClickCb(self, self._closeBtn, self._onBtnClose, self)
end

function FightEditorStateView:removeEvents()
	return
end

function FightEditorStateView:_editableInitView()
	return
end

function FightEditorStateView:onRefreshViewParam()
	return
end

function FightEditorStateView:_onBtnClose()
	self:closeThis()
end

function FightEditorStateView:onOpen()
	local btnData = {
		{
			name = "最后一回合"
		},
		{
			name = "战场日志"
		}
	}

	self:com_createObjList(self._onBtnItemShow, btnData, self._btnListRoot, self._btnModel)
	self:_onBtnClick1()
end

function FightEditorStateView:_onBtnItemShow(obj, data, index)
	local text = gohelper.findChildText(obj, "text")

	text.text = data.name

	local btn = gohelper.findChildClick(obj, "btn")

	self.addClickCb(self, btn, self["_onBtnClick" .. index], self)
end

function FightEditorStateView:_onBtnClick1()
	self:openExclusiveView(nil, 1, FightEditorStateLastRoundLogView, "ui/viewres/fight/fighteditorstatelogview.prefab", self._center)
end

function FightEditorStateView:_onBtnClick2()
	self:openExclusiveView(nil, 2, FightEditorStateLogView, "ui/viewres/fight/fighteditorstatelogview.prefab", self._center)
end

function FightEditorStateView:onClose()
	return
end

function FightEditorStateView:onDestroyView()
	return
end

return FightEditorStateView
