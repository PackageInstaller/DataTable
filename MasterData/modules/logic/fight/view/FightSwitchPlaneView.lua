-- chunkname: @modules/logic/fight/view/FightSwitchPlaneView.lua

module("modules.logic.fight.view.FightSwitchPlaneView", package.seeall)

local FightSwitchPlaneView = class("FightSwitchPlaneView", BaseView)

function FightSwitchPlaneView:onInitView()
	return
end

function FightSwitchPlaneView:addEvents()
	return
end

function FightSwitchPlaneView:removeEvents()
	return
end

function FightSwitchPlaneView.blockEsc()
	return
end

function FightSwitchPlaneView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)
end

FightSwitchPlaneView.AudioDelay = 0.8

function FightSwitchPlaneView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_task_entry)
	TaskDispatcher.runDelay(self.playAudio, self, FightSwitchPlaneView.AudioDelay)
end

function FightSwitchPlaneView:playAudio()
	AudioMgr.instance:trigger(AudioEnum.TowerCompose.play_ui_fight_talent_light)
end

function FightSwitchPlaneView:onDestroyView()
	TaskDispatcher.cancelTask(self.playAudio, self)
end

return FightSwitchPlaneView
