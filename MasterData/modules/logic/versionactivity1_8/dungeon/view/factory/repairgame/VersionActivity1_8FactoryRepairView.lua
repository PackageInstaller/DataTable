-- chunkname: @modules/logic/versionactivity1_8/dungeon/view/factory/repairgame/VersionActivity1_8FactoryRepairView.lua

module("modules.logic.versionactivity1_8.dungeon.view.factory.repairgame.VersionActivity1_8FactoryRepairView", package.seeall)

local VersionActivity1_8FactoryRepairView = class("VersionActivity1_8FactoryRepairView", BaseView)

function VersionActivity1_8FactoryRepairView:onInitView()
	self._txtTips = gohelper.findChildText(self.viewGO, "#txt_Tips")
	self._gofinish = gohelper.findChild(self.viewGO, "#go_finish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_8FactoryRepairView:addEvents()
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, self._onGameClear, self)
	self.addEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, self._onResetGame, self)
end

function VersionActivity1_8FactoryRepairView:removeEvents()
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.PipeGameClear, self._onGameClear, self)
	self.removeEventCb(self, Activity157Controller.instance, ArmPuzzlePipeEvent.ResetGameRefresh, self._onResetGame, self)
end

function VersionActivity1_8FactoryRepairView:_onGameClear()
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_achievement)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_character)
	gohelper.setActive(self._gofinish, true)
	Activity157Rpc.instance:sendAct157UnlockComponentRequest(self.actId, self.curComponentId)
end

function VersionActivity1_8FactoryRepairView:_onResetGame()
	gohelper.setActive(self._gofinish, false)
end

function VersionActivity1_8FactoryRepairView:_editableInitView()
	self.actId = Activity157Model.instance:getActId()
	self.curComponentId = Activity157RepairGameModel.instance:getCurComponentId()

	gohelper.setActive(self._gofinish, false)
end

function VersionActivity1_8FactoryRepairView:onOpen()
	self._txtTips.text = Activity157Config.instance:getAct157RepairMapTitleTip(self.actId, self.curComponentId)
end

function VersionActivity1_8FactoryRepairView:onClose()
	return
end

function VersionActivity1_8FactoryRepairView:onDestroyView()
	return
end

return VersionActivity1_8FactoryRepairView
