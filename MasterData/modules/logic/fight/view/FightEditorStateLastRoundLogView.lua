-- chunkname: @modules/logic/fight/view/FightEditorStateLastRoundLogView.lua

module("modules.logic.fight.view.FightEditorStateLastRoundLogView", package.seeall)

local FightEditorStateLastRoundLogView = class("FightEditorStateLastRoundLogView", BaseViewExtended)

function FightEditorStateLastRoundLogView:onInitView()
	self._btnListRoot = gohelper.findChild(self.viewGO, "btnScrill/Viewport/Content")
	self._btnModel = gohelper.findChild(self._btnListRoot, "btnModel")
	self._logText = gohelper.findChildText(self.viewGO, "ScrollView/Viewport/Content/logText")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightEditorStateLastRoundLogView:addEvents()
	return
end

function FightEditorStateLastRoundLogView:removeEvents()
	return
end

function FightEditorStateLastRoundLogView:_editableInitView()
	return
end

function FightEditorStateLastRoundLogView:onRefreshViewParam()
	return
end

function FightEditorStateLastRoundLogView:onOpen()
	local btnData = {
		{
			name = "复制"
		}
	}

	self:com_createObjList(self._onBtnItemShow, btnData, self._btnListRoot, self._btnModel)

	local lastRound = FightDataHelper.protoCacheMgr:getLastRoundProto()

	if not lastRound then
		self._logText.text = "没有数据"

		return
	end

	self._strList = {}

	local roundNum = FightDataHelper.protoCacheMgr:getLastRoundNum()

	if roundNum then
		self:addLog("回合" .. roundNum)
	end

	self:addLog(tostring(lastRound))

	local str = table.concat(self._strList, "\n")

	self._logText.text = FightEditorStateLogView.processStr(str)
end

function FightEditorStateLastRoundLogView:_onBtnItemShow(obj, data, index)
	local text = gohelper.findChildText(obj, "text")

	text.text = data.name

	local btn = gohelper.findChildClick(obj, "btn")

	self.addClickCb(self, btn, self["_onBtnClick" .. index], self)
end

function FightEditorStateLastRoundLogView:_onBtnClick1()
	ZProj.UGUIHelper.CopyText(self._logText.text)
end

function FightEditorStateLastRoundLogView:addLog(str)
	table.insert(self._strList, str)
end

function FightEditorStateLastRoundLogView:onClose()
	return
end

function FightEditorStateLastRoundLogView:onDestroyView()
	return
end

return FightEditorStateLastRoundLogView
