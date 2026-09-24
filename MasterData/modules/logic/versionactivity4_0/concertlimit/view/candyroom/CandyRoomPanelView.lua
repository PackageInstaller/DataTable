-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomPanelView.lua

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomPanelView", package.seeall)

local CandyRoomPanelView = class("CandyRoomPanelView", BaseView)

function CandyRoomPanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_close")
	self._btncloseicon = gohelper.findChildButtonWithAudio(self.viewGO, "Root/simage_Bg/#btn_closeicon")
	self._goreward1 = gohelper.findChild(self.viewGO, "Root/Reward/#go_reward_1")
	self._btnclick1 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Reward/#go_reward_1/#btn_click1")
	self._goreward3 = gohelper.findChild(self.viewGO, "Root/Reward/#go_reward_3")
	self._btnclick3 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Reward/#go_reward_3/#btn_click3")
	self._goreward2 = gohelper.findChild(self.viewGO, "Root/Reward/#go_reward_2")
	self._btnclick2 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Reward/#go_reward_2/#btn_click2")
	self._goreward4 = gohelper.findChild(self.viewGO, "Root/Reward/#go_reward_4")
	self._btnclick4 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Reward/#go_reward_4/#btn_click4")
	self._goreward5 = gohelper.findChild(self.viewGO, "Root/Reward/#go_reward_5")
	self._btnclick5 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Reward/#go_reward_5/#btn_click5")
	self._goreward6 = gohelper.findChild(self.viewGO, "Root/Reward/#go_reward_6")
	self._btnclick6 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Reward/#go_reward_6/#btn_click6")
	self._goreward7 = gohelper.findChild(self.viewGO, "Root/Reward/#go_reward_7")
	self._btnclick7 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Reward/#go_reward_7/#btn_click7")
	self._goreward8 = gohelper.findChild(self.viewGO, "Root/Reward/#go_reward_8")
	self._btnclick8 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Reward/#go_reward_8/#btn_click8")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/Title/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CandyRoomPanelView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btncloseicon:AddClickListener(self._btncloseiconOnClick, self)
	self._btnclick1:AddClickListener(self._btnclick1OnClick, self)
	self._btnclick3:AddClickListener(self._btnclick3OnClick, self)
	self._btnclick2:AddClickListener(self._btnclick2OnClick, self)
	self._btnclick4:AddClickListener(self._btnclick4OnClick, self)
	self._btnclick5:AddClickListener(self._btnclick5OnClick, self)
	self._btnclick6:AddClickListener(self._btnclick6OnClick, self)
	self._btnclick7:AddClickListener(self._btnclick7OnClick, self)
	self._btnclick8:AddClickListener(self._btnclick8OnClick, self)
end

function CandyRoomPanelView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btncloseicon:RemoveClickListener()
	self._btnclick1:RemoveClickListener()
	self._btnclick3:RemoveClickListener()
	self._btnclick2:RemoveClickListener()
	self._btnclick4:RemoveClickListener()
	self._btnclick5:RemoveClickListener()
	self._btnclick6:RemoveClickListener()
	self._btnclick7:RemoveClickListener()
	self._btnclick8:RemoveClickListener()
end

function CandyRoomPanelView:_btncloseOnClick()
	self:closeThis()
end

function CandyRoomPanelView:_btncloseiconOnClick()
	self:closeThis()
end

function CandyRoomPanelView:_btnclick1OnClick()
	return
end

function CandyRoomPanelView:_btnclick2OnClick()
	return
end

function CandyRoomPanelView:_btnclick3OnClick()
	return
end

function CandyRoomPanelView:_btnclick4OnClick()
	return
end

function CandyRoomPanelView:_btnclick5OnClick()
	return
end

function CandyRoomPanelView:_btnclick6OnClick()
	return
end

function CandyRoomPanelView:_btnclick7OnClick()
	return
end

function CandyRoomPanelView:_btnclick8OnClick()
	return
end

function CandyRoomPanelView:_editableInitView()
	self._actId = VersionActivity4_0Enum.ActivityId.ConcertCandyRoom

	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, 1)
end

function CandyRoomPanelView:_refreshTime()
	self._txtLimitTime.text = ActivityModel.getRemainTimeStr(self._actId)
end

function CandyRoomPanelView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_0.CandyRoom.play_ui_langchao_role_open)
end

function CandyRoomPanelView:onClose()
	return
end

function CandyRoomPanelView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTime, self)
end

return CandyRoomPanelView
